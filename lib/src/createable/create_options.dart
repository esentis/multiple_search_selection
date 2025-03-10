import 'package:flutter/material.dart';

class CreateOptions<T> {
  /// Return the item you want to add in your list.
  ///
  /// You can create the item [T] with provided [text].
  ///
  /// If [T] is [String] just return the [text].
  final T Function(String text) create;

  /// This is the create item [Widget] builder.
  ///
  /// The current text in the searchfield is provided via [text].
  final Widget Function(String text) createBuilder;

  /// Whether to automatically pick the created item. Defaults to `false`.
  final bool pickCreated;

  /// Whether to allow duplicates in the list.
  ///
  /// If [true] then the item will be added to the list even if it already exists. Defaults to `false`.
  final bool allowDuplicates;

  /// A callback after the item is created and added to your list/picked items.
  final void Function(T)? onCreated;

  /// A callback when the item already exists in your list.
  final void Function(T)? onDuplicate;

  /// You can create the item [T] with provided [text].
  ///
  /// If [T] is [String] just return the [text].
  ///
  /// The [validator] function is called before creating the item.
  /// If the function returns `false` the item will not be created.
  final bool Function(T) validator;

  // Default validator that always returns true
  static bool _defaultValidator(dynamic item) => true;

  const CreateOptions({
    required this.create,
    required this.createBuilder,
    this.validator = _defaultValidator,
    this.onDuplicate,
    this.pickCreated = false,
    this.allowDuplicates = false,
    this.onCreated,
  });
}
