import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coin_sim/ui/auth/auth_services.dart';
import 'package:coin_sim/ui/home/viewmodel/home_page_viewmodel.dart';
import 'package:coin_sim/ui/statistics/view/statistic_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'dart:convert';

import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  var homePageViewModel = HomePageViewModel();

  @override
  void initState() {
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
    _firestore
        .collection('UserResults')
        .doc(auth.currentUser!.uid)
        .set({'money': 250000, 'user': auth.currentUser!.email});

    setState(() {});
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

    if (response2.data() == null) {
      _firestore
          .collection('UserDatas')
          .doc(auth.currentUser!.uid)
          .collection('User')
          .doc(coin)
          .set({
        'Coin Name': coin,
        'Bought Price': price,
        'CoinNumber': 0,
      });
      var response3 = await coinRef.get();
      dynamic map2 = response3.data();
      var bla = map2['CoinNumber'];

      if (newBudget < price) {
        Get.snackbar('Fail', 'You dont have enough money to buy $coin');
      } else {
        usersdocRef.set({'money': newBudget});
        _firestore
            .collection('UserResults')
            .doc(auth.currentUser!.uid)
            .set({'money': newBudget, 'user': auth.currentUser!.email});

        _firestore
            .collection('UserDatas')
            .doc(auth.currentUser!.uid)
            .collection('User')
            .doc(coin)
            .set({
          'Coin Name': coin,
          'Bought Price': price,
          'CoinNumber': bla + 1,
          'Bought Date': DateTime.now()
        });

        setState(() {});
      }
    } else {
      var response2 = await coinRef.get();
      dynamic map2 = response2.data();
      var bla = map2['CoinNumber'];

      if (newBudget < price) {
        Get.snackbar('Fail', 'You dont have enough money to buy $coin');
      } else {
        usersdocRef.set({'money': newBudget});
        _firestore
            .collection('UserResults')
            .doc(auth.currentUser!.uid)
            .set({'money': newBudget, 'user': auth.currentUser!.email});

        _firestore
            .collection('UserDatas')
            .doc(auth.currentUser!.uid)
            .collection('User')
            .doc(coin)
            .set({
          'Coin Name': coin,
          'Bought Price': price,
          'CoinNumber': bla + 1,
          'Bought Date': DateTime.now()
        });
        Get.snackbar('Success', 'You bought your new coin',
            snackPosition: SnackPosition.BOTTOM);

        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
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

      FirebaseFirestore _firestore = FirebaseFirestore.instance;
      _firestore
          .collection('UserResults')
          .doc(auth.currentUser!.uid)
          .set({'money': newBudget, 'user': auth.currentUser!.email});

      if (bla - 1 == 0) {
        _firestore
            .collection('UserDatas')
            .doc(auth.currentUser!.uid)
            .collection('User')
            .doc(coin)
            .delete();
      } else {
        _firestore
            .collection('UserDatas')
            .doc(auth.currentUser!.uid)
            .collection('User')
            .doc(coin)
            .set({
          'Coin Name': coin,
          'Bought Price': price,
          'CoinNumber': bla - 1,
          'Bought Date': DateTime.now()
        });
      }

      Get.snackbar('Success', 'You sold your coin',
          snackPosition: SnackPosition.BOTTOM);

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseMoney;
    final _firestore = FirebaseFirestore.instance;
    DocumentReference usersdocRef = FirebaseFirestore.instance
        .collection('UserDatas')
        .doc(auth.currentUser!.uid)
        .collection('User')
        .doc('UserMoney');

    final TextEditingController _controller = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('CoinSim'),
        actions: [
          InkWell(
            child: Icon(Icons.logout),
            onTap: () {
              AuthController.instance.logOut();
            },
          )
        ],
      ),
      body: Observer(builder: (context) {
        return homePageViewModel.assetsModel == null
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(children: [
                  TextButton(
                      onPressed: () {
                        _adBill();
                        Get.snackbar('Success', 'Your budget has been given',
                            snackPosition: SnackPosition.BOTTOM);
                      },
                      child: Text('Get Your Budget')),
                  ListView.builder(
                    itemBuilder: ((context, index) {
                      return homePageViewModel.assetsModelList![index] == null
                          ? CircularProgressIndicator()
                          : Container(
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => StatisticPage(coinname: index));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    tileColor: Colors.white24,
                                    title: Row(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            OutlinedButton(
                                                onPressed: () {
                                                  _Sell(
                                                      double.parse(
                                                          homePageViewModel
                                                              .assetsModelList![
                                                                  index]!
                                                              .priceUsd
                                                              .toString()),
                                                      homePageViewModel
                                                          .assetsModelList![
                                                              index]!
                                                          .symbol
                                                          .toString());
                                                },
                                                child: Text('Sell',
                                                    style: TextStyle(
                                                        color: Colors.red))),
                                            OutlinedButton(
                                                onPressed: () {
                                                  _Buy(
                                                      double.parse(
                                                          homePageViewModel
                                                              .assetsModelList![
                                                                  index]!
                                                              .priceUsd
                                                              .toString()),
                                                      homePageViewModel
                                                          .assetsModelList![
                                                              index]!
                                                          .symbol
                                                          .toString());
                                                },
                                                child: Text(
                                                  'Buy',
                                                  style: TextStyle(
                                                      color:
                                                          Colors.greenAccent),
                                                )),
                                          ],
                                        ),
                                        Text(
                                          homePageViewModel
                                              .assetsModelList![index]!.priceUsd
                                              .toString()
                                              .substring(0, 15),
                                          style: TextStyle(color: Colors.amber),
                                        ),
                                        Text(
                                          '  USD',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        SizedBox(
                                          width: 40,
                                        ),
                                      ],
                                    ),
                                    leading: Text(
                                      homePageViewModel
                                          .assetsModelList![index]!.symbol
                                          .toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            );
                    }),
                    itemCount: homePageViewModel.assetsModelList!.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  ),
                ]),
              );
      }),
    );
  }
}
