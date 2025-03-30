import 'package:flutter_test/flutter_test.dart';
import 'package:dropdown_search/dropdown_search_picker.dart';

void main() {
  test('Dropdown initializes correctly', () {
    final dropdown = DropdownSearchPicker<String>(
      title: 'Test',
      items: ['Form', 'Form', 'Three', 'Four'],
      getItemLabel: (item) => item,
      onItemSelected: (item) {},
    );
    expect(dropdown.items.length, 3);
  });
}
