import express, { NextFunction, Request, Response } from "express";
import Token from "@/models/token";
import Snippet from "@/schemas/snippets";
import mongoose from "mongoose";
import config from "@/config/config";
import jwt from "jsonwebtoken";
import fs from "fs";
import crypto from "crypto";
import { execSync } from "child_process";
import snippets from "@/schemas/snippets";
import { Storage } from '@google-cloud/storage';
import { createReadStream } from "node:fs";
import path from "path";

// /api/snippet/deleteSnippet

// input
// {
//   "_id": string,
//
// }

// output
// {
//   snippet: {
//   "_id": string,
//   "userId": string,
//   "score":int
// }
// }
// returns the snippet that was deleted.

// /api/snippet/create
// input
// {
//   "token": string,
//   "codeText": string
// }
// output
// {
//   "snippet": Snippet,
//   "message": string,
// }

const gc = new Storage({
  keyFilename: 'chillchili-a1903a0fdbb3.json',
  projectId: 'chillchili'
});
const uploadBucket = gc.bucket('chillchilli-uploads');

const router = express.Router();

router.post("/create", async (req: Request, res: Response, next: NextFunction) => {
    try {
      let { token, codeText } = req.body;

      const data = jwt.verify(token, config.server.secret) as Token;

      // Verify code length
      if (codeText.length >= 1000)
        return res.status(400).json({message: "Snippet too long"});

      // Use carbon-now-cli to convert text to image
      const dir = "";
      const uuid = crypto.randomBytes(16).toString("hex");
      fs.writeFileSync(dir + uuid, codeText);
      execSync(`npx carbon-now ${dir}${uuid} -t ${dir}${uuid} -h --config carbon-now.json`);
      
      // Upload to GCloud bucket
      const response = await uploadBucket.upload(`${dir}${uuid}.png`);
      const imageURL = response[0].metadata.mediaLink;
      
      fs.unlinkSync(dir + uuid);
      fs.unlinkSync(`${dir}${uuid}.png`);

      const snippet = new Snippet({
        userId: data.userId,
        imageURL,
        score: 0,
      });

      let results = await snippet.save();

      return res.status(200).json({
        snippet: results,
        message: "success"
      });
    } catch (error) {
      return res.status(500).json({
        message: error.message,
      });
    }
  }
);

router.get('/get-random', async (req, res, next) => {
  try {
    let count = await Snippet.count().exec();
    let randIndex = Math.floor(Math.random() * count);
    let snippet = await Snippet.findOne().skip(randIndex).exec();

    return res.status(200).json({snippet, message: "success"});
  } catch (error) {
    return res.status(500).json({
      message: error.message
    });
  }
});

router.get('/find', async (req: Request, res: Response, next: NextFunction) => {
  try {
    let results = await Snippet.find().exec();

    return res.status(200).json({
      snippet: results,
      count: results.length,
      message: "success"
    });
  } catch (error) {
    return res.status(500).json({
      message: error.message,
    });
  }
});

router.post(
  "/deleteSnippet",
  async (req: Request, res: Response, next: NextFunction) => {
    var test = req.body._id; // valid way to store this
    try {
      let results = await Snippet.findByIdAndRemove(test).exec();
      return res.status(200).json({
        snippet: results,
        message: "success"
      });
    } catch (error) {
      return res.status(500).json({
        message: error.message,
      });
    }
  }
);

router.post("/get-by-score", async (req, res, next) => {
  try {
    let { startIndex, numSnippets } = req.body;
    
    let results = await Snippet.find().sort({'score': 'desc'}).skip(startIndex).limit(numSnippets).exec();
    
    return res.status(200).json({
      snippets: results,
      message: "success"
    });
  } catch (error) {
    return res.status(500).json({
      message: error.message,
    });
  }
});

export default router;
