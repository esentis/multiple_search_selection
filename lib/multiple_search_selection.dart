library multiple_search_selection;

import 'package:flutter/material.dart';
import 'package:multiple_search_selection/helpers/create_options.dart';
import 'package:multiple_search_selection/helpers/jaro.dart';
import 'package:multiple_search_selection/helpers/levenshtein.dart';

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

class MultipleSearchSelection<T> extends StatefulWidget {
  // Default constructor
  factory MultipleSearchSelection({
    required List<T> items,
    required Widget Function(T) pickedItemBuilder,
    required String Function(T) fieldToCheck,
    required Widget Function(T) itemBuilder,
    void Function(T)? onItemRemoved,
    void Function(T)? onItemAdded,
    void Function(List<T>)? onPickedChange,
    Key? key,
    FuzzySearch? fuzzySearch,
    double? maximumShowItemsHeight,
    ShowedItemsVisibility? itemsVisibility,
    List<T>? initialPickedItems,
    Widget? title,
    Color? pickedItemsBorderColor,
    Color? outerContainerBorderColor,
    Color? showedItemsScrollbarColor,
    Color? showedItemsBackgroundColor,
    double? showedItemsScrollbarMinThumbLength,
    double? showedItemsScrollbarMinOverscrollLength,
    Radius? showedItemsScrollbarRadius,
    double? showedItemContainerHeight,
    EdgeInsets? showedItemContainerPadding,
    bool? showShowedItemsScrollbar,
    bool? showSelectAllButton,
    bool? showClearAllButton,
    InputDecoration? searchFieldInputDecoration,
    TextStyle? searchFieldTextStyle,
    Widget? noResultsWidget,
    double? pickedItemSpacing,
    double? pickedItemsContainerMaxHeight,
    double? pickedItemsContainerMinHeight,
    Color? pickedItemsScrollbarColor,
    double? pickedItemsScrollbarThickness,
    double? pickedItemsScrollbarMinOverscrollLength,
    Radius? pickedItemsScrollbarRadius,
    double? pickedItemsScrollbarMinThumbLength,
    BoxDecoration? pickedItemsBoxDecoration,
    bool? showPickedItemScrollbar,
    VoidCallback? onTapShowedItem,
    ScrollController? pickedItemsScrollController,
    ScrollController? showedItemsScrollController,
    ScrollPhysics? pickedItemsScrollPhysics,
    ScrollPhysics? showedItemsScrollPhysics,
    BoxDecoration? showedItemsBoxDecoration,
    bool? sortPickedItems,
    bool? sortShowedItems,
    bool? clearSearchFieldOnSelect,
    Widget? showItemsButton,
    VoidCallback? onTapShowItems,
    Widget? selectAllButton,
    VoidCallback? onTapSelectAll,
    Widget? clearAllButton,
    VoidCallback? onTapClearAll,
    bool? caseSensitiveSearch,
  }) =>
      MultipleSearchSelection._(
        items: items,
        title: title,
        isCreatable: false,
        key: key ?? ValueKey(items.hashCode),
        clearSearchFieldOnSelect: clearSearchFieldOnSelect ?? false,
        fieldToCheck: fieldToCheck,
        itemBuilder: itemBuilder,
        onPickedChange: onPickedChange,
        pickedItemBuilder: pickedItemBuilder,
        clearAllButton: clearAllButton,
        fuzzySearch: fuzzySearch ?? FuzzySearch.none,
        initialPickedItems: initialPickedItems,
        itemsVisibility: itemsVisibility ?? ShowedItemsVisibility.alwaysOn,
        maximumShowItemsHeight: maximumShowItemsHeight ?? 150,
        noResultsWidget: noResultsWidget,
        onItemAdded: onItemAdded,
        onItemRemoved: onItemRemoved,
        onTapClearAll: onTapClearAll,
        onTapSelectAll: onTapSelectAll,
        onTapShowItems: onTapShowItems,
        onTapShowedItem: onTapShowedItem,
        outerContainerBorderColor: outerContainerBorderColor,
        pickedItemSpacing: pickedItemSpacing,
        pickedItemsBorderColor: pickedItemsBorderColor,
        pickedItemsBoxDecoration: pickedItemsBoxDecoration,
        pickedItemsContainerMaxHeight: pickedItemsContainerMaxHeight,
        pickedItemsContainerMinHeight: pickedItemsContainerMinHeight,
        pickedItemsScrollController: pickedItemsScrollController,
        pickedItemsScrollPhysics: pickedItemsScrollPhysics,
        pickedItemsScrollbarColor: pickedItemsScrollbarColor,
        pickedItemsScrollbarMinOverscrollLength:
            pickedItemsScrollbarMinOverscrollLength,
        pickedItemsScrollbarMinThumbLength: pickedItemsScrollbarMinThumbLength,
        pickedItemsScrollbarRadius: pickedItemsScrollbarRadius,
        pickedItemsScrollbarThickness: pickedItemsScrollbarThickness,
        searchFieldInputDecoration: searchFieldInputDecoration,
        searchFieldTextStyle: searchFieldTextStyle,
        selectAllButton: selectAllButton,
        showClearAllButton: showClearAllButton,
        showItemsButton: showItemsButton,
        showPickedItemScrollbar: showPickedItemScrollbar,
        showSelectAllButton: showSelectAllButton,
        showShowedItemsScrollbar: showShowedItemsScrollbar,
        showedItemContainerHeight: showedItemContainerHeight,
        showedItemContainerPadding: showedItemContainerPadding,
        showedItemsBackgroundColor: showedItemsBackgroundColor,
        showedItemsBoxDecoration: showedItemsBoxDecoration,
        showedItemsScrollController: showedItemsScrollController,
        showedItemsScrollPhysics: showedItemsScrollPhysics,
        showedItemsScrollbarColor: showedItemsScrollbarColor,
        showedItemsScrollbarMinOverscrollLength:
            showedItemsScrollbarMinOverscrollLength,
        showedItemsScrollbarMinThumbLength: showedItemsScrollbarMinThumbLength,
        showedItemsScrollbarRadius: showedItemsScrollbarRadius,
        sortPickedItems: sortPickedItems ?? false,
        sortShowedItems: sortShowedItems ?? false,
        caseSensitiveSearch: caseSensitiveSearch ?? false,
      );

