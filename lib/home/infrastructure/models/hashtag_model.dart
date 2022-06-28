import 'package:nosrah/home/domain/entities/hashtag.dart';

class HashtagModel extends Hashtag {
  const HashtagModel({
    required String text,
    required int priority,
  }) : super(
          text: text,
          priority: priority,
        );

  HashtagModel.fromJson(Map<String, dynamic> json)
      : super(
          text: json['text'],
          priority: json['priority'],
        );
}
