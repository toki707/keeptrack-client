import 'package:keeptrack/src/features/voiture/domain/specs.dart';

class Voiture {
  final String? id;
  final String? name;
  final String? brand;
  final String? description;
  final List<String>? tags;
  final String? classCar;
  final Specs? specs;
  final String? preview;
  final String? overview;
  final bool? isFav;

  Voiture({
    this.id,
    this.name,
    this.brand,
    this.description,
    this.tags,
    this.classCar,
    this.specs,
    required this.preview,
    this.overview,
    this.isFav,
  });

  factory Voiture.fromJson(Map<String, dynamic> json) {
    final id = json['_id'];
    if (id != null && id is! String?) {
      throw FormatException(
        "Le Json est invalide : id doit être de type String dans $json",
      );
    }

    final name = json['name'];
    if (name != null && name is! String?) {
      throw FormatException(
        "Le Json est invalide : name doit être de type String dans $json",
      );
    }

    final brand = json['brand'];
    if (brand != null && brand is! String?) {
      throw FormatException(
        "Le Json est invalide : brand doit être de type String dans $json",
      );
    }

    final description = json['description'];
    if (description != null && description is! String?) {
      throw FormatException(
        "Le Json est invalide : description doit être de type String dans $json",
      );
    }

    final tags = json['tags'] as List?;

    final classCar = json['classCar'];
    if (classCar != null && classCar is! String?) {
      throw FormatException(
        "Le Json est invalide : classCar doit être de type String dans $json",
      );
    }

    final specs = json['specs'] as Map<String, dynamic>?;

    final preview = json['preview'];
    if (preview != null && preview is! String?) {
      throw FormatException(
        "Le Json est invalide : preview doit être de type String dans $json",
      );
    }

    final overview = json['overview'];
    if (overview != null && overview is! String?) {
      throw FormatException(
        "Le Json est invalide : overview doit être de type String dans $json",
      );
    }

    final isFav = json['isFav'];
    if (isFav != null && isFav is! bool?) {
      throw FormatException(
        "Le Json est invalide : isFav doit être de type bool dans $json",
      );
    }

    return Voiture(
      id: id as String?,
      name: name as String?,
      brand: brand as String?,
      description: description as String?,
      tags: tags?.cast<String>().toList(),
      classCar: classCar as String?,
      specs: specs != null ? Specs.fromJson(specs) : null,
      preview: preview as String?,
      overview: overview as String?,
      isFav: isFav as bool?,
    );
  }
}
