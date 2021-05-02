import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MockStorage implements FlutterSecureStorage {
  final _map = new Map<String, String>();
  @override
  Future<bool> containsKey(
      {String key,
      IOSOptions iOptions = IOSOptions.defaultOptions,
      AndroidOptions aOptions,
      LinuxOptions lOptions}) {
    return Future(() => _map.containsKey(key));
  }

  @override
  Future<void> deleteAll(
      {IOSOptions iOptions = IOSOptions.defaultOptions,
      AndroidOptions aOptions,
      LinuxOptions lOptions}) {
    return Future(() => _map.clear());
  }

  @override
  Future<Map<String, String>> readAll(
      {IOSOptions iOptions = IOSOptions.defaultOptions,
      AndroidOptions aOptions,
      LinuxOptions lOptions}) {
    return Future(() => _map);
  }

  @override
  Future<void> delete(
      {String key,
      IOSOptions iOptions = IOSOptions.defaultOptions,
      AndroidOptions aOptions,
      LinuxOptions lOptions}) {
    return Future(() => _map.remove(key));
  }

  @override
  Future<String> read(
      {String key,
      IOSOptions iOptions = IOSOptions.defaultOptions,
      AndroidOptions aOptions,
      LinuxOptions lOptions}) {
    return Future(() => _map[key]);
  }

  @override
  Future<void> write(
      {String key,
      String value,
      IOSOptions iOptions = IOSOptions.defaultOptions,
      AndroidOptions aOptions,
      LinuxOptions lOptions}) {
    return Future(() {
      _map[key] = value;
    });
  }
}
