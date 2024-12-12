// features/profile/presentation/widget/mycard_widget.dart
import 'package:bookia/core/functions/text_title.dart';
import 'package:bookia/core/utils/colos.dart';
import 'package:flutter/material.dart';

class MycardWidget extends StatelessWidget {
  MycardWidget({super.key, required this.onTap, required this.title});
  void Function()? onTap;
  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.whiteColor,
      elevation: 20,
      shadowColor: AppColor.grayColor.withOpacity(.3),
      child: ListTile(
        onTap: onTap,
        tileColor: AppColor.whiteColor,
        title: title,
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
