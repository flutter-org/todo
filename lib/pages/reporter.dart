import 'package:flutter/material.dart';

class ReporterPage extends StatefulWidget {
  const ReporterPage({Key? key}) : super(key: key);

  @override
  State<ReporterPage> createState() => _ReporterPageState();
}

class _ReporterPageState extends State<ReporterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('报告'),
      ),
      body: Center(
        child: Text(
          runtimeType.toString(),
        ),
      ),
    );
  }
}
