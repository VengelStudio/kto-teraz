import 'package:flutter/material.dart';
import 'package:flutter_spinner/utils/collection.dart';
import 'package:flutter_spinner/utils/question.dart';
import 'package:flutter_spinner/widgets/question_box.dart';
import 'package:collection/collection.dart';
import 'collections_page.dart';

class CollectionEditor extends StatefulWidget {
  final String uuid;
  final String name;
  final bool isTabu;
  final List<Question> questions;
  final bool readonly;

  CollectionEditor(
      {Key? key,
      required this.uuid,
      required this.name,
      required this.isTabu,
      required this.questions,
      this.readonly = false});

  @override
  _CollectionEditorState createState() => _CollectionEditorState();
}

class _CollectionEditorState extends State<CollectionEditor> {
  String collectionName = '';
  List<Question> questions = [];
  bool isForAdults = false;

  @override
  void initState() {
    super.initState();

    collectionName = widget.name;
    isForAdults = widget.isTabu;
    questions = widget.questions;

    print(widget.readonly);
  }

  void onAddQuestion() {
    Question? existingEmptyQuestion = this.questions.firstWhereOrNull(
          (element) => element.text.isEmpty,
        );

    if (existingEmptyQuestion != null) {
      existingEmptyQuestion.focusNode.requestFocus();
      return;
    }

    setState(() {
      Question newQuestion = new Question(text: "");
      questions.add(newQuestion);
    });
  }

  void onSave() {
    Collection newCollection = new Collection(
      uuid: widget.uuid,
      name: collectionName,
      isTabu: isForAdults,
      questions: questions,
    );

    newCollection.saveCollection();

    Navigator.pop(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CollectionsPage()),
    );
  }

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
                  bottom: BorderSide(width: 1, color: Colors.black54),
                )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                      widget.name,
                      style: TextStyle(fontSize: 26.0),
                      overflow: TextOverflow.ellipsis,
                    )),
                    Container(
                      child: Row(
                        children: [
                          Text("18+"),
                          Switch(
                            value: isForAdults,
                            onChanged: (value) {
                              setState(() {
                                isForAdults = !isForAdults;
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
                        onPressed: onAddQuestion,
                        child: Container(
                            margin:
                                EdgeInsets.only(top: 16, bottom: 32, left: 16),
                            child: Row(
                              children: [
                                Icon(Icons.add),
                                Text("Dodaj pytanie"),
                              ],
                            )));
                  }

                  return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: QuestionBox(
                          question: questions[index],
                          autofocus: questions[index].text.isEmpty,
                          onChanged: (text) {
                            setState(() {
                              questions.elementAt(index).setText(text);
                            });
                          },
                          onDelete: () {
                            setState(() {
                              questions.removeAt(index);
                            });
                          },
                          readonly: !widget.readonly));
                },
              ))
            ],
          ),
        ),
        floatingActionButton: Visibility(
            visible: !widget.readonly &&
                MediaQuery.of(context).viewInsets.bottom == 0,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 42.0),
              child: FloatingActionButton.extended(
                  onPressed: onSave,
                  icon: Icon(Icons.save),
                  label: Text(
                    "ZAPISZ",
                  )),
            )));
  }
}
