library multiple_search_selection;

import 'package:flutter/material.dart';
import 'package:multiple_search_selection/helpers/jaro.dart';
import 'package:multiple_search_selection/helpers/levenshtein.dart';
import 'package:multiple_search_selection/widgets/action_button.dart';
import 'package:multiple_search_selection/widgets/picked_item_chip.dart';

enum FuzzySearch {
  levenshtein,
  jaro,
  none,
}

enum ShowedItemsVisibility {
  alwaysOn,
  onType,
  toggle,
}

class MultipleSearchSelection extends StatefulWidget {
  const MultipleSearchSelection({
    required this.items,
    required this.onPickedChange,
    this.initialPickedItems,
    this.fuzzySearch = FuzzySearch.none,
    this.padding,
    this.onItemAdded,
    this.onItemRemoved,
    this.onTapShowedItem,
    this.title,
    this.titlePadding,
    this.maximumShowItemsHeight = 150,
    this.hintText,
    this.hintTextStyle,
    this.showClearAllButton = true,
    this.showSelectAllButton = true,
    this.showTooltipOnpickedItem = false,
    this.sortPickedItems = false,
    this.sortShowedItems = false,
    this.tooltipDecoration,
    this.tooltipContentPadding,
    this.showedItemTextStyle,
    this.selectAllText,
    this.selectAllOnHoverTextColor,
    this.selectAllFontWeight,
    this.selectAllOnHoverFontWeight,
    this.selectAllTextStyle,
    this.selectAllTextColor,
    this.selectAllBorderRadius,
    this.selectAllContentPadding,
    this.selectAllHoverColor,
    this.selectAllAnimationDuration,
    this.selectAllBackgroundColor,
    this.selectAllBorderColor,
    this.selectAllFontSize,
    this.selectAllOnHoverBackgroundColor,
    this.selectAllOnHoverBorderColor,
    this.selectAllAnimationCurve,
    this.clearAllText,
    this.clearAllTextStyle,
    this.clearAllBorderRadius,
    this.clearAllContentPadding,
    this.clearAllAnimationDuration,
    this.clearAllBackgroundColor,
    this.clearAllBorderColor,
    this.clearAllFontSize,
    this.clearAllFontWeight,
    this.clearAllOnHoverColor,
    this.clearAllOnHoverBackgroundColor,
    this.clearAllOnHoverBorderColor,
    this.clearAllOnHoverFontWeight,
    this.clearAllTextColor,
    this.clearAllOnHoverTextColor,
    this.clearAllAnimationCurve,
    this.pickedItemTextStyle,
    this.pickedItemSpacing,
    this.pickedItemBackgroundColor,
    this.pickedItemBorderRadius,
    this.pickedItemBoxDecoration,
    this.pickedItemOnHoverBackgroundColor,
    this.pickedItemFontSIze,
    this.pickedItemOnHoverTextColor,
    this.pickedItemRemoveIconColor,
    this.pickedItemRemoveIconSize,
    this.pickedItemTextColor,
    this.pickedItemTooltipTextStyle,
    this.pickedItemContentPadding,
    this.pickedItemOnHoveredRemoveIconColor,
    this.pickedItemScrollbarColor,
    this.pickedItemScrollbarMinOverscrollLength,
    this.pickedItemScrollbarRadius,
    this.pickedItemScrollbarThickness,
    this.pickedItemScrollbarMinThumbLength,
    this.pickedItemsBoxDecoration,
    this.pickedItemFontWeight,
    this.pickedItemOnHoverFontWeight,
    this.pickedItemsContainerMaxHeight,
    this.pickedItemsContainerMinHeight,
    this.pickedItemsBorderColor,
    this.pickedItemRemoveIcon,
    this.pickedItemsScrollController,
    this.pickedItemsScrollPhysics,
    this.pickedItemMouseCursor,
    this.showShowedItemsScrollbar = true,
    this.showPickedItemScrollbar = true,
    this.showedItemsScrollbarColor,
    this.showedItemsScrollbarMinOverscrollLength,
    this.showedItemsScrollbarMinThumbLength,
    this.showedItemsScrollbarRadius,
    this.showedItemsScrollbarThickness,
    this.showedItemContainerContentPadding,
    this.showedItemContainerDecoration,
    this.showedItemContainerHeight,
    this.showedItemContainerPadding,
    this.showedItemsBackgroundColor,
    this.showedItemMouseCursor,
    this.showedItemsScrollController,
    this.showedItemsScrollPhysics,
    this.showedItemsBoxDecoration,
    this.searchItemTextInputDecoration,
    this.searchItemTextStyle,
    this.searchItemTextContentPadding,
    this.noResultsWidget,
    this.outerContainerBorderColor,
    this.showItemsAnimationCurve,
    this.showItemsAnimationDuration,
    this.showItemsBackgroundColor,
    this.showItemsBorderColor,
    this.showItemsBorderRadius,
    this.showItemsContentPadding,
    this.showItemsFontSize,
    this.showItemsFontWeight,
    this.showItemsOnHoverBackgroundColor,
    this.showItemsOnHoverBorderColor,
    this.showItemsOnHoverColor,
    this.showItemsOnHoverFontWeight,
    this.showItemsOnHoverTextColor,
    this.showItemsText,
    this.showItemsTextColor,
    this.showItemsTextStyle,
    this.itemsVisibility = ShowedItemsVisibility.alwaysOn,
    Key? key,
  }) : super(key: key);

  /// The title widget on top of picked items.
  final Widget? title;

  /// The padding of the whole widget.
  final EdgeInsets? padding;

  /// The padding of the title Widget. Defaults to [EdgeInsets.zero].
  final EdgeInsets? titlePadding;

