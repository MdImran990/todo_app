import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app/app.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables before the app starts.
  await dotenv.load(fileName: '.env');
  runApp(const TaskFlowApp());
}