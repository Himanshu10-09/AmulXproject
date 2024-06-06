import 'package:amulx/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  var docId;

  void getDocID(var path){
     docId = path;
  }
  final _userId = FirebaseAuth.instance.currentUser!.email;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff89CFF0),
        title: Text('Cart',style: TextStyle(
            color: Colors.white,
            letterSpacing: 3,
            fontSize: 30,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
        backgroundColor: Color(0xffE7F1F9),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('cart').where('Email', isEqualTo: _userId).snapshots(),
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
                height: 180,
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
                              image: DecorationImage(image: NetworkImage('${snapshot.data!.docs[index]['cart'][0]['imageUrl']}'),)
                          ),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15,top: 10),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snapshot.data!.docs[index]['cart'][0]['Name'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                              Text('₹${snapshot.data!.docs[index]['cart'][0]['Price']}',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 15),),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 40,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: Color(0xff191970),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(onPressed: (){
                                        if (snapshot.data!.docs[index]['Quantity'] > 1){
                                          getDocID(snapshot.data!.docs[index].id);
                                          Cart(Name: snapshot.data!.docs[index]['cart'][0]['Name'],
                                              imageUrl: snapshot.data!.docs[index]['cart'][0]['imageUrl'],
                                              Price: snapshot.data!.docs[index]['cart'][0]['Price'],
                                              Email: snapshot.data!.docs[index]['Email']).updateCart(docId, snapshot.data!.docs[index]['Quantity'] - 1);
                                          setState(() {

                                          });
                                        }

                                      }, icon: Icon(CupertinoIcons.minus,color: Colors.white,)),
                                      Text('${snapshot.data!.docs[index]['Quantity']}',style: TextStyle(color: Colors.white,fontSize: 18),),
                                      IconButton(onPressed: (){
                                        getDocID(snapshot.data!.docs[index].id);
                                        Cart(Name: snapshot.data!.docs[index]['cart'][0]['Name'],
                                            imageUrl: snapshot.data!.docs[index]['cart'][0]['imageUrl'],
                                            Price: snapshot.data!.docs[index]['cart'][0]['Price'],
                                            Email: snapshot.data!.docs[index]['Email']).updateCart(docId, snapshot.data!.docs[index]['Quantity'] + 1);
                                        setState(() {

                                        });

                                      }, icon: Icon(CupertinoIcons.add,color: Colors.white,)),
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(190, 40),
                                      backgroundColor: Color(0xff191970)
                                    ),
                                    onPressed: (){
                                      getDocID(snapshot.data!.docs[index].id);
                                      Cart(Name: snapshot.data!.docs[index]['cart'][0]['Name'],
                                          imageUrl: snapshot.data!.docs[index]['cart'][0]['imageUrl'],
                                          Price: snapshot.data!.docs[index]['cart'][0]['Price'],
                                          Email: snapshot.data!.docs[index]['Email']).removeFromCart(docId);
                                      setState(() {
                                      });
                                    }
                                  ,child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Remove from Cart',style: TextStyle(color: Colors.white,fontSize: 14),),
                                      Icon(Icons.delete,color: Colors.white,size: 20,)
                                    ],
                                  ),),
                                ],
                              ),
                            ],
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
      floatingActionButton: ElevatedButton(onPressed: (){
        showModalBottomSheet(context: context, builder: (BuildContext context) {
          return Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('cart').where('Email', isEqualTo: _userId).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  children: [
                    Text('Confirm Your Order',style: TextStyle(color: Color(0xff191970),fontSize: 30,fontStyle: FontStyle.italic),),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20,top: 10),
                        child: ListView.builder(itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${snapshot.data!.docs[index]['cart'][0]['Name']} x ${snapshot.data!.docs[index]['Quantity']}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                Text('₹${int.parse(snapshot.data!.docs[index]['cart'][0]['Price'])*snapshot.data!.docs[index]['Quantity']}',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 15),),
                              ],
                            ),
                          );
                        },
                          itemCount: snapshot.data!.docs.length,),
                      ),
                    ),
                    Row(
                      children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10,left: 15),
                        child: ElevatedButton(onPressed: (){
                          Navigator.pop(context);
                        },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(MediaQuery.of(context).size.width/2-20,50),
                              backgroundColor: Color(0xff191970),
                              side: BorderSide(style: BorderStyle.solid,),
                            ),
                            child: Text('Close',style: TextStyle(
                            fontSize: 20,
                            color: Colors.white),)),
                      ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10,left: 10),
                          child: ElevatedButton(onPressed: (){
                            Navigator.pop(context);
                          },
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(MediaQuery.of(context).size.width/2-20,50),
                                backgroundColor: Color(0xff191970),
                                side: BorderSide(style: BorderStyle.solid,),
                              ),
                              child: Text('Order',style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white),)),
                        ),
                    ],)
                  ],
                );
              },
            ),
          );
        },);
      },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff191970),
            side: BorderSide(style: BorderStyle.solid,color: Colors.lightBlueAccent,width: 2),
            fixedSize: Size(60, 60)

          ),
          child: Icon(CupertinoIcons.chevron_right_2,size: 20,color: Colors.white,)),
      extendBody: true,
    );
  }
}
