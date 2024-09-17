import 'package:customer_app/configurations/constants/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'appColors.dart';
import 'constants/assetsStrings.dart';

class AppStyles {
  /*
 * Below Text Styles will have fixed font size.
 * But boldness, font family  & Color Can be Customizable.
 *
 */

  /*
 * Below Text Styles will have fixed thickness.
 * But font size ,family & Color Can be Customizable.
 *
 * Bold      = w700
 * semiBold  = w600
 * regular   = w400
 * light     = w300
 * extraBold = w800
 *
 *
  */

  /*
  *
  * Below TextStyle is FreeHand Style
  * All Params can changed accordingly
  *
  * */

/*
  *
  * Strongly Recommend to create new styles as per design requirments for easy access.
  *
  * */

  /// For App Bar Title Text
  static appBarTitleText({
    Color? color,
    String? fontFamily,
  }) {
    return TextStyle(
      color: color ?? AppColors.primaryWhiteColor,
      fontSize: Constants.largeFont,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontFamily: fontFamily ?? AppFonts.primaryFont,
    );
  }

  /// TextField Stile
  static textFieldTitleText({
    Color? color,
    String? fontFamily,
  }) {
    return TextStyle(
      color: color ?? AppColors.greyShade,
      fontSize: Constants.font16,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontFamily: fontFamily ?? AppFonts.primaryFont,
    );
  }

  /// Bottom Text Style
  static subTitleStyle({
    Color? color,
    String? fontFamily,
  }) {
    return TextStyle(
      color: color ?? AppColors.primaryBlackColor,
      fontSize: Constants.font16,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontFamily: fontFamily ?? AppFonts.primaryFont,
    );
  }

  /// Buttons Texts
  static buttonTitleText({
    Color? color,
    String? fontFamily,
  }) {
    return TextStyle(
      color: color ?? AppColors.primaryBlueColor,
      fontSize: Constants.normalFont,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontFamily: fontFamily ?? AppFonts.primaryFont,
    );
  }

  /// Swipe Title Text Style
  static swipeTitleText({
    Color? color,
    String? fontFamily,
  }) {
    return TextStyle(
      color: color ?? AppColors.greyShade,
      fontSize: Constants.font15,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontFamily: fontFamily ?? AppFonts.primaryFont,
    );
  }

  /// List View Text
  static listTitleText({
    Color? color,
    String? fontFamily,
  }) {
    return TextStyle(
      color: color ?? AppColors.primaryBlueColor,
      fontSize: Constants.font16,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontFamily: fontFamily ?? AppFonts.primaryFont,
    );
  }

  /// List View Sub Title
  static listSubTitleText({
    Color? color,
    String? fontFamily,
  }) {
    return TextStyle(
      color: color ?? AppColors.greyShade,
      fontSize: Constants.normalFont,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      fontFamily: fontFamily ?? AppFonts.primaryFont,
    );
  }
}
