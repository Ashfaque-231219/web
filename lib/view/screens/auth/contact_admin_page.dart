import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web/helper/constants/color_constants.dart';
import 'package:web/helper/constants/colors.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/helper/constants/font_family.dart';
import 'package:web/helper/constants/images.dart';
import 'package:web/helper/constants/size_constants.dart';
import 'package:web/helper/constants/string.dart';
import 'package:web/helper/utils/common_methods.dart';
import 'package:web/helper/utils/shared_pref.dart';
import 'package:web/view-model/contact_admin_bloc/contact_admin_bloc.dart';
import 'package:web/view/shared_widget/custom_label.dart';
import 'package:web/view/shared_widget/custom_raised_button.dart';
import 'package:web/view/shared_widget/custom_text_field.dart';
import 'package:web/view/shared_widget/loading_widget.dart';

class ContactAdmin extends StatefulWidget {
  const ContactAdmin({Key? key}) : super(key: key);

  @override
  State<ContactAdmin> createState() => _ContactAdminState();
}

class _ContactAdminState extends State<ContactAdmin> {
  TextEditingController messageController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  triggerContactAdminEvent(GetContactAdminEvent event) {
    context.read<ContactAdminBloc>().add(event);
  }

  @override
  void initState() {
    getEmailData();
    super.initState();
  }

