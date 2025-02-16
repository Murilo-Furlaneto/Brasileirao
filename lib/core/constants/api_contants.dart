import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiContants {
  static String url = dotenv.get('BASE_URL');
  static String token = dotenv.get('TOKEN');
}
