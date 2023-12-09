/// A highly customizable multiple selection widget with fuzzy search functionality
library multiple_search_selection;

import 'package:flutter/material.dart';
import 'package:multiple_search_selection/createable/create_options.dart';
import 'package:multiple_search_selection/helpers/jaro.dart';
import 'package:multiple_search_selection/helpers/levenshtein.dart';
import 'package:multiple_search_selection/overlay/overlay_options.dart';

/// This is the controller for the [MultipleSearchSelection].
///
/// Use this controller to :
///
/// 1. getAllItems
/// 2. getPickedItems
/// 3. searchItems
/// 4. clearSearchField
/// 5. clearAllPickedItems
/// 6. selectAllItems
class MultipleSearchController<T> {
  /// Call this function to get the items in the list.
  late List<T> Function() getAllItems;

  /// Call this function to get the picked items in the list.
  late List<T> Function() getPickedItems;

  /// Call this function to search the items in the list.
  late List<T> Function(String term) searchItems;

  /// Call this function to clear the search field.
  late void Function() clearSearchField;

  /// Call this function to clear the picked items.
  late void Function() clearAllPickedItems;

  /// Call this function to select all the items.
  late void Function() selectAllItems;

  MultipleSearchController();
}

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
    required TextField searchField,
    required List<T> items,
    required Widget Function(T) pickedItemBuilder,
    required String Function(T) fieldToCheck,
    required Widget Function(T, int) itemBuilder,
    void Function(T)? onItemRemoved,
    void Function(T)? onItemAdded,
    void Function(List<T>)? onPickedChange,
    Widget Function(List<Widget> pickedItems)? pickedItemsContainerBuilder,
    Key? key,
    FuzzySearch? fuzzySearch,
    double? maximumShowItemsHeight,
    ShowedItemsVisibility? itemsVisibility,
    List<T>? initialPickedItems,
    Widget? title,
    double? showedItemsScrollbarMinThumbLength,
    Color? showedItemsScrollbarColor,
    double? showedItemsScrollbarMinOverscrollLength,
    Radius? showedItemsScrollbarRadius,
    double? showedItemContainerHeight,
    EdgeInsets? showedItemContainerPadding,
    bool? showShowedItemsScrollbar,
    bool? showSelectAllButton,
    bool? showClearAllButton,
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
    FocusNode? searchFieldFocus,
    String hintText = 'Type here to search',
    double? showedItemExtent,
    int? maxSelectedItems,
    bool? placePickedItemContainerBelow,
    MultipleSearchController? controller,
    Function(String)? onSearchChanged,
  }) =>
      MultipleSearchSelection._(
        items: items,
        title: title,
        maxSelectedItems: maxSelectedItems,
        isCreatable: false,
        isOverlay: false,
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
        pickedItemSpacing: pickedItemSpacing,
        pickedItemsBoxDecoration: pickedItemsBoxDecoration,
        pickedItemsContainerMaxHeight: pickedItemsContainerMaxHeight,
        pickedItemsContainerMinHeight: pickedItemsContainerMinHeight,
        pickedItemsScrollController:
            pickedItemsScrollController ?? ScrollController(),
        pickedItemsScrollPhysics: pickedItemsScrollPhysics,
        pickedItemsScrollbarColor: pickedItemsScrollbarColor,
        pickedItemsScrollbarMinOverscrollLength:
            pickedItemsScrollbarMinOverscrollLength,
        pickedItemsScrollbarMinThumbLength: pickedItemsScrollbarMinThumbLength,
        pickedItemsScrollbarRadius: pickedItemsScrollbarRadius,
        pickedItemsScrollbarThickness: pickedItemsScrollbarThickness,
        selectAllButton: selectAllButton,
        showClearAllButton: showClearAllButton,
        showItemsButton: showItemsButton,
        showPickedItemScrollbar: showPickedItemScrollbar,
        showSelectAllButton: showSelectAllButton,
        showShowedItemsScrollbar: showShowedItemsScrollbar,
        showedItemContainerHeight: showedItemContainerHeight,
        showedItemContainerPadding: showedItemContainerPadding,
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
        pickedItemsContainerBuilder: pickedItemsContainerBuilder,
        hintText: hintText,
        showedItemExtent: showedItemExtent,
        placePickedItemContainerBelow: placePickedItemContainerBelow ?? false,
        controller: controller,
        searchField: searchField,
        onSearchChanged: onSearchChanged,
      );

  /// [MultipleSearchSelection.creatable] constructor provides a way to add a new item in your list,
  ///
  /// after search doesn't return any results. You can pass
  factory MultipleSearchSelection.creatable({
    required TextField searchField,
    required List<T> items,
    required Widget Function(T) pickedItemBuilder,
    required String Function(T) fieldToCheck,
    required Widget Function(T, int) itemBuilder,
    required CreateOptions<T> createOptions,
    Widget Function(List<Widget> pickedItems)? pickedItemsContainerBuilder,
    void Function(T)? onItemRemoved,
    void Function(T)? onItemAdded,
    Function(List<T>)? onPickedChange,
    Key? key,
    FuzzySearch? fuzzySearch,
    double? maximumShowItemsHeight,
    ShowedItemsVisibility? itemsVisibility,
    List<T>? initialPickedItems,
    Widget? title,
    Color? showedItemsScrollbarColor,
    double? showedItemsScrollbarMinThumbLength,
    double? showedItemsScrollbarMinOverscrollLength,
    Radius? showedItemsScrollbarRadius,
    double? showedItemContainerHeight,
    EdgeInsets? showedItemContainerPadding,
    bool? showShowedItemsScrollbar,
    bool? showSelectAllButton,
    bool? showClearAllButton,
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
    String hintText = 'Type here to search',
    double? showedItemExtent,
    int? maxSelectedItems,
    bool? placePickedItemContainerBelow,
    MultipleSearchController? controller,
    Function(String)? onSearchChanged,
  }) =>
      MultipleSearchSelection._(
        searchField: searchField,
        items: items,
        title: title,
        maxSelectedItems: maxSelectedItems,
        isCreatable: true,
        createOptions: createOptions,
        isOverlay: false,
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
        pickedItemSpacing: pickedItemSpacing,
        pickedItemsBoxDecoration: pickedItemsBoxDecoration,
        pickedItemsContainerMaxHeight: pickedItemsContainerMaxHeight,
        pickedItemsContainerMinHeight: pickedItemsContainerMinHeight,
        pickedItemsScrollController:
            pickedItemsScrollController ?? ScrollController(),
        pickedItemsScrollPhysics: pickedItemsScrollPhysics,
        pickedItemsScrollbarColor: pickedItemsScrollbarColor,
        pickedItemsScrollbarMinOverscrollLength:
            pickedItemsScrollbarMinOverscrollLength,
        pickedItemsScrollbarMinThumbLength: pickedItemsScrollbarMinThumbLength,
        pickedItemsScrollbarRadius: pickedItemsScrollbarRadius,
        pickedItemsScrollbarThickness: pickedItemsScrollbarThickness,
        selectAllButton: selectAllButton,
        showClearAllButton: showClearAllButton,
        showItemsButton: showItemsButton,
        showPickedItemScrollbar: showPickedItemScrollbar,
        showSelectAllButton: showSelectAllButton,
        showShowedItemsScrollbar: showShowedItemsScrollbar,
        showedItemContainerHeight: showedItemContainerHeight,
        showedItemContainerPadding: showedItemContainerPadding,
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
        pickedItemsContainerBuilder: pickedItemsContainerBuilder,
        hintText: hintText,
        showedItemExtent: showedItemExtent,
        placePickedItemContainerBelow: placePickedItemContainerBelow ?? false,
        controller: controller,
        onSearchChanged: onSearchChanged,
      );

  /// [MultipleSearchSelection.overlay] is a widget that can be used to show the search results in an overlay.
  ///
  /// This is useful when you don't want the showed items to push the other widgets down.
  factory MultipleSearchSelection.overlay({
    required TextField searchField,
    required List<T> items,
    required Widget Function(T) pickedItemBuilder,
    required String Function(T) fieldToCheck,
    required Widget Function(T, int) itemBuilder,
    void Function(T)? onItemRemoved,
    void Function(T)? onItemAdded,
    void Function(List<T>)? onPickedChange,
    Widget Function(List<Widget> pickedItems)? pickedItemsContainerBuilder,
    Key? key,
    FuzzySearch? fuzzySearch,
    double? maximumShowItemsHeight,
    OverlayOptions<T>? overlayOptions,
    List<T>? initialPickedItems,
    Widget? title,
    double? showedItemsScrollbarMinThumbLength,
    Color? showedItemsScrollbarColor,
    double? showedItemsScrollbarMinOverscrollLength,
    Radius? showedItemsScrollbarRadius,
    double? showedItemContainerHeight,
    EdgeInsets? showedItemContainerPadding,
    bool? showShowedItemsScrollbar,
    bool? showSelectAllButton,
    bool? showClearAllButton,
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
    String hintText = 'Type here to search',
    double? showedItemExtent,
    int? maxSelectedItems,
    bool? placePickedItemContainerBelow,
    MultipleSearchController? controller,
    Function(String)? onSearchChanged,
  }) =>
      MultipleSearchSelection._(
        searchField: searchField,
        items: items,
        title: title,
        maxSelectedItems: maxSelectedItems,
        isCreatable: false,
        isOverlay: true,
        overlayOptions: overlayOptions,
        key: key ?? ValueKey(items.hashCode),
        clearSearchFieldOnSelect: clearSearchFieldOnSelect ?? false,
        fieldToCheck: fieldToCheck,
        itemBuilder: itemBuilder,
        onPickedChange: onPickedChange,
        pickedItemBuilder: pickedItemBuilder,
        clearAllButton: clearAllButton,
        fuzzySearch: fuzzySearch ?? FuzzySearch.none,
        initialPickedItems: initialPickedItems,
        maximumShowItemsHeight: maximumShowItemsHeight ?? 150,
        noResultsWidget: noResultsWidget,
        onItemAdded: onItemAdded,
        onItemRemoved: onItemRemoved,
        onTapClearAll: onTapClearAll,
        onTapSelectAll: onTapSelectAll,
        onTapShowItems: onTapShowItems,
        onTapShowedItem: onTapShowedItem,
        pickedItemSpacing: pickedItemSpacing,
        pickedItemsBoxDecoration: pickedItemsBoxDecoration,
        pickedItemsContainerMaxHeight: pickedItemsContainerMaxHeight,
        pickedItemsContainerMinHeight: pickedItemsContainerMinHeight,
        pickedItemsScrollController:
            pickedItemsScrollController ?? ScrollController(),
        pickedItemsScrollPhysics: pickedItemsScrollPhysics,
        pickedItemsScrollbarColor: pickedItemsScrollbarColor,
        pickedItemsScrollbarMinOverscrollLength:
            pickedItemsScrollbarMinOverscrollLength,
        pickedItemsScrollbarMinThumbLength: pickedItemsScrollbarMinThumbLength,
        pickedItemsScrollbarRadius: pickedItemsScrollbarRadius,
        pickedItemsScrollbarThickness: pickedItemsScrollbarThickness,
        selectAllButton: selectAllButton,
        showClearAllButton: showClearAllButton,
        showItemsButton: showItemsButton,
        showPickedItemScrollbar: showPickedItemScrollbar,
        showSelectAllButton: showSelectAllButton,
        showShowedItemsScrollbar: showShowedItemsScrollbar,
        showedItemContainerHeight: showedItemContainerHeight,
        showedItemContainerPadding: showedItemContainerPadding,
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
        pickedItemsContainerBuilder: pickedItemsContainerBuilder,
        hintText: hintText,
        showedItemExtent: showedItemExtent,
        placePickedItemContainerBelow: placePickedItemContainerBelow ?? false,
        controller: controller,
        onSearchChanged: onSearchChanged,
      );

  /// Private constructor
  const MultipleSearchSelection._({
    required this.searchField,
    required this.fieldToCheck,
    required this.itemBuilder,
    required this.pickedItemBuilder,
    required this.isCreatable,
    required this.isOverlay,
    required this.showedItemsScrollController,
    required this.pickedItemsScrollController,
    super.key,
    this.maxSelectedItems,
    this.onPickedChange,
    this.createOptions,
    this.overlayOptions,
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
    this.showedItemsScrollPhysics,
    this.showedItemsBoxDecoration,
    this.noResultsWidget,
    this.itemsVisibility = ShowedItemsVisibility.alwaysOn,
    this.pickedItemSpacing,
    this.pickedItemsContainerMaxHeight,
    this.pickedItemsContainerMinHeight,
    this.pickedItemsScrollbarColor,
    this.pickedItemsScrollbarThickness,
    this.pickedItemsScrollbarMinOverscrollLength,
    this.pickedItemsScrollbarRadius,
    this.pickedItemsScrollbarMinThumbLength,
    this.pickedItemsScrollPhysics,
    this.pickedItemsBoxDecoration,
    this.showItemsButton,
    this.selectAllButton,
    this.clearAllButton,
    this.onTapClearAll,
    this.onTapSelectAll,
    this.onTapShowItems,
    this.clearSearchFieldOnSelect,
    this.caseSensitiveSearch = false,
    this.pickedItemsContainerBuilder,
    this.hintText = 'Type here to search',
    this.showedItemExtent,
    this.placePickedItemContainerBelow = false,
    this.controller,
    this.onSearchChanged,
  });

  /// The maximum number of items that can be picked. If null, there is no limit.
  ///
  /// If the max number is met:
  ///
  /// - The [showItemsButton] will be disabled (if the item visibility is toggle).
  /// - The search field will be disabled.
  /// - The showed items will collapse.
  final int? maxSelectedItems;

  /// The title widget on top of the picked items.
  final Widget? title;

  /// The [BoxDecoration] of the picked items container.
  final BoxDecoration? pickedItemsBoxDecoration;

  /// The maximum height constraints of the items' container.
  final double maximumShowItemsHeight;

  /// The list of items (T) to search and select.
  final List<T>? items;

  /// The list of initial picked items.
  final List<T>? initialPickedItems;

  /// The thumb color of the items' scrollbar.
  final Color? showedItemsScrollbarColor;

  /// The [BoxDecoration] of the showed items container.
  final BoxDecoration? showedItemsBoxDecoration;

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

  /// Whether the picked items are sorted alphabetically. Defaults to [false].
  final bool sortPickedItems;

  /// Whether the showed items are sorted alphabetically. Defaults to [false].
  final bool? sortShowedItems;

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

  /// This is the builder of each picked item.
  final Widget Function(T) pickedItemBuilder;

  /// This is the builder of the whole picked items container.
  ///
  /// [pickedItems] is created from the [pickedItemBuilder] and [pickedItemBuilder] is called for each item in [pickedItems].
  ///
  /// This will make all the pickedItemsContainer* properties useless.
  ///
  /// If this is null, the default wrap will be used.
  ///
  final Widget Function(List<Widget> pickedItems)? pickedItemsContainerBuilder;

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
  ///
  /// [index] is the index of the item in the showed items list.
  final Widget Function(T, int) itemBuilder;

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

  /// Whether the widget is creatable style.
  final bool isCreatable;

  /// The [CreateOptions] of the creatable widget.
  final CreateOptions<T>? createOptions;

  /// Whether the search is case sensitive. Defaults to [false].
  final bool caseSensitiveSearch;

  /// Hint text to display in the text input
  final String hintText;

  /// When we have very large lists with dynamic content,
  /// unfortunately there is an open issue in flutter that causes the list to be very slow when
  /// scrolled with the srollbar.
  ///
  /// In that case you can set this to use a fixed height for each item resolving the jankiness.
  ///
  /// The downside obviously would be that you can't have dynamic height items.
  final double? showedItemExtent;

  /// Place the pickedItemsContainer bottom of the search box
  final bool placePickedItemContainerBelow;

  /// Whether widget is of type [MultipleSearchSelection.overlay]
  final bool isOverlay;

  /// Provide overlay options here to customise its behaviour.
  ///
  /// ```dart
  /// closeOnItemSelected: true, // Whether to close the overlay when an item is selected. Defaults to [true].
  /// closeOnFocusLost: true, // Whether to close the overlay when the search field loses focus. Defaults to [true].
  /// closeOverlay() // A static method to close the overlay. You can use this to close the overlay from anywhere in your code.
  /// ```
  final OverlayOptions<T>? overlayOptions;

  /// This is the controller for the [MultipleSearchSelection].
  ///
  /// Use this controller to :
  ///
  /// 1. Get the items in the list.
  /// 2. Get the picked items in the list.
  final MultipleSearchController? controller;

  /// The TextField that is used to search items.
  final TextField searchField;

  /// Since the `onChanged` of the `searchField` is used internally to search items,
  /// you can use this callback to get the search query.
  final Function(String)? onSearchChanged;

  @override
  _MultipleSearchSelectionState<T> createState() =>
      _MultipleSearchSelectionState<T>();
}