  getEmailData() async {
    final String email = await SharedPref.getString(key: "user-email");
    usernameController.text = email;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocBuilder<ContactAdminBloc, ContactAdminState>(
      builder: (context, state) {
        return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
          if (width > SizeConstants.tabWidth) {
            return LoadingWidget(
                status: state.stateStatus,
                child: LoadingWidget(
                  status: state.stateStatus,
                  child: Scaffold(
                    backgroundColor: Colors.white,
                    body: SingleChildScrollView(
                      child: Center(
                        child: Container(
                          width: width * 0.7,
                          margin: EdgeInsets.all(appDimen.sp20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      context.router.navigateBack();
                                    },
                                    child: SvgPicture.asset(
                                      appImages.backBlack,
                                      width: appDimen.sp40,
                                      height: appDimen.sp40,
                                    ),
                                  ),
                                  SizedBox(
                                    width: appDimen.sp20,
                                  ),
                                  Expanded(
                                    child: CustomLabel(
                                      text: 'Contact Admin',
                                      size: appDimen.sp16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: appDimen.sp20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: width * 0.3,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomLabel(
                                          text: 'Let us know what you are thinking !',
                                          color: Color(appColors.grey7A7A7A),
                                        ),
                                        SizedBox(
                                          height: appDimen.sp15,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(
                                              color: Color(appColors.greyA5A5A5),
                                            ),
                                            color: Colors.white,
                                          ),
                                          padding: EdgeInsets.only(
                                            top: appDimen.sp20,
                                            left: appDimen.sp20,
                                            right: appDimen.sp20,
                                          ),
                                          child: TextFormField(
                                            controller: usernameController,
                                            readOnly: true,
                                            cursorColor: ColorConstants.darkBrown,
                                            textInputAction: TextInputAction.next,
                                            decoration: InputDecoration(
                                              suffixIcon: Container(
                                                margin: const EdgeInsets.only(right: 10, bottom: 20),
                                                child: SvgPicture.asset(
                                                  appImages.person,
                                                  width: width * 0.02,
                                                  height: width * 0.02,
                                                  alignment: Alignment.centerRight,
                                                ),
                                              ),
                                              labelText: appString.email,
                                              labelStyle: TextStyle(fontSize: 16, fontFamily: FontFamily.montserrat, color: Colors.grey),
                                              floatingLabelStyle: TextStyle(fontSize: 16, fontFamily: FontFamily.montserrat, color: Colors.grey),
                                              floatingLabelBehavior: FloatingLabelBehavior.always,
                                              border: const OutlineInputBorder(borderSide: BorderSide.none),
                                              contentPadding: const EdgeInsets.only(
                                                top: 12,
                                              ),
                                            ),
                                            validator: (value) {
                                              if (value == null || value.toString().isEmpty) {
                                                return "Please Enter Email";
                                              } else {
                                                if (!CommonMethods.validateEmail(usernameController.text)) {
                                                  return "Please Enter Valid Email";
                                                } else {
                                                  return '';
                                                }
                                              }
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: appDimen.sp15,
                                        ),
                                        SizedBox(
                                          height: height * 0.25,
                                          child: CustomTextField(
                                            onTextChanged: messageController,
                                            borderRadius: appDimen.sp5,
                                            maxLines: null,
                                            maxLength: 100,
                                            inputType: TextInputType.multiline,
                                            expands: true,
                                            hintText: appString.messageHint,
                                          ),
                                        ),
                                        SizedBox(
                                          height: appDimen.sp15,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(appDimen.sp15),
                                          child: CustomRaisedButton(
                                            text: 'Send',
                                            color: Color(appColors.brown840000),
                                            onPressed: () {
                                              triggerContactAdminEvent(GetContactAdminEvent(questions: messageController.text, context: context));
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    appImages.contactAdmin,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ));
          } else {
            return LoadingWidget(
              status: state.stateStatus,
              child: Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  child: Center(
                    child: Container(
                      width: width,
                      margin: EdgeInsets.all(appDimen.sp20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  context.router.navigateBack();
                                },
                                child: SvgPicture.asset(
                                  appImages.backBlack,
                                  width: appDimen.sp40,
                                  height: appDimen.sp40,
                                ),
                              ),
                              SizedBox(
                                width: appDimen.sp20,
                              ),
                              Expanded(
                                child: CustomLabel(
                                  text: 'Contact Admin',
                                  size: appDimen.sp16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: appDimen.sp20,
                          ),
                          SizedBox(
                            width: width * 0.8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomLabel(
                                  text: 'Let us know what you are thinking !',
                                  color: Color(appColors.grey7A7A7A),
                                ),
                                SizedBox(
                                  height: appDimen.sp15,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Color(appColors.greyA5A5A5),
                                    ),
                                    color: Colors.white,
                                  ),
                                  padding: EdgeInsets.only(
                                    top: appDimen.sp20,
                                    left: appDimen.sp20,
                                    right: appDimen.sp20,
                                  ),
                                  child: TextFormField(
                                    controller: usernameController,
                                    cursorColor: ColorConstants.darkBrown,
                                    textInputAction: TextInputAction.next,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      suffixIcon: Container(
                                        margin: const EdgeInsets.only(right: 10, bottom: 20),
                                        child: SvgPicture.asset(
                                          appImages.person,
                                          width: width * 0.02,
                                          height: width * 0.02,
                                          alignment: Alignment.centerRight,
                                        ),
                                      ),
                                      labelText: appString.email,
                                      labelStyle: TextStyle(fontSize: 16, fontFamily: FontFamily.montserrat, color: Colors.grey),
                                      floatingLabelStyle: TextStyle(fontSize: 16, fontFamily: FontFamily.montserrat, color: Colors.grey),
                                      floatingLabelBehavior: FloatingLabelBehavior.always,
                                      border: const OutlineInputBorder(borderSide: BorderSide.none),
                                      contentPadding: const EdgeInsets.only(
                                        top: 12,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.toString().isEmpty) {
                                        return "Please Enter Email";
                                      } else {
                                        if (!CommonMethods.validateEmail(usernameController.text)) {
                                          return "Please Enter Valid Email";
                                        } else {
                                          return '';
                                        }
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: appDimen.sp15,
                                ),
                                SizedBox(
                                  height: height * 0.25,
                                  child: CustomTextField(
                                    onTextChanged: messageController,
                                    borderRadius: appDimen.sp5,
                                    maxLines: null,
                                    maxLength: 100,
                                    inputType: TextInputType.multiline,
                                    expands: true,
                                    hintText: appString.messageHint,
                                  ),
                                ),
                                SizedBox(
                                  height: appDimen.sp15,
                                ),
                                Padding(
                                  padding: EdgeInsets.all(appDimen.sp15),
                                  child: CustomRaisedButton(
                                    text: 'Send',
                                    color: Color(appColors.brown840000),
                                    onPressed: () {
                                      triggerContactAdminEvent(GetContactAdminEvent(questions: messageController.text, context: context));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
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
