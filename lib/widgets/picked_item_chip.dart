import 'package:flutter/material.dart';

class PickedItemChip extends StatefulWidget {
  const PickedItemChip({
    Key? key,
    required this.currentItem,
    required this.onRemove,
    required this.hoveredBackgroundColor,
    required this.textColor,
    required this.hoveredTextColor,
    required this.fontSize,
    required this.hoveredRemoveIconColor,
    required this.removedIconColor,
    required this.iconSize,
    required this.contentPadding,
    required this.backgroundColor,
    required this.fontWeight,
    required this.onHoverFontWeight,
    required this.borderRadius,
    this.decoration,
    this.textStyle,
    this.removeIcon,
  }) : super(key: key);

  final String currentItem;
  final VoidCallback onRemove;
  final Color backgroundColor;
  final Color hoveredBackgroundColor;
  final Color hoveredTextColor;
  final Color textColor;
  final Color hoveredRemoveIconColor;
  final Color removedIconColor;
  final double fontSize;
  final double iconSize;
  final EdgeInsets contentPadding;
  final TextStyle? textStyle;

  final FontWeight fontWeight;
  final FontWeight onHoverFontWeight;

  final Widget? removeIcon;
  final BoxDecoration? decoration;
  final double borderRadius;
  @override
  State<PickedItemChip> createState() => _PickedItemChipState();
}

class _PickedItemChipState extends State<PickedItemChip> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      onHover: (v) {
        isHovered = v;
        setState(() {});
      },
      onTap: () {
        widget.onRemove();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        decoration: widget.decoration ??
            BoxDecoration(
              color: isHovered
                  ? widget.hoveredBackgroundColor
                  : widget.backgroundColor,
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
        child: Padding(
          padding: widget.contentPadding,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            style: widget.textStyle?.copyWith(
                  color: isHovered ? widget.hoveredTextColor : widget.textColor,
                  fontWeight:
                      isHovered ? widget.onHoverFontWeight : widget.fontWeight,
                ) ??
                TextStyle(
                  fontSize: 12,
                  color: isHovered ? widget.hoveredTextColor : widget.textColor,
                  fontWeight:
                      isHovered ? widget.onHoverFontWeight : widget.fontWeight,
                ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.currentItem,
                ),
                const SizedBox(
                  width: 5,
                ),
                widget.removeIcon ??
                    Icon(
                      Icons.close,
                      size: widget.iconSize,
                      color: isHovered
                          ? widget.hoveredRemoveIconColor
                          : widget.removedIconColor,
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
