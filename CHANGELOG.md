# 1.1.0

- Adds [itemsVisibility] enum which activates different display options on showed items.

```dart
ShowedItemsVisibility.alwaysOn // The items are always displayed
ShowedItemsVisibility.onType // Items are displayed when user types on search field
ShowedItemsVisibility.toggle // Items are displayed when tapped on show items toggle button
```

## 1.0.5

- Replaces deprecated `isAlwaysShown` with `thumbVisibility` for `RawScrollBar`

## 1.0.4

- Adds initialy picked items parameter, `List<String>`. `initialPickedItems`
- Edits library description
- Edits example code

## 1.0.3

- Adds [MouseCursor] for showed & picked items. `showedItemMouseCursor` & `pickedItemMouseCursor`
- Adds [BoxDecoration] for showed & picked items container. `pickedItemsBoxDecoration` & `showedItemsBoxDecoration`

## 1.0.2

- Adds fuzzy search functionality. New `enum` `FuzzySearch` added to choose from available fuzzy algorithms (Jaro & Levenshtein). Defaults to [FuzzySearch.none].

## 1.0.1

- Adds [ScrollController] for showed & picked items.
- Adds [ScrollPhysics] for showed & picked items.
- Adds a choice whether to sort showed & picked items.
- Adds picked item remove icon parameter.
- Exposes picked item's [BoxDecoration].
- Exposes clear all & select all buttons' animation curves.

## 1.0.0

- Initial release.
