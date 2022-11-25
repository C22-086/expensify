import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final pageController = PageController();

  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Flexible(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                scrollDirection: Axis.horizontal,
                children: [
                  _pageContent(
                      imageUrl: 'assets/onboarding_1.png',
                      title: 'Track your daily Expenses  ',
                      description:
                          'Daily note down your expenses to help you manage your income '),
                  _pageContent(
                      imageUrl: 'assets/onboarding_2.png',
                      title: 'Expenses Statistics',
                      description:
                          'Expense patterns are plotted in different types of chart based on date and time for easy understanding '),
                  _pageContent(
                    imageUrl: 'assets/onboarding_3.png',
                    title: 'Plan for your future',
                    description:
                        'Build healthy financial habits. Control unnecessary expenses',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _pageContent(
      {required String imageUrl,
      required String title,
      required String description}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          imageUrl,
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 16),
          ),
        ),
        const SizedBox(height: 81),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 3; i++)
              Padding(
                padding: const EdgeInsets.all(8),
                child: _dotsPageIndicator(
                  color: pageIndex == i
                      ? const Color(0xff42BC73)
                      : const Color(0xffE5E5E5),
                ),
              ),
          ],
        ),
        const SizedBox(height: 28),
        ElevatedButton(
          onPressed: () {
            if (pageController.page!.toInt() < 2) {
              nextPage();
            } else {
              Navigator.pushNamed(context, '/home');
            }
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(22),
            shape: const CircleBorder(),
            backgroundColor: const Color(0xff42BC73),
          ),
          child: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }

  Container _dotsPageIndicator({required Color color}) {
    return Container(
      height: 4,
      width: 30,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  void nextPage() {
    pageController.animateToPage(pageController.page!.toInt() + 1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
    setState(() {
      pageIndex = pageController.page!.toInt() + 1;
    });
  }
}
