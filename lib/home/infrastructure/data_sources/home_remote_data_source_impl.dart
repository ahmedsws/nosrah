import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nosrah/home/infrastructure/data_sources/home_remote_data_source.dart';
import 'package:nosrah/home/infrastructure/models/hadeeth_model.dart';
import 'dart:math' as math;

import 'package:nosrah/home/infrastructure/models/hashtag_model.dart';

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<HadeethModel> getHadeeth() async {
    final ahadeeth =
        await FirebaseFirestore.instance.collection('ahadeeth').get();

    final int documentId = math.Random().nextInt(ahadeeth.size);

    final documentSnapshot =
        ahadeeth.docs.firstWhere((doc) => doc.id == '$documentId');

    if (documentSnapshot.exists) {
      final Map<String, dynamic> data = documentSnapshot.data();

      return HadeethModel.fromJson(data);
    } else {
      return HadeethModel.fromJson({
        'almatn': 'إن روح القدس لا يزال يؤيدك ما نافحت عن الله ورسوله',
        'source': 'صحيح مسلم'
      });
    }
  }

  @override
  Future<List<HashtagModel>> getHashtags() async {
    final hashtags =
        await FirebaseFirestore.instance.collection('hashtags').get();

    final documentsSnapshot = hashtags.docs;

    if (documentsSnapshot.isNotEmpty) {
      return documentsSnapshot
          .where((doc) => doc.data()['is_active'] == true)
          .map(
        (doc) {
          final data = doc.data();

          return HashtagModel.fromJson(data);
        },
      ).toList();
    } else {
      return [];
    }
  }
}
