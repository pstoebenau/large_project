import express, { NextFunction, Request, Response } from "express";
var nodemailer = require("nodemailer");
var bcrypt = require("bcrypt");
import User from "@models/user";
import mongoose from "mongoose";

const router = express.Router();

router.post("/signup", async (req: Request, res: Response, next: NextFunction) => {
    if (!req.body) {
      return res.status(500).json({
        message: "Invalid input",
      });
    }

    let { firstName, lastName, email, username, password} = req.body;

    const user = new User({
      firstName,
      lastName,
      email,
      username,
      bcrypt.hash(password),
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