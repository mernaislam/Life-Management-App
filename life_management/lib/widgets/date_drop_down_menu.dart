import 'package:flutter/material.dart';

class DateDropDownMenu extends StatefulWidget {
  const DateDropDownMenu({super.key, required this.values});
  final List<String> values;
  @override
  State<DateDropDownMenu> createState() => _DateDropDownMenuState();
}

class _DateDropDownMenuState extends State<DateDropDownMenu> {
  @override
  Widget build(BuildContext context) {
    List<String> dropDownList = widget.values;
    String dropDownVal = dropDownList[0];
    return DropdownButtonHideUnderline(
     child: ButtonTheme(
       child: DropdownButton(
         dropdownColor:
             Theme.of(context).colorScheme.shadow.withOpacity(1),
         value: dropDownVal,
         icon: const SizedBox.shrink(),
         items: dropDownList
             .map(
               (day) => DropdownMenuItem(
                 value: day,
                 child: Text(
                   day,
                   style: TextStyle(
                     color: Theme.of(context)
                         .colorScheme
                         .onPrimary
                         .withOpacity(0.5),
                     fontSize: 18,
                   ),
                 ),
               ),
             )
             .toList(),
         onChanged: (newValue) {
           setState(() {
             dropDownVal = newValue!;
           });
         },
       ),
     ),
      );
  }
}
