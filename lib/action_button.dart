import 'package:flutter/material.dart';

class ActionButton extends StatefulWidget {
  const ActionButton({
    Key? key,
    required this.text,
    required this.onTap,
    required this.onHoverBackgroundColor,
    required this.textColor,
    required this.onHoverTextColor,
    required this.backgroundColor,
    required this.animationDuration,
    required this.fontWeight,
    required this.onHoverFontWeight,
    required this.borderColor,
    required this.onHoverBorderColor,
    required this.borderRadius,
    required this.contentPadding,
    this.fontSize,
    this.textStyle,
  }) : super(key: key);

  final String text;
  final VoidCallback onTap;
  final Color onHoverBackgroundColor;
  final Color backgroundColor;
  final Color onHoverTextColor;
  final Color textColor;
  final Color borderColor;
  final Color onHoverBorderColor;

  final double? fontSize;
  final double borderRadius;

  final FontWeight fontWeight;
  final FontWeight onHoverFontWeight;
  final Duration animationDuration;
  final EdgeInsets contentPadding;

  final TextStyle? textStyle;
  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      onHover: (v) {
        isHovered = v;
        setState(() {});
      },
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: widget.animationDuration,
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isHovered
              ? widget.onHoverBackgroundColor
              : widget.backgroundColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: Border.all(
            color: isHovered ? widget.onHoverBorderColor : widget.borderColor,
          ),
        ),
        child: Padding(
            padding: widget.contentPadding,
            child: AnimatedDefaultTextStyle(
              duration: widget.animationDuration,
              curve: Curves.easeInOut,
              style: widget.textStyle?.copyWith(
                    color:
                        isHovered ? widget.onHoverTextColor : widget.textColor,
                    fontWeight: isHovered
                        ? widget.onHoverFontWeight
                        : widget.fontWeight,
                  ) ??
                  TextStyle(
                    fontSize: widget.fontSize ?? 13,
                    color:
                        isHovered ? widget.onHoverTextColor : widget.textColor,
                    fontWeight: isHovered
                        ? widget.onHoverFontWeight
                        : widget.fontWeight,
                  ),
              child: Text(
                widget.text,
              ),
            )),
      ),
    );
  }
}
