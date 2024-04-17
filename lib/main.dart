import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:super_task_list/app.dart';
import 'package:super_task_list/key_supabase.dart';
import 'package:system_theme/system_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: KeySupabase.url, anonKey: KeySupabase.anonKey);
  SystemTheme.fallbackColor = Colors.blueAccent;
  await SystemTheme.accentColor.load();
  runApp(const App());
}
