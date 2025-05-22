import 'package:flutter/material.dart';
import 'package:pinterest_downloader/screens/language_setup_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Image.asset('assets/intro1.jpeg', fit: BoxFit.cover),
    Image.asset('assets/intro2.jpeg', fit: BoxFit.cover),
    const LanguageSetupScreen(),
  ];

  void _nextPage() {
    if (_currentIndex < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  Widget _buildDotIndicator(int index) {
    bool isActive = index == _currentIndex;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      height: 12,
      width: isActive ? 24 : 12,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFFFA000) : const Color(0xFFFFCDD2),
        borderRadius: BorderRadius.circular(12),
        boxShadow:
            isActive
                ? [
                  BoxShadow(
                    color: const Color(0xFFE53935).withOpacity(0.6),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
                : [],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemCount: _pages.length,
            itemBuilder: (_, index) => SizedBox.expand(child: _pages[index]),
          ),
          if (_currentIndex < _pages.length - 1)
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Dot indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => _buildDotIndicator(index),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Next button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 34),
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFA000),
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
