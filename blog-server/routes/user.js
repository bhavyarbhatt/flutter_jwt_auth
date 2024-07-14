const express = require('express');
const User = require("../models/user_models"); // Assuming user_models.js defines the User model

const router = express.Router();

router.route("/register").post(async (req, res) => {
    console.log("Inside the register");

    try {
        const user = new User({
            username: req.body.username,
            password: req.body.password,
            email: req.body.email
        });

        const savedUser = await user.save(); // Use await to wait for the save operation

        console.log("user registered");
        res.status(201).json({ message: "User registered successfully", data: savedUser }); // Send created user data
    } catch (err) {
        console.error(err); // Log the error for debugging
        res.status(400).json({ message: "Registration failed", error: err.message }); // Send a more specific error message
    }
});

router.route("/update/:username").patch((req,res) => {
    User.findOneAndUpdate(
        { username: req.params.username },
        { $set: { password: req.body.password } },
        (err, result) => {
            if(err) return res.status(500).json({});
            const msg = {
                msg: "Password successfully updated",
                username: req.params.username,
            };
            return res.json(msg);
        }
    );
} )

router.route("/delete/:username").delete((req,res) => {

});

module.exports = router;
