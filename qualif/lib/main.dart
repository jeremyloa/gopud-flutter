import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qualif/login.dart';
import 'package:qualif/theme.dart';

void main() {
  runApp(ChangeNotifierProvider(
    child: const Qualif(),
    create: (context) => ThemeProvider(isDark: true),
  ));
}

class Qualif extends StatefulWidget {
  const Qualif({super.key});

  @override
  State<Qualif> createState() => _QualifState();
}

class _QualifState extends State<Qualif> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Gopud',
          theme: themeProvider.getTheme,
          home: LoginPage(),
        );
      },
    );
  }
}
