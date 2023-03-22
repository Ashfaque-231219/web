import 'dart:convert';
import 'dart:io';
import 'package:image_network/image_network.dart';
import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import 'package:web/view-model/maintenanceBloc/maintenance_bloc.dart';
import 'package:web/view/shared_widget/custom_dialog.dart';
import 'package:web/view/shared_widget/custom_label.dart';
import 'package:web/view/shared_widget/custom_raised_button.dart';
import 'package:web/view/shared_widget/custom_text_field.dart';
import 'package:web/view/shared_widget/loading_widget.dart';

class MaintenanceReportFormPage extends StatefulWidget {
  final int projectId;

  const MaintenanceReportFormPage({
    Key? key,
    @PathParam("id") required this.projectId,
  }) : super(key: key);

  @override
  State<MaintenanceReportFormPage> createState() => _MaintenanceReportFormPageState();
}

class _MaintenanceReportFormPageState extends State<MaintenanceReportFormPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String date = '';
  Uint8List? webImage;
  Uint8List? webVideo;
  VideoPlayerController? _videoPlayerController;
  bool videoPlayer = false;

  triggerMaintenanceEvent(MaintenanceEvent event) {
    context.read<MaintenanceBloc>().add(event);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<MaintenanceBloc, MaintenanceState>(
      builder: (context, state) {
        return LoadingWidget(
          status: state.stateStatus,
          child: LayoutBuilder(builder: (BuildContext ctx, BoxConstraints constraints) {
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
                                  text: 'Maintenance List',
                                  size: appDimen.sp16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
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
                                    maxLength: 10,
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
                                            onTap: () async {
                                              pickerDialog();
                                            },
                                            child: DottedBorder(
                                                dashPattern: const [4, 4],
                                                strokeWidth: 1,
                                                color: Color(appColors.greyA5A5A5),
                                                radius: Radius.circular(appDimen.sp5),
                                                child: webVideo != null
                                                    ? SizedBox(
                                                        width: width * 0.2,
                                                        height: height * 0.25,
                                                        child: _videoPlayerController!.value.isInitialized
                                                            ? AspectRatio(
                                                                aspectRatio: _videoPlayerController!.value.aspectRatio,
                                                                child: Stack(
                                                                  children: [
                                                                    VideoPlayer(_videoPlayerController!),
                                                                    GestureDetector(
                                                                      onTap: () {
                                                                        pickerDialog();
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            : const CircularProgressIndicator(),
                                                      )
                                                    : webImage == null
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
                                                            ))),
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
                                text: "Raise Issue",
                                color: ColorConstants.darkBrown,
                                onPressed: () {
                                  if (checkUploads() && widget.projectId != null && (webImage != null || webVideo != null)) {
                                    String base64Image = webVideo != null ? base64Encode(webVideo!) : base64Encode(webImage!);
                                    print("The project id is =========================......${widget.projectId}");
                                    triggerMaintenanceEvent(AddMaintenanceEvent(
                                      context: context,
                                      maintenanceId: idController.text,
                                      beforeDescription: descriptionController.text,
                                      beforeImage: base64Image,
                                      projectId: widget.projectId.toString(),
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
                                  text: 'Maintenance List',
                                  size: appDimen.sp16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
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
                                    maxLength: 10,
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
                                  onTap: () async {
                                    webImage = await CommonMethods().pickImage(context);
                                    setState(() {});
                                  },
                                  child: DottedBorder(
                                    dashPattern: const [4, 4],
                                    strokeWidth: 1,
                                    color: Color(appColors.greyA5A5A5),
                                    radius: Radius.circular(appDimen.sp5),
                                    child: webVideo != null
                                        ? SizedBox(
                                            height: height * 0.25,
                                            width: width * 0.86,
                                            child: _videoPlayerController!.value.isInitialized
                                                ? AspectRatio(
                                                    aspectRatio: _videoPlayerController!.value.aspectRatio,
                                                    child: Stack(
                                                      children: [
                                                        VideoPlayer(_videoPlayerController!),
                                                        GestureDetector(
                                                          onTap: () {
                                                            pickerDialog();
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : const CircularProgressIndicator(),
                                          )
                                        : webImage == null
                                            ? SizedBox(
                                                height: height * 0.25,
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
                                                height: height * 0.25,
                                                child: Image.memory(
                                                  webImage!,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                  ),
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
                                    hintText: appString.descriptionHint,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: appDimen.sp60),
                              child: CustomRaisedButton(
                                text: "Raise Issue",
                                color: ColorConstants.darkBrown,
                                onPressed: () {
                                  print(widget.projectId != null);
                                  if (checkUploads() && widget.projectId != null && (webImage != null || webVideo != null)) {
                                    String base64Image = webVideo != null ? base64Encode(webVideo!) : base64Encode(webImage!);
                                    triggerMaintenanceEvent(AddMaintenanceEvent(
                                      context: context,
                                      maintenanceId: idController.text,
                                      beforeDescription: descriptionController.text,
                                      beforeImage: base64Image,
                                      projectId: widget.projectId.toString(),
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
                  ),
                ),
              );
            }
          }),
        );
      },
    );
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
                  if (webImage != null) {
                    videoPlayer = false;
                    webVideo = null;
                  }
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
          _videoPlayerController = VideoPlayerController.network(videoFile.path)
            ..initialize().then((_) {
              setState(() {
                _videoPlayerController?.play();
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
    if (idController.text.isEmpty) {
      validate = '$validate \u2022  Maintenance ID is required.\n';
    }
    if (webImage == null && webVideo == null) {
      validate = '$validate \u2022 Image/Video.\n';
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
      return true;
    }
  }
}
