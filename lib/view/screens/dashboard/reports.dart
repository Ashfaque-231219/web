import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web/helper/constants/colors.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/helper/constants/images.dart';
import 'package:web/helper/constants/size_constants.dart';
import 'package:web/helper/constants/string.dart';
import 'package:web/models/response/report_list_modal.dart';
import 'package:web/view-model/siteSurveyReportBloc/site_survey_report_bloc.dart';
import 'package:web/view/screens/dashboard/reports_tile.dart';
import 'package:web/view/screens/dashboard/user_mail_dialog.dart';
import 'package:web/view/shared_widget/custom_dialog.dart';
import 'package:web/view/shared_widget/custom_label.dart';
import 'package:web/view/shared_widget/custom_search_bar.dart';

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  TextEditingController searchController = TextEditingController();
  bool shareMultiple = false;
  bool checkValue = false;
  BuildContext? buildContext;
  List<String> shareReportId = [];
  List<String>? reportId = [];
  String? reportType = '';

  triggerGetListEvent(SiteSurveyReportEvent event) {
    context.read<SiteSurveyReportBloc>().add(event);
  }

  @override
  void initState() {
    triggerGetListEvent(GetReportListEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    buildContext = context;
    return BlocBuilder<SiteSurveyReportBloc, SiteSurveyReportState>(
      builder: (context, state) {
        List<Data?>? reportsList;

        if (state is GetReportsListState) {
          if (state.reportList != null) {
            if (state.reportList!.data != null) {
              reportsList = state.reportList!.data!;
            }
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

                triggerGetListEvent(GetReportListEvent(context: context, loading: false));
              }
            }
          });
          triggerGetListEvent(GetReportListEvent(context: context, loading: false));
        }

        debugPrint(reportsList.toString());
        return LayoutBuilder(builder: (BuildContext ctx, BoxConstraints constraints) {
          if (width > SizeConstants.tabWidth) {
            return Scaffold(
              body: Center(
                child: Container(
                  width: width * 0.6,
                  margin: EdgeInsets.all(
                    appDimen.sp30,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomLabel(
                              text: 'Project Reports',
                              size: appDimen.sp16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SvgPicture.asset(
                            appImages.filter,
                            width: appDimen.sp25,
                            height: appDimen.sp23,
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          InkWell(
                            onTap: () {
                              shareMultiple = !shareMultiple;
                              setState(() {});
                            },
                            child: SvgPicture.asset(
                              appImages.selectMultiple,
                              width: appDimen.sp25,
                              height: appDimen.sp23,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: appDimen.sp20),
                        child: CustomSearchBar(
                          hint: 'Find your project reports',
                          controller: searchController,
                          onChanged: (value) {
                            debugPrint(value);
                            triggerGetListEvent(GetReportListEvent(context: context, search: value));
                          },
                        ),
                      ),
                      Visibility(
                        visible: shareMultiple && (reportsList != null && reportsList.isNotEmpty),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: appDimen.sp10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: checkValue,
                                    onChanged: (value) {
                                      checkValue = !checkValue;
                                      for (int report = 0; report < reportsList!.length; report++) {
                                        reportsList[report]?.isChecked = checkValue;
                                        if (checkValue) {
                                          if (!shareReportId.contains(reportsList[report]!.id.toString())) {
                                            shareReportId.add(reportsList[report]!.id.toString());
                                          }
                                        } else {
                                          shareReportId.clear();
                                        }
                                      }
                                      setState(() {});
                                    },
                                    activeColor: Color(appColors.brown840000),
                                  ),
                                  CustomLabel(
                                    text: 'Select All',
                                    size: appDimen.sp16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  if (shareReportId.isNotEmpty) {
                                    shareReport(shareReportId, appString.reportType[4]);
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const CustomDialog(
                                            text: "Please Select Reports",
                                            width: 200,
                                          );
                                        });
                                  }
                                },
                                child: SvgPicture.asset(
                                  appImages.share,
                                  width: width * 0.02,
                                  height: width * 0.02,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: reportsList != null && reportsList.isNotEmpty
                            ? ListView.builder(
                                itemCount: reportsList.length,
                                itemBuilder: (context, int index) {
                                  return Row(
                                    children: [
                                      Visibility(
                                        visible: shareMultiple,
                                        child: Checkbox(
                                          value: reportsList![index]!.isChecked ||
                                              shareReportId.contains(reportsList[index]!.id.toString()) ||
                                              checkValue,
                                          onChanged: (value) {
                                            setState(() {
                                              reportsList![index]!.isChecked = value!;
                                              if (reportsList[index]!.isChecked) {
                                                if (!shareReportId.contains(reportsList[index]!.id.toString())) {
                                                  shareReportId.add(reportsList[index]!.id.toString());
                                                }
                                              } else {
                                                shareReportId.remove(reportsList[index]!.id.toString());
                                              }
                                              for (int report = 0; report < reportsList.length; report++) {
                                                if (reportsList[report] != null && reportsList[report]!.isChecked) {
                                                  checkValue = true;
                                                } else {
                                                  checkValue = false;
                                                  return;
                                                }
                                              }
                                              setState(() {});
                                            });
                                          },
                                          activeColor: Color(appColors.brown840000),
                                        ),
                                      ),
                                      Expanded(
                                        child: ReportsTile(
                                          report: reportsList[index],
                                          refresh: refresh,
                                          share: shareMultiple,
                                          shareReport: shareReport,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              )
                            : const Center(
                                child: Text("No Record(s) Found."),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Container(
                width: width * 0.9,
                margin: EdgeInsets.all(
                  appDimen.sp30,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomLabel(
                            text: 'Project Reports',
                            size: appDimen.sp16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SvgPicture.asset(
                          appImages.filter,
                          width: appDimen.sp25,
                          height: appDimen.sp23,
                        ),
                        SizedBox(
                          width: width * 0.01,
                        ),
                        InkWell(
                          onTap: () {
                            shareMultiple = !shareMultiple;
                            setState(() {});
                          },
                          child: SvgPicture.asset(
                            appImages.selectMultiple,
                            width: appDimen.sp25,
                            height: appDimen.sp23,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: appDimen.sp20),
                      child: CustomSearchBar(
                        hint: 'Find your project reports',
                        controller: searchController,
                        onChanged: (value) {
                          debugPrint(value);
                          triggerGetListEvent(GetReportListEvent(context: context, search: value));
                        },
                      ),
                    ),
                    Visibility(
                      visible: shareMultiple,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: appDimen.sp10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: checkValue,
                                  onChanged: (value) {
                                    checkValue = !checkValue;
                                    for (int report = 0; report < reportsList!.length; report++) {
                                      reportsList[report]?.isChecked = checkValue;
                                      if (checkValue) {
                                        if (!shareReportId.contains(reportsList[report]!.id.toString())) {
                                          shareReportId.add(reportsList[report]!.id.toString());
                                        }
                                      } else {
                                        shareReportId.remove(reportsList[report]!.id.toString());
                                      }
                                    }
                                    setState(() {});
                                  },
                                  activeColor: Color(appColors.brown840000),
                                ),
                                CustomLabel(
                                  text: 'Select All',
                                  size: appDimen.sp16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                if (shareReportId.isNotEmpty) {
                                  shareReport(shareReportId, appString.reportType[4]);
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const CustomDialog(
                                          text: "Please Select Reports",
                                        );
                                      });
                                }
                              },
                              child: SvgPicture.asset(
                                appImages.share,
                                width: width * 0.04,
                                height: width * 0.04,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: reportsList != null && reportsList.isNotEmpty
                          ? ListView.builder(
                              itemCount: reportsList.length,
                              itemBuilder: (context, int index) {
                                return Row(
                                  children: [
                                    Visibility(
                                      visible: shareMultiple,
                                      child: Checkbox(
                                        value: reportsList![index]!.isChecked ||
                                            shareReportId.contains(reportsList[index]!.id.toString()) ||
                                            checkValue,
                                        onChanged: (value) {
                                          setState(() {
                                            reportsList![index]!.isChecked = value!;
                                            for (int report = 0; report < reportsList.length; report++) {
                                              if (reportsList[report] != null && reportsList[report]!.isChecked) {
                                                checkValue = true;
                                              } else {
                                                checkValue = false;
                                                return;
                                              }
                                            }
                                            if (reportsList[index]!.isChecked) {
                                              if (!shareReportId.contains(reportsList[index]!.id.toString())) {
                                                shareReportId.add(reportsList[index]!.id.toString());
                                              }
                                            } else {
                                              shareReportId.remove(reportsList[index]!.id.toString());
                                            }
                                          });
                                        },
                                        activeColor: Color(appColors.brown840000),
                                      ),
                                    ),
                                    Expanded(
                                      child: ReportsTile(
                                        report: reportsList[index],
                                        refresh: refresh,
                                        share: shareMultiple,
                                        shareReport: shareReport,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            )
                          : const Center(
                              child: Text("No Record(s) Found."),
                            ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
      },
    );
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

  refresh() {
    triggerGetListEvent(GetReportListEvent(context: context));
  }
}
