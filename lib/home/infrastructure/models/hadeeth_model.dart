import 'package:nosrah/home/domain/entities/hadeeth.dart';

class HadeethModel extends Hadeeth {
  const HadeethModel({
    String almatn =
        "إنَّ رُوحَ القُدُسِ لا يزالُ يُؤيِّدُك ما نافَحْتَ عنِ اللهِ وعن رسولِه",
  }) : super(
          almatn: almatn,
        );

  HadeethModel.fromJson(Map<String, dynamic> json)
      : super(
          almatn: json['almatn'],
        );
}
