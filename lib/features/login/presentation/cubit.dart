import 'package:tasks/core/feature/data/models/token_wrapper.dart';
import 'package:tasks/core/utils.dart';
import 'package:tasks/features/login/domain/usecases/usecases.dart';

import '../../../../../export.dart';

class LoginCubit extends Cubit<BaseState<TokenWrapper>> {
  LoginCubit({
    required this.useCase,
  }) : super(const BaseState());
  final AuthUseCase useCase;

  Future<TokenWrapper?> login(Map<String, String> user) async {
    final response = await useCase.login(user);
    return response.fold((l) {
      emit(state.copyWith(errorMessage: l.message, status: RxStatus.Error));
      return null;
    }, (r) {
      emit(state.copyWith(data: r, status: RxStatus.Success));
      return r;
    });
  }

  logout() async {
    final response = await useCase.logout();
    return response.fold((l) {
      showFailSnack(message: l.message);
      return null;
    }, (r) {
      showSuccessSnack(message: r.toString());
      return r;
    });
  }
}
