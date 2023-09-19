import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_shop/data/controllers/device_storage_controller.dart';

class GetDeviceData implements DeviceStorageControllerInterface {


  @override
  Future getDataFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(pickedFile == null) {
       return null;
    } else {
      return  pickedFile;
    }
  }
}