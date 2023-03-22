import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/helper/constants/images.dart';
import 'package:web/helper/constants/size_constants.dart';
import 'package:web/route_generator.dart';
import 'package:web/view-model/authBloc/login_bloc.dart';
import 'package:web/view-model/authBloc/login_event.dart';
import 'package:web/view/shared_widget/custom_raised_button.dart';

import '../../../helper/constants/color_constants.dart';
import '../../../helper/constants/font_family.dart';
import '../../../helper/constants/image_constants.dart';
import '../../../view-model/authBloc/login_state.dart';
import '../../shared_widget/redwood_logo_screen.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return Edit();
  }
}

class Edit extends State<EditProfile> {
  File? _pickedImage;
  Uint8List webImage = Uint8List(8);

  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _pickedImage = selected;
          debugPrint("THe picked images if ${_pickedImage?.path}");
        });
      } else {
        debugPrint('No image has been picked');
      }
    } else if (kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          _pickedImage = File(image.path);
        });
      } else {
        debugPrint('No image has been picked');
      }
    } else {
      debugPrint('Something went wrong');
    }
  }

  Future<bool> onWillPop() {
    // context.router.pop();
    Navigator.pushNamedAndRemoveUntil(context, RoutesConst.homePage, (route) => false);
    return Future.value(false);
  }

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  late String countryValue;
  late String stateValue;
  late String cityValue;
  late String counterpassword = "0";
  late bool logged = false;
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    // getIsLoggedIn();
    // GetUserId();
    _nameController.text = "";
    _emailController.text = "";
    _contactController.text = "";
    _locationController.text = "";
    triggerCreateAccountEvent(GetUserDetailsEvent(context: context));

    super.initState();
  }

  triggerCreateAccountEvent(LoginEvent event) {
    context.read<LoginBloc>().add(event);
  }

  late Uint8List uploadedImage = Uint8List(8);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      _nameController.text = state.name ?? "";
      _emailController.text = state.email ?? "";
      String image = state.image ?? "";
      return WillPopScope(
        onWillPop: onWillPop,
        child: LayoutBuilder(builder: (BuildContext ctx, BoxConstraints constraints) {
          if (width > SizeConstants.tabWidth) {
            return Scaffold(
                resizeToAvoidBottomInset: true,
                body: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: Stack(children: [
                      Row(
                        children: [
                          const LogoScreen(),
                          Form(
                            key: _key,
                            child: SizedBox(
                                height: height,
                                width: width * 0.5,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Container(
                                            margin: EdgeInsets.only(top: width * 0.04),
                                            child: Text(
                                              "Edit profile",
                                              style: TextStyle(fontSize: 20, fontFamily: FontFamily.montserrat),
                                            )),
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(top: 30),
                                          child: Center(
                                              child: Stack(alignment: Alignment.bottomRight, children: [
                                            SizedBox(
                                              height: 100,
                                              width: 100,
                                              child: GestureDetector(
                                                onTap: () {
                                                  // _startFilePicker();
                                                  debugPrint("tab");
                                                },
                                                child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(50),
                                                    child: _pickedImage == null
                                                        ? Image.network(
                                                            image,
                                                            fit: BoxFit.fill,
                                                            errorBuilder: (context, url, error) => Image.asset(
                                                              appImages.projectInfo,
                                                              height: width * 0.05,
                                                              width: width * 0.05,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          )
                                                        : Image.memory(
                                                            webImage,
                                                            fit: BoxFit.fill,
                                                          )),
                                              ),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  _pickImage();
                                                },
                                                icon: const Icon(Icons.add))
                                          ]))),
                                      Container(
                                        margin: const EdgeInsets.only(top: 20),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                                          child: TextFormField(
                                            controller: _nameController,
                                            keyboardType: TextInputType.name,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(13)),
                                                labelText: "Name",
                                                hintText: "Enter Name"),
                                            validator: (name) {
                                              if (name == null || name.isEmpty) {
                                                return "StringConstants.yourNameRequired";
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                                        child: TextFormField(
                                          enabled: false,
                                          controller: _emailController,
                                          keyboardType: TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(13),
                                              ),
                                              labelText: 'Email',
                                              hintText: "Enter Your Email"),
                                          validator: (email) {
                                            if (email == null || email.isEmpty) {
                                              return "StringConstants.yourEmailRequired";
                                            } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                .hasMatch(email)) {
                                              return "";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      // SelectState(
                                      //   // style: TextStyle(color: Colors.red),
                                      //   onCountryChanged: (value) {
                                      //     setState(() {
                                      //       countryValue = value;
                                      //     });
                                      //   },
                                      //   onStateChanged:(value) {
                                      //     setState(() {
                                      //       stateValue = value;
                                      //     });
                                      //   },
                                      //   onCityChanged:(value) {
                                      //     setState(() {
                                      //       cityValue = value;
                                      //     });
                                      //   },
                                      //
                                      // ),

                                      // Align(
                                      //   child: Container(
                                      //     margin: EdgeInsets.only(right: 30),
                                      //     alignment: Alignment.centerRight,
                                      //     child: Text("${counterpassword}/10"),
                                      //   ),
                                      // ),
                                      Container(
                                        width: width * 0.2,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(39),
                                            topLeft: Radius.circular(39),
                                            bottomRight: Radius.circular(39),
                                            bottomLeft: Radius.circular(39),
                                          ),
                                          color: ColorConstants.darkBrown,
                                        ),
                                        margin: const EdgeInsets.only(top: 10),
                                        child: TextButton(
                                          child: Text(
                                            'Save Changes',
                                            style: TextStyle(fontFamily: FontFamily.montserrat, color: Colors.white, fontSize: width * 0.015),
                                          ),
                                          onPressed: () async {
                                            if (_key.currentState!.validate()) {
                                              if (_pickedImage != null) {
                                                String base64Image = base64Encode(webImage);
                                                debugPrint("The converted image is ++++++ $base64Image");
                                                triggerCreateAccountEvent(
                                                    UpdateProfileEvent(context: context, name: _nameController.text, photo: base64Image));
                                              } else {
                                                triggerCreateAccountEvent(UpdateProfileEvent(
                                                  context: context,
                                                  name: _nameController.text,
                                                ));
                                              }
                                              // await SharedPref.setString(key: "user-name", data: _nameController.text);
                                              triggerCreateAccountEvent(GetUserDetailsEvent(context: context));
                                              // await SharedPref.setString(key: "user-name", data: _nameController.text);
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ],
                      ),
                      InkWell(
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
                    ])));
          } else {
            return Scaffold(
                resizeToAvoidBottomInset: true,
                body: GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(top: height * 0.090, left: 12, right: 12),
                      child: Form(
                        key: _formkey,
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
                            Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: GestureDetector(
                                      onTap: () {
                                        // _startFilePicker();
                                        debugPrint("tab");
                                      },
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child: _pickedImage == null
                                              ? Image.network(
                                                  image,
                                                  fit: BoxFit.fill,
                                                  errorBuilder: (context, url, error) => Image.asset(
                                                    appImages.projectInfo,
                                                    fit: BoxFit.fill,
                                                  ),
                                                )
                                              : Image.memory(
                                                  webImage,
                                                  fit: BoxFit.fill,
                                                )),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    left: 65,
                                    child: GestureDetector(
                                      onTap: () async {
                                        _pickImage();
                                      },
                                      child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor: ColorConstants.darkBrown,
                                          child: const Icon(
                                            Icons.add_a_photo,
                                            color: Colors.white,
                                            size: 20,
                                          )),
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            TextFormField(
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Name is required.';
                                } else if (value.length > 50) {
                                  return 'Name may not be greater than 50 characters';
                                } else {
                                  _nameController.text = value;
                                  return '';
                                }
                              },
                              controller: _nameController,
                              decoration: InputDecoration(
                                errorMaxLines: 3,
                                fillColor: Colors.blue,
                                labelText: 'Name',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                    )),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                errorMaxLines: 3,
                                fillColor: Colors.blue,
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                    )),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomRaisedButton(
                              onPressed: () async {
                                if (_pickedImage != null) {
                                  String base64Image = base64Encode(webImage);
                                  debugPrint("The converted image is ++++++ $base64Image");
                                  triggerCreateAccountEvent(UpdateProfileEvent(context: context, name: _nameController.text, photo: base64Image));
                                } else {
                                  triggerCreateAccountEvent(UpdateProfileEvent(
                                    context: context,
                                    name: _nameController.text,
                                  ));
                                }
                                // await SharedPref.setString(key: "user-name", data: _nameController.text);
                                triggerCreateAccountEvent(GetUserDetailsEvent(context: context));
                                // await SharedPref.setString(key: "user-name", data: _nameController.text);
                              },
                              color: ColorConstants.darkBrown,
                              text: 'Save Changes',
                              size: 14,
                              textColor: Colors.white,
                              height: height * 0.07,
                              width: width * 0.97,
                              fontFamily: FontFamily.montserrat,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
          }
        }),
      );
    });
  }
}
