import 'package:tasks/export.dart';

extension NumExtension on double {
  SizedBox get heightBox {
    return SizedBox(height: this);
  }

  SizedBox get widthBox {
    return SizedBox(width: this);
  }
}

extension Num2Extension on num {
  SizedBox get heightBox {
    return SizedBox(height: toDouble());
  }

  SizedBox get widthBox {
    return SizedBox(width: toDouble());
  }
}
