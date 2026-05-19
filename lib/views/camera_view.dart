import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../viewmodels/camera_viewmodel.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late final CameraViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = CameraViewModel();
    _viewModel.initCamera();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedBuilder(
        animation: _viewModel,
        builder: (context, child) {
          if (!_viewModel.isInitialized || _viewModel.controller == null) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          return Stack(
            fit: StackFit.expand,
            children: [
              CameraPreview(_viewModel.controller!),

              SafeArea(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 120.0),
                    child: GestureDetector(
                      onTap: () async {
                        final file = await _viewModel.takePicture();
                        if (file != null) {
                          debugPrint("Foto scattata salvata in: ${file.path}");
                        }
                      },
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                        child: Center(
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
