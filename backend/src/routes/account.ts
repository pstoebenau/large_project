import express, { NextFunction, Request, Response } from "express";
import nodemailer, { createTestAccount } from "nodemailer";
import bcrypt from "bcrypt";
import jwt from 'jsonwebtoken';
import User from "@schemas/user";
import mongoose from "mongoose";
import config from "@config/config";
import UserFunctions from "../functions/users";

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


    const hash = await bcrypt.hash(password, 10);

    const user = new User({
      firstName,
      lastName,
      email,
      username,
      password: hash,
      active: false,
    });

    try {
      let result = await user.save();

      var smtpConfig = {
        host: 'smtp.gmail.com',
        port: 465,
        secure: true, // use SSL
        auth: {
            user: 'mmidnight.magic@gmail.com',
            pass: 'magic!password'
        }
      };
    
      var transporter = nodemailer.createTransport(smtpConfig);
    
      let token = jwt.sign({userId: result.id}, config.server.secret);
    
      let verifyLink = `http://${config.server.hostname}:${config.server.port}/api/account/verify/${token}`;
      let send = await transporter.sendMail({
        from: '"Chill Midnight 👻" <mmidnight.magic@gmail.com>', // sender address
        to: email, // list of receivers
        subject: "Hello ✔", // Subject line
        text: "Hello world?", // plain text body
        html: `Hello,<br> Please Click on the link to verify your email.<br><a href=${verifyLink}>Click here to verify</a>`, // html body
      });
      
      console.log("Message sent: %s", send.messageId);
      console.log("Preview URL: %s", nodemailer.getTestMessageUrl(send));

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

router.get("/verify/:token", async function (req, res) {
  let token = req.params.token;

  try {
    let data = jwt.decode(token) as any;
    let userId = data.userId;
  
    let user = await User.findById(userId).exec();
    user?.updateOne({active: true}, null, (err, res) => {

    });
    console.log(user);

    res.status(200).json({user});
  } catch (error) {
    res.status(500).json({
      message: error.message
    });
  }
});

router.post('/login', async function(req,res) {
  let { username, password} = req.body;
  const hash = bcrypt.hash(password, 10);
  
  try {
    let user = await User.findOne({ username });
    console.log(user);

    res.status(200).json();
  } catch (error) {
    res.status(500).json({
      message: error.message
    });
  }
});

export default router;
