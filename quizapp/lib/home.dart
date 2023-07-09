import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizapp/Sections.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? _dheight,_dwidth;
  @override
  Widget build(BuildContext context) {
    _dheight=MediaQuery.of(context).size.height;
    _dwidth=MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child:Center(
        child: Container(
          margin: EdgeInsets.only(top: _dheight!/2.8),
         child: Column(
          children: [_animatedtext(),_buttons()],
        ),
      ),
      ),
      ),
    );
    
  }
  Widget _animatedtext(){
    return const Text("Quiz App",style: TextStyle(color: Colors.white,fontSize: 80,fontWeight: FontWeight.bold));
  }
  Widget _custombutton(String name){
    return  Container(
      height: _dheight!*0.08,
      width: _dwidth!*0.3,
      margin: const EdgeInsets.only(top: 150,right: 20),
      decoration:  BoxDecoration(
        color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      ),
    child:  MaterialButton(onPressed: (() { 
      if(name=="EXIT"){
        SystemNavigator.pop();
      }
      else{
        Navigator.push( context, MaterialPageRoute(builder: (context) => const Portions()),);
      }
    }),
    child: Text(" $name",style: const TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),)
    ),
    );
  }
  Widget _buttons(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [_custombutton("START"),_custombutton("EXIT")],
    );
  }
}