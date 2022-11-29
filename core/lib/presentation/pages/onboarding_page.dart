import 'package:core/core.dart';
import 'package:core/presentation/widgets/onboarding_content.dart';
import 'package:flutter/material.dart';

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
        title: 'Lacak Pengeluaran harian Anda',
        description:
            'Catat setiap hari pengeluaran Anda untuk membantu Anda mengelola uang Anda'),
    const OnboardingContent(
        imageUrl: 'assets/onboarding_2.png',
        title: 'Statistik Pengeluaran',
        description:
            'Pola pengeluaran diplot dalam berbagai jenis bagan berdasarkan tanggal dan waktu agar mudah dipahami.'),
    const OnboardingContent(
      imageUrl: 'assets/onboarding_3.png',
      title: 'Rencanakan Masa Depan Anda',
      description:
          'Bangun kebiasaan finansial yang sehat. Kontrol pengeluaran yang tidak perlu',
    ),
  ];

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    OnboardingCubit onboardingCubit = OnboardingCubit(0);
    return Scaffold(
      body: StreamBuilder<int>(
        initialData: 0,
        stream: onboardingCubit.stream,
        builder: (context, snapshot) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                PageView.builder(
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
                                    snapshot.data == i ? kGreen : kGrey,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 28),
                      ElevatedButton(
                        onPressed: () {
                          if (snapshot.data == pageContent.length - 1) {
                            Navigator.pushReplacementNamed(context, '/login');
                          }

                          _pageController.animateToPage(
                            snapshot.data! + 1,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeIn,
                          );
                          onboardingCubit.nextPage();
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
