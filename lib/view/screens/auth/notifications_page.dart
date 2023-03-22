import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web/helper/constants/colors.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/helper/constants/images.dart';
import 'package:web/helper/utils/common_methods.dart';
import 'package:web/models/notification/notification_model.dart';
import 'package:web/view-model/notificationBloc/notification_bloc.dart';
import 'package:web/view/shared_widget/custom_label.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  NotificationModel? notification;

  triggerNotificationEvent(NotificationEvent event) {
    context.read<NotificationBloc>().add(event);
  }

  @override
  void initState() {
    triggerNotificationEvent(ViewNotificationsEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        if (state is ViewNotificationListState) {
          notification = state.notification;
        }

        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Container(
              width: width * 0.7,
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
                          text: 'Notifications',
                          size: appDimen.sp16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: appDimen.sp20,
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: notification?.data?.notification?.length ?? 0,
                      itemBuilder: (context, int index) {
                        return notification != null &&
                                notification!.data != null &&
                                notification!.data!.notification != null &&
                                notification!.data!.notification![index] != null &&
                                notification!.data!.notification![index]!.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomLabel(
                                    text: CommonMethods.dateWithDay(notification!.data!.notification![index]![0]?.createdAt ?? ''),
                                    color: Color(appColors.brown840000),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  for (var data in notification!.data!.notification![index]!)
                                    Container(
                                      margin: EdgeInsets.symmetric(vertical: appDimen.sp10),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: width * 0.05,
                                            height: width * 0.05,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(width * 0.025),
                                              color: Color(appColors.whiteF6F6F6),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(width * 0.01),
                                              child: Icon(Icons.calendar_today_outlined, color: Color(appColors.grey676767), size: width * 0.03),
                                            ),
                                          ),
                                          SizedBox(
                                            width: appDimen.sp10,
                                          ),
                                          Expanded(
                                            child: CustomLabel(
                                              text: data?.body ?? '',
                                              size: appDimen.sp13,
                                              maxLines: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              )
                            : Container();
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: appDimen.sp20),
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(appColors.greyE8E8E8),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
