import 'package:flutter/material.dart';
import 'package:jwt/netwoekHandle.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

bool vis = true;
final _globalkey = GlobalKey<FormState>();
NetworkHandle networkHandle = NetworkHandle();
TextEditingController _usernameController = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
late String errorText;
bool validate = false;
bool circular = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            // height: MediaQuery.of(context).size.height,  
            // width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white, Colors.green,
                ],
                begin: FractionalOffset(0.0,0.1),
                end: FractionalOffset(0.0,1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.repeated,
              )
            ),
            child: Form(
              key: _globalkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sign up with email",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2
                    ),
                    ),
                        
                    SizedBox(
                      height: 20,
                    ),
                        
                    usernameTextFeild(),
                    emailTextFeild(),
                    passwordTextFeild(),
                    SizedBox(
                       height: 20,
                    ),
                    InkWell(
                      onTap: () async{
                        setState(() {
                          circular= true;
                        });
                        await checkUser();
                        if(_globalkey.currentState!.validate() && validate ){
                            Map<String,String>data={
                              "Username": _usernameController.text,
                              "email": _emailController.text,
                              "password": _passwordController.text
                            };
                            print(data);
                          await  networkHandle.post("/user/register", data);
                          setState(() {
                            circular = false;
                          });
                        }
                        else {
                          setState(() {
                            circular = false;
                          });
                        }
                      },
                      child: circular ? CircularProgressIndicator() : Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff00A86B)
                        ),
                        child: Center(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                            ),),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        )
    );
  }

checkUser()  async {
  if(_usernameController.text.length == 0 ) {
    setState(() {
      circular = false;
      validate = false;
      errorText = "Username Can't be empty";
    });
  } else {
    var response = await networkHandle
    .get("/user/checkUsername/${_usernameController.text}/");
    if(response['Status'])
    {
      setState(() {
      circular = false;
      validate = false;
      errorText = "Username already taken";
    });
    }
    else {
      setState(() {
      validate = false;
      
    });
    }
  }
}

  Widget usernameTextFeild() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: Column(
        children: [
          Text("Username"),
          TextFormField(
            controller: _usernameController,
            
            decoration: InputDecoration(
              errorText: validate?null:errorText,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2,
                )
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget emailTextFeild() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: [
          Text("Email"),
          TextFormField(
            controller: _passwordController,
            validator: (value){
                if(value!.isEmpty)
                  return "Email can't be empty";
                  if(!value.contains("@"))
                  return null;
                  return null;
            },
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: Colors.black,
                )
              ),
            ),
          )
        ],
      ),
    );
  }

Widget passwordTextFeild() {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: [
          Text("Password"),
          TextFormField(
            controller: _passwordController,
            validator: (value){
                if(value!.isEmpty)
                  return "Password can't be empty";
                  if(value.length<=8)
                  return "Password length must have >=";
                  return null;
            },
            obscureText: vis,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: (){
                  setState(() {
                    vis = !vis;
                  });
                },
                icon: Icon(vis ?   Icons.visibility_off : Icons.visibility),
                ),
              helperText: "Password length should have >=8",
              helperStyle: TextStyle(
                fontSize:  16
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 2,
                )
              ),
            ),
          )
        ],
      ),
    );
  }

}