import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/mail_validate_notifier.dart';
import '../models/mail_validate_model.dart';

final mailValidateProvider =
    StateNotifierProvider<MailValidateNotifier, MailValideModel>((ref) {
  return MailValidateNotifier();
});
