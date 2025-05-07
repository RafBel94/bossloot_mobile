import 'package:bossloot_mobile/providers/coin_exchange_provider.dart';
import 'package:bossloot_mobile/providers/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bossloot_mobile/providers/category_provider.dart';
import 'package:bossloot_mobile/providers/product_provider.dart';
import 'package:bossloot_mobile/screens/main_screen/main_screen.dart';

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
    _startAnimationsAndLoadData();
    }

    Future<void> _startAnimationsAndLoadData() async {
    _rotationController.forward();
    
    final startTime = DateTime.now();

    await _scaleController.forward();
    
    await _fadeTitleController.forward();
    
    final elapsed = DateTime.now().difference(startTime);
    final minDisplayDuration = const Duration(seconds: 3);
    
    if (elapsed < minDisplayDuration) {
      await Future.delayed(minDisplayDuration - elapsed);
    }

    await _initializeData();
    
    // Navigate to MainScreen
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen())
      );
    }
  }

  Future<void> _initializeData() async {
    final LanguageProvider languageProvider = context.read<LanguageProvider>();
    final coinExchangeProvider = context.read<CoinExchangeProvider>();
    final categoryProvider = context.read<CategoryProvider>();
    final productProvider = context.read<ProductProvider>();
    
    await languageProvider.initialize();
    await coinExchangeProvider.initialize();
    await productProvider.fetchCatalogProducts();
    await productProvider.fetchFeaturedProducts();
    await categoryProvider.fetchCategories();

    // Preload images
    await _preloadImages();
  }

  Future<void> _preloadImages() async {
    precacheImage(const AssetImage('assets/images/avatar-placeholder.png'), context);
    precacheImage(const AssetImage('assets/images/background-image-workshop.png'), context);
    precacheImage(const AssetImage('assets/images/background-image-workshop-2.png'), context);
    precacheImage(const AssetImage('assets/images/background-image-workshop-3.png'), context);
    precacheImage(const AssetImage('assets/images/bossloot-logo-full.png'), context);
    precacheImage(const AssetImage('assets/images/bossloot-logo-margin.png'), context);
    precacheImage(const AssetImage('assets/images/bossloot-title-only.png'), context);
    precacheImage(const AssetImage('assets/images/gnome-greetings.png'), context);
    precacheImage(const AssetImage('assets/images/gnome-greetings-2.png'), context);
    precacheImage(const AssetImage('assets/images/ladder-background.png'), context);
    precacheImage(const AssetImage('assets/images/loading-frame.png'), context);
    precacheImage(const AssetImage('assets/images/loading-image.png'), context);
    precacheImage(const AssetImage('assets/images/loading-image-2.png'), context);
    precacheImage(const AssetImage('assets/images/welcome-boss.gif'), context);

    const profileIconLoader = SvgAssetLoader('assets/icons/profile-icon.svg');
    svg.cache.putIfAbsent(profileIconLoader.cacheKey(null), () => profileIconLoader.loadBytes(null));
    const ordersIconLoader = SvgAssetLoader('assets/icons/orders-icon.svg');
    svg.cache.putIfAbsent(ordersIconLoader.cacheKey(null), () => ordersIconLoader.loadBytes(null));
    const favoritesIconLoader = SvgAssetLoader('assets/icons/favorites-icon.svg');
    svg.cache.putIfAbsent(favoritesIconLoader.cacheKey(null), () => favoritesIconLoader.loadBytes(null));
    const settingsIconLoader = SvgAssetLoader('assets/icons/settings-icon.svg');
    svg.cache.putIfAbsent(settingsIconLoader.cacheKey(null), () => settingsIconLoader.loadBytes(null));
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