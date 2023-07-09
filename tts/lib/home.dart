import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
class TssApp extends StatefulWidget {
  const TssApp({ Key? key }) : super(key: key);

  @override
  State<TssApp> createState() => _TssAppState();
}
enum TtsState {playing,stopped}
class _TssAppState extends State<TssApp> {
  late FlutterTts _flutterTts;
  late String _tts;
  late double _dheight,_dwidth;
  TtsState _ttsState = TtsState.stopped;
   @override
  void initState(){
     super.initState();
     initTts();
  }
  @override
  void dispose(){
    super.dispose();
    _flutterTts.stop();
  }
  initTts() async {
    _flutterTts = FlutterTts();
    await _flutterTts.awaitSpeakCompletion(true);
    _flutterTts.setStartHandler(() {
      setState(() {
        print("playing");
      _ttsState = TtsState.playing;
      });
    });
    _flutterTts.setCompletionHandler(() {
       setState(() {
         print("complete");
         _ttsState = TtsState.stopped;
       });
    });
    _flutterTts.setCancelHandler(() {
      setState(() {
        print("cancel");
        _ttsState=TtsState.stopped;
      });
    });
    _flutterTts.setErrorHandler((message) {
      setState(() {
        print("Error: $message");
        _ttsState=TtsState.stopped;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    _dheight=MediaQuery.of(context).size.height;
    _dwidth=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
      alignment: Alignment.center,
      child: Column(
        children: [input(),button()],
      ),
    ),
    );
  }
  Widget input(){
    return Container(
      padding: const EdgeInsets.only(top: 80),
      child: TextField(
         onChanged: (String value){
          setState(() {
            _tts=value;
          });
         },
      ),
    );
  }
  Widget button(){
    if(_ttsState ==   TtsState.stopped){
      return TextButton(onPressed: speak, 
       child: const Text('Play'),
      );
    }
    else{
      return TextButton(onPressed: stop, child: const Text('Stop'));
    }
  }
  Future speak() async {
     await _flutterTts.setVolume(1);
     await _flutterTts.setSpeechRate(0.5);
     await _flutterTts.setPitch(1);
     if(_tts !=null){
      if(_tts.isNotEmpty){
        await _flutterTts.speak(_tts);
      }
     }
  }
  Future stop() async {
     var result = await _flutterTts.stop();
     if(result==1){
      setState(() {
        _ttsState=TtsState.stopped;
      });
     }
  }
}