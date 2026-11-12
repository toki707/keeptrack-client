import 'dart:convert';
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeptrack/src/features/voiture/domain/voiture.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class NodejsVoituresRepository {
  static const url = 'http://192.168.8.39:3000';
  final voitures = <Voiture>[];

  Future<List<Voiture>> fetchVoituresList() async {
    try {
      final parsedUrl = Uri.parse('$url/api/voitures');
      final response = await http.get(parsedUrl);
      final statusCode = response.statusCode;
      if (statusCode != 200) {
        final message = 'Erreur survenue';
        throw Exception(message);
      }
      final data = jsonDecode(response.body) as List;
      voitures.clear();
      for (final voitureJson in data) {
        voitures.add(Voiture.fromJson(voitureJson as Map<String, dynamic>));
      }
      return voitures;
    } catch (erreur) {
      rethrow;
    }
  }

  Voiture fetchVoitureById(String voitureId) {
    return voitures.firstWhere((voiture) => voiture.id == voitureId);
  }

  Voiture fetchVoiturePref() {
    return voitures.firstWhere((voiture) => voiture.isFav == true);
  }
}

final nodejsVoituresRepositoryProvider = Provider<NodejsVoituresRepository>((
  ref,
) {
  return NodejsVoituresRepository();
});

final voituresListFutureProvider = FutureProvider<List<Voiture>>((ref) {
  final voituresRepository = ref.watch(nodejsVoituresRepositoryProvider);

  return voituresRepository.fetchVoituresList();
});
