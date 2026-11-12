import 'dart:convert';
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeptrack/src/features/user/domain/user.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class NodejsUsersRepository {
  static const url = 'http://192.168.8.39:3000';
  final users = <User>[];

  Future<List<User>> fetchUsersList() async {
    try {
      final parsedUrl = Uri.parse('$url/api/users');
      final response = await http.get(parsedUrl);
      final statusCode = response.statusCode;
      if (statusCode != 200) {
        final message = 'Erreur survenue';
        throw Exception(message);
      }
      final data = jsonDecode(response.body) as List;
      users.clear();
      for (final userJson in data) {
        users.add(User.fromJson(userJson as Map<String, dynamic>));
      }
      return users;
    } catch (erreur) {
      rethrow;
    }
  }

  User fetchUserById(String userId) {
    return users.firstWhere((user) => user.id == userId);
  }
}

final nodejsUsersRepositoryProvider = Provider<NodejsUsersRepository>((ref) {
  return NodejsUsersRepository();
});

final usersListFutureProvider = FutureProvider<List<User>>((ref) {
  final usersRepository = ref.watch(nodejsUsersRepositoryProvider);

  return usersRepository.fetchUsersList();
});
