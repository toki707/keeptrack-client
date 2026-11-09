import 'package:keeptrack/src/features/circuit/domain/circuit.dart';
import 'package:keeptrack/src/features/user/domain/objectif.dart';
import 'package:keeptrack/src/features/user/domain/performance.dart';
import 'package:keeptrack/src/features/user/domain/user.dart';
import 'package:keeptrack/src/features/user/domain/voiture_performance.dart';
import 'package:keeptrack/src/features/voiture/domain/voiture.dart';

List<User> testUsers = [
  User(
    id: "1",
    name: "Toki707",
    at: "jordan",
    performances: [
      Performance(
        circuit: Circuit(
          id: "1",
          name: "Monza",
          location: "it",
          country: "Italie",
          city: "Monza (DI)",
          preview: "assets/images/tracks/previews/monza.png",
          outline: "assets/images/tracks/outlines/monza.png",
        ),
        voitures: [
          VoiturePerformance(
            voiture: Voiture(
              id: "1",
              name: "Mclaren P1",
              preview: "assets/images/cars/previews/ks_mclaren_p1.jpg",
              brand: "Mclaren",
            ),
            temps: ["1:31.245", "1:32.055", "1:31.789", "1:31.583"],
          ),
        ],
      ),
      Performance(
        circuit: Circuit(
          id: "2",
          name: "Spa",
          location: "be",
          country: "Belgique",
          city: "Francorchamps",
          preview: "assets/images/tracks/previews/spa.png",
          outline: "assets/images/tracks/outlines/spa.png",
        ),
        voitures: [
          VoiturePerformance(
            voiture: Voiture(
              id: "2",
              name: "Ferrari F2004",
              preview: "assets/images/cars/previews/ks_ferrari_f2004.jpg",
              brand: "Ferrari",
            ),
            temps: ["1:42.987", "1:41.234", "1:43.501", "1:41.890"],
          ),
        ],
      ),
    ],
    objectifs: [
      Objectif(
        circuit: Circuit(id: "2", name: "Spa"),
        voiture: Voiture(
          id: "2",
          name: "Ferrari F2004",
          preview: "assets/images/cars/previews/ks_ferrari_f2004.jpg",
        ),
        tempsCible: "1:41.000",
        tempsDepart: "1:42.987",
      ),
      Objectif(
        circuit: Circuit(id: "7", name: "Silverstone GP"),
        voiture: Voiture(
          id: "2",
          name: "Ferrari F2004",
          preview: "assets/images/cars/previews/ks_ferrari_f2004.jpg",
        ),
        tempsCible: "1:41.000",
        tempsDepart: "1:42.987",
      ),
    ],
  ),
];
