import 'dart:convert';
import 'dart:typed_data';

import 'package:content_generator_front/constants.dart';
import 'package:content_generator_front/helpers.dart';
import 'package:content_generator_front/services/ai_service.dart';
import 'package:content_generator_front/widgets/button.dart';
import 'package:content_generator_front/widgets/circles_background.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:video_player/video_player.dart';

class TitleScreen extends StatefulWidget {
  static String routeName = "/title";
  const TitleScreen({super.key});

  @override
  State<TitleScreen> createState() => _TitleScreenState();
}

class _TitleScreenState extends State<TitleScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController descriptionController = TextEditingController();
  String? title;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final screenSize = getScreenSize(context);

    return Scaffold(
      body: CirclesBackground(
        child: Center(
          child: SizedBox(
            width: screenSize.width * 0.5,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Generate Title",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const Gap(40),
                    TextFormField(
                      controller: descriptionController,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: "Enter the Video Description",
                      ),
                    ),
                    const Gap(20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: isLoading
                            ? null
                            : () {
                                setState(() {
                                  isLoading = true;
                                });
                                AiService.generateTitle(
                                        description: descriptionController.text)
                                    .then(
                                  (value) {
                                    setState(() {
                                      title = value;
                                      isLoading = false;
                                    });
                                    descriptionController.clear();
                                  },
                                ).onError(
                                  (error, stackTrace) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    print(error);
                                  },
                                );
                              },
                        label: isLoading
                            ? const CircularProgressIndicator()
                            : const Text("Submit"),
                        icon: const Icon(Icons.send),
                      ),
                    ),
                    if (title != null) Text(title!),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
