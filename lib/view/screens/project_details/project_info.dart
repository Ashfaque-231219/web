import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_svg/svg.dart';
import 'package:web/helper/constants/colors.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/helper/constants/images.dart';
import 'package:web/helper/constants/size_constants.dart';
import 'package:web/helper/utils/common_methods.dart';
import 'package:web/models/response/project_info_modal.dart';
import 'package:web/view-model/projectDetailBloc/project_detail_bloc.dart';
import 'package:web/view/shared_widget/custom_label.dart';

class ProjectInfo extends StatefulWidget {
  final int projectId;

  const ProjectInfo({@PathParam('projectId') required this.projectId, Key? key}) : super(key: key);

  @override
  State<ProjectInfo> createState() => _ProjectInfoState();
}

class _ProjectInfoState extends State<ProjectInfo> {
  int _currentIndex = 0;
  List<String?> projectImages = [];

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  triggerProjectInfoEvent(ProjectDetailEvent event) {
    context.read<ProjectDetailBloc>().add(event);
  }

  @override
  void initState() {
    // projectImages = [appImages.projectInfo, appImages.projectInfo];
    triggerProjectInfoEvent(GetProjectInfoEvent(context: context, projectId: widget.projectId.toString()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocBuilder<ProjectDetailBloc, ProjectDetailState>(
      builder: (context, state) {
        ProjectDetails projectDetails = ProjectDetails();
        String date = '';
        if (state is GetProjectInfoState) {
          if (state.projectDetails != null && state.projectDetails!.data != null) {
            if (state.projectDetails!.data!.projectDetails != null && state.projectDetails!.data!.projectDetails![0] != null) {
              projectDetails = state.projectDetails!.data!.projectDetails![0]!;
            }
            if (state.projectDetails!.data!.images != null) {
              projectImages = state.projectDetails!.data!.images!;
            }
          }
        }
        // if (projectDetails.image != null) {
        //   projectImages.clear();
        //   if (projectDetails.image!.contains(',')) {
        //     projectImages = projectDetails.image!.split(',');
        //   } else {
        //     projectImages.add(projectDetails.image!);
        //   }
        // }

        if (projectDetails.projectStartDate != null && projectDetails.projectEndDate != null) {
          date =
              '${CommonMethods.dateFormatterYMDate(projectDetails.projectStartDate!)} - ${CommonMethods.dateFormatterYMDate(projectDetails.projectEndDate!)}';
        }
        debugPrint(projectDetails.toString());

        return LayoutBuilder(builder: (BuildContext ctx, BoxConstraints constraints) {
          if (width > SizeConstants.tabWidth) {
            return Scaffold(
              backgroundColor: Color(appColors.whiteF6F6F6),
              body: SingleChildScrollView(
                child: Center(
                  child: Container(
                    width: width * 0.65,
                    margin: EdgeInsets.all(appDimen.sp20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width * 0.65,
                          child: projectImages.isEmpty
                              ? Stack(
                                  children: [
                                    SizedBox(
                                      height: height * 0.6,
                                      child: Center(
                                        child: Image.asset(
                                          appImages.redwoodFrontLogo,
                                          opacity: const AlwaysStoppedAnimation(.5),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 20,
                                      left: 20,
                                      child: InkWell(
                                        onTap: () {
                                          context.router.navigateBack();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(appColors.white),
                                            borderRadius: BorderRadius.circular(appDimen.sp20),
                                          ),
                                          child: SvgPicture.asset(
                                            appImages.backBlack,
                                            width: appDimen.sp40,
                                            height: appDimen.sp40,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Stack(
                                  children: [
                                    Container(
                                      color: Colors.white,
                                      child: CarouselSlider(
                                        options: CarouselOptions(
                                          height: height * 0.6,
                                          viewportFraction: 1.0,
                                          onPageChanged: (index, reason) {
                                            setState(
                                              () {
                                                _currentIndex = index;
                                              },
                                            );
                                          },
                                        ),
                                        items: projectImages.map(
                                          (index) {
                                            return Builder(
                                              builder: (BuildContext context) {
                                                return Container(
                                                  width: width,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.transparent,
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: Image.network(
                                                      index.toString(),
                                                      fit: BoxFit.fill,
                                                      width: width * 0.65,
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: appDimen.sp10,
                                      left: 0,
                                      right: 0,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: map<Widget>(projectImages, (index, url) {
                                          return Container(
                                            width: appDimen.sp30,
                                            height: appDimen.sp3,
                                            margin: EdgeInsets.symmetric(vertical: appDimen.sp10, horizontal: appDimen.sp2),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: _currentIndex == index ? Colors.white : Colors.grey,
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                    Positioned(
                                      top: 20,
                                      left: 20,
                                      child: InkWell(
                                        onTap: () {
                                          context.router.navigateBack();
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(appColors.white),
                                            borderRadius: BorderRadius.circular(appDimen.sp20),
                                          ),
                                          child: SvgPicture.asset(
                                            appImages.backBlack,
                                            width: appDimen.sp40,
                                            height: appDimen.sp40,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                        SizedBox(
                          height: appDimen.sp20,
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
                          height: appDimen.sp10,
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: CustomLabel(
                                text: projectDetails.projectName ?? '',
                                size: appDimen.sp22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Flexible(
                              child: CustomLabel(
                                text: "(Reference No.- ${projectDetails.projectCode ?? ''})",
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: appDimen.sp10,
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
                        SizedBox(
                          height: appDimen.sp15,
                        ),
                        const Divider(
                          thickness: 1,
                          height: 1,
                        ),
                        SizedBox(
                          height: appDimen.sp15,
                        ),
                        CustomLabel(
                          text: "Details",
                          fontWeight: FontWeight.w500,
                          size: appDimen.sp15,
                        ),
                        SizedBox(
                          height: appDimen.sp10,
                        ),
                        CustomLabel(
                          text: projectDetails.description ?? '',
                          fontWeight: FontWeight.w400,
                        ),
                        SizedBox(
                          height: appDimen.sp10,
                        ),
                        (projectDetails.users != null && projectDetails.users!.isNotEmpty)
                            ? LayoutGrid(
                                columnSizes: [1.fr, 1.fr, 1.fr, 1.fr],
                                rowSizes: List.generate(
                                  projectDetails.users!.length,
                                  (index) => auto,
                                ),
                                rowGap: appDimen.sp10,
                                columnGap: appDimen.sp10,
                                children: List.generate(
                                  projectDetails.users!.length,
                                  (index) {
                                    return Center(
                                      child: SizedBox(
                                        width: width * 0.6,
                                        child: Card(
                                          child: GridTile(
                                            child: Padding(
                                              padding: EdgeInsets.all(appDimen.sp20),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: width * 0.06,
                                                    height: width * 0.06,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(
                                                        appDimen.sp10,
                                                      ),
                                                    ),
                                                    child: Image.network(
                                                      projectDetails.users![index]?.photo ?? '',
                                                      fit: BoxFit.fill,
                                                      errorBuilder: (context, url, error) => Image.asset(
                                                        appImages.rose,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: appDimen.sp5,
                                                  ),
                                                  Expanded(
                                                    child: CustomLabel(
                                                      text: projectDetails.users![index]?.name ?? '',
                                                      fontWeight: FontWeight.w500,
                                                      size: appDimen.sp16,
                                                      color: Color(appColors.grey7A7A7A),
                                                      alignment: TextAlign.center,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: appDimen.sp5,
                                                  ),
                                                  CustomLabel(
                                                    text: projectDetails.users![index]?.team ?? '',
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(appColors.greyA4A4A4),
                                                    alignment: TextAlign.center,
                                                  ),
                                                  SizedBox(
                                                    height: appDimen.sp5,
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.call_outlined,
                                                        color: Color(appColors.greyB4B4B4),
                                                        size: appDimen.sp13,
                                                      ),
                                                      Flexible(
                                                        child: CustomLabel(
                                                          text: projectDetails.users![index]?.phone ?? '',
                                                          fontWeight: FontWeight.w400,
                                                          size: appDimen.sp11,
                                                          color: Color(appColors.greyB4B4B4),
                                                          alignment: TextAlign.center,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: Color(appColors.whiteF6F6F6),
              body: SingleChildScrollView(
                child: Container(
                  width: width * 0.9,
                  margin: EdgeInsets.all(appDimen.sp20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: width,
                        child: projectImages.isEmpty
                            ? Stack(
                          children: [
                            SizedBox(
                              height: 200.0,
                              child: Center(
                                child: Image.asset(
                                  appImages.redwoodFrontLogo,
                                  opacity: const AlwaysStoppedAnimation(.5),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 20,
                              left: 20,
                              child: InkWell(
                                onTap: () {
                                  context.router.navigateBack();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(appColors.white),
                                    borderRadius: BorderRadius.circular(appDimen.sp20),
                                  ),
                                  child: SvgPicture.asset(
                                    appImages.backBlack,
                                    width: appDimen.sp40,
                                    height: appDimen.sp40,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                            : Stack(
                          children: [
                            Container(
                              color: Colors.white,
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  height: 200.0,
                                  viewportFraction: 1.0,
                                  onPageChanged: (index, reason) {
                                    setState(
                                      () {
                                        _currentIndex = index;
                                      },
                                    );
                                  },
                                ),
                                items: projectImages.map(
                                  (index) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return Container(
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.transparent,
                                            ),
                                          ),
                                          child: Center(
                                            child: Image.network(
                                              index.toString(),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ).toList(),
                              ),
                            ),
                            Positioned(
                              bottom: appDimen.sp10,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: map<Widget>(projectImages, (index, url) {
                                  return Container(
                                    width: appDimen.sp30,
                                    height: appDimen.sp3,
                                    margin: EdgeInsets.symmetric(vertical: appDimen.sp10, horizontal: appDimen.sp2),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: _currentIndex == index ? Colors.white : Colors.grey,
                                    ),
                                  );
                                }),
                              ),
                            ),
                            Positioned(
                              top: 20,
                              left: 20,
                              child: InkWell(
                                onTap: () {
                                  context.router.navigateBack();
                                  // context.router.navigateBack();
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(appColors.white),
                                    borderRadius: BorderRadius.circular(appDimen.sp20),
                                  ),
                                  child: SvgPicture.asset(
                                    appImages.backBlack,
                                    width: appDimen.sp40,
                                    height: appDimen.sp40,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: appDimen.sp20,
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
                        height: appDimen.sp10,
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: CustomLabel(
                              text: projectDetails.projectName ?? '',
                              size: appDimen.sp22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Flexible(
                            child: CustomLabel(
                              text: "(Reference No.- ${projectDetails.projectCode ?? ''})",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: appDimen.sp10,
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
                      SizedBox(
                        height: appDimen.sp15,
                      ),
                      const Divider(
                        thickness: 1,
                        height: 1,
                      ),
                      SizedBox(
                        height: appDimen.sp15,
                      ),
                      CustomLabel(
                        text: "Details",
                        fontWeight: FontWeight.w500,
                        size: appDimen.sp15,
                      ),
                      SizedBox(
                        height: appDimen.sp10,
                      ),
                      CustomLabel(
                        text: projectDetails.description ?? '',
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(
                        height: appDimen.sp10,
                      ),
                      (projectDetails.users != null && projectDetails.users!.isNotEmpty)
                          ? LayoutGrid(
                              columnSizes: [1.fr, 1.fr],
                              rowSizes: List.generate(
                                projectDetails.users!.length,
                                (index) => auto,
                              ),
                              rowGap: appDimen.sp10,
                              columnGap: appDimen.sp10,
                              children: List.generate(
                                projectDetails.users!.length,
                                (index) {
                                  return Center(
                                    child: SizedBox(
                                      width: width,
                                      child: Card(
                                        child: GridTile(
                                          child: Padding(
                                            padding: EdgeInsets.all(appDimen.sp20),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: width * 0.1,
                                                  height: width * 0.1,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(
                                                      appDimen.sp10,
                                                    ),
                                                  ),
                                                  child: Image.network(
                                                    projectDetails.users![index]?.photo ?? '',
                                                    fit: BoxFit.fill,
                                                    errorBuilder: (context, url, error) => Image.asset(
                                                      appImages.rose,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: appDimen.sp5,
                                                ),
                                                Expanded(
                                                  child: CustomLabel(
                                                    text: projectDetails.users![index]?.name ?? '',
                                                    fontWeight: FontWeight.w500,
                                                    size: appDimen.sp16,
                                                    color: Color(appColors.grey7A7A7A),
                                                    alignment: TextAlign.center,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: appDimen.sp5,
                                                ),
                                                CustomLabel(
                                                  text: projectDetails.users![index]?.team ?? '',
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(appColors.greyA4A4A4),
                                                  alignment: TextAlign.center,
                                                ),
                                                SizedBox(
                                                  height: appDimen.sp5,
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.call_outlined,
                                                      color: Color(appColors.greyB4B4B4),
                                                      size: appDimen.sp13,
                                                    ),
                                                    Flexible(
                                                      child: CustomLabel(
                                                        text: projectDetails.users![index]?.phone ?? '',
                                                        fontWeight: FontWeight.w400,
                                                        size: appDimen.sp11,
                                                        color: Color(appColors.greyB4B4B4),
                                                        alignment: TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            );
          }
        });
      },
    );
  }
}
