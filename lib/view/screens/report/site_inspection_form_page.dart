import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/helper/constants/images.dart';
import 'package:web/helper/constants/size_constants.dart';
import 'package:web/models/response/project_details_modal.dart';
import 'package:web/view-model/projectDetailBloc/project_detail_bloc.dart';
import 'package:web/view/screens/project_details/site_inspection_list.dart';
import 'package:web/view/shared_widget/custom_label.dart';

class SiteInspectionFormPage extends StatefulWidget {
  final int projectId;

  const SiteInspectionFormPage({
    Key? key,
    @PathParam("id") required this.projectId,
  }) : super(key: key);

  @override
  State<SiteInspectionFormPage> createState() => _SiteInspectionFormPageState();
}

class _SiteInspectionFormPageState extends State<SiteInspectionFormPage> {
  List<ScheduleList?>? scheduleList;
  List<TaskList?>? taskList;

  @override
  void initState() {
    super.initState();

    triggerGetListEvent(GetProjectDetailsEvent(context: context, projectId: widget.projectId.toString()));
  }

  triggerGetListEvent(ProjectDetailEvent event) {
    context.read<ProjectDetailBloc>().add(event);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocBuilder<ProjectDetailBloc, ProjectDetailState>(
      builder: (context, state) {
        if (state is GetProjectDetailsState) {
          if (state.projectDetails!.data!.scheduleList != null) {
            scheduleList = state.projectDetails!.data!.scheduleList!;
            print("schedule list List =========>>>>>>>> $scheduleList");
          }
          if (state.projectDetails!.data!.taskList != null) {
            taskList = state.projectDetails!.data!.taskList!;
            print("task list List =========>>>>>>>> $taskList");
          }
        }
        return Scaffold(
          body: Center(
            child: Container(
              width: width > SizeConstants.tabWidth ? width * 0.7 : width,
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
                          text: 'Site Installation Progress Report',
                          size: appDimen.sp16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SiteInspectionList(
                      projectId: widget.projectId.toString(),
                      createPage: true,
                      scheduleList: scheduleList,
                      taskList: taskList,
                      refresh: refresh,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  refresh(){
    triggerGetListEvent(GetProjectDetailsEvent(context: context, projectId: widget.projectId.toString()));
  }
}
