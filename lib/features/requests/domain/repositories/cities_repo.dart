abstract class CitiesRepo {
  /// Get a List of city names starting by [startsWith]
  Future<List<String>> getSome(String startsWith);
}
