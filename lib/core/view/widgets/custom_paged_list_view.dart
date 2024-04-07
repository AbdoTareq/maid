import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lottie/lottie.dart';
import 'package:tasks/core/app_colors.dart';
import 'package:tasks/core/extensions/num_extension.dart';

class CustomPagedListView<T, Y> extends StatelessWidget {
  const CustomPagedListView(
      {super.key,
      required this.pagingController,
      required this.itemBuilder,
      this.firstLoadingBuilder,
      this.shrinkWrap = true,
      this.tryAgainEvent,
      this.padding,
      this.scrollDirection = Axis.vertical});

  final PagingController<T, Y> pagingController;
  final ItemWidgetBuilder<Y> itemBuilder;
  final GestureTapCallback? tryAgainEvent;
  final Axis scrollDirection;
  final WidgetBuilder? firstLoadingBuilder;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return PagedListView<T, Y>(
      key: Key(pagingController.hashCode.toString()),
      pagingController: pagingController,
      scrollDirection: scrollDirection,
      padding: padding,
      builderDelegate: PagedChildBuilderDelegate<Y>(
          itemBuilder: itemBuilder,
          noItemsFoundIndicatorBuilder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LottieBuilder.network(
                    'https://lottie.host/b9919ceb-27b6-426d-a572-cd84fffc995a/V0B77VGGej.json'),
                24.heightBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text("Nothing is here..",
                      style: Theme.of(context).textTheme.labelSmall),
                ),
              ],
            );
          },
          firstPageErrorIndicatorBuilder: (context) {
            return scrollDirection == Axis.horizontal
                ? GestureDetector(
                    onTap: tryAgainEvent,
                    child: Container(
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 48.0, vertical: 10),
                        child: Text(
                          "Reload",
                          style: TextStyle(
                              color: kWhite,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  )
                : const SizedBox();
          },
          newPageErrorIndicatorBuilder: (context) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                      "Something went wrong, please try refreshing the page again.",
                      style: Theme.of(context).textTheme.labelSmall),
                ),
                const SizedBox(
                  height: 32,
                ),
                GestureDetector(
                  onTap: tryAgainEvent,
                  child: Container(
                    decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 48.0, vertical: 12),
                      child: Text("Try again",
                          style: Theme.of(context).textTheme.labelSmall),
                    ),
                  ),
                ),
              ],
            );
          },
          noMoreItemsIndicatorBuilder: (context) => SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Center(
                    child: Text('No more items',
                        style: Theme.of(context).textTheme.labelSmall),
                  ),
                ),
              ),
          firstPageProgressIndicatorBuilder: (context) => const Center(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          newPageProgressIndicatorBuilder: firstLoadingBuilder ??
              (context) => Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                      child: const Center(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  )),
      shrinkWrap: shrinkWrap,
    );
  }
}
