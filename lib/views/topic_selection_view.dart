import 'package:flashcard_app/views/quiz_view.dart';
import 'package:flutter/material.dart';

import '../data/quiz_data.dart';

class TopicSelectionScreen extends StatelessWidget {
  final VoidCallback onToggleTheme;
  final bool isDark;

  const TopicSelectionScreen({required this.onToggleTheme, required this.isDark, super.key});

  @override
  Widget build(BuildContext context) {
    final topics = localQuizzes.keys.toList();
    final topicIcons = [Icons.book, Icons.science, Icons.calculate]; // icons for topics

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Top row with theme toggle button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 100),
                IconButton(
                  icon: Icon(
                    isDark ? Icons.nights_stay : Icons.wb_sunny,
                    color: isDark ? Colors.white : Colors.yellow,
                    size: 28, // icon size
                  ),
                  onPressed: onToggleTheme,
                  splashRadius: 24, // touch ripple radius
                  tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
                  padding: const EdgeInsets.all(8),
                  constraints: const BoxConstraints(),
                ),
              ],
            ),

            const SizedBox(height: 10),

            const Text(
              'Ready to Learn? 🎓',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.indigo),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: topics.length,
                itemBuilder: (context, index) {
                  final topic = topics[index];
                  final icon = topicIcons[index % topicIcons.length];

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Colors.primaries[index % Colors.primaries.length].shade300,
                          Colors.primaries[index % Colors.primaries.length].shade700,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: Icon(icon, color: Colors.white, size: 32),
                      title: Text(
                        topic,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => QuizScreen(topic: topic, cards: localQuizzes[topic]!),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
