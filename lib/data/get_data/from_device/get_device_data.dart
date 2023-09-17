import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_shop/data/controllers/device_storage_controller.dart';

class GetDeviceData implements DeviceStorageControllerInterface {


  @override
  Future<Uint8List?> getDataFromGallery() async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile == null) {
       return null;
    } else {
      return await pickedFile.readAsBytes();
    }
  }
}