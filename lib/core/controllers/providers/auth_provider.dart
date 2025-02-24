import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/auth_state_model.dart';
import '../auth_notifier.dart';

final authProvider = StateNotifierProvider.autoDispose<AuthController, AuthState>(
  (ref) => AuthController(),
);