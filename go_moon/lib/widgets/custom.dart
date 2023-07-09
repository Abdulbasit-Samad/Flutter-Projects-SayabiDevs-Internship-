import 'package:flutter/material.dart';

class CustomDropDownButtonClass extends StatelessWidget {
  List<String> values;
  double wid;
  CustomDropDownButtonClass({Key? key, required this.values, required this.wid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: wid,
      padding: EdgeInsets.symmetric(horizontal: wid * 0.05),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(
          10,
        ),
        border: Border.all(
          width: 1,
        ),
      ),
      child: DropdownButton(
        onChanged: (_) {},
        value: values.first,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        items: values.map(
          (e) {
            return DropdownMenuItem(
              child: Text(e),
              value: e,
            );
          },
        ).toList(),
        underline: Container(),
        dropdownColor: const Color.fromRGBO(53, 53, 53, 1.0),
      ),
    );
  }
}
