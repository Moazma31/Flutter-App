import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../widgets/floating_background.dart';
import 'login_screen.dart';

class OnboardPage {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const OnboardPage({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });
}

const onboardPages = [
  OnboardPage(
    icon: Icons.search_rounded,
    title: 'Lost something?',
    subtitle: 'Post it in seconds and let the whole campus help you find it.',
    color: AppColors.teal,
  ),
  OnboardPage(
    icon: Icons.map_rounded,
    title: 'Pinpoint it on campus',
    subtitle: 'Tag the exact spot where it was lost or found, so searching is quick.',
    color: AppColors.green,
  ),
  OnboardPage(
    icon: Icons.verified_user_rounded,
    title: 'Verified claims',
    subtitle: 'Only the real owner can claim an item, by answering a secret question.',
    color: AppColors.purple,
  ),
  OnboardPage(
    icon: Icons.shield_rounded,
    title: 'Your privacy, protected',
    subtitle: 'Your phone number is never shown. Talk safely through secure in-app chat.',
    color: AppColors.blue,
  ),
  OnboardPage(
    icon: Icons.emoji_events_rounded,
    title: 'Become a Campus Hero',
    subtitle: 'Return items to their owners and earn points and badges.',
    color: AppColors.amber,
  ),
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _index = 0;

  bool get _isLast => _index == onboardPages.length - 1;

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  void _next() {
    if (_isLast) {
      _goToLogin();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = onboardPages[_index].color;

    return Scaffold(
      body: FloatingBackground(
        color: color,
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _goToLogin,
                  child: const Text('Skip'),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: onboardPages.length,
                  onPageChanged: (i) => setState(() => _index = i),
                  itemBuilder: (context, i) =>
                      PageContent(page: onboardPages[i]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardPages.length,
                      (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: i == _index ? 28 : 8,
                    decoration: BoxDecoration(
                      color: i == _index ? color : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _next,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      _isLast ? 'Get Started' : 'Next',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PageContent extends StatelessWidget {
  final OnboardPage page;
  const PageContent({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 190,
            height: 190,
            decoration: BoxDecoration(
              color: page.color.withAlpha(30),
              shape: BoxShape.circle,
            ),
            child: Icon(page.icon, size: 90, color: page.color),
          ),
          const SizedBox(height: 48),
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            page.subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              height: 1.5,
              color: AppColors.textGrey,
            ),
          ),
        ],
      ),
    );
  }
}