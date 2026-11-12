import 'dart:convert';
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keeptrack/src/features/circuit/domain/circuit.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class NodejsCircuitsRepository {
  static const url = 'http://192.168.8.39:3000';
  final circuits = <Circuit>[];

  Future<List<Circuit>> fetchCircuitsList() async {
    try {
      final parsedUrl = Uri.parse('$url/api/circuits');
      final response = await http.get(parsedUrl);
      final statusCode = response.statusCode;
      if (statusCode != 200) {
        final message = 'Erreur survenue';
        throw Exception(message);
      }
      final data = jsonDecode(response.body) as List;
      circuits.clear();
      for (final circuitJson in data) {
        circuits.add(Circuit.fromJson(circuitJson as Map<String, dynamic>));
      }
      return circuits;
    } catch (erreur) {
      rethrow;
    }
  }

  Circuit fetchCircuitById(String circuitId) {
    return circuits.firstWhere((circuit) => circuit.id == circuitId);
  }

  Circuit fetchCircuitByName(String? circuitName) {
    return circuits.firstWhere((circuit) => circuit.name == circuitName);
  }

  Circuit fetchCircuitPref() {
    return circuits.firstWhere((circuit) => circuit.isFav == true);
  }
}

final nodejsCircuitsRepositoryProvider = Provider<NodejsCircuitsRepository>((
  ref,
) {
  return NodejsCircuitsRepository();
});

final circuitsListFutureProvider = FutureProvider<List<Circuit>>((ref) {
  final circuitsRepository = ref.watch(nodejsCircuitsRepositoryProvider);

  return circuitsRepository.fetchCircuitsList();
});
