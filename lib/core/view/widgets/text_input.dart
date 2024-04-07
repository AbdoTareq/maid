import 'package:tasks/core/extensions/string_extension.dart';

import '../../../export.dart';

// TextField that takes TextEditingController from the main controller(ex:LoginController) to control text from outside to be independent widget
class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    this.focus,
    this.controller,
    this.function,
    required this.hint,
    this.spaceAfter = true,
    this.inputType,
    this.contentPadding,
    this.maxLength,
    this.registerFocus = false,
    this.isPass = false,
    this.onTap,
    this.disableInput = false,
    this.enabled = true,
    this.borderColor = kPrimaryColor,
    this.validate,
    this.suffixIcon,
    this.prefixIcon,
    this.fontSize,
    this.color,
    this.onChanged,
    this.textColor = kBlack,
    this.showUnderline = true,
    this.hintColor = kGreyShade,
    this.autofillHints,
    this.minLines,
    this.maxLines,
    this.cursorColor,
  });

  final FocusNode? focus;
  final Function? function;
  final String hint;
  final bool spaceAfter;
  final TextInputType? inputType;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final double? contentPadding;
  final Function(String value)? onChanged;
  final double? fontSize;
  final bool registerFocus;
  final bool isPass;
  final Function()? onTap;
  final bool disableInput;
  final bool enabled;
  final Color? borderColor;
  final Color? cursorColor;
  final String? Function(String?)? validate;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? color;
  final Color? textColor;
  final Color? hintColor;
  final TextEditingController? controller;
  final bool showUnderline;
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: autofillHints,
      onTapOutside: (event) => FocusManager.instance.primaryFocus!.unfocus(),
      style: TextStyle(color: textColor ?? borderColor),
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(contentPadding ?? 16),
        errorStyle: const TextStyle(fontSize: 12, height: 0.8),
        filled: color != null,
        fillColor: color,
        labelStyle: hintColor != null
            ? TextStyle(color: hintColor, fontSize: fontSize)
            : borderColor != null
                ? TextStyle(color: borderColor, fontSize: fontSize)
                : TextStyle(fontSize: fontSize),
        hintStyle: Theme.of(context).textTheme.titleMedium,
        labelText: hint.capitalize(),
        suffixIcon: suffixIcon,
        suffixIconConstraints: const BoxConstraints(
          minWidth: 80,
        ),
        prefixIcon: prefixIcon,
        prefixIconConstraints: const BoxConstraints(
          minWidth: 80,
        ),
        border: !showUnderline
            ? InputBorder.none
            : const OutlineInputBorder(
                borderSide: BorderSide(
                  color: kPrimaryColor,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                )),
        enabledBorder: borderColor != null
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: borderColor!,
                ),
              )
            : null,
        focusedBorder: borderColor != null
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: borderColor!,
                ),
              )
            : null,
      ),
      onTap: onTap,
      cursorColor: cursorColor ?? borderColor,
      onChanged: onChanged,
      minLines: minLines,
      maxLines: maxLines,
      textInputAction: TextInputAction.next,
      autofocus: registerFocus,
      enableInteractiveSelection: !disableInput,
      enabled: enabled,
      keyboardType: inputType,
      obscureText: isPass,
      inputFormatters: [
        if (inputType == TextInputType.number)
          FilteringTextInputFormatter.allow(RegExp("[-0-9,.]")),
      ],
      readOnly: disableInput,
      maxLength: maxLength,
      onFieldSubmitted: (v) async {
        FocusScope.of(context).requestFocus(focus);
        try {
          await function!();
        } catch (e) {}
      },
      validator: validate,
    );
  }
}
