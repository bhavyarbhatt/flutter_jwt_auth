const express = require('express');
const User = require("../models/user_models");

const router = express.Router();

router.route("/register").post((req,res) => {
    consolo.log("Inside the register");
    const user = new User({
        username: req.body.username,
        password: req.body.password,
        email: req.body.email
    });
    User
       .save()
       .then( () => {
        console.log("user registered");
        res.status(200).json("ok");
       })
       .catch((err) => {
        res.status(403).json({ msg: err });
       });
     res.json("registerd");   
});

module.exports = router;