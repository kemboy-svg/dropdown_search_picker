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
  flutter_dropdown_search:
    git:
      url: https://github.com/your-repo/flutter_dropdown_search.git
```

Or after publishing:

```yaml
dependencies:
  flutter_dropdown_search: ^1.0.0
```

Run:
```sh
flutter pub get
```

## Usage

Import the package:

```dart
import 'package:flutter_dropdown_search/flutter_dropdown_search.dart';
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



## License
MIT License

