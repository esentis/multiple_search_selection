# 2.2.0 🔥 Breaking changes

Fields removed:

- [padding] : Refactor -> You can wrap the whole widget in a [Padding] widget.
- [titlePadding] : Refactor -> You can wrap the title with a [Padding] widget.
- [showedItemMouseCursor] : Refactor -> You can build your own showed item [Widget] with [itemBuilder] and use your own style.
- [searchItemTextContentPadding] : Refactor -> You can use [searchFieldInputDecoration] to style your search textfield.

Fields renamed:

- [searchItemTextStyle] -> [searchFieldTextStyle]

## 2.1.0 🔥 ⚡️ Breaking changes & performance improvements

- Adds [showItemsButton] widget and removes all parameters associated with it previously.
- Adds [selectAllButton] widget and removes all parameters associated with it previously.
- Adds [clearAllButton] widget and removes all parameters associated with it previously.
- Removes opinionated default widgets to plain [Text] reducing code size

### 2.0.2 🐛 Bug fixes

- Fixes sort picked items bug

### 2.0.1 🐛 Bug fixes

- Fixes bug with [showItemsText] button text showing [selectAllText] instead
- Removes junk files reducing library size

### 2.0.0 🔥 Breaking changes

[items] & [initialItems] are now of type [T] for more flexibility when working with different types of [Object] in [List].

New required parameters added :

- [itemBuilder(T)] build and return the showed item widget
- [pickedItemBuilder(T)] build and return the picked item widget
- [fieldToCheck(T)] return the [String] field from the [T] of which you will search & sort against

Removed all parameters connected to showed & picked items since we now have builder methods. Please check the example for the implementation.

### 1.1.0 ✨ New features

- Adds [itemsVisibility] enum which activates different display options on showed items.

```dart
ShowedItemsVisibility.alwaysOn // The items are always displayed
ShowedItemsVisibility.onType // Items are displayed when user types on search field
ShowedItemsVisibility.toggle // Items are displayed when tapped on show items toggle button
```

### 1.0.5 ♻️ Refactors code

- Replaces deprecated `isAlwaysShown` with `thumbVisibility` for `RawScrollBar`

### 1.0.4 ✨ 📝 New features & documentation improvement

- Adds initialy picked items parameter, `List<String>`. `initialPickedItems`
- Edits library description
- Edits example code

### 1.0.3 ✨ New features

- Adds [MouseCursor] for showed & picked items. `showedItemMouseCursor` & `pickedItemMouseCursor`
- Adds [BoxDecoration] for showed & picked items container. `pickedItemsBoxDecoration` & `showedItemsBoxDecoration`

### 1.0.2 ✨ New features

- Adds fuzzy search functionality. New `enum` `FuzzySearch` added to choose from available fuzzy algorithms (Jaro & Levenshtein). Defaults to [FuzzySearch.none].

### 1.0.1 ✨ New features

- Adds [ScrollController] for showed & picked items.
- Adds [ScrollPhysics] for showed & picked items.
- Adds a choice whether to sort showed & picked items.
- Adds picked item remove icon parameter.
- Exposes picked item's [BoxDecoration].
- Exposes clear all & select all buttons' animation curves.

### 1.0.0 🎉 Initial release

- Initial release.
