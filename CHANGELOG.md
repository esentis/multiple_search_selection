## 2.5.5 ✨ New features

- Adds a new flag `placePickedItemContainerBelow` which defaults to `false`. Picked items will be displayed at the bottom instead of top

## 2.5.4 ✨🔥 New features & Breaking changes

- Renames `textFieldFocus` to `searchFieldFocus`
- Adds `autoCorrect` flag, to check if the search field should auto correct the input text
- Adds `enableSuggestions` flag, to check if the search field should provide suggestions

## 2.5.3 ✨ Adds screenshots & Allows higher than 3.0.0 version SDK

## 2.5.2 🐛 Bug fixes

- Resolves the inconsistency where ShowedItemsVisibility.onType was showing all items after selecting one from the list.

## 2.5.1 🐛 Bug fixes

- Fixes range exception issue when selecting all items

## 2.5.0 ✨🔥 New features & Breaking changes

### Breaking changes

- Removes deprecated parameters

### Features

- Adds `maxSelectedItems` parameter to specify the maximum amount of items the user can select from the items' list. If the maximum number is picked:
  - The search TextField is disabled and the items' list is hidden.
  - The select all button is hidden.
  - The show items button is hidden, if the item visibility is Toggle.
  - The dialog of the items is popped, if the item visibility is Toggle.

## 2.4.5 🐛✨ Bug fixes & New features

### Fixes

- Resolves an issue with `showedItems` not dissapearing when `itemsVisibility == ShowedItemsVisibility.onType` & `clearSearchFieldOnSelect == true`

### Features

- Adds `showedItemsExtent` flag.
  When we have very large lists with dynamic content, unfortunately there is an open [issue](https://github.com/flutter/flutter/issues/52207) in Flutter that causes the list to be very slow when scrolled with the srollbar. In that case you can set this to use a fixed height for each item resolving the jankiness. The downside obviously would be that you can't have dynamic height items.

## 2.4.4 🐛 Bug fixes

- Resolves an issue when the clear textfield button was not resetting showed items.

## 2.4.3 ✨ New features

- Renames `outerContainer` to `searchField` to properly reflect its purpose.

- Adds a new parameter called `searchFieldBoxDecoration`, which allows you to specify the decoration of the top portion of the dialog box when the `ShowedItemsVisibility` is set to `toggle`.

- Adds deprecated flags to exposed `Decoration` parameters from `pickedItemsBoxDecoration`, `searchFieldBoxDecoration` & `showedItemsBoxDecoration`. Will be removed on next version.

- Fixes discrepancies of the decoration parameters.

## 2.4.2 🐛 Bug fixes

- Fixes short circuiting issue

## 2.4.1 🐛 Bug fixes

- Resolved issue of displayed items failing to wrap when there were fewer items to display in the container.

## 2.4.0 ✨🔥 New features & Breaking changes

- Refactored the displayed items to use lazy loading, resulting in a significant improvement in performance for large lists. Additionally, the index is now accessible for further customization.

```dart
itemBuilder: (country, index) {
    if (index==0) return Text('Hello World');
    return Padding(
    padding: const EdgeInsets.all(6.0),
    child: Container(
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.white,
         ),
        child: Padding(
         padding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 12,
         ),
         child: Text(country.name),
      ),
    ),
  );
},
```

- Exposes some more `InputDecoration` parameters :
  - Adds `showClearSearchFieldButton` which adds a suffix icon to clear searchfield
  - Adds `hintText`
  - Adds `textFieldFocus`
  - Adds `textEdittingController`
- If `pickedItemsContainerBuilder` is provided it will build even if no items are picked

## 2.3.7 ✨ New features

- Adds `pickedItemsContainerBuilder`. You can now provide your own custom `Widget` for the picked items. `pickedItems` (`List<Widget>`) are created from the `pickedItemBuilder`. So having those items you can customise the layout at your needs.

```dart
pickedItemsContainerBuilder: (pickedItems) => Center(
    child: Container(
    height: 150,
    width: 150,
    decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[400]!),
      ),
    child: ListView(
        children: pickedItems,
    ),
  ),
),
pickedItemBuilder: (country) {
    return Padding(
    padding: const EdgeInsets.all(8),
    child: Center(
        child: Text(
        country.name,
        style: const TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
        ),
      ),
    ),
  );
},
```

<img src="https://i.imgur.com/EXZvBr0.gif" title="pickedItemsBuilder" />

## 2.3.6 🎨 ♻️ Improves structure & Refactors code

- Removes redundant code & refactors methods.
- Fixes `onItemRemoved` being called twice. Thanks to [anqit](https://github.com/anqit)

## 2.3.5 🐛 Bug fixes

- Fixes issue were fuzzy search was not always working

## 2.3.4 🎨 Updates CHANGELOG

## 2.3.3 🐛✨ Bug fixes & New features

- Adds missed [onItemCreated] parameter to [createOptions]
- Adds `caseSensitiveSearch` so you can search with case sensitive. Thanks to [anqit](https://github.com/anqit)

## 2.3.2 ✨ New features

New constructor added `MultipleSearchSelection<T>.creatable` which can now create new item when search result does not return any results. It takes a new required parameter, `createOptions` e.g :

```dart
// [T] here is [Country]
createOptions: CreateOptions<Country>(
    // You need to create and return the item you want to add since [T] is not always [String].
    createItem: (text) {
        return Country(name: text, iso: text);
    },
    // Create item Widget that appears instead of no results.
    createItemBuilder: (text) => Align(
        alignment: Alignment.centerLeft,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Create "$text"'),
            ),
        ),
    // Whether you want to pick the newly created item or just add it to your list. Defaults to false.
    pickCreatedItem: true,
),
```

<img src="https://i.imgur.com/XVwxgXA.gif" title="Creatable" />

## 2.3.1 ✨ New features

- [clearSearchFieldOnSelect]. Whether to clear the searchfield and reset the showed items when you pick an item. Defaults to [false].

## 2.3.0 ♻️ 🔥 🐛 Code refactoring, Breaking changes & Bug fixes

🔥 Breaking changes:

- Minimum Dart SDK updated to 2.17.0

🐛 Bug fixes:

- Dropdown was not correctly rebuilding after changing the initial `items` list.

♻️ Fields made optional:

- Key parameter has been added. It defaults to `ValueKey(items.hasCode)`.
- [maximumShowItemsHeight]. It defaults to 150.
- [onPickedChange]. Your call if you need it.
- [itemsVisibility]. It defaults to always on.
- [fuzzySearch]. It defaults to none.

### 2.2.1 🐛 Bug fixes

- Fixes `itemsVisibility: ShowedItemsVisibility.onType` not showing anything.

### 2.2.0 🔥 Breaking changes

Fields removed:

- [padding] : Refactor -> You can wrap the whole widget in a [Padding] widget.
- [titlePadding] : Refactor -> You can wrap the title with a [Padding] widget.
- [showedItemMouseCursor] : Refactor -> You can build your own showed item [Widget] with [itemBuilder] and use your own style.
- [searchItemTextContentPadding] : Refactor -> You can use [searchFieldInputDecoration] to style your search textfield.

Fields renamed:

- [searchItemTextStyle] -> [searchFieldTextStyle]

### 2.1.0 🔥 ⚡️ Breaking changes & performance improvements

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
