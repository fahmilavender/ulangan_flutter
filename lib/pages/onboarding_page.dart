import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:ulangan_flutter/components/custom_button.dart';
import 'package:ulangan_flutter/components/onboarding_controller.dart';
import 'package:ulangan_flutter/routes/routes.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() => isLastPage = index == 2);
            },
            children: const [
              OnboardingContent(
                icon: Icons.checklist_rounded,
                title: "Todyapp",
                subtitle: "The best to do list application for you",
                bgColor: Colors.white,
              ),
              OnboardingContent(
                icon: Icons.list_alt_rounded,
                title: "Your convenience",
                subtitle: "Create task lists easier and faster.",
                bgColor: Colors.white,
              ),
              OnboardingContent(
                icon: Icons.task_alt,
                title: "Find practicality",
                subtitle: "Easy-to-understand UI that improves productivity.",
                bgColor: Colors.white,
              ),
            ],
          ),

          // Bottom section
          Positioned(
            bottom: 40,
            left: 20,
            right: 20,
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: const WormEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Color(0xFF24A19C), // 🔥 ganti ungu → teal
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                ),
                const SizedBox(height: 24),

                // ✅ Tombol pakai CustomButton (warnanya ambil dari widget)
                CustomButton(
                 myText : "Continue",
                  onPressed: () {
                    if (isLastPage) {
                      Get.offAllNamed(AppRoutes.loginPage);
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
