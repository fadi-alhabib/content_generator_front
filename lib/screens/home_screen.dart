import 'package:content_generator_front/constants.dart';
import 'package:content_generator_front/services/auth_service.dart';
import 'package:content_generator_front/widgets/circles_background.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
              return InkWell(
                onTap: () => Navigator.of(context)
                    .pushNamed(containers[index]["routeName"]),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: containers[index]["border"], width: 2.0),
                      borderRadius: BorderRadius.circular(15),
                      color: containers[index]["body"]),
                  child: Column(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Lottie.asset(containers[index]["icon"],
                              fit: BoxFit.cover)),
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