  /// [MultipleSearchSelection.creatable] constructor provides a way to add a new item in your list,
  ///
  /// after search doesn't return any results. You can pass
  factory MultipleSearchSelection.creatable({
    required List<T> items,
    required Widget Function(T) pickedItemBuilder,
    required String Function(T) fieldToCheck,
    required Widget Function(T) itemBuilder,
    required CreateOptions<T> createOptions,
    void Function(T)? onItemRemoved,
    void Function(T)? onItemAdded,
    Function(List<T>)? onPickedChange,
    Key? key,
    FuzzySearch? fuzzySearch,
    double? maximumShowItemsHeight,
    ShowedItemsVisibility? itemsVisibility,
    List<T>? initialPickedItems,
    Widget? title,
    Color? pickedItemsBorderColor,
    Color? outerContainerBorderColor,
    Color? showedItemsScrollbarColor,
    Color? showedItemsBackgroundColor,
    double? showedItemsScrollbarMinThumbLength,
    double? showedItemsScrollbarMinOverscrollLength,
    Radius? showedItemsScrollbarRadius,
    double? showedItemContainerHeight,
    EdgeInsets? showedItemContainerPadding,
    bool? showShowedItemsScrollbar,
    bool? showSelectAllButton,
    bool? showClearAllButton,
    InputDecoration? searchFieldInputDecoration,
    TextStyle? searchFieldTextStyle,
    double? pickedItemSpacing,
    double? pickedItemsContainerMaxHeight,
    double? pickedItemsContainerMinHeight,
    Color? pickedItemsScrollbarColor,
    double? pickedItemsScrollbarThickness,
    double? pickedItemsScrollbarMinOverscrollLength,
    Radius? pickedItemsScrollbarRadius,
    double? pickedItemsScrollbarMinThumbLength,
    BoxDecoration? pickedItemsBoxDecoration,
    bool? showPickedItemScrollbar,
    VoidCallback? onTapShowedItem,
    ScrollController? pickedItemsScrollController,
    ScrollController? showedItemsScrollController,
    ScrollPhysics? pickedItemsScrollPhysics,
    ScrollPhysics? showedItemsScrollPhysics,
    BoxDecoration? showedItemsBoxDecoration,
    bool? sortPickedItems,
    bool? sortShowedItems,
    bool? clearSearchFieldOnSelect,
    Widget? showItemsButton,
    VoidCallback? onTapShowItems,
    Widget? selectAllButton,
    VoidCallback? onTapSelectAll,
    Widget? clearAllButton,
    VoidCallback? onTapClearAll,
    bool? caseSensitiveSearch,
  }) =>
      MultipleSearchSelection._(
        items: items,
        title: title,
        isCreatable: true,
        createOptions: createOptions,
        key: key ?? ValueKey(items.hashCode),
        clearSearchFieldOnSelect: clearSearchFieldOnSelect ?? false,
        fieldToCheck: fieldToCheck,
        itemBuilder: itemBuilder,
        onPickedChange: onPickedChange,
        pickedItemBuilder: pickedItemBuilder,
        clearAllButton: clearAllButton,
        fuzzySearch: fuzzySearch ?? FuzzySearch.none,
        initialPickedItems: initialPickedItems,
        itemsVisibility: itemsVisibility ?? ShowedItemsVisibility.alwaysOn,
        maximumShowItemsHeight: maximumShowItemsHeight ?? 150,
        onItemAdded: onItemAdded,
        onItemRemoved: onItemRemoved,
        onTapClearAll: onTapClearAll,
        onTapSelectAll: onTapSelectAll,
        onTapShowItems: onTapShowItems,
        onTapShowedItem: onTapShowedItem,
        outerContainerBorderColor: outerContainerBorderColor,
        pickedItemSpacing: pickedItemSpacing,
        pickedItemsBorderColor: pickedItemsBorderColor,
        pickedItemsBoxDecoration: pickedItemsBoxDecoration,
        pickedItemsContainerMaxHeight: pickedItemsContainerMaxHeight,
        pickedItemsContainerMinHeight: pickedItemsContainerMinHeight,
        pickedItemsScrollController: pickedItemsScrollController,
        pickedItemsScrollPhysics: pickedItemsScrollPhysics,
        pickedItemsScrollbarColor: pickedItemsScrollbarColor,
        pickedItemsScrollbarMinOverscrollLength:
            pickedItemsScrollbarMinOverscrollLength,
        pickedItemsScrollbarMinThumbLength: pickedItemsScrollbarMinThumbLength,
        pickedItemsScrollbarRadius: pickedItemsScrollbarRadius,
        pickedItemsScrollbarThickness: pickedItemsScrollbarThickness,
        searchFieldInputDecoration: searchFieldInputDecoration,
        searchFieldTextStyle: searchFieldTextStyle,
        selectAllButton: selectAllButton,
        showClearAllButton: showClearAllButton,
        showItemsButton: showItemsButton,
        showPickedItemScrollbar: showPickedItemScrollbar,
        showSelectAllButton: showSelectAllButton,
        showShowedItemsScrollbar: showShowedItemsScrollbar,
        showedItemContainerHeight: showedItemContainerHeight,
        showedItemContainerPadding: showedItemContainerPadding,
        showedItemsBackgroundColor: showedItemsBackgroundColor,
        showedItemsBoxDecoration: showedItemsBoxDecoration,
        showedItemsScrollController: showedItemsScrollController,
        showedItemsScrollPhysics: showedItemsScrollPhysics,
        showedItemsScrollbarColor: showedItemsScrollbarColor,
        showedItemsScrollbarMinOverscrollLength:
            showedItemsScrollbarMinOverscrollLength,
        showedItemsScrollbarMinThumbLength: showedItemsScrollbarMinThumbLength,
        showedItemsScrollbarRadius: showedItemsScrollbarRadius,
        sortPickedItems: sortPickedItems ?? false,
        sortShowedItems: sortShowedItems ?? false,
        caseSensitiveSearch: caseSensitiveSearch ?? false,
      );

