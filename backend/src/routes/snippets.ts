import express, { NextFunction, Request, Response } from "express";
import Token from "@/models/token";
import Snippet from "@/schemas/snippets";
import mongoose from "mongoose";
import config from "@/config/config";
import jwt from "jsonwebtoken";

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

const router = express.Router();

router.post(
  "/create",
  async (req: Request, res: Response, next: NextFunction) => {
    let { token, imageURL } = req.body;

    const data = jwt.verify(token, config.server.secret) as Token;

    const snippet = new Snippet({
      userId: data.userId,
      imageURL,
      score: 0,
    });

    try {
      let results = await snippet.save();

      return res.status(200).json({
        message: "success"
        //snippet: results
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

    return res.status(200).json(snippet);
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
    });
  } catch (error) {
    return res.status(500).json({
      message: error.message,
    });
  }
});

router.post('/updateScore', async (req: Request, res: Response, next: NextFunction) => {
  let { imageURL } = req.body;

  try {
    let results = await Snippet.findOneAndUpdate({imageURL: req.body.imageURL}, {$inc : {score : 1}});

    return res.status(200).json({
      message: "success"
    });
  } catch (error) {
    return res.status(500).json({
      message: error.message
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
        message: "success"
        //snippet: results,
      });
    } catch (error) {
      return res.status(500).json({
        message: error.message,
      });
    }
  }
);

export default router;
