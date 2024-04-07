import 'package:flutter/material.dart';
import 'package:tasks/core/app_colors.dart';

class RoundedCornerLoadingButton extends StatefulWidget {
  const RoundedCornerLoadingButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.color,
    this.isOutlined = false,
    this.borderColor,
  });

  final Function() onPressed;
  final Color? color;
  final Color? borderColor;
  final String text;
  final bool isOutlined;

  @override
  State<RoundedCornerLoadingButton> createState() =>
      _RoundedCornerLoadingButtonState();
}

class _RoundedCornerLoadingButtonState
    extends State<RoundedCornerLoadingButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: widget.isOutlined
            ? ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Theme.of(context).primaryColor),
                )))
            : ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    widget.color ?? Theme.of(context).primaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ))),
        onPressed: isLoading
            ? null
            : () async {
                if (mounted) {
                  setState(() {
                    isLoading = true;
                  });
                }
                await widget.onPressed();
                if (mounted) {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: isLoading
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child:
                      Center(child: CircularProgressIndicator(color: kWhite)))
              : Text(widget.text,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: kWhite)),
        ));
  }
}
