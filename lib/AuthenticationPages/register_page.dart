import 'package:amulx/AuthenticationPages/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key,required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  var _nameController = TextEditingController();
  var _idController = TextEditingController();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _confirmpasswordController = TextEditingController();

  bool hidden = true;

  void register() async {

    final _authService = AuthService();

    if(_passwordController.text.toString() == _confirmpasswordController.text.toString()){
      try{
        await _authService.signUpwithEmailPassword(_emailController.text, _passwordController.text,);

        // Adding data to the collection
        addUserDetails(_nameController.text, _idController.text, _emailController.text, _passwordController.text);
      }
      catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text(e.toString()),),);
      }
    }
    else{
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(title: Text('Passwords don\'t match!'),),
      );
    }
  }

  Future addUserDetails (String Name, String ID, String Email, String Password,) async {
    await FirebaseFirestore.instance.collection('users').add({
      'Name': Name,
      'ID': ID,
      'Email': Email,
      'Password': Password,
    });
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
                Text('Before Ordering, please register your account',style: TextStyle(fontSize: 12),),
                SizedBox(height: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 28,bottom: 3),
                      child: Text('Name',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: 'Username',
                            hintStyle: TextStyle(),
                            prefixIcon: Icon(Icons.perm_identity,color: Color(0xff191970),),
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
                      padding: const EdgeInsets.only(left: 28,bottom: 3),
                      child: Text('Student ID',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        controller: _idController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.credit_card_rounded,color: Color(0xff191970),),
                            hintText: 'eg. 2023UIT2023',
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
                      padding: const EdgeInsets.only(left: 28,bottom: 3),
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
                      padding: const EdgeInsets.only(left: 28,bottom: 3),
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
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.only(left: 28,bottom: 3),
                      child: Text('Confirm Password',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        controller: _confirmpasswordController,
                        obscureText: hidden,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.key,color: Color(0xff191970),),
                            hintText: 'Confirm Password',
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
                    SizedBox(height: 15,),
                  ],
                ),
                Center(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                      onPressed: (){
                        register();
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 55),
                        backgroundColor: Color(0xff191970),
                      ),
                      child: Text('Sign Up',style: TextStyle(color: Colors.white,fontSize: 20),)),
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?'),
                      SizedBox(width: 5,),
                      GestureDetector(
                        onTap: widget.showLoginPage,
                          child: Text('Sign In',style: TextStyle(color: Color(0xff191970)),)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
