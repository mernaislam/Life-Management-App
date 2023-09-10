import 'package:flutter/material.dart';

class TagsDropdownMenu extends StatefulWidget {
  const TagsDropdownMenu({super.key, required this.dropDownValue, required this.onChanged});
  final String dropDownValue;
  final void Function(String) onChanged;
  @override
  State<TagsDropdownMenu> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<TagsDropdownMenu> {
  late String dropDownVal;
  @override
  void initState() {
    dropDownVal = widget.dropDownValue;
    super.initState();
  }

  // String onChangedFun(String value){

  //   return value;
  // }
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton(
          borderRadius: BorderRadius.circular(25),
          dropdownColor: Theme.of(context).colorScheme.tertiary,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 25,
          ),
          icon: Icon(
            Icons.keyboard_arrow_down,
            size: 27,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          value: dropDownVal,
          items: ['Tags', 'Important', 'Work', 'Learn', 'Fun', 'Personal']
              .map(
                (tag) => DropdownMenuItem(
                  value: tag,
                  child: Text(tag),
                ),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              dropDownVal = value!;
            });
            widget.onChanged(value!);
          },
        ),
      ),
    );
  }
}
