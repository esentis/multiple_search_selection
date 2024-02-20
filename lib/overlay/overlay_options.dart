import 'package:flutter/widgets.dart';
import 'package:multiple_search_selection/createable/create_options.dart';
import 'package:multiple_search_selection/multiple_search_selection.dart';

/// Pass this to the [MultipleSearchSelection.overlay] widget to customize the overlay behavior.
class OverlayOptions<T> {
  /// Whether to close the overlay when an item is selected
  final bool closeOnItemSelected;

  /// Whether you can create an item when there are no results.
  final bool canCreateItem;

  /// The offset of the overlay relative to the Searchfield.
  ///
  /// The default value is:
  /// ```dart
  /// Offset(0, 56)
  /// ```
  final Offset? offset;

  /// Programmatically close the overlay of the showed items.
  void Function()? closeOverlay;

  /// Programmatically show the overlay of the showed items.
  void Function()? showOverlay;

  /// The options for creating an item.
  final CreateOptions<T>? createOptions;

  OverlayOptions({
    this.closeOnItemSelected = true,
    this.canCreateItem = false,
    this.offset,
    this.createOptions,
  }) : assert(!canCreateItem || (canCreateItem && createOptions != null));
}
