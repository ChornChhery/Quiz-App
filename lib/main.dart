import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

void main() => runApp(const QuizApp());

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advanced Quiz App',
      theme: _buildTheme(),
      home: const CategoryPage(),
      debugShowCheckedModeBanner: false,
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      fontFamily: 'Roboto',
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          shadowColor: Colors.indigo.withOpacity(0.3),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo),
        titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.indigo),
        bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
      ),
    );
  }
}

class Question {
  final String questionText, category;
  final List<String> options;
  final int correctIndex;

  const Question({
    required this.questionText,
    required this.options,
    required this.correctIndex,
    required this.category,
  });
}

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  static const categories = ['Geography', 'Science', 'Math', 'History', 'Art', 'Literature', 'Sports', 'Technology'];
  
  static const _categoryData = {
    'geography': {'icon': Icons.public, 'color': Colors.green},
    'science': {'icon': Icons.science, 'color': Colors.blue},
    'math': {'icon': Icons.calculate, 'color': Colors.orange},
    'history': {'icon': Icons.history_edu, 'color': Colors.brown},
    'art': {'icon': Icons.palette, 'color': Colors.purple},
    'literature': {'icon': Icons.menu_book, 'color': Colors.teal},
    'sports': {'icon': Icons.sports_soccer, 'color': Colors.red},
    'technology': {'icon': Icons.computer, 'color': Colors.indigo},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
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
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
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
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 28),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Test your knowledge across different subjects',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Expanded(child: _buildCategoryGrid(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryGrid(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.1,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) => _buildCategoryCard(context, categories[index]),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String category) {
    final data = _categoryData[category.toLowerCase()]!;
    final color = data['color'] as Color;
    final icon = data['icon'] as IconData;

    return Hero(
      tag: 'category_$category',
      child: Card(
        elevation: 8,
        shadowColor: color.withOpacity(0.3),
        child: InkWell(
          onTap: () => _navigateToQuiz(context, category),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
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
                    color: color.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 40, color: color),
                ),
                const SizedBox(height: 12),
                Text(
                  category,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToQuiz(BuildContext context, String category) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, _) => QuizPage(selectedCategory: category),
        transitionsBuilder: (context, animation, _, child) {
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
  }
}

class QuizPage extends StatefulWidget {
  final String selectedCategory;

