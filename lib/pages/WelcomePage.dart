import 'package:flutter/material.dart';
import 'package:jwt/pages/signUpPage.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>  with SingleTickerProviderStateMixin {

  late AnimationController _controller1;
  late Animation<Offset> animation1;

  late AnimationController _controller2;
  late Animation<Offset> animation2;

  @override
  void initState() {
    super.initState();
// animation
    _controller1 = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this
      );
      animation1 = Tween<Offset>(
        begin: Offset(0.0, 8.0),
        end: Offset(0.0, 0.0)
      ).animate(CurvedAnimation(
        parent: _controller1, 
        curve: Curves.easeIn
        )
        );
        _controller1.forward();


    _controller2 = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this
      );

      animation2 = Tween<Offset>(
        begin: Offset(0.0, 8.0),
        end: Offset(0.0, 0.0)
      ).animate(CurvedAnimation(
        parent: _controller1, 
        curve: Curves.bounceOut
        )
        );
        _controller1.forward();


  }

  @override
  void dispose() {
    super.dispose();
    _controller1.dispose();

    _controller2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
                Colors.white,
                Colors.green
            ],
            begin: FractionalOffset(0.0,1.0),
            end: FractionalOffset(0.0,1.0),
            stops: [0.0,1.0],
            tileMode: TileMode.repeated,
          ),
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 40
             ),
          child: Column(
            children: [
              SlideTransition(
                position: animation1,
                child: Text(
                  "DevStack",
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 2
                  ),
                  ),
              ),

                SizedBox(
                    height: MediaQuery.of(context).size.height,
                ),

                SlideTransition(
                  position: animation1,
                  child: Text(
                    "Great stories for graet people",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 38,
                      letterSpacing: 2
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                boxContainer("Sign Up with Google", null),
                SizedBox(
                  height: 20,
                ),
                boxContainer("Sign Up with Facebook", null),
                SizedBox(
                  height: 20,
                ),
                boxContainer("Sign Up with Email", onEmailClick()),
                SlideTransition(
                  position: animation2,
                  child: Row(
                    children: [
                  
                        Text(
                          "Already have an account",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17
                          ),
                          ),
                  
                          Text(
                          "Sign In",
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold
                          ),
                          ),
                    ],
                  ),
                ),
                
            ],
          ),
        ),
      ),
    );
  }

onEmailClick(){
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => SignUpPage() )
  );
}


Widget boxContainer(String text, onClick) {
  return SlideTransition(
    position: animation2,
    child: InkWell(
      onTap: onClick,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width-140,
        child: Card(
          child: Row(
            children: [
              Text(
                 text,
                 style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87
                 ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

}