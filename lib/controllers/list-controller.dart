import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user.dart';

class ListController extends GetxController {
  /// items list
  RxList list = <User>[].obs;

  /// sharedPreferences
  static final _savedList = () => GetStorage('MyPrefList');

  // final price = 1000.val('price', getBox: _savedList);
  // final price2 = ReadWriteValue('price', '', _savedList);

  // final age = Get.find<MyPref>().age;
  // age.val = 1;
  // final realAge = age.val; // will read from box

}
