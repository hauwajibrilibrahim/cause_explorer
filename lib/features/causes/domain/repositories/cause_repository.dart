import '../models/cause.dart';

abstract class CauseRepository {
  /// Fetches causes from remote data source and maps to domain model.
  Future<List<Cause>> getCauses();

  /// Fetches a single cause by ID (can be fetched from list or remote).
  Future<Cause> getCauseById(int id);
}
