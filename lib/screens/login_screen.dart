import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:sera_shop/bloc/auth_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sera_shop/screens/home_screen.dart';
import 'package:sera_shop/widgets/sera_textfield.dart';

Future<ImageInfo> getOriginalSizeImage(Image image) async {
  Completer<ImageInfo> completer = Completer();
  image.image
      .resolve(const ImageConfiguration())
      .addListener(ImageStreamListener((ImageInfo info, bool _) {
    completer.complete(info);
  }));
  ImageInfo imageInfo = await completer.future;
  return imageInfo;
}

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailNode = FocusNode();
  final FocusNode passwordNode = FocusNode();

  final ValueNotifier<bool> isFormValid = ValueNotifier(false);

  LoginScreen({super.key}) {
    emailController.addListener(validateForm);
    passwordController.addListener(validateForm);
  }

  void validateForm() {
    final emailFilled = emailController.text.isNotEmpty;
    final passwordFilled = passwordController.text.isNotEmpty;
    isFormValid.value = emailFilled && passwordFilled;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.green),
            child: FutureBuilder<ImageInfo>(
              future: getOriginalSizeImage(
                Image.asset(
                  "assets/images/bg_login.png",
                  fit: BoxFit.cover,
                ),
              ),
              builder:
                  (BuildContext context, AsyncSnapshot<ImageInfo> snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    width: snapshot.data!.image.width.toDouble(),
                    height: snapshot.data!.image.height.toDouble(),
                    child: Image.asset(
                      "assets/images/bg_login.png",
                      fit: BoxFit.cover,
                    ),
                  );
                } else {
                  return Image.asset(
                    "assets/images/bg_login.png",
                    fit: BoxFit.cover,
                  );
                }
              },
            ),
          ),
          Positioned(
            bottom: 30,
            right: 10,
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.cover,
              width: width * 0.25,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SvgPicture.asset(
                    'assets/images/asset_login.svg',
                    width: width * 0.7,
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      BlocListener<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is AuthenticatedState) {
                            context.push('/home');
                          } else if (state is AuthErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(color: Colors.teal, width: 1),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                content: Text(state.error),
                                backgroundColor: Colors.teal,
                                duration: const Duration(seconds: 4),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        },
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            bool isAuthLoading = state is AuthLoadingState;

                            return Column(
                              children: [
                                SeraTextfield(
                                  label: "Email",
                                  controller: emailController,
                                  focusNode: emailNode,
                                  fillColor: const Color(0xFF00cece).withOpacity(0.1),
                                  labelColor: Colors.black,
                                  cursorColor: Colors.teal,
                                  textInputAction: TextInputAction.next,
                                ),
                                const SizedBox(height: 16),
                                SeraTextfield(
                                  label: "Password",
                                  controller: passwordController,
                                  focusNode: passwordNode,
                                  fillColor: const Color(0xFF00cece).withOpacity(0.1),
                                  labelColor: Colors.black,
                                  cursorColor: Colors.teal,
                                  obscureText: true,
                                  textInputAction: TextInputAction.done,
                                ),
                                const SizedBox(height: 30),
                                ValueListenableBuilder<bool>(
                                  valueListenable: isFormValid,
                                  builder: (context, isEnabled, child) {
                                    return Row(
                                      children: [
                                        Expanded(
                                          child: FilledButton(
                                            onPressed: isEnabled && !isAuthLoading
                                                ? () {
                                                    context.read<AuthBloc>().add(
                                                      LoginEvent(
                                                        email: emailController.text,
                                                        password: passwordController.text,
                                                      ),
                                                    );
                                                  }
                                                : null,
                                            child: isAuthLoading
                                                ? SizedBox(
                                                    width: width,
                                                    height: 60,
                                                    child: Lottie.asset(
                                                      "assets/animations/loading.json",
                                                      width: MediaQuery.of(context).size.width
                                                    ),
                                                )
                                                : const Text(
                                                  'Masuk',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: "Inter",
                                                    fontSize: 18,
                                                  ),
                                                ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
