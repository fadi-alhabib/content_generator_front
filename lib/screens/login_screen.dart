import 'package:content_generator_front/constants.dart';
import 'package:content_generator_front/helpers.dart';
import 'package:content_generator_front/services/auth_service.dart';
import 'package:content_generator_front/widgets/button.dart';
import 'package:content_generator_front/widgets/circles_background.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showError = false;
  bool isLoading = false;
  String errorMessage = '';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final screenSize = getScreenSize(context);
    return Scaffold(
        body: CirclesBackground(
      child: Center(
        child: Container(
          height: screenSize.height * 0.9,
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
                        "Login",
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      const Gap(100),
                      if (showError)
                        Column(
                          children: [
                            Text(
                              errorMessage,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: Colors.red),
                            ),
                            const Gap(30),
                          ],
                        ),
                      Text(
                        "username",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Gap(10),
                      TextFormField(
                        controller: usernameController,
                        // validator: (val) => EmailValidator.validate(val!)
                        //     ? null
                        //     : "Please enter a valid email",
                        validator: (val) =>
                            val!.isEmpty ? 'username is Required' : null,
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
                          onPressed: isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    print(usernameController.text);
                                    print(passwordController.text);
                                    AuthService.login(
                                            username: usernameController.text,
                                            password: passwordController.text)
                                        .then((value) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                      return Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        '/home',
                                        (route) => false,
                                      );
                                    }).onError(
                                            (error, stackTrace) => setState(() {
                                                  showError = true;
                                                  errorMessage =
                                                      "Username or Password is Invalid";
                                                  isLoading = false;
                                                }));
                                  }
                                },
                          child: isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : const Text("Login"),
                        ),
                      ),
                      const Gap(20),
                      Row(
                        children: [
                          Text(
                            "Don't have an account?",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: Text(
                              "Register",
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
    ));
  }
}
