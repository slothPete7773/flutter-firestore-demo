import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scoring_firebase_app/model/studentscore.dart';

class ScoreForm extends StatefulWidget {
  const ScoreForm({Key? key}) : super(key: key);

  @override
  State<ScoreForm> createState() => _ScoreFormState();
}

class _ScoreFormState extends State<ScoreForm> {
  final formKey = GlobalKey<FormState>();
  StudentScore myScore = StudentScore();

  CollectionReference _scoreCollection =
      FirebaseFirestore.instance.collection('scores');

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saving score application'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                const Text(
                  'Student ID',
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(
                  onSaved: (studentId) {
                    myScore.studentId = studentId;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Name',
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(
                  onSaved: (name) {
                    myScore.name = name;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Email',
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(
                  onSaved: (email) {
                    myScore.email = email;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Score',
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(
                  onSaved: (score) {
                    myScore.score = score;
                  },
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text(
                      'Save score',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        await _scoreCollection.add({
                          'studentId': myScore.studentId,
                          'name': myScore.name,
                          'email': myScore.email,
                          'score': myScore.score
                        });
                        formKey.currentState!.reset();
                      }
                    },
                  ),
                ),
              ])),
        ),
      ),
    );
  }
}
