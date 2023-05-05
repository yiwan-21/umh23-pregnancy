import 'package:flutter/material.dart';

class Question extends StatefulWidget {
  const Question({super.key});

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  final List<String> questions = [
    'Question 1: How many people are in your household ?',
    'Question 2: How long is the average shower time in your household ? (in minutes)',
    'Question 3: How often do you take the bath per day ?',
    'Question 4: How long do you leave your bathroom faucets running each day ? (in minutes)',
    'Question 5: How long do you leave your kitchen faucets running each day ? (in minutes)',
    'Question 6: How often do you wash your dishes each day ?',
  ];

  List<int> answers = List.filled(6, 0);

  List<Widget> getQuestionList() {
    List<Widget> questionList = [];
    for (int i = 0; i < questions.length; i++) {
      questionList.add(
        ListTile(
          title: Text(questions[i]),
          subtitle: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              answers[i] = int.tryParse(value) ?? 0;
            },
          ),
        ),
      );
    }
    return questionList;
  }

  int calculateTotal() {
    int total = 0;
    int total2 = answers[1] * 3 * answers[2];
    int total3 = (answers[3] + answers[4]) * 2;
    int total4 = answers[5] * 20;
    total = answers[0] * (total2 + total3 + total4);

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questions'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: getQuestionList(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              int total = calculateTotal();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Total'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('The total is $total Gallons'),
                        if (total < 400) // add a conditional statement here
                          const Text(
                            'The water footprint is low! ',
                            style: TextStyle(color: Colors.green),
                          ),
                        if (total >= 400 && total <= 600)
                          const Text(
                            'The water footprint is medium! ',
                            style: TextStyle(color: Colors.yellow),
                          ),
                        if (total > 600)
                          const Text(
                            'The water footprint is high! ',
                            style: TextStyle(color: Colors.red),
                          ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Text('Calculate Total'),
          ),
        ],
      ),
    );
  }
}