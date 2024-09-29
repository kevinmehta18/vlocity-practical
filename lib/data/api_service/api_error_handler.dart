import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:practical/shared/constants/strings.dart';

import 'package:practical/shared/utils/toasts.dart';
import 'package:toastification/toastification.dart';


String getErrorMessage(DioException e) {
  switch (e.type) {
    case DioExceptionType.sendTimeout:
      return sendTimeoutError;
    case DioExceptionType.receiveTimeout:
      return receiveTimeoutError;
    case DioExceptionType.connectionTimeout:
      return connectionTimeoutError;
    case DioExceptionType.badResponse:
      return badResponseError;
    case DioExceptionType.cancel:
      return requestCancelledError;
    default:
      return internetConnectionError;
  }
}

Future<void> handleUnauthorizedResponse(BuildContext context) async {
  showToast(context, 'Unauthorized', toastType: ToastificationType.error);
  
}

bool isErrorResponse(int statusCode, Map<String, dynamic>? responseData) {
  return statusCode != 200 &&
      statusCode != 201 &&
      responseData != null &&
      responseData.containsKey('message');
}

void showErrorToast(BuildContext context, String message) {
  showToast(context, message, toastType: ToastificationType.error);
}
