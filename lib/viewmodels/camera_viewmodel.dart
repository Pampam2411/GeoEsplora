import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraViewModel extends ChangeNotifier {
  CameraController? controller;
  List<CameraDescription>? cameras;
  bool isInitialized = false;

  Future<void> initCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras != null && cameras!.isNotEmpty) {
        controller = CameraController(
          cameras![0],
          ResolutionPreset.high,
          enableAudio: false,
        );

        await controller!.initialize();
        isInitialized = true;
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Errore inizializzazione fotocamera: $e");
    }
  }

  Future<XFile?> takePicture() async {
    if (controller != null && controller!.value.isInitialized) {
      try {
        final XFile file = await controller!.takePicture();
        return file;
      } catch (e) {
        debugPrint("Errore durante lo scatto: $e");
        return null;
      }
    }
    return null;
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
