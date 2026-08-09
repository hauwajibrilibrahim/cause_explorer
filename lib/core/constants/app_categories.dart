class AppCategories {
  AppCategories._();

  static const List<String> categories = [
    'Health',
    'Education',
    'Emergency',
    'Environment',
    'Empowerment',
  ];

  /// Category Formula: categories[(userId - 1) % categories.length]
  static String deriveCategoryFromUserId(int userId) {
    if (userId <= 0) return categories[0];
    final index = (userId - 1) % categories.length;
    return categories[index];
  }
}
