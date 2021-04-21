import axios from 'axios';
import config from '../config/config';

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

  let res = await axios.post(`${url}/api/account/login`, {
    "username": "verifiedUsername",
    "password": "verifiedPassword"
  });

  let token = res.data.token;

  expect(res.data.message).toBe("success");

  res = await axios.post(`${url}/api/account/changepassword`, {
    password: "newpassword",
    token: token
  });

  expect(res.data.message).toBe("success");
});

test('Create snippet', async () => {

  let res = await axios.post(`${url}/api/account/login`, {
    "username": "verifiedUsername",
    "password": "verifiedPassword"
  });

  let token = res.data.token;

  expect(res.data.message).toBe("success");

  res = await axios.post(`${url}/api/snippet/create`, {
    token: token,
    imageURL: "image"
  });

  expect(res.data.message).toBe("success");
});

test('Delete snippet', async () => {

  let res = await axios.post(`${url}/api/account/login`, {
    "username": "verifiedUsername",
    "password": "verifiedPassword"
  });

  let token = res.data.token;

  expect(res.data.message).toBe("success");

  res = await axios.post(`${url}/api/snippet/create`, {
    token: token,
    imageURL: "snippet"
  });

  let id = res.data.snippet;

  expect(res.data.message).toBe("success");

  res = await axios.post(`${url}/api/snippet/deleteSnippet`, {
    _id: id
  });

  expect(res.data.message).toBe("success");
});

test('Update score', async () => {

  let res = await axios.post(`${url}/api/account/login`, {
    "username": "verifiedUsername",
    "password": "verifiedPassword"
  });

  let token = res.data.token;

  expect(res.data.message).toBe("success");

  res = await axios.post(`${url}/api/snippet/create`, {
    token: token,
    imageURL: "snippet"
  });

  let id = res.data.snippet;
  console.log(id);
  expect(res.data.message).toBe("success");
  res = await axios.post(`${url}/api/snippet/updateScore`, {
    _id: id
  });

  expect(res.data.message).toBe("success");
});