import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web/Routing/routing.gr.dart' as route;
import 'package:web/helper/constants/colors.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/helper/constants/images.dart';
import 'package:web/helper/constants/size_constants.dart';
import 'package:web/helper/constants/string.dart';
import 'package:web/helper/utils/common_methods.dart';
import 'package:web/models/response/project_details_modal.dart';
import 'package:web/view/shared_widget/custom_label.dart';

class ProjectReports extends StatelessWidget {
  const ProjectReports({this.reports, this.refresh, this.share, Key? key}) : super(key: key);

  final List<Reports?>? reports;
  final Function? refresh;
  final Function? share;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return reports != null && reports!.isNotEmpty
        ? LayoutBuilder(builder: (BuildContext ctx, BoxConstraints constraints) {
            if (width > SizeConstants.tabWidth) {
              return ListView.builder(
                itemCount: reports!.length,
                itemBuilder: (context, int index) {
                  return reports![index] != null
                      ? GestureDetector(
                          onTap: () {
                            if (reports![index]!.name.toString().toLowerCase() == appString.siteSurveyReport.toString().toLowerCase()) {
                              context.router
                                  .push(route.ViewSiteSurveyFormPage(
                                      reportId: reports![index]!.id!,
                                      reportCategoryId: reports![index]!.reportCategoryId!,
                                      projectId: reports![index]!.projectId!))
                                  .then((value) {
                                if (refresh != null) refresh!();
                              });
                            } else {
                              context.router.push(route.ViewSiteInspectionReport(
                                      reportId: reports![index]!.reportId!,
                                      projectId: reports![index]!.projectId!))
                                  .then((value) {
                                if (refresh != null) refresh!();
                              });
                            }
                          },
                          child: Card(
                            child: Container(
                              margin: EdgeInsets.all(appDimen.sp10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomLabel(
                                            text: reports![index]!.name ?? '',
                                            color: Color(appColors.brown840000),
                                            size: appDimen.sp16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          SizedBox(
                                            height: appDimen.sp10,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: width * 0.2,
                                                child: Row(
                                                  children: [
                                                    CustomLabel(
                                                      text: reports![index]!.createdAt != null && reports![index]!.createdAt!.isNotEmpty
                                                          ? CommonMethods.formatDateToString(reports![index]!.createdAt!)
                                                          : '',
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    SizedBox(
                                                      width: appDimen.sp10,
                                                    ),
                                                    CustomLabel(
                                                      text: reports![index]!.createdAt != null && reports![index]!.createdAt!.isNotEmpty
                                                          ? '(${CommonMethods.dateFormatterTimes(reports![index]!.createdAt!)})'
                                                          : '',
                                                      color: Color(appColors.grey767676),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: CustomLabel(
                                                  text: '50 kb',
                                                  color: Color(appColors.greyC0C0C0),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.03,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      // CommonMethods.download("https://www.africau.edu/images/default/sample.pdf");
                                      CommonMethods.download(reports![index]!.pdfUrl ?? '');
                                      // File file = await CommonMethods().downloadFile("https://www.africau.edu/images/default/sample.pdf", "Sample Pdf");
                                      // print(file.path);
                                      // print(file.path.split("/").last);
                                    },
                                    child: SvgPicture.asset(
                                      appImages.download,
                                      width: appDimen.sp20,
                                      height: appDimen.sp27,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.03,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (share != null) {
                                        if (reports![index]!.reportCategoryId != null && reports![index]!.reportCategoryId == 1) {
                                          String? id = reports![index]!.id != null ? reports![index]!.id.toString() : '';
                                          List<String> reportId = [id.toString()];
                                          print(appString.reportType[0]);
                                          share!(reportId, appString.reportType[0]);
                                        } else {
                                          String? id = reports![index]!.reportId != null ? reports![index]!.reportId.toString() : '';
                                          List<String> reportId = [id.toString()];
                                          print(appString.reportType[1]);
                                          share!(reportId, appString.reportType[1]);
                                        }
                                      }
                                    },
                                    child: SvgPicture.asset(
                                      appImages.share,
                                      width: appDimen.sp24,
                                      height: appDimen.sp27,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : const Center(
                          child: Text("No Record(s) Found."),
                        );
                },
              );
            } else {
              return ListView.builder(
                itemCount: reports!.length,
                itemBuilder: (context, int index) {
                  return reports![index] != null
                      ? GestureDetector(
                          onTap: () {
                            if (reports![index]!.name.toString().toLowerCase() == appString.siteSurveyReport.toString().toLowerCase()) {
                              context.router
                                  .push(route.ViewSiteSurveyFormPage(
                                      reportId: reports![index]!.id!,
                                      reportCategoryId: reports![index]!.reportCategoryId!,
                                      projectId: reports![index]!.projectId!))
                                  .then((value) {
                                if (refresh != null) refresh!();
                              });
                            }else{
                              context.router.push(route.ViewSiteInspectionReport(
                                  reportId: reports![index]!.reportId!,
                                  projectId: reports![index]!.projectId!))
                                  .then((value) {
                                if (refresh != null) refresh!();
                              });
                            }
                          },
                          child: Card(
                            child: Container(
                              width: width,
                              margin: EdgeInsets.all(appDimen.sp10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomLabel(
                                            text: reports![index]!.name ?? '',
                                            color: Color(appColors.brown840000),
                                            size: appDimen.sp16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          SizedBox(
                                            height: appDimen.sp10,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: width * 0.4,
                                                child: Row(
                                                  children: [
                                                    CustomLabel(
                                                      text: reports![index]!.createdAt != null && reports![index]!.createdAt!.isNotEmpty
                                                          ? CommonMethods.formatDateToString(reports![index]!.createdAt!)
                                                          : '',
                                                      size: appDimen.sp13,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                    SizedBox(
                                                      width: appDimen.sp10,
                                                    ),
                                                    CustomLabel(
                                                      text: reports![index]!.createdAt != null && reports![index]!.createdAt!.isNotEmpty
                                                          ? '(${CommonMethods.dateFormatterTimes(reports![index]!.createdAt!)} )'
                                                          : '',
                                                      size: appDimen.sp13,
                                                      color: Color(appColors.grey767676),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: CustomLabel(
                                                  text: '50 kb',
                                                  size: appDimen.sp13,
                                                  color: Color(appColors.greyC0C0C0),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.03,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      // CommonMethods.download("https://www.africau.edu/images/default/sample.pdf");
                                      CommonMethods.download(reports![index]!.pdfUrl ?? '');
                                      // File file = await CommonMethods().downloadFile("https://www.africau.edu/images/default/sample.pdf", "Sample Pdf");
                                      // print(file.path);
                                      // print(file.path.split("/").last);
                                    },
                                    child: SvgPicture.asset(
                                      appImages.download,
                                      width: width * 0.03,
                                      height: width * 0.04,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.03,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (share != null) {
                                        if (reports![index]!.reportCategoryId != null && reports![index]!.reportCategoryId == 1) {
                                          String? id = reports![index]!.id != null ? reports![index]!.id.toString() : '';
                                          List<String> reportId = [id.toString()];
                                          print(appString.reportType[0]);
                                          share!(reportId, appString.reportType[0]);
                                        } else {
                                          String? id = reports![index]!.reportId != null ? reports![index]!.reportId.toString() : '';
                                          List<String> reportId = [id.toString()];
                                          print(appString.reportType[1]);
                                          share!(reportId, appString.reportType[1]);
                                        }
                                      }
                                    },
                                    child: SvgPicture.asset(
                                      appImages.share,
                                      width: width * 0.03,
                                      height: width * 0.04,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : const Center(
                          child: Text("No Record(s) Found."),
                        );
                },
              );
            }
          })
        : const Center(
            child: Text("No Record(s) Found."),
          );
  }
}
