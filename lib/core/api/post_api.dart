import 'package:dio/dio.dart';
import 'package:overtime_connect_app/core/models/post_model.dart';
import 'package:retrofit/retrofit.dart';

part 'post_api.g.dart';

@RestApi()
abstract class PostApi {
  factory PostApi(Dio dio, {String baseUrl}) = _PostApi;

  @GET('/posts')
  Future<HttpResponse<List<Post>>> getPosts();
}
