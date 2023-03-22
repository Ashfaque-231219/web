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
import 'package:web/view/shared_widget/custom_expected_date.dart';
import 'package:web/view/shared_widget/custom_label.dart';
import 'package:web/view/shared_widget/custom_raised_button.dart';
import 'package:web/view/shared_widget/custom_search_bar.dart';

class ProjectPunchList extends StatefulWidget {
  const ProjectPunchList({this.punchList, this.refresh, this.share, this.projectId, Key? key}) : super(key: key);

  final List<PunchLists?>? punchList;
  final Function? refresh;
  final Function? share;
  final int? projectId;

  @override
  State<ProjectPunchList> createState() => _ProjectPunchListState();
}

class _ProjectPunchListState extends State<ProjectPunchList> with TickerProviderStateMixin {
  TabController? _tabController;
  bool allTab = true;
  List<PunchLists?>? punchList;
  List<PunchLists?> openPunchList = [];
  List<PunchLists?> closedPunchList = [];
  TextEditingController searchController = TextEditingController();

  // final imgUrl =
  //     "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf";
  // var dio = Dio();

  triggerGetListEvent(ProjectDetailEvent event) {
    context.read<ProjectDetailBloc>().add(event);
  }

  @override
  void initState() {
    punchList = widget.punchList;

    if (punchList != null) {
      for (var list in punchList!) {
        if (list?.status.toString().toLowerCase() == appString.open.toString().toLowerCase()) {
          openPunchList.add(list);
        } else {
          if (list != null && list.status != null) {
            closedPunchList.add(list);
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
            if (state.projectDetails!.data!.punchList != null) {
              punchList = state.projectDetails!.data!.punchList!;
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: appDimen.sp20),
                    child: CustomSearchBar(
                      hint: 'Find your punch list item',
                      controller: searchController,
                      filter: true,
                      onChanged: (value) {
                        debugPrint(value);
                        triggerGetListEvent(
                          GetProjectDetailsEvent(
                            context: context,
                            projectId: widget.projectId.toString(),
                            punchSearch: value,
                            loading: false,
                          ),
                        );
                      },
                    ),
                  ),
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
                                            text: openPunchList.length.toString(),
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
                                            text: closedPunchList.length.toString(),
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
                                punchList != null && punchList!.isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: punchList!.length,
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
                                                                text: punchList![index]?.referenceId ?? '',
                                                                size: appDimen.sp16,
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                              SizedBox(
                                                                width: appDimen.sp10,
                                                              ),
                                                              CustomLabel(
                                                                text: punchList![index]?.createdAt != null && punchList![index]!.createdAt!.isNotEmpty
                                                                    ? CommonMethods.formatDateToString(punchList![index]!.createdAt!)
                                                                    : '',
                                                                size: appDimen.sp16,
                                                                color: Color(appColors.greyD3D3D3),
                                                                fontWeight: FontWeight.w600,
                                                              ),
                                                              SizedBox(
                                                                width: appDimen.sp10,
                                                              ),
                                                              CustomLabel(
                                                                text: punchList![index]?.createdAt != null && punchList![index]!.createdAt!.isNotEmpty
                                                                    ? '(${CommonMethods.dateFormatterTimes(punchList![index]!.createdAt!)})'
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
                                                                  text: '(${punchList![index]?.punchListId ?? ''}) ',
                                                                  size: appDimen.sp13,
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                                Expanded(
                                                                  child: CustomLabel(
                                                                    text: punchList![index]?.beforeDescription ?? '',
                                                                    size: appDimen.sp13,
                                                                    fontWeight: FontWeight.w400,
                                                                    maxLines: 2,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Visibility(
                                                              visible: allTab,
                                                              child: const SizedBox(
                                                                height: 5,
                                                              )),
                                                          CustomExpectedDate(
                                                            visible: punchList![index]?.expectedCompletionDate != null,
                                                            date: punchList![index]?.expectedCompletionDate != null &&
                                                                    punchList![index]!.expectedCompletionDate!.isNotEmpty
                                                                ? CommonMethods.formatDateToString(punchList![index]!.expectedCompletionDate!)
                                                                : '',
                                                            text: "Expected Completion Date",
                                                          ),
                                                          Visibility(
                                                              visible: allTab,
                                                              child: const SizedBox(
                                                                height: 5,
                                                              )),
                                                          CustomExpectedDate(
                                                            visible: punchList![index]?.actualCompletionDate != null,
                                                            date: punchList![index]?.actualCompletionDate != null &&
                                                                    punchList![index]!.actualCompletionDate!.isNotEmpty
                                                                ? CommonMethods.formatDateToString(punchList![index]!.actualCompletionDate!)
                                                                : '',
                                                            text: "Actual Completion Date",
                                                          )
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
                                                              color: punchList![index]?.status.toString().toLowerCase() ==
                                                                      appString.open.toString().toLowerCase()
                                                                  ? Color(appColors.pinkFFD2D2)
                                                                  : Color(appColors.greenDBFFBF),
                                                              borderRadius: BorderRadius.circular(appDimen.sp5),
                                                            ),
                                                            child: CustomLabel(
                                                              text: punchList![index]?.status.toString().toLowerCase() ==
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
                                                                String? id = punchList![index]!.id != null ? punchList![index]!.id.toString() : '';
                                                                List<String> reportId = [id.toString()];
                                                                widget.share!(reportId, appString.reportType[3]);
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
                                                        text: punchList![index]?.status.toString().toLowerCase() ==
                                                                appString.open.toString().toLowerCase()
                                                            ? appString.resolve
                                                            : appString.download,
                                                        color: Colors.white,
                                                        size: appDimen.sp15,
                                                        textColor: Color(appColors.brown840000),
                                                        sideColor: Color(appColors.brown840000),
                                                        onPressed: () {
                                                          if (punchList![index]?.status.toString().toLowerCase() ==
                                                              appString.open.toString().toLowerCase()) {
                                                            context.router
                                                                .push(ResolvePunchList(
                                                                  punchListId: widget.punchList![index]!.id ?? 0,
                                                                ))
                                                                .then((value) => widget.refresh != null ? widget.refresh!() : '');
                                                            // Navigator.pushNamed(
                                                            //   context,
                                                            //   RoutesConst.homePage + RoutesConst.resolvePunchList,
                                                            //   arguments: {
                                                            //     "id": widget.punchList![index]!.id,
                                                            //     "resolve": true,
                                                            //     "punchList": widget.punchList![index],
                                                            //   },
                                                            // ).then((value) => widget.refresh != null ? widget.refresh!() : '');
                                                            // context.router
                                                            //     .push(PunchList(resolve: true, punchList: punchList![index]))
                                                            //     .then((value) => widget.refresh != null ? widget.refresh!() : '');
                                                          } else {
                                                            CommonMethods.download(punchList![index]!.pdfUrl ?? '');
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
                          openPunchList.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: openPunchList.length,
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
                                                          text: openPunchList[index]?.referenceId ?? '',
                                                          size: appDimen.sp16,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                        SizedBox(
                                                          width: appDimen.sp10,
                                                        ),
                                                        CustomLabel(
                                                          text: openPunchList[index]?.createdAt != null && openPunchList[index]!.createdAt!.isNotEmpty
                                                              ? CommonMethods.formatDateToString(openPunchList[index]!.createdAt!)
                                                              : '',
                                                          size: appDimen.sp16,
                                                          color: Color(appColors.greyD3D3D3),
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                        SizedBox(
                                                          width: appDimen.sp10,
                                                        ),
                                                        CustomLabel(
                                                          text: openPunchList[index]?.createdAt != null && openPunchList[index]!.createdAt!.isNotEmpty
                                                              ? '(${CommonMethods.dateFormatterTimes(openPunchList[index]!.createdAt!)})'
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
                                                            text: '(${openPunchList[index]?.punchListId ?? ''}) ',
                                                            size: appDimen.sp13,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                          Expanded(
                                                            child: CustomLabel(
                                                              text: openPunchList[index]?.beforeDescription ?? '',
                                                              size: appDimen.sp13,
                                                              fontWeight: FontWeight.w400,
                                                              maxLines: 2,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Visibility(
                                                        visible: allTab,
                                                        child: const SizedBox(
                                                          height: 5,
                                                        )),
                                                    CustomExpectedDate(
                                                      visible: openPunchList[index]?.expectedCompletionDate != null,
                                                      date: openPunchList[index]?.expectedCompletionDate != null &&
                                                              openPunchList[index]!.expectedCompletionDate!.isNotEmpty
                                                          ? CommonMethods.formatDateToString(openPunchList[index]!.expectedCompletionDate!)
                                                          : '',
                                                      text: "Expected Completion Date",
                                                    ),
                                                    Visibility(
                                                        visible: allTab,
                                                        child: const SizedBox(
                                                          height: 5,
                                                        )),
                                                    CustomExpectedDate(
                                                      visible: openPunchList[index]?.actualCompletionDate != null,
                                                      date: openPunchList[index]?.actualCompletionDate != null &&
                                                              openPunchList[index]!.actualCompletionDate!.isNotEmpty
                                                          ? CommonMethods.formatDateToString(openPunchList[index]!.actualCompletionDate!)
                                                          : '',
                                                      text: "Actual Completion Date",
                                                    )
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
                                                          String? id = openPunchList[index]!.id != null ? openPunchList[index]!.id.toString() : '';
                                                          List<String> reportId = [id.toString()];
                                                          widget.share!(reportId, appString.reportType[3]);
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
                                                        .push(ResolvePunchList(
                                                          punchListId: widget.punchList![index]!.id ?? 0,
                                                        ))
                                                        .then((value) => widget.refresh != null ? widget.refresh!() : '');
                                                    // Navigator.pushNamed(
                                                    //   context,
                                                    //   RoutesConst.resolvePunchList,
                                                    //   arguments: {
                                                    //     "id": widget.punchList![index]!.id,
                                                    //     "resolve": true,
                                                    //     "punchList":widget.punchList![index],
                                                    //   },
                                                    // ).then((value) => widget.refresh != null ? widget.refresh!() : '');
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
                          closedPunchList.isNotEmpty
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: closedPunchList.length,
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
                                                          text: closedPunchList[index]?.referenceId ?? '',
                                                          size: appDimen.sp16,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                        SizedBox(
                                                          width: appDimen.sp10,
                                                        ),
                                                        CustomLabel(
                                                          text: closedPunchList[index]?.createdAt != null &&
                                                                  closedPunchList[index]!.createdAt!.isNotEmpty
                                                              ? CommonMethods.formatDateToString(closedPunchList[index]!.createdAt!)
                                                              : '',
                                                          size: appDimen.sp16,
                                                          color: Color(appColors.greyD3D3D3),
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                        SizedBox(
                                                          width: appDimen.sp10,
                                                        ),
                                                        CustomLabel(
                                                          text: closedPunchList[index]?.createdAt != null &&
                                                                  closedPunchList[index]!.createdAt!.isNotEmpty
                                                              ? '(${CommonMethods.dateFormatterTimes(closedPunchList[index]!.createdAt!)})'
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
                                                            text: '(${closedPunchList[index]?.punchListId ?? ''}) ',
                                                            size: appDimen.sp13,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                          Expanded(
                                                            child: CustomLabel(
                                                              text: closedPunchList[index]?.beforeDescription ?? '',
                                                              size: appDimen.sp13,
                                                              fontWeight: FontWeight.w400,
                                                              maxLines: 2,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Visibility(
                                                        visible: allTab,
                                                        child: const SizedBox(
                                                          height: 5,
                                                        )),
                                                    CustomExpectedDate(
                                                      visible: closedPunchList[index]?.expectedCompletionDate != null,
                                                      date: closedPunchList[index]?.expectedCompletionDate != null &&
                                                              closedPunchList[index]!.expectedCompletionDate!.isNotEmpty
                                                          ? CommonMethods.formatDateToString(closedPunchList[index]!.expectedCompletionDate!)
                                                          : '',
                                                      text: "Expected Completion Date",
                                                    ),
                                                    Visibility(
                                                        visible: allTab,
                                                        child: const SizedBox(
                                                          height: 5,
                                                        )),
                                                    CustomExpectedDate(
                                                      visible: closedPunchList[index]?.actualCompletionDate != null,
                                                      date: closedPunchList[index]?.actualCompletionDate != null &&
                                                              closedPunchList[index]!.actualCompletionDate!.isNotEmpty
                                                          ? CommonMethods.formatDateToString(closedPunchList[index]!.actualCompletionDate!)
                                                          : '',
                                                      text: "Actual Completion Date",
                                                    )
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
                                                          String? id =
                                                              closedPunchList[index]!.id != null ? closedPunchList[index]!.id.toString() : '';
                                                          List<String> reportId = [id.toString()];
                                                          widget.share!(reportId, appString.reportType[3]);
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
                                                    CommonMethods.download(closedPunchList[index]!.pdfUrl ?? '');
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: appDimen.sp20),
                    child: CustomSearchBar(
                      hint: 'Find your punch list item',
                      controller: searchController,
                      filter: true,
                      onChanged: (value) {
                        debugPrint(value);
                        triggerGetListEvent(
                          GetProjectDetailsEvent(
                            context: context,
                            projectId: widget.projectId.toString(),
                            punchSearch: value,
                            loading: false,
                          ),
                        );
                      },
                    ),
                  ),
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
                                            text: openPunchList.length.toString(),
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
                                            text: closedPunchList.length.toString(),
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
                                punchList != null && punchList!.isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: punchList!.length,
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
                                                                    text: punchList![index]?.referenceId ?? '',
                                                                    fontWeight: FontWeight.w600,
                                                                    size: appDimen.sp12),
                                                              ),
                                                              SizedBox(
                                                                width: appDimen.sp7,
                                                              ),
                                                              Expanded(
                                                                child: CustomLabel(
                                                                    text: punchList![index]?.createdAt != null &&
                                                                            punchList![index]!.createdAt!.isNotEmpty
                                                                        ? CommonMethods.formatDateToString(punchList![index]!.createdAt!)
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
                                                                  text:
                                                                      punchList![index]?.createdAt != null && punchList![index]!.createdAt!.isNotEmpty
                                                                          ? '(${CommonMethods.dateFormatterTimes(punchList![index]!.createdAt!)})'
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
                                                            width: width * 0.4,
                                                            child: Row(
                                                              children: [
                                                                CustomLabel(
                                                                  text: '(${punchList![index]?.punchListId ?? ''}) ',
                                                                  size: appDimen.sp13,
                                                                  fontWeight: FontWeight.w600,
                                                                ),
                                                                Expanded(
                                                                  child: CustomLabel(
                                                                    text: punchList![index]?.beforeDescription ?? '',
                                                                    size: appDimen.sp11,
                                                                    fontWeight: FontWeight.w400,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Visibility(
                                                              visible: allTab,
                                                              child: const SizedBox(
                                                                height: 5,
                                                              )),
                                                          CustomExpectedDate(
                                                            visible: punchList![index]?.expectedCompletionDate != null,
                                                            date: punchList![index]?.expectedCompletionDate != null &&
                                                                    punchList![index]!.expectedCompletionDate!.isNotEmpty
                                                                ? CommonMethods.formatDateToString(punchList![index]!.expectedCompletionDate!)
                                                                : '',
                                                            text: "Expected Completion Date",
                                                            size: appDimen.sp11,
                                                          ),
                                                          Visibility(
                                                              visible: allTab,
                                                              child: const SizedBox(
                                                                height: 5,
                                                              )),
                                                          CustomExpectedDate(
                                                            visible: punchList![index]?.actualCompletionDate != null,
                                                            date: punchList![index]?.actualCompletionDate != null &&
                                                                    punchList![index]!.actualCompletionDate!.isNotEmpty
                                                                ? CommonMethods.formatDateToString(punchList![index]!.actualCompletionDate!)
                                                                : '',
                                                            text: "Actual Completion Date",
                                                            size: appDimen.sp11,
                                                          )
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
                                                              color: punchList![index]?.status.toString().toLowerCase() ==
                                                                      appString.open.toString().toLowerCase()
                                                                  ? Color(appColors.pinkFFD2D2)
                                                                  : Color(appColors.greenDBFFBF),
                                                              borderRadius: BorderRadius.circular(appDimen.sp5),
                                                            ),
                                                            child: CustomLabel(
                                                              text: punchList![index]?.status.toString().toLowerCase() ==
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
                                                                String? id = punchList![index]!.id != null ? punchList![index]!.id.toString() : '';
                                                                List<String> reportId = [id.toString()];
                                                                widget.share!(reportId, appString.reportType[3]);
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
                                                        text: punchList![index]?.status.toString().toLowerCase() ==
                                                                appString.open.toString().toLowerCase()
                                                            ? appString.resolve
                                                            : appString.download,
                                                        color: Colors.white,
                                                        size: appDimen.sp13,
                                                        textColor: Color(appColors.brown840000),
                                                        sideColor: Color(appColors.brown840000),
                                                        onPressed: () {
                                                          if (punchList![index]?.status.toString().toLowerCase() ==
                                                              appString.open.toString().toLowerCase()) {
                                                            context.router
                                                                .push(ResolvePunchList(
                                                                  punchListId: widget.punchList![index]!.id ?? 0,
                                                                ))
                                                                .then((value) => widget.refresh != null ? widget.refresh!() : '');
                                                            // Navigator.pushNamed(
                                                            //   context,
                                                            //   RoutesConst.homePage+RoutesConst.resolvePunchList,
                                                            //   arguments: {
                                                            //     "id": widget.punchList![index]!.id,
                                                            //     "resolve": true,
                                                            //     "punchList":widget.punchList![index],
                                                            //   },
                                                            // ).then((value) => widget.refresh != null ? widget.refresh!() : '');
                                                          } else {
                                                            CommonMethods.download(punchList![index]!.pdfUrl ?? '');
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
                          openPunchList.isNotEmpty
                              ? ListView.builder(
                                  itemCount: openPunchList.length,
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
                                                              text: openPunchList[index]?.referenceId ?? '',
                                                              fontWeight: FontWeight.w600,
                                                              size: appDimen.sp12),
                                                        ),
                                                        SizedBox(
                                                          width: appDimen.sp7,
                                                        ),
                                                        Expanded(
                                                          child: CustomLabel(
                                                              text: openPunchList[index]?.createdAt != null &&
                                                                      openPunchList[index]!.createdAt!.isNotEmpty
                                                                  ? CommonMethods.formatDateToString(openPunchList[index]!.createdAt!)
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
                                                            text:
                                                                openPunchList[index]?.createdAt != null && openPunchList[index]!.createdAt!.isNotEmpty
                                                                    ? '(${CommonMethods.dateFormatterTimes(openPunchList[index]!.createdAt!)})'
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
                                                      width: width * 0.25,
                                                      child: Row(
                                                        children: [
                                                          CustomLabel(
                                                            text: '(${openPunchList[index]?.punchListId ?? ''}) ',
                                                            size: appDimen.sp13,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                          CustomLabel(
                                                            text: openPunchList[index]?.beforeDescription ?? '',
                                                            size: appDimen.sp11,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Visibility(
                                                        visible: allTab,
                                                        child: const SizedBox(
                                                          height: 5,
                                                        )),
                                                    CustomExpectedDate(
                                                      visible: openPunchList[index]?.expectedCompletionDate != null,
                                                      date: openPunchList[index]?.expectedCompletionDate != null &&
                                                              openPunchList[index]!.expectedCompletionDate!.isNotEmpty
                                                          ? CommonMethods.formatDateToString(openPunchList[index]!.expectedCompletionDate!)
                                                          : '',
                                                      text: "Expected Completion Date",
                                                      size: appDimen.sp11,
                                                    ),
                                                    Visibility(
                                                        visible: allTab,
                                                        child: const SizedBox(
                                                          height: 5,
                                                        )),
                                                    CustomExpectedDate(
                                                      visible: openPunchList[index]?.actualCompletionDate != null,
                                                      date: openPunchList[index]?.actualCompletionDate != null &&
                                                              openPunchList[index]!.actualCompletionDate!.isNotEmpty
                                                          ? CommonMethods.formatDateToString(openPunchList[index]!.actualCompletionDate!)
                                                          : '',
                                                      text: "Actual Completion Date",
                                                      size: appDimen.sp11,
                                                    )
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
                                                          String? id = openPunchList[index]!.id != null ? openPunchList[index]!.id.toString() : '';
                                                          List<String> reportId = [id.toString()];
                                                          widget.share!(reportId, appString.reportType[3]);
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
                                                        .push(ResolvePunchList(
                                                          punchListId: widget.punchList![index]!.id ?? 0,
                                                        ))
                                                        .then((value) => widget.refresh != null ? widget.refresh!() : '');
                                                    // Navigator.pushNamed(
                                                    //   context,
                                                    //   RoutesConst.homePage+RoutesConst.resolvePunchList,
                                                    //   arguments: {
                                                    //     "id": widget.punchList![index]!.id,
                                                    //     "resolve": true,
                                                    //     "punchList": widget.punchList![index],
                                                    //   },
                                                    // ).then((value) => widget.refresh != null ? widget.refresh!() : '');
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
                          closedPunchList.isNotEmpty
                              ? ListView.builder(
                                  itemCount: closedPunchList.length,
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
                                                              text: closedPunchList[index]?.referenceId ?? '',
                                                              fontWeight: FontWeight.w600,
                                                              size: appDimen.sp12),
                                                        ),
                                                        SizedBox(
                                                          width: appDimen.sp7,
                                                        ),
                                                        Expanded(
                                                          child: CustomLabel(
                                                              text: closedPunchList[index]?.createdAt != null &&
                                                                      closedPunchList[index]!.createdAt!.isNotEmpty
                                                                  ? CommonMethods.formatDateToString(closedPunchList[index]!.createdAt!)
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
                                                            text: closedPunchList[index]?.createdAt != null &&
                                                                    closedPunchList[index]!.createdAt!.isNotEmpty
                                                                ? '(${CommonMethods.dateFormatterTimes(closedPunchList[index]!.createdAt!)})'
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
                                                      width: width * 0.25,
                                                      child: Row(
                                                        children: [
                                                          CustomLabel(
                                                            text: '(${closedPunchList[index]?.punchListId ?? ''}) ',
                                                            size: appDimen.sp13,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                          CustomLabel(
                                                            text: closedPunchList[index]?.beforeDescription ?? '',
                                                            size: appDimen.sp11,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Visibility(
                                                        visible: allTab,
                                                        child: const SizedBox(
                                                          height: 5,
                                                        )),
                                                    CustomExpectedDate(
                                                      visible: closedPunchList[index]?.expectedCompletionDate != null,
                                                      date: closedPunchList[index]?.expectedCompletionDate != null &&
                                                              closedPunchList[index]!.expectedCompletionDate!.isNotEmpty
                                                          ? CommonMethods.formatDateToString(closedPunchList[index]!.expectedCompletionDate!)
                                                          : '',
                                                      text: "Expected Completion Date",
                                                      size: appDimen.sp11,
                                                    ),
                                                    Visibility(
                                                        visible: allTab,
                                                        child: const SizedBox(
                                                          height: 5,
                                                        )),
                                                    CustomExpectedDate(
                                                      visible: closedPunchList[index]?.actualCompletionDate != null,
                                                      date: closedPunchList[index]?.actualCompletionDate != null &&
                                                              closedPunchList[index]!.actualCompletionDate!.isNotEmpty
                                                          ? CommonMethods.formatDateToString(closedPunchList[index]!.actualCompletionDate!)
                                                          : '',
                                                      text: "Actual Completion Date",
                                                      size: appDimen.sp11,
                                                    )
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
                                                          String? id =
                                                              closedPunchList[index]!.id != null ? closedPunchList[index]!.id.toString() : '';
                                                          List<String> reportId = [id.toString()];
                                                          widget.share!(reportId, appString.reportType[3]);
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
                                                    CommonMethods.download(closedPunchList[index]!.pdfUrl ?? '');
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
