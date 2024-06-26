import 'package:content_generator_front/helpers.dart';
import 'package:content_generator_front/services/ai_service.dart';
import 'package:content_generator_front/widgets/circles_background.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ValidateTitleScreen extends StatefulWidget {
  static String routeName = "/validate-title";
  const ValidateTitleScreen({super.key});

  @override
  State<ValidateTitleScreen> createState() => _ValidateTitleScreenState();
}

class _ValidateTitleScreenState extends State<ValidateTitleScreen> {
  TextEditingController controller = TextEditingController();
  bool? isGood;
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
                      "Validate Your Title",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const Gap(40),
                    TextFormField(
                      controller: controller,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: "Enter the Title",
                      ),
                    ),
                    const Gap(20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          AiService.validateTitle(title: controller.text).then(
                            (value) => setState(() {
                              isGood = value;
                            }),
                          );
                        },
                        label: const Text("Submit"),
                        icon: const Icon(Icons.send),
                      ),
                    ),
                    if (isGood != null)
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: Text(
                          isGood! ? "Good Title" : "Bad Title",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: isGood! ? Colors.green : Colors.red,
                                  ),
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
