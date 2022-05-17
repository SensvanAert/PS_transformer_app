import 'package:flutter/material.dart';
import 'package:transformer_testing_app/pages/home.dart';
import 'package:transformer_testing_app/pages/ratios.dart';
import 'package:transformer_testing_app/pages/resistances.dart';
import 'package:transformer_testing_app/pages/no-load_losses.dart';
import 'package:transformer_testing_app/pages/load_losses.dart';
import 'package:transformer_testing_app/pages/applied_voltage.dart';
import 'package:transformer_testing_app/pages/induced_voltage.dart';
import 'package:transformer_testing_app/pages/summary.dart';

void main() => runApp(MaterialApp(
  
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    fontFamily: 'Poppins',
  ),
  initialRoute: '/home',
  routes: {
    '/home': (context) => const Home(),
    '/ratios': (context) => RatioPage(),
    '/resistance': (context) => const ResistancesPage(),
    '/noLoad' :(context) => const noLoadPage(),
    '/load': (context) => const LoadPage(),
    '/applied': (context) => const AppliedVoltagePage(),
    '/induced':(context) => const InducedVoltagePage(),
    '/summary':(context) => const SummaryPage(),
  },
));




