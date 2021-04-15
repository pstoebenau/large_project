import express, { NextFunction, Request, Response } from 'express';
import User from '@/models/user';
import Snippet from '@/schemas/snippets';
import mongoose from 'mongoose';
import config from "@/config/config";
import jwt from 'jsonwebtoken';

const router = express.Router();

router.post('/add', async (req: Request, res: Response, next: NextFunction) => {
  let { token, imageURL } = req.body;

  const user = jwt.verify(token, config.server.secret) as User;
  console.log(user.userId);

  const snippet = new Snippet({
    userId: user.userId,
    imageURL,
    score: 0,
  });

  try {
    let results = await snippet.save()
    
    return res.status(200).json({
      snippet: results
    });
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
      count: results.length
    });
  } catch (error) {
    return res.status(500).json({
      message: error.message
    });
  }
});

export default router;