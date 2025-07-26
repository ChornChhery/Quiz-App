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
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        fontFamily: 'Roboto',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            shadowColor: Colors.indigo.withOpacity(0.3),
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 8,
          shadowColor: Colors.black.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
          titleMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.indigo,
          ),
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
      home: const CategoryPage(
        categories: [
          'Geography',
          'Science',
          'Math',
          'History',
          'Art',
          'Literature',
          'Sports',
          'Technology'
        ],
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

  // Category icons mapping
  IconData getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'geography':
        return Icons.public;
      case 'science':
        return Icons.science;
      case 'math':
        return Icons.calculate;
      case 'history':
        return Icons.history_edu;
      case 'art':
        return Icons.palette;
      case 'literature':
        return Icons.menu_book;
      case 'sports':
        return Icons.sports_soccer;
      case 'technology':
        return Icons.computer;
      default:
        return Icons.quiz;
    }
  }

  // Category colors mapping
  Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'geography':
        return Colors.green;
      case 'science':
        return Colors.blue;
      case 'math':
        return Colors.orange;
      case 'history':
        return Colors.brown;
      case 'art':
        return Colors.purple;
      case 'literature':
        return Colors.teal;
      case 'sports':
        return Colors.red;
      case 'technology':
        return Colors.indigo;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose a Category'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.indigoAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF8FAFC), Color(0xFFE2E8F0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                'Select Your Quiz Category',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Test your knowledge across different subjects',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    final categoryColor = getCategoryColor(category);
                    final categoryIcon = getCategoryIcon(category);

                    return Hero(
                      tag: 'category_$category',
                      child: Card(
                        elevation: 8,
                        shadowColor: categoryColor.withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) =>
                                    QuizPage(selectedCategory: category),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  return SlideTransition(
                                    position: animation.drive(
                                      Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                                          .chain(CurveTween(curve: Curves.easeInOut)),
                                    ),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                colors: [
                                  categoryColor.withOpacity(0.1),
                                  categoryColor.withOpacity(0.05),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: categoryColor.withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    categoryIcon,
                                    size: 40,
                                    color: categoryColor,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  category,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: categoryColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
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
    // 🧮 MATH (6 questions)
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
      correctIndex: 0,
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

    // 🏰 HISTORY (6 questions)
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

    // 🔬 SCIENCE (6 questions)
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

    // 🌍 GEOGRAPHY (6 questions)
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

    // 🎨 ART (6 questions)
    Question(
      category: 'Art',
      questionText: 'Who painted the Mona Lisa?',
      options: ['Vincent van Gogh', 'Leonardo da Vinci', 'Pablo Picasso', 'Michelangelo'],
      correctIndex: 1,
    ),
    Question(
      category: 'Art',
      questionText: 'Which art movement is Salvador Dalí associated with?',
      options: ['Impressionism', 'Cubism', 'Surrealism', 'Abstract Expressionism'],
      correctIndex: 2,
    ),
    Question(
      category: 'Art',
      questionText: 'What is the primary color that cannot be created by mixing other colors?',
      options: ['Green', 'Orange', 'Purple', 'Red'],
      correctIndex: 3,
    ),
    Question(
      category: 'Art',
      questionText: 'Which famous sculpture was created by Michelangelo?',
      options: ['The Thinker', 'David', 'Venus de Milo', 'The Kiss'],
      correctIndex: 1,
    ),
    Question(
      category: 'Art',
      questionText: 'What technique did Georges Seurat use in his paintings?',
      options: ['Impasto', 'Pointillism', 'Sfumato', 'Chiaroscuro'],
      correctIndex: 1,
    ),
    Question(
      category: 'Art',
      questionText: 'Which museum houses the painting "Starry Night"?',
      options: ['Louvre', 'Metropolitan Museum', 'Museum of Modern Art', 'Tate Modern'],
      correctIndex: 2,
    ),

    // 📚 LITERATURE (6 questions)
    Question(
      category: 'Literature',
      questionText: 'Who wrote "Romeo and Juliet"?',
      options: ['Charles Dickens', 'William Shakespeare', 'Jane Austen', 'Mark Twain'],
      correctIndex: 1,
    ),
    Question(
      category: 'Literature',
      questionText: 'Which novel begins with "It was the best of times, it was the worst of times"?',
      options: ['Great Expectations', 'A Tale of Two Cities', 'Oliver Twist', 'David Copperfield'],
      correctIndex: 1,
    ),
    Question(
      category: 'Literature',
      questionText: 'Who wrote "1984"?',
      options: ['Aldous Huxley', 'Ray Bradbury', 'George Orwell', 'H.G. Wells'],
      correctIndex: 2,
    ),
    Question(
      category: 'Literature',
      questionText: 'What is the first book in the Harry Potter series?',
      options: ['Chamber of Secrets', 'Philosopher\'s Stone', 'Prisoner of Azkaban', 'Goblet of Fire'],
      correctIndex: 1,
    ),
    Question(
      category: 'Literature',
      questionText: 'Who wrote "Pride and Prejudice"?',
      options: ['Emily Brontë', 'Charlotte Brontë', 'Jane Austen', 'George Eliot'],
      correctIndex: 2,
    ),
    Question(
      category: 'Literature',
      questionText: 'Which epic poem was written by Homer?',
      options: ['The Aeneid', 'The Iliad', 'Beowulf', 'Paradise Lost'],
      correctIndex: 1,
    ),

    // ⚽ SPORTS (6 questions)
    Question(
      category: 'Sports',
      questionText: 'How many players are on a basketball team on the court at one time?',
      options: ['4', '5', '6', '7'],
      correctIndex: 1,
    ),
    Question(
      category: 'Sports',
      questionText: 'Which country has won the most FIFA World Cups?',
      options: ['Germany', 'Argentina', 'Brazil', 'Italy'],
      correctIndex: 2,
    ),
    Question(
      category: 'Sports',
      questionText: 'In which sport would you perform a slam dunk?',
      options: ['Volleyball', 'Tennis', 'Basketball', 'Badminton'],
      correctIndex: 2,
    ),
    Question(
      category: 'Sports',
      questionText: 'How many holes are there in a standard round of golf?',
      options: ['16', '18', '20', '22'],
      correctIndex: 1,
    ),
    Question(
      category: 'Sports',
      questionText: 'Which sport is known as "The Beautiful Game"?',
      options: ['Basketball', 'Tennis', 'Football/Soccer', 'Baseball'],
      correctIndex: 2,
    ),
    Question(
      category: 'Sports',
      questionText: 'In which sport do you use a shuttlecock?',
      options: ['Tennis', 'Badminton', 'Squash', 'Table Tennis'],
      correctIndex: 1,
    ),

    // 💻 TECHNOLOGY (6 questions)
    Question(
      category: 'Technology',
      questionText: 'What does "WWW" stand for?',
      options: ['World Wide Web', 'World Wide Wire', 'Web Wide World', 'Wide World Web'],
      correctIndex: 0,
    ),
    Question(
      category: 'Technology',
      questionText: 'Who founded Microsoft?',
      options: ['Steve Jobs', 'Bill Gates', 'Mark Zuckerberg', 'Larry Page'],
      correctIndex: 1,
    ),
    Question(
      category: 'Technology',
      questionText: 'What does "AI" stand for in technology?',
      options: ['Automated Intelligence', 'Artificial Intelligence', 'Advanced Intelligence', 'Applied Intelligence'],
      correctIndex: 1,
    ),
    Question(
      category: 'Technology',
      questionText: 'Which company developed the iPhone?',
      options: ['Samsung', 'Google', 'Apple', 'Microsoft'],
      correctIndex: 2,
    ),
    Question(
      category: 'Technology',
      questionText: 'What does "URL" stand for?',
      options: ['Universal Resource Locator', 'Uniform Resource Locator', 'Universal Reference Link', 'Uniform Reference Locator'],
      correctIndex: 1,
    ),
    Question(
      category: 'Technology',
      questionText: 'Which programming language is known for its use in web development and has a coffee-related name?',
      options: ['Python', 'JavaScript', 'Java', 'C++'],
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
  late AnimationController _progressController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _progressAnimation;

  // Timer related
  static const int timePerQuestion = 15; // seconds
  late int timeLeft;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _initAnimationControllers();
    _shuffleQuestions();
  }

  void _initAnimationControllers() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutBack,
          ),
        );
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );
  }

  void _shuffleQuestions() {
    final random = Random();

    // Filter questions by selected category
    List<Question> categoryQuestions = allQuestions
        .where((q) => q.category == widget.selectedCategory)
        .toList();

    categoryQuestions.shuffle(random);
    questions = categoryQuestions.take(min(6, categoryQuestions.length)).toList();

    currentQuestion = 0;
    score = 0;
    quizFinished = false;
    selectedAnswerIndex = null;
    isAnswered = false;
    timeLeft = timePerQuestion;

    _animationController.reset();
    _progressController.reset();
    _animationController.forward();
    _progressController.forward();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          if (!isAnswered) {
            answerQuestion(-1);
          }
        }
      });
    });
  }

  void answerQuestion(int selectedIndex) {
    if (isAnswered) return;

    setState(() {
      isAnswered = true;
      selectedAnswerIndex = selectedIndex;

      if (selectedIndex == questions[currentQuestion].correctIndex) {
        score++;
      }
    });

    _timer.cancel();

    _animationController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 1500), () {
        setState(() {
          if (currentQuestion < questions.length - 1) {
            currentQuestion++;
            isAnswered = false;
            selectedAnswerIndex = null;
            timeLeft = timePerQuestion;
            _animationController.reset();
            _progressController.reset();
            _animationController.forward();
            _progressController.forward();
            _startTimer();
          } else {
            quizFinished = true;
          }
        });
      });
    });
  }

  void resetQuiz() {
    try {
      _timer.cancel();
    } catch (e) {
      // Timer might not be active
    }
    _animationController.reset();
    _progressController.reset();
    setState(() {
      _shuffleQuestions();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.selectedCategory} Quiz'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.indigoAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: resetQuiz,
            tooltip: 'Restart Quiz',
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF8FAFC), Color(0xFFE2E8F0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: quizFinished
              ? _buildResultView()
              : _buildQuestionView(),
        ),
      ),
    );
  }

  Widget _buildQuestionView() {
    final question = questions[currentQuestion];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top row: Question counter and Timer
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.indigo.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.indigo.withOpacity(0.3)),
              ),
              child: Text(
                'Question ${currentQuestion + 1}/${questions.length}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: timeLeft < 6
                    ? Colors.red.withOpacity(0.1)
                    : Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: timeLeft < 6
                      ? Colors.red.withOpacity(0.3)
                      : Colors.green.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    timeLeft < 6 ? Icons.timer : Icons.timer_outlined,
                    size: 20,
                    color: timeLeft < 6 ? Colors.red : Colors.green,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '$timeLeft s',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: timeLeft < 6 ? Colors.red : Colors.green,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Animated Progress Bar
        AnimatedBuilder(
          animation: _progressAnimation,
          builder: (context, child) {
            return Container(
              height: 12,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: ((currentQuestion + 1) / questions.length) * _progressAnimation.value,
                  backgroundColor: Colors.grey[300]!,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.indigo),
                  minHeight: 12,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 30),
        // Animated Question Card
        SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Hero(
              tag: 'question_card',
              child: Card(
                elevation: 12,
                shadowColor: Colors.indigo.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.indigo.withOpacity(0.05),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Text(
                      question.questionText,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontSize: 22,
                            height: 1.4,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        // Options List
        Expanded(
          child: ListView.builder(
            itemCount: question.options.length,
            itemBuilder: (context, index) {
              bool isSelected = selectedAnswerIndex == index;
              bool isCorrect = index == question.correctIndex;
              bool showResult = isAnswered;

              Color getOptionColor() {
                if (!showResult) return Colors.white;
                if (isSelected && !isCorrect) return Colors.red.withOpacity(0.1);
                if (isCorrect) return Colors.green.withOpacity(0.1);
                return Colors.white;
              }

              Color getBorderColor() {
                if (!showResult) return Colors.grey.withOpacity(0.3);
                if (isSelected && !isCorrect) return Colors.red;
                if (isCorrect) return Colors.green;
                return Colors.grey.withOpacity(0.3);
              }

              IconData? getIcon() {
                if (!showResult) return null;
                if (isCorrect) return Icons.check_circle;
                if (isSelected && !isCorrect) return Icons.cancel;
                return null;
              }

              Color getIconColor() {
                if (!showResult) return Colors.transparent;
                if (isCorrect) return Colors.green;
                if (isSelected && !isCorrect) return Colors.red;
                return Colors.transparent;
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: getOptionColor(),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: getBorderColor(), width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: getBorderColor().withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: isAnswered ? null : () => answerQuestion(index),
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: getBorderColor().withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  String.fromCharCode(65 + index), // A, B, C, D
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: getBorderColor(),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                question.options[index],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            if (getIcon() != null)
                              Icon(
                                getIcon(),
                                color: getIconColor(),
                                size: 28,
                              ),
                          ],
                        ),
                      ),
                    ),
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
    double percentage = (score / questions.length) * 100;
    String grade = percentage >= 80
        ? 'Excellent!'
        : percentage >= 60
            ? 'Good Job!'
            : percentage >= 40
                ? 'Not Bad!'
                : 'Keep Trying!';

    Color gradeColor = percentage >= 80
        ? Colors.green
        : percentage >= 60
            ? Colors.blue
            : percentage >= 40
                ? Colors.orange
                : Colors.red;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'result_card',
            child: Card(
              elevation: 16,
              shadowColor: gradeColor.withOpacity(0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              child: Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      gradeColor.withOpacity(0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: gradeColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        percentage >= 80
                            ? Icons.emoji_events
                            : percentage >= 60
                                ? Icons.thumb_up
                                : percentage >= 40
                                    ? Icons.sentiment_satisfied
                                    : Icons.sentiment_dissatisfied,
                        size: 60,
                        color: gradeColor,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Quiz Complete!',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      grade,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: gradeColor,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      decoration: BoxDecoration(
                        color: gradeColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: gradeColor.withOpacity(0.3)),
                      ),
                      child: Text(
                        'Score: $score/${questions.length} (${percentage.toStringAsFixed(1)}%)',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: gradeColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: resetQuiz,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.home),
                label: const Text('Home'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[600],
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

