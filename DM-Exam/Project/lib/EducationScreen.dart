import 'package:dmiti_project/algorithms/evklid_classes.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EducationScreen extends StatefulWidget {
  const EducationScreen({Key? key}) : super(key: key);

  @override
  State<EducationScreen> createState() => _EducationScreenState();
}

class _EducationScreenState extends State<EducationScreen> {
  var showWidgetOne = true;
  var showWidgetTwo = false;
  var showWidgetThree = false;

  void updateWidgets(String item) {
    setState(() {
      showWidgetOne = item == 'One';
      showWidgetTwo = item == 'Two';
      showWidgetThree = item == 'Three';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 252, 254),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 250, 252, 254),
          title: SizedBox(
            child: Column(
              children: const [
                Center(
                  child: Text(
                    "Обучение",
                    style: TextStyle(
                      color: Color.fromARGB(255, 36, 36, 63),
                      fontFamily: 'WorkSans',
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Align(
              child: DropDownMenuButton(
                updateWidgets: updateWidgets,
              ),
              alignment: Alignment.bottomLeft,
            ),
          ),
          if (showWidgetOne) Info1(),
          if (showWidgetTwo) Info2(),
          if (showWidgetThree) Info3(),
          //Center(child: FieldExample()),
          Center(
            child: Row(
              children: [
                FieldExample(),
                FieldExample(),
                FieldExample(),
                FieldExample(),
                FieldExample()
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DropDownMenuButton extends StatefulWidget {
  DropDownMenuButton({Key? key, required this.updateWidgets}) : super(key: key);

  final Function(String) updateWidgets;

  @override
  State<DropDownMenuButton> createState() => _DropDownMenuButtonState();
}

class _DropDownMenuButtonState extends State<DropDownMenuButton> {
  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  String? dropItem = 'One';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: const Color.fromARGB(255, 225, 229, 235),
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
              style: const TextStyle(
                color: Color.fromARGB(255, 36, 36, 63),
                fontFamily: "WorkSans",
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              underline: Container(),
              isExpanded: true,
              dropdownColor: const Color.fromARGB(255, 225, 229, 235),
            ),
          ),
        ),
      ],
    );
  }
}

class Info1 extends StatelessWidget {
  const Info1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Padding(
          padding: EdgeInsets.only(top: 80, left: 10),
          child: Text(
            "Алгоритм Евклида",
            style: TextStyle(
              color: Color.fromARGB(255, 36, 36, 63),
              fontFamily: 'WorkSans',
              fontSize: 25,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, top: 15),
          child: Text(
            "",
            style: TextStyle(
              color: Color.fromARGB(255, 36, 36, 63),
              fontFamily: 'WorkSans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class Info2 extends StatelessWidget {
  const Info2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 267,
        height: 365,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 15, left: 20),
          child: Text(
            "Алгоритм Евклида",
            style: TextStyle(
              color: Color.fromARGB(255, 36, 36, 63),
              fontFamily: 'WorkSans',
              fontSize: 25,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}

class Info3 extends StatelessWidget {
  const Info3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 267,
        height: 365,
        color: Colors.red,
      ),
    );
  }
}

class FieldExample extends StatefulWidget {
  const FieldExample({super.key});

  @override
  State<FieldExample> createState() => _FieldExampleState();
}

class _FieldExampleState extends State<FieldExample> {
  late var len = Cepnaya().line1;
  var mask = '';
  var myController = TextEditingController();
  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(_printLatestValue);
  }

  void _printLatestValue() {
    print(len[0]);
    final text = myController.text;
    // List<String> coef = formatter.getMaskedText().split('-')
    if (text == len[0]) {
      print("Kringe");
    }
    print('Second text field: $text (${text.characters.length})');
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  MaskTextInputFormatter create_mask() {
    for (int i = 0; i < len.length; i++) {
      for (int j = 0; j < len[i].toString().length; j++) {
        mask = "$mask" + '#';
      }
      mask = "$mask" + '-';
    }
    mask = mask.substring(0, mask.length - 1);
    var maskFormatter = MaskTextInputFormatter(
        //вид примерный маски - ###-###-###-###-###-###
        mask: mask,
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
    return maskFormatter;
  }

  @override
  Widget build(BuildContext context) {
    print(len);
    var maskFormatter = create_mask();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 250,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color.fromARGB(255, 225, 229, 235),
        ),
        child: TextField(
          keyboardType: TextInputType.number,
          //maxLength: 3,
          decoration: InputDecoration(border: InputBorder.none, hintText: mask),
          inputFormatters: [maskFormatter],
          controller: myController,
        ),
      ),
    );
  }
}
