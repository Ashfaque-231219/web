/* ************************************************************************
* Directory Name: common                                                  *
* File Name: loading.dart                                                 *
* Created At: Saturday, 19th March 2022 8:40:19 pm                        *
* Created By: singsys (Harshit Kishor)                                    *
************************************************************************ */

import 'package:flutter/material.dart';
import 'package:web/view-model/event_status.dart';
import 'package:web/view/shared_widget/loader.dart';



class LoadingWidget extends StatefulWidget {
  final bool backgroundTransparent;
  final StateStatus status;
  final Widget child;
  const LoadingWidget({
    Key? key,
    this.backgroundTransparent = true,
    required this.status,
    required this.child,
  }) : super(key: key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  Stream<bool> checkStream() async* {
    StateStatus state = widget.status;
    if (state is StateLoading) {
      yield (true);
    } else {
      yield false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: checkStream(),
        initialData: false,
        builder: (context, snapshot) {
          return Stack(
            children: <Widget>[
              widget.child,
              Loader.fullScreenLoader(
                context,
                loading: snapshot.data,
                backgroundColor: widget.backgroundTransparent
                    ? Colors.black54
                    : Colors.white,
                loaderImage: Loader.loading(context),
              )
            ],
          );
        });
  }
}
