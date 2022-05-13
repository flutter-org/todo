import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PlatformText extends StatelessWidget {
  final String? text;
  final String _viewType = 'platform_text_view';

  const PlatformText({Key? key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget platformView;
    if (defaultTargetPlatform == TargetPlatform.android) {
      platformView = AndroidView(
        viewType: _viewType,
        creationParams: text,
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      platformView = UiKitView(
        viewType: _viewType,
        creationParams: text,
        creationParamsCodec: const StandardMessageCodec(),
      );
    } else {
      platformView = const Text('不支持的平台');
    }
    return platformView;
  }
}
