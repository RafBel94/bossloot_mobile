import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class DataLoadingScreen extends StatelessWidget{
  const DataLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            // Background image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/loading-image-2.png'),
                  fit: BoxFit.cover,
                  repeat: ImageRepeat.repeat
                ),
              )
            ),

            // Loading frame
            Center(
              child: Container(
                height: 180,
                width: 280,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/loading-frame.png'),
                    fit: BoxFit.fill,
                  ),
                )
              ),
            ),

            // Loading indicator
            Align(
              alignment: const Alignment(0, 0.13),
              child: SizedBox(
                height: 40,
                width: 40,
                child: LoadingIndicator(
                  indicatorType: Indicator.pacman, 
                  colors: const [Color.fromARGB(255, 215, 174, 52)],
                )
              ),
            )
          ],
        )
      ),
    );
  }
}