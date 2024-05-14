import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mercubuan_kp_android/classes.dart';
import 'package:mercubuan_kp_android/classifier.dart';
import 'package:mercubuan_kp_android/utils/image.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class ScannerScreen extends StatefulWidget {
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  late CameraController cameraController;
  late Interpreter interpreter;
  final classifier = Classifier();

  bool initialized = false;
  bool isWorking = false;
  DetectionClasses detected = DetectionClasses.nothing;
  DateTime lastShot = DateTime.now();

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    // Load the TFLite model
    await classifier.loadModel();

    final cameras = await availableCameras();
    // Create a CameraController object
    cameraController = CameraController(
      cameras[0], // Choose the first camera in the list
      ResolutionPreset.medium, // Choose a resolution preset
    );

    // Initialize the CameraController and start the camera preview
    await cameraController.initialize();
    // Listen for image frames
    await cameraController.startImageStream((image) {
      // Make predictions only if not busy
      if (!isWorking) {
        processCameraImage(image);
      }
    });

    setState(() {
      initialized = true;
    });
  }

  Future<void> processCameraImage(CameraImage cameraImage) async {
    setState(() {
      isWorking = true;
    });

    var convertedImage = ImageUtils.convertYUV420ToImage(cameraImage);

    final result = await classifier.predict(convertedImage);

    if (detected != result) {
      setState(() {
        detected = result;
      });
    }

    setState(() {
      isWorking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Camera Demo'),
      ),
      body: initialized
          ? Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  child: CameraPreview(cameraController),
                ),
                Text(
                  "Detected: ${detected.label}",
                  style: const TextStyle(
                    fontSize: 28,
                    color: Colors.blue,
                  ),
                ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
