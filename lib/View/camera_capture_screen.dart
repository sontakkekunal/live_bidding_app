import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dealer_caryanam/View/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../Constant/resizing.dart';
import '../Controller/controller.dart';
import '../Model/car_beading_model.dart';

class CameraCaptureScreen extends ConsumerStatefulWidget {
  final List<CameraDescription> cameraList;
  final InspectorCarImgInfo icii;
  const CameraCaptureScreen(
      {super.key, required this.cameraList, required this.icii});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _CameraCaptureScreenState();
  }
}

class _CameraCaptureScreenState extends ConsumerState<CameraCaptureScreen> {
  late final CameraController _cameraController;
  late Future<void> _initializeCameraController;
  XFile? _imgFile;
  @override
  void initState() {
    super.initState();
    _cameraController =
        CameraController(widget.cameraList.first, ResolutionPreset.medium);
    _initializeCameraController = _cameraController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Take Photo",
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: FutureBuilder(
          future: _initializeCameraController,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 120.0.h()),
                  height: 450.0.h(),
                  width: 330.0.w(),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12, blurRadius: 6, spreadRadius: 4)
                    ],
                    borderRadius: BorderRadius.circular(15.0.h()),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0.h()),
                    child: _imgFile != null
                        ? Image.file(File(_imgFile!.path))
                        : CameraPreview(_cameraController),
                  ),
                ),
              );

              // if (imgFile != null) {
              //   return Image.file(imgFile!);
              // }
              // return CameraPreview(_cameraController);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w()),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: _imgFile != null
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.center,
          children: [
            if (_imgFile != null)
              FloatingActionButton.extended(
                heroTag: '2',
                onPressed: () async {
                  showCircularProcess(context: context);
                  if (await ref.watch(apiProvider).addWithPhotoCarPart(
                      icii: widget.icii, imgFile: File(_imgFile!.path))) {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    showSnackBar(
                        color: Colors.green,
                        message: "Car with image Added",
                        context: context);
                  } else {
                    Navigator.of(context).pop();
                    showSnackBar(
                        color: Colors.red,
                        message: "Car with image Added unsucessfully",
                        context: context);
                  }
                },
                backgroundColor: Colors.black54,
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(67.0.h()),
                        right: Radius.circular(67.0.h()))),
                label: Container(
                  alignment: Alignment.center,
                  height: 55.0.h(),
                  width: 120.0.w(),
                  child: Text(
                    "Upload Image",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            FloatingActionButton.extended(
              heroTag: '1',
              onPressed: () async {
                if (_imgFile == null) {
                  try {
                    await _initializeCameraController;
                    final path = join(
                      (await getTemporaryDirectory()).path,
                      '${DateTime.now()}.png',
                    );

                    _imgFile = await _cameraController.takePicture();
                  } catch (e) {
                    print(e);
                  }
                } else {
                  _imgFile = null;
                }
                setState(() {});
              },
              backgroundColor: Colors.black54,
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(67.0.h()),
                      right: Radius.circular(67.0.h()))),
              label: Container(
                margin: EdgeInsets.zero,
                alignment: Alignment.center,
                height: 50.0.h(),
                width: 100.0.w(),
                child: Text(
                  _imgFile == null ? "Capture" : "Retake",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                ),
              ),
              //child: ,
            )
          ],
        ),
      ),
    );
  }
}
