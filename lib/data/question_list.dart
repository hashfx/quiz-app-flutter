import 'package:quiz_app/model/question_model.dart';

List<QuestionModel> questions = [
  QuestionModel(
    "This is a Question",
    {
      "1": false,
      "2": false,
      "3": false,
      "4": true,
    },
  ),
  QuestionModel(
    "Another Question",
    {
      "1": true,
      "2": false,
      "3": false,
      "4": false,
    },
  ),
  QuestionModel(
    "Heya Question",
    {
      "1": false,
      "2": false,
      "3": true,
      "4": false,
    },
  ),
];
