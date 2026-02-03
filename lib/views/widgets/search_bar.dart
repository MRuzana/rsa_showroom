import 'package:flutter/material.dart';
import 'package:rsa_showroom/core/utils/debouncer.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();
  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  @override
  void dispose() {
    _searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  // void _onSearchChanged(String query) {
  //   final provider = Provider.of<BookingListProvider>(context, listen: false);
  //   _debouncer.run(() {
  //     if (query.trim().isEmpty) {
  //       provider.fetchBookings(reset: true);
  //     } else {
  //       provider.searchBookings(query.trim());
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Search",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                  //  _onSearchChanged('');
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  
                ),
              ),
              // onChanged: _onSearchChanged,
              // onSubmitted: _onSearchChanged,
            ),
          ),
        ],
      ),
    );
  }
}

