// /api/account/signup
// input
// {
//   "firstName": string,
//   "lastName": string,
//   "email": string,
//   "username": string,
//   "password": string
// }

// output
// {
//   "message": string
// }




// /api/account/login
// input
// {
//   "username": string,
//   "password": string
// }

// output
// {
//   token: string
// }




// /api/account/account-edit
// input: Will assume fields are instantiated and not empty. newPassword is excluded. If it is empty or just white space
// it will not update.

// input
// {
//   "token": string,
//   "profileImage": string,
//   "firstName": string,
//   "lastName": string,
//   "email" : string,
//   "about" : string,
//   "newUserName": string
//   "newPassword" : string
// }

// output
// {
//   message : string
// }



// /api/account/forgotpassword
// input
// {
//   "email": string
// }

// output
// {
//   "message": string
// }




// /api/account/changepassword
// input
// {
//   "password": string,
//   "token": string
// }

// output
// {
//   "message": string
// }
import express, { NextFunction, Request, Response } from "express";
import nodemailer, { createTestAccount } from "nodemailer";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import User from "@/schemas/user";
import mongoose from "mongoose";
import config from "@/config/config";
import UserFunctions from "../functions/user";
import path from "path";
import Token from "@/models/token";

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
      profileImage:
        "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png",
      firstName,
      lastName,
      email,
      username,
      password: hash,
      about: "",
      active: false,
    });

    try {
      let result = await user.save();

      var smtpConfig = {
        host: "smtp.gmail.com",
        port: 465,
        secure: true, // use SSL
        auth: {
          user: "mmidnight.magic@gmail.com",
          pass: "magic!password",
        },
      };

      var transporter = nodemailer.createTransport(smtpConfig);

      let token = jwt.sign({ userId: result.id }, config.server.secret);

      let verifyLink = `${config.server.url}/api/account/verify/${token}`;
      let send = await transporter.sendMail({
        from: '"Chill Chili 👻" <mmidnight.magic@gmail.com>', // sender address
        to: email, // list of receivers
        subject: "Verify Email ✔", // Subject line
        text: "Verify Email Link", // plain text body
        html: `Hello,<br> Please Click on the link to verify your email.<br><a href=${verifyLink}>Click here to verify</a>`, // html body
      });

      console.log("Message sent: %s", send.messageId);
      console.log("Preview URL: %s", nodemailer.getTestMessageUrl(send));

      return res.status(201).json({
        message: "success",
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
    user?.updateOne({ active: true }, null, (err, res) => {});
    console.log(user);

    return res.sendFile(path.resolve("src/public/success.html"));
  } catch (error) {
    return res.status(500).json({
      message: error.message,
    });
  }
});

router.post("/login", async function (req, res) {
  let { username, password } = req.body;
  let token;

  try {
    let user = await User.findOne({ username });
    console.log(user);
    if (user == null || !user.password) {
      return res.status(200).json({
        message: "invalid password/username",
      });
    }

    if (bcrypt.compareSync(password, user.password)) {
      if (user?.active) {
        token = jwt.sign(
          {
            userId: user.id,
            firstName: user.firstName,
            username: user.username,
          },
          config.server.secret
        );
        return res.status(200).json({ token, message: "success" });
      } else {
        return res.status(200).json({
          message: "verify email",
        });
      }
    }

    return res.status(200).json({
      message: "invalid password",
    });
  } catch (error) {
    return res.status(500).json({
      message: error.message,
    });
  }
});

router.post(
  "/forgotpassword",
  async (req: Request, res: Response, next: NextFunction) => {
    let { email } = req.body;

    try {
      var smtpConfig = {
        host: "smtp.gmail.com",
        port: 465,
        secure: true, // use SSL
        auth: {
          user: "mmidnight.magic@gmail.com",
          pass: "magic!password",
        },
      };
      
      let user = await User.findOne({ email });

      if (user === null)
      {
        return res.status(500).json({
          message: "not a valid email",
        });
      }

      var transporter = nodemailer.createTransport(smtpConfig);

      let token = jwt.sign({ email }, config.server.secret);

      let verifyLink = `${config.server.url}/api/account/changepassword/${token}`;
      let send = await transporter.sendMail({
        from: '"Chill Chili 👻" <mmidnight.magic@gmail.com>', // sender address
        to: email, // list of receivers
        subject: "Change Password ✔", // Subject line
        text: "Change Password Link", // plain text body
        html: `Hello,<br> Please Click on the link to change your password.<br><a href=${verifyLink}>Click here to change password</a>`, // html body
      });

      console.log("Message sent: %s", send.messageId);
      console.log("Preview URL: %s", nodemailer.getTestMessageUrl(send));

      return res.status(201).json({
        message: "success",
      });
    } catch (error) {

      res.status(500).json({
        message: error.message,
      });
      
    }
  }
);

router.get("/changepassword/:token", (req, res) => {
  return res.sendFile(path.resolve("src/public/changepassword.html"));
});

router.post("/changepassword", async function (req, res) {
  let { password, token } = req.body;
  try {
    const hash = await bcrypt.hash(password, 10);
    let data = jwt.decode(token) as any;
    let email = data.email;

    let user = await User.findOne({ email });
    user?.updateOne({ password: hash }, null, (err, res) => {});

    return res.status(200).json({ user, message: "success" });
  } catch (error) {
    return res.status(500).json({
      message: error.message,
    });
  }
});

// Assumes that all fields are instantiated
router.post("/account-edit", async function (req, res) {
  let {
    token,
    firstName,
    lastName,
    email,
    about,
    newUserName,
    newPassword,
  } = req.body;
  const hash = await bcrypt.hash(newPassword.trim(), 10);
  let data = jwt.verify(token, config.server.secret) as Token;

  let id = data.userId;

  try {
    let user = await User.findOne({ _id: id });
    user?.updateOne(
      {
        username: newUserName,
        firstName: firstName,
        lastName: lastName,
        email: email,
        about: about,
      },
      null,
      (err, res) => {}
    );
    if (newPassword.length > 0 && newPassword.trim().length > 0) {
      user?.updateOne({ password: hash }, null, (err, res) => {});

      return res.status(200).json({ message: "success with password change" });

    }
    return res.status(200).json({ message: "success" });
  } catch (error) {
    return res.status(500).json({
      message: error.message,
    });
  }
});
export default router;
