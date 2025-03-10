import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import '../utils/colors.dart';
import '../utils/models.dart';
import '../utils/nav_bar.dart';

class LessonsPage extends StatefulWidget {const LessonsPage({Key? key}) : super(key: key);

@override
State<LessonsPage> createState() => LessonsPageState();
}

class LessonsPageState extends State<LessonsPage> {

  bool showSecondButton = false;

  late Future<List<Lesson>> lessons;

  @override
  void initState() {
    super.initState();
    lessons = loadLessons();
  }

  Future<List<Lesson>> loadLessons() async {
    final String Jsonlesson = await rootBundle.loadString('assets/charset.json');
    final Map<String, dynamic> data = jsonDecode(Jsonlesson);

    return data.entries.map((entry)
        {return Lesson.fromJson(entry.key, entry.value);
    }).toList();
  }


//dipose contoller
  @override
  //void dispose() {
  //textController.dispose();
  //super.dispose();}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
            child: FutureBuilder<List<Lesson>>(
              future: lessons,
              builder: (context, snapshot) {
                return Container(
                  color: Colors.blue[100],
                  alignment: Alignment.center,
                  width: 500.0,
                  height: 500.0,
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        child: ListView(
                          shrinkWrap: true,
                          children: <Widget>[
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Lessons',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Buttons(),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }



  Widget Buttons(){
    return OverflowBar(
      alignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[

        ElevatedButton( child: const Text('Lesson1'), onPressed: () {
          setState(() {
            showSecondButton = !showSecondButton;
          });
        },
        ),
        if (showSecondButton)
          Lesson1(), // Displays lesson button
      ],
    );
  }

  Widget Lesson1() {
    return FutureBuilder<List<Lesson>>(
      future: lessons,
      //verifies the JSON is imported
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No lessons available'));
        } else {
          final lessons = snapshot.data!;

          //returns charcter button in column form
          return Column(
            children: lessons.map((lesson) {
              return Column(
                children: [
                  SizedBox(height: 10),

                  // Character Buttons
                   Center(
                  child: SizedBox(
                  width: 500,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center, // Align to center
              children: lesson.characters.map((character) {
              return Padding(
              padding: const EdgeInsets.only(bottom: 10.0), // Space between characters
              child: TextButton(
                            child: Text(
                              character.character, // Import character from JSON
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () {showCharacterDetails(context, character); // pops up a dialog bar containing character infomation

                            },
              ),
                          );

                        }).toList(),
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          );
        }
      },
    );
  }


  //pop up Dialog bar conatining character information
  void showCharacterDetails(BuildContext context, Character character) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(character.character, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,

            //displays all information
            children: [
              Text("character: ${character.character}", style: TextStyle(fontSize: 18)),
              Text("Unicode: ${character.unicode}", style: TextStyle(fontSize: 18)),
              Text("Pinyin: ${character.pinyin}", style: TextStyle(fontSize: 18)),
              Text("Definition: ${character.definition}", style: TextStyle(fontSize: 18)),
              Text("Strokes: ${character.strokeNum}", style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text("Parts", style: TextStyle(fontSize: 20)),
              Column(
                children: character.parts.map((part) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text("partID: ${part.partID}, strokeNums: ${part.strokeNums}, story: ${part.story }", style: TextStyle(fontSize: 16) ),

                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



}


