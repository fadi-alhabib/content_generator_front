import 'package:content_generator_front/helpers.dart';
import 'package:content_generator_front/models/video_rating_model.dart';
import 'package:content_generator_front/services/ai_service.dart';
import 'package:content_generator_front/widgets/circles_background.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pie_chart/pie_chart.dart';

class RatingScreen extends StatefulWidget {
  static String routeName = "/rating";
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  final TextEditingController controller = TextEditingController();
  VideoRatingModel? rating;
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
                      "Generate Rating",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const Gap(40),
                    TextFormField(
                      controller: controller,
                      maxLines: null,
                      decoration: const InputDecoration(
                        hintText: "Enter Video URL",
                      ),
                    ),
                    const Gap(20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          AiService.generateRating(url: controller.text).then(
                            (value) => setState(() {
                              rating = value;
                            }),
                          );
                        },
                        label: const Text("Submit"),
                        icon: const Icon(Icons.send),
                      ),
                    ),
                    const Gap(50),
                    if (rating != null)
                      SizedBox(
                        height: screenSize.height * 0.4,
                        child: PieChart(
                          totalValue: 100,
                          colorList: const [Colors.green, Colors.red],
                          dataMap: {
                            "Positive": rating!.positivePercentage!.toDouble(),
                            "Negative": rating!.positivePercentage!.toDouble(),
                          },
                          chartValuesOptions: ChartValuesOptions(
                            chartValueStyle:
                                Theme.of(context).textTheme.titleLarge!,
                            showChartValueBackground: false,
                            showChartValuesInPercentage: true,
                            decimalPlaces: 1,
                          ),
                        ),
                      ),
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
