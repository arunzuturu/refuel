import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:refuel/Models/product_model.dart';

import 'login.dart';

class Student extends StatefulWidget {
  const Student({super.key});

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Product>>(
        stream: readProducts(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return Text("Something went wrong");
          }
          else if(snapshot.hasData){
            final products = snapshot.data;
            return ListView(
              children: products!.map(buildCard).toList(),
            );
          }
          else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
      appBar: AppBar(
        title: Text("Buyer"),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: Icon(
              Icons.logout,
            ),
          )
        ],
      ),
    );
  }
  Widget buildCard(Product prod){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white38,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text("Name : ${prod.name}"),
              SizedBox(height: 5,),
              Text("Type : ${prod.type}"),
              SizedBox(height: 5,),
              Text("Price : ${prod.price}"),
              SizedBox(height: 5,),
              Text("Location : ${prod.loc}"),
            ],
          ),
        ),
      ),
    );
  }
  Stream<List<Product>> readProducts()=> FirebaseFirestore.instance.collection('products').snapshots().map((snapshot) => snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList());
  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