  /// The border color of the picked items container.
  final Color? pickedItemsBorderColor;

  /// The border color of the container that includes the search text field and  the showed items.
  final Color? outerContainerBorderColor;

  /// The maximum height constraints of the items' container.
  final double maximumShowItemsHeight;

  /// The list of items to search and select.
  final List<String> items;

  /// The list of initial picked items.
  final List<String>? initialPickedItems;

  /// The thumb color of the items' scrollbar.
  final Color? showedItemsScrollbarColor;

  /// The background color of the container holding all the items.
  final Color? showedItemsBackgroundColor;

  /// The thickness of the items' scrollbar thumb.
  final double? showedItemsScrollbarThickness;

  /// The minimum length of the items' scrollbar thumb.
  final double? showedItemsScrollbarMinThumbLength;

  /// The minimum length of the overscroll for items.
  final double? showedItemsScrollbarMinOverscrollLength;

  /// The radius of the items' scrollbar.
  final Radius? showedItemsScrollbarRadius;

  /// The height of the showed item container. Defaults to 50 pixels.
  final double? showedItemContainerHeight;

  /// The padding of the showed item container.
  final EdgeInsets? showedItemContainerPadding;

  /// The content padding of the showed item container. Defaults to [EdgeInsets.only(left: 8.0)]
  final EdgeInsets? showedItemContainerContentPadding;

  /// The decoration of the showed item container.
  final BoxDecoration? showedItemContainerDecoration;

  /// The mouse cursor when hovered over showed item container. Defaults to [SystemMouseCursors.click]
  final MouseCursor? showedItemMouseCursor;

  /// Hide or show items' scrollbar, defaults to [true]
  final bool showShowedItemsScrollbar;

  /// Hide or show select all button.
  final bool showSelectAllButton;

  /// Hide or show clear all button.
  final bool showClearAllButton;

  /// Hide or show tooltip when hovering picked item chip.
  final bool showTooltipOnpickedItem;

  /// The [BoxDecoration] of the picked item tooltip.
  final BoxDecoration? tooltipDecoration;

  /// The content padding of the picked item tooltip.
  final EdgeInsets? tooltipContentPadding;

  /// A callback when user selects or deselects an item. Always returns the currently picked items.
  final Function(List<String>) onPickedChange;

  /// A callback when an item is removed, returns the item aswell.
  final Function(String)? onItemRemoved;

  /// A callback when an item is added, returns the item aswell.
  final Function(String)? onItemAdded;

  /// [TextStyle] of the showed items.
  final TextStyle? showedItemTextStyle;

  /// The input decoration of the search text field.
  final InputDecoration? searchItemTextInputDecoration;

  /// The hint text of the search field. This is overriden if [searchItemTextInputDecoration] is provided.
  final String? hintText;

  /// What is shown when there are no more results to select.
  final Widget? noResultsWidget;

  /// The hint text style of the search field. This is overriden if [searchItemTextInputDecoration] is provided.
  final TextStyle? hintTextStyle;

  /// The text style of the search text field.
  final TextStyle? searchItemTextStyle;

  /// The text that appears on select all button.
  final String? selectAllText;

  /// The text style of the select all button.
  ///
  /// Keep in mind that, this is a child of [AnimatedDefaultTextStyle] and you can use
  ///
  /// conditions to animate your textstyle.
  final TextStyle? selectAllTextStyle;

  /// The background color of the select all button on idle state.
  final Color? selectAllBackgroundColor;

  /// The animation [Curve] of the select all button style. Defaults to [Curves.easeInOut].
  final Curve? selectAllAnimationCurve;

  /// The background color of the select all button when hovered.
  final Color? selectAllOnHoverBackgroundColor;

  /// The animation duration of color changes of the select all button.
  final Duration? selectAllAnimationDuration;

  /// The select all text font size. This is overriden if [selectAllTextStyle] is provided.
  final double? selectAllFontSize;

  /// The select all text color on idle state. This is overriden if [selectAllTextStyle] is provided.
  final Color? selectAllTextColor;

  /// The select all text color when hovered. This is overriden if [selectAllTextStyle] is provided.
  final Color? selectAllOnHoverTextColor;

  /// The font weight of the text on select all button, on idle state. This is overriden if [selectAllTextStyle] is provided.
  final FontWeight? selectAllFontWeight;

  /// The font weight of the text on select all button, when hovered. This is overriden if [selectAllTextStyle] is provided.
  final FontWeight? selectAllOnHoverFontWeight;

  /// The border radius of the select all button.
  final double? selectAllBorderRadius;

  /// The border color of the select all button on idle state.
  final Color? selectAllBorderColor;

  /// The border color of the select all button when hovered.
  final Color? selectAllOnHoverBorderColor;

  /// The padding of the text in the select all button.
  final EdgeInsets? selectAllContentPadding;

  /// The color that appears when hovering of the select all button.
  final Color? selectAllHoverColor;

  /// The text that appears on clear all button.
  final String? clearAllText;

  /// The text style of the clear all button.
  ///
  /// Keep in mind that, this is a child of [AnimatedDefaultTextStyle] and you can use
  ///
  /// conditions to animate your textstyle.
  final TextStyle? clearAllTextStyle;

  /// The background color of the clear all button on idle state.
  final Color? clearAllBackgroundColor;

  /// The animation [Curve] of the clear all button style. Defaults to [Curves.easeInOut].
  final Curve? clearAllAnimationCurve;

  /// The background color of the clear all button when hovered.
  final Color? clearAllOnHoverBackgroundColor;

  /// The animation duration of color changes of the clear all button.
  final Duration? clearAllAnimationDuration;

