import express from 'express'

const PORT = process.env.PORT || 5000;
const app = express();

app.get('/', (req, res) => {
  res.send('<h1>NOT AN APP!<br>THIS IS A REST API!</h1>');
});

app.post('/api/wow', (req, res) => {
  res.json({
    name: "wow",
    password: "wot"
  })
});

app.listen(PORT, () => {
  console.log(`Server started on port ${PORT}`);
});