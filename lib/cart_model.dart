import 'package:cloud_firestore/cloud_firestore.dart';

class Cart {
  final Name;
  final Price;
  final imageUrl;
  final Email;

  Cart(
      {required this.Name, required this.imageUrl, required this.Price, required this.Email,});

  Future addToCart(String Name, String Price, String imageUrl, var Email) async {
    List cartItems = [];
    cartItems.add({
      'Name': Name,
      'Price': Price,
      'imageUrl': imageUrl,
    });
    await FirebaseFirestore.instance.collection('cart').add({
      'cart': cartItems,
      'Quantity': 1,
      'Email': Email,
    });
  }
  Future removeFromCart(var docID) async {
    await FirebaseFirestore.instance.collection('cart').doc(docID).delete();
  }


  Future updateCart(var docID,var Quantity) async {
    await FirebaseFirestore.instance.collection('cart').doc(docID).update({
      'Quantity': Quantity,
    });

  }
}