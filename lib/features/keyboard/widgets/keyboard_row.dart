import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecotyper/features/keyboard/widgets/key_item.dart';

class KeyboardRow extends StatelessWidget {
  const KeyboardRow({
    super.key,
    required this.keys,
  });

  final List<String> keys;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.h),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: keys
            .map(
              (key) => KeyItem(
                text: key,
              ),
            )
            .toList(),
      ),
    );
  }
}
