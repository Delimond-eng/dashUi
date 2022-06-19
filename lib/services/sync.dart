import 'dart:convert';
import 'dart:io';

import 'package:dashui/models/sync_data_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as Api;

class Synchroniser {
  static const String baseURL = "http://z-database.rtgroup-rdc.com";

  static Future<SyncModel> outPutData() async {
    Api.Client client = Api.Client();
    Api.Response response;
    try {
      response = await client.get(Uri.parse("$baseURL/datas/sync/out"));
    } catch (err) {
      print("error from output data $err");
    }
    print(response.body);
    if (response.statusCode == 200) {
      return SyncModel.fromMap(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  static Future<void> send(Map<String, dynamic> map) async {
    String json = jsonEncode(map);
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    String filename = "file.json";
    File file = File(tempPath + "/" + filename);
    file.createSync();
    file.writeAsStringSync(json);
    try {
      var request =
          Api.MultipartRequest('POST', Uri.parse("$baseURL/datas/sync/in"));

      request.files.add(
        Api.MultipartFile.fromBytes(
          'fichier',
          file.readAsBytesSync(),
          filename: filename.split("/").last,
        ),
      );
      request
          .send()
          .then((result) async {
            Api.Response.fromStream(result).then((response) {
              if (response.statusCode == 200) {
                print(response.body);
              }
            });
          })
          .catchError((err) => print('error : ' + err.toString()))
          .whenComplete(() {});
    } catch (err) {
      print("error from $err");
    }
  }
}
