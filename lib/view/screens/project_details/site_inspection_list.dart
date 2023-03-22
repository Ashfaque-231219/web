import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/helper/constants/colors.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/helper/constants/size_constants.dart';
import 'package:web/helper/constants/string.dart';
import 'package:web/models/response/project_details_modal.dart';
import 'package:web/view-model/projectDetailBloc/project_detail_bloc.dart';
import 'package:web/view/screens/sipr/schedule_form_page.dart';
import 'package:web/view/screens/sipr/tasks_form_page.dart';
import 'package:web/view/shared_widget/custom_label.dart';
import 'package:web/view/shared_widget/custom_raised_button.dart';

import '../../../models/schedule_model/ViewScheduleModelData.dart';

class SiteInspectionList extends StatefulWidget {
  const SiteInspectionList({this.projectId = '', this.scheduleList, this.taskList, this.createPage = false, this.refresh, Key? key}) : super(key: key);
  final String? projectId;
  final List<ScheduleList?>? scheduleList;
  final List<TaskList?>? taskList;
  final bool? createPage;
  final Function? refresh;

  @override
  State<SiteInspectionList> createState() => _SiteInspectionListState();
}

class _SiteInspectionListState extends State<SiteInspectionList> with TickerProviderStateMixin {
  TabController? _tabController;
  TextEditingController searchController = TextEditingController();
  bool addMoreSchedule = false;
  bool addMoreTasks = false;
  bool refreshPage = false;

  // final imgUrl =
  //     "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";
  // var dio = Dio();
  List<ScheduleList?>? scheduleList;
  List<TaskList?>? taskList;
  ScrollController scheduleScrollController = ScrollController();
  ScrollController taskScrollController = ScrollController();

  triggerGetListEvent(ProjectDetailEvent event) {
    context.read<ProjectDetailBloc>().add(event);
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController!.addListener(() {
      setState(() {});
    });
    scheduleList = widget.scheduleList;
    taskList = widget.taskList;
    // triggerGetListEvent(GetProjectDetailsEvent(context: context, projectId: widget.projectId));

    super.initState();
  }

