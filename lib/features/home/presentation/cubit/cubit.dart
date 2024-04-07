import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tasks/core/feature/data/models/users_wrapper.dart';
import 'package:tasks/export.dart';
import 'package:tasks/features/home/usecases/usecases.dart';

class HomeCubit extends Cubit<BaseState<UsersWrapper>> {
  final TaskUseCase useCase;
  final pagingController = PagingController<int, Task>(firstPageKey: 1);

  HomeCubit({required this.useCase}) : super(const BaseState());

  get(int pageKey) async {
    emit(state.copyWith(status: RxStatus.Loading));
    final response = await useCase.get(pageKey);
    response.fold((l) {
      emit(state.copyWith(status: RxStatus.Error, errorMessage: l.message));
    }, (r) {
      emit(state.copyWith(
          status: (r.data ?? []).isEmpty ? RxStatus.empty : RxStatus.Success,
          data: r));
      r;
    });
  }

  Future<Either<Failure, Task>> save(
      String name, String job, String? id) async {
    emit(state.copyWith(status: RxStatus.Loading));
    final task = {"name": name, "job": job};
    final response =
        await (id == null ? useCase.create(task) : useCase.update(id, task));
    return response;
  }

  Future<Either<Failure, Map<String, dynamic>?>> delete(String id) async {
    emit(state.copyWith(status: RxStatus.Loading));
    final response = await useCase.delete(id);
    return response;
  }
}
