import 'package:flutter/material.dart';
import 'package:web/view/shared_widget/screen.dart';

class Loader {
  /* ----> Start Loader ----> */
  //! Full Screen Loader
  static fullScreenLoader(
    BuildContext context, {
    required bool? loading,
    Color backgroundColor = Colors.white,
    required Widget loaderImage,
  }) {
    return loading == true
        ? Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                width: Screen.width(context),
                height: Screen.height(context),
                color: backgroundColor,
              ),
              Center(child: loaderImage)
            ],
          )
        : Container();
  }

  //! Activity Laoder
  static Widget loading(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.transparent,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
      ),
    );
  }

/* End Loader class */

}
