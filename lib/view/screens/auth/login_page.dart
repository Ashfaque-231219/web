import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web/helper/constants/color_constants.dart';
import 'package:web/helper/constants/font_family.dart';
import 'package:web/helper/constants/image_constants.dart';
import 'package:web/helper/constants/string_constants.dart';
import 'package:web/helper/utils/common_methods.dart';
import 'package:web/helper/utils/shared_pref.dart';
import 'package:web/route_generator.dart';
import 'package:web/view-model/authBloc/login_bloc.dart';
import 'package:web/view-model/authBloc/login_event.dart';
import 'package:web/view-model/authBloc/login_state.dart';
import 'package:web/view/shared_widget/redwood_logo_screen.dart';

import '../../../helper/constants/size_constants.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isChecked = false;

  String? _token = '';
  Stream<String>? _tokenStream;
  int notificationCount = 0;

  void setToken(String? token) {
    print('FCM TokenToken: $token');
    setState(() {
      _token = token;
    });
  }

  @override
  void initState() {
    //get token
    FirebaseMessaging.instance.getToken().then(setToken);
    _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream?.listen(setToken);
    triggerAddItemEvent(const CheckUserEvent());
    setData();
    super.initState();
  }

  final TextEditingController _userText = TextEditingController();
  final TextEditingController _passText = TextEditingController();
  final _userformKey = GlobalKey<FormState>();
  final _passformKey = GlobalKey<FormState>();
  bool checkbox = false;
  bool obscure = true;

  triggerAddItemEvent(LoginEvent event) {
    context.read<LoginBloc>().add(event);
  }

  setData() async {
    await SharedPref.setBool(key: "logout", data: true);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var tabHeight = MediaQuery.of(context).size.height;
    var tabWidth = MediaQuery.of(context).size.width;
    var mobHeight = MediaQuery.of(context).size.height;
    var mobWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return LayoutBuilder(builder: (BuildContext ctx, BoxConstraints constraints) {
          //===================== Web View ====================//
          if (width > SizeConstants.tabWidth) {
            return Scaffold(
                body: GestureDetector(
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
                                        StringConstants.pleaseSignIn,
                                        style: TextStyle(
                                          fontSize: width * 0.013,
                                          fontFamily: FontFamily.montserrat,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Form(
                                    key: _userformKey,
                                    child: Container(
                                      width: width - 50,
                                      height: height * 0.08,
                                      color: Colors.white,
                                      child: TextFormField(
                                        controller: _userText,
                                        cursorColor: ColorConstants.darkBrown,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          suffixIcon: Container(
                                              margin: const EdgeInsets.only(right: 10),
                                              child: Image.asset(
                                                ImageConstants.person,
                                                width: width * 0.10,
                                                height: width * 0.10,
                                                alignment: Alignment.centerRight,
                                              )),
                                          hintText: StringConstants.enterUserName,
                                          hintStyle: TextStyle(
                                            fontSize: 12,
                                            fontFamily: FontFamily.montserrat,
                                          ),
                                          labelText: StringConstants.userName,
                                          labelStyle: TextStyle(
                                            fontSize: 13,
                                            fontFamily: FontFamily.montserrat,
                                          ),
                                          border: const OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: ColorConstants.darkBrown,
                                            ),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.toString().isEmpty) {
                                            return "Please Enter UserName";
                                          } else {
                                            if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                .hasMatch(_userText.text)) {
                                              return "Please Enter Valid Email";
                                            } else {
                                              return '';
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Form(
                                    key: _passformKey,
                                    child: Container(
                                      width: width - 50,
                                      height: height * 0.08,
                                      color: Colors.white,
                                      child: TextFormField(
                                        onFieldSubmitted: (value) {
                                          triggerAddItemEvent(
                                            GetLoginEvent(
                                              context: context,
                                              email: _userText.text,
                                              password: _passText.text,
                                              token: _token,
                                            ),
                                          );
                                        },
                                        obscureText: obscure,
                                        controller: _passText,
                                        textInputAction: TextInputAction.send,
                                        cursorColor: ColorConstants.darkBrown,
                                        decoration: InputDecoration(
                                          hoverColor: ColorConstants.darkBrown,
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  obscure = !obscure;
                                                });
                                              },
                                              icon: obscure == false
                                                  ? Icon(
                                                      Icons.visibility,
                                                      size: height * 0.04,
                                                    )
                                                  : Icon(
                                                      Icons.visibility_off,
                                                      size: height * 0.04,
                                                    )),
                                          hintText: StringConstants.enterPassword,
                                          hintStyle: TextStyle(
                                            fontSize: 12,
                                            fontFamily: FontFamily.montserrat,
                                          ),
                                          labelText: StringConstants.password,
                                          labelStyle: TextStyle(
                                            fontSize: 13,
                                            fontFamily: FontFamily.montserrat,
                                          ),
                                          border: const OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: ColorConstants.darkBrown),
                                          ),
                                        ),
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
                                    height: height * 0.01,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: height * 0.05,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: width * 0.02,
                                              height: height * 0.03,
                                              child: Checkbox(
                                                activeColor: ColorConstants.green,
                                                value: _isChecked,
                                                onChanged: _handleRememberMe,
                                              ),
                                            ),
                                            SizedBox(
                                              width: width * 0.02,
                                            ),
                                            Text(
                                              StringConstants.loggedIn,
                                              style: TextStyle(
                                                fontSize: width * 0.012,
                                                fontFamily: FontFamily.montserrat,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                            onPressed: () {
                                              context.router.pushNamed(RoutesConst.forgot);
                                              // Navigator.pushNamed(context, RoutesConst.forgot);
                                            },
                                            child: Text(
                                              "Forgot Password?",
                                              style: TextStyle(color: ColorConstants.darkBrown),
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.03,
                                  ),
                                  state.loading == true
                                      ? GestureDetector(
                                          onTap: () async {
                                            triggerAddItemEvent(
                                              GetLoginEvent(
                                                context: context,
                                                email: _userText.text,
                                                password: _passText.text,
                                                token: _token,
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: width * 0.3,
                                            height: height * 0.06,
                                            decoration: BoxDecoration(
                                              color: ColorConstants.darkBrown,
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            child: Center(
                                              child: Text(
                                                StringConstants.login,
                                                style: TextStyle(color: Colors.white, fontFamily: FontFamily.montserrat),
                                              ),
                                            ),
                                          ))
                                      : CircularProgressIndicator(
                                          color: ColorConstants.darkBrown,
                                        )
                                ],
                              ),
                            )),
                          )
                        ],
                      ),
                    )));
          }
          //===================== Tab  View ====================//
          else if (width <= SizeConstants.tabWidth && width >= SizeConstants.mobileWidth) {
            return Scaffold(
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.4,
                          width: width,
                          color: ColorConstants.darkBrown,
                          child: Center(
                              child: SizedBox(
                            width: SizeConstants.tabWidth * 0.45,
                            height: SizeConstants.tabHeight * 0.1,
                            child: Image.asset(
                              ImageConstants.logoImage,
                              fit: BoxFit.fill,
                            ),
                          )),
                        ),
                        SizedBox(
                          height: height * 0.6,
                          width: width,
                          child: Center(
                            child: SizedBox(
                              width: SizeConstants.tabWidth * 0.5,
                              height: SizeConstants.tabHeight * 0.6,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: SizeConstants.tabHeight * 0.02,
                                  ),
                                  SizedBox(
                                    width: width,
                                    height: height * 0.08,
                                    child: Center(
                                      child: Text(
                                        StringConstants.pleaseSignIn,
                                        style: TextStyle(
                                          fontSize: SizeConstants.tabWidth * 0.027,
                                          fontFamily: FontFamily.montserrat,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConstants.tabHeight * 0.02,
                                  ),
                                  Form(
                                    key: _userformKey,
                                    child: SizedBox(
                                      width: width * 0.9,
                                      height: height * 0.08,
                                      child: TextFormField(
                                        controller: _userText,
                                        cursorColor: ColorConstants.darkBrown,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          suffixIcon: Container(
                                            margin: const EdgeInsets.only(right: 0),
                                            child: Icon(
                                              Icons.person,
                                              size: height * 0.03,
                                            ),
                                          ),
                                          hintText: StringConstants.enterUserName,
                                          hintStyle: TextStyle(
                                            fontSize: width * 0.02,
                                            fontFamily: FontFamily.montserrat,
                                          ),
                                          labelText: StringConstants.userName,
                                          labelStyle: TextStyle(
                                            fontSize: width * 0.02,
                                            fontFamily: FontFamily.montserrat,
                                          ),
                                          border: const OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: ColorConstants.darkBrown),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.toString().isEmpty) {
                                            return "Please Enter UserName";
                                          } else {
                                            if (!CommonMethods.validateEmail(_userText.text)) {
                                              return "Please Enter Valid Email";
                                            } else {
                                              return '';
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Form(
                                    key: _passformKey,
                                    child: SizedBox(
                                      width: width * 0.9,
                                      height: height * 0.08,
                                      child: TextFormField(
                                        obscureText: obscure,
                                        controller: _passText,
                                        textInputAction: TextInputAction.send,
                                        cursorColor: ColorConstants.darkBrown,
                                        decoration: InputDecoration(
                                          hoverColor: ColorConstants.darkBrown,
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  obscure = !obscure;
                                                });
                                              },
                                              icon: obscure == false
                                                  ? Icon(
                                                      Icons.visibility,
                                                      size: height * 0.03,
                                                    )
                                                  : Icon(
                                                      Icons.visibility_off,
                                                      size: height * 0.03,
                                                    )),
                                          hintText: StringConstants.enterPassword,
                                          hintStyle: TextStyle(
                                            fontSize: width * 0.02,
                                            fontFamily: FontFamily.montserrat,
                                          ),
                                          labelText: StringConstants.password,
                                          labelStyle: TextStyle(
                                            fontSize: width * 0.02,
                                            fontFamily: FontFamily.montserrat,
                                          ),
                                          border: const OutlineInputBorder(),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: ColorConstants.darkBrown),
                                          ),
                                        ),
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: width * 0.25,
                                        height: height * 0.05,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: width * 0.02,
                                              height: height * 0.03,
                                              child: Checkbox(activeColor: ColorConstants.green, value: _isChecked, onChanged: _handleRememberMe),
                                            ),
                                            SizedBox(
                                              width: width * 0.01,
                                            ),
                                            Text(
                                              StringConstants.loggedIn,
                                              style: TextStyle(
                                                fontSize: width * 0.02,
                                                fontFamily: FontFamily.montserrat,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                          onPressed: () {
                                            context.router.pushNamed(RoutesConst.forgot);
                                            // Navigator.pushNamed(context, RoutesConst.forgot);
                                          },
                                          child: Text(
                                            "Forgot Password?",
                                            style: TextStyle(
                                              color: ColorConstants.darkBrown,
                                              fontSize: width * 0.02,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.03,
                                  ),
                                  state.loading == true
                                      ? GestureDetector(
                                          onTap: () async {
                                            triggerAddItemEvent(GetLoginEvent(
                                              context: context,
                                              email: _userText.text,
                                              password: _passText.text,
                                              token: _token,
                                            ));
                                          },
                                          child: Container(
                                            width: width * 0.3,
                                            height: height * 0.06,
                                            decoration: BoxDecoration(color: ColorConstants.darkBrown, borderRadius: BorderRadius.circular(5)),
                                            child: Center(
                                              child: Text(
                                                StringConstants.login,
                                                style: TextStyle(color: Colors.white, fontFamily: FontFamily.montserrat),
                                              ),
                                            ),
                                          ),
                                        )
                                      : CircularProgressIndicator(
                                          color: ColorConstants.darkBrown,
                                        ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          // ==============Mobile View ====================//
          else {
            return Scaffold(
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.2,
                        ),
                        SizedBox(
                          height: height * 0.1,
                          width: width,
                          child: Center(
                              child: SizedBox(
                            child: Image.asset(
                              ImageConstants.logoImageMob,
                              fit: BoxFit.fill,
                            ),
                          )),
                        ),
                        SizedBox(
                          height: height * 0.6,
                          width: width,
                          child: Center(
                              child: SizedBox(
                            width: SizeConstants.tabWidth * 0.5,
                            height: SizeConstants.tabHeight * 0.6,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: SizeConstants.tabHeight * 0.02,
                                ),
                                SizedBox(
                                  width: width,
                                  height: height * 0.05,
                                  child: Center(
                                    child: Text(
                                      StringConstants.pleaseSignIn,
                                      style: TextStyle(fontSize: width * 0.05, fontFamily: FontFamily.montserrat, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConstants.tabHeight * 0.01,
                                ),
                                Form(
                                  key: _userformKey,
                                  child: SizedBox(
                                    width: width * 0.85,
                                    height: height * 0.08,
                                    child: TextFormField(
                                      controller: _userText,
                                      cursorColor: ColorConstants.darkBrown,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        suffixIcon: Icon(
                                          Icons.person,
                                          size: height * 0.03,
                                        ),
                                        hintText: StringConstants.enterUserName,
                                        hintStyle: TextStyle(
                                          fontSize: width * 0.04,
                                          fontFamily: FontFamily.montserrat,
                                        ),
                                        labelText: StringConstants.userName,
                                        labelStyle: TextStyle(
                                          fontSize: width * 0.04,
                                          fontFamily: FontFamily.montserrat,
                                        ),
                                        border: const OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: ColorConstants.darkBrown,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.toString().isEmpty) {
                                          return "Please Enter UserName";
                                        } else {
                                          if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(_userText.text)) {
                                            return "Please Enter Valid Email";
                                          } else {
                                            return '';
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Form(
                                  key: _passformKey,
                                  child: SizedBox(
                                    width: width * 0.85,
                                    height: height * 0.08,
                                    child: TextFormField(
                                      onFieldSubmitted: (value) {
                                        triggerAddItemEvent(GetLoginEvent(
                                          context: context,
                                          email: _userText.text,
                                          password: _passText.text,
                                          token: _token,
                                        ));
                                      },
                                      obscureText: obscure,
                                      controller: _passText,
                                      textInputAction: TextInputAction.send,
                                      cursorColor: ColorConstants.darkBrown,
                                      decoration: InputDecoration(
                                          hoverColor: ColorConstants.darkBrown,
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  obscure = !obscure;
                                                });
                                              },
                                              icon: obscure == false
                                                  ? Icon(
                                                      Icons.visibility,
                                                      size: height * 0.03,
                                                    )
                                                  : Icon(
                                                      Icons.visibility_off,
                                                      size: height * 0.03,
                                                    )),
                                          hintText: StringConstants.enterPassword,
                                          hintStyle: TextStyle(
                                            fontSize: width * 0.04,
                                            fontFamily: FontFamily.montserrat,
                                          ),
                                          labelText: StringConstants.password,
                                          labelStyle: TextStyle(
                                            fontSize: width * 0.04,
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: width * 0.53,
                                      height: height * 0.05,
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: width * 0.09),
                                            width: width * 0.02,
                                            height: height * 0.03,
                                            child: Checkbox(activeColor: ColorConstants.green, value: _isChecked, onChanged: _handleRememberMe),
                                          ),
                                          SizedBox(
                                            width: width * 0.02,
                                          ),
                                          Text(
                                            StringConstants.loggedIn,
                                            style: TextStyle(
                                              fontSize: width * 0.04,
                                              fontFamily: FontFamily.montserrat,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: width * 0.05),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                            onPressed: () {
                                              context.router.pushNamed(RoutesConst.forgot);
                                              // Navigator.pushNamed(context, RoutesConst.forgot);
                                            },
                                            child: Text(
                                              "Forgot Password?",
                                              style: TextStyle(
                                                color: ColorConstants.darkBrown,
                                                fontSize: width * 0.04,
                                              ),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.03,
                                ),
                                state.loading == true
                                    ? GestureDetector(
                                        onTap: () async {
                                          triggerAddItemEvent(GetLoginEvent(
                                            context: context,
                                            email: _userText.text,
                                            password: _passText.text,
                                            token: _token,
                                          ));
                                        },
                                        child: Container(
                                          width: width * 0.85,
                                          height: height * 0.06,
                                          decoration: BoxDecoration(color: ColorConstants.darkBrown, borderRadius: BorderRadius.circular(5)),
                                          child: Center(
                                            child: Text(
                                              StringConstants.login,
                                              style: TextStyle(color: Colors.white, fontFamily: FontFamily.montserrat),
                                            ),
                                          ),
                                        ))
                                    : CircularProgressIndicator(
                                        color: ColorConstants.darkBrown,
                                      )
                              ],
                            ),
                          )),
                        )
                      ],
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

  void _handleRememberMe(bool? value) {
    _isChecked = value!;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('email', _userText.text);
        prefs.setString('password', _passText.text);
      },
    );
    setState(() {
      _isChecked = value;
    });
  }

// void _loadUserEmailPassword() async {
//   try {
//     SharedPreferences _prefs = await SharedPreferences.getInstance();
//     var _email = _prefs.getString("email") ?? "";
//     var _password = _prefs.getString("password") ?? "";
//     var _remeberMe = _prefs.getBool("remember_me") ?? false;
//     print(_remeberMe);
//     print(_email);
//     print(_password);
//     if (_remeberMe) {
//       setState(() {
//         _isChecked = true;
//       });
//       _userText.text = _email ?? "";
//       _passText.text = _password ?? "";
//     }
//   } catch (e)
//   {
//     print(e);
//   }
// }
}
