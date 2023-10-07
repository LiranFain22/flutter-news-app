import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  String search;
  String fromDate;
  String toDate;
  final Function(String, String, String) onSearch;

  SearchBar({
    super.key,
    required this.search,
    required this.fromDate,
    required this.toDate,
    required this.onSearch,
  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _dateFROMController = TextEditingController();
  final TextEditingController _dateTOController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          // Search Textfield
          TextField(
            onChanged: (searchKey) {
              widget.search = searchKey;
            },
            decoration: InputDecoration(
              hintText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: const Icon(Icons.search),
            ),
          ),

          const SizedBox(height: 5),

          // From and To Date's Textfield
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _dateFROMController,
                  decoration: InputDecoration(
                    hintText: 'Date From',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.calendar_month_outlined),
                  ),
                  readOnly: true,
                  onTap: () {
                    _selectDate(_dateFROMController, true);
                  },
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: TextField(
                  controller: _dateTOController,
                  decoration: InputDecoration(
                    hintText: 'Date From',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.calendar_month_outlined),
                  ),
                  readOnly: true,
                  onTap: () {
                    _selectDate(_dateTOController, false);
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 5),

          // Search buttom
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    widget.onSearch(
                        widget.search, widget.fromDate, widget.toDate);
                  },
                  icon: const Icon(Icons.search),
                  label: const Text('Search'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(
      TextEditingController textEditingController, bool isFromDate) async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (_picked != null) {
      setState(() {
        textEditingController.text =
            "${_picked.year}-${_picked.month}-${_picked.day}";
      });

      if (isFromDate) {
        widget.fromDate = textEditingController.text;
      } else {
        widget.toDate = textEditingController.text;
      }
    }
  }
}
