import 'dart:developer';

import 'package:flutter/foundation.dart';

class ErrorUtils {
  const ErrorUtils._();

  ErrorUtils.printException(Object e, StackTrace stackTrace, {String? methodName}) {
    if (!kDebugMode) return;

    log(e.toString(), name: e.runtimeType.toString(), stackTrace: stackTrace, error: e);
  }
}
