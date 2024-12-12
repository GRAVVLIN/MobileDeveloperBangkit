import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class OnboardingIndicator extends StatelessWidget {
  final int length;
  final int currentPage;

  const OnboardingIndicator({
    super.key,
    required this.length,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: currentPage == index
                    ? AppColors.black
                    : AppColors.transparent,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: AppColors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
