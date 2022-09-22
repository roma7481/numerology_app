import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/data/models/OtherApp.dart';

class OtherAppsRepository {

  Future<List<OtherApp>> getAll() async {
    Query<OtherApp> snapshot = FirebaseFirestore.instance
        .collection("${Globals.instance.localeCode}/other_apps/${Platform.operatingSystem}")
        .withConverter<OtherApp>(
      fromFirestore: (snapshots, _) => OtherApp.fromJson(snapshots.data()),
      toFirestore: (category, _) => category.toJson(),
    );

    QuerySnapshot<OtherApp> querySnapshot = await snapshot.get();
    List<OtherApp> otherApps = querySnapshot.docs.map((e) => e.data()).toList();
    return otherApps;
  }

}