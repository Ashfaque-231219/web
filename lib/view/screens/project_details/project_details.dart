import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_network/image_network.dart';
import 'package:web/Routing/routing.gr.dart' as route;
import 'package:web/helper/constants/colors.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/helper/constants/images.dart';
import 'package:web/helper/constants/size_constants.dart';
import 'package:web/helper/constants/string.dart';
import 'package:web/helper/utils/common_methods.dart';
import 'package:web/models/response/project_details_modal.dart';
import 'package:web/view-model/projectDetailBloc/project_detail_bloc.dart';
import 'package:web/view/screens/dashboard/user_mail_dialog.dart';
import 'package:web/view/screens/project_details/maintenance_list.dart';
import 'package:web/view/screens/project_details/project_punch_list.dart';
import 'package:web/view/screens/project_details/project_reports.dart';
import 'package:web/view/screens/project_details/site_inspection_list.dart';
import 'package:web/view/screens/report/create_report.dart';
import 'package:web/view/shared_widget/custom_label.dart';
import 'package:web/view/shared_widget/custom_raised_button.dart';
import 'package:web/view/shared_widget/custom_search_bar.dart';

class ProjectDetails extends StatefulWidget {
  final int id;

  const ProjectDetails({@PathParam('id') required this.id, Key? key}) : super(key: key);

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> with TickerProviderStateMixin {
  TabController? _tabController;
  String buttonText = '';
  int index = 0;
  TextEditingController searchController = TextEditingController();

  late ScrollController _scrollController;
  BuildContext? buildContext;
  ProjectsDetail projectDetails = ProjectsDetail();
  List<Reports?> reports = [];
  List<PunchLists?> punchList = [];
  String date = '';
  List<Maintenance?>? maintenanceList;
  List<ScheduleList?>? scheduleList;
  List<TaskList?>? taskList;
  List<String>? reportId = [];
  String? reportType = '';

  //Offset state <-------------------------------------
  double offset = 0.0;

  triggerGetListEvent(ProjectDetailEvent event) {
    context.read<ProjectDetailBloc>().add(event);
  }

  @override
  void initState() {
    _scrollController = ScrollController() //keepScrollOffset: false removed
      ..addListener(() {
        setState(() {
          //<-----------------------------
          offset = _scrollController.offset;
          // force a refresh so the app bar can be updated
        });
      });

    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController!.addListener(() {
      index = _tabController!.index;
      if (_tabController!.index == 0) {
        buttonText = appString.createReport;
      } else if (_tabController!.index == 1) {
        buttonText = appString.addMaintenance;
      } else {
        buttonText = appString.addItem;
      }
      setState(() {});
      // if (buildContext != null) {
      // triggerGetListEvent(GetProjectDetailsEvent(context: buildContext!, projectId: widget.id.toString()));
      // }
    });

    triggerGetListEvent(GetProjectDetailsEvent(context: context, projectId: widget.id.toString()));

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    // html.window.onBeforeUnload.listen((event) async {
    //   Navigator.pushNamed(context, RoutesConst.homePage + RoutesConst.projectDetails, arguments: {"id": widget.id});
    // });

    buildContext = context;
    return BlocBuilder<ProjectDetailBloc, ProjectDetailState>(builder: (context, state) {
      if (state is GetProjectDetailsState) {
        if (state.projectDetails != null && state.projectDetails!.data != null) {
          if (state.projectDetails!.data!.projectDetails != null &&
              state.projectDetails!.data!.projectDetails![0] != null) {
            projectDetails = state.projectDetails!.data!.projectDetails![0]!;
          }
          if (state.projectDetails!.data!.reports != null) {
            reports = state.projectDetails!.data!.reports!;
          }
          if (state.projectDetails!.data!.punchList != null) {
            punchList = state.projectDetails!.data!.punchList!;
          }
          if (state.projectDetails!.data!.maintenance != null) {
            maintenanceList = state.projectDetails!.data!.maintenance!;
          }
          if (state.projectDetails!.data!.scheduleList != null) {
            scheduleList = state.projectDetails!.data!.scheduleList!;
            print("schedule list List =========>>>>>>>> $scheduleList");
          }
          if (state.projectDetails!.data!.taskList != null) {
            taskList = state.projectDetails!.data!.taskList!;
            print("task list List =========>>>>>>>> $taskList");
          }

          if (projectDetails.projectStartDate != null && projectDetails.projectEndDate != null) {
            date =
                '${CommonMethods.dateFormatterYMDate(projectDetails.projectStartDate!)} - ${CommonMethods.dateFormatterYMDate(projectDetails.projectEndDate!)}';
          }
          return LayoutBuilder(builder: (BuildContext ctx, BoxConstraints constraints) {
            if (width > SizeConstants.tabWidth) {
              return Scaffold(
                backgroundColor: Color(appColors.whiteF6F6F6),
                body: Center(
                  child: Container(
                    width: width * 0.7,
                    margin: EdgeInsets.all(appDimen.sp20),
                    child: NestedScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                        return [
                          SliverToBoxAdapter(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    InkWell(
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
                                      width: appDimen.sp20,
                                    ),
                                    Expanded(
                                      child: CustomLabel(
                                        text: 'Project Details',
                                        size: appDimen.sp16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      width: appDimen.sp20,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        context
                                            .pushRoute(route.ProjectInfo(projectId: widget.id))
                                            /*Navigator.pushNamed(
                                          context,
                                          RoutesConst.homePage + RoutesConst.projectInfo,
                                          arguments: {"id": widget.id},
                                        )*/
                                            .then(
                                              (value) => triggerGetListEvent(
                                                GetProjectDetailsEvent(
                                                  context: context,
                                                  projectId: widget.id.toString(),
                                                ),
                                              ),
                                            );
                                      },
                                      child: SvgPicture.asset(
                                        appImages.info,
                                        width: appDimen.sp27,
                                        height: appDimen.sp27,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: appDimen.sp20,
                                ),
                                SizedBox(
                                  // width: width,
                                  // height: height * 0.18,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(appDimen.sp5),
                                        ),
                                        width: width * 0.08,
                                        height: width * 0.08,
                                        child:ImageNetwork(
                                            image: projectDetails.logo.toString(),
                                            height: height * 0.08,
                                            width: width * 0.08,
                                            fitWeb: BoxFitWeb.contain,
                                            imageCache: CachedNetworkImageProvider(projectDetails.logo.toString()))
                                        /* Image.network(projectDetails.logo.toString())*/,
                                      ),
                                      SizedBox(
                                        width: appDimen.sp20,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                CustomLabel(
                                                  text: projectDetails.projectName ?? '',
                                                  size: appDimen.sp22,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                CustomLabel(
                                                  text: "(Reference No.- ${projectDetails.projectCode ?? ''})",
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: appDimen.sp5,
                                            ),
                                            (projectDetails.projectCategory != null)
                                                ? SingleChildScrollView(
                                                    scrollDirection: Axis.horizontal,
                                                    child: Row(
                                                      children: [
                                                        for (var cat in projectDetails.projectCategory!)
                                                          cat != null
                                                              ? Container(
                                                                  padding: EdgeInsets.all(
                                                                    appDimen.sp3,
                                                                  ),
                                                                  margin: EdgeInsets.only(right: appDimen.sp3),
                                                                  decoration: BoxDecoration(
                                                                    color: Color(
                                                                      appColors.getColorHexFromStr(
                                                                        cat.color.toString(),
                                                                      ),
                                                                    ),
                                                                    borderRadius: BorderRadius.circular(appDimen.sp5),
                                                                  ),
                                                                  child: CustomLabel(
                                                                    text: cat.name.toString(),
                                                                    color: Color(appColors.grey5C5C5C),
                                                                    size: appDimen.sp11,
                                                                  ),
                                                                )
                                                              : Container(),
                                                      ],
                                                    ),
                                                  )
                                                : Container(),
                                            SizedBox(
                                              height: appDimen.sp5,
                                            ),
                                            CustomLabel(
                                              text: projectDetails.address ?? '',
                                              fontWeight: FontWeight.w400,
                                            ),
                                            SizedBox(
                                              height: appDimen.sp5,
                                            ),
                                            CustomLabel(
                                              text: date,
                                              fontWeight: FontWeight.w400,
                                              maxLines: 1,
                                              color: Color(appColors.brown840000),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: appDimen.sp20,
                                ),
                                Divider(
                                  thickness: appDimen.sp1,
                                  height: appDimen.sp1,
                                ),
                                SizedBox(
                                  height: appDimen.sp20,
                                ),
                              ],
                            ),
                          )
                        ];
                      },
                      body: Column(
                        children: [
                          Flexible(
                            child: DefaultTabController(
                              length: 4,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(appColors.white),
                                      borderRadius: BorderRadius.circular(appDimen.sp5),
                                    ),
                                    child: TabBar(
                                      controller: _tabController,
                                      indicatorColor: Colors.transparent,
                                      unselectedLabelColor: Color(appColors.grey4C525E),
                                      unselectedLabelStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: appDimen.sp17,
                                      ),
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: appDimen.sp17,
                                      ),
                                      indicator: BoxDecoration(
                                        borderRadius: BorderRadius.circular(appDimen.sp5),
                                        color: Color(appColors.brown840000),
                                      ),
                                      tabs: [
                                        Tab(
                                          text: appString.reports,
                                          height: appDimen.sp40,
                                        ),
                                        Tab(
                                          text: appString.maintenance,
                                          height: appDimen.sp40,
                                        ),
                                        Tab(
                                          text: appString.punchList,
                                          height: appDimen.sp40,
                                        ),
                                        Tab(
                                          text: appString.siteInspection,
                                          height: appDimen.sp40,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: index != 2 && index != 3,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: appDimen.sp20),
                                      child: CustomSearchBar(
                                        hint: index == 0 ? 'Find your project reports' : 'Find your reports',
                                        controller: searchController,
                                        filter: true,
                                        onChanged: (value) {
                                          if (index == 0) {
                                            triggerGetListEvent(
                                              GetProjectDetailsEvent(
                                                context: context,
                                                projectId: widget.id.toString(),
                                                search: value,
                                                loading: false,
                                              ),
                                            );
                                          } else if (index == 1) {
                                            triggerGetListEvent(
                                              GetProjectDetailsEvent(
                                                context: context,
                                                projectId: widget.id.toString(),
                                                maintenanceSearch: value,
                                                loading: false,
                                              ),
                                            );
                                          } else {
                                            triggerGetListEvent(
                                              GetProjectDetailsEvent(
                                                context: context,
                                                projectId: widget.id.toString(),
                                                punchSearch: value,
                                                loading: false,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: SizedBox(
                                      // height: 500,
                                      width: width * 0.7,
                                      child: TabBarView(
                                        controller: _tabController,
                                        children: [
                                          ProjectReports(
                                            reports: reports,
                                            refresh: refresh,
                                            share: shareReport,
                                          ),
                                          MaintenanceList(
                                            maintenanceList: maintenanceList,
                                            refresh: refresh,
                                            projectId: widget.id,
                                            share: shareReport,
                                          ),
                                          ProjectPunchList(
                                            punchList: punchList,
                                            refresh: refresh,
                                            projectId: widget.id,
                                            share: shareReport,
                                          ),
                                          SiteInspectionList(
                                            projectId: widget.id.toString(),
                                            scheduleList: scheduleList,
                                            taskList: taskList,
                                            refresh: refresh,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: index != 3,
                            child: CustomRaisedButton(
                              width: width * 0.2,
                              text: buttonText.isEmpty ? "+ ${appString.createReport}" : "+ $buttonText",
                              color: Color(appColors.brown840000),
                              textColor: Color(appColors.white),
                              sideColor: Color(appColors.white),
                              onPressed: () {
                                navigate();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Scaffold(
                backgroundColor: Color(appColors.whiteF6F6F6),
                body: Container(
                  width: width * 0.9,
                  margin: EdgeInsets.all(appDimen.sp20),
                  child: NestedScrollView(
                    scrollDirection: Axis.vertical,
                    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                      return [
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      context.router.navigateBack();
                                      // context.router.navigateBack();
                                    },
                                    child: SvgPicture.asset(
                                      appImages.backBlack,
                                      width: width * 0.05,
                                      height: width * 0.05,
                                    ),
                                  ),
                                  SizedBox(
                                    width: appDimen.sp20,
                                  ),
                                  Expanded(
                                    child: CustomLabel(
                                      text: 'Project Details',
                                      size: width * 0.037,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    width: appDimen.sp20,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      context
                                          .pushRoute(route.ProjectInfo(projectId: widget.id))
                                          /*Navigator.pushNamed(
                                        context,
                                        RoutesConst.homePage + RoutesConst.projectInfo,
                                        arguments: {"id": widget.id},
                                      )*/
                                          .then(
                                            (value) => triggerGetListEvent(
                                              GetProjectDetailsEvent(
                                                context: context,
                                                projectId: widget.id.toString(),
                                              ),
                                            ),
                                          );
                                    },
                                    child: SvgPicture.asset(
                                      appImages.info,
                                      width: width * 0.04,
                                      height: width * 0.04,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: appDimen.sp20,
                              ),
                              SizedBox(
                                // width: width,
                                // height: height * 0.18,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(appColors.blueBFFBFF),
                                        borderRadius: BorderRadius.circular(appDimen.sp5),
                                      ),
                                      width: width * 0.3,
                                      height: width * 0.3,
                                      child: ImageNetwork(
                                          image: projectDetails.logo.toString(),
                                          width: width * 0.3,
                                          height: width * 0.3,
                                          fitWeb: BoxFitWeb.contain,
                                          imageCache: CachedNetworkImageProvider(projectDetails.logo.toString())),
                                    ),
                                    SizedBox(
                                      width: appDimen.sp5,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              CustomLabel(
                                                text: projectDetails.projectName ?? '',
                                                size: width * 0.037,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              Expanded(
                                                child: CustomLabel(
                                                  text: "(Reference No.- ${projectDetails.projectCode ?? ''})",
                                                  size: width * 0.03,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: width * 0.01,
                                          ),
                                          (projectDetails.projectCategory != null)
                                              ? SingleChildScrollView(
                                                  scrollDirection: Axis.horizontal,
                                                  child: Row(
                                                    children: [
                                                      for (var cat in projectDetails.projectCategory!)
                                                        cat != null
                                                            ? Container(
                                                                padding: EdgeInsets.all(
                                                                  appDimen.sp3,
                                                                ),
                                                                margin: EdgeInsets.only(right: appDimen.sp3),
                                                                decoration: BoxDecoration(
                                                                  color: Color(
                                                                    appColors.getColorHexFromStr(cat.color.toString()),
                                                                  ),
                                                                  borderRadius: BorderRadius.circular(appDimen.sp5),
                                                                ),
                                                                child: CustomLabel(
                                                                  text: cat.name.toString(),
                                                                  color: Color(appColors.grey5C5C5C),
                                                                  size: appDimen.sp11,
                                                                ),
                                                              )
                                                            : Container(),
                                                    ],
                                                  ),
                                                )
                                              : Container(),
                                          SizedBox(
                                            height: width * 0.02,
                                          ),
                                          CustomLabel(
                                            text: projectDetails.address ?? '',
                                            size: width * 0.03,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          SizedBox(
                                            height: height * 0.01,
                                          ),
                                          CustomLabel(
                                            text: date,
                                            fontWeight: FontWeight.w400,
                                            maxLines: 1,
                                            color: Color(appColors.brown840000),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: appDimen.sp20,
                              ),
                              Divider(
                                thickness: appDimen.sp1,
                                height: appDimen.sp1,
                              ),
                              SizedBox(
                                height: appDimen.sp20,
                              ),
                            ],
                          ),
                        )
                      ];
                    },
                    body: Column(
                      children: [
                        Flexible(
                          child: DefaultTabController(
                            length: 4,
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(appColors.white),
                                    borderRadius: BorderRadius.circular(appDimen.sp5),
                                  ),
                                  child: TabBar(
                                    controller: _tabController,
                                    indicatorColor: Colors.transparent,
                                    unselectedLabelColor: Color(appColors.grey4C525E),
                                    unselectedLabelStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: appDimen.sp17,
                                    ),
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: appDimen.sp17,
                                    ),
                                    indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(appDimen.sp5),
                                      color: Color(appColors.brown840000),
                                    ),
                                    isScrollable: !(width > SizeConstants.mobileWidth),
                                    tabs: [
                                      Tab(
                                        text: appString.reports,
                                        height: appDimen.sp40,
                                      ),
                                      Tab(
                                        text: appString.maintenance,
                                        height: appDimen.sp40,
                                      ),
                                      Tab(
                                        text: appString.punchList,
                                        height: appDimen.sp40,
                                      ),
                                      Tab(
                                        text: appString.siteInspection,
                                        height: appDimen.sp40,
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: index != 2 && index != 3,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: appDimen.sp20),
                                    child: CustomSearchBar(
                                      hint: index == 0 ? 'Find your project reports' : 'Find your reports',
                                      controller: searchController,
                                      filter: true,
                                      onChanged: (value) {
                                        debugPrint(value);
                                        if (index == 0) {
                                          triggerGetListEvent(
                                            GetProjectDetailsEvent(
                                              context: context,
                                              projectId: widget.id.toString(),
                                              search: value,
                                              loading: false,
                                            ),
                                          );
                                        } else if (index == 1) {
                                          triggerGetListEvent(
                                            GetProjectDetailsEvent(
                                              context: context,
                                              projectId: widget.id.toString(),
                                              maintenanceSearch: value,
                                              loading: false,
                                            ),
                                          );
                                        } else {
                                          triggerGetListEvent(
                                            GetProjectDetailsEvent(
                                              context: context,
                                              projectId: widget.id.toString(),
                                              punchSearch: value,
                                              loading: false,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: SizedBox(
                                    // height: 500,
                                    width: width * 0.9,
                                    child: TabBarView(
                                      controller: _tabController,
                                      children: [
                                        ProjectReports(
                                          reports: reports,
                                          refresh: refresh,
                                          share: shareReport,
                                        ),
                                        MaintenanceList(
                                          maintenanceList: maintenanceList,
                                          refresh: refresh,
                                          projectId: widget.id,
                                          share: shareReport,
                                        ),
                                        ProjectPunchList(
                                          punchList: punchList,
                                          refresh: refresh,
                                          projectId: widget.id,
                                          share: shareReport,
                                        ),
                                        SiteInspectionList(
                                          projectId: widget.id.toString(),
                                          scheduleList: scheduleList,
                                          taskList: taskList,
                                          refresh: refresh,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: index != 3,
                          child: CustomRaisedButton(
                            width: width * 0.9,
                            text: buttonText.isEmpty ? "+ ${appString.createReport}" : "+ $buttonText",
                            color: Color(appColors.brown840000),
                            textColor: Color(appColors.white),
                            sideColor: Color(appColors.white),
                            onPressed: () {
                              navigate();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          });
        }
      }

      if (state is GetReportUsersState) {
        Future.delayed(Duration.zero, () async {
          List<String>? emailsList = await showDialog(
              context: context,
              builder: (context) {
                return UserMailDialog(
                  getShareUsersList: state.shareModal,
                );
              });
          if (emailsList != null && emailsList.isNotEmpty) {
            print("Emails for the reports == $emailsList");
            if (buildContext != null) {
              triggerGetListEvent(ShareEvent(
                context: buildContext!,
                reportId: reportId,
                mailId: emailsList,
                reportType: reportType,
              ));
              triggerGetListEvent(
                  GetProjectDetailsEvent(context: context, projectId: widget.id.toString(), loading: false));
            }
          }
        });
        triggerGetListEvent(GetProjectDetailsEvent(context: context, projectId: widget.id.toString(), loading: false));
      }

      debugPrint(projectDetails.toString());

      return Container();
    });
  }

  navigate() {
    if (index == 0) {
      showDialog(
        context: context,
        builder: (context) {
          return CreateReport(
            projectId: widget.id.toString(),
            refresh: refresh,
          );
        },
      ).then((value) => refresh());
    } else if (index == 1) {
      context.pushRoute(route.MaintenanceReportFormPage(projectId: widget.id)).then((value) => refresh());
    } else {
      // Navigator.pushNamed(
      //   context,
      //   RoutesConst.homePage + RoutesConst.punchList,
      //   arguments: {
      //     "projectId": widget.id,
      //     "resolve": false,
      //   },
      // ).then((value) => refresh());
      context.pushRoute(route.PunchList(projectId: widget.id)).then((value) => refresh());
    }
  }

  shareReport(List<String> reportId, String reportType) async {
    this.reportId = reportId;
    this.reportType = reportType;

    if (buildContext != null) {
      await triggerGetListEvent(
        GetReportUsersEvent(
          context: buildContext!,
          reportId: reportId,
          reportType: reportType,
        ),
      );
    }
    // refresh();
  }

  refresh() async {
    // _tabController?.animateTo(0);
    if (buildContext != null) {
      await triggerGetListEvent(
        GetProjectDetailsEvent(
          context: buildContext!,
          projectId: widget.id.toString(),
          search: '',
          maintenanceSearch: '',
          punchSearch: '',
        ),
      );
    }
  }
}
