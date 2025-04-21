import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
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
    
    // Configuración para la animación de rotación (1 giro completo)
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    // Configuración para la animación de escala (latido)
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    
    // Configuración para el fade in del título
    _fadeTitleController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    // Animación de rotación (0 a 1 = 360 grados)
    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _rotationController,
        curve: Curves.easeInOut,
      ),
    );
    
    // Animación de escala (1 → 1.2 → 1)
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.2), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 50),
    ]).animate(_scaleController);
    
    // Animación de fade para el título
    _fadeTitleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _fadeTitleController,
        curve: Curves.easeIn,
      ),
    );
    
    // Secuencia de animaciones
    _startAnimations();
  }

  Future<void> _startAnimations() async {
    // 1. Iniciar rotación
    await _rotationController.forward();
    
    // 2. Iniciar efecto de latido
    await _scaleController.forward();
    
    // 3. Mostrar título con fade in
    _fadeTitleController.forward();
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 36, 1, 60),
              const Color.fromARGB(255, 62, 11, 48)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
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