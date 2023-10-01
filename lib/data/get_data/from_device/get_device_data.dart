import 'package:image_picker/image_picker.dart';
import 'package:keyboard_shop/data/controllers/device_storage_controller.dart';

class GetDeviceData implements DeviceStorageControllerInterface {


  @override
  Future<XFile?> getDataFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    return pickedFile;
  }
}