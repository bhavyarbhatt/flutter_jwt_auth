const express = require('express');
const User = require("../models/user_models"); // Assuming user_models.js defines the User model

const router = express.Router();

router.route("/:username").get( async (req,res)=> {
    try{
      const user =await  User.findOne({username: req.params.username});

      console.log(`result is  ${user}`);

  
      res.status(200).json({ username: req.params.username }); 
    
    if(!user) {
        return res.status(404).json({
            message: "User not found"
        })
    }
    }   catch(err) {
      console.log(`Error in User ${err}`);
    } 
});

router.route("/login").post(async (req, res) => {
    try {
      // Find the user by username
      const user = await User.findOne({ username: req.body.username });
  
      // Check if user exists
      if (!user) {
        return res.status(401).json({ message: "Invalid username or password" });
      }
  
      // Login successful (replace with appropriate authentication logic)
      res.status(200).json({ message: "Login successful" }); // Consider using JWT for authentication
  
    } catch (err) {
      console.error(err); // Log the error for debugging
      return res.status(500).json({ message: "Internal server error" });
    }
  });
  

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

router.route("/update/:username").patch(async (req,res) => {
    try{
    
   const updatedUser = await User.findOneAndUpdate(
        { username: req.params.username },
        { $set: { password: req.body.password } },
        { new: true } // Optionally, return the updated user document
    );

    if(!updatedUser) {
        return res.status(404).json({
            message: "User not found"
        })
    }

    res.status(200).json({ message: "Password successfully updated" }); // Send a success response


  }  catch (err) {
    console.error(err); // Log the error for debugging
    return res.status(500).json({ message: "Error updating password" });

  }
} )

router.route("/delete/:username").delete(async (req,res) => {
     try{
        const userDelete = await User.deleteOne(
            {"username": req.params.username}
        );

        if(!userDelete) {
            return res.status(404).json({
                message: "User not found"
            })
        }

        res.status(200).json({message: "User deleted" });

     } catch(e) {
        console.log(`Error deleting password ${e}`);
     }
});



  module.exports = router;