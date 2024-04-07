import '../../../../export.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    super.key,
    required this.controller,
    required this.hint,
    this.validate,
    this.isUnderline = true,
    this.borderColor,
  });

  final TextEditingController controller;
  final String hint;
  final bool isUnderline;
  final String? Function(String?)? validate;
  final Color? borderColor;

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool isHide = true;
  @override
  Widget build(BuildContext context) {
    return TextInput(
      borderColor: widget.borderColor ?? kPrimaryColor,
      controller: widget.controller,
      autofillHints: const [AutofillHints.password],
      hint: widget.hint,
      maxLines: 1,
      showUnderline: widget.isUnderline,
      suffixIcon: InkWell(
        onTap: () => setState(() {
          isHide = !isHide;
        }),
        child: Icon(!isHide ? Icons.visibility : Icons.visibility_off),
      ),
      isPass: isHide,
      validate:
          widget.validate ?? (value) => value!.length > 5 ? null : passWar,
    );
  }
}
