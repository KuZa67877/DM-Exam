import 'package:dmiti_project/res/colors.dart';
import 'package:flutter/material.dart';

ThemeData getTheme() => ThemeData(
    //primarySwatch: Colors.red,
    textTheme: const TextTheme(
        titleLarge: TextStyle(
          color: AppColors.black,
          fontFamily: 'WorkSans',
          fontSize: 36,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          color: AppColors.black,
          fontFamily: 'WorkSans',
          fontSize: 25,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
            color: AppColors.black,
            fontFamily: 'WorkSans',
            fontSize: 13,
            fontWeight: FontWeight.w200),
        bodySmall: TextStyle(
            color: AppColors.gray2,
            fontFamily: 'WorkSans',
            fontSize: 11,
            fontWeight: FontWeight.w200),
        bodyLarge: TextStyle(
          color: AppColors.gray1,
          fontFamily: "WorkSans",
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        labelSmall: TextStyle(
            //Последние два стиля  -> для кнопок
            color: AppColors.white,
            fontFamily: "WorkSans",
            fontSize: 16,
            fontWeight: FontWeight.bold),
        labelLarge: TextStyle(
            color: AppColors.red,
            fontFamily: "WorkSans",
            fontSize: 16,
            fontWeight: FontWeight.bold),
        headlineLarge: TextStyle(
            fontFamily: "Cygre",
            fontSize: 40,
            fontWeight: FontWeight.w900,
            color: AppColors.black)));
