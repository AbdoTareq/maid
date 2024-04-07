import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:tasks/core/feature/data/models/users_wrapper.dart';
import 'package:tasks/core/utils.dart';
import 'package:tasks/export.dart';
import 'package:tasks/features/home/presentation/cubit/cubit.dart';

class TaskItem extends StatelessWidget {
  TaskItem({
    super.key,
    required this.item,
    this.fromSearch = false,
  });
  final Task item;
  final bool fromSearch;
  final PagingController<int, Task> pagingController =
      sl<HomeCubit>().pagingController;

  Future<void> editAction(
    Task item,
    BuildContext context,
  ) async {
    final Task? editedTask =
        await context.pushNamed(Routes.addTask, extra: item);
    if (editedTask != null) {
      var list = pagingController.itemList!;
      int index = list.indexWhere((element) => element.id == item.id);
      list[index] = editedTask;
      pagingController.appendLastPage(list);
      Logger().i(editedTask.toJson());
    }
    if (fromSearch) {
      context.pop();
    }
  }

  Future<void> deleteAction(Task item, BuildContext context) async {
    final res = await sl<HomeCubit>().delete(item.id!);
    res.fold((l) => showFailSnack(message: l.message), (r) {
      showSuccessSnack(message: success);
      var list = pagingController.itemList!;
      list.removeWhere((element) => element.id == item.id);
      pagingController.appendLastPage(list);
    });
    if (fromSearch) {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      child: Card(
        child: ListTile(
          title: Text(
            '${item.firstName ?? ''} ${item.lastName ?? ''}',
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall,
            maxLines: 1,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item.email != null)
                Text(
                  item.email!,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 1,
                ),
              if (item.job != null)
                Text(
                  item.job!,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 1,
                ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => editAction(item, context),
                child: const Icon(Icons.edit),
              ),
              12.w.widthBox,
              ActionIcon(
                onTap: () async => await deleteAction(item, context),
                icon: Icons.delete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