  const MultipleSearchSelection._({
    required this.fieldToCheck,
    required this.itemBuilder,
    required this.pickedItemBuilder,
    required this.isCreatable,
    super.key,
    this.onPickedChange,
    this.createOptions,
    this.items,
    this.initialPickedItems,
    this.fuzzySearch = FuzzySearch.none,
    this.onItemAdded,
    this.onItemRemoved,
    this.onTapShowedItem,
    this.title,
    this.maximumShowItemsHeight = 150,
    this.showClearAllButton = true,
    this.showSelectAllButton = true,
    this.sortPickedItems = false,
    this.sortShowedItems = false,
    this.showShowedItemsScrollbar = true,
    this.showPickedItemScrollbar = true,
    this.showedItemsScrollbarColor,
    this.showedItemsScrollbarMinOverscrollLength,
    this.showedItemsScrollbarMinThumbLength,
    this.showedItemsScrollbarRadius,
    this.showedItemContainerHeight,
    this.showedItemContainerPadding,
    this.showedItemsBackgroundColor,
    this.showedItemsScrollController,
    this.showedItemsScrollPhysics,
    this.showedItemsBoxDecoration,
    this.searchFieldInputDecoration,
    this.noResultsWidget,
    this.outerContainerBorderColor,
    this.itemsVisibility = ShowedItemsVisibility.alwaysOn,
    this.pickedItemsBorderColor,
    this.pickedItemSpacing,
    this.pickedItemsContainerMaxHeight,
    this.pickedItemsContainerMinHeight,
    this.pickedItemsScrollbarColor,
    this.pickedItemsScrollbarThickness,
    this.pickedItemsScrollbarMinOverscrollLength,
    this.pickedItemsScrollbarRadius,
    this.pickedItemsScrollbarMinThumbLength,
    this.pickedItemsScrollController,
    this.pickedItemsScrollPhysics,
    this.pickedItemsBoxDecoration,
    this.showItemsButton,
    this.selectAllButton,
    this.clearAllButton,
    this.searchFieldTextStyle,
    this.onTapClearAll,
    this.onTapSelectAll,
    this.onTapShowItems,
    this.clearSearchFieldOnSelect,
    this.caseSensitiveSearch = false,
  });