class _MultipleSearchSelectionState<T>
    extends State<MultipleSearchSelection<T>> {
  late List<T> showedItems;
  late List<T> allItems;

  bool showAllItems = false;

  List<T> pickedItems = [];

  final GlobalKey _searchFieldKey = GlobalKey();
  final LayerLink _layerLink = LayerLink();

  late ScrollController _showedItemsScrollController;
  late OverlayPortalController _overlayPortalController;

  late TextEditingController _searchFieldTextEditingController;
  late FocusNode _searchFieldFocusNode;

  Widget _searchField({
    required bool maxItemsSelected,
    required void Function(String)? onChanged,
  }) {
    return TextField(
      key: _searchFieldKey,
      enabled: !maxItemsSelected,
      onChanged: onChanged,
      controller: _searchFieldTextEditingController,
      focusNode: _searchFieldFocusNode,
      autofillHints: widget.searchField.autofillHints,
      textInputAction: widget.searchField.textInputAction,
      textCapitalization: widget.searchField.textCapitalization,
      textAlign: widget.searchField.textAlign,
      textAlignVertical: widget.searchField.textAlignVertical,
      readOnly: widget.searchField.readOnly,
      obscuringCharacter: widget.searchField.obscuringCharacter,
      obscureText: widget.searchField.obscureText,
      maxLengthEnforcement: widget.searchField.maxLengthEnforcement,
      maxLines: widget.searchField.maxLines,
      minLines: widget.searchField.minLines,
      maxLength: widget.searchField.maxLength,
      expands: widget.searchField.expands,
      autofocus: widget.searchField.autofocus,
      cursorColor: widget.searchField.cursorColor,
      cursorHeight: widget.searchField.cursorHeight,
      cursorRadius: widget.searchField.cursorRadius,
      cursorWidth: widget.searchField.cursorWidth,
      enableInteractiveSelection: widget.searchField.enableInteractiveSelection,
      enableSuggestions: widget.searchField.enableSuggestions,
      autocorrect: widget.searchField.autocorrect,
      buildCounter: widget.searchField.buildCounter,
      dragStartBehavior: widget.searchField.dragStartBehavior,
      enableIMEPersonalizedLearning:
          widget.searchField.enableIMEPersonalizedLearning, // Android only
      canRequestFocus: widget.searchField.canRequestFocus,
      clipBehavior: widget.searchField.clipBehavior,
      contentInsertionConfiguration:
          widget.searchField.contentInsertionConfiguration,
      keyboardType: widget.searchField.keyboardType,
      cursorOpacityAnimates: widget.searchField.cursorOpacityAnimates,
      inputFormatters: widget.searchField.inputFormatters,
      keyboardAppearance: widget.searchField.keyboardAppearance,
      contextMenuBuilder: widget.searchField.contextMenuBuilder,
      magnifierConfiguration: widget.searchField.magnifierConfiguration,
      mouseCursor: widget.searchField.mouseCursor,
      onAppPrivateCommand: widget.searchField.onAppPrivateCommand,
      onEditingComplete: widget.searchField.onEditingComplete,
      onSubmitted: widget.searchField.onSubmitted,
      onTap: widget.searchField.onTap,
      onTapOutside: widget.searchField.onTapOutside,
      restorationId: widget.searchField.restorationId,
      scribbleEnabled: widget.searchField.scribbleEnabled,
      scrollController: widget.searchField.scrollController,
      scrollPadding: widget.searchField.scrollPadding,
      scrollPhysics: widget.searchField.scrollPhysics,
      selectionControls: widget.searchField.selectionControls,
      showCursor: widget.searchField.showCursor,
      smartDashesType: widget.searchField.smartDashesType,
      smartQuotesType: widget.searchField.smartQuotesType,
      strutStyle: widget.searchField.strutStyle,
      selectionHeightStyle: widget.searchField.selectionHeightStyle,
      selectionWidthStyle: widget.searchField.selectionWidthStyle,
      textDirection: widget.searchField.textDirection,
      spellCheckConfiguration: widget.searchField.spellCheckConfiguration,
      undoController: widget.searchField.undoController,
      style: widget.searchField.style,
      decoration: widget.searchField.decoration,
    );
  }

  Widget _overlayedShowedItems() {
    final renderBox =
        _searchFieldKey.currentContext?.findRenderObject() as RenderBox?;
    final position = renderBox?.localToGlobal(Offset.zero);
    final size = renderBox?.size;

    return OverlayPortal(
      controller: _overlayPortalController,
      overlayChildBuilder: (context) => Positioned(
        left: position?.dx,
        top: (position?.dy ?? 0) + (size?.height ?? 0),
        width: _layerLink.leaderSize?.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: widget.overlayOptions?.offset ?? const Offset(0, 56),
          child: Material(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: widget.maximumShowItemsHeight,
              ),
              decoration: widget.showedItemsBoxDecoration ??
                  BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.withOpacity(0.5)),
                      left: BorderSide(color: Colors.grey.withOpacity(0.5)),
                      right: BorderSide(color: Colors.grey.withOpacity(0.5)),
                    ),
                  ),
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  scrollbars: false,
                ),
                child: widget.maxSelectedItems != null &&
                        widget.maxSelectedItems! <= pickedItems.length
                    ? const SizedBox()
                    : _buildShowedItems(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _prepareItems() async {
    showedItems = [...widget.items ?? []];
    allItems = [...widget.items ?? []];

    if (widget.sortShowedItems ?? false) {
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

  List<T> _searchAllItems(String query) {
    final q = widget.caseSensitiveSearch ? query : query.toLowerCase();

    return allItems.where((item) {
      final i = widget.caseSensitiveSearch
          ? widget.fieldToCheck(item)
          : widget.fieldToCheck(item).toLowerCase();
      bool matches = i.contains(q);

      if (widget.fuzzySearch == FuzzySearch.jaro) {
        matches = matches ||
            getJaro(
                  widget.fieldToCheck(item),
                  query,
                  caseSensitive: widget.caseSensitiveSearch,
                ) >=
                0.8;
      } else if (widget.fuzzySearch == FuzzySearch.levenshtein) {
        matches = matches ||
            getLevenshtein(
                  widget.fieldToCheck(item),
                  query,
                  caseSensitive: widget.caseSensitiveSearch,
                ) <=
                2;
      }

      return matches;
    }).toList();
  }

  void _onRemoveItem(T item) {
    pickedItems.remove(item);
    allItems.add(item);
    if (widget.sortShowedItems ?? false) {
      allItems.sort(
        (a, b) => widget.fieldToCheck(a).compareTo(
              widget.fieldToCheck(b),
            ),
      );
    }
    showedItems = _searchAllItems(
      _searchFieldTextEditingController.text,
    );

    widget.onPickedChange?.call(pickedItems);
    widget.onItemRemoved?.call(item);

    setState(() {});
  }

  void _onAddItem(T item) {
    if (widget.maxSelectedItems != null &&
        pickedItems.length >= widget.maxSelectedItems!) {
      Navigator.pop(context);
      return;
    }

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

    if (widget.maxSelectedItems != null &&
        pickedItems.length == widget.maxSelectedItems!) {
      _searchFieldTextEditingController.clear();
      if (widget.itemsVisibility == ShowedItemsVisibility.toggle) {
        Navigator.pop(context);
      }
    }

    if (widget.clearSearchFieldOnSelect ?? false) {
      _searchFieldTextEditingController.clear();
      showedItems = allItems;
    }
    if (widget.itemsVisibility == ShowedItemsVisibility.onType &&
        _searchFieldTextEditingController.text.isEmpty) {
      showAllItems = false;
    }
    if (widget.isOverlay &&
        widget.overlayOptions?.closeOnItemSelected == true) {
      _overlayPortalController.hide(); // Return focus to the TextField
    }
    setState(() {});
  }

  void _onCreateItem() {
    if (widget.isCreatable) {
      final T itemToAdd =
          widget.createOptions!.create(_searchFieldTextEditingController.text);

      if (allItems.contains(itemToAdd) || pickedItems.contains(itemToAdd)) {
        widget.createOptions!.onDuplicate?.call(itemToAdd);
        if (!widget.createOptions!.allowDuplicates) {
          return;
        }
      }

      if (widget.createOptions!.pickCreated) {
        pickedItems.add(itemToAdd);
        widget.onPickedChange?.call(
          pickedItems,
        );
        widget.onItemAdded?.call(itemToAdd);
        widget.createOptions!.onCreated?.call(itemToAdd);
      } else {
        allItems.add(itemToAdd);
      }

      if (widget.clearSearchFieldOnSelect ?? false) {
        _searchFieldTextEditingController.clear();
        showedItems = allItems;
      }
      if (widget.itemsVisibility == ShowedItemsVisibility.onType &&
          _searchFieldTextEditingController.text.isEmpty) {
        showAllItems = false;
      }

      setState(() {});
    } else if (widget.isOverlay &&
        widget.overlayOptions?.canCreateItem == true) {
      final T itemToAdd = widget.overlayOptions!.createOptions!
          .create(_searchFieldTextEditingController.text);

      if (allItems.contains(itemToAdd) || pickedItems.contains(itemToAdd)) {
        widget.overlayOptions!.createOptions!.onDuplicate?.call(itemToAdd);
        if (!widget.overlayOptions!.createOptions!.allowDuplicates) {
          return;
        }
      }

      if (widget.overlayOptions!.createOptions!.pickCreated) {
        pickedItems.add(itemToAdd);
        widget.onPickedChange?.call(
          pickedItems,
        );
        widget.onItemAdded?.call(itemToAdd);
        widget.overlayOptions!.createOptions!.onCreated?.call(itemToAdd);
      } else {
        allItems.add(itemToAdd);
      }

      if (widget.clearSearchFieldOnSelect ?? false) {
        _searchFieldTextEditingController.clear();
        showedItems = allItems;
      }
      if (widget.itemsVisibility == ShowedItemsVisibility.onType &&
          _searchFieldTextEditingController.text.isEmpty) {
        showAllItems = false;
      }

      setState(() {});
    }
  }

  void _onClearSearchField() {
    if (_searchFieldTextEditingController.text.isNotEmpty) {
      _searchFieldTextEditingController.clear();
      showedItems = allItems;
      if (widget.itemsVisibility == ShowedItemsVisibility.onType) {
        showAllItems = false;
      }

      setState(() {});
    }
  }

  void _selectAllItems() {
    pickedItems.addAll(
      showedItems,
    );
    if (widget.sortPickedItems) {
      pickedItems.sort(
        (a, b) => widget.fieldToCheck(a).compareTo(
              widget.fieldToCheck(b),
            ),
      );
    }
    allItems.removeWhere((e) => showedItems.contains(e));

    showedItems = _searchAllItems(_searchFieldTextEditingController.text);
    if (showedItems.isNotEmpty) {
      if (widget.sortShowedItems ?? false) {
        showedItems.sort(
          (a, b) => widget.fieldToCheck(a).compareTo(
                widget.fieldToCheck(b),
              ),
        );
      }
    }

    widget.onPickedChange?.call(pickedItems);
    widget.onTapSelectAll?.call();

    setState(() {
      showAllItems = widget.itemsVisibility != ShowedItemsVisibility.onType &&
          _searchFieldTextEditingController.text.isNotEmpty;
    });
    if (widget.isOverlay) {
      _overlayPortalController.hide(); // Return focus to the TextField
    }
  }

  void _clearAllPickedItems() {
    allItems.addAll(pickedItems);
    if (widget.sortShowedItems ?? false) {
      allItems.sort(
        (a, b) => widget.fieldToCheck(a).compareTo(
              widget.fieldToCheck(b),
            ),
      );
    }

    showedItems = _searchAllItems(_searchFieldTextEditingController.text);

    pickedItems.removeRange(0, pickedItems.length);

    widget.onPickedChange?.call(pickedItems);
    widget.onTapClearAll?.call();

    setState(() {});
    if (widget.isOverlay) {
      _searchFieldFocusNode.requestFocus(); // Return focus to the TextField
    }
  }

  Widget _buildShowedItems() {
    return TapRegion(
      onTapOutside: (event) {
        if (widget.isOverlay) {
          _overlayPortalController.hide();
        }
      },
      child: ListView.builder(
        padding: EdgeInsets.zero,
        primary: false,
        shrinkWrap: true,
        cacheExtent: 900,
        addAutomaticKeepAlives: false,
        controller: _showedItemsScrollController,
        itemCount: showedItems.isEmpty ? 1 : showedItems.length,
        itemExtent: widget.showedItemExtent,
        itemBuilder: (context, index) {
          if ((showedItems.isEmpty && allItems.isNotEmpty) ||
              (showedItems.isEmpty && allItems.isEmpty)) {
            return (widget.isCreatable ||
                        (widget.overlayOptions?.canCreateItem ?? false)) &&
                    _searchFieldTextEditingController.text.isNotEmpty
                ? GestureDetector(
                    onTap: _onCreateItem,
                    child: AbsorbPointer(
                      child: widget.createOptions?.createBuilder(
                            _searchFieldTextEditingController.text,
                          ) ??
                          widget.overlayOptions?.createOptions!.createBuilder
                              .call(
                            _searchFieldTextEditingController.text,
                          ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: widget.noResultsWidget ??
                        const Text(
                          'No results',
                        ),
                  );
          }

          final item = showedItems[index];
          return widget.isOverlay
              ? GestureDetector(
                  onTap: () async {
                    _onAddItem(item);
                  },
                  child: AbsorbPointer(
                    child: widget.itemBuilder(
                      item,
                      index,
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    _onAddItem(item);
                  },
                  child: AbsorbPointer(
                    child: widget.itemBuilder(
                      item,
                      index,
                    ),
                  ),
                );
        },
      ),
    );
  }

  List<Widget> _pickedItemsBuilder(BuildContext context, bool display) {
    if (display == false) return [];
    return [
      if (widget.pickedItemsContainerBuilder != null)
        widget.pickedItemsContainerBuilder!.call([
          ...pickedItems.map(
            (e) => TapRegion(
              onTapInside: (event) {
                if (widget.isOverlay) {
                  _overlayPortalController.show();
                }
              },
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  _onRemoveItem(e);
                },
                child: IgnorePointer(
                  child: widget.pickedItemBuilder.call(e),
                ),
              ),
            ),
          ),
        ])
      else if (pickedItems.isNotEmpty)
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
            controller: widget.pickedItemsScrollController,
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                controller: widget.pickedItemsScrollController,
                physics: widget.pickedItemsScrollPhysics,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: widget.pickedItemSpacing ?? 5,
                    runSpacing: widget.pickedItemSpacing ?? 5,
                    children: [
                      ...pickedItems.map(
                        (e) => TapRegion(
                          onTapInside: (event) {
                            if (widget.isOverlay) {
                              _overlayPortalController.show();
                            }
                          },
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              _onRemoveItem(e);
                            },
                            child: IgnorePointer(
                              child: widget.pickedItemBuilder.call(e),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
    ];
  }

  @override
  void initState() {
    super.initState();

    _prepareItems();

    _showedItemsScrollController =
        widget.showedItemsScrollController ?? ScrollController();

    showAllItems = widget.itemsVisibility == ShowedItemsVisibility.alwaysOn;

    if (widget.controller != null) {
      widget.controller!.getAllItems = () => allItems;
      widget.controller!.getPickedItems = () => pickedItems;
      widget.controller!.clearSearchField = _onClearSearchField;
      widget.controller!.selectAllItems = _selectAllItems;
      widget.controller!.clearAllPickedItems = _clearAllPickedItems;
      widget.controller!.searchItems = (query) => _searchAllItems(query);
    }

    _searchFieldTextEditingController =
        widget.searchField.controller ?? TextEditingController();
    _searchFieldFocusNode = widget.searchField.focusNode ?? FocusNode();

    pickedItems.addAll(widget.initialPickedItems ?? []);

    if (widget.isOverlay) {
      _overlayPortalController = OverlayPortalController();
      widget.overlayOptions?.closeOverlay = () {
        _overlayPortalController.hide();
      };

      widget.overlayOptions?.showOverlay = () {
        _overlayPortalController.show();
      };

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _searchFieldFocusNode.addListener(() {
          if (_searchFieldFocusNode.hasFocus) {
            _overlayPortalController.show();
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool maxItemsSelected = widget.maxSelectedItems != null &&
        (widget.maxSelectedItems!) <= pickedItems.length;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) widget.title!,
        ..._pickedItemsBuilder(
          context,
          widget.placePickedItemContainerBelow == false,
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
                                backgroundColor: Colors.white,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _searchField(
                                      maxItemsSelected: maxItemsSelected,
                                      onChanged: (value) {
                                        widget.onSearchChanged?.call(value);
                                        showedItems = _searchAllItems(value);
                                        setState(() {});
                                        stateSetter(() {});
                                      },
                                    ),
                                    Container(
                                      constraints: BoxConstraints(
                                        maxHeight:
                                            widget.maximumShowItemsHeight,
                                      ),
                                      decoration: widget
                                              .showedItemsBoxDecoration ??
                                          BoxDecoration(
                                            color: Colors.grey.withOpacity(0.1),
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                              ),
                                              left: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                              ),
                                              right: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ),
                                      child: ScrollConfiguration(
                                        behavior:
                                            ScrollConfiguration.of(context)
                                                .copyWith(
                                          scrollbars: false,
                                        ),
                                        child: maxItemsSelected
                                            ? const SizedBox()
                                            : _buildShowedItems(),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ).whenComplete(() {
                          _searchFieldTextEditingController.clear();
                          showedItems = allItems;
                        });
                      },
                      child: IgnorePointer(
                        child: maxItemsSelected
                            ? const SizedBox()
                            : widget.showItemsButton ??
                                const Text('Show items'),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                  if (widget.maxSelectedItems == null)
                    if (widget.showSelectAllButton ?? true)
                      TapRegion(
                        onTapInside: (event) {
                          if (widget.isOverlay) {
                            _overlayPortalController.show();
                          }
                        },
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: _selectAllItems,
                          child: IgnorePointer(
                            child: widget.selectAllButton ??
                                const Text('Select all'),
                          ),
                        ),
                      ),
                ],
              ),
              if (pickedItems.isNotEmpty && (widget.showClearAllButton ?? true))
                TapRegion(
                  onTapInside: (event) {
                    if (widget.isOverlay) {
                      _overlayPortalController.show();
                    }
                  },
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: _clearAllPickedItems,
                    child: IgnorePointer(
                      child: widget.clearAllButton ?? const Text('Clear all'),
                    ),
                  ),
                ),
            ],
          ),
        ],
        const SizedBox(
          height: 10,
        ),
        if (widget.itemsVisibility != ShowedItemsVisibility.toggle &&
            widget.isOverlay) ...[
          Column(
            children: [
              CompositedTransformTarget(
                link: _layerLink,
                child: TapRegion(
                  onTapInside: (event) {
                    _overlayPortalController.show();
                  },
                  child: _searchField(
                    maxItemsSelected: maxItemsSelected,
                    onChanged: (value) {
                      widget.onSearchChanged?.call(value);
                      showedItems = _searchAllItems(value);
                      if (widget.itemsVisibility ==
                          ShowedItemsVisibility.onType) {
                        showAllItems = widget.itemsVisibility ==
                                ShowedItemsVisibility.onType &&
                            _searchFieldTextEditingController.text.isNotEmpty;
                      }
                      setState(() {});
                    },
                  ),
                ),
              ),
              _overlayedShowedItems(),
            ],
          ),
        ],
        if (widget.itemsVisibility != ShowedItemsVisibility.toggle &&
            !widget.isOverlay) ...[
          _searchField(
            maxItemsSelected: maxItemsSelected,
            onChanged: (value) {
              widget.onSearchChanged?.call(value);
              showedItems = _searchAllItems(value);
              if (widget.itemsVisibility == ShowedItemsVisibility.onType) {
                showAllItems =
                    widget.itemsVisibility == ShowedItemsVisibility.onType &&
                        _searchFieldTextEditingController.text.isNotEmpty;
              }
              setState(() {});
            },
          ),
          if (showAllItems)
            Container(
              constraints: BoxConstraints(
                maxHeight: widget.maximumShowItemsHeight,
              ),
              decoration: widget.showedItemsBoxDecoration ??
                  BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      left: BorderSide(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      right: BorderSide(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    ),
                  ),
              child: RawScrollbar(
                controller: widget.showedItemsScrollController,
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
                  child:
                      maxItemsSelected ? const SizedBox() : _buildShowedItems(),
                ),
              ),
            ),
        ],
        ..._pickedItemsBuilder(
          context,
          widget.placePickedItemContainerBelow == true,
        ),
      ],
    );
  }
}
