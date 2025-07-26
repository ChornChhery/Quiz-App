import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async'; // Import for Timer

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advanced Quiz App',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFf0f2f5), // Softer background
        fontFamily: 'Roboto',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                Colors.deepPurple, // Slightly darker for better contrast
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
          titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
      home: CategoryPage(
        categories: ['Geography', 'Science', 'Math', 'History'],
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Question {
  final String questionText;
  final List<String> options;
  final int correctIndex;
  final String category;

  Question({
    required this.questionText,
    required this.options,
    required this.correctIndex,
    required this.category,
  });
}

class CategoryPage extends StatelessWidget {
  final List<String> categories;

  const CategoryPage({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose a Category')),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuizPage(
                      selectedCategory: category,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
              ),
              child: Text(
                category,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          );
        },
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  final String selectedCategory;

  const QuizPage({super.key, required this.selectedCategory});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with TickerProviderStateMixin {
final List<Question> allQuestions = [
  // 🧮 MATH
  Question(
    category: 'Math',
    questionText: 'What is the value of π (pi) rounded to two decimal places?',
    options: ['3.14', '3.33', '3.22', '3.41'],
    correctIndex: 0,
  ),
  Question(
    category: 'Math',
    questionText: 'What is 8 × 7?',
    options: ['54', '56', '58', '64'],
    correctIndex: 1,
  ),
  Question(
    category: 'Math',
    questionText: 'Solve: 15 - (3 × 2)',
    options: ['9', '12', '6', '15'],
    correctIndex: 1,
  ),
  Question(
    category: 'Math',
    questionText: 'Which number is a prime number?',
    options: ['4', '6', '9', '7'],
    correctIndex: 3,
  ),
  Question(
    category: 'Math',
    questionText: 'What is the square root of 81?',
    options: ['7', '8', '9', '10'],
    correctIndex: 2,
  ),
  Question(
    category: 'Math',
    questionText: 'What is 25% of 200?',
    options: ['25', '50', '75', '100'],
    correctIndex: 1,
  ),

  // 🏰 HISTORY
  Question(
    category: 'History',
    questionText: 'Who was the first President of the United States?',
    options: ['Thomas Jefferson', 'George Washington', 'Abraham Lincoln', 'John Adams'],
    correctIndex: 1,
  ),
  Question(
    category: 'History',
    questionText: 'In what year did World War II end?',
    options: ['1942', '1945', '1950', '1939'],
    correctIndex: 1,
  ),
  Question(
    category: 'History',
    questionText: 'The Great Wall of China was mainly built to protect against which group?',
    options: ['Romans', 'Huns', 'Mongols', 'Japanese'],
    correctIndex: 2,
  ),
  Question(
    category: 'History',
    questionText: 'Who was known as the Maid of Orléans?',
    options: ['Marie Curie', 'Catherine the Great', 'Joan of Arc', 'Cleopatra'],
    correctIndex: 2,
  ),
  Question(
    category: 'History',
    questionText: 'Which empire built Machu Picchu?',
    options: ['Aztec', 'Inca', 'Maya', 'Roman'],
    correctIndex: 1,
  ),
  Question(
    category: 'History',
    questionText: 'Where was Napoleon Bonaparte born?',
    options: ['France', 'Corsica', 'Italy', 'Spain'],
    correctIndex: 1,
  ),

  // 🔬 SCIENCE
  Question(
    category: 'Science',
    questionText: 'What is the chemical symbol for water?',
    options: ['O2', 'H2O', 'CO2', 'HO'],
    correctIndex: 1,
  ),
  Question(
    category: 'Science',
    questionText: 'Which part of the plant conducts photosynthesis?',
    options: ['Root', 'Stem', 'Leaf', 'Flower'],
    correctIndex: 2,
  ),
  Question(
    category: 'Science',
    questionText: 'What gas do humans need to breathe?',
    options: ['Hydrogen', 'Carbon Dioxide', 'Oxygen', 'Nitrogen'],
    correctIndex: 2,
  ),
  Question(
    category: 'Science',
    questionText: 'What planet is known as the Red Planet?',
    options: ['Venus', 'Mars', 'Jupiter', 'Saturn'],
    correctIndex: 1,
  ),
  Question(
    category: 'Science',
    questionText: 'Which organ pumps blood throughout the human body?',
    options: ['Liver', 'Lungs', 'Brain', 'Heart'],
    correctIndex: 3,
  ),
  Question(
    category: 'Science',
    questionText: 'What type of energy is stored in a battery?',
    options: ['Kinetic', 'Thermal', 'Chemical', 'Nuclear'],
    correctIndex: 2,
  ),

  // 🌍 GEOGRAPHY
  Question(
    category: 'Geography',
    questionText: 'What is the capital of France?',
    options: ['Paris', 'London', 'Berlin', 'Madrid'],
    correctIndex: 0,
  ),
  Question(
    category: 'Geography',
    questionText: 'Which continent is the Sahara Desert located in?',
    options: ['Asia', 'Australia', 'Africa', 'South America'],
    correctIndex: 2,
  ),
  Question(
    category: 'Geography',
    questionText: 'Which is the largest ocean on Earth?',
    options: ['Atlantic', 'Indian', 'Arctic', 'Pacific'],
    correctIndex: 3,
  ),
  Question(
    category: 'Geography',
    questionText: 'Mount Everest lies on the border of Nepal and which country?',
    options: ['China', 'India', 'Pakistan', 'Bhutan'],
    correctIndex: 0,
  ),
  Question(
    category: 'Geography',
    questionText: 'Which country has the most population in the world?',
    options: ['India', 'USA', 'China', 'Indonesia'],
    correctIndex: 2,
  ),
  Question(
    category: 'Geography',
    questionText: 'What is the longest river in the world?',
    options: ['Amazon', 'Yangtze', 'Nile', 'Mississippi'],
    correctIndex: 2,
  ),
];


  late List<Question> questions;
  int currentQuestion = 0;
  int score = 0;
  bool quizFinished = false;
  int? selectedAnswerIndex;
  bool isAnswered = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  // Timer related
  static const int timePerQuestion = 15; // seconds
  late int timeLeft;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // FIX 1: Initialize animation controllers (and prepare for _timer) FIRST
    _initAnimationControllers();
    // FIX 2: Then initialize quiz data (which uses _timer)
    _shuffleQuestions();
  }

  void _initAnimationControllers() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );
  }

  void _shuffleQuestions() {
    final random = Random();

    // 🔥 Filter questions by selected category
    List<Question> categoryQuestions = allQuestions
        .where((q) => q.category == widget.selectedCategory)
        .toList();

    categoryQuestions.shuffle(random);
    questions = categoryQuestions.take(min(5, categoryQuestions.length)).toList();

    currentQuestion = 0;
    score = 0;
    quizFinished = false;
    selectedAnswerIndex = null;
    isAnswered = false;
    timeLeft = timePerQuestion;

    _animationController.reset();
    _animationController.forward(); // 🔥 Start animation when quiz begins

    _startTimer();
  }

  void _startTimer() {
    // Create a periodic timer that ticks every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          // Decrement time left
          timeLeft--;
        } else {
          // Time's up!
          if (!isAnswered) {
            // If the user hasn't answered yet, auto-submit with -1 (timeout)
            answerQuestion(-1); // -1 indicates timeout
          }
        }
      });
    });
  }

  void answerQuestion(int selectedIndex) {
    // Prevent answering multiple times or after timeout auto-submit
    if (isAnswered) return;

    setState(() {
      isAnswered = true; // Mark question as answered
      selectedAnswerIndex = selectedIndex; // Store the selected index

      // Check if the selected answer is correct and update score
      if (selectedIndex == questions[currentQuestion].correctIndex) {
        score++;
      }
    });

    // Stop the timer for the current question as an answer is submitted
    _timer.cancel();

    // Trigger the animation for feedback
    _animationController.forward().then((_) {
      // Wait for a short delay before moving to the next question or finishing
      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          // Check if there are more questions
          if (currentQuestion < questions.length - 1) {
            // Move to the next question
            currentQuestion++;
            // Reset state for the next question
            isAnswered = false;
            selectedAnswerIndex = null;
            timeLeft = timePerQuestion;
            // Reset the animation controller for the next use
            _animationController.reset();
            _animationController.forward();
            // Start the timer for the next question
            _startTimer();
          } else {
            // No more questions, finish the quiz
            quizFinished = true;
          }
        });
      });
    });
  }

  void resetQuiz() {
    // FIX 3: Add safety check before cancelling timer in reset
    // It's generally safe to call cancel(), but good practice in stateful widgets
    try {
      _timer.cancel();
    } catch (e) {
      // Timer might not be active, that's okay.
    }
    _animationController.reset();
    setState(() {
      // Re-initialize the quiz with new random questions
      _shuffleQuestions();
    });
  }

  @override
  void dispose() {
    // Clean up resources when the widget is disposed
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Quiz App'),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: resetQuiz,
            tooltip: 'Restart Quiz',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: quizFinished
            ? _buildResultView() // Show results if quiz is finished
            : _buildQuestionView(), // Otherwise show the current question
      ),
    );
  }

  Widget _buildQuestionView() {
    // Get the current question object
    final question = questions[currentQuestion];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top row: Question counter and Timer
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Question ${currentQuestion + 1}/${questions.length}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: timeLeft < 6
                    ? Colors.red.withOpacity(0.2)
                    : Colors.deepPurple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(
                    timeLeft < 6 ? Icons.timer : Icons.timer_outlined,
                    size: 18,
                    color: timeLeft < 6 ? Colors.red : Colors.deepPurple,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$timeLeft s',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: timeLeft < 6 ? Colors.red : Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Animated Progress Bar
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: (currentQuestion + 1) / questions.length,
            backgroundColor: Colors.grey[300]!,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepPurple),
            minHeight: 8,
          ),
        ),
        const SizedBox(height: 24),
        // Animated Question Card
        SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(
                  24.0,
                ), // Increased padding slightly
                child: Text(
                  question.questionText,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Options List - Using ListView.builder for efficiency
        Expanded(
          child: ListView.builder(
            // itemCount is the number of options for the current question
            itemCount: question.options.length,
            // itemBuilder creates each option widget
            itemBuilder: (context, index) {
              // Determine the state of this specific option
              bool isSelected = selectedAnswerIndex == index;
              bool isCorrect = index == question.correctIndex;
              bool showResult =
                  isAnswered; // Show feedback if question is answered

              // Determine background color based on state
              Color getOptionColor() {
                if (!showResult)
                  return Colors.white; // Default before answering
                if (isSelected && !isCorrect)
                  return Colors.red.withOpacity(0.2); // Wrong selection
                if (isCorrect)
                  return Colors.green.withOpacity(0.2); // Correct answer
                return Colors.white; // Other options after answering
              }

              // Determine icon to show based on state
              IconData? getIcon() {
                if (!showResult) return null; // No icon before answering
                if (isCorrect) return Icons.check_circle; // Correct answer icon
                if (isSelected && !isCorrect)
                  return Icons.cancel; // Wrong selection icon
                return null; // No icon for other options
              }

              // Determine icon color
              Color getIconColor() {
                if (!showResult) return Colors.transparent;
                if (isCorrect) return Colors.green;
                if (isSelected && !isCorrect) return Colors.red;
                return Colors.transparent;
              }

              // Build the option widget
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: getOptionColor(),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? (isCorrect ? Colors.green : Colors.red)
                          : Colors.grey.shade300,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    title: Text(
                      question.options[index],
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isSelected
                            ? (isCorrect ? Colors.green : Colors.red)
                            : Colors.black87,
                      ),
                    ),
                    trailing: Icon(getIcon(), color: getIconColor(), size: 28),
                    // Disable onTap if result is already shown or if it's the timeout case
                    onTap: showResult ? null : () => answerQuestion(index),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildResultView() {
    // Calculate the percentage score
    double percentage = questions.length > 0
        ? (score / questions.length) * 100
        : 0;
    String performanceMessage;
    IconData performanceIcon;
    Color performanceColor;

    // Determine performance message, icon, and color based on percentage
    if (percentage >= 90) {
      performanceMessage = 'Outstanding!';
      performanceIcon = Icons.emoji_events;
      performanceColor = Colors.amber;
    } else if (percentage >= 70) {
      performanceMessage = 'Great Job!';
      performanceIcon = Icons.thumb_up;
      performanceColor = Colors.green;
    } else if (percentage >= 50) {
      performanceMessage = 'Good Effort!';
      performanceIcon = Icons.rocket_launch;
      performanceColor = Colors.blue;
    } else {
      performanceMessage = 'Keep Practicing!';
      performanceIcon = Icons.auto_graph;
      performanceColor = Colors.deepPurple;
    }

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(performanceIcon, size: 100, color: performanceColor),
            const SizedBox(height: 24),
            Text(
              'Quiz Completed!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            Text(
              performanceMessage,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: performanceColor,
              ),
            ),
            const SizedBox(height: 32),
            // Score circle display
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: performanceColor.withOpacity(0.1),
                border: Border.all(
                  color: performanceColor.withOpacity(0.3),
                  width: 8,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$score',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    Text(
                      'out of ${questions.length}',
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '${percentage.toStringAsFixed(1)}% Correct',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: performanceColor,
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: resetQuiz,
                icon: const Icon(Icons.refresh, size: 24),
                label: const Text('Try Again', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}