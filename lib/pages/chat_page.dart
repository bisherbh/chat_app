import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../provider/chatProvider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool foucus = false;
  final _controller = ScrollController();
  String? Textmessage;
  TextEditingController textcontroller = TextEditingController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection('message');
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  final user = FirebaseAuth.instance.currentUser;

  CollectionReference collection =
      FirebaseFirestore.instance.collection('users');
  //  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xff05113b), //or set color with: Color(0xFF0000FF)
    ));

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        print("this email from top" +
            Provider.of<Chatprovider>(context, listen: false).getemail);
        foucus = false;
      },
      child: Scaffold(
        backgroundColor: Color(0xff05113b),
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back)),
          ),
          titleSpacing: 0,
          title: StreamBuilder(
              stream: collection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List? ff;
                  for (var snapshot in snapshot.data!.docs) {
                    print(
                        "this email from outside stream " + snapshot['email']);
                    if (snapshot['email'] ==
                        Provider.of<Chatprovider>(context, listen: false)
                            .getemail) {
                      print("email found " + snapshot['email']);
                      return Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/images/s.jpg'),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${Provider.of<Chatprovider>(context, listen: true).getname}",
                                style: TextStyle(fontSize: 25),
                              ),
                              snapshot['online'] ? Online() : Text("offline"),
                            ],
                          )
                        ],
                      );
                    }
                  }
                }
                return Container(
                  child: Text("data"),
                );
              }
              // return Center(
              //   child: LinearProgressIndicator(),
              // );

              ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.more_horiz),
            )
          ],
          backgroundColor: Color(0xff05113b),
          elevation: 0,
        ),
        body: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: messages.orderBy('creatAt', descending: true).snapshots(),
              builder: (context, snapshot) {
                print(
                    Provider.of<Chatprovider>(context, listen: true).getemail);
                return snapshot.hasData
                    ? Expanded(
                        child: ListView.builder(
                          reverse: true,
                          controller: _controller,
                          physics:
                              ScrollPhysics(parent: BouncingScrollPhysics()),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            if (snapshot.data!.docs[index]['from'] ==
                                    user!.email.toString() &&
                                snapshot.data!.docs[index]['to'] ==
                                    Provider.of<Chatprovider>(context,
                                            listen: true)
                                        .getemail) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        padding: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Color(0xff4acfee)),
                                        child: Text(
                                          "${snapshot.data!.docs[index]['message']}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              );
                            } else if (snapshot.data!.docs[index]['from'] ==
                                    Provider.of<Chatprovider>(context,
                                            listen: true)
                                        .getemail &&
                                snapshot.data!.docs[index]['to'] ==
                                    user!.email) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        padding: EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Color(0xff13254d)),
                                        child: Text(
                                          "${snapshot.data!.docs[index]['message']}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      )
                    : Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextFormField(
                controller: textcontroller,
                onChanged: (data) {
                  Textmessage = data;
                },
                cursorColor: Colors.white,
                cursorWidth: 1,
                style: TextStyle(color: Colors.white),
                onTap: () {
                  print("tap tap");
                  foucus = true;

                  setState(() {});
                },
                onFieldSubmitted: (data) {},
                decoration: InputDecoration(
                  hintText: "write your message",
                  hintStyle: TextStyle(
                      color: Color.fromARGB(250, 74, 87, 133), fontSize: 14),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide:
                        BorderSide(color: Color.fromARGB(173, 236, 237, 239)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide:
                        BorderSide(color: Color.fromARGB(174, 135, 143, 159)),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      backgroundColor: Color(0xff4acfee),
                      child: IconButton(
                          onPressed: () {
                            messages.add({
                              'message': Textmessage,
                              'from': user!.email,
                              'to': Provider.of<Chatprovider>(context,
                                      listen: false)
                                  .getemail,
                              'creatAt': DateTime.now(),
                            });
                            textcontroller.clear();
                            _controller.animateTo(0,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          icon: Icon(Icons.send, color: Colors.white)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget Online() => Row(
      children: [
        CircleAvatar(
          radius: 4,
          backgroundColor: Colors.green,
        ),
        SizedBox(
          width: 3,
        ),
        Text(
          "online",
          style: TextStyle(fontSize: 10),
        ),
      ],
    );
