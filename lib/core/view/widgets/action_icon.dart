import 'package:tasks/export.dart';

class ActionIcon extends StatefulWidget {
  const ActionIcon({
    super.key,
    required this.onTap,
    required this.icon,
  });

  final Function onTap;
  final IconData icon;

  @override
  State<ActionIcon> createState() => _ActionIconState();
}

class _ActionIconState extends State<ActionIcon> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading
          ? null
          : () async {
              if (mounted) {
                setState(() {
                  isLoading = true;
                });
              }
              await widget.onTap();
              if (mounted) {
                setState(() {
                  isLoading = false;
                });
              }
            },
      child: isLoading
          ? const SizedBox(
              height: 16,
              width: 16,
              child: Center(
                  child: CircularProgressIndicator(color: kPrimaryColor)))
          : Icon(widget.icon),
    );
  }
}
