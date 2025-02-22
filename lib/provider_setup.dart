import 'package:dio/dio.dart';
import 'package:overtime_connect_app/core/api/auth_api.dart';
import 'package:overtime_connect_app/core/api/overtime_api.dart';
import 'package:overtime_connect_app/core/api/post_api.dart';
import 'package:overtime_connect_app/core/constants/app_constants.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = <SingleChildWidget>[
  ...apiServices,
];

List<SingleChildWidget> apiServices = <SingleChildWidget>[
  Provider<PostApi>.value(
    value: PostApi(
      Dio(
        BaseOptions(
          contentType: 'application/json',
          baseUrl: AppConstants.baseUrl,
        ),
      ),
    ),
  ),
  Provider<AuthApi>.value(
    value: AuthApi(
      Dio(
        BaseOptions(
          contentType: 'application/json',
          baseUrl: AppConstants.baseUrl,
        ),
      ),
    ),
  ),
  Provider<OvertimeApi>.value(
    value: OvertimeApi(
      Dio(
        BaseOptions(
          contentType: 'application/json',
          baseUrl: AppConstants.baseUrl,
        ),
      ),
    ),
  ),
];
