import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:web/helper/constants/colors.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/helper/constants/images.dart';
import 'package:web/helper/constants/size_constants.dart';
import 'package:web/view/shared_widget/custom_label.dart';
import 'package:web/view/shared_widget/custom_raised_button.dart';

import '../../../helper/constants/color_constants.dart';
import '../../../helper/constants/font_family.dart';
import '../../../helper/constants/image_constants.dart';
import '../../../helper/constants/string_constants.dart';
import '../../../view-model/authBloc/login_bloc.dart';
import '../../../view-model/authBloc/login_event.dart';
import '../../shared_widget/redwood_logo_screen.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  bool obscureNew = true;
  bool obscureConfirm = true;

  triggerAddItemEvent(LoginEvent event) {
    context.read<LoginBloc>().add(event);
  }

  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmNewPassword = TextEditingController();
  final _userformKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return LayoutBuilder(builder: (BuildContext ctx, BoxConstraints constraints) {
      if (width > SizeConstants.tabWidth) {
        return Scaffold(
          body: Stack(children: [
            Row(
              children: [
                const LogoScreen(),
                Container(
                  width: width * 0.5,
                  height: height,
                  color: Colors.white,
                  child: Center(
                    child: SizedBox(
                      width: width * 0.3,
                      height: height * 0.5,
                      child: Column(
                        children: [
                          SizedBox(width: width * 0.05, height: height * 0.1, child: Image.asset(ImageConstants.resetPassImage)),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Text(
                            StringConstants.resetPassword,
                            style: TextStyle(
                                fontSize: width * 0.012, fontFamily: FontFamily.montserrat, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Container(
                            width: width - 50,
                            height: height * 0.08,
                            color: Colors.white,
                            child: TextFormField(
                              obscureText: obscureNew,
                              controller: _newPassword,
                              cursorColor: ColorConstants.darkBrown,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscureNew = !obscureNew;
                                      });
                                    },
                                    icon: obscureNew == false
                                        ? Icon(Icons.visibility, size: height * 0.04)
                                        : Icon(Icons.visibility_off, size: height * 0.04)),
                                hintText: StringConstants.newPassword,
                                hintStyle: TextStyle(
                                  fontSize: width * 0.013,
                                  fontFamily: FontFamily.montserrat,
                                ),
                                labelText: StringConstants.newPassword,
                                labelStyle: TextStyle(
                                  fontSize: width * 0.013,
                                  fontFamily: FontFamily.montserrat,
                                ),
                                border: const OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorConstants.darkBrown)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "New Password is mandatory";
                                }else {
                                  return '';
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Container(
                            width: width - 50,
                            height: height * 0.08,
                            color: Colors.white,
                            child: TextFormField(
                              obscureText: obscureConfirm,
                              onFieldSubmitted: (value) {
                                triggerAddItemEvent(
                                    ResetPassEvent(context: context, newPass: _newPassword.text, confirmPass: _confirmNewPassword.text));
                              },
                              controller: _confirmNewPassword,
                              cursorColor: ColorConstants.darkBrown,
                              decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          obscureConfirm = !obscureConfirm;
                                        });
                                      },
                                      icon: obscureConfirm == false
                                          ? Icon(
                                              Icons.visibility,
                                              size: height * 0.04,
                                            )
                                          : Icon(
                                              Icons.visibility_off,
                                              size: height * 0.04,
                                            )),
                                  hintText: StringConstants.confirmNewPassword,
                                  hintStyle: TextStyle(
                                    fontSize: width * 0.013,
                                    fontFamily: FontFamily.montserrat,
                                  ),
                                  labelText: StringConstants.confirmNewPassword,
                                  labelStyle: TextStyle(
                                    fontSize: width * 0.013,
                                    fontFamily: FontFamily.montserrat,
                                  ),
                                  border: const OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorConstants.darkBrown))),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Confirm Password is mandatory";
                                }else {
                                  return '';
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          GestureDetector(
                            onTap: () {
                              triggerAddItemEvent(
                                  ResetPassEvent(context: context, newPass: _newPassword.text, confirmPass: _confirmNewPassword.text));
                            },
                            child: Container(
                              width: width * 0.22,
                              height: height * 0.06,
                              decoration: BoxDecoration(color: ColorConstants.darkBrown, borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text(
                                  "Confirm",
                                  style: TextStyle(color: Colors.white, fontSize: width * 0.01, fontFamily: FontFamily.montserrat),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: () {
                context.router.navigateBack();
              },
              child: Container(
                margin: EdgeInsets.only(left: width * 0.02, top: width * 0.02),
                width: width * 0.04,
                height: width * 0.04,
                child: SvgPicture.asset(
                  appImages.backBlack,
                  color: Colors.white,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ]),
        );
      } else {
        return Scaffold(
            body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(height * 0.03),
              child: SingleChildScrollView(
                child: Form(
                  key: _userformKey,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    GestureDetector(
                      onTap: () {
                        int count = 0;
                        Navigator.of(context).popUntil((_) => count++ >= 2);
                      },
                      child: SvgPicture.asset(
                        appImages.backBlack,
                        color: Color(appColors.brown840000),
                        width: appDimen.sp40,
                        height: appDimen.sp40,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.1,
                    ),
                    Align(alignment: Alignment.center, child: Image.asset(ImageConstants.resetPassImage)),
                    SizedBox(
                      height: height * 0.033,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: CustomLabel(
                        text: 'Reset  Password',
                        size: appDimen.sp21,
                        fontWeight: FontWeight.w600,
                        fontFamily: FontFamily.montserrat,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: width * 0.8,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Enter Confirm Password",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(appColors.greyA5A5A5),
                              ),
                            ),
                          ),
                          controller: _newPassword,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'New  Password is required.';
                            } else if (value.length > 15) {
                              return 'The password must be at least 8 to 15 characters.';
                            }else {
                              return '';
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.025,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: width * 0.8,
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Enter Confirm Password",
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(appColors.greyA5A5A5),
                              ),
                            ),
                          ),
                          controller: _confirmNewPassword,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'New Confirm Password is required.';
                            } else if (value.length > 15) {
                              return 'The password must be at least 8 to 15 characters.';
                            }else {
                              return '';
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.052,
                    ),
                    CustomRaisedButton(
                      onPressed: () async {
                        if (_userformKey.currentState!.validate()) {
                          triggerAddItemEvent(ResetPassEvent(context: context, newPass: _newPassword.text, confirmPass: _confirmNewPassword.text));
                        }
                      },
                      color: ColorConstants.darkBrown,
                      text: 'Save',
                      size: appDimen.sp16,
                      textColor: Colors.white,
                      height: height * 0.07,
                      width: width * 0.97,
                      fontFamily: FontFamily.montserrat,
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ));
      }
    });
  }
}
