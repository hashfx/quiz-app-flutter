import 'package:flutter/material.dart';
import 'package:quiz_app/data/question_list.dart';
import 'package:quiz_app/screens/result_screen.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScr(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScr extends StatelessWidget {
  const SplashScr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 6,
      navigateAfterSeconds: new HomePage(),
      title: Text("Quizzy",
          textScaleFactor: 2,
          style: TextStyle(
            color: Colors.red,
            fontFamily: 'Nabla',
            fontSize: 48,
          )),
      image: new Image.network('https://picsum.photos/600/800'),
      backgroundColor: Colors.lightBlueAccent.shade100,
      loadingText: Text("Loading..."),
      photoSize: 100.0,
      loaderColor: Colors.blue,
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

  // page controller for page view
  PageController? _controller = PageController(initialPage: 0);

  // game variables
  bool isPressed = false;
  Color isRight = Colors.green;
  Color isWrong = Colors.red;
  Color btnColor = Color(0xFF117eeb);
  int score = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainColor,
        body: Padding(
            padding: EdgeInsets.all(18.0),
            child: PageView.builder(
              // disable scrolling to avoid sliding to next question
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller!,
              onPageChanged: (page) {
                setState(() {
                  isPressed = false;
                });
              },
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
                      height: 35.0,
                    ),

                    // generate buttons for options
                    for (int i = 0; i < questions[index].answer!.length; i++)
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 18.0),
                        child: MaterialButton(
                          shape: StadiumBorder(),
                          color: isPressed
                              ? questions[index]
                                      .answer!
                                      .entries
                                      .toList()[i]
                                      .value
                                  ? isRight
                                  : isWrong
                              : secondaryColor,
                          padding: EdgeInsets.symmetric(vertical: 18.0),
                          onPressed: isPressed
                              ? () {}
                              : () {
                                  setState(() {
                                    isPressed = true;
                                  });
                                  if (questions[index]
                                      .answer!
                                      .entries
                                      .toList()[i]
                                      .value) {
                                    score += 10;
                                    // print(score);
                                  }
                                },
                          child: Text(
                            questions[index].answer!.keys.toList()[i],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: isPressed
                              ? index + 1 == questions.length
                                  ? () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ResultScreen(score)));
                                    }
                                  : () {
                                      _controller!.nextPage(
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.linear);
                                      setState(() {
                                        isPressed = false;
                                      });
                                    }
                              : null,
                          style: OutlinedButton.styleFrom(
                            shape: StadiumBorder(),
                            side: BorderSide(color: Colors.orange, width: 1.0),
                          ),
                          child: Text(
                            index + 1 == questions.length
                                ? "See Result"
                                : "Next",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            )));
  }
}
