import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dropdown_search/flutter_dropdown_search.dart';

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
