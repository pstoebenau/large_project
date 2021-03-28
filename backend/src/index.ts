import http from 'http';
import express from 'express';
import bodyParser from 'body-parser';
import config from '@config/config';
import mongoose from 'mongoose';
import userRoutes from '@routes/user';
import accountRoutes from '@routes/account';
import router from '@routes/user';

const app = express();

// Connect to MongoDB database
mongoose.connect(config.mongo.url, config.mongo.options)
  .then((result) => {
    console.log("Connected to MongoDB!");
  }).catch((err) => {
    console.log("NOT CONNECTED");
  });

app.get('/', (req, res) => {
  res.send('<h1>NOT AN APP!<br>THIS IS A REST API!</h1>');
});

// Server headers

// Parse body of requests
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

// Routes
app.use('/api/user', userRoutes);
app.use('/api/account', accountRoutes);

// Error Handling
app.use((req, res, next) => {
  const error = new Error('not found');

  return res.status(404).json({
    message: error.message
  });
});

// Create the server
const httpServer = http.createServer(app);
httpServer.listen(config.server.port, () => {
  console.log(`Server is running on ${config.server.hostname}:${config.server.port}`);
});