  const QuizPage({super.key, required this.selectedCategory});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with TickerProviderStateMixin {
  static const _allQuestions = [
    // Math
    Question(category: 'Math', questionText: 'What is the value of π (pi) rounded to two decimal places?', options: ['3.14', '3.33', '3.22', '3.41'], correctIndex: 0),
    Question(category: 'Math', questionText: 'What is 8 × 7?', options: ['54', '56', '58', '64'], correctIndex: 1),
    Question(category: 'Math', questionText: 'Solve: 15 - (3 × 2)', options: ['9', '12', '6', '15'], correctIndex: 0),
    Question(category: 'Math', questionText: 'Which number is a prime number?', options: ['4', '6', '9', '7'], correctIndex: 3),
    Question(category: 'Math', questionText: 'What is the square root of 81?', options: ['7', '8', '9', '10'], correctIndex: 2),
    Question(category: 'Math', questionText: 'What is 25% of 200?', options: ['25', '50', '75', '100'], correctIndex: 1),
    
    // History
    Question(category: 'History', questionText: 'Who was the first President of the United States?', options: ['Thomas Jefferson', 'George Washington', 'Abraham Lincoln', 'John Adams'], correctIndex: 1),
    Question(category: 'History', questionText: 'In what year did World War II end?', options: ['1942', '1945', '1950', '1939'], correctIndex: 1),
    Question(category: 'History', questionText: 'The Great Wall of China was mainly built to protect against which group?', options: ['Romans', 'Huns', 'Mongols', 'Japanese'], correctIndex: 2),
    Question(category: 'History', questionText: 'Who was known as the Maid of Orléans?', options: ['Marie Curie', 'Catherine the Great', 'Joan of Arc', 'Cleopatra'], correctIndex: 2),
    Question(category: 'History', questionText: 'Which empire built Machu Picchu?', options: ['Aztec', 'Inca', 'Maya', 'Roman'], correctIndex: 1),
    Question(category: 'History', questionText: 'Where was Napoleon Bonaparte born?', options: ['France', 'Corsica', 'Italy', 'Spain'], correctIndex: 1),
    
    // Science
    Question(category: 'Science', questionText: 'What is the chemical symbol for water?', options: ['O2', 'H2O', 'CO2', 'HO'], correctIndex: 1),
    Question(category: 'Science', questionText: 'Which part of the plant conducts photosynthesis?', options: ['Root', 'Stem', 'Leaf', 'Flower'], correctIndex: 2),
    Question(category: 'Science', questionText: 'What gas do humans need to breathe?', options: ['Hydrogen', 'Carbon Dioxide', 'Oxygen', 'Nitrogen'], correctIndex: 2),
    Question(category: 'Science', questionText: 'What planet is known as the Red Planet?', options: ['Venus', 'Mars', 'Jupiter', 'Saturn'], correctIndex: 1),
    Question(category: 'Science', questionText: 'Which organ pumps blood throughout the human body?', options: ['Liver', 'Lungs', 'Brain', 'Heart'], correctIndex: 3),
    Question(category: 'Science', questionText: 'What type of energy is stored in a battery?', options: ['Kinetic', 'Thermal', 'Chemical', 'Nuclear'], correctIndex: 2),
    
    // Geography
    Question(category: 'Geography', questionText: 'What is the capital of France?', options: ['Paris', 'London', 'Berlin', 'Madrid'], correctIndex: 0),
    Question(category: 'Geography', questionText: 'Which continent is the Sahara Desert located in?', options: ['Asia', 'Australia', 'Africa', 'South America'], correctIndex: 2),
    Question(category: 'Geography', questionText: 'Which is the largest ocean on Earth?', options: ['Atlantic', 'Indian', 'Arctic', 'Pacific'], correctIndex: 3),
    Question(category: 'Geography', questionText: 'Mount Everest lies on the border of Nepal and which country?', options: ['China', 'India', 'Pakistan', 'Bhutan'], correctIndex: 0),
    Question(category: 'Geography', questionText: 'Which country has the most population in the world?', options: ['India', 'USA', 'China', 'Indonesia'], correctIndex: 2),
    Question(category: 'Geography', questionText: 'What is the longest river in the world?', options: ['Amazon', 'Yangtze', 'Nile', 'Mississippi'], correctIndex: 2),
    
    // Art
    Question(category: 'Art', questionText: 'Who painted the Mona Lisa?', options: ['Vincent van Gogh', 'Leonardo da Vinci', 'Pablo Picasso', 'Michelangelo'], correctIndex: 1),
    Question(category: 'Art', questionText: 'Which art movement is Salvador Dalí associated with?', options: ['Impressionism', 'Cubism', 'Surrealism', 'Abstract Expressionism'], correctIndex: 2),
    Question(category: 'Art', questionText: 'What is the primary color that cannot be created by mixing other colors?', options: ['Green', 'Orange', 'Purple', 'Red'], correctIndex: 3),
    Question(category: 'Art', questionText: 'Which famous sculpture was created by Michelangelo?', options: ['The Thinker', 'David', 'Venus de Milo', 'The Kiss'], correctIndex: 1),
    Question(category: 'Art', questionText: 'What technique did Georges Seurat use in his paintings?', options: ['Impasto', 'Pointillism', 'Sfumato', 'Chiaroscuro'], correctIndex: 1),
    Question(category: 'Art', questionText: 'Which museum houses the painting "Starry Night"?', options: ['Louvre', 'Metropolitan Museum', 'Museum of Modern Art', 'Tate Modern'], correctIndex: 2),
    
    // Literature
    Question(category: 'Literature', questionText: 'Who wrote "Romeo and Juliet"?', options: ['Charles Dickens', 'William Shakespeare', 'Jane Austen', 'Mark Twain'], correctIndex: 1),
    Question(category: 'Literature', questionText: 'Which novel begins with "It was the best of times, it was the worst of times"?', options: ['Great Expectations', 'A Tale of Two Cities', 'Oliver Twist', 'David Copperfield'], correctIndex: 1),
    Question(category: 'Literature', questionText: 'Who wrote "1984"?', options: ['Aldous Huxley', 'Ray Bradbury', 'George Orwell', 'H.G. Wells'], correctIndex: 2),
    Question(category: 'Literature', questionText: 'What is the first book in the Harry Potter series?', options: ['Chamber of Secrets', 'Philosopher\'s Stone', 'Prisoner of Azkaban', 'Goblet of Fire'], correctIndex: 1),
    Question(category: 'Literature', questionText: 'Who wrote "Pride and Prejudice"?', options: ['Emily Brontë', 'Charlotte Brontë', 'Jane Austen', 'George Eliot'], correctIndex: 2),
    Question(category: 'Literature', questionText: 'Which epic poem was written by Homer?', options: ['The Aeneid', 'The Iliad', 'Beowulf', 'Paradise Lost'], correctIndex: 1),
    
    // Sports
    Question(category: 'Sports', questionText: 'How many players are on a basketball team on the court at one time?', options: ['4', '5', '6', '7'], correctIndex: 1),
    Question(category: 'Sports', questionText: 'Which country has won the most FIFA World Cups?', options: ['Germany', 'Argentina', 'Brazil', 'Italy'], correctIndex: 2),
    Question(category: 'Sports', questionText: 'In which sport would you perform a slam dunk?', options: ['Volleyball', 'Tennis', 'Basketball', 'Badminton'], correctIndex: 2),
    Question(category: 'Sports', questionText: 'How many holes are there in a standard round of golf?', options: ['16', '18', '20', '22'], correctIndex: 1),
    Question(category: 'Sports', questionText: 'Which sport is known as "The Beautiful Game"?', options: ['Basketball', 'Tennis', 'Football/Soccer', 'Baseball'], correctIndex: 2),
    Question(category: 'Sports', questionText: 'In which sport do you use a shuttlecock?', options: ['Tennis', 'Badminton', 'Squash', 'Table Tennis'], correctIndex: 1),
    
    // Technology
    Question(category: 'Technology', questionText: 'What does "WWW" stand for?', options: ['World Wide Web', 'World Wide Wire', 'Web Wide World', 'Wide World Web'], correctIndex: 0),
    Question(category: 'Technology', questionText: 'Who founded Microsoft?', options: ['Steve Jobs', 'Bill Gates', 'Mark Zuckerberg', 'Larry Page'], correctIndex: 1),
    Question(category: 'Technology', questionText: 'What does "AI" stand for in technology?', options: ['Automated Intelligence', 'Artificial Intelligence', 'Advanced Intelligence', 'Applied Intelligence'], correctIndex: 1),
    Question(category: 'Technology', questionText: 'Which company developed the iPhone?', options: ['Samsung', 'Google', 'Apple', 'Microsoft'], correctIndex: 2),
    Question(category: 'Technology', questionText: 'What does "URL" stand for?', options: ['Universal Resource Locator', 'Uniform Resource Locator', 'Universal Reference Link', 'Uniform Reference Locator'], correctIndex: 1),
    Question(category: 'Technology', questionText: 'Which programming language is known for its use in web development and has a coffee-related name?', options: ['Python', 'JavaScript', 'Java', 'C++'], correctIndex: 2),
  ];

  late List<Question> questions;
  int currentQuestion = 0, score = 0, timeLeft = 15;
  bool quizFinished = false, isAnswered = false;
  int? selectedAnswerIndex;
  late AnimationController _animationController, _progressController;
  late Animation<double> _fadeAnimation, _progressAnimation;
  late Animation<Offset> _slideAnimation;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _shuffleQuestions();
  }

