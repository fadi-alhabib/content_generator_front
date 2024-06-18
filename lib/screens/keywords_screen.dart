import 'package:content_generator_front/constants.dart';
import 'package:content_generator_front/helpers.dart';
import 'package:content_generator_front/services/ai_api_service.dart';
import 'package:content_generator_front/widgets/circles_background.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class KeywordsScreen extends StatefulWidget {
  static String routeName = "/keywords";
  const KeywordsScreen({super.key});

  @override
  State<KeywordsScreen> createState() => _KeywordsScreenState();
}

class _KeywordsScreenState extends State<KeywordsScreen> {
  TextEditingController textEditingController = TextEditingController();
  List<String>? keywords = [];
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
                      "Generate Keywords",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const Gap(40),
                    TextFormField(
                      controller: textEditingController,
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
                        onPressed: () {
                          AiService.generateKeywords(
                                  description: textEditingController.text)
                              .then(
                            (value) {
                              setState(() {
                                keywords = value;
                              });
                              textEditingController.clear();
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
                    if (keywords!.isNotEmpty)
                      SizedBox(
                        height: screenSize.height * 0.3,
                        child: GridView.builder(
                          padding: const EdgeInsets.all(10),
                          itemCount: keywords!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 8 / 1),
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                  child: Text(
                                keywords![index],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: primaryColor),
                              )),
                            );
                          },
                        ),
                      )
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
