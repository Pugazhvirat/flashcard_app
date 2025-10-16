import 'package:flashcard_app/widgets/option_tile.dart';
import 'package:flashcard_app/widgets/question_card.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  final String topic;
  final List<Map<String, dynamic>> cards;

  const QuizScreen({required this.topic, required this.cards, super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  int? selectedIndex;
  bool answered = false;
  late List<int?> selectedPerCard;
  late List<bool> answeredPerCard;

  @override
  void initState() {
    super.initState();
    selectedPerCard = List<int?>.filled(widget.cards.length, null);
    answeredPerCard = List<bool>.filled(widget.cards.length, false);
  }

  void selectOption(int index) {
    if (answered) return;
    setState(() {
      selectedIndex = index;
      answered = true;
      selectedPerCard[currentIndex] = index;
      answeredPerCard[currentIndex] = true;
    });
  }

  void next() {
    if (!answered) return;
    if (currentIndex == widget.cards.length - 1) {
      showResult();
      return;
    }
    setState(() {
      currentIndex++;
      selectedIndex = selectedPerCard[currentIndex];
      answered = answeredPerCard[currentIndex];
    });
  }

  int computeCorrectCount() {
    int count = 0;
    for (int i = 0; i < widget.cards.length; i++) {
      if (selectedPerCard[i] == widget.cards[i]['answerIndex']) count++;
    }
    return count;
  }

  void showResult() {
    final correct = computeCorrectCount();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Quiz Finished!'),
        content: Text('You answered $correct out of ${widget.cards.length} correctly.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Back to Topics'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                currentIndex = 0;
                selectedPerCard = List<int?>.filled(widget.cards.length, null);
                answeredPerCard = List<bool>.filled(widget.cards.length, false);
                selectedIndex = null;
                answered = false;
              });
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final card = widget.cards[currentIndex];
    final correctIndex = card['answerIndex'] as int;
    final options = List<String>.from(card['options']);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3A003F), Color(0xFF5E003F)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.topic,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${currentIndex + 1}/${widget.cards.length}',
                      style: const TextStyle(color: Colors.white60),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                QuestionCard(question: card['question']),
                const SizedBox(height: 24),
                Expanded(
                  child: GridView.builder(
                    itemCount: options.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 1.2,
                    ),
                    itemBuilder: (context, i) {
                      return OptionTile(
                        option: options[i],
                        isSelected: selectedIndex == i,
                        isAnswered: answered,
                        isCorrect: i == correctIndex,
                        onTap: () => selectOption(i),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: answered ? next : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.tealAccent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(currentIndex == widget.cards.length - 1 ? 'Finish' : 'Next'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
