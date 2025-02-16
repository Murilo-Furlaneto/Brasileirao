import 'package:brasileirao/pages/home_page.dart';
import 'package:brasileirao/repository/api_repository_impl.dart';
import 'package:brasileirao/service/http_service.dart';
import 'package:brasileirao/provider/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final apiService = HttpService();
  final apiRepository = ApiRepositoryImpl(apiService);

  runApp(MyApp(apiRepository: apiRepository));
}

class MyApp extends StatelessWidget {
  final ApiRepositoryImpl apiRepository;

  const MyApp({super.key, required this.apiRepository});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(apiRepository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: const HomePage(),
      ),
    );
  }
}
