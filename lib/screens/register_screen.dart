import 'package:content_generator_front/constants.dart';
import 'package:content_generator_front/helpers.dart';
import 'package:content_generator_front/services/auth_service.dart';
import 'package:content_generator_front/widgets/button.dart';
import 'package:content_generator_front/widgets/circles_background.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenSize = getScreenSize(context);
    return Scaffold(
        body: CirclesBackground(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 45),
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.06),
            padding: EdgeInsets.symmetric(
                vertical: screenSize.height * 0.04,
                horizontal: screenSize.width * 0.04),
            decoration: BoxDecoration(
              border: Border.all(color: primaryColor, width: 3),
              borderRadius: BorderRadius.circular(20),
              color: primaryColor.withOpacity(0.1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: screenSize.width * 0.3,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Register",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        const Gap(50),
                        Text(
                          "Full Name",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Gap(10),
                        TextFormField(
                          controller: fullNameController,
                          validator: (val) =>
                              val!.isEmpty ? 'Full Name is Required' : null,
                          decoration: const InputDecoration(
                            hintText: "Full Name",
                          ),
                        ),
                        const Gap(20),
                        Text(
                          "Full Name",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Gap(10),
                        TextFormField(
                          controller: usernameController,
                          validator: (val) =>
                              val!.isEmpty ? 'Username is Required' : null,
                          decoration: const InputDecoration(
                            hintText: "username",
                          ),
                        ),
                        const Gap(20),
                        Text(
                          "Password",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Gap(10),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          validator: (val) =>
                              val!.isEmpty ? 'Password is Required' : null,
                          decoration: const InputDecoration(
                            hintText: "Password",
                          ),
                        ),
                        const Gap(30),
                        SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                AuthService.register(
                                        email: fullNameController.text,
                                        username: usernameController.text,
                                        password: passwordController.text)
                                    .then((value) => Navigator.of(context)
                                        .pushReplacementNamed('/login'))
                                    .onError((error, stackTrace) => null);
                              }
                            },
                            child: const Text("Register"),
                          ),
                        ),
                        const Gap(20),
                        Row(
                          children: [
                            Text(
                              "Already have an account?",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/login');
                              },
                              child: Text(
                                "Login",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: primaryColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                        .animate()
                        .fade(duration: 2.seconds)
                        .slideX(duration: 1.2.seconds)
                        .then()
                        .shimmer(duration: 1.5.seconds),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Image.asset(
                    "assets/images/login-banner.png",
                    fit: BoxFit.fill,
                  )
                      .animate()
                      .fade(duration: 2.seconds)
                      .slideY(duration: 1.2.seconds)
                      .then()
                      .shimmer(duration: 1.5.seconds),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
