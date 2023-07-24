import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_money/wajiu/constant/color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 自定义带清空内容的TextField
class CustomTextFieldWithClear extends StatefulWidget {
  const CustomTextFieldWithClear(
      {Key? key,
      this.controller,
      this.style,
      this.onChanged,
      this.focusNode,
      this.hintText,
      this.inputFormatters,
      this.hintStyle,
      this.fontSize,
      this.hintFontSize,
      this.color,
      this.hintColor,
      this.showObscure,
      this.maxLines,
      this.keyboardType,
      this.onSubmitted,
      this.textInputAction,
      this.textAlignVertical,
      this.contentPadding,
      this.border,
      this.enabled})
      : super(key: key);

  final TextEditingController? controller;
  final TextStyle? style;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? hintStyle;
  final double? fontSize;
  final double? hintFontSize;
  final Color? color;
  final Color? hintColor;
  final bool? showObscure; // 是否展示模糊眼睛按钮
  final int? maxLines;
  final TextInputType? keyboardType;
  final void Function(String)? onSubmitted;
  final TextInputAction? textInputAction;
  final TextAlignVertical? textAlignVertical;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;
  final bool? enabled;

  @override
  State<CustomTextFieldWithClear> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextFieldWithClear> {
  TextEditingController? _controller;
  FocusNode? _focusNode;
  bool _showCancel = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _controller ??= TextEditingController();
    _focusNode = widget.focusNode;
    _focusNode ??= FocusNode();
    _focusNode?.addListener(() {
      setState(() {
        if (_focusNode?.hasFocus == true && _controller!.text.isNotEmpty) {
          _showCancel = true;
        } else {
          _showCancel = false;
        }
      });
    });
    if (widget.showObscure ?? false) {
      _obscureText = true;
    } else {
      _obscureText = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: _obscureText,
      focusNode: _focusNode,
      maxLines: widget.maxLines,
      controller: _controller,
      keyboardType: widget.keyboardType,
      enabled: widget.enabled,
      style: widget.style ??
          TextStyle(
              fontSize: widget.fontSize ?? 16.sp,
              color: widget.color ?? ColorConstant.color_333333),
      onChanged: (String value) {
        if (_focusNode?.hasFocus == true) {
          setState(() {
            if (value.isNotEmpty) {
              _showCancel = true;
            } else {
              _showCancel = false;
            }
          });
        }
        widget.onChanged?.call(value);
      },
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        contentPadding: widget.contentPadding,
        border: widget.border ?? InputBorder.none,
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _showCancel
                ? IconButton(
                    icon: Icon(
                      Icons.cancel,
                      size: 18.w,
                      color: ColorConstant.color_e0e0e0,
                    ),
                    onPressed: () {
                      setState(() {
                        _showCancel = false;
                        _controller?.text = '';
                        widget.onChanged?.call('');
                      });
                    },
                  )
                : const SizedBox(),
            (widget.showObscure == true)
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      size: 18.w,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : const SizedBox(),
          ],
        ),
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ??
            TextStyle(
                fontSize: widget.hintFontSize ?? 16.sp,
                color: widget.hintColor ?? ColorConstant.color_d6d6d6),
      ),
      onSubmitted: widget.onSubmitted,
      textInputAction: widget.textInputAction,
      textAlignVertical: widget.textAlignVertical,
    );
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller?.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode?.dispose();
    }
    super.dispose();
  }
}
