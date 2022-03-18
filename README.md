<center><img src='https://i.imgur.com/3dHOaoF.gif'></center>

#### A highly customizable multiple selection widget with search functionality.

```dart
MultipleSearchSelection(
items: countries, // List<String>
padding: const EdgeInsets.all(20),
title: Text(
    'Countries',
    style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    ),
),
titlePadding: const EdgeInsets.symmetric(vertical: 10),
searchItemTextContentPadding:
    const EdgeInsets.symmetric(horizontal: 10),
maximumShowItemsHeight: 200,
hintText: 'Type here to search',
hintTextStyle: TextStyle(
    fontSize: 13,
    color: Colors.grey[400],
),
selectAllTextStyle: TextStyle(
  color: Colors.black,
  fontSize: 16,
  fontWeight: FontWeight.bold,
),
selectAllBackgroundColor: Colors.white,
selectAllOnHoverBackgroundColor: Colors.blue[300],
selectAllOnHoverTextColor: Colors.white,
selectAllOnHoverFontWeight: FontWeight.bold,
clearAllTextStyle: TextStyle(
    color: Colors.red,
),
clearAllOnHoverFontWeight: FontWeight.bold,
clearAllOnHoverBackgroundColor: Colors.white,
pickedItemTextStyle: TextStyle(
    fontSize: 13,
),
pickedItemBackgroundColor: Colors.grey[300]!.withOpacity(0.5),
pickedItemTextColor: Colors.black,
showedItemTextStyle: TextStyle(
    fontWeight: FontWeight.w500,
),
showedItemsBackgroundColor: Colors.grey.withOpacity(0.1),
searchItemTextStyle: TextStyle(
  color: Colors.black,
  fontSize: 16,
  fontWeight: FontWeight.bold,
),
noResultsWidget: Text(
    'No items found',
    style: TextStyle(
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

Found a bug or want a new feature? Open an issue in the Github repository of the project.
