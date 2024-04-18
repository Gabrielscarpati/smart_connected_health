import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smart_connected_health/ultils/app_routes.dart';
import 'package:smart_connected_health/ultils/sentiments_api.dart';
import 'package:smart_connected_health/widgets/loading_buttom.dart';
import 'package:smart_connected_health/widgets/widgets.dart';

import 'charts/chat_screen.dart';

class AnswerQuestion extends StatefulWidget {
  const AnswerQuestion({Key? key}) : super(key: key);

  @override
  State<AnswerQuestion> createState() => _AnswerQuestionState();
}

class _AnswerQuestionState extends State<AnswerQuestion> {
  RoundedLoadingButtonController controller = RoundedLoadingButtonController();
  TextEditingController texFieldControllerQ1 = TextEditingController();
  TextEditingController texFieldControllerQ2 = TextEditingController();
  TextEditingController texFieldControllerQ3 = TextEditingController();
  List<String>? questions;

  @override
  void initState() {
    List<String> reflectionQuestions = [
      "Daily Reflection: How did you feel when you woke up this morning? What was your first thought?",
      "Recent Interactions: Think about a conversation you had today that stands out. How did it make you feel and why?",
      "Work or School Experience: Describe a recent challenge or success at work or school. How did it affect your mood?",
      "Leisure and Relaxation: What do you do to relax, and how do you feel during and after that activity?",
      "Personal Accomplishments: Can you tell me about something you accomplished recently that you're proud of? How did it make you feel?",
      "Expectations vs. Reality: Was there anything that happened today that didn’t meet your expectations? How did you react emotionally?",
      "Social Dynamics: How do you generally feel about the interactions you have with your friends or colleagues? Is there a recent example that illustrates this feeling?",
      "Physical Wellbeing: How has your physical health affected your emotions lately?",
      "Cultural or Community Events: Have you participated in any community or cultural events recently? What was your emotional experience during these events?",
      "Family Relationships: Reflect on your recent interactions with your family. What emotions do these interactions usually evoke?",
      "Personal Challenges: Are there any personal issues or challenges you’re currently facing? How are they impacting your feelings?",
      "Future Outlook: What are you most hopeful or anxious about in the coming months?",
      "Media Consumption: What kind of media (books, movies, news) have you consumed recently, and what emotions did they evoke?",
      "Changes in Routine: Have there been any recent changes in your daily routine? How have these changes affected your mood?",
      "Moment of Joy or Sadness: Can you share a recent moment that made you very happy or very sad?"
    ];
    List<String> getRandomQuestions(int count) {
      Random rnd = Random();
      List<String> pickedQuestions = [];
      count = count > reflectionQuestions.length
          ? reflectionQuestions.length
          : count;

      while (pickedQuestions.length < count) {
        var question =
            reflectionQuestions[rnd.nextInt(reflectionQuestions.length)];
        if (!pickedQuestions.contains(question)) {
          pickedQuestions.add(question);
        }
      }

      return pickedQuestions;
    }

    questions = getRandomQuestions(3);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(questions![0]),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextFieldLogInSignUp(
                  title: 'QUESTION 1',
                  hint: 'Enter your answer here',
                  texFieldController: texFieldControllerQ1,
                  validator: (value) {
                    return null;
                  },
                  prefixIcon: Icons.book,
                  suffixIcon: Icons.close,
                  deleteOrHide: 'delete',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(questions![1]),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextFieldLogInSignUp(
                  title: 'QUESTION 2',
                  hint: 'Enter your answer here',
                  texFieldController: texFieldControllerQ2,
                  validator: (value) {
                    return null;
                  },
                  prefixIcon: Icons.book,
                  suffixIcon: Icons.close,
                  deleteOrHide: 'delete',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(questions![2]),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextFieldLogInSignUp(
                  title: 'QUESTION 3',
                  hint: 'Enter your answer here',
                  texFieldController: texFieldControllerQ3,
                  validator: (value) {
                    return null;
                  },
                  prefixIcon: Icons.book,
                  suffixIcon: Icons.close,
                  deleteOrHide: 'delete',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: LoadingButton(
          buttonText: 'SUBMIT',
          onPressed: () async {
            if (texFieldControllerQ1.text.isEmpty ||
                texFieldControllerQ2.text.isEmpty ||
                texFieldControllerQ3.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill all the fields')));
            } else {
              num answer1 =
                  await analyzeSentiment(answer: texFieldControllerQ1.text);
              num answer2 =
                  await analyzeSentiment(answer: texFieldControllerQ2.text);
              num answer3 =
                  await analyzeSentiment(answer: texFieldControllerQ3.text);
              await addEmotion(FirebaseAuth.instance.currentUser!.uid,
                  (answer1 + answer2 + answer3) / 3);

              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Answer submitted successfully')));
              AppRoutes.push(context, const ChartScreen());
            }
            controller.reset();
          },
          controller: controller,
        ),
      ),
    );
  }

  Future<void> addEmotion(String userId, num score) async {
    CollectionReference emotions =
        FirebaseFirestore.instance.collection('emotions');

    await emotions
        .add({'userId': userId, 'date': DateTime.now(), 'score': score});
  }
}
