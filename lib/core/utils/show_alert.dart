import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

Future<bool?> showAlert({
  required BuildContext context,
  required String message,
  DialogType dialogType = DialogType.info,
  VoidCallback? btnOkOnPress,
  bool autoDismiss = false,
}) async {
  bool? result;
  
  await AwesomeDialog(
    context: context,
    dialogType: dialogType,
    animType: AnimType.scale,
    title: dialogType == DialogType.error ? 'Error' : 'Success',
    desc: message,
    dismissOnTouchOutside: dialogType != DialogType.warning,
    dismissOnBackKeyPress: dialogType != DialogType.warning,
    onDismissCallback: (type) {
      if (dialogType == DialogType.success || autoDismiss) {
        result = true;
        if (btnOkOnPress != null) {
          btnOkOnPress();
        }
      }
    },
    btnOkOnPress: () {
      result = true;
      if (btnOkOnPress != null) {
        btnOkOnPress();
      }
    },
    btnCancelOnPress: dialogType == DialogType.warning ? () {
      result = false;
    } : null,
    autoHide: dialogType == DialogType.success || autoDismiss 
        ? const Duration(seconds: 3) 
        : null,
  ).show();

  return result;
}
