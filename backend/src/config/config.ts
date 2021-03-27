import dotenv from 'dotenv';

dotenv.config();

const MONGO_OPTIONS = {
  useUnifiedTopology: true,
  useNewUrlParser: true,
  socketTimeoutMS: 30000,
  keepAlive: true,
  poolSize: 50,
  retryWrites: false
};

const MONGO_HOST = process.env.MONGO_HOST || 'mongo';
const MONGO_USERNAME = process.env.MONGO_USERNAME || '';
const MONGO_PASSWORD = process.env.MONGO_PASSWORD || '';
const MONGO_DATABASE = process.env.MONGO_DATABASE || 'hot_or_not';

let mongoUrl = `mongodb://${MONGO_USERNAME}:${MONGO_PASSWORD}@${MONGO_HOST}/${MONGO_DATABASE}`;
if (MONGO_USERNAME === "" || MONGO_PASSWORD === "")
  mongoUrl = `mongodb://${MONGO_HOST}/${MONGO_DATABASE}`;

const MONGO = {
  host: MONGO_HOST,
  username: MONGO_USERNAME,
  password: MONGO_PASSWORD,
  options: MONGO_OPTIONS,
  url: mongoUrl
}

const SERVER_HOSTNAME = process.env.SERVER_HOSTNAME || 'localhost';
const SERVER_PORT = process.env.PORT || 8080;

const SERVER = {
  hostname: SERVER_HOSTNAME,
  port: SERVER_PORT
}

const config = {
  mongo: MONGO,
  server: SERVER
}

export default config;