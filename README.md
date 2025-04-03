# Flutter Dropdown Search

A customizable and searchable dropdown widget for Flutter. This package allows users to select an item from a list with an intuitive search functionality.

## Features
- Dropdown selection with search functionality
- Customizable UI
- Generic type support for flexible item types
- Supports both light and dark themes

## Installation
Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  dropdown_search_picker:
    git:
      url: https://github.com/dropdown_search_picker/flutter_dropdown_search.git
```

Or after publishing:

```yaml
dependencies:
  dropdown_search_picker: ^1.0.0
```

Run:
```sh
flutter pub get
```

## Usage

Import the package:

```dart
import 'package:dropdown_search_picker/dropdown_search_picker.dart';
```

Use the widget:

```dart
CustomDropdownPicker<String>(
  title: 'Select a location',
  items: ['Kitengela', 'Nairobi', 'Bhaghatell', 'Port-louis','Grand Bay'],
  getItemLabel: (item) => item,
  onItemSelected: (item) {
    print('Selected: $item');
  },
  initial: 'Select a location',
)
```

## Customization
- **title**: Sets the label for the dropdown.
- **items**: A list of items to be displayed.
- **getItemLabel**: A function to extract the display label from the item.
- **onItemSelected**: A callback function when an item is selected.
- **initial**: Placeholder text before selection.

## Contributions

Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an [issue](https://github.com/kemboy-svg/dropdown_search_picker/issues).  
If you fixed a bug or implemented a feature, please send a [pull request](https://github.com/kemboy-svg/dropdown_search_picker/pulls).



## License
MIT License

