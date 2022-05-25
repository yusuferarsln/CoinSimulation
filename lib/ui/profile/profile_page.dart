import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coin_sim/ui/home/viewmodel/home_page_viewmodel.dart';
import 'package:coin_sim/ui/statistics/view/statistic_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var homePageViewModel = HomePageViewModel();

  @override
  Widget build(BuildContext context) {
    CollectionReference usersdocRef = FirebaseFirestore.instance
        .collection('UserDatas')
        .doc(auth.currentUser!.uid)
        .collection('User');
    DocumentReference usersdocRef2 = FirebaseFirestore.instance
        .collection('UserDatas')
        .doc(auth.currentUser!.uid)
        .collection('User')
        .doc('UserMoney');
    DocumentReference users = FirebaseFirestore.instance
        .collection('UserResults')
        .doc(auth.currentUser!.uid);

    @override
    void initState() {
      // TODO: implement initState

      super.initState();
      homePageViewModel.getAssets();
    }

    void _adBill() {
      FirebaseFirestore _firestore = FirebaseFirestore.instance;

      _firestore
          .collection('UserDatas')
          .doc(auth.currentUser!.uid)
          .collection('User')
          .doc('UserMoney')
          .set({'money': 250000});

      setState(() {});
    }

    return Scaffold(
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: usersdocRef.snapshots(),
            builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
              if (asyncSnapshot.hasData == false) {
                return Center(child: CircularProgressIndicator());
              } else {
                List<DocumentSnapshot> list = asyncSnapshot.data.docs;

                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    return Card(
                      color: Colors.black,
                      child: InkWell(
                        child: list[index] == 'UserMoney'
                            ? SizedBox.shrink()
                            : list[index]['CoinNumber'] == 0
                                ? SizedBox.shrink()
                                : ListTile(
                                    title: Text(
                                      list[index]['Coin Name'],
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    subtitle: Text(
                                        list[index]['CoinNumber'].toString(),
                                        style: TextStyle(color: Colors.white)),
                                  ),
                      ),
                    );
                  }),
                  itemCount: list.length - 1,
                );
              }
            },
          ),
          // StreamBuilder<DocumentSnapshot>(
          //   stream: usersdocRef2.snapshots(),
          //   builder: (context, AsyncSnapshot asyncSnapshot) {
          //     return Text(asyncSnapshot.data['money'].toString());
          //   },
          // ),
  

          ElevatedButton(
              onPressed: () {
                _adBill();
              },
              child: Text('Reset Budget')),
        ],
      ),
    );
  }
}
