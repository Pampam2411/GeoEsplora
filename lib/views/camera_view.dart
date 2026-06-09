import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geoesplora/viewmodels/bottom_nav_viewmodel.dart';
import '../viewmodels/camera_viewmodel.dart';

class CameraView extends ConsumerStatefulWidget {
  const CameraView({super.key});

  @override
  ConsumerState<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends ConsumerState<CameraView>
    with WidgetsBindingObserver {
  late final CameraViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = CameraViewModel();
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.read(bottomNavIndexProvider) == 2) {
        _viewModel.initCamera();
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final currentIndex = ref.read(bottomNavIndexProvider);
    if (currentIndex != 2) return;

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _viewModel.stopCamera(); // Libera l'hardware
    } else if (state == AppLifecycleState.resumed) {
      _viewModel.initCamera(); // Riattiva l'hardware
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<int>(bottomNavIndexProvider, (previous, next) {
      if (next == 2) {
        _viewModel.initCamera();
      } else if (previous == 2 && next != 2) {
        _viewModel.stopCamera();
      }
    });

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
