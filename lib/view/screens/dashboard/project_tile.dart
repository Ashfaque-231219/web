import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:web/helper/constants/colors.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/models/response/project_list_modal.dart';
import 'package:web/view/shared_widget/custom_label.dart';

class ProjectTile extends StatefulWidget {
  const ProjectTile({this.mobileView = false, required this.projectDetailsList, Key? key}) : super(key: key);

  final bool mobileView;
  final ProjectDetailsList? projectDetailsList;

  @override
  State<ProjectTile> createState() => _ProjectTileState();
}

class _ProjectTileState extends State<ProjectTile> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    ProjectDetailsList? projectDetailsList = widget.projectDetailsList;
    if (projectDetailsList != null) {
      return !widget.mobileView
          ? Container(
              width: width,
              // height: height * 0.13,
              padding: EdgeInsets.all(appDimen.sp8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.5, 1),
                    blurRadius: 1,
                    spreadRadius: 1,
                  )
                ],
                color: Colors.white,
              ),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width * 0.002,
                      color: Color(appColors.brown840000),
                    ),
                    SizedBox(
                      width: width * 0.006,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        // color: Color(appColors.blueEBFFEF),
                        borderRadius: BorderRadius.circular(
                          width * 0.008,
                        ),
                      ),
                      width: width * 0.08,
                      height: height * 0.12,
                      child:  ImageNetwork(
                          image: projectDetailsList.logo.toString(),
                          height: height * 0.12,
                          width: width * 0.08,
                          fitWeb: BoxFitWeb.contain,
                          imageCache: CachedNetworkImageProvider(projectDetailsList.logo.toString()))
                      /*Image.network(projectDetailsList.logo.toString()*/),

                    SizedBox(
                      width: width * 0.01,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: appDimen.sp5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomLabel(
                              text: projectDetailsList.projectName.toString(),
                              size: appDimen.sp16,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(
                              height: appDimen.sp5,
                            ),
                            (projectDetailsList.projectCategory != null)
                                ? SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        for (var cat in projectDetailsList.projectCategory!)
                                          cat != null
                                              ? Container(
                                                  padding: EdgeInsets.all(
                                                    appDimen.sp3,
                                                  ),
                                                  margin: EdgeInsets.only(right: appDimen.sp3),
                                                  decoration: BoxDecoration(
                                                    color: Color(appColors.getColorHexFromStr(cat.color.toString())),
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
                              text: projectDetailsList.address ?? '',
                              fontWeight: FontWeight.w400,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          : Card(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.5, 1),
                      blurRadius: 1,
                      spreadRadius: 1,
                    )
                  ],
                  color: Colors.white,
                ),
                width: width,
                // height: height * 0.13,
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Container(
                        width: width * 0.01,
                        color: Color(appColors.brown840000),
                      ),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          // color: Color(appColors.blueEBFFEF),
                          borderRadius: BorderRadius.circular(width * 0.008),
                        ),
                        width: width * 0.28,
                        height: height * 0.12,
                        child:  ImageNetwork(
                            image: projectDetailsList.logo.toString(),
                            height: height * 0.12,
                            width: width * 0.28,
                            fitWeb: BoxFitWeb.fill,
                            imageCache: CachedNetworkImageProvider(projectDetailsList.logo.toString()))
                        /*Image(
                          image: NetworkImage(
                            projectDetailsList.logo.toString(),
                            headers: {"Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept"},
                          ),
                        ),*/
                      ),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: appDimen.sp5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomLabel(
                                text: projectDetailsList.projectName.toString(),
                                size: appDimen.sp16,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(
                                height: width * 0.01,
                              ),
                              (projectDetailsList.projectCategory != null)
                                  ? SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          for (var cat in projectDetailsList.projectCategory!)
                                            cat != null
                                                ? Container(
                                                    padding: EdgeInsets.all(
                                                      appDimen.sp3,
                                                    ),
                                                    margin: EdgeInsets.only(right: appDimen.sp3),
                                                    decoration: BoxDecoration(
                                                      color: Color(appColors.getColorHexFromStr(cat.color.toString())),
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
                                height: width * 0.01,
                              ),
                              CustomLabel(
                                text: projectDetailsList.address ?? '',
                                fontWeight: FontWeight.w400,
                                size: appDimen.sp12,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
    } else {
      return Container();
    }
  }
}
