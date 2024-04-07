import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tasks/core/feature/data/models/users_wrapper.dart';
import 'package:tasks/core/utils.dart';
import 'package:tasks/features/home/presentation/cubit/cubit.dart';

import '../../../../../../../export.dart';

class AddTaskPage extends HookWidget {
  final Task? item;
  final GlobalKey<FormState> formKey = GlobalKey();
  final controller = sl<HomeCubit>();

  AddTaskPage({super.key, this.item});
  @override
  Widget build(BuildContext context) {
    final nameTextController = useTextEditingController(
        text: '${item?.firstName ?? ''} ${item?.lastName ?? ''}');
    final jobTextController = useTextEditingController(text: item?.job ?? '');

    return Scaffold(
      appBar: CustomAppBar(title: addNewTask),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  .3.sh.heightBox,
                  TextInput(
                    autofillHints: const [AutofillHints.name],
                    controller: nameTextController,
                    textColor: kBlack,
                    hint: name,
                    validate: (value) => value!.isNotEmpty ? null : war.tr(),
                  ),
                  16.h.heightBox,
                  TextInput(
                    autofillHints: const [AutofillHints.name],
                    controller: jobTextController,
                    textColor: kBlack,
                    hint: job,
                    validate: (value) => value!.isNotEmpty ? null : war.tr(),
                  ),
                  16.h.heightBox,
                  RoundedCornerLoadingButton(
                    onPressed: () async {
                      final res = await controller.save(nameTextController.text,
                          jobTextController.text, item?.id);
                      res.fold((l) => showFailSnack(message: l.message), (r) {
                        context.pop(r.copyWith(
                            firstName: nameTextController.text,
                            job: jobTextController.text));
                        showSuccessSnack(message: success);
                      });
                    },
                    text: save,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
