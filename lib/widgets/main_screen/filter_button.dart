import 'package:flutter/material.dart';

class FilterButton extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const FilterButton({super.key, required this.scaffoldKey, });

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      right: 0,
      child: ElevatedButton(
        onPressed: () {
            widget.scaffoldKey.currentState?.openEndDrawer();
          },
          style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.white, width: 2),
            borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            )
          ),
          backgroundColor: Color(0xFFECD3FF),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.filter_alt, color: Colors.black, size: 22,),
            SizedBox(width: 8),
            Text("Filter", style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}