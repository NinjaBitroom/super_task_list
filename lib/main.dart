import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:super_task_list/components/misc/task_app.dart';
import 'package:super_task_list/key_supabase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: KeySupabase.url, anonKey: KeySupabase.anonKey);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(const TaskApp());
}
