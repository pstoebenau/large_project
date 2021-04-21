// /api/user/getuser

// input
// {
//   "token": string;
// }

// output
// {
//   "user": {
    //   "_id": string,
    //   "profileImage": string,
    //   "firstName": string,
    //   "lastName": string,
    //   "email": string,
    //   "username": string,
    //   "password": string,
    //   "about": string,
    //   "active": boolean,
    //   "createdAt": "2021-04-20T18:43:39.732Z",
    //   "updatedAt": "2021-04-20T18:43:52.378Z",
    //   "__v": 0
// },
// "message": "success"
// }
import express, { NextFunction, Request, Response } from 'express';
import User from '@/schemas/user';
import mongoose from 'mongoose';
import jwt from "jsonwebtoken";
import { OutputFileType } from 'typescript';

const router = express.Router();

router.post('/create', async (req: Request, res: Response, next: NextFunction) => {
  if (!req.body) {
    return res.status(500).json({
      message: "Invalid input"
    });
  }
  
  let { firstName, lastName, email, username, password } = req.body;

  const user = new User({
    firstName,
    lastName,
    email,
    username,
    password
  });

  try {
    let result = await user.save()
    
    return res.status(201).json({
      user: result,
      message: "success"
    });
  } catch (error) {
    return res.status(500).json({
      message: error.message,
      error
    });
  }
});

router.get('/getAll', async (req: Request, res: Response, next: NextFunction) => {
  try {
    let results = await User.find().exec();

    return res.status(200).json({
      users: results,
      count: results.length,
      message: "success"
    });
  } catch (error) {
    return res.status(500).json({
      message: error.message
    });
  }
});

router.post("/getuser", async function (req, res) {
  let { token } = req.body;
  let data = jwt.decode(token) as any;
  let userId = data.userId;

  try {
    let user = await User.findOne({ _id: userId });

    return res
      .status(200)
      .json({
        user,
        message: "success",
      });
  } catch (error) {
    return res.status(500).json({
      message: error.message,
    });
  }
});

export default router;