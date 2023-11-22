import 'package:dmiti_project/res/colors.dart';
import 'package:dmiti_project/res/text.dart';
import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';

class DropDownMenuButton extends StatefulWidget {
  const DropDownMenuButton({Key? key, required this.updateWidgets})
      : super(key: key);

  final Function(String) updateWidgets;

  @override
  State<DropDownMenuButton> createState() => _DropDownMenuButtonState();
}

class _DropDownMenuButtonState extends State<DropDownMenuButton> {
  List<String> list = <String>[
    AppStrings.diofantLittle,
    AppStrings.inverseElevent,
    AppStrings.nod,
    AppStrings.continuedFraction,
    AppStrings.suitableFraction,
    AppStrings.diafantBig
  ];
  String? dropItem = AppStrings.diofantLittle;
  final theme = getTheme();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 200,
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.grayContainer,
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: DropdownButton<String>(
              value: dropItem,
              items: list
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
              onChanged: (item) {
                setState(() {
                  dropItem = item;
                });
                widget.updateWidgets(item!);
              },
              icon: const Icon(Icons.arrow_drop_down_outlined),
              iconSize: 24,
              elevation: 16,
              style: theme.textTheme.bodyLarge,
              underline: Container(),
              isExpanded: true,
              dropdownColor: AppColors.grayContainer,
            ),
          ),
        ),
      ],
    );
  }
}
