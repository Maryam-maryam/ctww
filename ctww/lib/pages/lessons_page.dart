import 'package:flutter/material.dart';

//import '../utils/colors.dart';
import '../utils/nav_bar.dart';

class LessonsPage extends StatefulWidget {

  const LessonsPage({Key? key}) : super(key: key);

  @override
  State<LessonsPage> createState() => LessonsPageState();
}

class LessonsPageState extends State<LessonsPage> {

  bool showSecondButton = false;
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
         // constraints: BoxConstraints.expand(
           // height: Theme.of(context).textTheme.headlineMedium!.fontSize! * 1.1 + 200.0,
          //),
          padding: const EdgeInsets.all(8.0),
          color: Colors.blue[100],
          alignment: Alignment.center,
         // transform: Matrix4.rotationZ(0.1),
          width: 500.0,
          height: 500.0,
        child: Column(
          children: <Widget>[
            Flexible(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
        const Align(
            alignment: Alignment.topLeft ,
              child: Text(
          'Lessons',
          style: TextStyle(fontSize: 20,
              fontWeight: FontWeight.bold,
                color: Colors.white ),), ),
             Buttons(),
     ]
        ),

        ),
        ]
      ), ),),
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
           // Ensure this function is properly defined elsewhere
        },

        ),
    if (showSecondButton)
    Lesson1(),

      ],
    );
  }

  Widget Lesson1(){
    return OverflowBar(
     //children: Row(
       children: <Widget>[

          //if (showSecondButton)
            TextButton( child: const Text('一'), onPressed: () {}),
          TextButton( child: const Text('二'), onPressed: () {}),
          TextButton( child: const Text('三'), onPressed: () {}),
          TextButton( child: const Text('四'), onPressed: () {}),
    ],
     //),
    );
  }

}
