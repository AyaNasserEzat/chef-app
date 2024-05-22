
import 'package:chef_app/core/local/app_local.dart';
import 'package:chef_app/core/utils/app_strings.dart';
import 'package:chef_app/core/widgets/custom_textButton.dart';
import 'package:flutter/material.dart';

class CustomAlerDialog extends StatelessWidget {
   CustomAlerDialog({
    super.key, required this.message, required this.confirmAction,
  });
final String message;
final VoidCallback confirmAction;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(message,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
      actions: [
        CustomTextButton(
          onPressed: confirmAction,
          text: AppStrings.ok.tr(context),
        ),
        CustomTextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          text: AppStrings.cancel.tr(context),
        ),
      ],
    );
  }
}
