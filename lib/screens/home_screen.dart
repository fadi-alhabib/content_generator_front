import 'dart:convert';
import 'dart:typed_data';

import 'package:content_generator_front/constants.dart';
import 'package:content_generator_front/helpers.dart';
import 'package:content_generator_front/services/auth_service.dart';
import 'package:content_generator_front/widgets/button.dart';
import 'package:content_generator_front/widgets/circles_background.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  VideoPlayerController? _controller;
  Uint8List? _videoBytes;
  bool isPause = false;
  late TabController tabController;
  late TextEditingController urlController;
  String? url;

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
      appBar: AppBar(
        title: const Text('Smart Scribe'),
        actions: [
          TextButton(
              onPressed: () {
                AuthService.logout()
                    .then((value) =>
                        Navigator.of(context).pushReplacementNamed('/'))
                    .onError((error, stackTrace) => showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                            title: Text(
                              "something wrong happend, please try again later!",
                              style: TextStyle(color: Colors.amber),
                            ),
                          ),
                        ));
              },
              child: Text(
                'Logout',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: primaryColor),
              ))
        ],
      ),
      body: CirclesBackground(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              crossAxisCount: 3,
            ),
            itemCount: containers.length,
            itemBuilder: (BuildContext context, int index) {
              return LayoutBuilder(builder: (context, boxConstraints) {
                return Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: containers[index]["border"], width: 2.0),
                      borderRadius: BorderRadius.circular(15),
                      color: containers[index]["body"]),
                  child: Column(
                    children: [
                      Lottie.asset(containers[index]["icon"],
                          height: boxConstraints.maxHeight / 2,
                          fit: BoxFit.cover),
                      Text(
                        containers[index]["title"],
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      Text(containers[index]["description"]),
                    ],
                  ),
                );
              });
            },
          ),
        ),
      ),
      // body: CirclesBackground(
      //   child: SingleChildScrollView(
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(vertical: 10),
      //       child: Column(
      //         mainAxisSize: MainAxisSize.min,
      //         children: [
      //           _controller != null
      //               ? Stack(
      //                   alignment: Alignment.center,
      //                   children: [
      //                     Container(
      //                       height: screenSize.height * 0.7,
      //                       margin: const EdgeInsets.symmetric(vertical: 50),
      //                       decoration: BoxDecoration(
      //                           boxShadow: const [
      //                             BoxShadow(
      //                               color: primaryColor,
      //                               blurRadius: 50,
      //                               spreadRadius: 4,
      //                             )
      //                           ],
      //                           borderRadius: BorderRadius.circular(40),
      //                           border: Border.all(color: primaryColor)),
      //                       child: AspectRatio(
      //                         aspectRatio: _controller!.value.aspectRatio,
      //                         child: ClipRRect(
      //                             borderRadius: BorderRadius.circular(40),
      //                             child: VideoPlayer(_controller!)),
      //                       ),
      //                     ),
      //                     Align(
      //                       alignment: Alignment.center,
      //                       child: Container(
      //                         decoration: const BoxDecoration(
      //                           shape: BoxShape.circle,
      //                           color: Colors.black54,
      //                         ),
      //                         child: IconButton(
      //                             onPressed: () {
      //                               _controller!.value.isPlaying
      //                                   ? _controller!.pause()
      //                                   : _controller!.play().then((value) =>
      //                                       _controller!.setLooping(true));
      //                               setState(() {
      //                                 isPause = !isPause;
      //                               });
      //                             },
      //                             icon: Icon(isPause
      //                                 ? Icons.pause
      //                                 : Icons.play_arrow)),
      //                       ),
      //                     ),
      //                     Positioned(
      //                         bottom: 0,
      //                         child: CustomButton(
      //                           child: const Text("Remove Video"),
      //                           onPressed: () {
      //                             setState(() {
      //                               _controller = null;
      //                               isPause = false;
      //                             });
      //                           },
      //                         ))
      //                   ],
      //                 )
      //               : InkWell(
      //                   onTap: _pickVideo,
      //                   child: Center(
      //                       child: Container(
      //                           height: screenSize.height * 0.7,
      //                           decoration: BoxDecoration(
      //                               border: Border.all(color: primaryColor),
      //                               borderRadius: BorderRadius.circular(50),
      //                               color: primaryColor.withOpacity(0.2)),
      //                           child: Image.asset(
      //                               'assets/images/upload-image.png'))),
      //                 ),
      //           const Gap(100),
      //           _controller != null
      //               ? SizedBox(
      //                   // width: screenSize.width / 1.2,
      //                   height: screenSize.height / 1.2,
      //                   child: LayoutBuilder(builder: (context, constraints) {
      //                     return Column(
      //                       children: [
      //                         TabBar(
      //                           controller: tabController,
      //                           tabs: const [
      //                             Tab(
      //                               text: 'TITLE',
      //                             ),
      //                             Tab(
      //                               text: 'DESCRIPTION',
      //                             ),
      //                             Tab(
      //                               text: 'KEYWORDS',
      //                             ),
      //                             Tab(
      //                               text: 'RATING',
      //                             ),
      //                           ],
      //                           labelColor: primaryColor,
      //                           indicatorColor: Colors.white,
      //                           unselectedLabelColor: Colors.white,
      //                         ),
      //                         Row(
      //                           mainAxisAlignment:
      //                               MainAxisAlignment.spaceBetween,
      //                           children: [
      //                             SizedBox(
      //                               height: constraints.maxHeight - 48,
      //                               child: IconButton(
      //                                 icon: const Icon(
      //                                   Icons.arrow_back,
      //                                   color: Colors.black,
      //                                 ),
      //                                 onPressed: () {
      //                                   if (tabController.index != 0) {
      //                                     tabController.animateTo(
      //                                       tabController.index - 1,
      //                                     );
      //                                   }
      //                                 },
      //                               ),
      //                             ),
      //                             SizedBox(
      //                               width: screenSize.width / 1.3,
      //                               height: constraints.maxHeight - 48,
      //                               child: TabBarView(
      //                                 controller: tabController,
      //                                 children: [
      //                                   Center(
      //                                     child: Text(
      //                                       "Titleee",
      //                                       style: Theme.of(context)
      //                                           .textTheme
      //                                           .headlineMedium,
      //                                     )
      //                                         .animate()
      //                                         .scale(duration: 1.seconds)
      //                                         .shake(duration: 1.seconds)
      //                                         .shader(duration: 1.seconds),
      //                                   ),
      //                                   const Center(
      //                                     child: Text(
      //                                         "Non ullamco sunt occaecat enim aliquip adipisicing magna fugiat incididunt. Id dolor ex ut sint. Ut et excepteur sunt ex velit. Incididunt quis proident ipsum sunt. Consectetur esse aliquip magna ad voluptate Lorem. Ipsum culpa dolor qui ad excepteur quis sit elit tempor."),
      //                                   )
      //                                       .animate()
      //                                       .scale(duration: 0.5.seconds)
      //                                       .shader(duration: 0.5.seconds),
      //                                   GridView.builder(
      //                                     padding: const EdgeInsets.all(10),
      //                                     gridDelegate:
      //                                         const SliverGridDelegateWithFixedCrossAxisCount(
      //                                             crossAxisCount: 3,
      //                                             crossAxisSpacing: 20,
      //                                             mainAxisSpacing: 10,
      //                                             childAspectRatio: 8 / 1),
      //                                     itemBuilder: (context, index) {
      //                                       return Container(
      //                                         decoration: BoxDecoration(
      //                                             color: Colors.grey.shade100
      //                                                 .withOpacity(0.2),
      //                                             borderRadius:
      //                                                 BorderRadius.circular(
      //                                                     20)),
      //                                         child: Center(
      //                                             child: Text(
      //                                           "Keyword $index",
      //                                           style: Theme.of(context)
      //                                               .textTheme
      //                                               .bodyMedium!
      //                                               .copyWith(
      //                                                   color: primaryColor),
      //                                         )),
      //                                       );
      //                                     },
      //                                   ),
      //                                   Container(
      //                                     margin:
      //                                         const EdgeInsets.only(bottom: 20),
      //                                     child: Column(
      //                                       mainAxisAlignment:
      //                                           MainAxisAlignment.end,
      //                                       children: [
      //                                         Flexible(
      //                                           child: PieChart(
      //                                             totalValue: 100,
      //                                             colorList: const [
      //                                               Colors.green,
      //                                               Colors.red
      //                                             ],
      //                                             dataMap: const {
      //                                               "Positive": 60,
      //                                               "Negative": 40,
      //                                             },
      //                                             chartValuesOptions:
      //                                                 ChartValuesOptions(
      //                                               chartValueStyle:
      //                                                   Theme.of(context)
      //                                                       .textTheme
      //                                                       .titleLarge!,
      //                                               showChartValueBackground:
      //                                                   false,
      //                                               showChartValuesInPercentage:
      //                                                   true,
      //                                               decimalPlaces: 1,
      //                                             ),
      //                                           ),
      //                                         ),
      //                                         TextFormField(
      //                                           cursorColor: Colors.black,
      //                                           controller: urlController,
      //                                           decoration: InputDecoration(
      //                                               prefixIcon: const Icon(
      //                                                 Icons.link,
      //                                                 color: Colors.black,
      //                                               ),
      //                                               label: const Text(
      //                                                 "Enter URL",
      //                                                 style: TextStyle(
      //                                                     color: Colors.black),
      //                                               ),
      //                                               suffix: IconButton(
      //                                                 icon: const Icon(
      //                                                   Icons.send,
      //                                                   color: Colors.black,
      //                                                 ),
      //                                                 onPressed: () {
      //                                                   setState(() {
      //                                                     url = urlController
      //                                                         .text;
      //                                                   });
      //                                                 },
      //                                               )),
      //                                         ),
      //                                       ],
      //                                     ),
      //                                   ),
      //                                 ],
      //                               ),
      //                             ),
      //                             SizedBox(
      //                               height: constraints.maxHeight - 48,
      //                               child: IconButton(
      //                                 icon: const Icon(Icons.arrow_forward,
      //                                     color: Colors.black),
      //                                 onPressed: () {
      //                                   if (tabController.index !=
      //                                       tabController.length) {
      //                                     tabController.animateTo(
      //                                       tabController.index + 1,
      //                                     );
      //                                   }
      //                                 },
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                       ],
      //                     );
      //                   }),
      //                 )
      //               : const SizedBox(),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
