import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera_shop/service/auth_service.dart';

import '../model/user_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc({required this.authService}) : super(UnauthenticatedState()) {
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
  }

  void _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      final user = await authService.login(event.email, event.password);
      emit(AuthenticatedState(user: user));
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }

  void _onLogout(LogoutEvent event, Emitter<AuthState> emit) {
    emit(UnauthenticatedState());
  }
}
