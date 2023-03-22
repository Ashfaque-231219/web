import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:web/helper/constants/colors.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/helper/constants/images.dart';
import 'package:web/helper/constants/size_constants.dart';
import 'package:web/helper/constants/string.dart';
import 'package:web/helper/utils/common_methods.dart';
import 'package:web/helper/utils/utils.dart';
import 'package:web/models/response/site_survey_report_modal.dart';
import 'package:web/view-model/siteSurveyReportBloc/site_survey_report_bloc.dart';
import 'package:web/view/shared_widget/custom_dialog.dart';
import 'package:web/view/shared_widget/custom_label.dart';
import 'package:web/view/shared_widget/custom_raised_button.dart';
import 'package:web/view/shared_widget/custom_text_field.dart';

class ViewSiteSurveyFormPage extends StatefulWidget {
  const ViewSiteSurveyFormPage({
    @PathParam("id") required this.reportId,
    @PathParam("reportCategoryId") required this.reportCategoryId,
    @PathParam("projectId") required this.projectId,
    Key? key,
  }) : super(key: key);

  final int reportId;
  final int reportCategoryId;
  final int projectId;

  @override
  State<ViewSiteSurveyFormPage> createState() => _ViewSiteSurveyFormPageState();
}

class _ViewSiteSurveyFormPageState extends State<ViewSiteSurveyFormPage> {
  ExpandableController siteMeasurementController = ExpandableController(initialExpanded: true);
  ExpandableController uploadLayoutController = ExpandableController(initialExpanded: false);
  ExpandableController upload360Controller = ExpandableController(initialExpanded: false);
  TextEditingController lengthController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController onLoadingController = TextEditingController();
  TextEditingController offLoadingController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  File? _pickedImage;
  File? _picked360Image;
  File? _video;
  Uint8List? webImage;
  Uint8List? web360Image;
  Uint8List? webVideo;
  bool editReport = false;
  String layoutPlanImage = '';
  String the360degreeImage = '';
  String the360degreeVideo = '';

  bool videoPlayer = false;

  VideoPlayerController? _videoPlayerController;
  Future<void>? _initializeVideoPlayerFuture;

  Duration newCurrentPosition = Duration.zero;

  bool view = false;

  @override
  void initState() {
    siteMeasurementController = ExpandableController(initialExpanded: true);
    uploadLayoutController = ExpandableController(initialExpanded: true);
    upload360Controller = ExpandableController(initialExpanded: true);
    if (widget.reportId != null) {
      triggerSiteSurveyEvent(ViewReportEvent(reportId: widget.reportId, context: context));
    }
    // _initController('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');

    _videoPlayerController = VideoPlayerController.network('');
    _videoPlayerController!.addListener(() {});
    _initializeVideoPlayerFuture = _videoPlayerController!.initialize();
    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _initializeVideoPlayerFuture = null;
    _videoPlayerController!.dispose();
    super.dispose();
  }

  triggerSiteSurveyEvent(SiteSurveyReportEvent event) {
    context.read<SiteSurveyReportBloc>().add(event);
  }

