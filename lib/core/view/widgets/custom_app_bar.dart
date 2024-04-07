import 'package:tasks/core/view/widgets/task_item.dart';
import 'package:tasks/features/home/presentation/cubit/cubit.dart';

import '../../../export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    super.key,
    required this.title,
    this.searchController,
  });

  final SearchController? searchController;
  final String title;
  final cubit = sl<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title, style: Theme.of(context).textTheme.titleLarge),
        actions: [
          searchController == null
              ? Container()
              : SearchAnchor(
                  searchController: searchController,
                  builder: (context, SearchController searchController) =>
                      IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            searchController.openView();
                          }),
                  viewHintText: 'Start typing to filter',
                  suggestionsBuilder:
                      (context, SearchController searchController) => cubit
                          .pagingController.itemList!
                          .where((element) =>
                              '${element.firstName!} ${element.lastName}'
                                  .contains(searchController.text))
                          .map(
                            (e) => TaskItem(
                              item: e,
                              fromSearch: true,
                            ),
                          ),
                )
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
