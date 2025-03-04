import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/auth_state_model.dart';
import '../notifiers/auth_notifier.dart';

final authProvider = StateNotifierProvider.autoDispose<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);