  int i = 1;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocBuilder<SiteSurveyReportBloc, SiteSurveyReportState>(
      builder: (context, state) {
        SiteSurveyModalData? siteSurveyModalData;
        if (state is ViewSiteSurveyReportState) {
          if (state.report != null && state.report!.data != null) {
            siteSurveyModalData = state.report!.data!;
          }
          if (siteSurveyModalData != null &&
              siteSurveyModalData.the360DegreeImage != null &&
              siteSurveyModalData.the360DegreeImage!.contains('mp4')) {
            the360degreeVideo = siteSurveyModalData.the360DegreeImage ?? '';
            if (the360degreeVideo.isNotEmpty) {
              if (i == 1) {
                Future.delayed(Duration.zero, () {
                  _getValuesAndPlay(the360degreeVideo);
                  print(_videoPlayerController);
                  setState(() {
                    i++;
                  });
                  if (_videoPlayerController!.value.isInitialized) {
                    _videoPlayerController!.play();
                    _videoPlayerController!.setLooping(true);
                  }
                  videoPlayer = true;
                });
              }
            }
          } else {
            videoPlayer = false;
            the360degreeImage = siteSurveyModalData!.the360DegreeImage ?? '';
          }
        }

        if (siteSurveyModalData != null) {
          lengthController.text = siteSurveyModalData.length ?? '';
          widthController.text = siteSurveyModalData.width ?? '';
          areaController.text = siteSurveyModalData.area ?? '';
          onLoadingController.text = siteSurveyModalData.onloadingLocation ?? '';
          offLoadingController.text = siteSurveyModalData.offloadingLocation ?? '';
          descriptionController.text = siteSurveyModalData.description ?? '';
          layoutPlanImage = siteSurveyModalData.layoutPlanImage ?? '';
        }

        return LayoutBuilder(builder: (BuildContext ctx, BoxConstraints constraints) {
          if (width > SizeConstants.tabWidth) {
            return WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                  body: SingleChildScrollView(
                child: Center(
                  child: Container(
                    width: width * 0.5,
                    margin: EdgeInsets.all(appDimen.sp20),
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
                                width: appDimen.sp40,
                                height: appDimen.sp40,
                              ),
                            ),
                            SizedBox(
                              width: appDimen.sp20,
                            ),
                            Expanded(
                              child: CustomLabel(
                                text: editReport ? 'Edit Site Survey Report' : 'View Site Survey Report',
                                size: appDimen.sp16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Visibility(
                              visible: !editReport,
                              child: InkWell(
                                onTap: () {
                                  editReport = true;
                                  setState(() {});
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: appDimen.sp15),
                                  child: SvgPicture.asset(
                                    appImages.edit,
                                    width: appDimen.sp20,
                                    height: appDimen.sp20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: appDimen.sp20,
                        ),
                        ExpandablePanel(
                          controller: siteMeasurementController,
                          header: CustomLabel(
                            text: 'Site Measurements',
                            fontWeight: FontWeight.w600,
                            size: appDimen.sp15,
                          ),
                          theme: const ExpandableThemeData(
                            headerAlignment: ExpandablePanelHeaderAlignment.center,
                          ),
                          collapsed: const Text(
                            "",
                            softWrap: true,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          expanded: Container(
                            width: width * 0.5,
                            padding: EdgeInsets.all(appDimen.sp10),
                            margin: EdgeInsets.all(appDimen.sp10),
                            decoration: BoxDecoration(
                              color: Color(appColors.white),
                              borderRadius: BorderRadius.all(Radius.circular(appDimen.sp5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: const Offset(0.0, 2.0), //(x,y)
                                  blurRadius: appDimen.sp5,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: width * 0.35,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              child: CustomLabel(
                                                text: 'Length',
                                                size: appDimen.sp13,
                                                color: Color(appColors.grey7A7A7A),
                                              ),
                                            ),
                                            CustomTextField(
                                              onTextChanged: lengthController,
                                              borderRadius: appDimen.sp5,
                                              hintText: appString.lengthWidthHint,
                                              inputType: TextInputType.number,
                                              maxLength: 20,
                                              onChanged: (text) {
                                                if (lengthController.text.isNotEmpty && widthController.text.isNotEmpty) {
                                                  areaController.text =
                                                      (double.parse(lengthController.text) * double.parse(widthController.text)).toString();
                                                } else {
                                                  areaController.text = '';
                                                }
                                              },
                                              readonly: !editReport,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: appDimen.sp10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              child: CustomLabel(
                                                text: 'Width',
                                                size: appDimen.sp13,
                                                color: Color(appColors.grey7A7A7A),
                                              ),
                                            ),
                                            CustomTextField(
                                              onTextChanged: widthController,
                                              borderRadius: appDimen.sp5,
                                              hintText: appString.lengthWidthHint,
                                              maxLength: 20,
                                              inputType: TextInputType.number,
                                              onChanged: (text) {
                                                if (lengthController.text.isNotEmpty && widthController.text.isNotEmpty) {
                                                  areaController.text =
                                                      (double.parse(lengthController.text) * double.parse(widthController.text)).toString();
                                                } else {
                                                  areaController.text = '';
                                                }
                                              },
                                              readonly: !editReport,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: appDimen.sp10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              child: CustomLabel(
                                                text: 'Area',
                                                size: appDimen.sp13,
                                                color: Color(appColors.grey7A7A7A),
                                              ),
                                            ),
                                            CustomTextField(
                                              onTextChanged: areaController,
                                              borderRadius: appDimen.sp5,
                                              hintText: appString.areaHint,
                                              maxLength: 20,
                                              inputType: TextInputType.number,
                                              readonly: true,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: appDimen.sp10,
                                ),
                                SizedBox(
                                  width: width * 0.4,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              child: CustomLabel(
                                                text: 'Onloading Location',
                                                size: appDimen.sp13,
                                                color: Color(appColors.grey7A7A7A),
                                              ),
                                            ),
                                            CustomTextField(
                                              onTextChanged: onLoadingController,
                                              borderRadius: appDimen.sp5,
                                              hintText: appString.loadingLocationHint,
                                              maxLength: 50,
                                              readonly: !editReport,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: appDimen.sp10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              child: CustomLabel(
                                                text: 'Offloading Location',
                                                size: appDimen.sp13,
                                                color: Color(appColors.grey7A7A7A),
                                              ),
                                            ),
                                            CustomTextField(
                                              onTextChanged: offLoadingController,
                                              borderRadius: appDimen.sp5,
                                              hintText: appString.loadingLocationHint,
                                              maxLength: 50,
                                              readonly: !editReport,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: editReport,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: appDimen.sp15,
                                      ),
                                      CustomRaisedButton(
                                        width: width * 0.15,
                                        text: 'Next',
                                        color: Colors.white,
                                        textColor: Color(appColors.brown840000),
                                        sideColor: Color(appColors.brown840000),
                                        onPressed: () {
                                          // checkMeasurements();
                                          siteMeasurementController.value = false;
                                          uploadLayoutController.value = true;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: appDimen.sp10,
                        ),
                        Divider(
                          thickness: appDimen.sp1,
                          height: appDimen.sp1,
                        ),
                        SizedBox(
                          height: appDimen.sp10,
                        ),
                        ExpandablePanel(
                          controller: uploadLayoutController,
                          header: CustomLabel(
                            text: 'Upload Layout Plan Images',
                            fontWeight: FontWeight.w600,
                            size: appDimen.sp15,
                          ),
                          theme: const ExpandableThemeData(
                            headerAlignment: ExpandablePanelHeaderAlignment.center,
                          ),
                          collapsed: const Text(
                            "",
                            softWrap: true,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          expanded: Container(
                            width: width * 0.5,
                            padding: EdgeInsets.all(appDimen.sp10),
                            margin: EdgeInsets.all(appDimen.sp10),
                            decoration: BoxDecoration(
                              color: Color(appColors.white),
                              borderRadius: BorderRadius.all(Radius.circular(appDimen.sp5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: const Offset(0.0, 2.0), //(x,y)
                                  blurRadius: appDimen.sp5,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  // width: width * 0.35,
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: CustomLabel(
                                              text: 'Add Image',
                                              size: appDimen.sp13,
                                              color: Color(appColors.grey7A7A7A),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (editReport) {
                                                _pickImage();
                                              }
                                            },
                                            child: DottedBorder(
                                              dashPattern: const [4, 4],
                                              strokeWidth: 1,
                                              color: Color(appColors.greyA5A5A5),
                                              radius: Radius.circular(appDimen.sp5),
                                              child: _pickedImage == null
                                                  ? layoutPlanImage.isNotEmpty
                                                      ? SizedBox(
                                                          width: width * 0.2,
                                                          height: height * 0.3,
                                                          child:
                                                          ImageNetwork(
                                                            fitWeb: BoxFitWeb.fill,
                                                            image: layoutPlanImage,
                                                            height: height * 0.3,
                                                            width: width * 0.2,
                                                            imageCache: CachedNetworkImageProvider(layoutPlanImage),

                                                          ),/*Image.network(
                                                            layoutPlanImage,
                                                            fit: BoxFit.fill,
                                                          ),*/
                                                        )
                                                      : SizedBox(
                                                          width: width * 0.2,
                                                          height: height * 0.3,
                                                          child: Icon(
                                                            Icons.camera_alt_outlined,
                                                            size: appDimen.sp40,
                                                            color: Color(
                                                              appColors.greyA5A5A5,
                                                            ),
                                                          ),
                                                        )
                                                  : SizedBox(
                                                      width: width * 0.2,
                                                      height: height * 0.3,
                                                      child: Image.memory(
                                                        webImage ?? Uint8List(8),
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: appDimen.sp10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              child: CustomLabel(
                                                text: 'Description',
                                                size: appDimen.sp13,
                                                color: Color(appColors.grey7A7A7A),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.3,
                                              child: CustomTextField(
                                                onTextChanged: descriptionController,
                                                borderRadius: appDimen.sp5,
                                                maxLines: null,
                                                maxLength: 100,
                                                inputType: TextInputType.multiline,
                                                expands: true,
                                                hintText: appString.descriptionHint,
                                                readonly: !editReport,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: editReport,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: appDimen.sp15,
                                      ),
                                      CustomRaisedButton(
                                        width: width * 0.15,
                                        text: 'Next',
                                        color: Colors.white,
                                        textColor: Color(appColors.brown840000),
                                        sideColor: Color(appColors.brown840000),
                                        onPressed: () {
                                          // checkLayoutPlan();
                                          uploadLayoutController.value = false;
                                          upload360Controller.value = true;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: appDimen.sp10,
                        ),
                        Divider(
                          thickness: appDimen.sp1,
                          height: appDimen.sp1,
                        ),
                        SizedBox(
                          height: appDimen.sp10,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: ExpandablePanel(
                            controller: upload360Controller,
                            header: CustomLabel(
                              text: 'Upload 360 degree Image / Video',
                              fontWeight: FontWeight.w600,
                              size: appDimen.sp15,
                            ),
                            theme: const ExpandableThemeData(
                              headerAlignment: ExpandablePanelHeaderAlignment.center,
                            ),
                            collapsed: const Text(
                              "",
                              softWrap: true,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            expanded: Container(
                              width: width * 0.5,
                              padding: EdgeInsets.all(appDimen.sp10),
                              margin: EdgeInsets.all(appDimen.sp10),
                              decoration: BoxDecoration(
                                color: Color(appColors.white),
                                borderRadius: BorderRadius.all(Radius.circular(appDimen.sp5)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: const Offset(0.0, 2.0), //(x,y)
                                    blurRadius: appDimen.sp5,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width * 0.35,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: CustomLabel(
                                            text: 'Add Image / Video',
                                            size: appDimen.sp13,
                                            color: Color(appColors.grey7A7A7A),
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              if (editReport) {
                                                pickerDialog();
                                              }
                                            },
                                            child: DottedBorder(
                                                dashPattern: const [4, 4],
                                                strokeWidth: 1,
                                                color: Color(appColors.greyA5A5A5),
                                                radius: Radius.circular(appDimen.sp5),
                                                child: _video == null && videoPlayer == false
                                                    ? _picked360Image == null
                                                        ? the360degreeImage.isNotEmpty
                                                            ? SizedBox(
                                                                width: width * 0.2,
                                                                height: height * 0.3,
                                                                child: ImageNetwork(
                                                                  fitWeb: BoxFitWeb.fill,
                                                                  image: the360degreeImage,
                                                                  height: height * 0.3,
                                                                  width: width * 0.2,
                                                                  imageCache: CachedNetworkImageProvider(the360degreeImage),

                                                                ),
                                                  /*Image.network(
                                                                  the360degreeImage,
                                                                  fit: BoxFit.fill,
                                                                ),*/
                                                              )
                                                            : SizedBox(
                                                                height: height * 0.3,
                                                                width: width * 0.2,
                                                                child: Icon(
                                                                  Icons.camera_alt_outlined,
                                                                  size: appDimen.sp40,
                                                                  color: Color(
                                                                    appColors.greyA5A5A5,
                                                                  ),
                                                                ),
                                                              )
                                                        : SizedBox(
                                                            width: width * 0.2,
                                                            height: height * 0.3,
                                                            child: Image.memory(
                                                              web360Image!,
                                                              fit: BoxFit.fill,
                                                            ))
                                                    : _videoPlayerController != null && _videoPlayerController!.value.isInitialized
                                                        ? AspectRatio(
                                                            aspectRatio: _videoPlayerController!.value.aspectRatio,
                                                            child: Stack(
                                                              children: [
                                                                VideoPlayer(_videoPlayerController!),
                                                                GestureDetector(
                                                                  onTap: () {
                                                                    if (editReport) {
                                                                      pickerDialog();
                                                                    }
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        : const CircularProgressIndicator()))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: editReport,
                          child: Column(
                            children: [
                              SizedBox(
                                height: appDimen.sp10,
                              ),
                              CustomRaisedButton(
                                width: width * 0.2,
                                text: 'Generate Report',
                                color: Color(appColors.brown840000),
                                textColor: Color(appColors.white),
                                sideColor: Color(appColors.white),
                                onPressed: () {
                                  navigate();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
            );
          } else {
            return Scaffold(
                body: SingleChildScrollView(
              child: Center(
                child: Container(
                  width: width * 0.9,
                  margin: EdgeInsets.all(appDimen.sp20),
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
                              width: appDimen.sp40,
                              height: appDimen.sp40,
                            ),
                          ),
                          SizedBox(
                            width: appDimen.sp20,
                          ),
                          Expanded(
                            child: CustomLabel(
                              text: editReport ? 'Edit Site Survey Report' : 'View Site Survey Report',
                              size: appDimen.sp16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Visibility(
                            visible: !editReport,
                            child: InkWell(
                              onTap: () {
                                editReport = true;
                                setState(() {});
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: appDimen.sp15),
                                child: SvgPicture.asset(
                                  appImages.edit,
                                  width: appDimen.sp20,
                                  height: appDimen.sp20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: appDimen.sp20,
                      ),
                      ExpandablePanel(
                        controller: siteMeasurementController,
                        header: CustomLabel(
                          text: 'Site Measurements',
                          fontWeight: FontWeight.w600,
                          size: appDimen.sp15,
                        ),
                        theme: const ExpandableThemeData(
                          headerAlignment: ExpandablePanelHeaderAlignment.center,
                        ),
                        collapsed: const Text(
                          "",
                          softWrap: true,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        expanded: Container(
                          width: width * 0.9,
                          padding: EdgeInsets.all(appDimen.sp10),
                          margin: EdgeInsets.all(appDimen.sp10),
                          decoration: BoxDecoration(
                            color: Color(appColors.white),
                            borderRadius: BorderRadius.all(Radius.circular(appDimen.sp5)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: const Offset(0.0, 2.0), //(x,y)
                                blurRadius: appDimen.sp5,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: width * 0.9,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: CustomLabel(
                                              text: 'Length',
                                              size: appDimen.sp16,
                                              color: Color(appColors.grey7A7A7A),
                                            ),
                                          ),
                                          CustomTextField(
                                            onTextChanged: lengthController,
                                            borderRadius: appDimen.sp5,
                                            hintText: appString.lengthWidthHint,
                                            maxLength: 15,
                                            inputType: TextInputType.number,
                                            onChanged: (text) {
                                              if (lengthController.text.isNotEmpty && widthController.text.isNotEmpty) {
                                                areaController.text =
                                                    (double.parse(lengthController.text) * double.parse(widthController.text)).toString();
                                              } else {
                                                areaController.text = '';
                                              }
                                            },
                                            readonly: !editReport,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: appDimen.sp10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: CustomLabel(
                                              text: 'Width',
                                              size: appDimen.sp16,
                                              color: Color(appColors.grey7A7A7A),
                                            ),
                                          ),
                                          CustomTextField(
                                            onTextChanged: widthController,
                                            borderRadius: appDimen.sp5,
                                            hintText: appString.lengthWidthHint,
                                            maxLength: 15,
                                            inputType: TextInputType.number,
                                            onChanged: (text) {
                                              if (lengthController.text.isNotEmpty && widthController.text.isNotEmpty) {
                                                areaController.text =
                                                    (double.parse(lengthController.text) * double.parse(widthController.text)).toString();
                                              } else {
                                                areaController.text = '';
                                              }
                                            },
                                            readonly: !editReport,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: appDimen.sp10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: CustomLabel(
                                              text: 'Area',
                                              size: appDimen.sp16,
                                              color: Color(appColors.grey7A7A7A),
                                            ),
                                          ),
                                          CustomTextField(
                                            onTextChanged: areaController,
                                            borderRadius: appDimen.sp5,
                                            hintText: appString.areaHint,
                                            inputType: TextInputType.number,
                                            readonly: true,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: appDimen.sp19,
                              ),
                              SizedBox(
                                width: width * 0.88,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: CustomLabel(
                                              text: 'Onloading Location',
                                              size: appDimen.sp16,
                                              color: Color(appColors.grey7A7A7A),
                                            ),
                                          ),
                                          CustomTextField(
                                            onTextChanged: onLoadingController,
                                            borderRadius: appDimen.sp5,
                                            hintText: appString.loadingLocationHint,
                                            maxLength: 50,
                                            readonly: !editReport,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: appDimen.sp10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                            child: CustomLabel(
                                              text: 'Offloading Location',
                                              size: appDimen.sp16,
                                              color: Color(appColors.grey7A7A7A),
                                            ),
                                          ),
                                          CustomTextField(
                                            onTextChanged: offLoadingController,
                                            borderRadius: appDimen.sp5,
                                            hintText: appString.loadingLocationHint,
                                            maxLength: 50,
                                            readonly: !editReport,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: editReport,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: appDimen.sp18,
                                    ),
                                    CustomRaisedButton(
                                      width: width * 0.9,
                                      text: 'Next',
                                      color: Colors.white,
                                      textColor: Color(appColors.brown840000),
                                      sideColor: Color(appColors.brown840000),
                                      onPressed: () {
                                        // checkMeasurements();
                                        siteMeasurementController.value = false;
                                        uploadLayoutController.value = true;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: appDimen.sp10,
                      ),
                      Divider(
                        thickness: appDimen.sp1,
                        height: appDimen.sp1,
                      ),
                      SizedBox(
                        height: appDimen.sp10,
                      ),
                      ExpandablePanel(
                        controller: uploadLayoutController,
                        header: CustomLabel(
                          text: 'Upload Layout Plan Images',
                          fontWeight: FontWeight.w600,
                          size: appDimen.sp15,
                        ),
                        theme: const ExpandableThemeData(
                          headerAlignment: ExpandablePanelHeaderAlignment.center,
                        ),
                        collapsed: const Text(
                          "",
                          softWrap: true,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        expanded: Container(
                          width: width * 0.9,
                          padding: EdgeInsets.all(appDimen.sp10),
                          margin: EdgeInsets.all(appDimen.sp10),
                          decoration: BoxDecoration(
                            color: Color(appColors.white),
                            borderRadius: BorderRadius.all(Radius.circular(appDimen.sp5)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: const Offset(0.0, 2.0), //(x,y)
                                blurRadius: appDimen.sp5,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: CustomLabel(
                                  text: 'Add Image',
                                  size: appDimen.sp16,
                                  color: Color(appColors.grey7A7A7A),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _pickImage();
                                },
                                child: DottedBorder(
                                    dashPattern: const [4, 4],
                                    strokeWidth: 1,
                                    color: Color(appColors.greyA5A5A5),
                                    radius: Radius.circular(appDimen.sp5),
                                    child: _pickedImage == null
                                        ? layoutPlanImage.isNotEmpty
                                            ? SizedBox(
                                                height: height * 0.3,
                                                width: width * 0.86,
                                                child:
                                                ImageNetwork(
                                                  fitWeb: BoxFitWeb.fill,
                                                  image: layoutPlanImage,
                                                  height: height * 0.3,
                                                  width: width * 0.2,
                                                  imageCache: CachedNetworkImageProvider(layoutPlanImage),

                                                ),/*Image.network(
                                                  layoutPlanImage,
                                                  fit: BoxFit.fill,
                                                ),*/
                                              )
                                            : SizedBox(
                                                height: height * 0.3,
                                                width: width * 0.86,
                                                child: Icon(
                                                  Icons.camera_alt_outlined,
                                                  size: appDimen.sp40,
                                                  color: Color(
                                                    appColors.greyA5A5A5,
                                                  ),
                                                ),
                                              )
                                        : SizedBox(
                                            width: width * 0.86,
                                            height: height * 0.3,
                                            child: Image.memory(
                                              webImage ?? Uint8List(8),
                                              fit: BoxFit.fill,
                                            ))),
                              ),
                              SizedBox(
                                height: appDimen.sp15,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: CustomLabel(
                                  text: 'Description',
                                  size: appDimen.sp16,
                                  color: Color(appColors.grey7A7A7A),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.3,
                                child: CustomTextField(
                                  onTextChanged: descriptionController,
                                  borderRadius: appDimen.sp5,
                                  maxLines: null,
                                  maxLength: 100,
                                  inputType: TextInputType.multiline,
                                  expands: true,
                                  hintText: appString.descriptionHint,
                                  readonly: !editReport,
                                ),
                              ),
                              Visibility(
                                visible: editReport,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: appDimen.sp15,
                                    ),
                                    CustomRaisedButton(
                                      width: width * 0.9,
                                      text: 'Next',
                                      color: Colors.white,
                                      textColor: Color(appColors.brown840000),
                                      sideColor: Color(appColors.brown840000),
                                      onPressed: () {
                                        // checkLayoutPlan();
                                        uploadLayoutController.value = false;
                                        upload360Controller.value = true;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: appDimen.sp10,
                      ),
                      Divider(
                        thickness: appDimen.sp1,
                        height: appDimen.sp1,
                      ),
                      SizedBox(
                        height: appDimen.sp10,
                      ),
                      ExpandablePanel(
                        controller: upload360Controller,
                        header: CustomLabel(
                          text: 'Upload 360 degree Image / Video',
                          fontWeight: FontWeight.w600,
                          size: appDimen.sp15,
                        ),
                        theme: const ExpandableThemeData(
                          headerAlignment: ExpandablePanelHeaderAlignment.center,
                        ),
                        collapsed: const Text(
                          "",
                          softWrap: true,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        expanded: Container(
                          width: width * 0.9,
                          padding: EdgeInsets.all(appDimen.sp10),
                          margin: EdgeInsets.all(appDimen.sp10),
                          decoration: BoxDecoration(
                            color: Color(appColors.white),
                            borderRadius: BorderRadius.all(Radius.circular(appDimen.sp5)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: const Offset(0.0, 2.0), //(x,y)
                                blurRadius: appDimen.sp5,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: width * 0.9,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: CustomLabel(
                                        text: 'Add Image / Video',
                                        size: appDimen.sp13,
                                        color: Color(appColors.grey7A7A7A),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        pickerDialog();
                                      },
                                      child: DottedBorder(
                                        dashPattern: const [4, 4],
                                        strokeWidth: 1,
                                        color: Color(appColors.greyA5A5A5),
                                        radius: Radius.circular(appDimen.sp5),
                                        child: SizedBox(
                                          height: height * 0.3,
                                          width: width * 0.9,
                                          child: _video == null && videoPlayer == false
                                              ? _picked360Image == null
                                                  ? the360degreeImage.isNotEmpty
                                                      ? SizedBox(
                                                          width: width * 0.86,
                                                          height: height * 0.3,
                                                          child: ImageNetwork(
                                                            fitWeb: BoxFitWeb.fill,
                                                            image: the360degreeImage,
                                                            height: height * 0.3,
                                                            width: width * 0.2,
                                                            imageCache: CachedNetworkImageProvider(the360degreeImage),

                                                          ),
                                            /*Image.network(
                                                            the360degreeImage,
                                                            fit: BoxFit.fill,
                                                          ),*/
                                                        )
                                                      : SizedBox(
                                                          width: width * 0.86,
                                                          height: height * 0.3,
                                                          child: Icon(
                                                            Icons.camera_alt_outlined,
                                                            size: appDimen.sp40,
                                                            color: Color(
                                                              appColors.greyA5A5A5,
                                                            ),
                                                          ),
                                                        )
                                                  : SizedBox(
                                                      width: width * 0.86,
                                                      height: height * 0.3,
                                                      child: Image.memory(
                                                        web360Image!,
                                                        fit: BoxFit.fill,
                                                      ))
                                              : _videoPlayerController!.value.isInitialized
                                                  ? AspectRatio(
                                                      aspectRatio: _videoPlayerController!.value.aspectRatio,
                                                      child: Stack(
                                                        children: [
                                                          VideoPlayer(_videoPlayerController!),
                                                          GestureDetector(
                                                            onTap: () {
                                                              if (editReport) {
                                                                pickerDialog();
                                                              }
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : const CircularProgressIndicator(),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              // Visibility(
                              //   visible: editReport,
                              //   child: Column(
                              //     children: [
                              //       SizedBox(
                              //         height: appDimen.sp18,
                              //       ),
                              //       CustomRaisedButton(
                              //         width: width * 0.9,
                              //         text: 'Save',
                              //         color: Colors.white,
                              //         textColor: Color(appColors.brown840000),
                              //         sideColor: Color(appColors.brown840000),
                              //         onPressed: () {
                              //           check360ImageVideo();
                              //         },
                              //       ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: editReport,
                        child: Column(
                          children: [
                            SizedBox(
                              height: appDimen.sp10,
                            ),
                            CustomRaisedButton(
                              width: width * 0.8,
                              text: 'Generate Report',
                              color: Color(appColors.brown840000),
                              textColor: Color(appColors.white),
                              sideColor: Color(appColors.white),
                              onPressed: () {
                                navigate();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
          }
        });
      },
    );
  }

  validate() {
    String message = '';
    if (lengthController.text.isNotEmpty ||
        widthController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        offLoadingController.text.isNotEmpty ||
        onLoadingController.text.isNotEmpty ||
        descriptionController.text.isNotEmpty ||
        (webImage != null && webImage!.isNotEmpty) ||
        layoutPlanImage.isNotEmpty ||
        (webVideo != null && webVideo!.isNotEmpty) ||
        (web360Image != null && web360Image!.isNotEmpty) ||
        the360degreeImage.isNotEmpty ||
        the360degreeVideo.isNotEmpty) {
      if (lengthController.text.isNotEmpty && !CommonMethods.isNumericUsingRegularExpression(lengthController.text)) {
        message = "$message \u2022 Invalid Numeric Length.\n";
      }
      if (widthController.text.isNotEmpty && !CommonMethods.isNumericUsingRegularExpression(widthController.text)) {
        message = "$message \u2022 Invalid Numeric Width.\n";
      }
      if (areaController.text.isNotEmpty && !CommonMethods.isNumericUsingRegularExpression(areaController.text)) {
        message = "$message \u2022 Invalid Numeric Area.\n";
      }
      if (message.isNotEmpty) {
        showDialog(
          context: context,
          builder: (context) {
            return CustomDialog(
              text: 'Following field(s) are required: \n$message',
            );
          },
        );
        return false;
      } else {
        return true;
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return const CustomDialog(
            text: 'Form is Empty. Please enter the details.',
          );
        },
      );
      return false;
    }
  }

  navigate() {
    if (validate()) {
      String base64Image = webImage == null || (webImage != null && webImage!.isEmpty) && layoutPlanImage.isNotEmpty
          ? ''
          : webImage != null
              ? base64Encode(webImage!)
              : '';
      String base64Image360 = webVideo == null && web360Image == null && (the360degreeImage.isNotEmpty || the360degreeVideo.isNotEmpty)
          ? ''
          : _video != null
              ? webVideo != null
                  ? base64Encode(webVideo ?? Uint8List(8))
                  : ''
              : web360Image != null
                  ? base64Encode(web360Image ?? Uint8List(8))
                  : '';

      if (editReport) {
        triggerSiteSurveyEvent(
          EditReportEvent(
            context: context,
            reportId: widget.reportId,
            projectId: widget.projectId.toString(),
            length: lengthController.text,
            width: widthController.text,
            area: areaController.text,
            onLoadingLocation: onLoadingController.text,
            offLoadingLocation: offLoadingController.text,
            reportCategoryId: widget.reportCategoryId,
            description: descriptionController.text,
            layoutPlanImage: base64Image,
            image360Degree: base64Image360,
            videoType: webVideo != null,
          ),
        );
      }
    }
  }

  Future<bool> _clearPrevious() async {
    await _videoPlayerController?.pause();
    return true;
  }

  void _getValuesAndPlay(String videoPath) {
    newCurrentPosition = _videoPlayerController!.value.position;
    _startPlay(videoPath);
    print(newCurrentPosition.toString());
  }

  Future<void> _initializePlay(String videoPath) async {
    _videoPlayerController = VideoPlayerController.network(videoPath)
      ..initialize().then((value) {
        Future.delayed(Duration.zero, () {
          setState(() {
            _videoPlayerController!.play();
            _videoPlayerController!.setLooping(true);
            videoPlayer = true;
          });
        });
      });
    _initializeVideoPlayerFuture = _videoPlayerController!.initialize().then((_) {
      _videoPlayerController?.seekTo(newCurrentPosition);
      _videoPlayerController?.play();
    });
  }

  Future<void> _startPlay(String videoPath) async {
    setState(() {
      _initializeVideoPlayerFuture = null;
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      _clearPrevious().then((_) {
        _initializePlay(videoPath);
      });
    });
  }

  final ImagePicker _picker = ImagePicker();
  final ImagePicker _videoPicker = ImagePicker();

  Future<void> _pickImage() async {
    if (!kIsWeb) {
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        if (CommonMethods.isImagePngJpeg(image.path)) {
          setState(() {
            _pickedImage = selected;
            debugPrint("THe picked images if ${_pickedImage?.path}");
          });
        } else {
          showErrorSnackBar(context, "Image Type is not supported. Supported Types are jpg,jpeg and png)");
        }
      } else {
        debugPrint('No image has been picked');
      }
    } else if (kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        debugPrint(image.mimeType);
        print("fileExtension");
        print(image.path);
        if (CommonMethods.isImagePngJpeg(image.mimeType.toString())) {
          setState(() {
            webImage = f;
            _pickedImage = File(image.path);
            _loadImage(image.path);
          });
        } else {
          showErrorSnackBar(context, "Image Type is not supported. Supported Types are jpg,jpeg and png).");
        }
      } else {
        debugPrint('No image has been picked');
      }
    } else {
      debugPrint('Something went wrong');
    }
  }

  Future<void> _pick360Image() async {
    if (!kIsWeb) {
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        if (CommonMethods.isImagePngJpeg(image.mimeType.toString())) {
          setState(() {
            _pickedImage = selected;
            debugPrint("THe picked images if ${_pickedImage?.path}");
          });
        } else {
          showErrorSnackBar(context, "Image Type is not supported. Supported Types are jpg,jpeg and png).");
        }
      } else {
        debugPrint('No image has been picked');
      }
    } else if (kIsWeb) {
      final ImagePicker picker = ImagePicker();
      XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        if (CommonMethods.isImagePngJpeg(image.mimeType.toString())) {
          setState(() {
            web360Image = f;
            _picked360Image = File(image.path);
            _loadImage(image.path);
            videoPlayer = false;
            _video = null;
            the360degreeVideo = '';
            _videoPlayerController == null;
            webVideo = null;
            setState(() {});
          });
        } else {
          showErrorSnackBar(context, "Image Type is not supported. Supported Types are jpg,jpeg and png.");
        }
      } else {
        debugPrint('No image has been picked');
      }
    } else {
      debugPrint('Something went wrong');
    }
  }

  Future<void> _pickVideo() async {
    if (!kIsWeb) {
      XFile? video = await _videoPicker.pickVideo(source: ImageSource.gallery);

      if (video != null) {
        _video = File(video.path);
        _videoPlayerController = VideoPlayerController.file(_video!)
          ..initialize().then((_) {
            setState(() {});
            _videoPlayerController?.play();
          });
      } else {
        debugPrint('No image has been picked');
      }
    } else if (kIsWeb) {
      final ImagePicker videoPicker = ImagePicker();
      XFile? video = await videoPicker.pickVideo(source: ImageSource.gallery);
      if (video != null) {
        var f = await video.readAsBytes();
        if (video.mimeType.toString() == "video/mp4") {
          setState(() {
            webVideo = f;
            _video = File(video.path);
            _getValuesAndPlay(_video!.path);
            videoPlayer = true;
            web360Image = null;
          });
        } else {
          showErrorSnackBar(context, "Video Type is not supported. Supported Type is mp4.");
        }
      } else {
        debugPrint('No image has been picked');
      }
    } else {
      debugPrint('Something went wrong');
    }
  }

  pickerDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const CustomLabel(
            text: "Choose Option :",
          ),
          contentPadding: EdgeInsets.all(appDimen.sp10),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  _pick360Image();
                },
                child: Padding(
                  padding: EdgeInsets.all(appDimen.sp10),
                  child: const Center(child: CustomLabel(text: "Image")),
                ),
              ),
              Divider(
                thickness: appDimen.sp1,
                height: appDimen.sp2,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  _pickVideo();
                },
                child: Padding(
                  padding: EdgeInsets.all(appDimen.sp10),
                  child: const Center(child: CustomLabel(text: "Video")),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<ui.Image> _loadImage(String imageAssetPath) async {
    final ByteData data = await rootBundle.load(imageAssetPath);
    final codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetHeight: 300,
      targetWidth: 300,
    );
    var frame = await codec.getNextFrame();
    return frame.image;
  }

  bool checkMeasurements() {
    String message = '';
    if (lengthController.text.isEmpty) {
      message = '$message \u2022 Length.\n';
    }
    if (lengthController.text.isNotEmpty && !CommonMethods.isNumericUsingRegularExpression(lengthController.text)) {
      message = "$message \u2022 Invalid Numeric Length.\n";
    }
    if (widthController.text.isEmpty) {
      message = '$message \u2022 Width.\n';
    }
    if (widthController.text.isNotEmpty && !CommonMethods.isNumericUsingRegularExpression(widthController.text)) {
      message = "$message \u2022 Invalid Numeric Width.\n";
    }
    if (areaController.text.isEmpty) {
      message = '$message \u2022 Area.\n';
    }
    if (areaController.text.isNotEmpty && !CommonMethods.isNumericUsingRegularExpression(areaController.text)) {
      message = "$message \u2022 Invalid Numeric Area.\n";
    }
    if (onLoadingController.text.isEmpty) {
      message = '$message \u2022 Onloading Location.\n';
    }
    if (offLoadingController.text.isEmpty) {
      message = '$message \u2022 Offloading Location.\n';
    }
    if (message.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            text: 'Following field(s) are required: \n$message',
          );
        },
      );
      return false;
    } else {
      siteMeasurementController.value = false;
      uploadLayoutController.value = true;
      return true;
    }
  }

  bool checkLayoutPlan() {
    bool measures = checkMeasurements();
    String validate = '';
    if (measures) {
      if (_pickedImage == null && layoutPlanImage.isEmpty) {
        validate = '$validate \u2022 Layout Plan Image.\n';
      }
      if (descriptionController.text.isEmpty) {
        validate = '$validate \u2022 Description.\n';
      }
      if (validate.isNotEmpty) {
        showDialog(
          context: context,
          builder: (context) {
            return CustomDialog(
              text: 'Following field(s) are required: \n$validate',
            );
          },
        );
        return false;
      } else {
        uploadLayoutController.value = false;
        upload360Controller.value = true;
        return true;
      }
    } else {
      return false;
    }
  }

  bool check360ImageVideo() {
    bool measures = checkLayoutPlan();
    String validate = '';
    if (measures) {
      if (_video == null && _picked360Image == null && the360degreeImage.isEmpty && the360degreeVideo.isEmpty) {
        validate = '$validate \u2022 360 degree Image/Video.\n';
      }
      if (validate.isNotEmpty) {
        showDialog(
          context: context,
          builder: (context) {
            return CustomDialog(
              text: 'Following field(s) are required: \n$validate',
            );
          },
        );
        return false;
      } else {
        // uploadLayoutController.value = false;
        // upload360Controller.value = true;
        return true;
      }
    } else {
      return false;
    }
  }
}
