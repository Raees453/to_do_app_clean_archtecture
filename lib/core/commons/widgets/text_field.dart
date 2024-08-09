import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do_app/core/commons/extensions/build_extension.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.maxLines = 1,
    this.enabled = true,
    this.obscureText = false,
    this.isTitleRequired = true,
    this.hasRightBorderRadius = false,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.sentences,
    required this.hintText,
    required this.controller,
    this.title,
    this.validator,
    this.prefix,
    this.suffix,
    this.titleStyle,
    this.maxLength,
    this.onChanged,
    this.node,
  });

  final bool enabled;
  final bool obscureText;
  final bool isTitleRequired;
  final bool hasRightBorderRadius;
  final int? maxLines, maxLength;
  final String? title;
  final String hintText;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;

  final TextStyle? titleStyle;

  final FocusNode? node;
  final Widget? prefix;
  final Widget? suffix;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    _obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final borderColor = Colors.grey.withOpacity(0.8);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          CustomFieldTitleWidget(
            enabled: widget.enabled,
            title: widget.title!,
            isTitleRequired: widget.isTitleRequired,
          ),
        if (widget.title != null) const SizedBox(height: 8),
        TextFormField(
          focusNode: widget.node,
          enabled: widget.enabled,
          obscureText: _obscureText,
          onChanged: widget.onChanged,
          maxLength: widget.maxLength,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            counterText: '',
            labelStyle: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.colorScheme.onTertiary,
            ),
            hintStyle: textTheme.bodyMedium?.copyWith(color: borderColor),
            hintText: widget.hintText,
            suffixIcon: widget.obscureText ? const Icon(Icons.remove_red_eye) : widget.suffix,
            prefixIcon: widget.prefix,
            suffixIconColor: const Color(0xff64748B),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
          ),
          controller: widget.controller,
          textInputAction: widget.textInputAction,
          keyboardType: widget.textInputType,
          maxLines: widget.maxLines,
          validator: widget.validator,
          textCapitalization: widget.textCapitalization,
        ),
      ],
    );
  }

  // void _onPressed() => setState(() => _obscureText = !_obscureText);
}

class CustomFieldTitleWidget extends StatelessWidget {
  const CustomFieldTitleWidget({
    super.key,
    this.enabled = true,
    this.isTitleRequired = true,
    required this.title,
  });

  final bool enabled;
  final bool isTitleRequired;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: context.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        if (isTitleRequired) ...[
          const SizedBox(width: 2),
          Text(
            '*',
            style: context.textTheme.bodyLarge?.copyWith(
              color: Colors.red,
            ),
          ),
        ],
      ],
    );
  }
}
