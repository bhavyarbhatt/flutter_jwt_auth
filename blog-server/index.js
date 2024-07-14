const express = require('express');
const mongoose = require('mongoose');

mongoose.connect('mongodb://127.0.0.1:27017/myapp');

const connection = mongoose.connection;
connection.once("open", () => {
  console.log("Mongodb Connected");
});


const app = express();

const Port = process.env.port || 5000;

app.route("/").get((req,res)=>res.json("Your First rest api "));

app.listen(Port, ()=>console.log(`Your Server is running on ${Port}`));