  /// The clear all text font size. This is overriden if [clearAllTextStyle] is provided.
  final double? clearAllFontSize;

  /// The clear all text color on idle state. This is overriden if [clearAllTextStyle] is provided.
  final Color? clearAllTextColor;

  /// The clear all text color when hovered. This is overriden if [clearAllTextStyle] is provided.
  final Color? clearAllOnHoverTextColor;

  /// The font weight of the text on clear all button, on idle state. This is overriden if [clearAllTextStyle] is provided.
  final FontWeight? clearAllFontWeight;

  /// The font weight of the text on clear all button, when hovered. This is overriden if [clearAllTextStyle] is provided.
  final FontWeight? clearAllOnHoverFontWeight;

  /// The border radius of the clear all button.
  final double? clearAllBorderRadius;

  /// The border color of the clear all button on idle state.
  final Color? clearAllBorderColor;

  /// The border color of the clear all button when hovered.
  final Color? clearAllOnHoverBorderColor;

  /// The padding of the text in the clear all button.
  final EdgeInsets? clearAllContentPadding;

  /// The color that appears when hovering over the clear all button.
  final Color? clearAllOnHoverColor;

  /// The textstyle of picked item tooltip.
  ///
  /// Keep in mind that, this is a child of [AnimatedDefaultTextStyle] and you can use
  ///
  /// conditions to animate your textstyle.
  final TextStyle? pickedItemTooltipTextStyle;

  /// The text style of the picked item chip.
  final TextStyle? pickedItemTextStyle;

  /// The background color of the picked item chip, on idle state.
  final Color? pickedItemBackgroundColor;

  /// The background color of the picked item chip, when hovered.
  final Color? pickedItemOnHoverBackgroundColor;

  /// The spacing of picked item chip. Defaults to 5.
  final double? pickedItemSpacing;

  /// The maximum height of which the picked items container can extend. Defaults to 150 pixels.
  final double? pickedItemsContainerMaxHeight;

  /// The minimum height of which the picked items container can extend. Defaults to 50 pixels.
  final double? pickedItemsContainerMinHeight;

  /// The border radius of the picked item chip. This is overriden if [pickedItemBoxDecoration] is provided.
  final double? pickedItemBorderRadius;

  /// The color of the picked item text, on idle state. This is overriden if [pickedItemTextStyle] is provided.
  final Color? pickedItemTextColor;

  /// The color of the picked item text, when hovered. This is overriden if [pickedItemTextStyle] is provided.
  final Color? pickedItemOnHoverTextColor;

  /// The font size of the text tha appears on picked item chip. This is overriden if [pickedItemTextStyle] is provided.
  final double? pickedItemFontSIze;

  /// The remove icon color of the picked item chip, on idle state.
  final Color? pickedItemRemoveIconColor;

  /// The remove icon color of the picked item chip, when hovered.  This is overriden if [pickedItemBoxDecoration] is provided.
  final Color? pickedItemOnHoveredRemoveIconColor;

  /// The remove icon size of the picked item chip.
  final double? pickedItemRemoveIconSize;

  /// The picked item remove icon. Defaults to [Icons.close].
  final Widget? pickedItemRemoveIcon;

  /// The content padding of the picked items' chip.
  final EdgeInsets? pickedItemContentPadding;

  /// The thumb color of the picked items' scrollbar.
  final Color? pickedItemScrollbarColor;

  /// The thickness of the picked items' scrollbar thumb.
  final double? pickedItemScrollbarThickness;

  /// The minimum length of the overscroll for picked items.
  final double? pickedItemScrollbarMinOverscrollLength;

  /// The radius of the picked items' scrollbar.
  final Radius? pickedItemScrollbarRadius;

  /// The minimum length of the picked items' scrollbar thumb.
  final double? pickedItemScrollbarMinThumbLength;

  /// The [BoxDecoration] of the picked items container.
  final BoxDecoration? pickedItemsBoxDecoration;

  /// The picked item's font weight, on idle state. Defaults to [FontWeight.w100].
  final FontWeight? pickedItemFontWeight;

  /// The picked item's font weight, on hover. Defaults to [FontWeight.bold].
  final FontWeight? pickedItemOnHoverFontWeight;

  /// The picked item's [BoxDecoration].
  final BoxDecoration? pickedItemBoxDecoration;

  /// The mouse cursor when hovered over picked item.
  final MouseCursor? pickedItemMouseCursor;

  /// Hide or show picked items' scrollbar, defaults to [true].
  final bool showPickedItemScrollbar;

  /// The content padding of the search item textfield. This is overriden if [searchItemTextInputDecoration] is provided.
  final EdgeInsets? searchItemTextContentPadding;

  /// A callback when a showed item is tapped.
  final VoidCallback? onTapShowedItem;

  /// The [ScrollController] of the picked items list.
  final ScrollController? pickedItemsScrollController;

  /// The [ScrollController] of showed items list.
  final ScrollController? showedItemsScrollController;

  /// The [ScrollPhysics] of the picked items list.
  final ScrollPhysics? pickedItemsScrollPhysics;

  /// The [ScrollPhysics] of showed items list.
  final ScrollPhysics? showedItemsScrollPhysics;

  /// The [BoxDecoration] of the showed items container.
  final BoxDecoration? showedItemsBoxDecoration;

  /// Whether the picked items are sorted alphabetically. Defaults to [false].
  final bool sortPickedItems;

  /// Whether the showed items are sorted alphabetically. Defaults to [false].
  final bool sortShowedItems;

