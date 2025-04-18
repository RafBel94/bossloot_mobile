// ignore_for_file: must_be_immutable

import 'package:bossloot_mobile/domain/models/category.dart';
import 'package:flutter/material.dart';

class CategoryFilterExpansionTile extends StatefulWidget {
  List<Category> categories = [];
  CategoryFilterExpansionTile({super.key, required this.categories});

  @override
  State<CategoryFilterExpansionTile> createState() => _CategoryFilterExpansionTileState();
}

class _CategoryFilterExpansionTileState extends State<CategoryFilterExpansionTile> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      backgroundColor: const Color.fromARGB(255, 220, 220, 220),
      shape: RoundedRectangleBorder(
      side: BorderSide(
        color: const Color.fromARGB(255, 204, 204, 204),
      ),
      ),
      title: Row(
      children: [
        Icon(Icons.category_outlined),
        SizedBox(width: 10),
        Text('Category'),
      ],
      ),
      children: widget.categories.map((category) {
        return ListTile(
          contentPadding: EdgeInsets.only(left: 40),
          tileColor: const Color.fromARGB(255, 242, 242, 242),
          title: Row(
            children: [
              Icon(Icons.more_horiz_outlined),
              SizedBox(width: 10),
              Text(category.name),
            ],
          ),
          onTap: () {

          },
        );
      }).toList(),
    );
  }
}