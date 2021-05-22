import 'package:flutter/material.dart';
import 'package:flutter_spinner/utils/collection.model.dart';
import 'package:flutter_spinner/utils/questions.dart';
import 'package:flutter_spinner/widgets/question_box.dart';
import 'package:flutter/foundation.dart';

import 'collections_page.dart';

class CollectionCreator extends StatefulWidget {
  // final bool isTabu;

  // CollectionCreator({Key key, @required this.isTabu}) : super(key: key);

  @override
  _CollectionCreatorState createState() => _CollectionCreatorState();
}

class _CollectionCreatorState extends State<CollectionCreator> {
  @override
  void initState() {
    super.initState();
  }

  List<Question> questions = [];
  final questionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Collection collection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(width: 1.0, color: Color(0xFF000000)),
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    'Nazwa kolekcji',
                    style: TextStyle(fontSize: 26.0),
                    overflow: TextOverflow.ellipsis,
                  )),
                  Container(
                    child: Row(
                      children: [
                        Text("18+"),
                        Switch(
                          value: true,
                          onChanged: (value) {
                            setState(() {
                              // gameOptions.isTabuEnabled = value;
                            });
                          },
                          activeColor: Colors.blue,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: questions.length + 1,
                itemBuilder: (context, index) {
                  if (index == questions.length) {
                    return TextButton(
                        onPressed: () {
                          setState(() {
                            Question newQuestion = new Question(
                                isTabu: false, probability: 0.5, text: "");
                            questions.add(newQuestion);
                            questionController.clear();
                          });
                        },
                        child: Padding(
                            padding: EdgeInsets.only(bottom: 32),
                            child: Row(
                              children: [
                                Icon(Icons.add),
                                Text("Dodaj pytanie"),
                              ],
                            )));
                  }

                  return QuestionBox(
                      title: questions[index].text,
                      autofocus: questions[index].text.isEmpty,
                      callback: () {
                        setState(() {
                          questions.removeAt(index);
                        });
                      });
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 42.0),
        child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CollectionsPage()),
              );
            },
            icon: Icon(Icons.save),
            label: Text("Zapisz")),
      ),
    );
  }
}
