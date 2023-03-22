import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web/Routing/routing.gr.dart';
import 'package:web/helper/constants/colors.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/helper/constants/images.dart';
import 'package:web/helper/constants/size_constants.dart';
import 'package:web/helper/constants/string.dart';
import 'package:web/helper/utils/common_methods.dart';
import 'package:web/models/response/project_details_modal.dart';
import 'package:web/view-model/projectDetailBloc/project_detail_bloc.dart';
import 'package:web/view/shared_widget/custom_label.dart';
import 'package:web/view/shared_widget/custom_raised_button.dart';

class MaintenanceList extends StatefulWidget {
  const MaintenanceList({this.maintenanceList, this.refresh, this.share, this.projectId, Key? key}) : super(key: key);
  final List<Maintenance?>? maintenanceList;

  final Function? refresh;
  final Function? share;
  final int? projectId;

  @override
  State<MaintenanceList> createState() => _MaintenanceListState();
}

class _MaintenanceListState extends State<MaintenanceList> with TickerProviderStateMixin {
  TabController? _tabController;
  bool allTab = true;
  List<Maintenance?>? maintenanceList;
  List<Maintenance?>? openMaintenanceList = [];
  List<Maintenance?>? closedMaintenanceList = [];
  TextEditingController searchController = TextEditingController();

  // final imgUrl =
  //     "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";
  // var dio = Dio();

  triggerGetListEvent(ProjectDetailEvent event) {
    context.read<ProjectDetailBloc>().add(event);
  }

