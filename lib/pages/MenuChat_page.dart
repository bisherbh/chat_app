import 'package:chat_app/pages/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../provider/chatProvider.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> with WidgetsBindingObserver {
  bool focus = false;
  final user = FirebaseAuth.instance.currentUser;

  final userst = FirebaseFirestore.instance.collection('users');
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    //ff();
    WidgetsBinding.instance.addObserver(this);
    setStatus(true);
  }

  void setStatus(bool status) async {
    print("status:  : :" + status.toString());
    var documentID;
    var collection = FirebaseFirestore.instance.collection('users');
    var querySnapshots = await collection.get();
    for (var snapshot in querySnapshots.docs) {
      if (snapshot['email'] == user!.email) {
        documentID = snapshot.id;
        print("User ID : " + snapshot.id);
        print("that is active account");
      }
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(documentID)
        .update({'online': status});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      print("efefefkerwjfjerwnjiogfnmeorngfoinjmeroig");
      setStatus(true);
    } else {
      setStatus(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xff05113b), //or set color with: Color(0xFF0000FF)
    ));

    return GestureDetector(
      onTap: () async {
        FocusScope.of(context).unfocus();

        // <-- Document ID

        focus = false;
      },
      child: Scaffold(
        backgroundColor: Color(0xff05113b),
        body: SafeArea(
            child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "BTA CHAT",
                    style: TextStyle(color: Color(0xffc3c2d0), fontSize: 20),
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.settings,
                      color: Colors.white,
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextFormField(
                cursorColor: Colors.white,
                cursorWidth: 1,
                style: TextStyle(color: Colors.white),
                onTap: () {
                  print("tap tap");
                  focus = true;

                  setState(() {});
                },
                onFieldSubmitted: (data) {},
                decoration: InputDecoration(
                  hintText: "Search",
                  hintStyle: TextStyle(
                      color: Color.fromARGB(250, 74, 87, 133), fontSize: 14),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(color: Color.fromARGB(173, 236, 237, 239)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(color: Color.fromARGB(174, 135, 143, 159)),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(right: 0.0),
                    child: Icon(
                      Icons.search,
                      color: focus
                          ? Colors.white
                          : Color.fromARGB(174, 135, 143, 159),
                    ),
                  ),
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                //  if(snapshot.data!.docs[0]['first_name'])
                if (snapshot!.hasData) {
                  print("length " + snapshot.data!.docs.length.toString());
                }
                // if (snapshot.hasError) {
                //   return Text('Something went wrong');
                // }
                // print(user!.email);

                // if (snapshot.connectionState == ConnectionState.waiting) {
                //   return Text("Loading");
                // }

                return snapshot!.hasData == true
                    ? Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 10,
                            );
                          },
                          physics:
                              ScrollPhysics(parent: BouncingScrollPhysics()),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            print("loob");
                            if (snapshot.data!.docs[index]['email']
                                    .toString() ==
                                user!.email.toString()) {
                              print("GGGGGrwgwrg");
                              return Container();
                            } else {
                              return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      foregroundColor: Color(0xff13254d),
                                      backgroundColor: Color(0xff05113b)),
                                  onPressed: () {
                                    Provider.of<Chatprovider>(context,
                                                listen: false)
                                            .setonline =
                                        snapshot.data!.docs[index]['online'];

                                    Provider.of<Chatprovider>(context,
                                                listen: false)
                                            .setname =
                                        '${snapshot.data!.docs[index]['first_name']}' +
                                            ' ' +
                                            '${snapshot.data!.docs[index]['last_name']}';

                                    Provider.of<Chatprovider>(context,
                                                listen: false)
                                            .setemail =
                                        snapshot.data!.docs[index]['email'];
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) {
                                          return ChatPage();
                                        },
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Spacer(
                                              flex: 1,
                                            ),
                                            CircleAvatar(
                                              radius: 25,
                                              child: Text(
                                                  "${snapshot.data!.docs[index]['first_name'].substring(0, 1)}"),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${snapshot.data!.docs[index]['first_name']}",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  width: 150,
                                                  child: Text(
                                                   Provider.of<Chatprovider>(context, listen: true).getmessage,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff646984),
                                                        fontSize: 10,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Spacer(
                                              flex: 12,
                                            ),
                                            Text(
                                              "11:00 Am",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            counter(),
                                            Spacer(
                                              flex: 2,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ));
                            }
                          },
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
          ],
        )),
      ),
    );
  }
}

Widget counter() {
  return Row(
    children: [
      SizedBox(
        width: 8,
      ),
      CircleAvatar(
        radius: 9,
        backgroundColor: Color(0xfff13c3b),
        child: Text(
          "3",
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
      ),
    ],
  );
}

// void ff() {
//   CollectionReference messages =
//       FirebaseFirestore.instance.collection('message');

//   StreamBuilder<QuerySnapshot>(
//     stream: messages.orderBy('creatAt', descending: true).snapshots(),
//     builder: (context, snapshot) {
//       print(Provider.of<Chatprovider>(context, listen: true).getemail);
//      return Expanded(
//         child: ListView.builder(
//           reverse: true,
//           physics: ScrollPhysics(parent: BouncingScrollPhysics()),
//           itemCount: snapshot.data!.docs.length,
//           itemBuilder: (context, index) {
//             if(index== snapshot.data!.docs.length-1)
//             {
// print("kenfkjnewfkjwerf");
//             Provider.of<Chatprovider>(context, listen: true).setmessage =
//                 snapshot.data!.docs[index]['message'];

//             }
//             return Container();

//           },
//         ),
//       );
//     },
//   );
// }
