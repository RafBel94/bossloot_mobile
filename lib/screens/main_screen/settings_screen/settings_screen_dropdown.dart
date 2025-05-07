import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreenDropdown extends StatelessWidget {
  final String label;
  final String selectedValue;
  final Map<String, String> options;
  final ValueChanged<String?> onChanged;

  const SettingsScreenDropdown({
    super.key,
    required this.label,
    required this.selectedValue,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Label
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              label,
              style: GoogleFonts.pressStart2p(
                color: Colors.amber,
                fontSize: 12,
                shadows: const [
                  Shadow(
                    offset: Offset(1, 1),
                    color: Color.fromARGB(255, 202, 10, 199),
                  ),
                ],
              ),
            ),
          ),

          // Dropdown
          Container(
            height: 48,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 63, 8, 73),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: const Color.fromARGB(255, 223, 64, 251),
                width: 2,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(100, 223, 64, 251),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  value: selectedValue,
                  isExpanded: true,
                  dropdownColor: const Color.fromARGB(255, 63, 8, 73),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.amber,
                    size: 24,
                  ),
                  items: options.entries.map((entry) {
                    return DropdownMenuItem<String>(
                      value: entry.key,
                      child: Text(
                        entry.value,
                        style: GoogleFonts.pressStart2p(
                          color: Colors.amber,
                          fontSize: 12,
                          shadows: const [
                            Shadow(
                              offset: Offset(1, 1),
                              color: Color.fromARGB(255, 202, 10, 199),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: onChanged,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
