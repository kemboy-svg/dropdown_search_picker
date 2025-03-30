library;

import 'package:flutter/material.dart';

class DropdownSearchPicker<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final String Function(T) getItemLabel;
  final Function(T) onItemSelected;
  final String? initial;

  const DropdownSearchPicker({
    required this.title,
    required this.items,
    required this.getItemLabel,
    required this.onItemSelected,
    this.initial,
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DropdownSearchPickerState<T> createState() =>
      _DropdownSearchPickerState<T>();
}

class _DropdownSearchPickerState<T> extends State<DropdownSearchPicker<T>> {
  T? selectedItem;
  final TextEditingController _searchController = TextEditingController();
  late List<T> filteredItems;
  bool isDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    filteredItems = List.from(widget.items);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _toggleDropdown,
          child: InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              labelText: selectedItem != null
                  ? widget.title
                  : "Select ${widget.title}",
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(selectedItem != null
                    ? widget.getItemLabel(selectedItem!)
                    : widget.initial ?? ''),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        if (isDropdownOpen)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  cursorColor: Colors.blueAccent,
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onChanged: _filterItems,
                ),
                const SizedBox(height: 10),
                Container(
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(widget.getItemLabel(filteredItems[index])),
                        onTap: () => _selectItem(filteredItems[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  void _filterItems(String query) {
    setState(() {
      filteredItems = query.isEmpty
          ? List.from(widget.items)
          : widget.items.where((item) => widget.getItemLabel(item).toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  void _selectItem(T item) {
    setState(() {
      selectedItem = item;
      isDropdownOpen = false;
      _searchController.clear();
    });
    widget.onItemSelected(item);
  }

  void _toggleDropdown() {
    setState(() {
      isDropdownOpen = !isDropdownOpen;
      if (isDropdownOpen) {
        filteredItems = List.from(widget.items);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
