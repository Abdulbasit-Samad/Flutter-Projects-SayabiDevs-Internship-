import 'package:flutter/material.dart';
import 'package:go_moon/widgets/custom.dart';

class HomePage extends StatelessWidget {
  late double _dheight, _dwidth;
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _dheight = MediaQuery.of(context).size.height;
    _dwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: _dwidth * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _pageTitle(),
                  _CombineFunction(),
                ],
              ))),
    );
  }

  Widget _RowFunctions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _SecondDropDown(),
        _ThirdDropDown(),
      ],
    );
  }

  Widget _AstroPicture() {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets\images\astronautimg.png")),
        ),
      ),
    );
  }

  Widget _BookRide() {
    return Container(
        margin: EdgeInsets.only(bottom: _dwidth * 0.05),
        width: _dwidth,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.5)),
        child: MaterialButton(
          height: _dheight * 0.09,
          onPressed: () {},
          child: Text("BOOK RIDE !",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: 20,
              )),
        ));
  }

  Widget _CombineFunction() {
    return Container(
      height: _dheight * 0.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _FirstDropDown(),
          _RowFunctions(),
          _BookRide(),
        ],
      ),
    );
  }

  Widget _pageTitle() {
    return const Text(
      "#TASK1\n(APP)",
      style: TextStyle(
          color: Colors.white, fontSize: 60, fontWeight: FontWeight.w800),
    );
  }

  Widget _SecondDropDown() {
    List<String> _items = [
      '1',
      '2',
      '3',
      '4',
    ];
    return CustomDropDownButtonClass(values: _items, wid: _dwidth * 0.4);
  }

  Widget _FirstDropDown() {
    List<String> _items = [
      'James Well Station',
      'Loraine Station',
      'Michael Station',
    ];
    return CustomDropDownButtonClass(values: _items, wid: _dwidth);
  }

  Widget _ThirdDropDown() {
    List<String> _items = [
      'Economy',
      'Socially',
      'partially',
    ];
    return CustomDropDownButtonClass(values: _items, wid: _dwidth * 0.45);
  }
}
