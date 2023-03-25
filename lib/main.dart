import 'package:chat_app/pages/MenuChat_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/registertion_page.dart';
import 'package:chat_app/provider/chatProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  ff();
  runApp(ChangeNotifierProvider(
    create: (context) {
      return Chatprovider();
    },
    builder: (context, child) {
      return MaterialApp(
        home: Myapp(),
        routes: {
          'login': (_) => LoginPage(),
          'register': (_) => RegisterPage(),
          'menuchat_page': (_) => MenuPage(),
        },
        initialRoute: 'login',
      );
    },
  ));
}

class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}

 ff() {
  CollectionReference messages =
      FirebaseFirestore.instance.collection('message');

  return StreamBuilder<QuerySnapshot>(
    stream: messages.orderBy('creatAt', descending: true).snapshots(),
    builder: (context, snapshot) {
      print(Provider.of<Chatprovider>(context, listen: true).getemail);
     return Expanded(
        child: ListView.builder(
          reverse: true,
          physics: ScrollPhysics(parent: BouncingScrollPhysics()),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            if(index== snapshot.data!.docs.length-1)
            {

            Provider.of<Chatprovider>(context, listen: true).setmessage =
                snapshot.data!.docs[index]['message'];

            }
            return Container();

          },
        ),
      );
    },
  );
}
