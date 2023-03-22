import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_network/image_network.dart';
import 'package:web/helper/constants/colors.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/helper/constants/images.dart';
import 'package:web/helper/constants/size_constants.dart';
import 'package:web/helper/constants/string.dart';
import 'package:web/helper/utils/common_methods.dart';
import 'package:web/models/response/report_list_modal.dart';
import 'package:web/view/shared_widget/custom_label.dart';
import 'package:web/view/shared_widget/custom_raised_button.dart';

class ReportsTile extends StatefulWidget {
  const ReportsTile({required this.report, required this.refresh, this.shareReport, this.share = false, Key? key})
      : super(key: key);

  final Data? report;
  final Function? refresh;
  final Function? shareReport;
  final bool share;

  @override
  State<ReportsTile> createState() => _ReportsTileState();
}

class _ReportsTileState extends State<ReportsTile> {
  Data? report;

  @override
  void initState() {
    report = widget.report;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return LayoutBuilder(builder: (BuildContext ctx, BoxConstraints constraints) {
      if (width > SizeConstants.tabWidth) {
        return report != null
            ? Card(
                child: IntrinsicWidth(
                  child: Container(
                    margin: EdgeInsets.all(appDimen.sp10),
                    // width: width,
                    // height: height * 0.13,
                    child: Column(
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                // color: Color(appColors.blueEBFFEF),
                                borderRadius: BorderRadius.circular(
                                  width * 0.008,
                                ),
                              ),
                              width: width * 0.06,
                              height: height * 0.12,
                              child: ImageNetwork(
                                  image: report != null ? report!.logo.toString() : '',
                                width: width * 0.06,
                                height: height * 0.12,
                                  fitWeb: BoxFitWeb.contain,
                                  imageCache: CachedNetworkImageProvider(report != null ? report!.logo.toString() : ''),
                              // child: Image.network(report != null ? report!.logo.toString() : ''),
                            )),
                            SizedBox(
                              width: width * 0.01,
                            ),
                            Expanded(
                              child: SizedBox(
                                width: width * 0.38,
                                height: height * 0.13,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CustomLabel(
                                          text: report?.createdAt != null && report!.createdAt!.isNotEmpty
                                              ? CommonMethods.formatDateToString(report!.createdAt!)
                                              : '',
                                          size: appDimen.sp17,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        CustomLabel(
                                          text: report?.createdAt != null && report!.createdAt!.isNotEmpty
                                              ? '(${CommonMethods.dateFormatterTimes(report!.createdAt!)})'
                                              : '',
                                          size: appDimen.sp12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: appDimen.sp5,
                                    ),
                                    Row(
                                      children: [
                                        CustomLabel(
                                          text: report?.projectName ?? '',
                                          size: appDimen.sp15,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        SizedBox(
                                          width: width * 0.002,
                                        ),
                                        (report != null && report!.projectCategory != null)
                                            ? SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    for (var cat in report!.projectCategory!)
                                                      cat != null
                                                          ? Container(
                                                              padding: EdgeInsets.all(
                                                                appDimen.sp3,
                                                              ),
                                                              margin: EdgeInsets.only(right: appDimen.sp3),
                                                              decoration: BoxDecoration(
                                                                color: Color(
                                                                    appColors.getColorHexFromStr(cat.color.toString())),
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
                                      ],
                                    ),
                                    SizedBox(
                                      height: appDimen.sp5,
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        width: width * 0.38,
                                        height: height * 0.06,
                                        child: CustomLabel(
                                          text: report?.address ?? '',
                                          fontWeight: FontWeight.w400,
                                          maxLines: 2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Visibility(
                              visible: !widget.share,
                              child: InkWell(
                                onTap: () {
                                  if (widget.shareReport != null) {
                                    String? id = report?.id != null ? report?.id.toString() : '';
                                    List<String> reportId = [id.toString()];
                                    print(appString.reportType[4]);
                                    widget.shareReport!(reportId, appString.reportType[4]);
                                  }
                                },
                                child: SvgPicture.asset(
                                  appImages.share,
                                  width: appDimen.sp24,
                                  height: appDimen.sp27,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: appDimen.sp10,
                        ),
                        const Divider(
                          thickness: 1,
                          height: 1,
                        ),
                        SizedBox(
                          height: appDimen.sp10,
                        ),
                        CustomRaisedButton(
                          width: width * 0.2,
                          text: report?.reportName ?? '',
                          color: Colors.white,
                          size: appDimen.sp15,
                          textColor: Color(appColors.brown840000),
                          sideColor: Color(appColors.brown840000),
                          onPressed: () {
                            // CommonMethods.download("https://www.africau.edu/images/default/sample.pdf");
                            CommonMethods.download(report?.pdfUrl ?? "");
                            // if (report?.reportCategoryName.toString().toLowerCase() == appString.siteSurveyReport.toString().toLowerCase()) {
                            //   context.router.push(ViewSiteSurveyFormPage(
                            //           reportId: report?.surveyReportId ?? 0,
                            //           reportCategoryId: report?.reportCategoryId ?? 0,
                            //           projectId: report?.projectId ?? 0))
                            //       .then((value) => widget.refresh != null ? widget.refresh!() : '');
                            //
                            //   // Navigator.pushNamed(
                            //   //   context,
                            //   //   RoutesConst.homePage + RoutesConst.viewSiteSurvey,
                            //   //   arguments: {
                            //   //     "id": report?.surveyReportId,
                            //   //     "reportCategoryId": report?.reportCategoryId,
                            //   //     "viewReport": true,
                            //   //   },
                            //   // ).then((value) => widget.refresh != null ? widget.refresh!() : '');
                            // }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container();
      } else {
        return report != null
            ? Card(
                child: Container(
                  margin: EdgeInsets.all(appDimen.sp10),
                  width: width,
                  // height: height * 0.13,
                  child: Column(
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              // color: Color(appColors.blueEBFFEF),
                              borderRadius: BorderRadius.circular(
                                width * 0.008,
                              ),
                            ),
                            width: width * 0.2,
                            height: height * 0.1,
                            child: ImageNetwork(
                              image: report != null ? report!.logo.toString() : '',
                              width: width * 0.2,
                              height: height * 0.1,
                              fitWeb: BoxFitWeb.contain,
                              imageCache: CachedNetworkImageProvider(report != null ? report!.logo.toString() : ''),
                              // child: Image.network(report != null ? report!.logo.toString() : ''),
                            )
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          Expanded(
                            child: SizedBox(
                              width: width * 0.38,
                              height: height * 0.13,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CustomLabel(
                                        text: report?.createdAt != null && report!.createdAt!.isNotEmpty
                                            ? CommonMethods.formatDateToString(report!.createdAt!)
                                            : '',
                                        size: appDimen.sp14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      Expanded(
                                        child: CustomLabel(
                                          text: report?.createdAt != null && report!.createdAt!.isNotEmpty
                                              ? '(${CommonMethods.dateFormatterTimes(report!.createdAt!)})'
                                              : '',
                                          size: appDimen.sp11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: appDimen.sp5,
                                  ),
                                  Row(
                                    children: [
                                      CustomLabel(
                                        text: report?.projectName ?? '',
                                        size: appDimen.sp12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      SizedBox(
                                        width: width * 0.005,
                                      ),
                                      Expanded(
                                        child: (report != null && report!.projectCategory != null)
                                            ? SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    for (var cat in report!.projectCategory!)
                                                      cat != null
                                                          ? Container(
                                                              padding: EdgeInsets.all(
                                                                appDimen.sp3,
                                                              ),
                                                              margin: EdgeInsets.only(right: appDimen.sp3),
                                                              decoration: BoxDecoration(
                                                                color: Color(
                                                                    appColors.getColorHexFromStr(cat.color.toString())),
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
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: appDimen.sp2,
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      width: width,
                                      height: height * 0.06,
                                      child: CustomLabel(
                                        text: report?.address ?? '',
                                        fontWeight: FontWeight.w400,
                                        size: appDimen.sp11,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          Visibility(
                            visible: !widget.share,
                            child: InkWell(
                              onTap: () {
                                if (widget.shareReport != null) {
                                  String? id = report?.id != null ? report?.id.toString() : '';
                                  List<String> reportId = [id.toString()];
                                  print(appString.reportType[4]);
                                  widget.shareReport!(reportId, appString.reportType[4]);
                                }
                              },
                              child: SvgPicture.asset(
                                appImages.share,
                                width: width * 0.03,
                                height: width * 0.04,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: appDimen.sp2,
                      ),
                      const Divider(
                        thickness: 1,
                        height: 1,
                      ),
                      SizedBox(
                        height: appDimen.sp10,
                      ),
                      CustomRaisedButton(
                        width: width * 0.9,
                        text: report?.reportName ?? '',
                        color: Colors.white,
                        size: appDimen.sp15,
                        textColor: Color(appColors.brown840000),
                        sideColor: Color(appColors.brown840000),
                        onPressed: () {
                          // CommonMethods.download("https://www.africau.edu/images/default/sample.pdf");
                          CommonMethods.download(report?.pdfUrl ?? "");
                          // if (report?.reportCategoryName.toString().toLowerCase() == appString.siteSurveyReport.toString().toLowerCase()) {
                          //   context.router
                          //       .push(ViewSiteSurveyFormPage(
                          //           reportId: report?.surveyReportId ?? 0,
                          //           reportCategoryId: report?.reportCategoryId ?? 0,
                          //           projectId: report?.projectId ?? 0))
                          //       .then((value) => widget.refresh != null ? widget.refresh!() : '');
                          //   // Navigator.pushNamed(
                          //   //   context,
                          //   //   RoutesConst.homePage + RoutesConst.viewSiteSurvey,
                          //   //   arguments: {
                          //   //     "id": report?.surveyReportId,
                          //   //     "reportCategoryId": report?.reportCategoryId,
                          //   //     "viewReport": true,
                          //   //   },
                          //   // ).then((value) => widget.refresh != null ? widget.refresh!() : '');
                          // }
                        },
                      ),
                    ],
                  ),
                ),
              )
            : Container();
      }
    });
  }
}