  /// The title widget on top of the picked items.
  final Widget? title;

  /// The border color of the picked items container.
  final Color? pickedItemsBorderColor;

  /// The border color of the container that includes the search text field and  the showed items.
  final Color? outerContainerBorderColor;

  /// The maximum height constraints of the items' container.
  final double maximumShowItemsHeight;

  /// The list of items (T) to search and select.
  final List<T>? items;

  /// The list of initial picked items.
  final List<T>? initialPickedItems;

  /// The thumb color of the items' scrollbar.
  final Color? showedItemsScrollbarColor;

  /// The background color of the container holding all the items.
  final Color? showedItemsBackgroundColor;

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

  /// Hide or show items' scrollbar, defaults to [true].
  final bool? showShowedItemsScrollbar;

  /// Hide or show select all button, defaults to [true].
  final bool? showSelectAllButton;

  /// Hide or show clear all button, defaults to [true].
  final bool? showClearAllButton;

  /// Whether to clear the searchfield and reset the showed items when you pick an item. Defaults to [false].
  final bool? clearSearchFieldOnSelect;

  /// A callback when user selects or deselects an item. Always returns the currently picked items.
  final Function(List<T>)? onPickedChange;

  /// A callback when an item is removed, returns the item aswell.
  final Function(T)? onItemRemoved;

  /// A callback when an item is added, returns the item aswell.
  final Function(T)? onItemAdded;

  /// The input decoration of the search text field.
  final InputDecoration? searchFieldInputDecoration;

  /// The text style of the search text field.
  final TextStyle? searchFieldTextStyle;

  /// What is shown when there are no more results to select.
  final Widget? noResultsWidget;

  /// The spacing of the picked item. Defaults to 5.
  final double? pickedItemSpacing;

  /// The maximum height of which the picked items container can extend. Defaults to 150 pixels.
  final double? pickedItemsContainerMaxHeight;

  /// The minimum height of which the picked items container can extend. Defaults to 50 pixels.
  final double? pickedItemsContainerMinHeight;

  /// The thumb color of the picked items' scrollbar.
  final Color? pickedItemsScrollbarColor;

  /// The thickness of the picked items' scrollbar thumb.
  final double? pickedItemsScrollbarThickness;

  /// The minimum length of the overscroll for picked items.
  final double? pickedItemsScrollbarMinOverscrollLength;

  /// The radius of the picked items' scrollbar.
  final Radius? pickedItemsScrollbarRadius;

  /// The minimum length of the picked items' scrollbar thumb.
  final double? pickedItemsScrollbarMinThumbLength;

  /// The [BoxDecoration] of the picked items container.
  final BoxDecoration? pickedItemsBoxDecoration;

  /// Hide or show picked items' scrollbar, defaults to [true].
  final bool? showPickedItemScrollbar;

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
  final ShowedItemsVisibility? itemsVisibility;

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
  final FuzzySearch? fuzzySearch;

  /// This is the builder of picked items.
  final Widget Function(T) pickedItemBuilder;

