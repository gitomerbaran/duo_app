import 'base_notifier.dart';
import 'models/auth_state_model.dart';

class AuthController extends BaseController<AuthState> {
  AuthController() : super(AuthState());

  Future<void> registerUser(String email, String password) async {
    updateState(state.copyWith(isLoading: true));
    
 /*    try {
      await ApiService.register(email, password);
      updateState(state.copyWith(isRegistered: true, isLoading: false));
      resetState(AuthState()); // ✅ State sıfırlandı
    } catch (e) {
      updateState(state.copyWith(isLoading: false, errorMessage: "Kayıt Başarısız"));
    } */
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
