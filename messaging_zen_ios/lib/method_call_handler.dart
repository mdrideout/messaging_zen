import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:messaging_zen_ios/enums/invokable_methods_enum.dart';
import 'package:messaging_zen_ios/util/logger.dart';

/// Method Call Handler
/// Handles method calls made from the native platform
Future<dynamic> methodCallHandler(MethodCall call) async {
  final method = call.method;
  final arguments = call.arguments;

  InvokableMethodsEnum? methodEnum = InvokableMethodsEnum.values.firstWhereOrNull((e) => describeEnum(e) == method);

  if (methodEnum == null) {
    throw ("Native platform call.method is null and is not a valid InvokableMethodsEnum enum.");
  }

  switch (methodEnum) {
    case InvokableMethodsEnum.logger:
      {
        logger.d(arguments);
        break;
      }

    default:
      logger.e(
          "methodCallHandler call.method of $method has no matching case for the MethdCall from the native platform.");
      break;
  }
}
