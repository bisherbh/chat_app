import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _MyappState();
}

class _MyappState extends State<RegisterPage> {
  bool foucas = false;
  bool foucas1 = false;
  bool foucas2 = false;
  String? email;
  String? f_name;
  String? l_name;
  String? Mobile_num;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  GlobalKey<FormState> formkey = GlobalKey();
  String? password;
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xff05113b), //or set color with: Color(0xFF0000FF)
    ));

    return Scaffold(
      backgroundColor: Color(0xff05113b),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          print("dwd");
          foucas = false;
          foucas1 = false;
          foucas2 = false;
          setState(() {});
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
              child: ListView(
            physics: ScrollPhysics(parent: BouncingScrollPhysics()),
            children: [
              SizedBox(
                height: 100,
              ),
              Column(
                children: [
                  Image.asset(
                    'assets/images/Messaging-pana (1).png',
                    fit: BoxFit.fill,
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "BTA",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'DancingScript-Medium',
                        fontSize: 45),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Text(
                              "Register",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter email";
                            } else if (!value.contains("@")) {
                              return "Please enter valid email";
                            }
                          },
                          onChanged: (data) {
                            email = data;
                          },
                          onTap: () {
                            print("tap tap");
                            foucas = true;
                            foucas1 = false;
                            foucas2 = false;
                            setState(() {});
                          },
                          onFieldSubmitted: (data) {},
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(250, 74, 87, 133),
                                fontSize: 14),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(173, 236, 237, 239)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(174, 135, 143, 159)),
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.email_outlined,
                                color: foucas
                                    ? Colors.white
                                    : Color.fromARGB(174, 135, 143, 159),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter name";
                                  }
                                },
                                onChanged: (data) {
                                  f_name = data;
                                },
                                onTap: () {
                                  print("tap tap");
                                  foucas = false;
                                  foucas1 = false;
                                  foucas2 = false;
                                  setState(() {});
                                },
                                onFieldSubmitted: (data) {},
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "first name",
                                  hintStyle: TextStyle(
                                      color: Color.fromARGB(250, 74, 87, 133),
                                      fontSize: 14),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(173, 236, 237, 239)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(174, 135, 143, 159)),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter Last name";
                                  }
                                },
                                onChanged: (data) {
                                  l_name = data;
                                },
                                onTap: () {
                                  print("tap tap");
                                  foucas = false;
                                  foucas1 = false;
                                  foucas2 = false;
                                  setState(() {});
                                },
                                onFieldSubmitted: (data) {},
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "last name",
                                  hintStyle: TextStyle(
                                      color: Color.fromARGB(250, 74, 87, 133),
                                      fontSize: 14),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(173, 236, 237, 239)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(174, 135, 143, 159)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter phone number";
                            }
                          },
                          onChanged: (data) {
                            Mobile_num = data;
                          },
                          onTap: () {
                            print("tap tap");
                            foucas = false;
                            foucas1 = false;
                            foucas2 = false;
                            setState(() {});
                          },
                          onFieldSubmitted: (data) {},
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "phone number",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(250, 74, 87, 133),
                                fontSize: 14),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(173, 236, 237, 239)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(174, 135, 143, 159)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter password";
                            }
                          },
                          onChanged: (data) {
                            password = data;
                          },
                          onTap: () {
                            print("tap tap");
                            foucas = false;
                            foucas1 = true;
                            foucas2 = false;
                            setState(() {});
                          },
                          onFieldSubmitted: (data) {},
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(250, 74, 87, 133),
                                fontSize: 14),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(173, 236, 237, 239)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(174, 135, 143, 159)),
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.lock_open_rounded,
                                color: foucas1
                                    ? Colors.white
                                    : Color.fromARGB(174, 135, 143, 159),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value != password) {
                              return "Password not match";
                            }

                            if (value!.isEmpty) {
                              return "Please enter email";
                            }
                          },
                          onTap: () {
                            print("tap tap");
                            foucas1 = false;
                            foucas = false;
                            foucas2 = true;
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            hintText: "confirm Password",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(250, 74, 87, 133),
                                fontSize: 14),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(173, 236, 237, 239)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(174, 135, 143, 159)),
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.lock_open_rounded,
                                color: foucas2
                                    ? Colors.white
                                    : Color.fromARGB(174, 135, 143, 159),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 40,
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(),
                              onPressed: () async {
                                if (formkey.currentState!.validate()) {
                                  try {
                                    final credential = await FirebaseAuth
                                        .instance
                                        .createUserWithEmailAndPassword(
                                      email: email!,
                                      password: password!,
                                    );
                                    users
                                        .add({
                                          'first_name': f_name,
                                          'last_name': l_name,
                                          'phone_num': Mobile_num,
                                          'email': email,
                                          'password':
                                              password ,
                                              'online':false
                                              // Stokes and Sons
                                        });
                                        // .then((value) => print("User Added"))
                                        // .catchError((error) => print(
                                        //     "Failed to add user: $error"));
                                    Navigator.pushReplacementNamed(
                                        context, 'menuchat_page');
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'weak-password') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "The password provided is too weak.")));
                                      print(
                                          'The password provided is too weak.');
                                    } else if (e.code ==
                                        'email-already-in-use') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "The account already exists for that email.")));

                                      print(
                                          'The account already exists for that email.');
                                    }
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("$e")));

                                    print(e);
                                  }
                                }
                              },
                              child: Text("Register")),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("You Have account ?",
                                style: TextStyle(color: Colors.white)),
                            TextButton(
                                clipBehavior: Clip.antiAlias,
                                style: const ButtonStyle(
                                    overlayColor: MaterialStatePropertyAll(
                                        Color.fromARGB(0, 244, 67, 54)),
                                    padding: MaterialStatePropertyAll(
                                        EdgeInsets.symmetric(horizontal: 5))),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Login"))
                          ],
                        )
                      ],
                    )),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
