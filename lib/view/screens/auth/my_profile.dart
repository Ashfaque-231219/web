import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/view/shared_widget/redwood_logo_screen.dart';

import '../../../helper/constants/image_constants.dart';
import '../../../route_generator.dart';
import '../../../view-model/authBloc/login_bloc.dart';
import '../../../view-model/authBloc/login_event.dart';
import '../../../view-model/authBloc/login_state.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {


  @override
  void initState() {
    // _loadUserEmailPassword();
    triggerAddItemEvent(GetUserDetailsEvent(context: context));

    super.initState();
  }

  triggerAddItemEvent(LoginEvent event) {
    context.read<LoginBloc>().add(event);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        final String? name = state.name;
        final String? email = state.email;
        final String? createdAt = state.createdAt;
        final String image = state.images ?? "";
        return
          Scaffold(
              body:
              Stack(
                children:[
                  Row(
                  children: [
                    const LogoScreen(),
                    SizedBox(
                      width: width * 0.4,
                      height: height,
                      child:
                      Column(
                        children: [
                          SizedBox(
                            height: height * 0.012,
                          ),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              margin: EdgeInsets.only(left: width * 0.12),
                              width: width * 0.05,
                              height: width * 0.05,
                              color: Colors.yellow,
                              child: Image.network(image),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.012,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: width * 0.12),
                            child: Text(
                              name ?? "",
                              style:
                              TextStyle(fontSize: width * 0.014),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.005,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: width * 0.12),
                            child: Text(
                              email ?? "",
                              style: TextStyle(
                                  fontSize: width * 0.014),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.1,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, RoutesConst.changePass);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: width * 0.03),
                                  child: Text(
                                    "Change Password",
                                    style: TextStyle(
                                        fontSize: width * 0.014),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, RoutesConst.editProfile);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: width * 0.03),
                                  child: Text(
                                    "Edit Profile",
                                    style: TextStyle(
                                        fontSize:
                                        width * 0.014),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: width * 0.03),
                                    child: Icon(
                                      Icons.logout,
                                      color: Colors.black,
                                      size: width * 0.014,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.005,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        triggerAddItemEvent(
                                            LogoutEvent(
                                                context:
                                                context));
                                      },
                                      child: Text(
                                        "Logout",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontSize:
                                            width * 0.014),
                                      ))
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.1,
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
                  GestureDetector(
                    onTap: (){
                      context.router.navigateBack();
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: width * 0.02,top: width * 0.02),
                      width: 30,
                      height: 30,
                      child: Image.asset(ImageConstants.backButton,fit: BoxFit.fill,),
                    ),
                  ),
                ]
              )
          );
      },
    );


  }
}