  void _initAnimations() {
    _animationController = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    _progressController = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack));
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _progressController, curve: Curves.easeInOut));
  }

  void _shuffleQuestions() {
    final categoryQuestions = _allQuestions.where((q) => q.category == widget.selectedCategory).toList()..shuffle();
    questions = categoryQuestions.take(6).toList();
    _resetQuizState();
    _startTimer();
  }

  void _resetQuizState() {
    currentQuestion = score = 0;
    timeLeft = 15;
    quizFinished = isAnswered = false;
    selectedAnswerIndex = null;
    _animationController.reset();
    _progressController.reset();
    _animationController.forward();
    _progressController.forward();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else if (!isAnswered) {
          _answerQuestion(-1);
        }
      });
    });
  }

  void _answerQuestion(int selectedIndex) {
    if (isAnswered) return;
    
    setState(() {
      isAnswered = true;
      selectedAnswerIndex = selectedIndex;
      if (selectedIndex == questions[currentQuestion].correctIndex) score++;
    });

    _timer.cancel();
    Future.delayed(const Duration(milliseconds: 1500), _nextQuestion);
  }

  void _nextQuestion() {
    setState(() {
      if (currentQuestion < questions.length - 1) {
        currentQuestion++;
        isAnswered = false;
        selectedAnswerIndex = null;
        timeLeft = 15;
        _animationController.reset();
        _progressController.reset();
        _animationController.forward();
        _progressController.forward();
        _startTimer();
      } else {
        quizFinished = true;
      }
    });
  }

  void _resetQuiz() {
    _timer.cancel();
    setState(_shuffleQuestions);
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
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
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
      actions: [IconButton(icon: const Icon(Icons.refresh), onPressed: _resetQuiz, tooltip: 'Restart Quiz')],
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFF8FAFC), Color(0xFFE2E8F0)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
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
        _buildHeader(),
        const SizedBox(height: 20),
        _buildProgressBar(),
        const SizedBox(height: 30),
        _buildQuestionCard(question),
        const SizedBox(height: 30),
        Expanded(child: _buildOptionsList(question)),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildInfoChip('Question ${currentQuestion + 1}/${questions.length}', Colors.indigo),
        _buildTimerChip(),
      ],
    );
  }

  Widget _buildInfoChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(text, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
    );
  }

  Widget _buildTimerChip() {
    final isUrgent = timeLeft < 6;
    final color = isUrgent ? Colors.red : Colors.green;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(isUrgent ? Icons.timer : Icons.timer_outlined, size: 20, color: color),
          const SizedBox(width: 6),
          Text('$timeLeft s', style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (context, child) {
        return Container(
          height: 12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            boxShadow: [BoxShadow(color: Colors.indigo.withOpacity(0.3), blurRadius: 4, offset: const Offset(0, 2))],
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
    );
  }

  Widget _buildQuestionCard(Question question) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Hero(
          tag: 'question_card',
          child: Card(
            elevation: 12,
            shadowColor: Colors.indigo.withOpacity(0.3),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.indigo.withOpacity(0.05)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Text(
                  question.questionText,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 22, height: 1.4),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionsList(Question question) {
    return ListView.builder(
      itemCount: question.options.length,
      itemBuilder: (context, index) => _buildOptionCard(question, index),
    );
  }

  Widget _buildOptionCard(Question question, int index) {
    final isSelected = selectedAnswerIndex == index;
    final isCorrect = index == question.correctIndex;
    final showResult = isAnswered;

    Color getColor() {
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

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: getColor(),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: getBorderColor(), width: 2),
          boxShadow: [BoxShadow(color: getBorderColor().withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 4))],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isAnswered ? null : () => _answerQuestion(index),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(color: getBorderColor().withOpacity(0.2), shape: BoxShape.circle),
                    child: Center(
                      child: Text(
                        String.fromCharCode(65 + index),
                        style: TextStyle(fontWeight: FontWeight.bold, color: getBorderColor()),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(question.options[index], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  ),
                  if (getIcon() != null) Icon(getIcon(), color: getBorderColor(), size: 28),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultView() {
    final percentage = (score / questions.length) * 100;
    final grade = percentage >= 80 ? 'Excellent!' : percentage >= 60 ? 'Good Job!' : percentage >= 40 ? 'Not Bad!' : 'Keep Trying!';
    final gradeColor = percentage >= 80 ? Colors.green : percentage >= 60 ? Colors.blue : percentage >= 40 ? Colors.orange : Colors.red;
    final gradeIcon = percentage >= 80 ? Icons.emoji_events : percentage >= 60 ? Icons.thumb_up : percentage >= 40 ? Icons.sentiment_satisfied : Icons.sentiment_dissatisfied;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'result_card',
            child: Card(
              elevation: 16,
              shadowColor: gradeColor.withOpacity(0.3),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
              child: Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  gradient: LinearGradient(colors: [Colors.white, gradeColor.withOpacity(0.05)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: gradeColor.withOpacity(0.1), shape: BoxShape.circle),
                      child: Icon(gradeIcon, size: 60, color: gradeColor),
                    ),
                    const SizedBox(height: 24),
                    Text('Quiz Complete!', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 28)),
                    const SizedBox(height: 16),
                    Text(grade, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: gradeColor)),
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
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: gradeColor),
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
                onPressed: _resetQuiz,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16)),
              ),
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.home),
                label: const Text('Home'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[600],
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

