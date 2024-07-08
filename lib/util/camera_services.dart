import 'package:image_picker/image_picker.dart';

class CameraServices {
  static Future cameraPickImage() async {
    ImagePicker _picker = ImagePicker();
    XFile? f = await _picker.pickImage(source: ImageSource.gallery);
    return f;
  }
}
