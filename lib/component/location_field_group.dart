import 'package:flutter/material.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/platform_channel/platform_channel.dart';

/// 支持用户点击弹出的日期选择器组件
class LocationFieldGroup extends StatefulWidget {
  final Function(Location)? onChange;

  /// 用来展示选择的位置的组件
  final Widget child;

  const LocationFieldGroup({
    Key? key,
    required this.child,
    this.onChange,
  }) : super(key: key);

  @override
  State<LocationFieldGroup> createState() => _LocationFieldGroupState();
}

class _LocationFieldGroupState extends State<LocationFieldGroup> {
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          isLoading = true;
        });
        Location location = await PlatformChannel.getCurrentLocation();
        if (widget.onChange != null) {
          widget.onChange!(location);
        }
        setState(() {
          isLoading = false;
        });
      },
      child: AbsorbPointer(
        child: Stack(
          children: [
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(),
            Opacity(
              opacity: isLoading ? 0.5 : 1.0,
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }
}
