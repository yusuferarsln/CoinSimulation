import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coin_sim/ui/home/model/assets_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';

import '../../home/viewmodel/home_page_viewmodel.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StatisticPage extends StatefulWidget {
  final coinname;
  StatisticPage({Key? key, required this.coinname}) : super(key: key);

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  var homePageViewModel = HomePageViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homePageViewModel.getAssets();
  }

  void _Buy(double price, String coin) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    DocumentReference usersdocRef = FirebaseFirestore.instance
        .collection('UserDatas')
        .doc(auth.currentUser!.uid)
        .collection('User')
        .doc('UserMoney');
    var response = await usersdocRef.get();
    dynamic map = response.data();
    var newBudget = map['money'] - price;

    DocumentReference coinRef = FirebaseFirestore.instance
        .collection('UserDatas')
        .doc(auth.currentUser!.uid)
        .collection('User')
        .doc(coin);
    var response2 = await coinRef.get();
    dynamic map2 = response2.data();
    var bla = map2['CoinNumber'];

    if (newBudget < price) {
      Get.snackbar('Fail', 'You dont have enough money to buy $coin');
    } else {
      usersdocRef.set({'money': newBudget});

      _firestore
          .collection('UserDatas')
          .doc(auth.currentUser!.uid)
          .collection('User')
          .doc(coin)
          .set({
        'Coin Name': coin,
        'Bought Price': price,
        'CoinNumber': bla + 1,
      });

      setState(() {});
    }
  }

  void _Sell(double price, coin) async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    DocumentReference usersdocRef = FirebaseFirestore.instance
        .collection('UserDatas')
        .doc(auth.currentUser!.uid)
        .collection('User')
        .doc('UserMoney');
    var response = await usersdocRef.get();
    dynamic map = response.data();
    var newBudget = map['money'] + price;

    DocumentReference coinRef = FirebaseFirestore.instance
        .collection('UserDatas')
        .doc(auth.currentUser!.uid)
        .collection('User')
        .doc(coin);
    var response2 = await coinRef.get();
    dynamic map2 = response2.data();
    var bla = map2['CoinNumber'];

    if (bla == 0) {
      Get.snackbar('Fail', 'You dont have any $coin');
    } else {
      usersdocRef.set({'money': newBudget});

      _firestore
          .collection('UserDatas')
          .doc(auth.currentUser!.uid)
          .collection('User')
          .doc(coin)
          .set({
        'Coin Name': coin,
        'Bought Price': price,
        'CoinNumber': bla - 1,
      });

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    DocumentReference usersdocRef = FirebaseFirestore.instance
        .collection('UserDatas')
        .doc(auth.currentUser!.uid)
        .collection('User')
        .doc('UserMoney');

    return Scaffold(
        appBar:
            AppBar(title: Text('Statistics'), backgroundColor: Colors.black),
        backgroundColor: Colors.black,
        body: Observer(builder: (context) {
          return homePageViewModel.assetsModel == null
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(children: [
                    ListView.builder(
                      
                      itemBuilder: ((context, index) {
                        
                        return homePageViewModel.assetsModelList![index] == null
                            ? CircularProgressIndicator()
                            : Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Card(
                                  child: Container(
                                    color: Colors.black.withOpacity(0.7),
                                    height: Get.height * 0.7,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: Get.height * 0.1,
                                        ),
                                        Text(
                                          homePageViewModel
                                              .assetsModelList![
                                                  widget.coinname!.toInt()]!
                                              .name
                                              .toString(),
                                          style: TextStyle(fontSize: 30),
                                        ),
                                        Text(
                                            homePageViewModel
                                                .assetsModelList![
                                                    widget.coinname!.toInt()]!
                                                .symbol
                                                .toString(),
                                            style: TextStyle(fontSize: 20)),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              homePageViewModel
                                                  .assetsModelList![
                                                      widget.coinname!.toInt()]!
                                                  .changePercent24Hr
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: homePageViewModel
                                                              .assetsModelList![
                                                                  widget
                                                                      .coinname!
                                                                      .toInt()]!
                                                              .changePercent24Hr!
                                                              .substring(
                                                                  0, 1) ==
                                                          '-'
                                                      ? Colors.red
                                                      : Colors.greenAccent)),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Your Budget : ',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            StreamBuilder<DocumentSnapshot>(
                                              stream: usersdocRef.snapshots(),
                                              builder: (context,
                                                  AsyncSnapshot asyncSnapshot) {
                                                return Text(
                                                    asyncSnapshot.data['money']
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20));
                                              },
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.1,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text('Market Cappacity >',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white)),
                                              Text(
                                                  homePageViewModel
                                                      .assetsModelList![widget
                                                          .coinname!
                                                          .toInt()]!
                                                      .marketCapUsd
                                                      .toString()
                                                      .substring(0, 15),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.amber)),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text('Volume USD 24 Hr >',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white)),
                                              Text(
                                                  homePageViewModel
                                                      .assetsModelList![widget
                                                          .coinname!
                                                          .toInt()]!
                                                      .volumeUsd24Hr
                                                      .toString()
                                                      .substring(0, 15),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.amber)),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text('Supply >',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white)),
                                              Text(
                                                  homePageViewModel
                                                      .assetsModelList![widget
                                                          .coinname!
                                                          .toInt()]!
                                                      .supply
                                                      .toString()
                                                      .substring(0, 15),
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.amber)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                      }),
                      itemCount: 1,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ]),
                );
        }));
  }
}
