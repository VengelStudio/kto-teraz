import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../utils/collection.dart';
import '../utils/question.dart';
import '../widgets/question_box.dart';
import 'package:collection/collection.dart';
import 'package:google_fonts/google_fonts.dart';
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
  final TextEditingController nameFieldController = new TextEditingController();
  final nameFieldFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    collectionName = widget.name;
    isForAdults = widget.isTabu;
    questions = widget.questions;
    nameFieldController.text = widget.name;

    SchedulerBinding.instance?.addPostFrameCallback((Duration _) {
      if (nameFieldController.text.isEmpty) {
        nameFieldFocusNode.requestFocus();
      }
    });
  }

  void onNameChanged(String updatedName) {
    this.collectionName = updatedName;
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
    if (!_formKey.currentState!.validate()) {
      return;
    }

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
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Form(
                    key: _formKey,
                    child: TextFormField(
                      focusNode: nameFieldFocusNode,
                      controller: nameFieldController,
                      style: TextStyle(
                        color: Theme.of(context).appBarTheme.backgroundColor,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        enabledBorder: new OutlineInputBorder(),
                        focusedBorder: new OutlineInputBorder(),
                        hintText: "Nazwa kolekcji",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nazwa kolekcji nie może być pusta';
                        }
                        return null;
                      },
                      onChanged: onNameChanged,
                      readOnly: widget.readonly,
                    )),
              ),
              SizedBox(width: 24),
              Container(
                child: Row(
                  children: [
                    Text(
                      "18+",
                      style: GoogleFonts.lato(fontSize: 16),
                    ),
                    Switch(
                      value: isForAdults,
                      onChanged: widget.readonly
                          ? null
                          : (value) {
                              setState(() {
                                isForAdults = !isForAdults;
                              });
                            },
                      activeColor: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                itemCount: questions.length + 1,
                itemBuilder: (context, index) {
                  if (index == questions.length) {
                    return TextButton(
                        onPressed: onAddQuestion,
                        child: Container(
                            margin: EdgeInsets.only(top: 16, bottom: 32),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Theme.of(context).primaryColor,
                                  size: 36,
                                ),
                                SizedBox(width: 8),
                                Text("DODAJ PYTANIE",
                                    style: GoogleFonts.signika(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ))
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
