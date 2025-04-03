library;

import 'package:flutter/material.dart';

class DropdownSearchPicker<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final String Function(T) getItemLabel;
  final Function(List<T>) onItemSelected;
  final String? initial;
  final bool multiSelect;

  const DropdownSearchPicker({
    required this.title,
    required this.items,
    required this.getItemLabel,
    required this.onItemSelected,
    this.initial,
    this.multiSelect = false,
    super.key,
  });

  @override
  _DropdownSearchPickerState<T> createState() =>
      _DropdownSearchPickerState<T>();
}

class _DropdownSearchPickerState<T> extends State<DropdownSearchPicker<T>> {
  List<T> selectedItems = [];
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
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
              labelText: selectedItems.isNotEmpty
                  ? widget.title
                  : "Select ${widget.title}",
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    selectedItems.isNotEmpty
                        ? (selectedItems.length == 1
                            ? widget.getItemLabel(
                                selectedItems.first) 
                            : selectedItems
                                .map(widget.getItemLabel)
                                .join(", "))
                        : widget.initial ?? '',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
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
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 12),
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
                      final item = filteredItems[index];
                      final isSelected = selectedItems.contains(item);
                      return ListTile(
                        title: Text(widget.getItemLabel(item)),
                        leading: widget.multiSelect
                            ? Checkbox(
                                value: isSelected,
                                onChanged: (_) => _toggleSelection(item),
                              )
                            : null,
                        onTap: () {
                          if (widget.multiSelect) {
                            _toggleSelection(item);
                          } else {
                            _selectSingleItem(item);
                          }
                        },
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
          : widget.items
              .where((item) => widget
                  .getItemLabel(item)
                  .toLowerCase()
                  .contains(query.toLowerCase()))
              .toList();
    });
  }

  void _toggleSelection(T item) {
    setState(() {
      if (selectedItems.contains(item)) {
        selectedItems.remove(item);
      } else {
        selectedItems.add(item);
      }
    });
    widget.onItemSelected(selectedItems); // Notify parent widget instantly
  }

  void _selectSingleItem(T item) {
    setState(() {
      selectedItems = [item];
      isDropdownOpen = false;
      _searchController.clear();
    });
    widget.onItemSelected(selectedItems);
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
