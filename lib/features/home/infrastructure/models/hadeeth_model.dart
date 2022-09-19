import '../../domain/entities/hadeeth.dart';

class HadeethModel extends Hadeeth {
  const HadeethModel({
    String almatn = 'إن روح القدس لا يزال يؤيدك ما نافحت عن الله ورسوله',
    String source = 'صحيح مسلم',
  }) : super(
          almatn: almatn,
          source: source,
        );

  HadeethModel.fromJson(Map<String, dynamic> json)
      : super(
          almatn: json['almatn'],
          source: json['source'],
        );
}
