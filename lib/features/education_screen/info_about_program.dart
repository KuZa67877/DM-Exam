import 'package:dmiti_project/res/text.dart';
import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';

class MainInfo extends StatelessWidget {
  const MainInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Text(AppStrings.mainInfo,
                      style: getTheme().textTheme.bodyLarge),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(AppStrings.mainInfo1,
                  style: getTheme().textTheme.bodyLarge),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Text(AppStrings.educationInfo,
                  style: getTheme().textTheme.bodyLarge),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Text(AppStrings.studyInfo,
                  style: getTheme().textTheme.bodyLarge),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Text(AppStrings.testInfo,
                  style: getTheme().textTheme.bodyLarge),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Text(AppStrings.profileInfo,
                  style: getTheme().textTheme.bodyLarge),
            ),
            Text(AppStrings.questions, style: getTheme().textTheme.bodyLarge),
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Text(AppStrings.asnwers1,
                  style: getTheme().textTheme.bodyLarge),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Text(AppStrings.asnwers2,
                  style: getTheme().textTheme.bodyLarge),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Text(AppStrings.answers3,
                  style: getTheme().textTheme.bodyLarge),
            )
          ],
        ),
      ),
    );
  }
}
