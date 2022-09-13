import 'package:flutter/material.dart';
import 'package:quiz_app/data/question_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // color
  Color mainColor = Color(0xFF252c4a);
  Color secondaryColor = Color(0xFF117eeb);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainColor,
        body: Padding(
            padding: EdgeInsets.all(18.0),
            child: PageView.builder(
              itemCount: questions.length, // number of questions
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text("Question ${index + 1} / ${questions.length}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 28.0,
                          )),
                    ),
                    const Divider(
                      color: Colors.white,
                      height: 4.0,
                      thickness: 1.0,
                    ),
                    const SizedBox(height: 20.0),
                    // displays question
                    Text(
                      questions[index].question!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28.0,
                      ),
                    ),

                    SizedBox(
                      height: 25.0,
                    ),

                    // generate buttons for options
                    for (int i = 0; i < questions[index].answer!.length; i++)
                      MaterialButton(
                        shape: StadiumBorder(),
                        color: secondaryColor,
                        onPressed: () {},
                        child: Text(questions[index].answer!.keys.toList()[i],
                        style: TextStyle(color: Colors.white),
                        ),
                        
                      ),
                  ],
                );
              },
            )));
  }
}
