import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:super_task_list/components/misc/app.dart';
import 'package:super_task_list/key_supabase.dart';
import 'package:super_task_list/providers/task_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: KeySupabase.url, anonKey: KeySupabase.anonKey);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(ChangeNotifierProvider(
    create: (context) => TaskProvider(),
    child: const App(),
  ));
}
