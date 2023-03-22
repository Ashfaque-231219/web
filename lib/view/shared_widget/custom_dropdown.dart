import 'package:flutter/material.dart';
import 'package:web/helper/constants/colors.dart';
import 'package:web/helper/constants/dimen.dart';
import 'package:web/view/shared_widget/custom_label.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({
    required this.items,
    required this.id,
    Key? key,
  }) : super(key: key);

  final List<dynamic>? items;
  final Function id;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      hint: const Text("Report Type"),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 10,right: 10),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(appColors.greyA5A5A5),
          ),
          borderRadius: BorderRadius.circular(appDimen.sp5),
        ),
      ),
      icon: const Icon(
        Icons.keyboard_arrow_down_outlined,
      ),
      items: widget.items?.map((val) {
        return DropdownMenuItem(
            value: val,
            child: CustomLabel(
              text: val.name.toString(),
            ));
      }).toList(),
      onChanged: (value) {
        widget.id(value);
      },
    );
  }
}
