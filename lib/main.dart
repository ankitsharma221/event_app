import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task1/bloc/event_repo.dart';
import 'bloc/bloc.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: BlocProvider(
        create: (context) => EventBloc(EventRepository(
            'https://sde-007.api.assignment.theinternetfolks.works/v1/event')),
        child: const HomePage(),
      ),
    );
  }
}
