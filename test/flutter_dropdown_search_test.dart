import 'package:dropdown_search_picker/dropdown_search_picker.dart';
import 'package:flutter_test/flutter_test.dart';

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