  /// This is the field to check when searching & sorting the List<T>.
  ///
  /// ### Example
  ///
  /// If we work with `List<Country>`, where Country is
  /// ```dart
  /// class Country {
  ///   String name;
  ///   Srtring iso;
  /// }
  /// ```
  ///
  /// and you want to search by name then you can do
  ///
  /// ```dart
  /// fieldToCheck: (country) {
  ///   return c.name;
  ///}
  /// ```
  ///
  /// If we work with `List<String>` then
  /// ```dart
  /// fieldToCheck: (country) {
  ///   return country;
  ///}
  /// ```
  final String Function(T) fieldToCheck;

  /// This is the builder of showed items.
  final Widget Function(T) itemBuilder;

  /// The toggle items button when [itemsVisibility] == [ShowedItemsVisibility.toggle]. Ontap logic is already defined and you can't override it with
  ///
  /// a widget that has onTap, e.g [TextButton]. If you want to do something when you tap the button
  ///
  /// you can use the [onTapShowItems] callback.
  final Widget? showItemsButton;

  /// A callback when the select all button is pressed.
  final VoidCallback? onTapShowItems;

  /// The select all button widget. Ontap logic is already defined and you can't override it with
  ///
  /// a widget that has onTap, e.g [TextButton]. If you want to do something when you tap the button
  ///
  /// you can use the [onTapSelectAll] callback.
  final Widget? selectAllButton;

  /// A callback when the select all button is pressed.
  final VoidCallback? onTapSelectAll;

  /// The clear all selected items button widget. Ontap logic is already defined and you can't override it with
  ///
  /// a widget that has onTap, e.g [TextButton]. If you want to do something when you tap the button
  ///
  /// you can use the [onTapClearAll] callback.
  final Widget? clearAllButton;

  /// A callback when the clear all button is pressed.
  final VoidCallback? onTapClearAll;

  /// Whether the widget is createable style.
  final bool isCreatable;

  /// The [CreateOptions] of the creatable widget.
  final CreateOptions<T>? createOptions;

  /// Whether the search is case sensitive. Defaults to [false].
  final bool caseSensitiveSearch;

  @override
  _MultipleSearchSelectionState<T> createState() =>
      _MultipleSearchSelectionState<T>();
}

