import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:web/helper/constants/color_constants.dart';
import 'package:web/helper/constants/colors.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/helper/constants/images.dart';
import 'package:web/helper/constants/size_constants.dart';
import 'package:web/helper/constants/string.dart';
import 'package:web/helper/utils/common_methods.dart';
import 'package:web/helper/utils/utils.dart';
import 'package:web/view-model/event_status.dart';
import 'package:web/view-model/maintenanceBloc/maintenance_bloc.dart';
import 'package:web/view/shared_widget/custom_dialog.dart';
import 'package:web/view/shared_widget/custom_label.dart';
import 'package:web/view/shared_widget/custom_raised_button.dart';
import 'package:web/view/shared_widget/custom_text_field.dart';

class ViewMaintenanceFormPage extends StatefulWidget {
  final int maintenanceId;

  const ViewMaintenanceFormPage({
    Key? key,
    @PathParam("id") required this.maintenanceId,
  }) : super(key: key);

  @override
  State<ViewMaintenanceFormPage> createState() => _ViewMaintenanceFormPageState();
}

class _ViewMaintenanceFormPageState extends State<ViewMaintenanceFormPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController afterDescriptionController = TextEditingController();
  String referenceId = '';
  String beforeImage = '';
  String beforeVideo = '';
  Uint8List? webImage;
  Uint8List? webVideo;
  VideoPlayerController? _videoPlayerController;
  VideoPlayerController? _videoPlayerController2;
  bool videoPlayer = false;
  int i = 1;
  Future<void>? _initializeVideoPlayerFuture;

  Duration newCurrentPosition = Duration.zero;

  triggerMaintenanceEvent(MaintenanceEvent event) {
    context.read<MaintenanceBloc>().add(event);
  }

  @override
  void initState() {
    triggerMaintenanceEvent(ViewMaintenanceEvent(maintenanceId: widget.maintenanceId.toString(), context: context));
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
    _videoPlayerController2!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<MaintenanceBloc, MaintenanceState>(
      builder: (context, state) {
        if (state.stateStatus is StateLoaded) {
          print(state.maintenanceModel?.data);
          if (state.maintenanceModel != null && state.maintenanceModel?.data != null) {
            if (state.maintenanceModel!.data!.beforeImage != null &&
                state.maintenanceModel!.data!.beforeImage!.contains('mp4')) {
              beforeVideo = state.maintenanceModel!.data!.beforeImage ?? '';
              if (beforeVideo.isNotEmpty) {
                if (i == 1) {
                  Future.delayed(Duration.zero, () {
                    _getValuesAndPlay(beforeVideo);
                    print(_videoPlayerController);
                    setState(() {
                      i++;
                    });
                    if (_videoPlayerController!.value.isInitialized) {
                      _videoPlayerController!.play();
                      _videoPlayerController!.setLooping(true);
                    }
                    // videoPlayer = true;
                  });
                }
              }
            } else {
              // videoPlayer = false;
              beforeImage = state.maintenanceModel?.data?.beforeImage ?? '';
            }
            idController.text = state.maintenanceModel?.data?.maintenanceListId.toString() ?? '';
            descriptionController.text = state.maintenanceModel?.data?.beforeDescription ?? '';
            referenceId = state.maintenanceModel?.data?.referenceId ?? "";
          }
        }
        return LayoutBuilder(builder: (BuildContext ctx, BoxConstraints constraints) {
          if (width > SizeConstants.tabWidth) {
            return Scaffold(
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
                                text: referenceId,
                                size: appDimen.sp16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
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
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: appDimen.sp10,
                              ),
                              Padding(
                                padding: EdgeInsets.all(appDimen.sp10),
                                child: CustomLabel(
                                  text: "Before",
                                  size: appDimen.sp15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: appDimen.sp10,
                              ),
                            ],
                          ),
                        ),
                        Container(
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
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: CustomLabel(
                                  text: 'Maintenance ID',
                                  size: appDimen.sp13,
                                  color: Color(appColors.grey7A7A7A),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.2,
                                child: CustomTextField(
                                  onTextChanged: idController,
                                  borderRadius: appDimen.sp5,
                                  hintText: appString.idHint,
                                  readonly: true,
                                ),
                              ),
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
                                            text: 'Add Image/Video',
                                            size: appDimen.sp13,
                                            color: Color(appColors.grey7A7A7A),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: DottedBorder(
                                              dashPattern: const [
                                                4,
                                                4
                                              ],
                                              strokeWidth: 1,
                                              color: Color(appColors.greyA5A5A5),
                                              radius: Radius.circular(appDimen.sp5),
                                              child: beforeVideo.isEmpty
                                                  ? /*webImage == null
                                                      ?*/
                                                  beforeImage.isNotEmpty
                                                      ? SizedBox(
                                                          width: width * 0.2,
                                                          height: height * 0.25,
                                                          child: ImageNetwork(
                                                            image: beforeImage,
                                                            height: height * 0.25,
                                                            width: width * 0.2,
                                                            imageCache: CachedNetworkImageProvider(beforeImage),
                                                          ),
                                                        )
                                                      : SizedBox(
                                                          height: height * 0.25,
                                                          width: width * 0.2,
                                                          child: Icon(
                                                            Icons.camera_alt_outlined,
                                                            size: appDimen.sp40,
                                                            color: Color(
                                                              appColors.greyA5A5A5,
                                                            ),
                                                          ),
                                                        )
                                                  // : SizedBox(
                                                  //     width: width * 0.2,
                                                  //     height: height * 0.25,
                                                  //     child: Image.memory(
                                                  //       webImage!,
                                                  //       fit: BoxFit.fill,
                                                  //     ))
                                                  : _videoPlayerController != null &&
                                                          _videoPlayerController!.value.isInitialized
                                                      ? SizedBox(
                                                          width: width * 0.2,
                                                          height: height * 0.25,
                                                          // aspectRatio: _videoPlayerController!.value.aspectRatio,
                                                          child: Stack(
                                                            children: [
                                                              VideoPlayer(_videoPlayerController!),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  // pickerDialog();
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : const CircularProgressIndicator()),
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
                                            height: height * 0.25,
                                            child: CustomTextField(
                                              onTextChanged: descriptionController,
                                              borderRadius: appDimen.sp5,
                                              maxLines: null,
                                              maxLength: 100,
                                              inputType: TextInputType.multiline,
                                              expands: true,
                                              readonly: true,
                                              hintText: appString.descriptionHint,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width * 0.9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: appDimen.sp30,
                              ),
                              Padding(
                                padding: EdgeInsets.all(appDimen.sp10),
                                child: CustomLabel(
                                  text: "After",
                                  size: appDimen.sp15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
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
                                                  text: 'Add Image/Video',
                                                  size: appDimen.sp13,
                                                  color: Color(appColors.grey7A7A7A),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  // webImage = await CommonMethods().pickImage(context);
                                                  // setState(() {});
                                                  pickerDialog();
                                                },
                                                child: DottedBorder(
                                                    dashPattern: const [4, 4],
                                                    strokeWidth: 1,
                                                    color: Color(appColors.greyA5A5A5),
                                                    radius: Radius.circular(appDimen.sp5),
                                                    child: webVideo == null && videoPlayer == false
                                                        ? webImage == null
                                                            ? SizedBox(
                                                                height: height * 0.25,
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
                                                                height: height * 0.25,
                                                                child: Image.memory(
                                                                  webImage!,
                                                                  fit: BoxFit.fill,
                                                                ))
                                                        : _videoPlayerController2 != null &&
                                                                _videoPlayerController2!.value.isInitialized
                                                            ? SizedBox(
                                                                width: width * 0.2,
                                                                height: height * 0.25,
                                                                // aspectRatio: _videoPlayerController!.value.aspectRatio,
                                                                child: Stack(
                                                                  children: [
                                                                    VideoPlayer(_videoPlayerController2!),
                                                                    GestureDetector(
                                                                      onTap: () {
                                                                        pickerDialog();
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            : const CircularProgressIndicator()),
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
                                                  height: height * 0.25,
                                                  child: CustomTextField(
                                                    onTextChanged: afterDescriptionController,
                                                    borderRadius: appDimen.sp5,
                                                    maxLines: null,
                                                    maxLength: 100,
                                                    inputType: TextInputType.multiline,
                                                    expands: true,
                                                    hintText: appString.descriptionHint,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: appDimen.sp60),
                                  child: CustomRaisedButton(
                                    text: "Generate Report",
                                    color: ColorConstants.darkBrown,
                                    onPressed: () {
                                      if (checkUploads() && (webImage != null || webVideo != null)) {
                                        String base64Image =
                                            webVideo != null ? base64Encode(webVideo!) : base64Encode(webImage!);
                                        triggerMaintenanceEvent(ResolveMaintenanceEvent(
                                          context: context,
                                          maintenanceId: widget.maintenanceId.toString(),
                                          afterImage: base64Image,
                                          afterDescription: afterDescriptionController.text,
                                          videoType: webVideo != null,
                                        ));
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              body: SingleChildScrollView(
                child: Center(
                  child: Container(
                    width: width * 0.9,
                    // height: height,
                    margin: EdgeInsets.all(appDimen.sp20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                context.router.navigateBack();
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
                                text: referenceId,
                                size: appDimen.sp16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
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
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: appDimen.sp10,
                              ),
                              Padding(
                                padding: EdgeInsets.all(appDimen.sp10),
                                child: CustomLabel(
                                  text: "Before",
                                  size: appDimen.sp15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: appDimen.sp10,
                              ),
                            ],
                          ),
                        ),
                        Container(
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
                                  text: 'Maintenance ID',
                                  size: appDimen.sp13,
                                  color: Color(appColors.grey7A7A7A),
                                ),
                              ),
                              SizedBox(
                                width: width * 0.86,
                                child: CustomTextField(
                                  onTextChanged: idController,
                                  borderRadius: appDimen.sp5,
                                  hintText: appString.idHint,
                                  readonly: true,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: CustomLabel(
                                  text: 'Add Image/Video',
                                  size: appDimen.sp16,
                                  color: Color(appColors.grey7A7A7A),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  // if (!widget.resolve) {
                                  //   _pickImage();
                                  // }
                                },
                                child: DottedBorder(
                                    dashPattern: const [4, 4],
                                    strokeWidth: 1,
                                    color: Color(appColors.greyA5A5A5),
                                    radius: Radius.circular(appDimen.sp5),
                                    child: beforeVideo.isEmpty && videoPlayer == false
                                        ? /*webImage == null
                                            ?*/
                                        beforeImage.isNotEmpty
                                            ? SizedBox(
                                                width: width * 0.86,
                                                height: height * 0.3,
                                                child: ImageNetwork(
                                                    image: beforeImage,
                                                    height: height * 0.25,
                                                    width: width * 0.2,
                                                    imageCache: CachedNetworkImageProvider(beforeImage)))
                                            /*Image.network(
                                                      beforeImage,
                                                      fit: BoxFit.fill,
                                                    ),*/

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
                                        // : SizedBox(
                                        //     width: width * 0.86,
                                        //     height: height * 0.3,
                                        //     child: Image.memory(
                                        //       webImage!,
                                        //       fit: BoxFit.fill,
                                        //     ))
                                        : _videoPlayerController != null && _videoPlayerController!.value.isInitialized
                                            ? SizedBox(
                                                width: width * 0.86,
                                                height: height * 0.3,
                                                // aspectRatio: _videoPlayerController!.value.aspectRatio,
                                                child: Stack(
                                                  children: [
                                                    VideoPlayer(_videoPlayerController!),
                                                    GestureDetector(
                                                      onTap: () {
                                                        // pickerDialog();
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : const CircularProgressIndicator()),
                              ),
                              SizedBox(
                                height: appDimen.sp10,
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
                                  readonly: true,
                                  hintText: appString.descriptionHint,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: width * 0.9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: appDimen.sp30,
                              ),
                              Padding(
                                padding: EdgeInsets.all(appDimen.sp10),
                                child: CustomLabel(
                                  text: "After",
                                  size: appDimen.sp15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
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
                                          text: 'Add Image/Video',
                                          size: appDimen.sp16,
                                          color: Color(appColors.grey7A7A7A),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          // webImage = await CommonMethods().pickImage(context);
                                          // setState(() {});
                                          pickerDialog();
                                        },
                                        child: DottedBorder(
                                            dashPattern: const [4, 4],
                                            strokeWidth: 1,
                                            color: Color(appColors.greyA5A5A5),
                                            radius: Radius.circular(appDimen.sp5),
                                            child: webVideo == null && videoPlayer == false
                                                ? webImage == null
                                                    ? SizedBox(
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
                                                          webImage!,
                                                          fit: BoxFit.fill,
                                                        ))
                                                : _videoPlayerController2 != null &&
                                                        _videoPlayerController2!.value.isInitialized
                                                    ? SizedBox(
                                                        width: width * 0.86,
                                                        height: height * 0.3,
                                                        // aspectRatio: _videoPlayerController!.value.aspectRatio,
                                                        child: Stack(
                                                          children: [
                                                            VideoPlayer(_videoPlayerController2!),
                                                            GestureDetector(
                                                              onTap: () {
                                                                pickerDialog();
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : const CircularProgressIndicator()),
                                      ),
                                      SizedBox(
                                        height: appDimen.sp10,
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
                                          onTextChanged: afterDescriptionController,
                                          borderRadius: appDimen.sp5,
                                          maxLines: null,
                                          maxLength: 100,
                                          inputType: TextInputType.multiline,
                                          expands: true,
                                          hintText: appString.descriptionHint,
                                        ),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: appDimen.sp15,
                              ),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: appDimen.sp60),
                                  child: CustomRaisedButton(
                                    text: "Generate Report",
                                    color: ColorConstants.darkBrown,
                                    onPressed: () {
                                      if (checkUploads() && (webImage != null || webVideo != null)) {
                                        String base64Image =
                                            webVideo != null ? base64Encode(webVideo!) : base64Encode(webImage!);
                                        triggerMaintenanceEvent(ResolveMaintenanceEvent(
                                          context: context,
                                          maintenanceId: widget.maintenanceId.toString(),
                                          afterImage: base64Image,
                                          afterDescription: afterDescriptionController.text,
                                          videoType: webVideo != null,
                                        ));
                                      }
                                    },
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
              ),
            );
          }
        });
      },
    );
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
            // videoPlayer = true;
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
                onTap: () async {
                  Navigator.pop(context);
                  webImage = await CommonMethods().pickImage(context);
                  webVideo = null;
                  videoPlayer = false;
                  setState(() {});
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
                onTap: () async {
                  pickVideo();
                  Navigator.pop(context);
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

  pickVideo() async {
    final ImagePicker videoPicker = ImagePicker();
    XFile? video = await videoPicker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      var f = await video.readAsBytes();
      if (video.mimeType.toString() == "video/mp4") {
        setState(() {
          webVideo = f;
          File videoFile = File(video.path);
          _videoPlayerController2 = VideoPlayerController.network(videoFile.path)
            ..initialize().then((_) {
              setState(() {
                _videoPlayerController2?.play();
              });
            });
          videoPlayer = true;
          webImage = null;
        });
      } else {
        showErrorSnackBar(context, "Video Type is not supported. Supported Type is mp4).");
      }
    } else {
      debugPrint('No image has been picked');
    }
  }

  bool checkUploads() {
    String validate = '';
    if (webImage == null && webVideo == null) {
      validate = '$validate \u2022 Image/Video.\n';
    }
    if (afterDescriptionController.text.isEmpty) {
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
      return true;
    }
  }
}
