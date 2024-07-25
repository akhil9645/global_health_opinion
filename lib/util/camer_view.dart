import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controller.dart/app_controller.dart';
import '../main.dart';

class CameraView extends StatefulWidget {
  const CameraView({Key? key}) : super(key: key);

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late final CameraController _camera;
  final AppController _appController = Get.find();

  @override
  void initState() {
    super.initState();
    _camera = CameraController(cameras[0], ResolutionPreset.high);
    _camera.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: CameraPreview(
        _camera,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: InkWell(
                onTap: () async {
                  if (kDebugMode) {
                    XFile file = await CameraServices.cameraPickImage();
                    log(file.toString());
                    await _appController.capturePhoto(file);
                    _appController.submitImgToBatchList();
                  } else {
                    XFile file = await _camera.takePicture();
                    await _appController.capturePhoto(file);
                    _appController.submitImgToBatchList();
                  }
                  Get.back();
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> setZoom(double zoomLevel) async {
    if (_camera == null || !_camera.value.isInitialized) {
      return;
    }

    // Ensure the zoom level is within the allowed range (min: 0.0, max: maxZoomScale)
    final double maxZoom = await _camera.getMaxZoomLevel();
    final double minZoom = await _camera.getMinZoomLevel();
    zoomLevel = zoomLevel.clamp(minZoom, maxZoom);

    await _camera.setZoomLevel(zoomLevel);
  }

  @override
  void dispose() {
    _camera.dispose();
    super.dispose();
  }
}

class CameraServices {
  static Future cameraPickImage() async {
    ImagePicker _picker = ImagePicker();
    XFile? f = await _picker.pickImage(source: ImageSource.gallery);
    return f;
  }
}
