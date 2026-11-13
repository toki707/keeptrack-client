import 'package:keeptrack/src/features/user/domain/performance.dart';

import '../../voiture/domain/voiture.dart';
import 'objectif.dart';

class User {
  final String? id;
  final String? name;
  final String? at;
  final String? banner;
  final String? pfp;
  final List<Performance> performances;
  final List<Objectif> objectifs;

  User({
    required this.id,
    required this.name,
    required this.at,
    required this.performances,
    this.banner,
    this.pfp,
    this.objectifs = const [],
  });

  User copyWith({
    String? id,
    String? name,
    String? banner,
    String? pfp,
    List<Performance>? performances,
    List<Objectif>? objectifs,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      banner: banner ?? this.banner,
      at: at ?? at,
      pfp: pfp ?? this.pfp,
      performances: performances ?? this.performances,
      objectifs: objectifs ?? this.objectifs,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    final id = json['_id'];
    if (id != null && id is! String?) {
      throw FormatException(
        "Le Json est invalide : id doit être de type String dans $json",
      );
    }

    final name = json['name'];
    if (name == null || name is! String) {
      throw FormatException(
        "Le Json est invalide : name doit être de type String dans $json",
      );
    }

    final banner = json['banner'];
    if (banner == null || banner is! String) {
      throw FormatException(
        "Le Json est invalide : banner doit être de type String dans $json",
      );
    }

    final at = json['at'];
    if (at == null || at is! String) {
      throw FormatException(
        "Le Json est invalide : at doit être de type String dans $json",
      );
    }

    final pfp = json['pfp'];
    if (pfp == null || pfp is! String) {
      throw FormatException(
        "Le Json est invalide : pfp doit être de type String dans $json",
      );
    }

    final performances = json['performances'];
    if (performances == null || performances is! List) {
      throw FormatException(
        "Le Json est invalide : performances doit être de type List dans $json",
      );
    }

    final objectifs = json['objectifs'] as List?;

    return User(
      id: id as String?,
      name: name as String?,
      banner: banner as String?,
      at: at as String?,
      pfp: pfp as String?,
      performances: performances
          .cast<Map<String, dynamic>>()
          .map((performanceData) => Performance.fromJson(performanceData))
          .toList(),
      objectifs: objectifs != null
          ? objectifs
                .cast<Map<String, dynamic>>()
                .map((objectifData) => Objectif.fromJson(objectifData))
                .toList()
          : <Objectif>[],
    );
  }

  double get nbreHeursJouees {
    int totalMs = 0;

    for (final performance in performances) {
      for (final voiturePerf in performance.voitures) {
        for (final tour in voiturePerf.temps) {
          totalMs += voiturePerf.tempsEnMs(tour);
        }
      }
    }

    return totalMs / 3600000;
  }

  int nbreToursVoiture(Voiture voiturePref) {
    int totalTours = 0;

    for (final performance in performances) {
      for (final voiturePerf in performance.voitures) {
        if (voiturePerf.voiture.name == voiturePref.name) {
          totalTours += voiturePerf.temps.length;
        }
      }
    }

    return totalTours;
  }
}
