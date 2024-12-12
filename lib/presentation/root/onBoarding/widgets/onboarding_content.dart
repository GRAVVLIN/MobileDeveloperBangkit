import 'package:flutter/material.dart';
import '../../../../core/core.dart';
import '../models/onboarding_model.dart';

class OnboardingContent extends StatelessWidget {
  final PageController pageController;
  final void Function(int index) onPageChanged;
  final List<OnboardingModel> contents;

  const OnboardingContent({
    super.key,
    required this.pageController,
    required this.onPageChanged,
    required this.contents,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: pageController,
        onPageChanged: onPageChanged,
        itemCount: contents.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(40.0),
            child: index != 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .1,
                      ),
                      contents[index].image != null
                          ? Container(
                              height: MediaQuery.of(context).size.height * .3,
                              child: Image.asset(
                                contents[index].image ?? '',
                              ),
                            )
                          : SizedBox.shrink(),
                      const SizedBox(height: 20),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              contents[index].title,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).textScaler.scale(30),
                                color: AppColors.textColor,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              contents[index].desc,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).textScaler.scale(20),
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .1,
                      ),
                      const SizedBox(height: 20),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              contents[index].title,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).textScaler.scale(18),
                                color: AppColors.textColor,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            contents[index].image != null
                                ? Image.asset(
                                  contents[index].image ?? '',
                                  fit: BoxFit.cover,
                                )
                                : SizedBox.shrink(),
                            Text(
                              contents[index].desc,
                              style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).textScaler.scale(18),
                                color: AppColors.textColor,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
          );
        },
      ),
    );
  }
}
