import 'dart:convert';
import 'dart:typed_data';

import 'package:content_generator_front/constants.dart';
import 'package:content_generator_front/helpers.dart';
import 'package:content_generator_front/models/description_model.dart';
import 'package:content_generator_front/services/ai_api_service.dart';
import 'package:content_generator_front/widgets/button.dart';
import 'package:content_generator_front/widgets/circles_background.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:video_player/video_player.dart';

class DescriptionScreen extends StatefulWidget {
  const DescriptionScreen({super.key});
  static String routeName = '/description';
  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen>
    with SingleTickerProviderStateMixin {
  VideoPlayerController? _controller;
  Uint8List? _videoBytes;
  bool isPause = false;
  late TabController tabController;
  late TextEditingController urlController;
  String? url;
  DescriptionModel? description;

  Future<void> _pickVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      withData: true,
    );

    if (result != null) {
      _videoBytes = result.files.single.bytes;
      _playVideoFromBytes(_videoBytes!);
    }
  }

  Future<void> _playVideoFromBytes(Uint8List videoBytes) async {
    final videoDataUri = 'data:video/mp4;base64,${base64Encode(videoBytes)}';

    // Create a video player controller from the data URI
    _controller = VideoPlayerController.network(videoDataUri)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 4, vsync: this);
    urlController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = getScreenSize(context);

    return Scaffold(
      body: CirclesBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _controller != null
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: screenSize.height * 0.7,
                            margin: const EdgeInsets.symmetric(vertical: 50),
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: primaryColor,
                                    blurRadius: 50,
                                    spreadRadius: 4,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(color: primaryColor)),
                            child: AspectRatio(
                              aspectRatio: _controller!.value.aspectRatio,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: VideoPlayer(_controller!)),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black54,
                              ),
                              child: IconButton(
                                  onPressed: () {
                                    _controller!.value.isPlaying
                                        ? _controller!.pause()
                                        : _controller!.play().then((value) =>
                                            _controller!.setLooping(true));
                                    setState(() {
                                      isPause = !isPause;
                                    });
                                  },
                                  icon: Icon(isPause
                                      ? Icons.pause
                                      : Icons.play_arrow)),
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              child: CustomButton(
                                child: const Text("Remove Video"),
                                onPressed: () {
                                  setState(() {
                                    _controller = null;
                                    isPause = false;
                                  });
                                },
                              ))
                        ],
                      )
                    : InkWell(
                        onTap: _pickVideo,
                        child: Center(
                            child: Container(
                                height: screenSize.height * 0.7,
                                decoration: BoxDecoration(
                                    border: Border.all(color: primaryColor),
                                    borderRadius: BorderRadius.circular(50),
                                    color: primaryColor.withOpacity(0.2)),
                                child: Image.asset(
                                    'assets/images/upload-image.png'))),
                      ),
                if (_controller != null)
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: _controller!.value.size.width,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        AiService.generateDescription(
                                file: MultipartFile.fromBytes(_videoBytes!))
                            .then(
                          (value) {
                            setState(() {
                              description = value;
                            });
                          },
                        ).onError(
                          (error, stackTrace) {
                            print(error);
                          },
                        );
                      },
                      label: const Text("Submit"),
                      icon: const Icon(Icons.send),
                    ),
                  ),
                if (description != null)
                  Container(
                    child: Text(description!.greedyCaption!),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}