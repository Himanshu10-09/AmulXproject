import 'package:amulx/AuthenticationPages/auth_service.dart';
import 'package:amulx/AuthenticationPages/forgot_password.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var _emailController = TextEditingController();
  var  _passwordController = TextEditingController();
  bool hidden = true;

  void login() async {
    final _authService = AuthService();

    try{
      await _authService.signInwithEmailPassword(
          _emailController.text.toString(),
          _passwordController.text.toString()
      );
    }
    catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text(e.toString()),),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE7F1F9),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome To',style: TextStyle(fontSize: 15,color: Colors.black),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 10,),
                    Image.asset('assets/images/Amul.png',height: 70,width: 140,color: Color(0xff191970),),
                    Image.asset('assets/images/X.png',color: Color(0xff191970),height: 50,),
                  ],
                ),
                Text('Before Ordering, please login with your account',style: TextStyle(fontSize: 12),),
                SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.only(left: 28,bottom: 8),
                      child: Text('NSUT E-mail',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mail_outline_rounded,color: Color(0xff191970)),
                            hintText: 'eg. student@nsut.ac.in',
                            hintStyle: TextStyle(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(style: BorderStyle.solid),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(style: BorderStyle.solid,width: 2)
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.only(left: 28,bottom: 8),
                      child: Text('Password',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: hidden,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.key,color: Color(0xff191970),),
                            hintText: 'Password',
                            hintStyle: TextStyle(),
                            suffixIcon: GestureDetector(
                              onTap: (){
                                hidden = !hidden;
                                setState(() {

                                });
                              },
                                child: hidden
                                    ? Icon(Icons.visibility_off,color: Colors.grey,)
                                    : Icon(Icons.visibility,color: Color(0xff191970),),

                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(style: BorderStyle.solid),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(style: BorderStyle.solid,width: 2)
                            )
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 3,bottom: 12,right: 10),
                          child: TextButton(onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return ForgotPasswordPage();
                            }));
                          },
                              child: Text('Forgot Password?',style: TextStyle(color: Color(0xff191970)))
                          ),
                        ),
                      ],
                    ),
                    Center(child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: ElevatedButton(
                          onPressed: (){
                            login();

                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(MediaQuery.of(context).size.width, 55),
                            backgroundColor: Color(0xff191970),
                          ),
                          child: Text('Sign In',style: TextStyle(color: Colors.white,fontSize: 20),)),
                    )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Create a new account'),
                          SizedBox(width: 5,),
                          GestureDetector(
                            onTap: widget.showRegisterPage,
                              child: Text('Register Now',style: TextStyle(color: Color(0xff191970),fontWeight: FontWeight.bold),)),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
