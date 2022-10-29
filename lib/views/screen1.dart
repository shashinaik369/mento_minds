import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mento_mind_assignment/blocs/tests_bloc/test_bloc.dart';
import 'package:mento_mind_assignment/constants.dart';

import 'package:mento_mind_assignment/routes/routes.dart';
import 'package:mento_mind_assignment/views/screen2.dart';

import 'package:flutter_svg/flutter_svg.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const MockTestHead(),
            Expanded(child: LocalNotesList()),
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestBloc, TestState>(builder: (context, state) {
      if (state is TestInitial) {
        return Center(child: CircularProgressIndicator());
      }
      if (state is TestLoadedState) {
        return ListView.builder(
            shrinkWrap: true,
            itemCount: state.tests.length,
            itemBuilder: (context, index) {
              return state.tests.isEmpty ? Center(child: Text('No Tests Created',style: kTextStyle.copyWith(color: Colors.grey.withOpacity(0.5)),),)
              : Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 20, right: 30, top: 15, bottom: 15),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.tests[index].title,
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
                            DateFormat.yMMMMd()
                                .add_jm()
                                .format(state.tests[index].time),
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            });
      }
      return Text('something went wrong');
    });
  }
}
