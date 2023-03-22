import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/Routing/routing.gr.dart';
import 'package:web/helper/constants/color_constants.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/helper/constants/font_family.dart';
import 'package:web/helper/constants/size_constants.dart';
import 'package:web/helper/utils/shared_pref.dart';
import 'package:web/models/response/project_list_modal.dart';
import 'package:web/view-model/projectDetailBloc/project_detail_bloc.dart';
import 'package:web/view/screens/dashboard/project_tile.dart';
import 'package:web/view/shared_widget/custom_label.dart';
import 'package:web/view/shared_widget/custom_search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = '';
  List<ProjectDetailsList?>? projectDetails;
  String? date = '';
  String? projectCount = '';

  triggerGetListEvent(ProjectDetailEvent event) {
    context.read<ProjectDetailBloc>().add(event);
  }

  Future<bool> _onWillPop() async {
    return false;
  }

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    getUserDetails();
    triggerGetListEvent(GetProjectListEvent(context: context));
    super.initState();
  }

  getUserDetails() async {
    name = await SharedPref.getString(key: "user-name");
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // return BlocBuilder<LoginBloc, LoginState>(
    //   builder: (BuildContext context, state) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocBuilder<ProjectDetailBloc, ProjectDetailState>(
        builder: (context, state) {
          if (state is GetProjectListState) {
            if (state.projectList != null && state.projectList!.data != null) {
              date = state.projectList!.data!.currentDate;
              projectCount = state.projectList!.data!.projectCount.toString();
              projectDetails = state.projectList!.data!.projectDetails;
            }
          }
          debugPrint(projectDetails.toString());
          return WillPopScope(onWillPop: () async {
            return _onWillPop();
          }, child: LayoutBuilder(builder: (BuildContext ctx, BoxConstraints constraints) {
            //===================== Web View ====================//
            if (width > SizeConstants.tabWidth) {
              return Scaffold(
                  body: Container(
                color: ColorConstants.lightGrey,
                width: width,
                height: height,
                child: Column(children: [
                  SizedBox(
                    width: width * 0.5,
                    height: height * 0.82,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Text(
                          date.toString(),
                          style: TextStyle(
                              fontSize: width * 0.013,
                              color: ColorConstants.darkBrown,
                              fontFamily: FontFamily.montserrat,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Text(
                          "Hello $name!",
                          style: TextStyle(
                            fontSize: width * 0.018,
                            color: Colors.black,
                            fontFamily: FontFamily.montserrat,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Text(
                          "You have $projectCount projects assigned.",
                          style: TextStyle(
                            fontSize: width * 0.012,
                            color: Colors.black,
                            fontFamily: FontFamily.montserrat,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: appDimen.sp20),
                          child: CustomSearchBar(
                            hint: 'Find your projects',
                            controller: searchController,
                            onChanged: (value) {
                              debugPrint(value);
                              triggerGetListEvent(GetProjectListEvent(context: context, search: value));
                            },
                          ),
                        ),
                        projectDetails != null && projectDetails!.isNotEmpty
                            ? Flexible(
                                child: ListView.separated(
                                  separatorBuilder: (context, index) => SizedBox(
                                    height: appDimen.sp15,
                                  ),
                                  shrinkWrap: true,
                                  itemCount: projectDetails!.length,
                                  itemBuilder: (context, int index) {
                                    return InkWell(
                                        onTap: () {
                                          // context.goNamed('ProjectsDetails', params: {'id': (projectDetails![index]!.id ?? 0).toString()});
                                          int id = (projectDetails![index]!.id ?? 0);
                                          // context.go("/home-page/project-details/$id");
                                          // document.cookie = "clicked=true";
                                          // Navigator.pushNamed(
                                          //   context,
                                          //   RoutesConst.homePage + RoutesConst.projectDetails,
                                          //   arguments: {"id": id},
                                          // ).then((value) {
                                          //   triggerGetListEvent(GetProjectListEvent(context: context));
                                          // });
                                          context.pushRoute(ProjectDetails(id: id)).then(
                                              (value) => triggerGetListEvent(GetProjectListEvent(context: context)));
                                        },
                                        child: ProjectTile(
                                          projectDetailsList: projectDetails![index],
                                        ));
                                  },
                                ),
                              )
                            : const Center(
                                child: CustomLabel(
                                  text: 'No Record(s) Found!',
                                ),
                              ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                      ],
                    ),
                  ),
                  /*Container(
                      padding: EdgeInsets.only(left: width * 0.13),
                      width: width,
                      height: height * 0.08,
                      color: Colors.white,
                      child: Center(
                          child: Row(
                        children: [
                          Image.asset(ImageConstants.hollmarkImage, width: width * 0.01),
                          SizedBox(
                            width: width * 0.002,
                          ),
                          CustomLabel(
                            text: "Copyright 2021.All rights reserved",
                            size: appDimen.sp11,
                            fontWeight: FontWeight.w400,
                            color: Color(appColors.brown840000),
                          ),
                        ],
                      ))),*/
                ]),
              ));
            } else {
              // ================Mobile View ======================//
              return Scaffold(
                backgroundColor: ColorConstants.lightGrey,
                body: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 25, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: ColorConstants.lightGrey,
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: CustomLabel(
                          text: date.toString(),
                          color: ColorConstants.darkBrown,
                          fontFamily: FontFamily.montserrat,
                          fontWeight: FontWeight.bold,
                          size: 17,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: CustomLabel(
                          text: 'Hello $name!',
                          size: 23,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontFamily.montserrat,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: CustomLabel(
                          text: 'You have $projectCount Project assigned',
                          fontFamily: FontFamily.montserrat,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: appDimen.sp20),
                        child: CustomSearchBar(
                          hint: 'Find your projects',
                          controller: searchController,
                          onChanged: (value) {
                            debugPrint(value);
                            triggerGetListEvent(GetProjectListEvent(context: context, search: value));
                          },
                        ),
                      ),
                      projectDetails != null && projectDetails!.isNotEmpty
                          ? Flexible(
                              child: ListView.separated(
                                  separatorBuilder: (context, index) => SizedBox(
                                        height: appDimen.sp15,
                                      ),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: projectDetails!.length,
                                  itemBuilder: (context, int index) {
                                    return InkWell(
                                        onTap: () {
                                          int id = (projectDetails![index]!.id ?? 0);
                                          // document.cookie = "clicked=true";
                                          // Navigator.pushNamed(
                                          //   context,
                                          //   RoutesConst.homePage + RoutesConst.projectDetails,
                                          //   arguments: {"id": id},
                                          // ).then((value) {
                                          //   // document.cookie = "clicked=";
                                          //   triggerGetListEvent(GetProjectListEvent(context: context));
                                          // });

                                          context.pushRoute(ProjectDetails(id: id)).then(
                                              (value) => triggerGetListEvent(GetProjectListEvent(context: context)));
                                        },
                                        child: ProjectTile(
                                          mobileView: true,
                                          projectDetailsList: projectDetails![index],
                                        ));
                                  }),
                            )
                          : const Center(
                              child: CustomLabel(
                                text: 'No Record(s) Found!',
                              ),
                            ),
                    ],
                  ),
                ),
              );
            }
          }));
        },
      ),
    );
    //   },
    // );
  }
}
