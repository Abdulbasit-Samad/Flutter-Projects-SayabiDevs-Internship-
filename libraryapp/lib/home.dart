import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:libraryapp/bookclass.dart';
class Library extends StatefulWidget {
  const Library({Key? key}) : super(key: key);

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  List <BookDataSet> books = [];
  Future getdata() async{
    final response = await http.get(Uri.parse('https://www.googleapis.com/books/v1/volumes?q=search-terms&key=AIzaSyDgdMVHpg2Ozcc1uR9fQsCeDj4f_g7vhlI&maxResults=40'));
    if(response.statusCode==200){
      var data =jsonDecode(response.body.toString());
      for(Map i in data['items']){
        BookDataSet temp = BookDataSet(title: i['volumeInfo']['title'], subtitle: i['volumeInfo']['subtitle']);
        books.add(temp);
      }
      return books;
    }
    else{
      return books;
    }
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text("LIBRARY APP",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: [Expanded(child: 
        FutureBuilder(
          future: getdata(),
          builder: (context, snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(
                child: Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    color: Colors.purple,
                    strokeWidth: 7,
                  ),
                ),
              );
            }
            else{
              return ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return ListTile(
                  title: Text(books[index].title.toString(),style: const TextStyle(color: Colors
                  .red,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 20),),
                  subtitle: books[index].subtitle != null?
                  Text(books[index].subtitle.toString(),style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),):null,
                  );
                },
              );
            }
          }
        ),
        )]
      ),
     );
  }
}