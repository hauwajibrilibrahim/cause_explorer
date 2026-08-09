import '../../domain/models/cause.dart';
import '../../domain/repositories/cause_repository.dart';
import '../datasources/cause_remote_data_source.dart';

class CauseRepositoryImpl implements CauseRepository {
  final CauseRemoteDataSource _remoteDataSource;
  List<Cause>? _cachedCauses;

  CauseRepositoryImpl({required CauseRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<List<Cause>> getCauses() async {
    final dtos = await _remoteDataSource.fetchPosts();
    final causes = dtos.map((dto) => dto.toDomain()).toList();
    _cachedCauses = causes;
    return causes;
  }

  @override
  Future<Cause> getCauseById(int id) async {
    if (_cachedCauses != null) {
      final found = _cachedCauses!.firstWhere(
        (c) => c.id == id,
        orElse: () => throw Exception('Cause with id $id not found'),
      );
      return found;
    }

    final causes = await getCauses();
    return causes.firstWhere(
      (c) => c.id == id,
      orElse: () => throw Exception('Cause with id $id not found'),
    );
  }
}
