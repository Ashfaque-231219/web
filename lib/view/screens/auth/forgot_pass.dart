import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:web/helper/constants/color_constants.dart';
import 'package:web/helper/constants/colors.dart';
import 'package:web/helper/constants/image_constants.dart';
import 'package:web/helper/constants/size_constants.dart';
import 'package:web/helper/constants/string_constants.dart';
import 'package:web/view-model/authBloc/login_state.dart';
import 'package:web/view/shared_widget/redwood_logo_screen.dart';

import '../../../helper/constants/dimen.dart';
import '../../../helper/constants/font_family.dart';
import '../../../helper/constants/images.dart';
import '../../../helper/utils/validate.dart';
import '../../../view-model/authBloc/login_bloc.dart';
import '../../../view-model/authBloc/login_event.dart';
import '../../shared_widget/custom_label.dart';
import '../../shared_widget/custom_raised_button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _userText = TextEditingController();
  final _userFormKey = GlobalKey<FormState>();

  triggerAddItemEvent(LoginEvent event) {
    context.read<LoginBloc>().add(event);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, newState) {
        return LayoutBuilder(builder: (BuildContext ctx, BoxConstraints constraints) {
          if (width > SizeConstants.tabWidth) {
            return Scaffold(
                body: Stack(
              children: [
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
                          height: height * 0.6,
                          child: Column(
                            children: [
                              SizedBox(
                                  width: width * 0.05,
                                  height: height * 0.08,
                                  child: Image.asset(
                                    ImageConstants.forgotImage,
                                  )),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Text(
                                StringConstants.needToReset,
                                style: TextStyle(
                                    fontSize: width * 0.012, fontFamily: FontFamily.montserrat, fontWeight: FontWeight.bold, color: Colors.black),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              SizedBox(
                                width: width * 0.25,
                                child: Center(
                                  child: Text(
                                    StringConstants.resetting,
                                    maxLines: 3,
                                    style: TextStyle(
                                      fontSize: width * 0.010,
                                      fontFamily: FontFamily.montserrat,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.17,
                                child: Center(
                                  child: Text(
                                    StringConstants.sendYou,
                                    style: TextStyle(
                                      fontSize: width * 0.010,
                                      fontFamily: FontFamily.montserrat,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.17,
                                child: Center(
                                  child: Text(
                                    "password OTP.",
                                    style: TextStyle(
                                      fontSize: width * 0.010,
                                      fontFamily: FontFamily.montserrat,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Container(
                                width: width - 50,
                                height: height * 0.10,
                                color: Colors.white,
                                child: TextFormField(
                                  controller: _userText,
                                  key: _userFormKey,
                                  onFieldSubmitted: (value) {
                                    triggerAddItemEvent(ForgotPassEvent(email: _userText.text, context: context));
                                  },
                                  cursorColor: ColorConstants.darkBrown,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                      suffixIcon: Container(
                                          margin: const EdgeInsets.only(right: 5),
                                          child: Image.asset(
                                            ImageConstants.person,
                                            width: width * 0.10,
                                            height: width * 0.10,
                                            alignment: Alignment.centerRight,
                                          )),
                                      hintText: StringConstants.enterUserName,
                                      hintStyle: TextStyle(
                                        fontSize: width * 0.012,
                                        fontFamily: FontFamily.montserrat,
                                      ),
                                      labelText: StringConstants.userName,
                                      labelStyle: TextStyle(
                                        fontSize: width * 0.012,
                                        fontFamily: FontFamily.montserrat,
                                      ),
                                      border: const OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ColorConstants.darkBrown))),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please Enter UserName/Email";
                                    } else {
                                      if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_userText.text)) {
                                        return "Please Enter Valid Email";
                                      }
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: height * 0.04,
                              ),

                              newState.onLoading == true
                                  ? GestureDetector(
                                      onTap: () {
                                        triggerAddItemEvent(ForgotPassEvent(email: _userText.text, context: context));
                                      },
                                      child: Container(
                                          width: width * 0.22,
                                          height: height * 0.06,
                                          decoration: BoxDecoration(color: ColorConstants.darkBrown, borderRadius: BorderRadius.circular(5)),
                                          child: Center(
                                            child: Text(
                                              StringConstants.sendLink,
                                              style: TextStyle(color: Colors.white, fontSize: width * 0.01, fontFamily: FontFamily.montserrat),
                                            ),
                                          )),
                                    )
                                  : CircularProgressIndicator(color: ColorConstants.darkBrown)
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
              ],
            ));
          } else {
            return Scaffold(
              body: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(height * 0.03),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _userFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.router.navigateBack();
                              },
                              child: SvgPicture.asset(
                                appImages.backBlack,
                                color: Color(appColors.brown840000),
                                width: appDimen.sp40,
                                height: appDimen.sp40,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.20,
                            ),
                            Align(alignment: Alignment.center, child: Image.asset(ImageConstants.openLock)),
                            SizedBox(
                              height: height * 0.033,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: CustomLabel(
                                text: 'Need to reset your password?',
                                size: appDimen.sp20,
                                fontWeight: FontWeight.w600,
                                fontFamily: FontFamily.montserrat,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.011,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: CustomLabel(
                                text: 'Resetting your password is easy.Enter  email ID and we ll send you a OTP on your email.',
                                size: appDimen.sp16,
                                fontFamily: FontFamily.montserrat,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: height * 0.035,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: width * 0.8,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Email",
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color(appColors.greyA5A5A5),
                                      ),
                                    ),
                                  ),
                                  controller: _userText,
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Email is required.';
                                    } else if (Validate.validateEmail(value.toString()) == false) {
                                      return "Email is Invalid.";
                                    }else {
                                      return '';
                                    }
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.038,
                            ),
                            CustomRaisedButton(
                              onPressed: () {
                                  triggerAddItemEvent(ForgotPassEvent(email: _userText.text, context: context));
                              },
                              color: ColorConstants.darkBrown,
                              text: 'Send OTP',
                              size: 14,
                              textColor: Colors.white,
                              height: height * 0.07,
                              width: width * 0.97,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        });
      },
    );
  }
}
