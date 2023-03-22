import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/helper/constants/images.dart';
import 'package:web/helper/constants/size_constants.dart';
import 'package:web/helper/utils/utils.dart';
import 'package:web/route_generator.dart';
import 'package:web/view/shared_widget/custom_label.dart';
import 'package:web/view/shared_widget/custom_password_field.dart';
import 'package:web/view/shared_widget/custom_raised_button.dart';

import '../../../helper/constants/color_constants.dart';
import '../../../helper/constants/font_family.dart';
import '../../../helper/constants/image_constants.dart';
import '../../../view-model/authBloc/login_bloc.dart';
import '../../../view-model/authBloc/login_event.dart';
import '../../shared_widget/redwood_logo_screen.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool obscureNew = true;
  bool obscureOld = true;
  bool obscureConfirm = true;

  final _userFormKey = GlobalKey<FormState>();

  final TextEditingController _oldText = TextEditingController();
  final TextEditingController _passText = TextEditingController();
  final TextEditingController _confirmText = TextEditingController();
  final TextEditingController _oldPassMobile = TextEditingController();
  final TextEditingController _newPassMobile = TextEditingController();
  final TextEditingController _confirmPassMobile = TextEditingController();

  triggerAddItemEvent(LoginEvent event) {
    context.read<LoginBloc>().add(event);
  }

  Future<bool> onWillPop() {
    Navigator.pushNamedAndRemoveUntil(context, RoutesConst.homePage, (route) => false);
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: onWillPop,
      child: LayoutBuilder(builder: (BuildContext ctx, BoxConstraints constraints) {
        if (width > SizeConstants.tabWidth) {
          return Scaffold(
              body: Stack(children: [
            GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: SizedBox(
                  height: height,
                  width: width,
                  child: Row(
                    children: [
                      const LogoScreen(),
                      Container(
                        height: height,
                        width: width * 0.5,
                        color: Colors.white,
                        child: Center(
                            child: SizedBox(
                          width: width * 0.35,
                          height: height * 0.6,
                          child: Column(
                            children: [
                              SizedBox(
                                width: width,
                                height: height * 0.08,
                                child: Center(
                                  child: Text(
                                    "Create New Password",
                                    style: TextStyle(fontSize: width * 0.013, fontFamily: FontFamily.montserrat, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.012,
                              ),
                              Form(
                                child: Container(
                                  width: width,
                                  height: height * 0.1,
                                  color: Colors.white,
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    obscureText: obscureOld,
                                    controller: _oldText,
                                    cursorColor: ColorConstants.darkBrown,
                                    decoration: InputDecoration(
                                        hoverColor: ColorConstants.darkBrown,
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                obscureOld = !obscureOld;
                                              });
                                            },
                                            icon: obscureOld == false
                                                ? Icon(
                                                    Icons.visibility,
                                                    size: height * 0.04,
                                                  )
                                                : Icon(
                                                    Icons.visibility_off,
                                                    size: height * 0.04,
                                                  )),
                                        hintText: "Enter Current password",
                                        hintStyle: TextStyle(
                                          fontSize: width * 0.013,
                                          fontFamily: FontFamily.montserrat,
                                        ),
                                        labelText: "Current password",
                                        labelStyle: TextStyle(
                                          fontSize: width * 0.013,
                                          fontFamily: FontFamily.montserrat,
                                        ),
                                        border: const OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorConstants.darkBrown))),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter password';
                                      } else {
                                        return '';
                                      }
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              Form(
                                child: Container(
                                  width: width,
                                  height: height * 0.1,
                                  color: Colors.white,
                                  child: TextFormField(
                                    textInputAction: TextInputAction.next,
                                    obscureText: obscureNew,
                                    controller: _passText,
                                    cursorColor: ColorConstants.darkBrown,
                                    decoration: InputDecoration(
                                        hoverColor: ColorConstants.darkBrown,
                                        suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                obscureNew = !obscureNew;
                                              });
                                            },
                                            icon: obscureNew == false
                                                ? Icon(
                                                    Icons.visibility,
                                                    size: height * 0.04,
                                                  )
                                                : Icon(
                                                    Icons.visibility_off,
                                                    size: height * 0.04,
                                                  )),
                                        hintText: "Enter New Password",
                                        hintStyle: TextStyle(
                                          fontSize: width * 0.013,
                                          fontFamily: FontFamily.montserrat,
                                        ),
                                        labelText: "New Password",
                                        labelStyle: TextStyle(
                                          fontSize: width * 0.013,
                                          fontFamily: FontFamily.montserrat,
                                        ),
                                        border: const OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorConstants.darkBrown))),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter password';
                                      } else {
                                        return '';
                                      }
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              Form(
                                child: Container(
                                  width: width,
                                  height: height * 0.1,
                                  color: Colors.white,
                                  child: TextFormField(
                                    onFieldSubmitted: (value) {
                                      if (_passText.text == _confirmText.text) {
                                        triggerAddItemEvent(ChangePassEvent(context: context, oldPass: _oldText.text, newPass: _confirmText.text));
                                      } else {
                                        showCustomAlert(context: context, title: "Warning !", message: "passwords does not match!");
                                      }
                                    },
                                    obscureText: obscureConfirm,
                                    controller: _confirmText,
                                    cursorColor: ColorConstants.darkBrown,
                                    decoration: InputDecoration(
                                        hoverColor: ColorConstants.darkBrown,
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
                                        hintText: "Enter Confirm Password",
                                        hintStyle: TextStyle(
                                          fontSize: width * 0.013,
                                          fontFamily: FontFamily.montserrat,
                                        ),
                                        labelText: "Confirm Password",
                                        labelStyle: TextStyle(
                                          fontSize: width * 0.013,
                                          fontFamily: FontFamily.montserrat,
                                        ),
                                        border: const OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorConstants.darkBrown))),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter password';
                                      } else {
                                        return '';
                                      }
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    if (_passText.text == _confirmText.text) {
                                      triggerAddItemEvent(ChangePassEvent(context: context, oldPass: _oldText.text, newPass: _confirmText.text));
                                    } else {
                                      showCustomAlert(context: context, title: "Warning !", message: "passwords does not match!");
                                    }
                                  },
                                  child: Container(
                                    width: width * 0.27,
                                    height: height * 0.06,
                                    decoration: BoxDecoration(color: ColorConstants.darkBrown, borderRadius: BorderRadius.circular(5)),
                                    child: Center(
                                      child: Text(
                                        "Submit",
                                        style: TextStyle(color: Colors.white, fontFamily: FontFamily.montserrat),
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        )),
                      )
                    ],
                  ),
                )),
            GestureDetector(
              onTap: () {
                context.router.navigateBack();
              },
              child: Container(
                margin: EdgeInsets.only(left: width * 0.02, top: width * 0.02),
                width: 30,
                height: 30,
                child: Image.asset(
                  ImageConstants.backButton,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ]));
        } else {
          return Scaffold(
            body: GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: SingleChildScrollView(
                child: Form(
                  key: _userFormKey,
                  child: Padding(
                    padding: EdgeInsets.only(top: height * 0.090, left: 12, right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // context.router.navigateBack();
                            context.router.navigateBack();
                          },
                          child: SvgPicture.asset(
                            appImages.backBlack,
                            width: appDimen.sp40,
                            height: appDimen.sp40,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.07,
                        ),
                        CustomLabel(
                          text: 'Create a New Password',
                          size: 22,
                          fontWeight: FontWeight.w500,
                          fontFamily: FontFamily.montserrat,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomPasswordField(
                          hintText: 'Current Password',
                          onTextChanged: _oldPassMobile,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomPasswordField(
                          hintText: 'New Password',
                          onTextChanged: _newPassMobile,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        CustomPasswordField(
                          hintText: 'Confirm Password',
                          onTextChanged: _confirmPassMobile,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: CustomRaisedButton(
                            text: 'Submit',
                            fontFamily: FontFamily.montserrat,
                            textColor: Colors.white,
                            height: height * 0.07,
                            width: width * 0.97,
                            color: ColorConstants.darkBrown,
                            sideColor: Colors.white,
                            onPressed: () {
                              if (_newPassMobile.text == _confirmPassMobile.text) {
                                triggerAddItemEvent(
                                    ChangePassEvent(context: context, oldPass: _oldPassMobile.text, newPass: _confirmPassMobile.text));
                              } else {
                                showCustomAlert(context: context, title: "Warning !", message: "passwords does not match!");
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
