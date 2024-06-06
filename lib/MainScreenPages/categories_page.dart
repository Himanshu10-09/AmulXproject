import 'package:amulx/category_nav.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {

  var type1 = 'food';
  var type2 = 'drinks';
  var type3 = 'snacks';
  var type4 = 'dairy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffE7F1F9),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 10,),
                    Image.asset('assets/images/Amul.png',height: 70,width: 140,color: Color(0xff191970),),
                    Image.asset('assets/images/X.png',color: Color(0xff191970),height: 50,),
                  ],
                ),
                SizedBox(height: 30,),
                Text('Answer Your Apetite!',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,letterSpacing: 3,
                        fontStyle: FontStyle.italic)),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: FloatingActionButton(
                              heroTag: 'food',
                              onPressed: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CategoryNavPage(type: type1,)));
                            },
                              child:CircleAvatar(
                                foregroundImage: AssetImage('assets/images/Food.png'),
                                backgroundColor: Colors.white,
                                radius: 70,),
                              backgroundColor: Colors.white,
                              splashColor: Color(0xffE7F1F9),
                              shape: CircleBorder(side: BorderSide(style: BorderStyle.solid,color: Color(0xffE7F1F9),)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('Food',style: TextStyle(fontSize: 20),),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: FloatingActionButton(
                              heroTag: 'drinks',
                              onPressed: (){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CategoryNavPage(type: type2,)));
                            },
                              child:CircleAvatar(
                                foregroundImage: AssetImage('assets/images/Drinks.jpg'),
                                backgroundColor: Colors.white,
                                radius: 70,),
                              backgroundColor: Colors.white,
                              splashColor: Color(0xffE7F1F9),
                              shape: CircleBorder(side: BorderSide(style: BorderStyle.solid,color: Color(0xffE7F1F9),)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('Drinks',style: TextStyle(fontSize: 20),),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: FloatingActionButton(
                              heroTag: 'snacks',
                              onPressed: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CategoryNavPage(type: type3,)));
                            },
                              child:CircleAvatar(
                                foregroundImage: AssetImage('assets/images/Snacks.png'),
                                backgroundColor: Colors.white,
                                radius: 70,),
                              backgroundColor: Colors.white,
                              splashColor: Color(0xffE7F1F9),
                              shape: CircleBorder(side: BorderSide(style: BorderStyle.solid,color: Color(0xffE7F1F9),)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('Snacks',style: TextStyle(fontSize: 20),),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: FloatingActionButton(
                              heroTag: 'dairy',
                              onPressed: (){

                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CategoryNavPage(type: type4,)));
                            },
                              child:CircleAvatar(
                                foregroundImage: AssetImage('assets/images/Dairy.png'),
                                backgroundColor: Colors.white,
                                radius: 70,),
                              backgroundColor: Colors.white,
                              splashColor: Color(0xffE7F1F9),
                              shape: CircleBorder(side: BorderSide(style: BorderStyle.solid,color: Color(0xffE7F1F9),)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('Dairy',style: TextStyle(fontSize: 20),),
                          )
                        ],
                      ),
                    ],
                  ),
                ),//Button
              ],
            ),
          ),
        ),
      ),
    );
  }
}
