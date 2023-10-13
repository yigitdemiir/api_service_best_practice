import 'package:api_service_best_practice/model/post_model.dart';
import 'package:dio/dio.dart';

abstract class IApiService {
  Future<List<PostModel>?> fetchPosts();
  Future<bool> createPost(PostModel post);
  Future<bool> deletePost(int id);
  Future<bool> updatePost(PostModel post);
  Future<PostModel?> fetchSpesificPost(int id);
}

class ApiService implements IApiService {
  late final Dio _dio;
  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://jsonplaceholder.typicode.com',
      ),
    );
  }

  @override
  Future<List<PostModel>?> fetchPosts() async {
    try {
      final response = await _dio.get("/posts");
      if (response.statusCode == 200) {
        final data = response.data as List;
        final posts = data.map((e) => PostModel.fromJson(e)).toList();
        return posts;
      } else {
        throw Exception("Failed to fetch user data");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<bool> createPost(PostModel post) async {
    try {
      final response = await _dio.post("/posts", data: post.toJson());
      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception("Failed to create post");
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> deletePost(int id) async {
    try {
      final response = await _dio.delete("/posts/$id");
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Failed to delete post");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<PostModel?> fetchSpesificPost(int id) async {
    try {
      final response = await _dio.get("/posts/$id");
      if (response.statusCode == 200) {
        final data = response.data;
        final post = PostModel.fromJson(data);
        return post;
      } else {
        throw Exception("Failed to fetch post");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<bool> updatePost(PostModel post) async {
    try {
      final response = await _dio.put("/posts/${post.id}", data: post.toJson());
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Failed to update post");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
