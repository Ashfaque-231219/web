import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web/helper/constants/colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    required this.onTextChanged,
    this.onChanged,
    this.readonly = false,
    this.hintText = "",
    this.labelText = "",
    this.maxLength,
    this.maxLines = 1,
    this.expands = false,
    this.inputType = TextInputType.text,
    this.focus,
    this.validator,
    this.contentPadding = 17,
    this.borderRadius = 0,
    this.fontWeight = FontWeight.w400,
    this.suffixIcon,
    this.size = 14.0,
    Key? key,
  }) : super(key: key);

  final TextEditingController onTextChanged;
  final void Function(String)? onChanged;
  final bool readonly;
  final TextInputType inputType;
  final String hintText;
  final String labelText;
  final int? maxLength;
  final int? maxLines;
  final bool expands;
  final FocusNode? focus;
  final FormFieldValidator<String>? validator;
  final double contentPadding;
  final double borderRadius;
  final FontWeight fontWeight;
  final Widget? suffixIcon;
  final double size;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  get onTextChanged => widget.onTextChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        style: TextStyle(fontWeight: widget.fontWeight),
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,
        keyboardType: widget.inputType,
        textAlignVertical: TextAlignVertical.top,
        focusNode: widget.focus,
        readOnly: widget.readonly,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: GoogleFonts.montserrat(
            fontSize: widget.size,
            color: Color(appColors.greyA5A5A5),
            fontWeight: widget.fontWeight,
          ),
          counterText: '',
          contentPadding: EdgeInsets.all(widget.contentPadding),
          suffixIcon: widget.suffixIcon,
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(appColors.greyA5A5A5),
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
        ),
        controller: onTextChanged,
        onChanged: widget.onChanged,
        validator: widget.validator,
        expands: widget.expands,
      ),
    );
  }
}
