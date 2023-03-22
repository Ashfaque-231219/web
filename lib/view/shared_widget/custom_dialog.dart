import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web/helper/constants/colors.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/helper/constants/images.dart';
import 'package:web/helper/constants/string.dart';
import 'package:web/view/shared_widget/custom_label.dart';
import 'package:web/view/shared_widget/custom_raised_button.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({Key? key, this.text = '',this.width, this.doneAdmin = false}) : super(key: key);

  final String text;
  final double? width;
  final bool doneAdmin;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        width: width ?? MediaQuery.of(context).size.width * 0.32,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: doneAdmin,
              child: Padding(
                padding: EdgeInsets.only(top: appDimen.sp20),
                child: SvgPicture.asset(
                  appImages.doneDialog,
                  width: appDimen.sp60,
                  height: appDimen.sp60,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(appDimen.sp20),
              child: CustomLabel(
                text: text,
                size: appDimen.sp16,
                alignment: TextAlign.center,
              ),
            ),
            CustomRaisedButton(
                text: appString.okText,
                width: 100,
                color: Color(appColors.brown840000),
                onPressed: () {
                  Navigator.pop(context, true);
                }),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
