import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_app/presentation/resources/color_manager.dart';
import 'package:weather_app/presentation/resources/font_manager.dart';
import 'package:weather_app/presentation/resources/strings_manager.dart';
import 'package:weather_app/presentation/resources/values_manager.dart';
import 'package:intl/intl.dart' as intl;

class Methods {

  static void showToastMessage(String message, {Color? toastColor}) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: toastColor ?? ColorManager.defaultPrimaryColor,
      fontSize: FontSize.s18,
    );
  }

  static Future<bool> showAskDialog(BuildContext context, String title, String text, {bool isYesOrNo = false, bool isCancelOnly = false}) async {
    return (
      await (showDialog(
        context: context,
        builder: (context) => AlertDialog(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(AppSize.s10))),
          title: Text(title, style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorManager.black)),
          titlePadding: const EdgeInsets.only(left: AppPadding.p16, right: AppPadding.p16, top: AppPadding.p16, bottom: AppPadding.p8),
          content: Text(text, style: Theme.of(context).textTheme.titleSmall!.copyWith(color: ColorManager.grey1)),
          contentPadding: const EdgeInsets.only(left: AppPadding.p16, right: AppPadding.p16, bottom: AppPadding.p8),
          actions: [
            if (isYesOrNo) TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(StringManager.no, style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold)),
            ),
            if (isYesOrNo) TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(StringManager.yes, style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold)),
            ),

            if (isCancelOnly) TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(StringManager.cancel, style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ))
    ) ?? false;
  }

  static Future<bool> checkConnectivityState() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi) {return true;}
    else if (result == ConnectivityResult.mobile) {return true;}
    else {return false;}
  }

  static String formatDate(String date, String format) {
    DateTime dateTime = DateTime(
      int.parse(date.split('-')[0]),
      int.parse(date.split('-')[1]),
      int.parse(date.split('-')[2].substring(0, 2)),
      int.parse(date.split(' ')[1].split(':')[0]),
      int.parse(date.split(' ')[1].split(':')[1]),
    );
    return intl.DateFormat(format).format(dateTime);
  }
}