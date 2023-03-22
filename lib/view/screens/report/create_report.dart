import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web/Routing/routing.gr.dart';
import 'package:web/helper/constants/colors.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/helper/constants/size_constants.dart';
import 'package:web/helper/constants/string.dart';
import 'package:web/models/response/get_report_type.dart';
import 'package:web/view-model/projectDetailBloc/project_detail_bloc.dart';
import 'package:web/view/shared_widget/custom_dialog.dart';
import 'package:web/view/shared_widget/custom_dropdown.dart';
import 'package:web/view/shared_widget/custom_label.dart';
import 'package:web/view/shared_widget/custom_raised_button.dart';

class CreateReport extends StatefulWidget {
  const CreateReport({this.projectId, this.refresh, Key? key}) : super(key: key);

  final String? projectId;
  final Function? refresh;

  @override
  State<CreateReport> createState() => _CreateReportState();
}

class _CreateReportState extends State<CreateReport> {
  int? reportId;
  List<ReportType>? reportTypes;

  triggerProjectDetailEvent(ProjectDetailEvent event) {
    context.read<ProjectDetailBloc>().add(event);
  }

  @override
  void initState() {
    super.initState();
    triggerProjectDetailEvent(GetReportTypeEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return BlocBuilder<ProjectDetailBloc, ProjectDetailState>(
      builder: (context, state) {
        if (state is GetReportTypeState) {
          reportTypes = state.reportName;
        }
        debugPrint(reportTypes.toString());
        return LayoutBuilder(builder: (BuildContext ctx, BoxConstraints constraints) {
          if (width > SizeConstants.tabWidth) {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(appDimen.sp10)),
              child: Container(
                padding: EdgeInsets.all(appDimen.sp20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(appDimen.sp20),
                      child: CustomLabel(
                        text: appString.createReport,
                        size: appDimen.sp17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.22,
                      child: CustomLabel(
                        text: appString.createReportText,
                        size: appDimen.sp15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: appDimen.sp10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric( horizontal: appDimen.sp10),
                      width: width * 0.24,
                      child: reportTypes != null
                          ? CustomDropDown(
                              items: reportTypes,
                              id: getReportType,
                            )
                          : Container(),
                    ),
                    SizedBox(
                      height: appDimen.sp10,
                    ),
                    CustomRaisedButton(
                        text: appString.proceed,
                        width: width * 0.22,
                        color: Color(appColors.brown840000),
                        onPressed: () {
                          navigate();
                        }),
                  ],
                ),
              ),
            );
          } else {
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(appDimen.sp10)),
              child: Container(
                padding: EdgeInsets.all(appDimen.sp10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(appDimen.sp20),
                      child: CustomLabel(
                        text: appString.createReport,
                        size: appDimen.sp17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.8,
                      child: CustomLabel(
                        text: appString.createReportText,
                        size: appDimen.sp15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: appDimen.sp10,
                    ),
                    SizedBox(
                        width: width * 0.8,
                        child: CustomDropDown(
                          items: reportTypes,
                          id: getReportType,
                        )),
                    SizedBox(
                      height: appDimen.sp10,
                    ),
                    CustomRaisedButton(
                      text: appString.proceed,
                      width: width * 0.22,
                      color: Color(appColors.brown840000),
                      onPressed: () {
                        navigate();
                      },
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

  getReportType(ReportType reportType) {
    debugPrint(reportType.toString());
    reportId = reportType.id;
  }

  navigate() {
    if (reportId != null) {
      context.router.pop();
      if(reportId == 1) {
        context.pushRoute(SiteSurveyFormPage(reportCategoryId: reportId, projectId: widget.projectId)).then((value) {
          if (widget.refresh != null) {
            widget.refresh!();
          }
        });
      }else{
        context.pushRoute(SiteInspectionFormPage(projectId: int.parse(widget.projectId.toString()))).then((value) {
          if (widget.refresh != null) {
            widget.refresh!();
          }
        });
      }
      // context.router.navigateBack();
      // Navigator.pushNamed(
      //   context,
      //   RoutesConst.homePage + RoutesConst.siteSurveyForm,
      //   arguments: {"reportCategoryId": reportId, "projectId": widget.projectId},
      // ).then((value) {
      //   if (widget.refresh != null) {
      //     widget.refresh!();
      //   }
      // });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const CustomDialog(
            text: "Please Select Report Type.",
          );
        },
      );
    }
  }
}
