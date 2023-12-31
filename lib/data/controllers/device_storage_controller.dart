import 'package:keyboard_shop/data/get_data/from_device/get_device_data.dart';

abstract class DeviceStorageControllerInterface {
  getDataFromGallery();
}


class DeviceStorageController {
  final DeviceStorageControllerInterface _implementationObject = GetDeviceData();


  getGalleryData() async {
    return _implementationObject.getDataFromGallery();
  }
}