import 'package:amulx/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var email = FirebaseAuth.instance.currentUser?.email;

  TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE7F1F9),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 20,),
            Image.asset('assets/images/Amul.png',height: 70,width: 140,color: Color(0xff191970),),
            Image.asset('assets/images/X.png',color: Color(0xff191970),height: 50,),
          ],
        ),
        centerTitle: true,
        backgroundColor: Color(0xff89CFF0),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 170,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white38,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xff191970),width: 2),
                    gradient: LinearGradient(colors: [
                      Color(0xffA7C7E7),
                      Colors.white,
                      Color(0xffA7C7E7)
                    ])
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(13),

                        child: Container(
                          height: 100,
                          width: 80,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: NetworkImage('${snapshot.data!.docs[index]['Image']}'),)
                          ),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15,top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(snapshot.data!.docs[index]['Name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                          Text('₹${snapshot.data!.docs[index]['Price']}',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 15),),
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: ElevatedButton(onPressed: (){
                              Cart(Name: snapshot.data!.docs[index]['Name'],
                                  imageUrl: snapshot.data!.docs[index]['Image'],
                                  Price: snapshot.data!.docs[index]['Price'],
                                  Email: email).addToCart(snapshot.data!.docs[index]['Name'], snapshot.data!.docs[index]['Price'], snapshot.data!.docs[index]['Image'], email);
                            },
                                style: ElevatedButton.styleFrom(
                                    shadowColor: Color(0xff191970),
                                    elevation: 8,
                                    fixedSize: Size(160, 45),
                                    backgroundColor: Color(0xff191970),
                                    side: BorderSide(color: Colors.black)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Add to Cart',style: TextStyle(color: Colors.white,fontSize: 15),),
                                    Icon(Icons.shopping_cart,color: Colors.white,)
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
            itemCount: snapshot.data!.docs.length,);
        },
      ),
    );
  }
}
