import 'package:flutter/material.dart';

class CreateOptions<T> {
  /// Return the item you want to add in your list.
  ///
  /// You can create the item [T] with provided [text].
  ///
  /// If [T] is [String] just return the [text].
  final T Function(String text) createItem;

  /// This is the create item [Widget] builder.
  ///
  /// The current text in the searchfield is provided via [text].
  final Widget Function(String text) createItemBuilder;

  /// Whether to automatically pick the created item.
  final bool pickCreatedItem;

  /// Whether to allow duplicates in the list.
  ///
  /// If [true] then the item will be added to the list even if it already exists.
  final bool allowDuplicates;

  /// A callback after the item is created and added to your list/picked items.
  final Function(T)? onItemCreated;

  final Function(T)? onDuplicateItem;

  const CreateOptions({
    required this.createItem,
    required this.createItemBuilder,
    this.onDuplicateItem,
    this.pickCreatedItem = false,
    this.allowDuplicates = false,
    this.onItemCreated,
  });
}
