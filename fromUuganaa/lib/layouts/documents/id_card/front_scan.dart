import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cashapp/components/button/black_white_button.dart';
import 'package:cashapp/components/button/white_green_button.dart';
import 'package:cashapp/components/loader.dart';
import 'package:cashapp/layouts/documents/id_card/take_photo_button.dart';
import 'package:cashapp/utils/common_util.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';

class FrontScan extends StatefulWidget {
  const FrontScan({super.key});

  @override
  State<FrontScan> createState() => _FrontScanState();
}

class _FrontScanState extends State<FrontScan> {
  late CameraController controller;
  final PageController pageController = PageController();
  late List<CameraDescription> availableCameraList;
  bool cameraControllerInitialiazed = false;
  XFile? pickedImage;
  bool isCameraTakenPhoto = true;
  bool animateBottomControllerToShow = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  initializeCamera() async {
    availableCameraList = await availableCameras();
    if (availableCameraList.isEmpty) {
      CommonUtils.showSnackBar(message: 'No available cameras detected', color: Colors.orange);
      await Future.delayed(const Duration(seconds: 2));
      return Get.close(1);
    }

    controller = CameraController(availableCameraList[0], ResolutionPreset.max);
    controller.initialize().then((_) async {
      if (!mounted) return;
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() => cameraControllerInitialiazed = true);
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() => animateBottomControllerToShow = true);
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
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      CommonUtils.showSnackBar(message: 'Error: select a camera first.');
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      return null;
    }

    try {
      final XFile image = await cameraController.takePicture();
      setPickedImage(image, true);
    } on CameraException catch (e) {
      _showCameraException(e);
    }
  }

  pickImage() async {
    final ImagePicker picker = ImagePicker();
    print('start: ${DateTime.now().toIso8601String()}');
    final XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 50, requestFullMetadata: false);
    print('end: ${DateTime.now().toIso8601String()}');
    if (image != null) {
      setPickedImage(image, false);
    }
  }

  void _showCameraException(CameraException e) {
    CommonUtils.logError(e.code, e.description);
    CommonUtils.showSnackBar(message: 'Error: ${e.code}\n${e.description}');
  }

  setPickedImage(XFile? file, bool type) async {
    setState(() {
      pickedImage = file;
      isCameraTakenPhoto = type;
    });
    pageController.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  reset() async {
    setState(() => pickedImage = null);
    pageController.animateToPage(0, duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  pauseOrResumePreview() async {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      CommonUtils.showSnackBar(message: 'Error: select a camera first.');
      return;
    }

    if (cameraController.value.isPreviewPaused) {
      await cameraController.resumePreview();
    } else {
      await cameraController.pausePreview();
    }
  }

  void toggleCameraLens() {
    // get current lens direction (front / rear)
    final lensDirection = controller.description.lensDirection;
    CameraDescription newDescription;
    if (lensDirection == CameraLensDirection.front) {
      newDescription = availableCameraList.firstWhere((description) => description.lensDirection == CameraLensDirection.back);
    } else {
      newDescription = availableCameraList.firstWhere((description) => description.lensDirection == CameraLensDirection.front);
    }
    controller.setDescription(newDescription);
  }

  @override
  Widget build(BuildContext context) {
    final bool isInitialized = (cameraControllerInitialiazed && controller.value.isInitialized);
    Size? mediaSize;
    double? scale;
    if (isInitialized) {
      mediaSize = MediaQuery.of(context).size;
      scale = 1 / (controller.value.aspectRatio * mediaSize.aspectRatio);
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: isInitialized
          ? Stack(
              children: [
                ClipRect(
                  clipper: _MediaSizeClipper(mediaSize!),
                  child: Transform.scale(
                    scale: scale,
                    alignment: Alignment.topCenter,
                    child: CameraPreview(controller),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: mediaSize.height,
                    width: mediaSize.width,
                    child: pickedImage != null
                        ? Image.file(
                            File(pickedImage!.path),
                            height: isCameraTakenPhoto ? mediaSize.height : mediaSize.height * 0.5,
                            width: mediaSize.width,
                            fit: BoxFit.cover,
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: mediaSize.height * 0.5,
                    child: PageView(
                      controller: pageController,
                      pageSnapping: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        AnimatedCrossFade(
                          duration: const Duration(milliseconds: 500),
                          crossFadeState: animateBottomControllerToShow ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                          firstChild: const SizedBox.shrink(),
                          secondChild: Container(
                            color: const Color.fromRGBO(0, 0, 0, 0.8),
                            padding: const EdgeInsets.only(bottom: 12, left: 32, right: 32),
                            height: mediaSize.height * 0.5,
                            child: SafeArea(
                              child: Column(
                                children: [
                                  Text('Урд тал'),
                                  Text('Иргэний үнэмлэхийн урд талыг хүрээлсэн хэсэгт байрлуулж дарна уу!'),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(onPressed: pickImage, icon: Icon(Icons.camera)),
                                      TakePhotoButton(onTap: takePicture),
                                      IconButton(onPressed: toggleCameraLens, icon: Icon(Icons.cameraswitch_outlined)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: const Color.fromRGBO(0, 0, 0, 1),
                          padding: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
                          height: mediaSize.height * 0.5,
                          child: SafeArea(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text('Таны мэдээлэл тод гаргацтай уншигдаж байгаа эсэхийг шалгаарай.'),
                                const Spacer(),
                                Row(
                                  children: [
                                    Expanded(
                                      child: WhiteGreenButton(label: 'Үргэлжлүүлэх', onPressed: () {}),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0, bottom: 18),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: BlackWhiteButton(
                                          label: 'Дахин авах',
                                          onPressed: reset,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          : const Loader(),
    );
  }
}

class _MediaSizeClipper extends CustomClipper<Rect> {
  final Size mediaSize;
  const _MediaSizeClipper(this.mediaSize);
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, mediaSize.width, mediaSize.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
