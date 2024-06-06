import 'package:amulx/navBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryNavPage extends StatefulWidget {
  final type;
  const CategoryNavPage({required this.type});

  @override
  State<CategoryNavPage> createState() => _CategoryNavPageState();
}

class _CategoryNavPageState extends State<CategoryNavPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff89CFF0),
        leading: GestureDetector(
          onTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NavBarPage()));
          },
          child: Icon(Icons.arrow_back,color: Colors.white,)),
        title: Text('${widget.type.toString().toUpperCase()}',style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: Colors.white,
        ),),
      ),
      backgroundColor: Color(0xffE7F1F9),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').where('type', isEqualTo: "${widget.type}").snapshots(),
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
                height: 150,
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
                            padding: const EdgeInsets.only(top: 30),
                            child: ElevatedButton(onPressed: (){},
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
                          )
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
