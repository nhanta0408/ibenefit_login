import 'dart:io';

import 'package:hive/hive.dart';
import 'package:ibenefit_interview_test/model/init_response.dart';
import 'package:ibenefit_interview_test/repo/login_repo.dart';
import 'package:ibenefit_interview_test/value/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;

class StoreDeivceCode {
  //Khai báo các box
  //Box để chứa device code
  static late Box<dynamic> box;
  //Box Timestamp để chứa timestamp, nhận biết khi nào nên clear cache
  static late Box<dynamic> boxTimestamp;
  //Dùng để get device code từ api
  static LoginRepository loginRepository =
      LoginRepository(httpClient: http.Client());

  //Open box
  static Future openBox() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    box = await Hive.openBox('data');
    boxTimestamp = await Hive.openBox('timestamp');

    box.add("dummy");
    //Phần tử timestamp đầu tiên là -30 ngày trước nên chắc chắc phải tải dữ liệu từ API
    boxTimestamp.add(DateTime.now().add(Duration(days: -45)));

    return;
  }

//Add dữ liệu và cache, có clear
  static Future putData(data) async {
    await box.clear();
    await boxTimestamp.clear();
    box.add(data);
    //Put timestamp
    boxTimestamp.add(DateTime.now());
  }

  //get device code, xử lí luôn phần timout Cache
  static Future<String> getDeviceCode() async {
    box = await Hive.openBox('data');
    boxTimestamp = await Hive.openBox('timestamp');

    DateTime timestamp = boxTimestamp.values.first;
    print(boxTimestamp.values.first);
    //Chỉnh duration tại đây để dễ test
    if (DateTime.now().isBefore(timestamp.add(Constants.timeOutCache))) {
      //Nếu cache còn hạn sử dụng
      print("Code cũ á: " + box.values.toString());
      return box.values.first.toString();
    } else {
      //Nếu cache hết hạn dùng
      final response = await loginRepository.initDevice();
      if (response is InitResponse) {
        print("Phải tải Device code mới: " + response.data!.deviceCode!);
        putData(response.data!.deviceCode!);
        return response.data!.deviceCode!;
      } else {
        //return "Error" tức là lỗi, bên ngoài sẽ xử lí
        return "Error";
      }
    }
  }
}
