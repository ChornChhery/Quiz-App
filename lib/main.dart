import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Question {
  final String questionText;
  final List<String> options;
  final int correctIndex;

  Question({
    required this.questionText,
    required this.options,
    required this.correctIndex,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: QuizPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Question> questions = [
    Question(
      questionText: 'What is the capital of France?',
      options: ['Paris', 'London', 'Berlin', 'Madrid'],
      correctIndex: 0,
    ),
    Question(
      questionText: 'Who painted the Mona Lisa?',
      options: ['Leonardo da Vinci', 'Vincent van Gogh', 'Pablo Picasso', 'Michelangelo'],
      correctIndex: 0,
    ),
    Question(
      questionText: 'What is the largest planet in our solar system?',
      options: ['Saturn', 'Mars','Jupiter', 'Earth'],
      correctIndex: 2,
    ),
    Question(
      questionText: 'What is the chemical symbol for gold?',
      options: ['Ag', 'Au', 'Cu', 'Fe'],
      correctIndex: 1,
    ),
    Question(
      questionText: 'What is the capital of Australia?',
      options: ['Canberra', 'Sydney', 'Melbourne', 'Brisbane'],
      correctIndex: 0,
    ),
    Question(
      questionText: 'What is the largest ocean on Earth?',
      options: ['Atlantic Ocean', 'Indian Ocean','Pacific Ocean', 'Arctic Ocean'],
      correctIndex: 2,
    ),
    Question(
      questionText: 'What is the tallest mountain in the world?',
      options: ['K2', 'Kangchenjunga', 'Lhotse','Mount Everest'],
      correctIndex: 3,
    ),
    Question(
      questionText: 'Who wrote "To Kill a Mockingbird"?',
      options: ['Harper Lee', 'F. Scott Fitzgerald', 'J.D. Salinger', 'Ernest Hemingway'],
      correctIndex: 0,
    ),
    Question(
      questionText: 'What is the smallest country in the world?',
      options: ['Monaco','Vatican City', 'Nauru', 'San Marino'],
      correctIndex: 1,
    ),
  ];

  int currentQuestion = 0;
  int score = 0;
  bool quizFinished = false;

  void answerQuestion(int selectedIndex) {
    if (questions[currentQuestion].correctIndex == selectedIndex) {
      score++;
    }

    setState(() {
      if (currentQuestion < questions.length - 1) {
        currentQuestion++;
      } else {
        quizFinished = true;
      }
    });
  }

  void resetQuiz() {
    setState(() {
      currentQuestion = 0;
      score = 0;
      quizFinished = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Quiz App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: quizFinished
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Quiz Completed!',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    Text('Your Score: $score / ${questions.length}',
                        style: TextStyle(fontSize: 20)),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: resetQuiz,
                      child: Text('Restart Quiz'),
                    )
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question ${currentQuestion + 1} of ${questions.length}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 16),
                  Text(
                    questions[currentQuestion].questionText,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 24),
                  ...List.generate(4, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: ElevatedButton(
                        onPressed: () => answerQuestion(index),
                        child: Text(questions[currentQuestion].options[index]),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                        ),
                      ),
                    );
                  })
                ],
              ),
      ),
    );
  }
}
