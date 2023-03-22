import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:web/helper/constants/colors.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/helper/constants/images.dart';
import 'package:web/helper/constants/size_constants.dart';
import 'package:web/view-model/authBloc/login_bloc.dart';
import 'package:web/view-model/authBloc/login_state.dart';
import 'package:web/view/shared_widget/custom_label.dart';
import 'package:web/view/shared_widget/custom_raised_button.dart';
import 'package:web/view/shared_widget/redwood_logo_screen.dart';

import '../../../helper/constants/color_constants.dart';
import '../../../helper/constants/font_family.dart';
import '../../../helper/constants/string_constants.dart';
import '../../../view-model/authBloc/login_event.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  triggerAddItemEvent(LoginEvent event) {
    context.read<LoginBloc>().add(event);
  }

  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();

  final TextEditingController _otpText = TextEditingController();
  final TextEditingController _otpMobile = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return LayoutBuilder(builder: (BuildContext ctx, BoxConstraints constraints) {
        if (width > SizeConstants.tabWidth) {
          return Scaffold(
            body: Stack(children: [
              SizedBox(
                width: width,
                height: height,
                child: Row(
                  children: [
                    const LogoScreen(),
                    Center(
                        child: Container(
                      margin: EdgeInsets.only(top: width * 0.1),
                      height: height,
                      width: width * 0.5,
                      color: Colors.white,
                      child: Center(
                          child: SizedBox(
                        width: width * 0.35,
                        height: height,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                width: width,
                                height: height * 0.08,
                                child: Center(
                                  child: Text(
                                    "Enter Verification Code",
                                    style: TextStyle(fontSize: width * 0.013, fontFamily: FontFamily.montserrat, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.3,
                                height: height * 0.14,
                                child: Center(
                                  child: Text(
                                    "Enter the verification code below sent to your provided email address to reset password",
                                    style: TextStyle(
                                      fontSize: width * 0.013,
                                      fontFamily: FontFamily.montserrat,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              PinCodeTextField(
                                controller: _otpText,
                                length: 4,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                obscureText: false,
                                animationType: AnimationType.fade,
                                pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(5),
                                    fieldHeight: 50,
                                    fieldWidth: 40,
                                    activeFillColor: Colors.white,
                                    inactiveFillColor: Colors.white,
                                    activeColor: ColorConstants.darkBrown,
                                    inactiveColor: ColorConstants.darkBrown,
                                    selectedColor: ColorConstants.darkBrown,
                                    disabledColor: ColorConstants.darkBrown),
                                showCursor: true,
                                cursorColor: ColorConstants.darkBrown,
                                autoFocus: true,
                                onSubmitted: (value) {
                                  triggerAddItemEvent(OtpVerifyEvent(context: context, otp: _otpText.text));
                                },
                                keyboardType: TextInputType.number,
                                animationDuration: const Duration(milliseconds: 300),
                                //   errorAnimationController: errorController,
                                onCompleted: (v) {
                                  triggerAddItemEvent(OtpVerifyEvent(context: context, otp: _otpText.text));
                                },
                                onChanged: (value) {
                                  debugPrint(value);
                                  setState(() {});
                                },
                                beforeTextPaste: (text) {
                                  debugPrint("Allowing to paste $text");
                                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                  return true;
                                },
                                appContext: context,
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 50),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                      onPressed: () {
                                        triggerAddItemEvent(ResendOptEvent(context: context));
                                      },
                                      child: Text(
                                        "Resend OTP",
                                        style: TextStyle(decoration: TextDecoration.underline, color: ColorConstants.darkBrown),
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              state.otpLoader == true
                                  ? GestureDetector(
                                      onTap: () async {
                                        triggerAddItemEvent(OtpVerifyEvent(context: context, otp: _otpText.text));
                                      },
                                      child: Container(
                                        width: width * 0.27,
                                        height: height * 0.06,
                                        decoration: BoxDecoration(color: ColorConstants.darkBrown, borderRadius: BorderRadius.circular(5)),
                                        child: Center(
                                          child: Text(
                                            StringConstants.proceed,
                                            style: TextStyle(color: Colors.white, fontFamily: FontFamily.montserrat),
                                          ),
                                        ),
                                      ),
                                    )
                                  : CircularProgressIndicator(color: ColorConstants.darkBrown)
                            ],
                          ),
                        ),
                      )),
                    ))
                  ],
                ),
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(top: height * 0.10, left: 12, right: 12),
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
                        height: height * 0.17,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: CustomLabel(
                          text: 'Enter verification code',
                          fontWeight: FontWeight.w800,
                          fontFamily: FontFamily.montserrat,
                          size: appDimen.sp20,
                        ),
                      ),
                      SizedBox(height: height * 0.015),
                      Align(
                        alignment: Alignment.center,
                        child: CustomLabel(
                          text: 'Enter the verification code below sent to your provided email address.',
                          size: appDimen.sp17,
                          fontFamily: FontFamily.montserrat,
                        ),
                      ),
                      SizedBox(height: height * 0.055),
                      PinCodeTextField(
                        controller: _otpMobile,
                        length: 4,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        obscureText: false,
                        animationType: AnimationType.fade,
                        pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 40,
                            activeFillColor: Colors.white,
                            inactiveFillColor: Colors.white,
                            activeColor: ColorConstants.darkBrown,
                            inactiveColor: ColorConstants.darkBrown,
                            selectedColor: ColorConstants.darkBrown,
                            disabledColor: ColorConstants.darkBrown),
                        showCursor: true,
                        cursorColor: ColorConstants.darkBrown,
                        autoFocus: true,
                        keyboardType: TextInputType.number,
                        animationDuration: const Duration(milliseconds: 300),
                        //   errorAnimationController: errorController,
                        onCompleted: (value) {
                          triggerAddItemEvent(OtpVerifyEvent(context: context, otp: _otpMobile.text));
                        },
                        onChanged: (value) {
                          debugPrint(value);
                          setState(() {});
                        },
                        beforeTextPaste: (text) {
                          debugPrint("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                        appContext: context,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () async {
                              triggerAddItemEvent(ResendOptEvent(context: context));
                            },
                            child: Text(
                              'Resend OTP',
                              style:
                                  TextStyle(decoration: TextDecoration.underline, color: ColorConstants.darkBrown, fontFamily: FontFamily.montserrat),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: CustomRaisedButton(
                          color: ColorConstants.darkBrown,
                          text: 'Proceed',
                          size: appDimen.sp17,
                          textColor: Colors.white,
                          height: height * 0.07,
                          width: width * 0.97,
                          fontFamily: FontFamily.montserrat,
                          onPressed: () async {
                            triggerAddItemEvent(OtpVerifyEvent(context: context, otp: _otpMobile.text));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      });
    });
  }
}
