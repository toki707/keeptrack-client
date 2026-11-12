import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keeptrack/src/features/user/domain/objectif.dart';
import 'package:keeptrack/src/features/voiture/domain/voiture.dart';

@immutable
class VoiturePerformance {
  const VoiturePerformance({required this.voiture, required this.temps});

  final Voiture voiture;
  final List<String> temps;

  VoiturePerformance copyWith({Voiture? voiture, List<String>? temps}) {
    return VoiturePerformance(
      voiture: voiture ?? this.voiture,
      temps: temps ?? this.temps,
    );
  }

  factory VoiturePerformance.fromJson(Map<String, dynamic> json) {
    final voiture = json['voiture'];
    if (voiture == null || voiture is! Map<String, dynamic>) {
      throw FormatException(
        "Le Json est invalide : voiture doit être de type Map dans $json",
      );
    }

    final temps = json['temps'];
    if (temps == null || temps is! List) {
      throw FormatException(
        "Le Json est invalide : temps doit être de type List dans $json",
      );
    }

    return VoiturePerformance(
      voiture: Voiture.fromJson(voiture),
      temps: temps.cast<String>().toList(),
    );
  }

  int tempsEnMs(String temps) {
    final minutesEtRestes = temps.split(":");
    final secondesEtMs = minutesEtRestes[1].split(".");

    final minutes = int.parse(minutesEtRestes[0]);
    final secondes = int.parse(secondesEtMs[0]);
    final millisecondes = int.parse(secondesEtMs[1]);

    return (minutes * 60000) + (secondes * 1000) + millisecondes;
  }

  String get meilleurTemps {
    String meilleurTour = temps.first;

    for (final tour in temps) {
      if (tempsEnMs(tour) < tempsEnMs(meilleurTour)) {
        meilleurTour = tour;
      }
    }
    return meilleurTour;
  }

  double progressionObjectif(Objectif objectif, String meilleurTempsActuel) {
    final depart = tempsEnMs(objectif.tempsDepart);
    final cible = tempsEnMs(objectif.tempsCible);
    final actuel = tempsEnMs(meilleurTempsActuel);

    if (depart <= cible) {
      return 1.0;
    }

    return ((depart - actuel) / (depart - cible)).clamp(0.0, 1.0);
  }

  int get moyenneEnMs {
    int total = 0;
    for (final tour in temps) {
      total += tempsEnMs(tour);
    }
    return (total / temps.length).round();
  }

  int get indexMeilleurTemps {
    return temps.indexOf(meilleurTemps);
  }

  String formaterTemps(int ms) {
    final minutes = (ms / 60000).floor();
    final secondes = ((ms % 60000) / 1000).round();
    final millisecondes = ms % 1000;

    return "$minutes:${secondes.toString().padLeft(2, '0')}.${millisecondes.toString().padLeft(3, '0')}";
  }

  
}