  @override
  void initState() {
    maintenanceList = widget.maintenanceList;

    if (maintenanceList != null) {
      for (var list in maintenanceList!) {
        if (list?.status.toString().toLowerCase() == appString.open.toString().toLowerCase()) {
          openMaintenanceList?.add(list);
        } else {
          if (list != null && list.status != null) {
            closedMaintenanceList?.add(list);
          }
        }
      }
    }

    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController!.addListener(() {
      if (_tabController!.index == 0) {
        allTab = true;
      } else {
        allTab = false;
      }
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return BlocBuilder<ProjectDetailBloc, ProjectDetailState>(
      builder: (context, state) {
        if (state is GetProjectDetailsState) {
          if (state.projectDetails != null && state.projectDetails!.data != null) {
            if (state.projectDetails!.data!.maintenance != null) {
              maintenanceList = state.projectDetails!.data!.maintenance!;
            }
          }
        }
        return LayoutBuilder(builder: (BuildContext ctx, BoxConstraints constraints) {
          if (width > SizeConstants.tabWidth) {
            return DefaultTabController(
              length: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabBar(
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
                            text: appString.all,
                            height: appDimen.sp30,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: appDimen.sp100,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Tab(
                            text: appString.open,
                            height: appDimen.sp30,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: appDimen.sp100,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Tab(
                            text: appString.closed,
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
                          SingleChildScrollView(
                            physics: const ScrollPhysics(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: width * 0.08,
                                      padding: EdgeInsets.all(appDimen.sp10),
                                      decoration: BoxDecoration(
                                        color: Color(appColors.pinkFFD2D2),
                                        borderRadius: BorderRadius.circular(appDimen.sp5),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            offset: const Offset(0.8, 0.8), //(x,y)
                                            blurRadius: appDimen.sp5,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomLabel(
                                            text: openMaintenanceList!.length.toString(),
                                            size: width * 0.02,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          SizedBox(
                                            height: appDimen.sp10,
                                          ),
                                          CustomLabel(
                                            text: appString.open,
                                            size: appDimen.sp13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: appDimen.sp15,
                                    ),
                                    Container(
                                      width: width * 0.08,
                                      padding: EdgeInsets.all(appDimen.sp10),
                                      decoration: BoxDecoration(
                                        color: Color(appColors.greenDBFFBF),
                                        borderRadius: BorderRadius.circular(appDimen.sp5),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            offset: const Offset(0.8, 0.8), //(x,y)
                                            blurRadius: appDimen.sp5,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomLabel(
                                            text: closedMaintenanceList!.length.toString(),
                                            size: width * 0.02,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          SizedBox(
                                            height: appDimen.sp10,
                                          ),
                                          CustomLabel(
                                            text: appString.closed,
                                            size: appDimen.sp13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: appDimen.sp20,
                                ),
                                maintenanceList != null && maintenanceList!.isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: maintenanceList!.length,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, int index) {
                                          return Card(
                                            child: Container(
                                              margin: EdgeInsets.all(appDimen.sp10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: SizedBox(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              CustomLabel(
                                                                text: maintenanceList![index]?.referenceId ?? '',
                                                                size: appDimen.sp16,
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                              SizedBox(
                                                                width: appDimen.sp10,
                                                              ),
                                                              CustomLabel(
                                                                text: maintenanceList![index]?.createdAt != null &&
                                                                        maintenanceList![index]!.createdAt!.isNotEmpty
                                                                    ? CommonMethods.formatDateToString(maintenanceList![index]!.createdAt!)
                                                                    : '',
                                                                size: appDimen.sp16,
                                                                color: Color(appColors.greyD3D3D3),
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                              SizedBox(
                                                                width: appDimen.sp10,
                                                              ),
                                                              CustomLabel(
                                                                text: maintenanceList![index]?.createdAt != null &&
                                                                        maintenanceList![index]!.createdAt!.isNotEmpty
                                                                    ? '(${CommonMethods.dateFormatterTimes(maintenanceList![index]!.createdAt!)})'
                                                                    : '',
                                                                color: Color(appColors.greyD3D3D3),
                                                                fontWeight: FontWeight.w500,
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: appDimen.sp10,
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.25,
                                                            child: Row(
                                                              children: [
                                                                CustomLabel(
                                                                  text: '(${maintenanceList![index]?.maintenanceListId ?? ''}) ',
                                                                  size: appDimen.sp13,
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                                Expanded(
                                                                  child: CustomLabel(
                                                                    text: maintenanceList![index]?.beforeDescription ?? '',
                                                                    size: appDimen.sp13,
                                                                    fontWeight: FontWeight.w400,
                                                                    maxLines: 2,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets.symmetric(
                                                              horizontal: appDimen.sp10,
                                                              vertical: appDimen.sp7,
                                                            ),
                                                            decoration: BoxDecoration(
                                                              color: maintenanceList![index]?.status.toString().toLowerCase() ==
                                                                      appString.open.toString().toLowerCase()
                                                                  ? Color(appColors.pinkFFD2D2)
                                                                  : Color(appColors.greenDBFFBF),
                                                              borderRadius: BorderRadius.circular(appDimen.sp5),
                                                            ),
                                                            child: CustomLabel(
                                                              text: maintenanceList![index]?.status.toString().toLowerCase() ==
                                                                      appString.open.toString().toLowerCase()
                                                                  ? appString.open
                                                                  : appString.closed,
                                                              size: appDimen.sp13,
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.01,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              if (widget.share != null) {
                                                                String? id =
                                                                    maintenanceList![index]!.id != null ? maintenanceList![index]!.id.toString() : '';
                                                                List<String> reportId = [id.toString()];
                                                                print(appString.reportType[2]);
                                                                widget.share!(reportId, appString.reportType[2]);
                                                              }
                                                            },
                                                            child: SvgPicture.asset(
                                                              appImages.share,
                                                              width: width * 0.015,
                                                              height: width * 0.015,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: appDimen.sp10,
                                                      ),
                                                      CustomRaisedButton(
                                                        width: width * 0.15,
                                                        text: maintenanceList![index]?.status.toString().toLowerCase() ==
                                                                appString.open.toString().toLowerCase()
                                                            ? appString.resolve
                                                            : appString.download,
                                                        color: Colors.white,
                                                        size: appDimen.sp15,
                                                        textColor: Color(appColors.brown840000),
                                                        sideColor: Color(appColors.brown840000),
                                                        onPressed: () {
                                                          if (maintenanceList![index]?.status.toString().toLowerCase() ==
                                                              appString.open.toString().toLowerCase()) {
                                                            context.router
                                                                .push(ViewMaintenanceFormPage(
                                                                  maintenanceId: widget.maintenanceList![index]!.id ?? 0,
                                                                ))
                                                                .then((value) => widget.refresh != null ? widget.refresh!() : '');
                                                          } else {
                                                            CommonMethods.download(maintenanceList![index]!.pdfUrl ?? '');
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : const Center(
                                        child: Text("No Record(s) Found."),
                                      ),
                              ],
                            ),
                          ),
                          openMaintenanceList!.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: openMaintenanceList!.length,
                                  itemBuilder: (context, int index) {
                                    return Card(
                                      child: Container(
                                        margin: EdgeInsets.all(appDimen.sp10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        CustomLabel(
                                                          text: openMaintenanceList![index]?.referenceId ?? '',
                                                          size: appDimen.sp16,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                        SizedBox(
                                                          width: appDimen.sp10,
                                                        ),
                                                        CustomLabel(
                                                          text: openMaintenanceList![index]?.createdAt != null &&
                                                                  openMaintenanceList![index]!.createdAt!.isNotEmpty
                                                              ? CommonMethods.formatDateToString(openMaintenanceList![index]!.createdAt!)
                                                              : '',
                                                          size: appDimen.sp16,
                                                          color: Color(appColors.greyD3D3D3),
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                        SizedBox(
                                                          width: appDimen.sp10,
                                                        ),
                                                        CustomLabel(
                                                          text: openMaintenanceList![index]?.createdAt != null &&
                                                                  openMaintenanceList![index]!.createdAt!.isNotEmpty
                                                              ? '(${CommonMethods.dateFormatterTimes(openMaintenanceList![index]!.createdAt!)})'
                                                              : '',
                                                          color: Color(appColors.greyD3D3D3),
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: appDimen.sp10,
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.25,
                                                      child: Row(
                                                        children: [
                                                          CustomLabel(
                                                            text: '(${openMaintenanceList![index]?.maintenanceListId ?? ''}) ',
                                                            size: appDimen.sp13,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                          CustomLabel(
                                                            text: openMaintenanceList![index]?.beforeDescription ?? '',
                                                            size: appDimen.sp13,
                                                            fontWeight: FontWeight.w400,
                                                            maxLines: 2,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: appDimen.sp10,
                                                        vertical: appDimen.sp7,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Color(appColors.pinkFFD2D2),
                                                        borderRadius: BorderRadius.circular(appDimen.sp5),
                                                      ),
                                                      child: CustomLabel(
                                                        text: appString.open,
                                                        size: appDimen.sp13,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.01,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        if (widget.share != null) {
                                                          String? id = openMaintenanceList![index]!.id != null
                                                              ? openMaintenanceList![index]!.id.toString()
                                                              : '';
                                                          List<String> reportId = [id.toString()];
                                                          print(appString.reportType[2]);
                                                          widget.share!(reportId, appString.reportType[2]);
                                                        }
                                                      },
                                                      child: SvgPicture.asset(
                                                        appImages.share,
                                                        width: width * 0.015,
                                                        height: width * 0.015,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: appDimen.sp10,
                                                ),
                                                CustomRaisedButton(
                                                  width: width * 0.15,
                                                  text: appString.resolve,
                                                  color: Colors.white,
                                                  size: appDimen.sp15,
                                                  textColor: Color(appColors.brown840000),
                                                  sideColor: Color(appColors.brown840000),
                                                  onPressed: () {
                                                    context.router
                                                        .push(ViewMaintenanceFormPage(
                                                          maintenanceId: openMaintenanceList![index]!.id ?? 0,
                                                        ))
                                                        .then((value) => widget.refresh != null ? widget.refresh!() : '');
                                                  },
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : const Center(
                                  child: Text("No Record(s) Found."),
                                ),
                          closedMaintenanceList!.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: closedMaintenanceList!.length,
                                  itemBuilder: (context, int index) {
                                    return Card(
                                      child: Container(
                                        margin: EdgeInsets.all(appDimen.sp10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        CustomLabel(
                                                          text: closedMaintenanceList![index]?.referenceId ?? '',
                                                          size: appDimen.sp16,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                        SizedBox(
                                                          width: appDimen.sp10,
                                                        ),
                                                        CustomLabel(
                                                          text: closedMaintenanceList![index]?.createdAt != null &&
                                                                  closedMaintenanceList![index]!.createdAt!.isNotEmpty
                                                              ? CommonMethods.formatDateToString(closedMaintenanceList![index]!.createdAt!)
                                                              : '',
                                                          size: appDimen.sp16,
                                                          color: Color(appColors.greyD3D3D3),
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                        SizedBox(
                                                          width: appDimen.sp10,
                                                        ),
                                                        CustomLabel(
                                                          text: closedMaintenanceList![index]?.createdAt != null &&
                                                                  closedMaintenanceList![index]!.createdAt!.isNotEmpty
                                                              ? '(${CommonMethods.dateFormatterTimes(closedMaintenanceList![index]!.createdAt!)})'
                                                              : '',
                                                          color: Color(appColors.greyD3D3D3),
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: appDimen.sp10,
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.25,
                                                      child: Row(
                                                        children: [
                                                          CustomLabel(
                                                            text: '(${closedMaintenanceList![index]?.maintenanceListId ?? ''}) ',
                                                            size: appDimen.sp13,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                          CustomLabel(
                                                            text: closedMaintenanceList![index]?.beforeDescription ?? '',
                                                            size: appDimen.sp13,
                                                            fontWeight: FontWeight.w400,
                                                            maxLines: 2,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: appDimen.sp10,
                                                        vertical: appDimen.sp7,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Color(appColors.greenDBFFBF),
                                                        borderRadius: BorderRadius.circular(appDimen.sp5),
                                                      ),
                                                      child: CustomLabel(
                                                        text: appString.closed,
                                                        size: appDimen.sp13,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.01,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        if (widget.share != null) {
                                                          String? id = closedMaintenanceList![index]!.id != null
                                                              ? closedMaintenanceList![index]!.id.toString()
                                                              : '';
                                                          List<String> reportId = [id.toString()];
                                                          print(appString.reportType[2]);
                                                          widget.share!(reportId, appString.reportType[2]);
                                                        }
                                                      },
                                                      child: SvgPicture.asset(
                                                        appImages.share,
                                                        width: width * 0.015,
                                                        height: width * 0.015,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: appDimen.sp10,
                                                ),
                                                CustomRaisedButton(
                                                  width: width * 0.15,
                                                  text: appString.download,
                                                  color: Colors.white,
                                                  size: appDimen.sp15,
                                                  textColor: Color(appColors.brown840000),
                                                  sideColor: Color(appColors.brown840000),
                                                  onPressed: () {
                                                    CommonMethods.download(closedMaintenanceList![index]!.pdfUrl ?? '');
                                                  },
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : const Center(
                                  child: Text("No Record(s) Found."),
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
              length: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabBar(
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
                        width: width * 0.18,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Tab(
                            text: appString.all,
                            height: appDimen.sp30,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.18,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Tab(
                            text: appString.open,
                            height: appDimen.sp30,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.18,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Tab(
                            text: appString.closed,
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
                          SingleChildScrollView(
                            physics: const ScrollPhysics(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: width * 0.3,
                                      padding: EdgeInsets.all(appDimen.sp10),
                                      decoration: BoxDecoration(
                                        color: Color(appColors.pinkFFD2D2),
                                        borderRadius: BorderRadius.circular(appDimen.sp5),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            offset: const Offset(0.8, 0.8), //(x,y)
                                            blurRadius: appDimen.sp5,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomLabel(
                                            text: openMaintenanceList!.length.toString(),
                                            size: width * 0.03,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          SizedBox(
                                            height: appDimen.sp10,
                                          ),
                                          CustomLabel(
                                            text: appString.open,
                                            size: appDimen.sp13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: appDimen.sp15,
                                    ),
                                    Container(
                                      width: width * 0.3,
                                      padding: EdgeInsets.all(appDimen.sp10),
                                      decoration: BoxDecoration(
                                        color: Color(appColors.greenDBFFBF),
                                        borderRadius: BorderRadius.circular(appDimen.sp5),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            offset: const Offset(0.8, 0.8), //(x,y)
                                            blurRadius: appDimen.sp5,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomLabel(
                                            text: closedMaintenanceList!.length.toString(),
                                            size: width * 0.03,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          SizedBox(
                                            height: appDimen.sp10,
                                          ),
                                          CustomLabel(
                                            text: appString.closed,
                                            size: appDimen.sp13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: appDimen.sp20,
                                ),
                                maintenanceList != null && maintenanceList!.isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: maintenanceList!.length,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, int index) {
                                          return Card(
                                            child: Container(
                                              margin: EdgeInsets.all(appDimen.sp10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: SizedBox(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: CustomLabel(
                                                                    text: maintenanceList![index]!.referenceId.toString(),
                                                                    fontWeight: FontWeight.w600,
                                                                    size: appDimen.sp12),
                                                              ),
                                                              SizedBox(
                                                                width: appDimen.sp7,
                                                              ),
                                                              Expanded(
                                                                child: CustomLabel(
                                                                    text: maintenanceList![index]?.createdAt != null &&
                                                                            maintenanceList![index]!.createdAt!.isNotEmpty
                                                                        ? CommonMethods.formatDateToString(maintenanceList![index]!.createdAt!)
                                                                        : '',
                                                                    color: Color(appColors.greyD3D3D3),
                                                                    fontWeight: FontWeight.w600,
                                                                    size: appDimen.sp12),
                                                              ),
                                                              SizedBox(
                                                                width: appDimen.sp7,
                                                              ),
                                                              Expanded(
                                                                child: CustomLabel(
                                                                  text: maintenanceList![index]?.createdAt != null &&
                                                                          maintenanceList![index]!.createdAt!.isNotEmpty
                                                                      ? '(${CommonMethods.dateFormatterTimes(maintenanceList![index]!.createdAt!)})'
                                                                      : '',
                                                                  color: Color(appColors.greyD3D3D3),
                                                                  fontWeight: FontWeight.w500,
                                                                  size: appDimen.sp10,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: appDimen.sp10,
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.3,
                                                            child: Row(
                                                              children: [
                                                                CustomLabel(
                                                                  text: '(${maintenanceList![index]?.maintenanceListId ?? ''}) ',
                                                                  size: appDimen.sp13,
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                                Expanded(
                                                                  child: CustomLabel(
                                                                    text: maintenanceList![index]?.beforeDescription ?? '',
                                                                    size: appDimen.sp11,
                                                                    fontWeight: FontWeight.w400,
                                                                    maxLines: 2,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.end,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets.symmetric(
                                                              horizontal: appDimen.sp10,
                                                              vertical: appDimen.sp7,
                                                            ),
                                                            decoration: BoxDecoration(
                                                              color: maintenanceList![index]?.status.toString().toLowerCase() ==
                                                                      appString.open.toString().toLowerCase()
                                                                  ? Color(appColors.pinkFFD2D2)
                                                                  : Color(appColors.greenDBFFBF),
                                                              borderRadius: BorderRadius.circular(appDimen.sp5),
                                                            ),
                                                            child: CustomLabel(
                                                              text: maintenanceList![index]?.status.toString().toLowerCase() ==
                                                                      appString.open.toString().toLowerCase()
                                                                  ? appString.open
                                                                  : appString.closed,
                                                              size: appDimen.sp11,
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.005,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              if (widget.share != null) {
                                                                String? id =
                                                                    maintenanceList![index]!.id != null ? maintenanceList![index]!.id.toString() : '';
                                                                List<String> reportId = [id.toString()];
                                                                print(appString.reportType[2]);
                                                                widget.share!(reportId, appString.reportType[2]);
                                                              }
                                                            },
                                                            child: SvgPicture.asset(
                                                              appImages.share,
                                                              width: width * 0.028,
                                                              height: width * 0.028,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: appDimen.sp10,
                                                      ),
                                                      CustomRaisedButton(
                                                        width: width * 0.22,
                                                        text: maintenanceList![index]?.status.toString().toLowerCase() ==
                                                                appString.open.toString().toLowerCase()
                                                            ? appString.resolve
                                                            : appString.download,
                                                        color: Colors.white,
                                                        size: appDimen.sp13,
                                                        textColor: Color(appColors.brown840000),
                                                        sideColor: Color(appColors.brown840000),
                                                        onPressed: () {
                                                          if (maintenanceList![index]?.status.toString().toLowerCase() ==
                                                              appString.open.toString().toLowerCase()) {
                                                            context.router
                                                                .push(ViewMaintenanceFormPage(
                                                                  maintenanceId: widget.maintenanceList![index]!.id ?? 0,
                                                                ))
                                                                .then((value) => widget.refresh != null ? widget.refresh!() : '');
                                                          } else {
                                                            CommonMethods.download(maintenanceList![index]!.pdfUrl ?? '');
                                                          }
                                                        },
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    : const Center(
                                        child: Text("No Record(s) Found."),
                                      ),
                              ],
                            ),
                          ),
                          openMaintenanceList!.isNotEmpty
                              ? ListView.builder(
                                  itemCount: openMaintenanceList!.length,
                                  itemBuilder: (context, int index) {
                                    return Card(
                                      child: Container(
                                        margin: EdgeInsets.all(appDimen.sp10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: CustomLabel(
                                                              text: openMaintenanceList![index]?.referenceId ?? '',
                                                              fontWeight: FontWeight.w600,
                                                              size: appDimen.sp12),
                                                        ),
                                                        SizedBox(
                                                          width: appDimen.sp7,
                                                        ),
                                                        Expanded(
                                                          child: CustomLabel(
                                                              text: openMaintenanceList![index]?.createdAt != null &&
                                                                      openMaintenanceList![index]!.createdAt!.isNotEmpty
                                                                  ? CommonMethods.formatDateToString(openMaintenanceList![index]!.createdAt!)
                                                                  : '',
                                                              color: Color(appColors.greyD3D3D3),
                                                              fontWeight: FontWeight.w600,
                                                              size: appDimen.sp12),
                                                        ),
                                                        SizedBox(
                                                          width: appDimen.sp7,
                                                        ),
                                                        Expanded(
                                                          child: CustomLabel(
                                                            text: openMaintenanceList![index]?.createdAt != null &&
                                                                    openMaintenanceList![index]!.createdAt!.isNotEmpty
                                                                ? '(${CommonMethods.dateFormatterTimes(openMaintenanceList![index]!.createdAt!)})'
                                                                : '',
                                                            color: Color(appColors.greyD3D3D3),
                                                            fontWeight: FontWeight.w500,
                                                            size: appDimen.sp10,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: appDimen.sp10,
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.3,
                                                      child: Row(
                                                        children: [
                                                          CustomLabel(
                                                            text: '(${openMaintenanceList![index]?.maintenanceListId ?? ''}) ',
                                                            size: appDimen.sp13,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                          Expanded(
                                                            child: CustomLabel(
                                                              text: openMaintenanceList![index]?.beforeDescription ?? '',
                                                              size: appDimen.sp11,
                                                              fontWeight: FontWeight.w400,
                                                              maxLines: 2,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: appDimen.sp10,
                                                        vertical: appDimen.sp7,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Color(appColors.pinkFFD2D2),
                                                        borderRadius: BorderRadius.circular(appDimen.sp5),
                                                      ),
                                                      child: CustomLabel(
                                                        text: appString.open,
                                                        size: appDimen.sp11,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.005,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        if (widget.share != null) {
                                                          String? id = openMaintenanceList![index]!.id != null
                                                              ? openMaintenanceList![index]!.id.toString()
                                                              : '';
                                                          List<String> reportId = [id.toString()];
                                                          print(appString.reportType[2]);
                                                          widget.share!(reportId, appString.reportType[2]);
                                                        }
                                                      },
                                                      child: SvgPicture.asset(
                                                        appImages.share,
                                                        width: width * 0.028,
                                                        height: width * 0.028,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: appDimen.sp10,
                                                ),
                                                CustomRaisedButton(
                                                  width: width * 0.22,
                                                  text: appString.resolve,
                                                  color: Colors.white,
                                                  size: appDimen.sp13,
                                                  textColor: Color(appColors.brown840000),
                                                  sideColor: Color(appColors.brown840000),
                                                  onPressed: () {
                                                    context.router
                                                        .push(ViewMaintenanceFormPage(maintenanceId: openMaintenanceList![index]!.id ?? 0))
                                                        .then((value) => widget.refresh != null ? widget.refresh!() : '');
                                                  },
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : const Center(
                                  child: Text("No Record(s) Found."),
                                ),
                          closedMaintenanceList!.isNotEmpty
                              ? ListView.builder(
                                  itemCount: closedMaintenanceList!.length,
                                  itemBuilder: (context, int index) {
                                    return Card(
                                      child: Container(
                                        margin: EdgeInsets.all(appDimen.sp10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: CustomLabel(
                                                              text: closedMaintenanceList![index]?.referenceId ?? '',
                                                              fontWeight: FontWeight.w600,
                                                              size: appDimen.sp12),
                                                        ),
                                                        SizedBox(
                                                          width: appDimen.sp7,
                                                        ),
                                                        Expanded(
                                                          child: CustomLabel(
                                                              text: closedMaintenanceList![index]?.createdAt != null &&
                                                                      closedMaintenanceList![index]!.createdAt!.isNotEmpty
                                                                  ? CommonMethods.formatDateToString(closedMaintenanceList![index]!.createdAt!)
                                                                  : '',
                                                              color: Color(appColors.greyD3D3D3),
                                                              fontWeight: FontWeight.w600,
                                                              size: appDimen.sp12),
                                                        ),
                                                        SizedBox(
                                                          width: appDimen.sp7,
                                                        ),
                                                        Expanded(
                                                          child: CustomLabel(
                                                            text: closedMaintenanceList![index]?.createdAt != null &&
                                                                    closedMaintenanceList![index]!.createdAt!.isNotEmpty
                                                                ? '(${CommonMethods.dateFormatterTimes(closedMaintenanceList![index]!.createdAt!)})'
                                                                : '',
                                                            color: Color(appColors.greyD3D3D3),
                                                            fontWeight: FontWeight.w500,
                                                            size: appDimen.sp10,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: appDimen.sp10,
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.3,
                                                      child: Row(
                                                        children: [
                                                          CustomLabel(
                                                            text: '(${closedMaintenanceList![index]?.maintenanceListId ?? ''}) ',
                                                            size: appDimen.sp13,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                          Expanded(
                                                            child: CustomLabel(
                                                              text: closedMaintenanceList![index]?.beforeDescription ?? '',
                                                              size: appDimen.sp11,
                                                              fontWeight: FontWeight.w400,
                                                              maxLines: 2,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: appDimen.sp10,
                                                        vertical: appDimen.sp7,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: Color(appColors.greenDBFFBF),
                                                        borderRadius: BorderRadius.circular(appDimen.sp5),
                                                      ),
                                                      child: CustomLabel(
                                                        text: appString.closed,
                                                        size: appDimen.sp11,
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.005,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        if (widget.share != null) {
                                                          String? id = closedMaintenanceList![index]!.id != null
                                                              ? closedMaintenanceList![index]!.id.toString()
                                                              : '';
                                                          List<String> reportId = [id.toString()];
                                                          print(appString.reportType[2]);
                                                          widget.share!(reportId, appString.reportType[2]);
                                                        }
                                                      },
                                                      child: SvgPicture.asset(
                                                        appImages.share,
                                                        width: width * 0.028,
                                                        height: width * 0.028,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: appDimen.sp10,
                                                ),
                                                CustomRaisedButton(
                                                  width: width * 0.22,
                                                  text: appString.download,
                                                  color: Colors.white,
                                                  size: appDimen.sp13,
                                                  textColor: Color(appColors.brown840000),
                                                  sideColor: Color(appColors.brown840000),
                                                  onPressed: () {
                                                    CommonMethods.download(closedMaintenanceList![index]!.pdfUrl ?? '');
                                                  },
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : const Center(
                                  child: Text("No Record(s) Found."),
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
}
