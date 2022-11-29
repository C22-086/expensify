import 'package:core/core.dart';
import 'package:core/presentation/widgets/onboarding_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/dots_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  final pageContent = [
    const OnboardingContent(
        imageUrl: 'assets/onboarding_1.png',
        title: 'Track your daily Expenses  ',
        description:
            'Daily note down your expenses to help you manage your income '),
    const OnboardingContent(
        imageUrl: 'assets/onboarding_2.png',
        title: 'Expenses Statistics',
        description:
            'Expense patterns are plotted in different types of chart based on date and time for easy understanding '),
    const OnboardingContent(
      imageUrl: 'assets/onboarding_3.png',
      title: 'Plan for your future',
      description:
          'Build healthy financial habits. Control unnecessary expenses',
    ),
  ];

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                PageView.builder(
                  onPageChanged: (value) {
                    state.pageIndex = value;
                  },
                  controller: _pageController,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: pageContent.length,
                  itemBuilder: (context, index) {
                    return pageContent[index];
                  },
                ),
                Positioned(
                  bottom: 65,
                  left: 0,
                  right: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < 3; i++)
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: DotsIndicator(
                                backgroundColor:
                                    state.pageIndex == i ? kGreen : kGrey,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      ElevatedButton(
                        onPressed: () {
                          if (state.pageIndex == pageContent.length - 1) {
                            Navigator.pushNamed(context, '/set-balance');
                          }
                          context.read<OnboardingCubit>().nextPage();
                          _pageController.animateToPage(
                            state.pageIndex + 1,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeIn,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(22),
                          shape: const CircleBorder(),
                        ),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: kWhite,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
