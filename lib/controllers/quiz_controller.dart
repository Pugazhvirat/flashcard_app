import '../models/quiz_model.dart';

class QuizController {
  final List<QuizModel> quizList;
  int currentIndex = 0;
  List<int?> selectedPerCard;
  List<bool> answeredPerCard;

  QuizController({required this.quizList})
    : selectedPerCard = List<int?>.filled(quizList.length, null),
      answeredPerCard = List<bool>.filled(quizList.length, false);

  bool selectOption(int index) {
    if (answeredPerCard[currentIndex] == true) return false;
    selectedPerCard[currentIndex] = index;
    answeredPerCard[currentIndex] = true;
    return true;
  }

  void nextCard() {
    if (currentIndex < quizList.length - 1) {
      currentIndex++;
    }
  }

  int computeCorrectCount() {
    int count = 0;
    for (int i = 0; i < quizList.length; i++) {
      if (selectedPerCard[i] == quizList[i].answerIndex) count++;
    }
    return count;
  }

  bool isLastCard() => currentIndex == quizList.length - 1;
}
