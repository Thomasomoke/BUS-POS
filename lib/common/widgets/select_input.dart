import 'package:flutter/material.dart';

class SelectInput extends StatelessWidget {
  final List<String> items;
  final void Function(String item) onSelect;
  final String placeholder;
  final bool isEnabled;
  final double padding;
  final double fontsize;
  final double iconsize;

  const SelectInput({
    super.key,
    required this.items,
    required this.onSelect,
    this.placeholder = "Select",
    this.isEnabled = true,
    this.padding = 8.0,
    this.fontsize = 14,
    this.iconsize = 32,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnabled ? 1.0 : 0.6,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isEnabled
                ? Theme.of(context).primaryColor.withAlpha(200)
                : Colors.grey.shade400,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: EdgeInsets.all(padding),
        child: DropdownButtonHideUnderline(

          child: DropdownButton(
            
            hint: Text(
              placeholder,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: isEnabled ? Colors.black : Colors.grey,
                fontSize: fontsize,
              ),
            ),
            isDense: true,
            isExpanded: true,
            padding: EdgeInsets.symmetric(
              horizontal: padding / 2,
              vertical: padding,
            ),
            iconSize: iconsize,
            icon: const Icon(Icons.keyboard_arrow_down),

            onChanged: isEnabled
                ? (String? newValue) {
                    if (newValue != null) {
                      onSelect(newValue);
                    }
                  }
                : null,

            items: items.map((String item) {
              return DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall!.copyWith(fontSize: 14),
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
