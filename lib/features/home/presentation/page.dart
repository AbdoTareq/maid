import 'package:tasks/core/feature/data/models/users_wrapper.dart';
import 'package:tasks/core/utils.dart';
import 'package:tasks/core/view/widgets/custom_paged_list_view.dart';
import 'package:tasks/core/view/widgets/task_item.dart';
import 'package:tasks/features/home/presentation/cubit/cubit.dart';

import '../../../export.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeCubit cubit;
  final searchController = SearchController();

  @override
  void initState() {
    super.initState();
    cubit = sl<HomeCubit>();
    cubit.pagingController.addPageRequestListener((pageKey) {
      cubit.get(pageKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, BaseState<UsersWrapper>>(
        bloc: cubit,
        listener: (context, state) {
          if (state.status == RxStatus.Success) {
            final usersWrapper = state.data!;
            int? lastPage = usersWrapper.totalPages ?? 1;
            int currentPage = cubit.pagingController.nextPageKey ?? 1;
            if (currentPage >= lastPage) {
              cubit.pagingController.appendLastPage(usersWrapper.data ?? []);
              showSuccessSnack(message: 'reached the end');
            } else {
              cubit.pagingController
                  .appendPage(usersWrapper.data ?? [], currentPage + 1);
            }
          } else if (state.status == RxStatus.Error) {
            cubit.pagingController.error = state.errorMessage;
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: CustomAppBar(
              title: tasks,
              searchController: searchController,
            ),
            body: RefreshIndicator(
              backgroundColor: Theme.of(context).primaryColor,
              color: Theme.of(context).primaryColorDark,
              onRefresh: () async {
                cubit.pagingController.refresh();
              },
              child: CustomPagedListView<int, Task>(
                pagingController: cubit.pagingController,
                itemBuilder: (context, item, index) {
                  return TaskItem(
                    item: item,
                  );
                },
              ),
            ),
          );
        });
  }

  Future<void> addAction(BuildContext context) async {
    final Task? createdTask = await context.pushNamed(Routes.addTask);
    if (createdTask != null) {
      var list = cubit.pagingController.itemList!;
      list.add(createdTask);
      cubit.pagingController.appendLastPage(list);
      Logger().i(createdTask.toJson());
    }
  }
}