  /// How the showed items are displayed.
  ///
  /// There are currently three types :
  ///
  /// ```dart
  /// ShowedItemsVisibility.alwaysOn // The items are always displayed
  /// ShowedItemsVisibility.onType // Items are displayed when user types on search field
  /// ShowedItemsVisibility.toggle // Items are displayed when tapped on toggle button
  /// ```
  ///
  /// Defaults to [ShowedItemsVisibility.alwaysOn].
  final ShowedItemsVisibility itemsVisibility;

  /// Fuzzy search functionality. Defaults to [FuzzySearch.none].
  ///
  /// Currently available fuzzy algorithms :
  ///
  /// ```dart
  /// FuzzySearch.jaro // Measures characters in common, considerating transpositions.
  /// ```
  /// ### Shows results with score higher of 0.8.
  ///
  /// ```dart
  /// FuzzySearch.levenshtein // The number of edits required to convert one string to other.
  /// ```
  /// ### Shows results with minimum 2 edits.
  final FuzzySearch fuzzySearch;

  /// The text that appears on show items toggle button.
  ///
  /// Only when [itemsVisibility] == [ShowedItemsVisibility.toggle].
  final String? showItemsText;

  /// The text style of the show items toggle button.
  ///
  /// Only when [itemsVisibility] == [ShowedItemsVisibility.toggle].
  ///
  /// Keep in mind that, this is a child of [AnimatedDefaultTextStyle] and you can use
  ///
  /// conditions to animate your textstyle.
  final TextStyle? showItemsTextStyle;

  /// The background color of the show items toggle button on idle state.
  ///
  /// Only when [itemsVisibility] == [ShowedItemsVisibility.toggle].
  final Color? showItemsBackgroundColor;

  /// The animation [Curve] of the show items toggle button.
  ///
  /// Only when [itemsVisibility] == [ShowedItemsVisibility.toggle].
  ///
  /// Defaults to [Curves.easeInOut].
  final Curve? showItemsAnimationCurve;

  /// The background color of the show items toggle button when hovered.
  ///
  /// Only when [itemsVisibility] == [ShowedItemsVisibility.toggle].
  final Color? showItemsOnHoverBackgroundColor;

  /// The animation duration of color changes of the show items toggle button.
  final Duration? showItemsAnimationDuration;

  /// The show items toggle button font size. This is overriden if [showItemsTextStyle] is provided.
  final double? showItemsFontSize;

  /// The show items toggle button text color on idle state. This is overriden if [showItemsTextStyle] is provided.
  final Color? showItemsTextColor;

  /// The show items toggle button text color when hovered. This is overriden if [showItemsTextStyle] is provided.
  final Color? showItemsOnHoverTextColor;

  /// The font weight of the show items toggle button, on idle state. This is overriden if [showItemsTextStyle] is provided.
  final FontWeight? showItemsFontWeight;

  /// The font weight of the show items toggle button, when hovered. This is overriden if [showItemsTextStyle] is provided.
  final FontWeight? showItemsOnHoverFontWeight;

  /// The border radius of the show items toggle button.
  final double? showItemsBorderRadius;

  /// The border color of the show items toggle button on idle state.
  final Color? showItemsBorderColor;

  /// The border color of the show items toggle button when hovered.
  final Color? showItemsOnHoverBorderColor;

  /// The padding of the text in the show items toggle button.
  final EdgeInsets? showItemsContentPadding;

  /// The color that appears when hovering over the show items toggle button.
  final Color? showItemsOnHoverColor;

  @override
  _MultipleSearchSelectionState createState() =>
      _MultipleSearchSelectionState();
}

class _MultipleSearchSelectionState extends State<MultipleSearchSelection> {
  late List<String> showedItems;
  late List<String> allItems;

  bool expanded = false;

  List<String> pickedItems = [];
  final ScrollController _pickedItemsController = ScrollController();
  final ScrollController _showedItemsScrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();

