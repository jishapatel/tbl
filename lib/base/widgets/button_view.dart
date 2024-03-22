import 'package:flutter/material.dart';

import '../src_constants.dart';

class ButtonView extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? textColor;
  final Color? disableColor;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;
  final double radius;
  final bool disable;
  final AlignmentGeometry alignment;
  final Widget? postfix;
  final double height;
  final double minWidth;
  final TextStyle? textStyle;
  final VoidCallback? isForceClick;
  final double? borderWidth;
  final Color? borderColor;

  ButtonView(this.text, this.onPressed,
      {this.color,
        this.textColor,
        this.disableColor,
        this.height = 56,
        this.minWidth = double.infinity,
        this.radius = 30,
        this.textStyle,
        this.disable = false,
        this.borderColor,
        this.borderWidth,
        this.alignment = Alignment.center,
        this.postfix,
        this.isForceClick,
        this.padding = const EdgeInsets.all(16)});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        elevation: 0,
        padding: padding,
        minWidth: minWidth,
        height: height,
        color: disable
            ? (disableColor != null ? disableColor : BLACK.withOpacity(0.5))
            : (color != null ? color : BUTTON_COLOR),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            side: BorderSide(color: borderColor ?? Colors.transparent,
                width: borderWidth ?? 0.0)),
        child: Container(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Row(
            children: [
              Expanded(
                child: Align(
                    alignment: alignment,
                    child: Text(text,
                        maxLines: 1,
                        style: textStyle == null
                            ? TextStyle(
                            color: textColor != null ? textColor : WHITE,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            fontFamily: FONT_FAMILY_POPPINS)
                            : textStyle)),
              ),
              postfix == null
                  ? SizedBox()
                  : Container(
                  margin: const EdgeInsets.only(left: 12), child: postfix)
            ],
          ),
        ),
        onPressed: isForceClick ?? (disable ? () => null : onPressed));
  }
}
