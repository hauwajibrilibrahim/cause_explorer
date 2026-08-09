import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../models/cause_dto.dart';

abstract class CauseRemoteDataSource {
  Future<List<CauseDto>> fetchPosts();
}

class CauseRemoteDataSourceImpl implements CauseRemoteDataSource {
  final DioClient _dioClient;

  CauseRemoteDataSourceImpl({required DioClient dioClient}) : _dioClient = dioClient;

  @override
  Future<List<CauseDto>> fetchPosts() async {
    final response = await _dioClient.get(ApiConstants.postsEndpoint);
    if (response is List) {
      return response
          .map((json) => CauseDto.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw FormatException('Unexpected response format: expected a List, got ${response.runtimeType}');
    }
  }
}
