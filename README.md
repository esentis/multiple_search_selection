<p align="center">
<img src='https://i.imgur.com/3dHOaoF.gif' width=550px>
</p>
<p align="center">
 <img src="https://img.shields.io/pub/v/multiple_search_selection?color=637d0d&style=for-the-badge" alt="Version" /> <img src="https://img.shields.io/github/languages/code-size/esentis/multiple_search_selection?color=637d0d&style=for-the-badge&label=size" alt="Version" />
</br>
</p>

#### A highly customizable multiple selection widget with fuzzy search functionality

```dart
MultipleSearchSelection(
    items: countries, // List<String>
    fuzzySearch: FuzzySearch.jaro,
    padding: const EdgeInsets.all(20),
    itemsVisibility: ShowedItemsVisibility.alwaysOn,
    title: Text(
        'Countries',
        style: kStyleDefault.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        ),
    ),
    showSelectAllButton: false,
    titlePadding: const EdgeInsets.symmetric(vertical: 10),
    searchItemTextContentPadding:
        const EdgeInsets.symmetric(horizontal: 10),
    maximumShowItemsHeight: 200,
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

### Showed items behavior

| Always on                                                 | On type                                               | Toggle                                              |
| --------------------------------------------------------- | ----------------------------------------------------- | --------------------------------------------------- |
| ![Always on](https://i.imgur.com/UgJGDtq.gif "Always on") | ![On type](https://i.imgur.com/f15wDcz.gif "On type") | ![Toggle](https://i.imgur.com/tGKQVhl.gif "Toggle") |

## Issues / Features

Found a bug or want a new feature? Open an issue in the [Github repository](https://github.com/esentis/multiple_search_selection) of the project.
