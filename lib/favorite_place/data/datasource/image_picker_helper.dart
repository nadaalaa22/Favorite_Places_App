import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class ImagePickerHelper {
  Future<File?> pickImageFile();
}

class ImagePickerHelperImp implements ImagePickerHelper {
  @override
  Future<File?> pickImageFile() => ImagePicker()
      .pickImage(source: ImageSource.camera)
      .then((value) => value == null ? null : File(value.path));
}
