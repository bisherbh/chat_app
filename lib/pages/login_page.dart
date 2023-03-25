import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _MyappState();
}

class _MyappState extends State<LoginPage> {
  bool foucas = false;
  GlobalKey<FormState> formkey = GlobalKey();
  bool foucas1 = false;
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
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
                height: 70,
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
                              "LOGIN",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          onChanged: (data) {
                            email = data;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter email";
                            } else if (!value.contains("@")) {
                              return "Please enter valid email";
                            }
                          },
                          onTap: () {
                            print("tap tap");
                            foucas = true;
                            foucas1 = false;
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
                        TextFormField(
                          onChanged: (data) {
                            password = data;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter password";
                            }
                          },
                          onTap: () {
                            print("tap tap");
                            foucas1 = true;
                            foucas = false;
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
                                        .signInWithEmailAndPassword(
                                            email: email!, password: password!);
                                    // .then((value) => print("User Added"))
                                    // .catchError((error) => print(
                                    //     "Failed to add user: $error"));
                                    Navigator.pushReplacementNamed(
                                        context, 'menuchat_page');
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'user-not-found') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "No user found for that email.")));
                                      print(
                                          'No user found for that email.');
                                    } else if (e.code ==
                                       'wrong-password') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Wrong password provided for that user.")));

                                      print(
                                          'Wrong password provided for that user.');
                                    }
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text("$e")));

                                    print(e);
                                  }
                                }
                              },
                              child: Text("Login")),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't Have account ?",
                                style: TextStyle(color: Colors.white)),
                            TextButton(
                                clipBehavior: Clip.antiAlias,
                                style: const ButtonStyle(
                                    overlayColor: MaterialStatePropertyAll(
                                        Color.fromARGB(0, 244, 67, 54)),
                                    padding: MaterialStatePropertyAll(
                                        EdgeInsets.symmetric(horizontal: 5))),
                                onPressed: () {
                                  Navigator.pushNamed(context, 'register',arguments: email);
                                },
                                child: const Text("register"))
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
