import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:web/helper/constants/colors.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/helper/constants/string.dart';
import 'package:web/helper/utils/common_methods.dart';
import 'package:web/models/share_model/share_users_list.dart';
import 'package:web/view/shared_widget/custom_dialog.dart';
import 'package:web/view/shared_widget/custom_label.dart';
import 'package:web/view/shared_widget/custom_raised_button.dart';
import 'package:web/view/shared_widget/custom_text_field.dart';

class UserMailDialog extends StatefulWidget {
  const UserMailDialog({required this.getShareUsersList, Key? key}) : super(key: key);

  final GetShareUsersList? getShareUsersList;

  @override
  State<UserMailDialog> createState() => _UserMailDialogState();
}

class _UserMailDialogState extends State<UserMailDialog> {
  List<TextEditingController> emailController = [TextEditingController()];

  List<Data?>? getShareUsersList = [];
  List<String> emailsList = [];
  List<String> userMail = [];

  @override
  void initState() {
    getShareUsersList = widget.getShareUsersList?.data;
    emailController = List.generate(getShareUsersList?.length ?? 0, (index) => TextEditingController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.32,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: getShareUsersList?.length,
                  itemBuilder: (context, int index) {
                    if (getShareUsersList != null &&
                        getShareUsersList?[index] != null &&
                        getShareUsersList?[index]?.users != null) {
                      userMail.clear();
                      for (int i = 0; i < getShareUsersList![index]!.users!.length; i++) {
                        if (getShareUsersList?[index]?.users?[i] != null &&
                            getShareUsersList?[index]?.users?[i]?.email != null) {
                          if (getShareUsersList?[index]?.users?[i]?.checked != null &&
                              getShareUsersList![index]!.users![i]!.checked!) {
                            userMail.add(getShareUsersList?[index]?.users?[i]?.email ?? '');
                          }
                        }
                      }
                      if (userMail.isNotEmpty) {
                        // emailsList.clear();
                        // emailsList.add(userMail.toString());
                        if (emailsList.length > index) {
                          emailsList[index] = userMail.join(",");
                        } else {
                          emailsList.add(userMail.join(","));
                        }
                      }
                    }
                    return ExpansionTile(
                      title: CustomLabel(
                        text: getShareUsersList?[index]?.reportName ?? '',
                      ),
                      initiallyExpanded: index == 0,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: getShareUsersList?[index]?.users?.length,
                          itemBuilder: (context, int usersIndex) {
                            return CheckboxListTile(
                              title: CustomLabel(
                                text: getShareUsersList?[index]?.users?[usersIndex]?.email ?? '',
                              ),
                              value: getShareUsersList?[index]?.users?[usersIndex]?.checked ?? true,
                              onChanged: (value) {
                                setState(() {
                                  if (value != null) {
                                    getShareUsersList?[index]?.users?[usersIndex]?.checked = value;
                                    if (getShareUsersList != null &&
                                        getShareUsersList?[index] != null &&
                                        getShareUsersList?[index]?.users != null) {
                                      userMail.clear();
                                      for (int i = 0; i < getShareUsersList![index]!.users!.length; i++) {
                                        if (getShareUsersList?[index]?.users?[i] != null &&
                                            getShareUsersList?[index]?.users?[i]?.email != null) {
                                          if (getShareUsersList![index]!.users![i]!.checked != null &&
                                              getShareUsersList![index]!.users![i]!.checked!) {
                                            userMail.add(getShareUsersList?[index]?.users?[i]?.email ?? '');
                                          }
                                        }
                                      }
                                      if (userMail.isNotEmpty) {
                                        // emailsList.clear();
                                        // emailsList.add(userMail.toString());
                                        // emailsList[index] = userMail.join(",");
                                      }
                                    }
                                  }
                                });
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: appDimen.sp10,
                        ),
                        Padding(
                          padding: EdgeInsets.all(appDimen.sp8),
                          child: SizedBox(
                            child: CustomTextField(
                              onTextChanged: emailController[index],
                              borderRadius: appDimen.sp5,
                              inputType: TextInputType.multiline,
                              hintText: appString.email,
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.send),
                                onPressed: () {
                                  print(emailController[index].text);
                                  if (emailController[index].text.trim().isEmpty) {
                                    showDialog(context: context, builder: (context){
                                      return const CustomDialog(text: "Please Enter Email", width: 200,);
                                    });
                                    Fluttertoast.showToast(
                                      msg: "Please Enter Email",
                                      toastLength: Toast.LENGTH_LONG,
                                      fontSize: 18.0,
                                    );
                                  } else if (!CommonMethods.validateEmail(emailController[index].text.trim())) {
                                    showDialog(context: context, builder: (context){
                                      return const CustomDialog(text: "Please Enter Valid Email", width: 200,);
                                    });
                                    Fluttertoast.showToast(
                                      msg: "Please Enter Valid Email",
                                      toastLength: Toast.LENGTH_LONG,
                                      fontSize: 18.0,
                                    );
                                  } else {
                                    List<String> email = [];
                                    if (getShareUsersList!=null &&
                                        getShareUsersList![index] != null &&
                                        getShareUsersList?[index]!.users != null) {
                                      for (var user in getShareUsersList![index]!.users!) {
                                        if (user!=null && user.email != null) {
                                          email.add(user.email!);
                                        }
                                      }
                                      if (email.contains(emailController[index].text.trim())) {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return const CustomDialog(
                                                text: "The Email Already Exists", width: 200,
                                              );
                                            });

                                        Fluttertoast.showToast(
                                          msg: "This Email Already Exists",
                                          toastLength: Toast.LENGTH_LONG,
                                          fontSize: 18.0,
                                        );
                                      } else {
                                        getShareUsersList?[index]!
                                            .users
                                            ?.add(Users(email: emailController[index].text));
                                        emailController[index].text = '';
                                        setState(() {});
                                      }
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                width: 100,
                child: CustomRaisedButton(
                  text: 'Share',
                  color: Color(appColors.brown840000),
                  onPressed: () {
                    Navigator.pop(context, emailsList);
                  },
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
