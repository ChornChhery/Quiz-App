import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modern Quiz App',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        fontFamily: 'Roboto',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 16),
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      home: const QuizPage(),
      debugShowCheckedModeBanner: false,
    );
  }
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

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Question> allQuestions = [
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
      options: ['Saturn', 'Mars', 'Jupiter', 'Earth'],
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
      options: ['Atlantic Ocean', 'Indian Ocean', 'Pacific Ocean', 'Arctic Ocean'],
      correctIndex: 2,
    ),
    Question(
      questionText: 'Who wrote "To Kill a Mockingbird"?',
      options: ['Harper Lee', 'F. Scott Fitzgerald', 'J.D. Salinger', 'Ernest Hemingway'],
      correctIndex: 0,
    ),
    Question(
      questionText: 'What is the smallest country in the world?',
      options: ['Monaco', 'Vatican City', 'Nauru', 'San Marino'],
      correctIndex: 1,
    ),
    Question(
      questionText: 'What is the speed of light in a vacuum?',
      options: ['100,000 km/s', '300,000 km/s', '500,000 km/s', '1,000,000 km/s'],
      correctIndex: 1,
    ),
    Question(
      questionText: 'Which element is represented by the symbol "H"?',
      options: ['Helium', 'Hydrogen', 'Hassium','Hydrogen'],
      correctIndex: 3,
    ),
  ];

  late List<Question> questions;
  int currentQuestion = 0;
  int score = 0;
  bool quizFinished = false;

  @override
  void initState() {
    super.initState();
    _shuffleQuestions();
  }

  void _shuffleQuestions() {
    questions = List<Question>.from(allQuestions)..shuffle(Random());
    currentQuestion = 0;
    score = 0;
    quizFinished = false;
  }

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
      _shuffleQuestions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: quizFinished ? _buildResultView() : _buildQuestionView(),
      ),
    );
  }

  Widget _buildQuestionView() {
    final question = questions[currentQuestion];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: (currentQuestion + 1) / questions.length,
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
        ),
        const SizedBox(height: 20),
        Text(
          'Question ${currentQuestion + 1} of ${questions.length}',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 12),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          margin: const EdgeInsets.only(bottom: 20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              question.questionText,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: question.options.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: ElevatedButton(
                  onPressed: () => answerQuestion(index),
                  child: Text(question.options[index]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildResultView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.emoji_events, size: 80, color: Colors.amber),
          const SizedBox(height: 20),
          const Text(
            'Congratulations!',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            'Your score is $score out of ${questions.length}',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: resetQuiz,
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
          )
        ],
      ),
    );
  }
}
