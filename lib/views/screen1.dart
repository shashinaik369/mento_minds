import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mento_mind_assignment/constants.dart';
import 'package:mento_mind_assignment/modal/hive_modal/localNotes_model.dart';
import 'package:mento_mind_assignment/routes/routes.dart';
import 'package:mento_mind_assignment/views/screen2.dart';

import '../blocs/Notes/notes_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    final box = Hive.box<LocalNoteModel>('TestsCreated');
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const MockTestHead(),
            LocalNotesList(box: box),
          ],
        ),
      ),
    );
  }
}





class MockTestHead extends StatelessWidget {
  const MockTestHead({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Mock Test App',
          style: kTextStyle,
        ),
        SizedBox(
          height: 220,
          child: SvgPicture.network(
              'https://rush-analytics.com/wp-content/uploads/2021/10/audit-img.svg'),
        ),
        const CreateNewTestButton(),
        const SizedBox(
          height: 20,
        ),
        const Divider(
          color: Colors.blue,
          thickness: 4,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class CreateNewTestButton extends StatelessWidget {
  const CreateNewTestButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, MyRoutes.screen2);
        },
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.blue),
          child: Center(
            child: Text(
              'Create New Test',
              style: kTextStyle.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}



class LocalNotesList extends StatelessWidget {
  const LocalNotesList({
    Key? key,
    required this.box,
  }) : super(key: key);

  final Box<LocalNoteModel> box;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: box.listenable(),
      builder: (_, Box<LocalNoteModel> box, __) {
        if (box.values.isEmpty) {
          return const Center(
            child:
                Text('No Tests created', style: TextStyle(color: Colors.grey)),
          );
        }

        return BlocBuilder<NotesBloc, NotesState>(builder: (_, state) {
          return const Expanded(child: _ListNotes());
        });
      },
    );
  }
}






class _ListNotes extends StatefulWidget {
  const _ListNotes({Key? key}) : super(key: key);

  @override
  State<_ListNotes> createState() => _ListNotesState();
}

class _ListNotesState extends State<_ListNotes> {
  late Box<LocalNoteModel> box;
  @override
  void initState() {
    box = Hive.box('TestsCreated');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      itemCount: box.values.length,
      itemBuilder: (_, i) {
        LocalNoteModel note = box.get(i)!;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Container(
            padding:
                const EdgeInsets.only(left: 20, right: 30, top: 15, bottom: 15),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title.toString(),
                  style: kTextStyle,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Created on: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.6)),
                    ),
                    Text(
                      DateFormat.yMMMMd().add_jm().format(note.created!),
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
