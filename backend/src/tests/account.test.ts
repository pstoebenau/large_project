import axios from 'axios';
import config from '../config/config';

const url = config.server.hostname+":"+config.server.port;

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