  ViewScheduleModel? viewScheduleModel;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<ProjectDetailBloc, ProjectDetailState>(
      builder: (context, state) {
        if (state is GetProjectDetailsState) {
          if (state.projectDetails!.data!.scheduleList != null) {
            scheduleList = state.projectDetails!.data!.scheduleList!;
          }
          if (state.projectDetails!.data!.taskList != null) {
            taskList = state.projectDetails!.data!.taskList!;
          }
        }

        print("state======= $state");
        
        if (state is GenerateReportState && refreshPage) {
          refreshPage = false;
          refresh();
          // triggerGetListEvent(GetProjectDetailsEvent(context: context, projectId: widget.projectId));
        }

        return LayoutBuilder(builder: (BuildContext ctx, BoxConstraints constraints) {
          if (width > SizeConstants.tabWidth) {
            return DefaultTabController(
              length: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: appDimen.sp20,
                  ),
                  widget.createPage!
                      ? TabBar(
                          controller: _tabController,
                          indicatorColor: Colors.transparent,
                          unselectedLabelColor: Color(appColors.grey4C525E),
                          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: appDimen.sp17),
                          labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: appDimen.sp17),
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(appDimen.sp5),
                            color: Color(appColors.brown840000),
                          ),
                          tabs: [
                            Tab(
                              text: appString.schedule,
                              height: appDimen.sp40,
                            ),
                            Tab(
                              text: appString.tasks,
                              height: appDimen.sp40,
                            ),
                          ],
                        )
                      : TabBar(
                          controller: _tabController,
                          indicatorColor: Color(appColors.brown840000),
                          labelColor: Color(appColors.black242425),
                          unselectedLabelColor: Color(appColors.grey4C525E),
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorWeight: 1.0,
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: appDimen.sp17,
                          ),
                          isScrollable: true,
                          tabs: [
                            SizedBox(
                              width: appDimen.sp100,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Tab(
                                  text: appString.schedule,
                                  height: appDimen.sp30,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: appDimen.sp100,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Tab(
                                  text: appString.tasks,
                                  height: appDimen.sp30,
                                ),
                              ),
                            ),
                          ],
                        ),
                  SizedBox(
                    height: appDimen.sp20,
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: SizedBox(
                      // height: 600,
                      width: MediaQuery.of(context).size.width,
                      child: TabBarView(
                        controller: _tabController,
                        children: <Widget>[
                          scheduleList != null && scheduleList!.isNotEmpty
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        controller: scheduleScrollController,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListView.separated(
                                              shrinkWrap: true,
                                              itemCount: scheduleList!.length,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, int index) {
                                                return ScheduleFormPage(
                                                  view: true,
                                                  projectId: widget.projectId.toString(),
                                                  scheduleList: widget.scheduleList?[index],
                                                  refresh: refresh,
                                                );
                                              },
                                              separatorBuilder: (BuildContext context, int index) {
                                                return SizedBox(
                                                  height: appDimen.sp10,
                                                );
                                              },
                                            ),
                                            Visibility(
                                              visible: addMoreSchedule,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(vertical: appDimen.sp10),
                                                child: ScheduleFormPage(
                                                  projectId: widget.projectId.toString(),
                                                  refresh: refresh,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        addMoreSchedule = true;
                                        scheduleScrollController.animateTo(scheduleScrollController.position.maxScrollExtent,
                                            duration: const Duration(seconds: 1), curve: Curves.ease);
                                        setState(() {});
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: appDimen.sp10),
                                        child: CustomLabel(
                                          text: '+ Add more',
                                          color: Color(appColors.brown840000),
                                          size: appDimen.sp15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Visibility(
                                          visible: addMoreSchedule,
                                          child: ScheduleFormPage(
                                            projectId: widget.projectId.toString(),
                                            refresh: refresh,
                                          )),
                                      InkWell(
                                        onTap: () {
                                          addMoreSchedule = true;
                                          setState(() {});
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: appDimen.sp10),
                                          child: CustomLabel(
                                            text: '+ Add more',
                                            color: Color(appColors.brown840000),
                                            size: appDimen.sp15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          taskList != null && taskList!.isNotEmpty
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        controller: taskScrollController,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ListView.separated(
                                              shrinkWrap: true,
                                              itemCount: taskList!.length,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, int index) {
                                                return TasksFormPage(
                                                  view: true,
                                                  projectId: widget.projectId.toString(),
                                                  taskList: widget.taskList?[index],
                                                  refresh: refresh,
                                                );
                                              },
                                              separatorBuilder: (BuildContext context, int index) {
                                                return SizedBox(
                                                  height: appDimen.sp10,
                                                );
                                              },
                                            ),
                                            Visibility(
                                              visible: addMoreTasks,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(vertical: appDimen.sp10),
                                                child: TasksFormPage(
                                                  projectId: widget.projectId,
                                                  refresh: refresh,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        addMoreTasks = true;
                                        taskScrollController.animateTo(taskScrollController.position.maxScrollExtent,
                                            duration: const Duration(seconds: 1), curve: Curves.ease);
                                        setState(() {});
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: appDimen.sp10),
                                        child: CustomLabel(
                                          text: '+ Add more',
                                          color: Color(appColors.brown840000),
                                          size: appDimen.sp15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: CustomRaisedButton(
                                        width: width * 0.2,
                                        text: "Generate Report",
                                        color: Color(appColors.brown840000),
                                        textColor: Color(appColors.white),
                                        sideColor: Color(appColors.white),
                                        onPressed: () {
                                          refreshPage = true;
                                          triggerGetListEvent(GenerateTaskReportEvent(context: context, projectId: widget.projectId));
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Visibility(
                                        visible: addMoreTasks,
                                        child: TasksFormPage(
                                          projectId: widget.projectId,
                                          refresh: refresh,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          addMoreTasks = true;
                                          setState(() {});
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: appDimen.sp10),
                                          child: CustomLabel(
                                            text: '+ Add more',
                                            color: Color(appColors.brown840000),
                                            size: appDimen.sp15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return DefaultTabController(
              length: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: appDimen.sp20,
                  ),
                  widget.createPage!
                      ? TabBar(
                          controller: _tabController,
                          indicatorColor: Colors.transparent,
                          unselectedLabelColor: Color(appColors.grey4C525E),
                          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: appDimen.sp17),
                          labelStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: appDimen.sp17),
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(appDimen.sp5),
                            color: Color(appColors.brown840000),
                          ),
                          tabs: [
                            Tab(
                              text: appString.schedule,
                              height: appDimen.sp40,
                            ),
                            Tab(
                              text: appString.tasks,
                              height: appDimen.sp40,
                            ),
                          ],
                        )
                      : TabBar(
                          controller: _tabController,
                          indicatorColor: Color(appColors.brown840000),
                          labelColor: Color(appColors.black242425),
                          unselectedLabelColor: Color(appColors.grey4C525E),
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorWeight: 1.0,
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: appDimen.sp17,
                          ),
                          isScrollable: true,
                          tabs: [
                            SizedBox(
                              width: width * 0.2,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Tab(
                                  text: appString.schedule,
                                  height: appDimen.sp30,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.2,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Tab(
                                  text: appString.tasks,
                                  height: appDimen.sp30,
                                ),
                              ),
                            ),
                          ],
                        ),
                  SizedBox(
                    height: appDimen.sp20,
                  ),
                  Flexible(
                    fit: FlexFit.loose,
                    child: SizedBox(
                      // height: 600,
                      width: MediaQuery.of(context).size.width,
                      child: TabBarView(
                        controller: _tabController,
                        children: <Widget>[
                          scheduleList != null && scheduleList!.isNotEmpty
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        controller: scheduleScrollController,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListView.separated(
                                              shrinkWrap: true,
                                              itemCount: scheduleList!.length,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, int index) {
                                                return ScheduleFormPage(
                                                  view: true,
                                                  projectId: widget.projectId.toString(),
                                                  scheduleList: widget.scheduleList?[index],
                                                  refresh: refresh,
                                                );
                                              },
                                              separatorBuilder: (BuildContext context, int index) {
                                                return SizedBox(
                                                  height: appDimen.sp10,
                                                );
                                              },
                                            ),
                                            Visibility(
                                              visible: addMoreSchedule,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(vertical: appDimen.sp10),
                                                child: ScheduleFormPage(
                                                  projectId: widget.projectId.toString(),
                                                  refresh: refresh,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        addMoreSchedule = true;
                                        scheduleScrollController.animateTo(scheduleScrollController.position.maxScrollExtent,
                                            duration: const Duration(seconds: 1), curve: Curves.ease);
                                        setState(() {});
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: appDimen.sp10),
                                        child: CustomLabel(
                                          text: '+ Add more',
                                          color: Color(appColors.brown840000),
                                          size: appDimen.sp15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Visibility(
                                          visible: addMoreSchedule,
                                          child: ScheduleFormPage(
                                            projectId: widget.projectId.toString(),
                                            refresh: refresh,
                                          )),
                                      InkWell(
                                        onTap: () {
                                          addMoreSchedule = true;
                                          setState(() {});
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: appDimen.sp10),
                                          child: CustomLabel(
                                            text: '+ Add more',
                                            color: Color(appColors.brown840000),
                                            size: appDimen.sp15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          taskList != null && taskList!.isNotEmpty
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        controller: taskScrollController,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ListView.separated(
                                              shrinkWrap: true,
                                              itemCount: taskList!.length,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, int index) {
                                                return TasksFormPage(
                                                  view: true,
                                                  projectId: widget.projectId.toString(),
                                                  taskList: widget.taskList?[index],
                                                  refresh: refresh,
                                                );
                                              },
                                              separatorBuilder: (BuildContext context, int index) {
                                                return SizedBox(
                                                  height: appDimen.sp10,
                                                );
                                              },
                                            ),
                                            Visibility(
                                              visible: addMoreTasks,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(vertical: appDimen.sp10),
                                                child: TasksFormPage(
                                                  projectId: widget.projectId,
                                                  refresh: refresh,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        addMoreTasks = true;
                                        taskScrollController.animateTo(taskScrollController.position.maxScrollExtent,
                                            duration: const Duration(seconds: 1), curve: Curves.ease);
                                        setState(() {});
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: appDimen.sp10),
                                        child: CustomLabel(
                                          text: '+ Add more',
                                          color: Color(appColors.brown840000),
                                          size: appDimen.sp15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: CustomRaisedButton(
                                        width: width * 0.8,
                                        text: "Generate Report",
                                        color: Color(appColors.brown840000),
                                        textColor: Color(appColors.white),
                                        sideColor: Color(appColors.white),
                                        onPressed: () {
                                          refreshPage = true;
                                          triggerGetListEvent(GenerateTaskReportEvent(context: context, projectId: widget.projectId));
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              : SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Visibility(
                                        visible: addMoreTasks,
                                        child: TasksFormPage(
                                          projectId: widget.projectId,
                                          refresh: refresh,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          addMoreTasks = true;
                                          setState(() {});
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: appDimen.sp10),
                                          child: CustomLabel(
                                            text: '+ Add more',
                                            color: Color(appColors.brown840000),
                                            size: appDimen.sp15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        });
      },
    );
  }

  refresh() {
    if(widget.refresh!=null){
      widget.refresh!();
    }else {
      triggerGetListEvent(GetProjectDetailsEvent(context: context, projectId: widget.projectId));
    }
  }
}
