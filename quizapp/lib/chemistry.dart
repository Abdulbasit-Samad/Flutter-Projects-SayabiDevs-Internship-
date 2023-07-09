import 'package:flutter/material.dart';
import 'package:quizapp/Sections.dart';
class Chemistry extends StatefulWidget {
  const Chemistry({Key? key}) : super(key: key);

  @override
  State<Chemistry> createState() => _ChemistryState();
}

class _ChemistryState extends State<Chemistry> {
  double? _dheight,_dwidth;
  bool check=true;
  int score=0;
  List <Question> questions =getQuestions();
  int index=0;
  @override
  Widget build(BuildContext context) {
     _dheight= MediaQuery.of(context).size.height;
     _dwidth=MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
           child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
          children: [showQuestion(),options(),
              Row(
                children: [showMarks(),nextbutton()],
              )
              ]
          ),
        ),
    );
  }
  Widget showQuestion(){
    String q=questions[index].questionText;
    int n=index+1;
    return Container(
      margin: const EdgeInsets.only(top: 20),
    child: SizedBox(
      height: 220,
      width: 400,
      child: Card(
        color: const Color.fromARGB(255, 248, 250, 107),
          child: Column(
       mainAxisSize: MainAxisSize.max,
      children: [Text(" \nQuestion 0$n :",overflow: TextOverflow.ellipsis,textAlign: TextAlign.start,style: const TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic)),
                 Text("  \n$q",textAlign: TextAlign.start,style: const TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold))],
      ),
      ),
    ),
    );
  }
  Widget _textbutton(int v){
  String a=questions[index].answersList[v].answerText;
   return Container(
    margin: const EdgeInsets.only(top: 15),
    width: _dwidth!*0.95,
    height: _dheight!*0.09,
    decoration:  BoxDecoration(
      color:check?Colors.deepOrange:questions[index].answersList[v].isCorrect?Colors.green:Colors.red,
      borderRadius: BorderRadius.circular(9),
    ),
    child: MaterialButton(onPressed: () {
     setState(() {
       if(questions[index].answersList[v].isCorrect && check==true){
        score++;
       }
       check=false;
     });
    },
    child:  Text(" $a",style: const TextStyle(fontSize: 25,fontWeight: FontWeight.w900,color: Colors.black),),
    ),
   );
}
Widget options(){
  return Container(
    padding: const EdgeInsets.only(top:30),
   child:  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [_textbutton(0),_textbutton(1),_textbutton(2),_textbutton(3)],
  ),
  );
}
Widget nextbutton(){
  return Container(
    margin: const EdgeInsets.only(top: 30,left: 80),
    width: _dwidth!*0.25,
    height: _dheight!*0.07,
    decoration: const BoxDecoration(
      color:  Colors.white,
    ),
    child: MaterialButton(onPressed: () {
      if(check==false){
      if(index<4)
      {
      setState(() {
        index++;
        check=true;
      });
      }
      else if(index==4){
         Navigator.push( context, MaterialPageRoute(builder: (context) => const Portions()),);
      }
    }
    },
    child:const Text("Next",style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 25),),),
  );
}
Widget showMarks(){
  return  Container(
    margin: const EdgeInsets.only(left:30,top:20),
  child:Text("MARKS : 0$score",style: const TextStyle(color: Colors.white54,fontSize: 25,fontWeight: FontWeight.w600),),
  );
}
}
class Question {
  final String questionText;
  final List<Answer> answersList;

  Question(this.questionText, this.answersList);
}

class Answer {
  final String answerText;
  final bool isCorrect;

  Answer(this.answerText, this.isCorrect);
}
List<Question> getQuestions() {
  List<Question> list = [];
  list.add(Question(
    "Avogardo number is denoted by",
    [
      Answer("Ga", false),
      Answer("Na", true),
      Answer("La", false),
      Answer("Za", false),
    ],
  ));

  list.add(Question(
    "This element is radioactive",
    [
      Answer("Francium", true),
      Answer("Chlorine", false),
      Answer("Sodium", false),
      Answer("Oxygen", false),
    ],
  ));

  list.add(Question(
    "1 mole of a gas at STP accuires",
    [
      Answer("48.4 dm3", false),
      Answer("20", false),
      Answer("19.67", false),
      Answer("22.4 dm3", true),
    ],
  ));

  list.add(Question(
    "It is very strong acid ",
    [
      Answer("Phosphoric acid", false),
      Answer("Hydrochloric acid", false),
      Answer("Nitric acid", false),
      Answer("Sulphuric acid", true),
    ],
  ));
  list.add(Question(
    "CH4 is a pure _____ compound",
    [
      Answer("ionic", false),
      Answer("covalent", true),
      Answer("co-ordinate covalent", false),
      Answer("none of these", false),
    ],
  ));

  return list;
}