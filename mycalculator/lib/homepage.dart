import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
//import 'package:audioplayers/audioplayers.dart';
class CalculatorHomnePage extends StatefulWidget {
  const CalculatorHomnePage({ Key? key }) : super(key: key);

  @override
  State<CalculatorHomnePage> createState(){
    return _CalculatorHomnePageState();
  }
}

class _CalculatorHomnePageState extends State<CalculatorHomnePage> with TickerProviderStateMixin {
  AudioPlayer? _click,_beep;
   double? fn,sn,ans,_dheight,_dwidth;
   bool check=false;
   late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );
  @override
  void disposeone() {
    _controller.dispose();
    super.dispose();
  }
    @override
  void disposeclick(){
    _click?.dispose();
    super.dispose();
  }
  void disposebeep(){
    _beep?.dispose();
    super.dispose();
  }
  void _playclick(){
    _click?.dispose();
    final player=AudioPlayer();
    player.play(AssetSource('click.mp3'),volume: 0.3);
  }
  void _playbeep(){
     _beep?.dispose();
    final player=AudioPlayer();
    player.play(AssetSource('beep.mp3'),volume: 0.1);
  }
  @override
  Widget build(BuildContext context) {
    _dheight=MediaQuery.of(context).size.height;
    _dwidth=MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
      child: SafeArea(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment:MainAxisAlignment.center,
            children: [animatedTitle(),_setOfInputField(),_setOfArithmeticButtons(),_showResult()]
          ),
        ),
      ),
    );
  }
   Widget _inputField(String p,int n){
      return Container(
            padding: const EdgeInsets.only(top: 25,right: 10,left: 10),
            child:TextField(
              style: const TextStyle(fontSize: 25),
              onSubmitted: (value) {
                final List l=value.split('.');
                if(value.isNotEmpty && l.length-1 <= 1){
                setState(() {
                  if(n==1){
                    fn=double.parse(value);
                  }
                  else{
                    sn=double.parse(value);
                  }
                });
                }
                else{
                  if(n==1){
                    fn=null;
                  }
                  else{
                    sn=null;
                  }
                  check=false;
                  ans=null;
                  showErrorMessage();
                }
              },
              onChanged: (value) {
                setState(() {
                  _playbeep();
                });
              },
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]'))],
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: " $p",
                labelStyle: const TextStyle(fontSize: 24,color: Color.fromRGBO(3, 2, 2, 1),fontStyle: FontStyle.italic,fontWeight: FontWeight.w400),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3, color: Colors.black87),
                  borderRadius: BorderRadius.circular(12),
                ),
                   focusedBorder: UnderlineInputBorder(
                   borderSide: const BorderSide(width: 3, color: Colors.black87),
                   borderRadius: BorderRadius.circular(15),
                )
                ),
            ),
                );
  }
  Widget _setOfInputField(){
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_inputField("Enter number", 1),_inputField("Enter number", 2)],
    );
  }
  Widget _arithmeticButton(String sign){
     return Container(
      margin: const EdgeInsets.only(top: 10,left: 10),
      width: _dwidth!*0.25,
      height: _dheight!*0.095,
      decoration:const BoxDecoration(
        color: Color.fromRGBO(66, 61, 54, 1),
      ),
      child: MaterialButton(onPressed: () {
        _playclick();
        if(sign=="+"){
          if(fn!=null && sn!=null){
          setState(() {
            ans=fn! + sn!;
            check=true;
          });
        }
        }
        else if(sign=="-"){
          if(fn!=null && sn!=null){
          setState(() {
            ans=fn! - sn!;
            check=true;
          });
        }
        }
        else if(sign=="x"){
          if(fn!=null && sn!=null){
          setState(() {
            ans=fn! * sn!;
            check=true;
          });
        }
        }
        else{
          if(fn!=null && sn!=null){
          setState(() {
            ans=fn! / sn!;
            check=true;
          });
        }
        }
      },
      child: Text(sign,style: const TextStyle(color: Colors.white,fontSize: 50)),
      ),
     );
  }
  Widget _setOfArithmeticButtons(){
     return  Container(
        margin: const EdgeInsets.only(top: 50,left: 75),
       child: Column(
      children: [Row(
        children: [_arithmeticButton("+"),_arithmeticButton("-")],
      ),Row(
        children: [_arithmeticButton("x"),_arithmeticButton("/")],
      )],
       ),
     );
  }
  void showErrorMessage(){
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          backgroundColor: Colors.transparent,
          behavior: SnackBarBehavior.floating,
          elevation: 0,
          content:  Container(
            padding: const EdgeInsets.all(16),
            height: 90,
            width: 20,
            decoration: const BoxDecoration(
              color: Color(0xFFC72C41),
              borderRadius:BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(
               children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.white,
                  size: 40,
                ),
                const SizedBox(width: 20,),
                Expanded(
                  child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ Text(
              "Oops!",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Color.fromRGBO(252, 252, 252, 1))),
              const Text("An Error Occured",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Color.fromRGBO(252, 252, 252, 1)),maxLines: 2,overflow: TextOverflow.ellipsis,),
                ],
            )
            )] 
            ), 
            ),
          ),
        );
      
  }
  Widget _showResult(){
     return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(top: 80),
      child: check?
    Text(
      "=  $ans",style:const TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),
    ):null,
    );
  }
  Widget animatedTitle(){
    return ScaleTransition(
          scale: _animation,
          child: Container(
            child: const Text("CALCULATOR",
       style: TextStyle(fontSize: 57,color: Color.fromRGBO(12, 9, 217, 1),fontWeight: FontWeight.w900),
      ),
          )
        );
  }
}