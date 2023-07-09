import 'package:flutter/material.dart';
import 'package:quizapp/chemistry.dart';
import 'package:quizapp/english.dart';
import 'package:quizapp/maths.dart';
import 'package:quizapp/physics.dart';
class Portions extends StatefulWidget {
  const Portions({Key? key}) : super(key: key);

  @override
  State<Portions> createState() => _PortionsState();
}

class _PortionsState extends State<Portions> {
  final _items = ["          PHYSICS","          MATHS","          CHEMISTRY","          ENGLISH"];
  bool check=false;
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedList(
        key: _key,
        initialItemCount: 0,
        padding: const EdgeInsets.only(top:100,left:5,right: 5),
        itemBuilder: (_, index, animation) {
          return SizeTransition(
            key: UniqueKey(),
            sizeFactor: animation,
            child: Card(
              margin: const EdgeInsets.all(25),
              elevation: 10,
              color: const Color.fromARGB(255, 223, 146, 203),
              child: ListTile(
                onTap: () {
                     if(index==0){
                     Navigator.push( context, MaterialPageRoute(builder: (context) => const Physics()),);
                     }
                     else if(index==1){
                      Navigator.push( context, MaterialPageRoute(builder: (context) => const Maths()),);
                     }
                     else if(index==2){
                       Navigator.push( context, MaterialPageRoute(builder: (context) => const Chemistry()),);
                     }
                     else{
                       Navigator.push( context, MaterialPageRoute(builder: (context) => const English()),);
                     }
                },
                contentPadding: const EdgeInsets.all(15),
                title:
                    Text(_items[index], style: const TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold)),
              ),
            ),
            
          );
        },
      ),
      floatingActionButton: Container(
         height: 100,
         width: 150,
         margin: const EdgeInsets.only(right: 100),
      child: FloatingActionButton(
          onPressed: (){
             if(check==false){
             check=true;
            _addItem();
             }
          }, child: const Text("CLICK",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
      ),
      ),
    );
  }
  void _addItem() {
     for(int i=0;i<4;i++){
    _key.currentState!.insertItem(0, duration: const Duration(seconds: 1));}
  }
}