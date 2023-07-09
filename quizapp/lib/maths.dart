import 'package:flutter/material.dart';
import 'package:quizapp/Sections.dart';
class Maths extends StatefulWidget {
  const Maths({Key? key}) : super(key: key);

  @override
  State<Maths> createState() => _MathsState();
}

class _MathsState extends State<Maths> {
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
    "Pi is a/an ____ number or not ?",
    [
      Answer("Rational", false),
      Answer("Irrational", true),
      Answer("Natural", false),
      Answer("Integer", false),
    ],
  ));

  list.add(Question(
    "Circumference of circle is determined by?",
    [
      Answer("2(pi)r", true),
      Answer("(pi)r*r", false),
      Answer("(pi)r", false),
      Answer("4(pi)r*r*r", false),
    ],
  ));

  list.add(Question(
    "Natural Logarithm has the base ?",
    [
      Answer("10", false),
      Answer("20", false),
      Answer("e", true),
      Answer("g", false),
    ],
  ));

  list.add(Question(
    "Union of a set with its complement is equal to ",
    [
      Answer("Null set", false),
      Answer("Disjoint set", false),
      Answer("Empty set", false),
      Answer("Universal set", true),
    ],
  ));
  list.add(Question(
    "cos60 is equal to ",
    [
      Answer("1/2", true),
      Answer("3/2", false),
      Answer("4", false),
      Answer("5", false),
    ],
  ));

  return list;
}