class _MultipleSearchSelectionState<T>
    extends State<MultipleSearchSelection<T>> {
  late List<T> showedItems;
  late List<T> allItems;

  bool expanded = false;

  List<T> pickedItems = [];
  final ScrollController _pickedItemsController = ScrollController();
  final ScrollController _showedItemsScrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();

  final FocusNode _textFieldFocus = FocusNode();

  Future<void> _prepareItems() async {
    showedItems = [...widget.items ?? []];
    allItems = [...widget.items ?? []];

    if (widget.sortShowedItems) {
      showedItems.sort(
        (a, b) => widget.fieldToCheck(a).compareTo(
              widget.fieldToCheck(b),
            ),
      );
      allItems.sort(
        (a, b) => widget.fieldToCheck(a).compareTo(
              widget.fieldToCheck(b),
            ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _prepareItems();

    expanded = widget.itemsVisibility == ShowedItemsVisibility.alwaysOn;

    pickedItems.addAll(widget.initialPickedItems ?? []);
  }

  List<T> _searchAllItems(String query) {
    final q = widget.caseSensitiveSearch ? query : query.toLowerCase();

    return allItems.where((item) {
      final i = widget.caseSensitiveSearch
          ? widget.fieldToCheck(item)
          : widget.fieldToCheck(item).toLowerCase();
      bool matches = i.contains(q);

      if (widget.fuzzySearch != FuzzySearch.none) {
        if (widget.fuzzySearch == FuzzySearch.jaro) {
          matches |= getJaro(
                widget.fieldToCheck(item),
                query,
                caseSensitive: widget.caseSensitiveSearch,
              ) >=
              0.8;
        } else if (widget.fuzzySearch == FuzzySearch.levenshtein) {
          matches |= getLevenshtein(
                widget.fieldToCheck(item),
                query,
                caseSensitive: widget.caseSensitiveSearch,
              ) <=
              2;
        }
      }

      return matches;
    }).toList();
  }

  void _onRemoveItem(T item) {
    pickedItems.remove(item);
    allItems.add(item);
    if (widget.sortShowedItems) {
      allItems.sort(
        (a, b) => widget.fieldToCheck(a).compareTo(
              widget.fieldToCheck(b),
            ),
      );
    }
    showedItems = _searchAllItems(
      _textEditingController.text,
    );

    widget.onPickedChange?.call(pickedItems);
    widget.onItemRemoved?.call(item);
    setState(() {});
    widget.onItemRemoved?.call(item);
  }

  void _onAddItem(T item) {
    widget.onTapShowedItem?.call();
    final T pickedItem = item;
    pickedItems.add(pickedItem);
    if (widget.sortPickedItems) {
      pickedItems.sort(
        (a, b) => widget.fieldToCheck(a).compareTo(
              widget.fieldToCheck(b),
            ),
      );
    }
    allItems.remove(pickedItem);
    showedItems.remove(pickedItem);
    widget.onPickedChange?.call(
      pickedItems,
    );
    widget.onItemAdded?.call(pickedItem);
  }

  void _onCreateItem() {
    final T itemToAdd =
        widget.createOptions!.createItem(_textEditingController.text);
    if (widget.createOptions!.pickCreatedItem) {
      pickedItems.add(itemToAdd);
      widget.onPickedChange?.call(
        pickedItems,
      );
      widget.onItemAdded?.call(itemToAdd);
      widget.createOptions!.onItemCreated?.call(itemToAdd);
    } else {
      allItems.add(itemToAdd);
    }

    _textEditingController.clear();
    showedItems = allItems;
    setState(() {});
  }

  void _selectAllItems() {
    pickedItems.addAll(showedItems);
    if (widget.sortPickedItems) {
      pickedItems.sort(
        (a, b) => widget.fieldToCheck(a).compareTo(
              widget.fieldToCheck(b),
            ),
      );
    }
    allItems.removeWhere((e) => showedItems.contains(e));

    showedItems = _searchAllItems(_textEditingController.text);
    if (showedItems.isNotEmpty) {
      if (widget.sortShowedItems) {
        showedItems.sort(
          (a, b) => widget.fieldToCheck(a).compareTo(
                widget.fieldToCheck(b),
              ),
        );
      }
    }

    widget.onPickedChange?.call(pickedItems);
    widget.onTapSelectAll?.call();
    setState(() {});
  }

  void _clearAllPickedItems() {
    allItems.addAll(pickedItems);
    showedItems = _searchAllItems(_textEditingController.text);
    if (showedItems.isNotEmpty) {
      if (widget.sortShowedItems) {
        showedItems.sort(
          (a, b) => widget.fieldToCheck(a).compareTo(
                widget.fieldToCheck(b),
              ),
        );
      }
    }
    pickedItems.removeRange(0, pickedItems.length);
    if (widget.sortShowedItems) {
      allItems.sort(
        (a, b) => widget.fieldToCheck(a).compareTo(
              widget.fieldToCheck(b),
            ),
      );
    }
    widget.onPickedChange?.call(pickedItems);
    widget.onTapClearAll?.call();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          widget.title!,
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
              thumbColor: widget.pickedItemsScrollbarColor,
              minOverscrollLength:
                  widget.pickedItemsScrollbarMinOverscrollLength ?? 5,
              minThumbLength: widget.pickedItemsScrollbarMinThumbLength ?? 30,
              thickness: widget.pickedItemsScrollbarThickness ?? 10,
              radius:
                  widget.pickedItemsScrollbarRadius ?? const Radius.circular(5),
              controller:
                  widget.pickedItemsScrollController ?? _pickedItemsController,
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
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
                          (e) => GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              _onRemoveItem(e);
                            },
                            child: IgnorePointer(
                              child: widget.pickedItemBuilder.call(e),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        if ((widget.showClearAllButton ?? true) ||
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
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        widget.onTapShowItems?.call();
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
                                            color: Colors.grey.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      child: TextField(
                                        key: const Key('toggle-searchfield'),
                                        focusNode: _textFieldFocus,
                                        controller: _textEditingController,
                                        style: widget.searchFieldTextStyle,
                                        decoration: widget
                                                .searchFieldInputDecoration ??
                                            InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                left: 6,
                                              ),
                                              hintText: 'Type here to search',
                                              hintStyle: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                        onChanged: (value) {
                                          showedItems = _searchAllItems(value);
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
                                        radius:
                                            widget.showedItemsScrollbarRadius ??
                                                const Radius.circular(5),
                                        thumbVisibility:
                                            widget.showShowedItemsScrollbar,
                                        child: ScrollConfiguration(
                                          behavior:
                                              ScrollConfiguration.of(context)
                                                  .copyWith(
                                            scrollbars: false,
                                          ),
                                          child: ListView(
                                            padding: EdgeInsets.zero,
                                            primary: false,
                                            shrinkWrap: true,
                                            controller: widget
                                                    .showedItemsScrollController ??
                                                _showedItemsScrollController,
                                            children: showedItems.isEmpty
                                                ? [
                                                    if (widget.isCreatable)
                                                      GestureDetector(
                                                        onTap: () {
                                                          _onCreateItem();
                                                          stateSetter(() {});
                                                        },
                                                        child: AbsorbPointer(
                                                          child: widget
                                                              .createOptions!
                                                              .createItemBuilder(
                                                            _textEditingController
                                                                .text,
                                                          ),
                                                        ),
                                                      )
                                                    else
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(
                                                          6.0,
                                                        ),
                                                        child: widget
                                                                .noResultsWidget ??
                                                            const Text(
                                                              'No results',
                                                            ),
                                                      )
                                                  ]
                                                : showedItems.map((T item) {
                                                    return GestureDetector(
                                                      behavior: HitTestBehavior
                                                          .opaque,
                                                      onTap: () {
                                                        _onAddItem(item);
                                                        if (widget
                                                                .clearSearchFieldOnSelect ??
                                                            false) {
                                                          _textEditingController
                                                              .clear();
                                                          showedItems =
                                                              allItems;
                                                        }

                                                        stateSetter(() {});
                                                        setState(() {});
                                                      },
                                                      child: IgnorePointer(
                                                        child:
                                                            widget.itemBuilder(
                                                          item,
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ).whenComplete(() {
                          _textEditingController.clear();
                          showedItems = allItems;
                        });
                      },
                      child: IgnorePointer(
                        child:
                            widget.showItemsButton ?? const Text('Show items'),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                  if (widget.showSelectAllButton ?? true)
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: _selectAllItems,
                      child: IgnorePointer(
                        child:
                            widget.selectAllButton ?? const Text('Select all'),
                      ),
                    ),
                ],
              ),
              if (pickedItems.isNotEmpty && (widget.showClearAllButton ?? true))
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _clearAllPickedItems,
                  child: IgnorePointer(
                    child: widget.clearAllButton ?? const Text('Clear all'),
                  ),
                )
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
              key: const Key('searchfield'),
              focusNode: _textFieldFocus,
              controller: _textEditingController,
              style: widget.searchFieldTextStyle,
              decoration: widget.searchFieldInputDecoration ??
                  InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 6),
                    hintText: 'Type here to search',
                    hintStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
              onChanged: (value) {
                showedItems = _searchAllItems(value);
                if (widget.itemsVisibility == ShowedItemsVisibility.onType) {
                  expanded =
                      widget.itemsVisibility == ShowedItemsVisibility.onType &&
                          _textEditingController.text.isNotEmpty;
                }
                setState(() {});
              },
            ),
          ),
        if (expanded && widget.itemsVisibility != ShowedItemsVisibility.toggle)
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
              radius:
                  widget.showedItemsScrollbarRadius ?? const Radius.circular(5),
              thumbVisibility: widget.showShowedItemsScrollbar,
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: ListView(
                  padding: EdgeInsets.zero,
                  primary: false,
                  shrinkWrap: true,
                  controller: widget.showedItemsScrollController ??
                      _showedItemsScrollController,
                  children: showedItems.isEmpty
                      ? [
                          if (widget.isCreatable)
                            GestureDetector(
                              onTap: _onCreateItem,
                              child: AbsorbPointer(
                                child: widget.createOptions!.createItemBuilder(
                                  _textEditingController.text,
                                ),
                              ),
                            )
                          else
                            Padding(
                              padding: const EdgeInsets.all(
                                6.0,
                              ),
                              child: widget.noResultsWidget ??
                                  const Text(
                                    'No results',
                                  ),
                            )
                        ]
                      : showedItems.map((T item) {
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              _onAddItem(item);
                              if (widget.clearSearchFieldOnSelect ?? false) {
                                _textEditingController.clear();
                                showedItems = allItems;
                              }

                              setState(() {});
                            },
                            child: IgnorePointer(
                              child: widget.itemBuilder(
                                item,
                              ),
                            ),
                          );
                        }).toList(),
                ),
              ),
            ),
          )
      ],
    );
  }
}
