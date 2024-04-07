import '../../export.dart';

// methods

void showSuccessSnack({required String message}) {
  ScaffoldMessenger.of(navKey.currentContext!).showSnackBar(
    SnackBar(
      content: Text(message.tr(),
          style: Theme.of(navKey.currentContext!).textTheme.labelSmall),
      backgroundColor: kPrimaryColor,
    ),
  );
}

void showFailSnack({required String message}) {
  ScaffoldMessenger.of(navKey.currentContext!).showSnackBar(
    SnackBar(
      content: Text(message.tr(),
          style: Theme.of(navKey.currentContext!).textTheme.labelSmall),
      backgroundColor: kRed,
    ),
  );
}
