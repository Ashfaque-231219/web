import 'package:flutter/material.dart';
import 'package:web/helper/constants/colors.dart';
import 'package:web/helper/constants/dimen.dart';

class CustomPasswordField extends StatefulWidget {
  const CustomPasswordField({
    required this.onTextChanged,
    this.hintText = "",
    this.focus,
    this.maxLength,
    this.validator,
    Key? key,  Function(String? value)? valueChanged,
  }) : super(key: key);
  final TextEditingController onTextChanged;
  final String hintText;
  final FocusNode? focus;
  final int? maxLength;
  final FormFieldValidator<String>? validator;

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool obscureText = true;

  get onTextChanged => widget.onTextChanged;

  get _obscureText => obscureText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child:  TextFormField(
          textAlignVertical: TextAlignVertical.center,
          obscureText: _obscureText,
          focusNode: widget.focus,
          maxLength: widget.maxLength,
          decoration: InputDecoration(
              hintText: widget.focus == null ||
                      (widget.focus != null && widget.focus!.hasFocus)
                  ? ''
                  : widget.hintText,
              labelText: widget.hintText,
              counterText: '',
              contentPadding: EdgeInsets.all(appDimen.sp10),
              isDense: true,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(appColors.grey00000029),
                ),
                borderRadius: BorderRadius.circular(0),
              ),
              suffixIconConstraints: const BoxConstraints(),
              suffixIcon: InkWell(
                onTap: _togglePasswordView,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(_obscureText
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined),
                ),
              )),
          controller: onTextChanged,
          validator: widget.validator,
        ),
    );
  }

  void _togglePasswordView() {
    setState(() {
      obscureText = !_obscureText;
    });
  }
}
