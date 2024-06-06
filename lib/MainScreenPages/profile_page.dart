import 'package:amulx/AuthenticationPages/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final _userId = FirebaseAuth.instance.currentUser!.email;

  void signOut() async {
    final _authService = AuthService();
    await _authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff89CFF0),
        title: Text('Profile',style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: Colors.white,
        ),),
      ),
        backgroundColor: Color(0xffE7F1F9),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').where('Email', isEqualTo: _userId).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          print(_userId);
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
              itemBuilder:(context, index) {
                return Column(
                  children: [
                    SizedBox(height: 30,),
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Image.asset('assets/images/profilepic.png',width: 150),
                        CircleAvatar(
                          child: IconButton(
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xff191970)),
                            iconSize: MaterialStateProperty.all(20)),
                            onPressed: (){},
                            icon: Icon(Icons.add,color: Colors.white,),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text('Username',style: TextStyle(fontSize: 15),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 20),
                            child: Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(style: BorderStyle.solid,color: Color(0xff191970),width: 2),
                              ),
                              child: Center(child: Text('${snapshot.data!.docs[index]['Name']}',style: TextStyle(fontSize: 22,fontStyle: FontStyle.italic),)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text('Student ID',style: TextStyle(fontSize: 15),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 20),
                            child: Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(style: BorderStyle.solid,color: Color(0xff191970),width: 2),
                              ),
                              child: Center(child: Text('${snapshot.data!.docs[index]['ID']}',style: TextStyle(fontSize: 22),)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text('Email',style: TextStyle(fontSize: 15),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 20),
                            child: Container(
                              height: 60,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(style: BorderStyle.solid,color: Color(0xff191970),width: 2),
                              ),
                              child: Center(child: Text('${snapshot.data!.docs[index]['Email']}',style: TextStyle(fontSize: 20),)),
                            ),
                          ),
                          SizedBox(height: 30,),
                          Center(
                            child: ElevatedButton(onPressed: (){
                              signOut();
                            },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(170, 55),
                                  backgroundColor: Color(0xff191970)
                                ),
                                child: Row(children: [
                              Text('Log Out',style: TextStyle(fontSize: 20,color: Colors.white),),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Icon(Icons.logout,color: Colors.white
                                  ,),
                              ),
                            ],)),
                          )
                        ],
                      ),
                    )
                  ],
                );
              },);
        },
      ),
    );
  }
}
