import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEnv {
  static final baseUrl = dotenv.env['API_URL']!;
}
