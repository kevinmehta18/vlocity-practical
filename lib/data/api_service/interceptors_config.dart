import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:practical/data/api_service/api_error_handler.dart';
import 'package:provider/provider.dart';

void configureInterceptors(Dio dio, BuildContext context) {
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) => handleRequest(options, handler),
    onResponse: (response, handler) =>
        handleResposne(response, handler, context),
    onError: (e, handler) => handleErrorResponse(e, handler, context),
  ));
  dio.options.validateStatus = (status) => status! < 500;
}

void handleRequest(RequestOptions options, RequestInterceptorHandler handler) {
  handler.next(options);
}

handleResposne(Response response, handler, BuildContext context) {
  try {
    final responseData = response.data as Map<String, dynamic>?;
    if (isErrorResponse(response.statusCode!, responseData)) {
      final errorMessage = responseData!['message'] as String;
      if (response.statusCode == 401) {
        handleUnauthorizedResponse(context);
      } else {
        showErrorToast(context, errorMessage);
      }
    }
  } catch (e, s) {
   if (kDebugMode) {
    
    print('Error----------------->>>\n $e\n StackTrace----------------->>>\n$s');
  }
  }
  handler.next(response);
}

handleErrorResponse(
  DioException e,
  ErrorInterceptorHandler handler,
  BuildContext context,
) {
  if (kDebugMode) {
    print('Error Method Invoked ------------------------------------------------------------->');
  }
  stopLoader(context);
  String errorMessage = getErrorMessage(e);
  showErrorToast(context, errorMessage);

  handler.next(e);
}

void stopLoader(BuildContext context) {
  // context.read<AuthProvider>().stopLoader();
}
