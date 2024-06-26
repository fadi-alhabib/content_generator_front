import 'dart:typed_data';

import 'package:content_generator_front/constants.dart';
import 'package:content_generator_front/helpers.dart';
import 'package:content_generator_front/services/ai_service.dart';
import 'package:content_generator_front/widgets/button.dart';
import 'package:content_generator_front/widgets/circles_background.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class DescribeImageScreen extends StatefulWidget {
  const DescribeImageScreen({super.key});
  static String routeName = "/describe-image";

  @override
  State<DescribeImageScreen> createState() => _DescribeImageScreenState();
}

class _DescribeImageScreenState extends State<DescribeImageScreen> {
  Uint8List? _imageData;
  bool isLoading = false;
  String? description;
  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _imageData = result.files.single.bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = getScreenSize(context);
    return Scaffold(
        body: CirclesBackground(
      child: Column(
        children: [
          InkWell(
            onTap: _pickImage,
            child: Center(
                child: Container(
                    height: screenSize.height * 0.7,
                    decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.circular(50),
                        color: primaryColor.withOpacity(0.2)),
                    child: _imageData != null
                        ? Image.memory(_imageData!)
                        : Image.asset('assets/images/upload-image.png'))),
          ),
          if (_imageData != null)
            ElevatedButton(
                onPressed: () => setState(() {
                      _imageData = null;
                    }),
                child: const Text("Remove")),
          if (_imageData != null)
            Container(
              margin: const EdgeInsets.only(top: 20),
              height: 50,
              child: ElevatedButton.icon(
                onPressed: isLoading
                    ? null
                    : () async {
                        setState(() {
                          isLoading = true;
                        });
                        AiService.generateImageDescription(
                                file: MultipartFile.fromBytes(_imageData!,
                                    filename: "file"))
                            .then(
                          (value) {
                            setState(() {
                              description = value;
                              isLoading = false;
                            });
                          },
                        ).onError(
                          (error, stackTrace) {
                            print(error);
                            setState(() {
                              isLoading = false;
                            });
                          },
                        );
                      },
                label: const Text("Submit"),
                icon: const Icon(Icons.send),
              ),
            ),
          if (description != null)
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description:",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.grey.shade300),
                  ),
                  Text(
                    description!,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.grey.shade300),
                  ),
                ],
              ),
            ),
        ],
      ),
    ));
  }
}

// Stack(
//         alignment: Alignment.center,
//         children: [
//           Container(
//             height: screenSize.height * 0.7,
//             margin: const EdgeInsets.symmetric(vertical: 50),
//             decoration: BoxDecoration(
//                 boxShadow: const [
//                   BoxShadow(
//                     color: primaryColor,
//                     blurRadius: 50,
//                     spreadRadius: 4,
//                   )
//                 ],
//                 borderRadius: BorderRadius.circular(40),
//                 border: Border.all(color: primaryColor)),
//             child: AspectRatio(
//               aspectRatio: _controller!.value.aspectRatio,
//               child: ClipRRect(
//                   borderRadius: BorderRadius.circular(40),
//                   child: VideoPlayer(_controller!)),
//             ),
//           ),
//           Align(
//             alignment: Alignment.center,
//             child: Container(
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.black54,
//               ),
//               child: IconButton(
//                   onPressed: () {
//                     _controller!.value.isPlaying
//                         ? _controller!.pause()
//                         : _controller!
//                             .play()
//                             .then((value) => _controller!.setLooping(true));
//                     setState(() {
//                       isPause = !isPause;
//                     });
//                   },
//                   icon: Icon(isPause ? Icons.pause : Icons.play_arrow)),
//             ),
//           ),
//           Positioned(
//               bottom: 0,
//               child: CustomButton(
//                 child: const Text("Remove Video"),
//                 onPressed: () {
//                   setState(() {
//                     _controller = null;
//                     isPause = false;
//                   });
//                 },
//               ))
//         ],
//       )),
