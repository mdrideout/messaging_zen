import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IOSCompositionWidget extends StatelessWidget {
  const IOSCompositionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.
    const String viewType = 'messagingZenIosView';

    // Pass parameters to the platform side
    final Map<String, dynamic> creationParams = <String, dynamic>{};

    return UiKitView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}

class TogetherWidget extends StatelessWidget {
  const TogetherWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
