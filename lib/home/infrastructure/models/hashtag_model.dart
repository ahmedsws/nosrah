import 'package:nosrah/home/domain/entities/hashtag.dart';
import 'package:nosrah/home/domain/utils/hashtag_count_values.dart';

class HashtagModel extends Hashtag {
  const HashtagModel({
    required String text,
    required int priority,
    required String key,
    bool isActive = false,
    bool hasCount = false,
    int? count,
  }) : super(
          text: text,
          priority: priority,
          isActive: isActive,
          hasCount: hasCount,
          key: key,
          count: count,
        );

  HashtagModel.fromJson(Map<String, dynamic> json)
      : super(
          text: json['text'] +
              (json['has_count'] ? getCount(json).toString() : ''),
          priority: json['priority'],
          key: json['key'],
          isActive: json['is_active'],
          hasCount: json['has_count'],
          count: json['has_count'] ? getCount(json) : null,
        );

  static int? getCount(Map<String, dynamic> json) {
    return HashtagCountValues().getValues()[json['key']];
  }
}
