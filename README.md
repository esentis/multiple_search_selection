<p align="center">
<img src='https://i.imgur.com/3dHOaoF.gif' width=550px>
</p>
<p align="center">
 <img src="https://img.shields.io/pub/v/multiple_search_selection?color=637d0d&style=for-the-badge" alt="Version" /> <img src="https://img.shields.io/github/languages/code-size/esentis/multiple_search_selection?color=637d0d&style=for-the-badge&label=size" alt="Version" />
</br>
</p>

#### A highly customizable multiple selection widget with fuzzy search functionality

```dart
MultipleSearchSelection<Country>(
        items: countries, // List<Country>
        fieldToCheck: (c) {
          return c.name;
        },
        itemBuilder: (country) {
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
        pickedItemBuilder: (country) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey[400]!),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(country.name),
            ),
          );
        },
        onTapShowedItem: () {},
        onPickedChange: (items) {},
        onItemAdded: (item) {},
        onItemRemoved: (item) {},
        sortShowedItems: true,
        sortPickedItems: true,
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
        showSelectAllButton: true,
        titlePadding: const EdgeInsets.symmetric(vertical: 10),
        searchItemTextContentPadding:
            const EdgeInsets.symmetric(horizontal: 10),
        maximumShowItemsHeight: 200,
      )
```

### Showed items behavior

| Always on                                                 | On type                                               | Toggle                                              |
| --------------------------------------------------------- | ----------------------------------------------------- | --------------------------------------------------- |
| ![Always on](https://i.imgur.com/UgJGDtq.gif "Always on") | ![On type](https://i.imgur.com/f15wDcz.gif "On type") | ![Toggle](https://i.imgur.com/tGKQVhl.gif "Toggle") |

## Issues / Features

Found a bug or want a new feature? Open an issue in the [Github repository](https://github.com/esentis/multiple_search_selection) of the project.
