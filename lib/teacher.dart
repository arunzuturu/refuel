import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class Teacher extends StatefulWidget {
  const Teacher({super.key});

  @override
  State<Teacher> createState() => _TeacherState();
}

class _TeacherState extends State<Teacher> {
  TextEditingController _price = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _location = TextEditingController();
  TextEditingController _type = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seller"),
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Sell Fuel", style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.fromLTRB(10,2,10,2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black)
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Enter Fuel Price",
                    ),
                    controller: _price,
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.fromLTRB(10,2,10,2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black)
                  ),
                  child: TextField(

                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Enter Petrol/Disel",
                    ),
                    controller: _type,
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.fromLTRB(10,2,10,2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black)
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Enter Brand/Service Name",
                    ),
                    controller: _name,
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  padding: EdgeInsets.fromLTRB(10,2,10,2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black)
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Enter location",
                    ),
                    controller: _location,
                  ),
                ),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: (){
                  createProduct();
                  print("Done");
                }, child: Text("Create Sale"))
              ],
            ),
          ),
        ),
      ),
    );
  }

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
  Future createProduct() async {
    User? user = FirebaseAuth.instance.currentUser;
    final docUser = FirebaseFirestore.instance.collection('products').doc(user!.uid.toString());
    final json = {
      "name" : _name.text.toString(),
      "price" : _price.text.toString(),
      "type" : _type.text.toString(),
      "loc": _location.text.toString(),
      "uid": user!.uid.toString(),
      "email": user!.email.toString()
    };
    await docUser.set(json);
  }
}
