import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LeaderBoardPage extends StatefulWidget {
  const LeaderBoardPage({Key? key}) : super(key: key);

  @override
  State<LeaderBoardPage> createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State<LeaderBoardPage> {
  String? userid;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('UserResults');

    return Scaffold(
      appBar: AppBar(
          title: Center(child: Text('LeaderBoard')),
          backgroundColor: Colors.black),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: users.orderBy('money', descending: true).snapshots(),
            builder: (context, AsyncSnapshot asyncSnapshot) {
              if (asyncSnapshot.hasData == false) {
                return CircularProgressIndicator();
              } else {
                List<DocumentSnapshot> listOfDocumentSnap =
                    asyncSnapshot.data.docs;

                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      tileColor: listOfDocumentSnap[index]['user'] ==
                              auth.currentUser!.email
                          ? Colors.green
                          : index == 0
                              ? Colors.black12
                              : Colors.grey,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          listOfDocumentSnap[index]['user'] ==
                                  auth.currentUser!.email
                              ? Icon(Icons.verified_user)
                              : index == 0
                                  ? Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    )
                                  : Text('No: ${index + 1}'),
                          SizedBox(
                            width: 10,
                          ),
                          Text(listOfDocumentSnap[index]['user']
                              .toString()
                              .toUpperCase()),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Money= ' +
                              listOfDocumentSnap[index]['money']
                                  .toString()
                                  .toUpperCase()
                                  .substring(0, 8)),
                        ],
                      ),
                    );
                  }),
                  itemCount: listOfDocumentSnap.length,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
