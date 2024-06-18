import 'package:content_generator_front/helpers.dart';
import 'package:content_generator_front/widgets/circles_background.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ValidateTitleScreen extends StatelessWidget {
  static String routeName = "/validate-title";
  const ValidateTitleScreen({super.key});

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
                        onPressed: () {},
                        label: const Text("Submit"),
                        icon: const Icon(Icons.send),
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