  final FocusNode _textFieldFocus = FocusNode();
  @override
  void initState() {
    super.initState();
    showedItems = [...widget.items];
    allItems = [...widget.items];
    if (widget.sortShowedItems) {
      showedItems.sort();
      allItems.sort();
    }

    expanded = widget.itemsVisibility == ShowedItemsVisibility.alwaysOn;

    pickedItems.addAll(widget.initialPickedItems ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null) ...[
            Padding(
              padding: widget.titlePadding ?? EdgeInsets.zero,
              child: widget.title,
            ),
          ],
          if (pickedItems.isNotEmpty)
            // picked item chips
            Container(
              width: MediaQuery.of(context).size.width,
              constraints: BoxConstraints(
                maxHeight: widget.pickedItemsContainerMaxHeight ?? 150,
                minHeight: widget.pickedItemsContainerMinHeight ?? 50,
              ),
              decoration: widget.pickedItemsBoxDecoration ??
                  BoxDecoration(
                    border: pickedItems.isNotEmpty
                        ? Border.all(
                            color: Colors.grey.withOpacity(0.5),
                          )
                        : null,
                  ),
              child: RawScrollbar(
                thumbVisibility: widget.showPickedItemScrollbar,
                thumbColor: widget.pickedItemScrollbarColor,
                minOverscrollLength:
                    widget.pickedItemScrollbarMinOverscrollLength ?? 5,
                minThumbLength: widget.pickedItemScrollbarMinThumbLength ?? 30,
                thickness: widget.pickedItemScrollbarThickness ?? 10,
                radius: widget.pickedItemScrollbarRadius ??
                    const Radius.circular(5),
                controller: widget.pickedItemsScrollController ??
                    _pickedItemsController,
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    controller: widget.pickedItemsScrollController ??
                        _pickedItemsController,
                    physics: widget.pickedItemsScrollPhysics,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        spacing: widget.pickedItemSpacing ?? 5,
                        runSpacing: widget.pickedItemSpacing ?? 5,
                        children: [
                          ...pickedItems.map(
                            (e) => widget.showTooltipOnpickedItem
                                ? Tooltip(
                                    message: e,
                                    preferBelow: true,
                                    textStyle:
                                        widget.pickedItemTooltipTextStyle,
                                    decoration: widget.tooltipDecoration,
                                    padding: widget.tooltipContentPadding,
                                    child: PickedItemChip(
                                      removeIcon: widget.pickedItemRemoveIcon,
                                      mouseCursor: widget.pickedItemMouseCursor,
                                      decoration:
                                          widget.pickedItemBoxDecoration,
                                      borderRadius:
                                          widget.pickedItemBorderRadius ?? 0,
                                      textStyle: widget.pickedItemTextStyle,
                                      fontWeight: widget.pickedItemFontWeight ??
                                          FontWeight.w100,
                                      onHoverFontWeight:
                                          widget.pickedItemOnHoverFontWeight ??
                                              FontWeight.bold,
                                      backgroundColor: widget
                                              .pickedItemBackgroundColor ??
                                          Colors.grey[500]!.withOpacity(0.3),
                                      contentPadding:
                                          widget.pickedItemContentPadding ??
                                              const EdgeInsets.all(8),
                                      textColor: widget.pickedItemTextColor ??
                                          Colors.black,
                                      removedIconColor:
                                          widget.pickedItemRemoveIconColor ??
                                              Colors.black,
                                      hoveredRemoveIconColor: widget
                                              .pickedItemOnHoveredRemoveIconColor ??
                                          Colors.white,
                                      iconSize:
                                          widget.pickedItemRemoveIconSize ?? 15,
                                      currentItem: e,
                                      hoveredBackgroundColor: widget
                                              .pickedItemOnHoverBackgroundColor ??
                                          Colors.red,
                                      fontSize: widget.pickedItemFontSIze ?? 12,
                                      hoveredTextColor:
                                          widget.pickedItemOnHoverTextColor ??
                                              Colors.white,
                                      onRemove: () {
                                        pickedItems.remove(e);
                                        allItems.add(e);
                                        showedItems = allItems
                                            .where(
                                              (p) => p.toLowerCase().contains(
                                                    _textEditingController.text,
                                                  ),
                                            )
                                            .toList();
                                        if (showedItems.isNotEmpty) {
                                          if (widget.sortShowedItems) {
                                            showedItems.sort();
                                          }
                                        }
                                        if (widget.sortShowedItems) {
                                          allItems.sort();
                                        }

                                        widget.onPickedChange(pickedItems);
                                        widget.onItemRemoved?.call(e);
                                        setState(() {});
                                      },
                                    ),
                                  )
                                : PickedItemChip(
                                    textStyle: widget.pickedItemTextStyle,
                                    removeIcon: widget.pickedItemRemoveIcon,
                                    decoration: widget.pickedItemBoxDecoration,
                                    fontWeight: widget.pickedItemFontWeight ??
                                        FontWeight.w100,
                                    borderRadius:
                                        widget.pickedItemBorderRadius ?? 0,
                                    onHoverFontWeight:
                                        widget.pickedItemOnHoverFontWeight ??
                                            FontWeight.bold,
                                    contentPadding:
                                        widget.pickedItemContentPadding ??
                                            const EdgeInsets.all(8),
                                    backgroundColor:
                                        widget.pickedItemBackgroundColor ??
                                            Colors.grey[500]!.withOpacity(0.3),
                                    textColor: widget.pickedItemTextColor ??
                                        Colors.black,
                                    removedIconColor:
                                        widget.pickedItemRemoveIconColor ??
                                            Colors.black,
                                    hoveredRemoveIconColor: widget
                                            .pickedItemOnHoveredRemoveIconColor ??
                                        Colors.white,
                                    iconSize:
                                        widget.pickedItemRemoveIconSize ?? 15,
                                    currentItem: e,
                                    hoveredBackgroundColor: widget
                                            .pickedItemOnHoverBackgroundColor ??
                                        Colors.red,
                                    fontSize: widget.pickedItemFontSIze ?? 12,
                                    hoveredTextColor:
                                        widget.pickedItemOnHoverTextColor ??
                                            Colors.white,
                                    onRemove: () {
                                      pickedItems.remove(e);
                                      allItems.add(e);
                                      showedItems = allItems
                                          .where(
                                            (p) => p.toLowerCase().contains(
                                                  _textEditingController.text,
                                                ),
                                          )
                                          .toList();
                                      if (showedItems.isNotEmpty) {
                                        if (widget.sortShowedItems) {
                                          showedItems.sort();
                                        }
                                      }
                                      if (widget.sortShowedItems) {
                                        allItems.sort();
                                      }

                                      widget.onPickedChange(pickedItems);
                                      widget.onItemRemoved?.call(e);
                                      setState(() {});
                                    },
                                  ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (widget.showClearAllButton ||
              widget.showClearAllButton ||
              widget.itemsVisibility == ShowedItemsVisibility.toggle) ...[
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (widget.itemsVisibility ==
                        ShowedItemsVisibility.toggle) ...[
                      ActionButton(
                        text: widget.selectAllText ?? 'Show items',
                        backgroundColor:
                            widget.showItemsBackgroundColor ?? Colors.white,
                        animationDuration: widget.showItemsAnimationDuration ??
                            const Duration(milliseconds: 200),
                        fontSize: widget.showItemsFontSize ?? 13,
                        textStyle: widget.showItemsTextStyle ??
                            widget.showItemsTextStyle,
                        borderRadius: widget.showItemsBorderRadius ?? 0,
                        actionButtonAnimationCurve:
                            widget.showItemsAnimationCurve,
                        borderColor:
                            widget.showItemsBorderColor ?? Colors.blue[300]!,
                        contentPadding: widget.showItemsContentPadding ??
                            const EdgeInsets.all(8),
                        textColor:
                            widget.showItemsTextColor ?? Colors.blue[300]!,
                        fontWeight:
                            widget.showItemsFontWeight ?? FontWeight.w500,
                        onHoverBorderColor:
                            widget.showItemsOnHoverBorderColor ?? Colors.white,
                        onHoverBackgroundColor:
                            widget.showItemsBackgroundColor ??
                                Colors.blue[300]!,
                        onHoverFontWeight: widget.showItemsOnHoverFontWeight ??
                            FontWeight.w100,
                        onHoverTextColor:
                            widget.showItemsOnHoverTextColor ?? Colors.white,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => StatefulBuilder(
                              builder: (context, stateSetter) {
                                return Dialog(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border(
                                            top: BorderSide(
                                              color: widget
                                                      .outerContainerBorderColor ??
                                                  Colors.grey.withOpacity(0.5),
                                            ),
                                            left: BorderSide(
                                              color: widget
                                                      .outerContainerBorderColor ??
                                                  Colors.grey.withOpacity(0.5),
                                            ),
                                            right: BorderSide(
                                              color: widget
                                                      .outerContainerBorderColor ??
                                                  Colors.grey.withOpacity(0.5),
                                            ),
                                            bottom: BorderSide(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                        child: TextField(
                                          focusNode: _textFieldFocus,
                                          controller: _textEditingController,
                                          style: widget.searchItemTextStyle,
                                          decoration: widget
                                                  .searchItemTextInputDecoration ??
                                              InputDecoration(
                                                contentPadding: widget
                                                        .searchItemTextContentPadding ??
                                                    const EdgeInsets.only(
                                                        left: 6),
                                                hintText: widget.hintText ??
                                                    'Type here to search',
                                                hintStyle:
                                                    widget.hintTextStyle ??
                                                        const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                          onChanged: (value) {
                                            if (widget.fuzzySearch ==
                                                FuzzySearch.jaro) {
                                              showedItems = allItems.where(
                                                (p) {
                                                  return p
                                                          .toLowerCase()
                                                          .contains(value) ||
                                                      (getJaro(p, value) >=
                                                          0.8);
                                                },
                                              ).toList();
                                            } else if (widget.fuzzySearch ==
                                                FuzzySearch.levenshtein) {
                                              showedItems = allItems.where(
                                                (p) {
                                                  return p
                                                          .toLowerCase()
                                                          .contains(value) ||
                                                      (getLevenshtein(
                                                              p, value) <=
                                                          2);
                                                },
                                              ).toList();
                                            } else {
                                              showedItems = allItems
                                                  .where(
                                                    (p) => p
                                                        .toLowerCase()
                                                        .contains(value),
                                                  )
                                                  .toList();
                                            }
                                            setState(() {});
                                            stateSetter(() {});
                                          },
                                        ),
                                      ),
                                      Container(
                                        constraints: BoxConstraints(
                                          maxHeight:
                                              widget.maximumShowItemsHeight,
                                        ),
                                        decoration: widget
                                                .showedItemsBoxDecoration ??
                                            BoxDecoration(
                                              color: widget
                                                      .showedItemsBackgroundColor ??
                                                  Colors.grey.withOpacity(0.1),
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: widget
                                                          .outerContainerBorderColor ??
                                                      Colors.grey
                                                          .withOpacity(0.5),
                                                ),
                                                left: BorderSide(
                                                  color: widget
                                                          .outerContainerBorderColor ??
                                                      Colors.grey
                                                          .withOpacity(0.5),
                                                ),
                                                right: BorderSide(
                                                  color: widget
                                                          .outerContainerBorderColor ??
                                                      Colors.grey
                                                          .withOpacity(0.5),
                                                ),
                                              ),
                                            ),
                                        child: RawScrollbar(
                                          controller: widget
                                                  .showedItemsScrollController ??
                                              _showedItemsScrollController,
                                          thumbColor:
                                              widget.showedItemsScrollbarColor,
                                          thickness: widget
                                                  .showedItemsScrollbarMinThumbLength ??
                                              10,
                                          minThumbLength: widget
                                                  .showedItemsScrollbarMinThumbLength ??
                                              30,
                                          minOverscrollLength: widget
                                                  .showedItemsScrollbarMinOverscrollLength ??
                                              5,
                                          radius: widget
                                                  .showedItemsScrollbarRadius ??
                                              const Radius.circular(5),
                                          thumbVisibility:
                                              widget.showShowedItemsScrollbar,
                                          child: ScrollConfiguration(
                                            behavior:
                                                ScrollConfiguration.of(context)
                                                    .copyWith(
                                                        scrollbars: false),
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              controller: widget
                                                      .showedItemsScrollController ??
                                                  _showedItemsScrollController,
                                              physics: widget
                                                  .showedItemsScrollPhysics,
                                              itemBuilder: (context, index) {
                                                if (showedItems.isEmpty) {
                                                  return widget
                                                          .noResultsWidget ??
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: 12.0,
                                                          horizontal: 12,
                                                        ),
                                                        child: Text(
                                                          'No results found',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .grey[400],
                                                          ),
                                                        ),
                                                      );
                                                }
                                                return GestureDetector(
                                                  onTap: () {
                                                    widget.onTapShowedItem
                                                        ?.call();
                                                    final String pickedItem =
                                                        showedItems[index];
                                                    pickedItems.add(pickedItem);
                                                    if (widget
                                                        .sortPickedItems) {
                                                      pickedItems.sort();
                                                    }
                                                    allItems.remove(pickedItem);
                                                    showedItems
                                                        .remove(pickedItem);
                                                    widget.onPickedChange(
                                                        pickedItems);
                                                    widget.onItemAdded
                                                        ?.call(pickedItem);
                                                    setState(() {});
                                                    stateSetter(() {});
                                                  },
                                                  child: MouseRegion(
                                                    cursor: widget
                                                            .showedItemMouseCursor ??
                                                        SystemMouseCursors
                                                            .click,
                                                    child: Padding(
                                                      padding: widget
                                                              .showedItemContainerPadding ??
                                                          EdgeInsets.only(
                                                            right: !widget
                                                                    .showShowedItemsScrollbar
                                                                ? 0
                                                                : 15.0,
                                                            top: 5,
                                                            bottom: 2,
                                                          ),
                                                      child: Container(
                                                        height: widget
                                                                .showedItemContainerHeight ??
                                                            50,
                                                        decoration: widget
                                                                .showedItemContainerDecoration ??
                                                            BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                4,
                                                              ),
                                                              color:
                                                                  Colors.white,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  blurRadius:
                                                                      22,
                                                                  spreadRadius:
                                                                      1,
                                                                  offset:
                                                                      const Offset(
                                                                    1.1,
                                                                    1,
                                                                  ),
                                                                  blurStyle:
                                                                      BlurStyle
                                                                          .inner,
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.3),
                                                                )
                                                              ],
                                                            ),
                                                        child: Padding(
                                                          padding: widget
                                                                  .showedItemContainerContentPadding ??
                                                              const EdgeInsets
                                                                  .only(
                                                                left: 8.0,
                                                              ),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              showedItems[
                                                                  index],
                                                              style: widget
                                                                      .showedItemTextStyle ??
                                                                  const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w100,
                                                                    color: Colors
                                                                        .black,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              itemCount: showedItems.isEmpty
                                                  ? 1
                                                  : showedItems.length,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                    if (widget.showSelectAllButton)
                      ActionButton(
                        text: widget.selectAllText ?? 'Select all',
                        textStyle: widget.selectAllTextStyle,
                        backgroundColor:
                            widget.selectAllBackgroundColor ?? Colors.white,
                        actionButtonAnimationCurve:
                            widget.selectAllAnimationCurve,
                        onHoverBackgroundColor:
                            widget.selectAllOnHoverBackgroundColor ??
                                Colors.blue[300]!,
                        animationDuration: widget.selectAllAnimationDuration ??
                            const Duration(milliseconds: 200),
                        fontSize: widget.selectAllFontSize ?? 13,
                        borderRadius: widget.selectAllBorderRadius ?? 0,
                        onHoverBorderColor:
                            widget.selectAllOnHoverBorderColor ?? Colors.white,
                        borderColor:
                            widget.selectAllBorderColor ?? Colors.blue[300]!,
                        contentPadding: widget.selectAllContentPadding ??
                            const EdgeInsets.all(8),
                        textColor: widget.selectAllTextColor ?? Colors.black,
                        fontWeight:
                            widget.selectAllFontWeight ?? FontWeight.w500,
                        onHoverFontWeight: widget.selectAllOnHoverFontWeight ??
                            FontWeight.w100,
                        onHoverTextColor:
                            widget.selectAllOnHoverTextColor ?? Colors.white,
                        onTap: () {
                          pickedItems.addAll(showedItems);
                          if (widget.sortPickedItems) {
                            pickedItems.sort();
                          }
                          allItems.removeWhere((e) => showedItems.contains(e));

                          showedItems = allItems
                              .where(
                                (p) => p
                                    .toLowerCase()
                                    .contains(_textEditingController.text),
                              )
                              .toList();
                          if (showedItems.isNotEmpty) {
                            if (widget.sortShowedItems) {
                              showedItems.sort();
                            }
                          }

                          widget.onPickedChange(pickedItems);
                          setState(() {});
                        },
                      ),
                  ],
                ),
                if (pickedItems.isNotEmpty && widget.showClearAllButton)
                  ActionButton(
                    text: widget.clearAllText ?? 'Clear',
                    backgroundColor:
                        widget.clearAllBackgroundColor ?? Colors.white,
                    animationDuration: widget.clearAllAnimationDuration ??
                        const Duration(milliseconds: 200),
                    fontSize: widget.clearAllFontSize ?? 13,
                    textStyle:
                        widget.clearAllTextStyle ?? widget.clearAllTextStyle,
                    borderRadius: widget.clearAllBorderRadius ?? 0,
                    actionButtonAnimationCurve: widget.clearAllAnimationCurve,
                    borderColor: widget.clearAllBorderColor ?? Colors.red,
                    contentPadding: widget.clearAllContentPadding ??
                        const EdgeInsets.all(8),
                    textColor: widget.clearAllTextColor ?? Colors.red,
                    fontWeight: widget.clearAllFontWeight ?? FontWeight.w500,
                    onHoverBorderColor:
                        widget.clearAllOnHoverBorderColor ?? Colors.white,
                    onHoverBackgroundColor:
                        widget.clearAllBackgroundColor ?? Colors.red[300]!,
                    onHoverFontWeight:
                        widget.clearAllOnHoverFontWeight ?? FontWeight.w100,
                    onHoverTextColor:
                        widget.clearAllOnHoverTextColor ?? Colors.white,
                    onTap: () {
                      allItems.addAll(pickedItems);
                      showedItems = allItems
                          .where(
                            (p) => p
                                .toLowerCase()
                                .contains(_textEditingController.text),
                          )
                          .toList();
                      if (showedItems.isNotEmpty) {
                        if (widget.sortShowedItems) {
                          showedItems.sort();
                        }
                      }
                      pickedItems.removeRange(0, pickedItems.length);
                      if (widget.sortShowedItems) {
                        allItems.sort();
                      }
                      widget.onPickedChange(pickedItems);
                      setState(() {});
                    },
                  ),
              ],
            )
          ],
          const SizedBox(
            height: 10,
          ),
          if (widget.itemsVisibility != ShowedItemsVisibility.toggle)
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: widget.outerContainerBorderColor ??
                        Colors.grey.withOpacity(0.5),
                  ),
                  left: BorderSide(
                    color: widget.outerContainerBorderColor ??
                        Colors.grey.withOpacity(0.5),
                  ),
                  right: BorderSide(
                    color: widget.outerContainerBorderColor ??
                        Colors.grey.withOpacity(0.5),
                  ),
                  bottom: BorderSide(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
              ),
              child: TextField(
                focusNode: _textFieldFocus,
                controller: _textEditingController,
                style: widget.searchItemTextStyle,
                decoration: widget.searchItemTextInputDecoration ??
                    InputDecoration(
                      contentPadding: widget.searchItemTextContentPadding ??
                          const EdgeInsets.only(left: 6),
                      hintText: widget.hintText ?? 'Type here to search',
                      hintStyle: widget.hintTextStyle ??
                          const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                onChanged: (value) {
                  if (widget.fuzzySearch == FuzzySearch.jaro) {
                    showedItems = allItems.where(
                      (p) {
                        return p.toLowerCase().contains(value) ||
                            (getJaro(p, value) >= 0.8);
                      },
                    ).toList();
                  } else if (widget.fuzzySearch == FuzzySearch.levenshtein) {
                    showedItems = allItems.where(
                      (p) {
                        return p.toLowerCase().contains(value) ||
                            (getLevenshtein(p, value) <= 2);
                      },
                    ).toList();
                  } else {
                    showedItems = allItems
                        .where((p) => p.toLowerCase().contains(value))
                        .toList();
                  }
                  if (widget.itemsVisibility !=
                          ShowedItemsVisibility.alwaysOn &&
                      widget.itemsVisibility != ShowedItemsVisibility.toggle) {
                    expanded = widget.itemsVisibility ==
                            ShowedItemsVisibility.onType &&
                        _textEditingController.text.isNotEmpty;
                  }
                  setState(() {});
                },
              ),
            ),
          if (expanded &&
              widget.itemsVisibility != ShowedItemsVisibility.toggle)
            Container(
              constraints: BoxConstraints(
                maxHeight: widget.maximumShowItemsHeight,
              ),
              decoration: widget.showedItemsBoxDecoration ??
                  BoxDecoration(
                    color: widget.showedItemsBackgroundColor ??
                        Colors.grey.withOpacity(0.1),
                    border: Border(
                      bottom: BorderSide(
                        color: widget.outerContainerBorderColor ??
                            Colors.grey.withOpacity(0.5),
                      ),
                      left: BorderSide(
                        color: widget.outerContainerBorderColor ??
                            Colors.grey.withOpacity(0.5),
                      ),
                      right: BorderSide(
                        color: widget.outerContainerBorderColor ??
                            Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ),
              child: RawScrollbar(
                controller: widget.showedItemsScrollController ??
                    _showedItemsScrollController,
                thumbColor: widget.showedItemsScrollbarColor,
                thickness: widget.showedItemsScrollbarMinThumbLength ?? 10,
                minThumbLength: widget.showedItemsScrollbarMinThumbLength ?? 30,
                minOverscrollLength:
                    widget.showedItemsScrollbarMinOverscrollLength ?? 5,
                radius: widget.showedItemsScrollbarRadius ??
                    const Radius.circular(5),
                thumbVisibility: widget.showShowedItemsScrollbar,
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: widget.showedItemsScrollController ??
                        _showedItemsScrollController,
                    physics: widget.showedItemsScrollPhysics,
                    itemBuilder: (context, index) {
                      if (showedItems.isEmpty) {
                        return widget.noResultsWidget ??
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 12,
                              ),
                              child: Text(
                                'No results found',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[400],
                                ),
                              ),
                            );
                      }
                      return GestureDetector(
                        onTap: () {
                          widget.onTapShowedItem?.call();
                          final String pickedItem = showedItems[index];
                          pickedItems.add(pickedItem);
                          if (widget.sortPickedItems) {
                            pickedItems.sort();
                          }
                          allItems.remove(pickedItem);
                          showedItems.remove(pickedItem);
                          widget.onPickedChange(pickedItems);
                          widget.onItemAdded?.call(pickedItem);
                          setState(() {});
                        },
                        child: MouseRegion(
                          cursor: widget.showedItemMouseCursor ??
                              SystemMouseCursors.click,
                          child: Padding(
                            padding: widget.showedItemContainerPadding ??
                                EdgeInsets.only(
                                  right: !widget.showShowedItemsScrollbar
                                      ? 0
                                      : 15.0,
                                  top: 5,
                                  bottom: 2,
                                ),
                            child: Container(
                              height: widget.showedItemContainerHeight ?? 50,
                              decoration:
                                  widget.showedItemContainerDecoration ??
                                      BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 22,
                                            spreadRadius: 1,
                                            offset: const Offset(1.1, 1),
                                            blurStyle: BlurStyle.inner,
                                            color: Colors.grey.withOpacity(0.3),
                                          )
                                        ],
                                      ),
                              child: Padding(
                                padding:
                                    widget.showedItemContainerContentPadding ??
                                        const EdgeInsets.only(left: 8.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    showedItems[index],
                                    style: widget.showedItemTextStyle ??
                                        const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w100,
                                          color: Colors.black,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: showedItems.isEmpty ? 1 : showedItems.length,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
