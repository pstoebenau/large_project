import express, { NextFunction, Request, Response } from "express";
import nodemailer from "nodemailer";
import bcrypt from "bcrypt";
import User from "@models/user";
import mongoose from "mongoose";

const router = express.Router();

router.post(
  "/signup",
  async (req: Request, res: Response, next: NextFunction) => {
    if (!req.body) {
      return res.status(500).json({
        message: "Invalid input",
      });
    }

    let { firstName, lastName, email, username, password } = req.body;

    //bcrypt.hash(password, 10, (err, hash) => {
    //  if (err) {
    //    return res.status(500).json({
    //      error: err,
    //   });
    //  } else {
    //    const user = new User({
    //      firstName,
    //      lastName,
    //      email,
    //      username,
    //      hash,
    //    });
    //  }
    //});

    const hash = bcrypt.hashSync(password, 10);

    const user = new User({
      firstName,
      lastName,
      email,
      username,
      hash,
    });

    try {
      let result = await user.save();

      return res.status(201).json({
        user: result,
      });
    } catch (error) {
      return res.status(500).json({
        message: error.message,
        error,
      });
    }
  }
);

export default router;
