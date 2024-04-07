import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_rich_text/super_rich_text.dart';
import 'package:tasks/core/feature/data/models/token_wrapper.dart';
import 'package:tasks/core/utils.dart';
import 'package:tasks/core/view/widgets/password_input.dart';
import 'package:tasks/features/login/presentation/cubit.dart';

import '../../../../../export.dart';

class LoginPage extends HookWidget {
  LoginPage({super.key});
  final cubit = sl<LoginCubit>();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final emailTextController = useTextEditingController();
    final passTextController = useTextEditingController();

    return Scaffold(
        backgroundColor: kBGGreyColor,
        appBar: CustomAppBar(title: login),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocListener<LoginCubit, BaseState<TokenWrapper>>(
              bloc: cubit,
              listener: (context, state) {
                if (state.status == RxStatus.Success) {
                  if (state.data != null) {
                    context.goNamed(Routes.home);
                  }
                } else if (state.status == RxStatus.Error) {
                  showFailSnack(message: state.errorMessage.toString());
                }
              },
              child: ListView(
                children: [
                  32.h.heightBox,
                  SvgPicture.asset(Assets.imagesLogin),
                  20.h.heightBox,
                  TextInput(
                    autofillHints: const [AutofillHints.email],
                    controller: emailTextController,
                    textColor: kBlack,
                    inputType: TextInputType.emailAddress,
                    hint: mail,
                    validate: (value) =>
                        value!.contains('@') ? null : mailWar.tr(),
                  ),
                  20.h.heightBox,
                  PasswordInput(
                    controller: passTextController,
                    hint: pass,
                  ),
                  20.h.heightBox,
                  RoundedCornerLoadingButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await cubit.login({
                            "email": emailTextController.text,
                            "password": passTextController.text,
                          });
                        }
                      },
                      text: login.tr()),
                  24.heightBox,
                  SuperRichText(
                    text: '${dontHaveAccount.tr()}  ll${signup.tr()}ll',
                    style: Theme.of(context).textTheme.titleMedium!,
                    othersMarkers: [
                      MarkerText(
                        marker: 'll',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: kPrimaryColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
