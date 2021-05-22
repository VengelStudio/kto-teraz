import 'package:flutter/material.dart';
import 'package:flutter_spinner/utils/collection.model.dart';
import 'package:flutter_spinner/widgets/question_box.dart';
import 'package:flutter/foundation.dart';

class CollectionCreator extends StatefulWidget {
  final bool isTabu;

  CollectionCreator({Key key, @required this.isTabu}) : super(key: key);

  @override
  _CollectionCreatorState createState() => _CollectionCreatorState();
}

class _CollectionCreatorState extends State<CollectionCreator> {
  @override
  void initState() {
    print(widget.isTabu);
    super.initState();
  }

  List<String> questions = [];
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
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(width: 1.0, color: Color(0xFF000000)),
              )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Nazwa kolekcji',
                    style: TextStyle(fontSize: 26.0),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "ZAPISZ",
                      style: TextStyle(fontSize: 26.0, color: Colors.black),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return QuestionBox(
                      title: questions[index],
                      callback: () {
                        setState(() {
                          questions.removeAt(index);
                        });
                      });
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
              child: Form(
                key: _formKey,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: questionController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Wpisz pytanie',
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          questions.add(questionController.text);
                          questionController.clear();
                        });
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
