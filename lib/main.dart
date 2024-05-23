import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:super_task_list/app.dart';
import 'package:super_task_list/key_supabase.dart';
import 'package:super_task_list/models/task_list_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: KeySupabase.url, anonKey: KeySupabase.anonKey);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(ChangeNotifierProvider(
    create: (context) => TaskListModel(),
    child: const App(),
  ));
}
