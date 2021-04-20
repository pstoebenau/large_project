import axios from 'axios';
import config from '../config/config';
import jwt from "jsonwebtoken";

const url = config.server.hostname + ":" + config.server.port;

test('Create account', async () => {
  let randNum = Math.ceil(Math.random() * 99999);

  let res = await axios.post(`${url}/api/account/signup`, {
    firstName: "name",
    lastName: "jeff",
    email: `namejeff${randNum}@mailinator.com`,
    username: `namejeff${randNum}`,
    password: "password"
  });

  expect(res.data.message).toBe("success");
});

test('Login to account', async () => {
  let randNum = Math.ceil(Math.random() * 99999);

  let res = await axios.post(`${url}/api/account/signup`, {
    firstName: "name",
    lastName: "jeff",
    email: `namejeff${randNum}@mailinator.com`,
    username: `namejeff${randNum}`,
    password: "password"
  });

  expect(res.data.message).toBe("success");

  res = await axios.post(`${url}/api/account/login`, {
    "username": `namejeff${randNum}`,
    "password": "password"
  });

  expect(res.data.message).toBe("verify email");
});

test('Forgot password', async () => {
  let randNum = Math.ceil(Math.random() * 99999);

  let res = await axios.post(`${url}/api/account/signup`, {
    firstName: "name",
    lastName: "jeff",
    email: `namejeff${randNum}@mailinator.com`,
    username: `namejeff${randNum}`,
    password: "password"
  });

  expect(res.data.message).toBe("success");

  res = await axios.post(`${url}/api/account/login`, {
    "username": `namejeff${randNum}`,
    "password": "password"
  });

  expect(res.data.message).toBe("verify email");

  res = await axios.post(`${url}/api/account/forgotpassword`, {
    email: `namejeff${randNum}@mailinator.com`
  });

  expect(res.data.message).toBe("success");
});

test('Change password', async () => {
  let randNum = Math.ceil(Math.random() * 99999);

  let res = await axios.post(`${url}/api/account/signup`, {
    firstName: "name",
    lastName: "jeff",
    email: `namejeff${randNum}@mailinator.com`,
    username: `namejeff${randNum}`,
    password: "password"
  });

  expect(res.data.message).toBe("success");

  res = await axios.post(`${url}/api/account/login`, {
    "username": `namejeff${randNum}`,
    "password": "password"
  });

  expect(res.data.message).toBe("verify email");

  let token = jwt.sign({ userId: `namejeff${randNum}` }, config.server.secret);

  res = await axios.post(`${url}/api/account/changepassword`, {
    password: "newpassword",
    token: token
  });

  expect(res.data.message).toBe("success");
});

test('Create snippet', async () => {
  let randNum = Math.ceil(Math.random() * 99999);

  let res = await axios.post(`${url}/api/account/signup`, {
    firstName: "name",
    lastName: "jeff",
    email: `namejeff${randNum}@mailinator.com`,
    username: `namejeff${randNum}`,
    password: "password"
  });

  expect(res.data.message).toBe("success");

  res = await axios.post(`${url}/api/account/login`, {
    "username": `namejeff${randNum}`,
    "password": "password"
  });

  expect(res.data.message).toBe("verify email");

  let token = jwt.sign({ userId: `namejeff${randNum}` }, config.server.secret);

  res = await axios.post(`${url}/api/snippet/create`, {
    token: token,
    imageURL: "image"
  });

  expect(res.data.message).toBe("success");
});

test('Delete snippet', async () => {
  let randNum = Math.ceil(Math.random() * 99999);

  let res = await axios.post(`${url}/api/account/signup`, {
    firstName: "name",
    lastName: "jeff",
    email: `namejeff${randNum}@mailinator.com`,
    username: `namejeff${randNum}`,
    password: "password"
  });

  expect(res.data.message).toBe("success");

  res = await axios.post(`${url}/api/account/login`, {
    "username": `namejeff${randNum}`,
    "password": "password"
  });

  expect(res.data.message).toBe("verify email");

  let token = jwt.sign({ userId: `namejeff${randNum}` }, config.server.secret);

  res = await axios.post(`${url}/api/snippet/create`, {
    token: token,
    imageURL: "image"
  });

  expect(res.data.message).toBe("success");

  res = await axios.post(`${url}/api/snippet/deleteSnippet`, {
    _id: "607c94b717e587002cabadfd" 
  });

  expect(res.data.message).toBe("success");
});

test('Update score', async () => {
  let randNum = Math.ceil(Math.random() * 99999);

  let res = await axios.post(`${url}/api/account/signup`, {
    firstName: "name",
    lastName: "jeff",
    email: `namejeff${randNum}@mailinator.com`,
    username: `namejeff${randNum}`,
    password: "password"
  });

  expect(res.data.message).toBe("success");

  res = await axios.post(`${url}/api/account/login`, {
    "username": `namejeff${randNum}`,
    "password": "password"
  });

  expect(res.data.message).toBe("verify email");

  let token = jwt.sign({ userId: `namejeff${randNum}` }, config.server.secret);

  res = await axios.post(`${url}/api/snippet/create`, {
    token: token,
    imageURL: "image"
  });

  expect(res.data.message).toBe("success");

  res = await axios.post(`${url}/api/snippet/updateScore`, {
    imageURL: "image"
  });

  expect(res.data.message).toBe("success");
});