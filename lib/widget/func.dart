import 'dart:io';

import 'package:hive/hive.dart';
import 'package:ibenefit_interview_test/model/init_response.dart';
import 'package:ibenefit_interview_test/repo/login_repo.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;

class StoreDeivceCode {
  static late Box<dynamic> box;
  static late Box<dynamic> boxTimestamp;
  static LoginRepository loginRepository =
      LoginRepository(httpClient: http.Client());
  static Future openBox() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    box = await Hive.openBox('data');
    boxTimestamp = await Hive.openBox('timestamp');
    return;
  }

  static Future putData(data) async {
    await box.clear();
    await boxTimestamp.clear();
    box.add(data);
    //Put timestamp
    boxTimestamp.add(DateTime.now());
  }

  static Future<String> getDeviceCode() async {
    box = await Hive.openBox('data');
    boxTimestamp = await Hive.openBox('timestamp');

    if (boxTimestamp.isEmpty) {
      //Neu timestamp trong thi phai add truoc cho no 1 cai
      boxTimestamp.add(DateTime.now());
      return "";
    } else {
      DateTime timestamp = boxTimestamp.values.first;
      if (DateTime.now().isBefore(timestamp.add(Duration(minutes: 1)))) {
        print("Code cũ á: " + box.values.toString());
        return box.values.first.toString();
      } else {
        final response = await loginRepository.initDevice();
        if (response is InitResponse) {
          print("Phải tải Device code mới: " + response.data!.deviceCode!);
          putData(response.data!.deviceCode!);
          return response.data!.deviceCode!;
        } else {
          return "Error";
        }
      }
    }
  }
}
