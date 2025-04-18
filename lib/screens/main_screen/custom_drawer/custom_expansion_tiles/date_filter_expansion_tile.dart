import 'package:flutter/material.dart';

class DateFilterExpansionTile extends StatefulWidget {
  const DateFilterExpansionTile({super.key});

  @override
  State<DateFilterExpansionTile> createState() => _DateFilterExpansionTileState();
}

class _DateFilterExpansionTileState extends State<DateFilterExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      backgroundColor: const Color.fromARGB(255, 220, 220, 220),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: const Color.fromARGB(255, 204, 204, 204)
        )
      ),
      title: Row(children: [Icon(Icons.calendar_month), SizedBox(width: 10), Text('Date')],),
        children: [
          ListTile(
            contentPadding: EdgeInsets.only(left: 40),
            tileColor: const Color.fromARGB(255, 242, 242, 242),
            title: Row(children: [Icon(Icons.arrow_upward), SizedBox(width: 10), Text('Ascendent')],),
            onTap: () {
              // Handle sub-item 1 tap
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 40),
            tileColor: const Color.fromARGB(255, 242, 242, 242),
            title: Row(children: [Icon(Icons.arrow_downward), SizedBox(width: 10), Text('Descendent')],),
            onTap: () {
              // Handle sub-item 2 tap
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 40),
            tileColor: const Color.fromARGB(255, 242, 242, 242),
            title: Row(
              children: [
                Text('From: '),
                SizedBox(width: 10),
                Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Choose', style: TextStyle(color: Colors.black),),
                  onPressed: () {}                          )
                ),
                SizedBox(width: 30,)
              ],
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 40),
            tileColor: const Color.fromARGB(255, 242, 242, 242),
            title: Row(
              children: [
                Text('To: '),
                SizedBox(width: 30),
                Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Choose', style: TextStyle(color: Colors.black),),
                  onPressed: () {}                          )
                ),
                SizedBox(width: 30,)
              ],
            ),
          ),
        ],
    );
  }
}