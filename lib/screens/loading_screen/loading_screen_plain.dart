import 'package:bossloot_mobile/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

class LoadingScreenPlain extends StatefulWidget {
  const LoadingScreenPlain({super.key});

  @override
  State<LoadingScreenPlain> createState() => _LoadingScreenPlainState();
}

class _LoadingScreenPlainState extends State<LoadingScreenPlain>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  late AnimationController _fadeTitleController;
  
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeTitleAnimation;

  @override
  void initState() {
    super.initState();
    // Configuration for the rotation animation (1 full spin)
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    // Configuration for the scale animation (heartbeat effect)
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    
    // Configuration for the title fade-in animation
    _fadeTitleController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    // Rotation animation (0 to 1 = 360 degrees)
    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
      parent: _rotationController,
      curve: Curves.easeInOut,
      ),
    );
    
    // Scale animation (1 → 1.2 → 1)
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.2), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 50),
    ]).animate(_scaleController);
    
    // Fade animation for the title
    _fadeTitleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
      parent: _fadeTitleController,
      curve: Curves.easeIn,
      ),
    );
    
    // Start animations and load data
    _startAnimations();
    }

    Future<void> _startAnimations() async {
    // 1. Start rotation
    _rotationController.forward();
    
    // 2. Load data while the animation is displayed
    final startTime = DateTime.now();

    // 3. Start heartbeat effect
    await _scaleController.forward();
    
    // 4. Show title with fade-in effect
    await _fadeTitleController.forward();
    
    // 5. Ensure minimum display time
    final elapsed = DateTime.now().difference(startTime);
    final minDisplayDuration = const Duration(seconds: 3);
    
    if (elapsed < minDisplayDuration) {
      await Future.delayed(minDisplayDuration - elapsed);
    }
    
    // 6. Navigate to MainScreen
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen(withPageIndex: 4,))
      );
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _scaleController.dispose();
    _fadeTitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background-image-workshop-3.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: Listenable.merge([_rotationAnimation, _scaleAnimation]),
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationAnimation.value * 2 * 3.1416,
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Image.asset(
                        'assets/images/bossloot-logo-margin.png',
                        height: 150,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              FadeTransition(
                opacity: _fadeTitleAnimation,
                child: Image.asset(
                  'assets/images/bossloot-title-only.png',
                  height: 42,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}