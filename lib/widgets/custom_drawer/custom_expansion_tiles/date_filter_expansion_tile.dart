import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      title: Row(children: [Icon(Icons.calendar_month), SizedBox(width: 10), Text(AppLocalizations.of(context)!.app_date)],),
        children: [
          ListTile(
            contentPadding: EdgeInsets.only(left: 40),
            tileColor: const Color.fromARGB(255, 242, 242, 242),
            title: Row(children: [Icon(Icons.arrow_upward), SizedBox(width: 10), Text(AppLocalizations.of(context)!.app_ascending)],),
            onTap: () {
              // Handle sub-item 1 tap
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 40),
            tileColor: const Color.fromARGB(255, 242, 242, 242),
            title: Row(children: [Icon(Icons.arrow_downward), SizedBox(width: 10), Text(AppLocalizations.of(context)!.app_descending)],),
            onTap: () {
              // Handle sub-item 2 tap
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 40),
            tileColor: const Color.fromARGB(255, 242, 242, 242),
            title: Row(
              children: [
                Text('${AppLocalizations.of(context)!.app_from}: '),
                SizedBox(width: 10),
                Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(AppLocalizations.of(context)!.app_choose, style: TextStyle(color: Colors.black),),
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
                Text('${AppLocalizations.of(context)!.app_to}: '),
                SizedBox(width: 30),
                Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: Colors.white, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(AppLocalizations.of(context)!.app_choose, style: TextStyle(color: Colors.black),),
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