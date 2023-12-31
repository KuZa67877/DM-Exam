import 'package:dmiti_project/res/colors.dart';
import 'package:dmiti_project/res/text.dart';
import 'package:dmiti_project/res/theme.dart';
import 'package:flutter/material.dart';

class DropDownMenuButton extends StatefulWidget {
  final List<String> list;
  final bool isInfo;
  const DropDownMenuButton(
      {Key? key,
      required this.isInfo,
      required this.updateWidgets,
      required this.list})
      : super(key: key);

  final Function(String) updateWidgets;

  @override
  State<DropDownMenuButton> createState() =>
      _DropDownMenuButtonState(isInfo: isInfo);
}

class _DropDownMenuButtonState extends State<DropDownMenuButton> {
  final theme = getTheme();
  String? dropItem;
  bool isInfo;

  _DropDownMenuButtonState({required this.isInfo}) {
    (isInfo) ? dropItem = "Информация" : dropItem = AppStrings.diofantLittle;
  }

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
              items: widget.list
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ),
                  )
                  .toList(),
              onChanged: (item) {
                setState(() {
                  dropItem = item!;
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
