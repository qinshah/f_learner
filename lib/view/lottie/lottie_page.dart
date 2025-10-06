import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottiePage extends StatefulWidget {
  const LottiePage({super.key});

  @override
  State<LottiePage> createState() => _LottiePageState();
}

class _LottiePageState extends State<LottiePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lottie动画')),
      body: ListView(
        children: [
          // Load a Lottie file from your assets
          Lottie.asset(
            'assets/LottieLogo1.json',
            frameRate: FrameRate.max,
          ),
          // Load an animation and its images from a zip file
          Lottie.asset(
            'assets/lottiefiles/angel.zip',
            frameRate: FrameRate.max,
          ),
        ],
      ),
    );
  }
}
