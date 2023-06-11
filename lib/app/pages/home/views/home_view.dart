import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:teknisi_app/app/pages/home/controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<QuerySnapshot?>(
        future: controller.firebaseFunctions
            .getUserCredential(controller.currentUser!.email!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var userData =
                jsonDecode(jsonEncode(snapshot.data?.docs.first.data()));
            if (userData['accountType'] == 1) {
              return Column(
                children: [],
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(userData['accountType'].toString()),
                )
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
