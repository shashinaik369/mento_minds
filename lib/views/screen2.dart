import 'package:flutter/material.dart';
import 'package:mento_mind_assignment/blocs/Notes/notes_bloc.dart';
import 'package:mento_mind_assignment/blocs/data_bloc/data_bloc.dart';
import 'package:mento_mind_assignment/constants.dart';
import 'package:mento_mind_assignment/modal/concepts_model.dart';
import 'package:mento_mind_assignment/modal/test_modal.dart';
import 'package:mento_mind_assignment/repository/test_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mento_mind_assignment/views/screen1.dart';

import 'widgets/warning_dialog.dart';

class Screen2 extends StatefulWidget {
  Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  TextEditingController testNameController = TextEditingController();

  late List<Topics> toppings;
  List<String> concepts = [];
  List<String> topics = [];
  bool isTicked = false;
  bool allticked = false;
  bool arrow = false;
  int currentIndex = 0;
  List<ConceptsModel> conceptModel = [];
  void clearText() {
    testNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final noteBloc = BlocProvider.of<NotesBloc>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
        ),
        title: Text(
          'Create New Test',
          style: kTextStyle.copyWith(
              fontWeight: FontWeight.w500, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TestName(testNameController: testNameController),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Topics',
                style: kTextStyle.copyWith(
                    fontWeight: FontWeight.w500, color: Colors.blue),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<DataBloc, DataState>(
                builder: (context, state) {
                  if (state is DataLoadedState) {
                    toppings = state.topics;

                    ///topics list view
                    return Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: toppings.length,
                          itemBuilder: ((context, index) {
                            var topicName = toppings[index].topicName!;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                        value: toppings[index].isTicked,
                                        onChanged: (value) {
                                          toppings[index].isTicked = value!;
                                          setState(() {
                                            allticked = value;
                                          });
                                        }),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (topics.isEmpty) {
                                            topics.add(topicName);
                                          } else if (topics.isNotEmpty) {
                                            if (topics.contains(topicName)) {
                                              topics.remove(topicName);
                                            } else {
                                              topics.add(topicName);
                                            }
                                          }
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            topicName,
                                            style: kTextStyle.copyWith(
                                                fontSize: 17),
                                          ),
                                          Icon(topics.contains(topicName)
                                              ? Icons.keyboard_arrow_up_rounded
                                              : Icons
                                                  .keyboard_arrow_down_rounded),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                ///concepts listview
                                topics.contains(topicName)
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            toppings[index].concepts!.length,
                                        itemBuilder: (context, conceptIndex) {
                                          var conceptNames = toppings[index]
                                              .concepts![conceptIndex];

                                          return Row(
                                            children: [
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Checkbox(
                                                  value: allticked
                                                      ? toppings[index].isTicked
                                                      : concepts.contains(
                                                              conceptNames)
                                                          ? true
                                                          : false,
                                                  onChanged: (value) {
                                                    allticked
                                                        ? toppings[index]
                                                            .isTicked = value!
                                                        : setState(() {
                                                            if (concepts
                                                                .isEmpty) {
                                                              concepts.add(
                                                                  conceptNames);
                                                            } else if (concepts
                                                                .isNotEmpty) {
                                                              if (concepts.contains(
                                                                  conceptNames)) {
                                                                concepts.remove(
                                                                    conceptNames);
                                                              } else {
                                                                concepts.add(
                                                                    conceptNames);
                                                              }
                                                            }
                                                          });

                                                    setState(() {});
                                                  }),
                                              Expanded(
                                                child: Text(conceptNames,
                                                    style: kTextStyle.copyWith(
                                                        fontSize: 17)),
                                              ),
                                            ],
                                          );
                                        })
                                    : const SizedBox()
                              ],
                            );
                          })),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              CreateButton(
                onTap: () {
                  if (testNameController.text.trim().isNotEmpty) {
                    noteBloc.add(AddNoteFrave(
                      title: testNameController.text,
                      created: DateTime.now(),
                      isComplete: false,
                    ));
                    clearText();
                    Navigator.pop(context);
                  } else {
                    modalWarning(context, 'Test Name is required');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}




class CreateButton extends StatelessWidget {
  VoidCallback onTap;
  CreateButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          height: 45,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6), color: Colors.blue),
          child: Center(
            child: Text(
              'Create',
              style: kTextStyle.copyWith(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}

class TestName extends StatelessWidget {
  const TestName({
    Key? key,
    required this.testNameController,
  }) : super(key: key);

  final TextEditingController testNameController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: testNameController,
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.card_travel,
            color: Colors.blue,
          ),
          hintText: 'Test Name',
          hintStyle: kTextStyle.copyWith(
              color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w500),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(15),
          )),
    );
  }
}
