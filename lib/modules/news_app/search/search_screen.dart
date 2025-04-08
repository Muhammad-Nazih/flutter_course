import 'package:first_pro/shared/components/components.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: defaultFormField(
              controller: searchController,
              type: TextInputType.text,
              validate: (String? value) {
                if (value!.isEmpty) {
                  return 'search must not be empty';
                }
                return null;
              },
              label: 'search',
              prefix: Icons.search,
            ),
          ),
        ],
      ),
    );
  }
}
