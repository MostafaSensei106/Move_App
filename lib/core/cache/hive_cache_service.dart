abstract class HiveCacheService<T> {
  /// Cache a single item with a key
  Future<void> cacheItem(String key, T item);

  /// Retrieve a cached item by key
  T? getCachedItem(String key);

  /// Clear a specific cached item by key
  Future<void> clearCachedItem(String key);

  /// Clear all cached items
  Future<void> clearAll();

  /// Check if an item exists in cache
  bool hasItem(String key);
}
