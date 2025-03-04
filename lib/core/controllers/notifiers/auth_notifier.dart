import 'package:flutter/widgets.dart';
import '../../constants/navigate/navigate_constants.dart';
import '../../dependency_injection/di.dart';
import '../../navigate/navigate_services.dart';
import '../../services/auth/firebase_auth_services.dart';
import '_base_notifier.dart';
import '../models/auth_state_model.dart';

class AuthNotifier extends BaseNotifier<AuthState> {
  AuthNotifier() : super(AuthState());
  final authService = getIt<AuthService>();

  Future<void> registerUser(
      String email, String password, String username) async {
    updateState(state.copyWith(isLoading: true));

    // 🔥 Firestore'a kayıt yap
    final result = await authService.registerUser(
      username: username,
      email: email,
      password: password,
    );

    result.fold(
      (failure) {
        debugPrint("❌ Registration Error: ${failure}");
      },
      (_) {
        debugPrint("✅ Kullanıcı kaydı başarılı!");
        // **Login ekranına yönlendir**
        NavigationService.instance.navigateToPageClear(
          path: NavigateConstants.LOGIN,
        );
      },
    );
  }

  Future<void> loginUser(String email, String password) async {
    updateState(state.copyWith(isLoading: true));

    /*  try {
      await ApiService.login(email, password);
      updateState(state.copyWith(isAuthenticated: true, isLoading: false));
    } catch (e) {
      updateState(state.copyWith(isLoading: false, errorMessage: "Giriş Başarısız"));
    } */
  }

  void logout() {
    resetState(AuthState());
  }
}
