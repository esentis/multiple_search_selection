<p align="center">
<img src='https://i.imgur.com/3dHOaoF.gif'>
</p>
<p align="center">
 <img src="https://img.shields.io/pub/v/multiple_search_selection?color=637d0d&style=for-the-badge" alt="Version" /> <img src="https://img.shields.io/github/languages/code-size/esentis/multiple_search_selection?color=637d0d&style=for-the-badge&label=size" alt="Version" />
</br>
</p>

#### A highly customizable multiple selection widget with fuzzy search functionality

```dart
MultipleSearchSelection(
    items: countries, // List<String>
    fuzzySearch: true,
    fuzzyDistance: 2,
    padding: const EdgeInsets.all(20),
    title: Text(
        'Countries',
        style: kStyleDefault.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        ),
    ),
    titlePadding: const EdgeInsets.symmetric(vertical: 10),
    searchItemTextContentPadding:
        const EdgeInsets.symmetric(horizontal: 10),
    maximumShowItemsHeight: 200,
    hintText: 'Type here to search',
    hintTextStyle: kStyleDefault.copyWith(
        fontSize: 13,
        color: Colors.grey[400],
    ),
    selectAllTextStyle: kStyleDefault,
    selectAllBackgroundColor: Colors.white,
    selectAllOnHoverBackgroundColor: Colors.blue[300],
    selectAllOnHoverTextColor: Colors.white,
    selectAllOnHoverFontWeight: FontWeight.bold,
    clearAllTextStyle: kStyleDefault.copyWith(
        color: Colors.red,
    ),
    clearAllOnHoverFontWeight: FontWeight.bold,
    clearAllOnHoverBackgroundColor: Colors.white,
    pickedItemTextStyle: kStyleDefault.copyWith(
        fontSize: 13,
    ),
    pickedItemBackgroundColor: Colors.grey[300]!.withOpacity(0.5),
    pickedItemBorderRadius: 6,
    pickedItemTextColor: Colors.black,
    showedItemTextStyle: kStyleDefault.copyWith(
        fontWeight: FontWeight.w500,
    ),
    showedItemsBackgroundColor: Colors.grey.withOpacity(0.1),
    searchItemTextStyle: kStyleDefault,
    noResultsWidget: Text(
        'No items found',
        style: kStyleDefault.copyWith(
        color: Colors.grey[400],
        fontSize: 13,
        fontWeight: FontWeight.w100,
        ),
    ),
    onTapShowedItem: () {},
    onPickedChange: (items) {},
    onItemAdded: (item) {
        print('$item added to picked items');
    },
    onItemRemoved: (item) {
        print('$item removed from picked items');
    },
    )
```

## Issues / Features

Found a bug or want a new feature? Open an issue in the [Github repository](https://github.com/esentis/multiple_search_selection) of the project.
