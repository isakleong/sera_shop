import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sera_shop/screens/cart_screen.dart';
import 'dart:async';

import 'package:sera_shop/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      context.push("/login");
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.green),
            child: FutureBuilder<ImageInfo>(
              future: getOriginalSizeImage(
                Image.asset(
                  "assets/images/bg_splash.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              builder:
                  (BuildContext context, AsyncSnapshot<ImageInfo> snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    width: snapshot.data!.image.width.toDouble(),
                    height: (snapshot.data!.image.height / snapshot.data!.image.width) * (width + 30),
                    child: Image.asset(
                      "assets/images/bg_splash.jpg",
                      fit: BoxFit.cover,
                    ),
                  );
                } else {
                  return Image.asset(
                    "assets/images/bg_splash.jpg",
                    fit: BoxFit.cover,
                  );
                }
              },
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: height * 0.3, // Adjust height
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Center(
                child: Hero(
                  tag: "logo",
                  child: Image.asset(
                    "assets/images/logo.png",
                    fit: BoxFit.cover,
                    width: width * 0.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
