import 'package:flutter/material.dart';
import 'package:mento_mind_assignment/modal/hive_modal/localNotes_model.dart';
import 'package:mento_mind_assignment/routes/routes.dart';
import 'package:mento_mind_assignment/views/screen1.dart';
import 'package:mento_mind_assignment/views/screen2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'blocs/Notes/notes_bloc.dart';
import 'blocs/data_bloc/data_bloc.dart';
import 'repository/test_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(LocalNoteModelAdapter());
  await Hive.openBox<LocalNoteModel>('TestsCreated');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TestRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DataBloc(
              RepositoryProvider.of<TestRepository>(context),
            )..add(DataLoadingEvent()),
          ),
          BlocProvider(
            create: (context) => NotesBloc(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(),
          onGenerateRoute: MyRoutes.onGenerateRoute,
          initialRoute: MyRoutes.screen1,
        ),
      ),
    );
  }
}
