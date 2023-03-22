import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/helper/constants/images.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({this.filter = false, this.hint = '', required this.controller, required this.onChanged,Key? key}) : super(key: key);

  final bool filter;
  final String hint;
  final TextEditingController controller;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              contentPadding: EdgeInsets.all(appDimen.sp10),
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(appDimen.sp5),
              ),
            ),
            controller: controller,
            onChanged: onChanged,
          ),
        ),
        Visibility(
          visible: filter,
          child: SizedBox(
            width: appDimen.sp10,
          ),
        ),
        Visibility(
          visible: filter,
          child: SvgPicture.asset(
            appImages.filter,
            width: appDimen.sp25,
            height: appDimen.sp23,
          ),
        )
      ],
    );
  }
}
