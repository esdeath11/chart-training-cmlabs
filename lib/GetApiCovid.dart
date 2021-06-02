import 'dart:convert';
import 'package:http/http.dart' as http;

class EndPointLink {
  static var url = Uri.https(
      'data.covid19.go.id', '/public/api/prov_detail_JAWA_TIMUR.json');
}

class GetDataApiCovid {
  static Future getData() async {
    final response = await http.get(EndPointLink.url);
    var body = json.decode(response.body);
    var listModelCovid = List.from(body['list_perkembangan'].map((model)=>
      ModelCovid.fromJson(model)
    ));

    print(listModelCovid[1].tanggal);
    return listModelCovid;
  }
}





class ModelCovid {
  final int kasus;
  final int sembuh;
  final int meninggal;
  final DateTime tanggal;

  ModelCovid({ required this.kasus, required this.sembuh, required this.meninggal, required this.tanggal});

  factory ModelCovid.fromJson(Map<String, dynamic> json){
    return ModelCovid(
        kasus: json['KASUS'], sembuh: json['SEMBUH'], meninggal: json['MENINGGAL'], tanggal: DateTime.fromMillisecondsSinceEpoch(json['tanggal']));
  }
}
