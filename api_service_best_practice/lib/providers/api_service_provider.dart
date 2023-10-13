import 'package:api_service_best_practice/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<ApiService> apiServiceProvider = Provider((ref) => ApiService());
