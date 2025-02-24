import 'package:equatable/equatable.dart';

class MailValideModel extends Equatable {
  final String enteredCode;
  final String otpCode;

  const MailValideModel({this.enteredCode = "", this.otpCode = ""});

  MailValideModel copyWith({String? enteredCode, String? otpCode}) {
    return MailValideModel(
      enteredCode: enteredCode ?? this.enteredCode,
      otpCode: otpCode ?? this.otpCode,
    );
  }

  @override
  List<Object?> get props => [enteredCode, otpCode];
}
