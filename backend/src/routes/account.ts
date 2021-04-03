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

router.get("/send", async (req: Request, res: Response, next: NextFunction) => {
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

  let token = jwt.sign({userId: "ashodfahjkdfhaskjdfh"}, config.server.secret);
  console.log(token);

  let data = jwt.decode(token) as string;
  console.log(data);  
  console.log(JSON.parse(data));

  try {
    let send = await transporter.sendMail({
      from: '"Chill Midnight 👻" <mmidnight.magic@gmail.com>', // sender address
      to: "jajptadlkajwxnraia@upived.online", // list of receivers
      subject: "Hello ✔", // Subject line
      text: "Hello world?", // plain text body
      html: "<b>Hello world?</b>", // html body
    });

    console.log("Message sent: %s", send.messageId);
    console.log("Preview URL: %s", nodemailer.getTestMessageUrl(send));

    return res.status(200).json();
  } catch (error) {
    return res.status(500).json({
      message: error.message,
      error,
    });
  }
});


/*router.get("/send", function (req, res) {
  let account = nodemailer.createTestAccount();

  let transporter = nodemailer.createTransport({
    host: "smtp.ethereal.email",
    port: 587,
    secure: false,
    auth: {
      user: account.user,
      pass: account.pass,
    },
  });

  let rand = Math.floor(Math.random() * 100 + 54);
  let link = `http://${config.server.hostname}/verify?id=${rand}`;
  let mailOptions = {
    to: "ywvrlrqqmipjsshkze@miucce.com",
    subject: "Please confirm your Email account",
    html:
      "Hello,<br> Please Click on the link to verify your email.<br><a href=" +
      link +
      ">Click here to verify</a>",
  };
  console.log(mailOptions);
  transporter.sendMail(mailOptions, function (error, response) {
    if (error) {
      console.log(error);
      res.end("error");
    } else {
      console.log("Message sent: " + response.message);
      res.end("sent");
    }
  });
});*/

/*router.get("/verify", function (req, res) {
  console.log(req.protocol + ":/" + req.get("host"));
  if (req.protocol + "://" + req.get("host") == "http://" + host) {
    console.log("Domain is matched. Information is from Authentic email");
    if (req.query.id == rand) {
      console.log("email is verified");
      res.end("<h1>Email " + mailOptions.to + " is been Successfully verified");
    } else {
      console.log("email is not verified");
      res.end("<h1>Bad Request</h1>");
    }
  } else {
    res.end("<h1>Request is from unknown source");
  }
});*/

export default router;
