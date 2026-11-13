class Circuit {
  final String? id;
  final String? name;
  final String? description;
  final List<String>? tags;
  final List<String>? geotags;
  final String? country;
  final String? city;
  final String? lengthKm;
  final String? pitboxes;
  final String? run;
  final int? yearCreation;
  final String? highestPoint;
  final String? lowestPoint;
  final String? preview;
  final String? outline;
  final String? location;
  final bool? isFav;

  Circuit({
    this.id,
    this.name,
    this.description,
    this.tags,
    this.geotags,
    this.country,
    this.city,
    this.lengthKm,
    this.pitboxes,
    this.run,
    this.yearCreation,
    this.highestPoint,
    this.lowestPoint,
    this.preview,
    this.outline,
    this.location,
    this.isFav,
  });

  factory Circuit.fromJson(Map<String, dynamic> json) {
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

    final description = json['description'];
    if (description != null && description is! String?) {
      throw FormatException(
        "Le Json est invalide : description doit être de type String dans $json",
      );
    }

    final tags = json['tags'] as List?;

    final geotags = json['geotags'] as List?;

    final country = json['country'];
    if (country != null && country is! String?) {
      throw FormatException(
        "Le Json est invalide : country doit être de type String dans $json",
      );
    }

    final city = json['city'];
    if (city != null && city is! String?) {
      throw FormatException(
        "Le Json est invalide : city doit être de type String dans $json",
      );
    }

    final lengthKm = json['lengthKm'];
    if (lengthKm != null && lengthKm is! String?) {
      throw FormatException(
        "Le Json est invalide : lengthKm doit être de type String dans $json",
      );
    }

    final pitboxes = json['pitboxes'];
    if (pitboxes != null && pitboxes is! String?) {
      throw FormatException(
        "Le Json est invalide : pitboxes doit être de type String dans $json",
      );
    }

    final run = json['run'];
    if (run != null && run is! String?) {
      throw FormatException(
        "Le Json est invalide : run doit être de type String dans $json",
      );
    }

    final yearCreation = json['yearCreation'];
    if (yearCreation != null && yearCreation is! int?) {
      throw FormatException(
        "Le Json est invalide : yearCreation doit être de type int dans $json",
      );
    }

    final highestPoint = json['highestPoint'];
    if (highestPoint != null && highestPoint is! String?) {
      throw FormatException(
        "Le Json est invalide : highestPoint doit être de type String dans $json",
      );
    }

    final lowestPoint = json['lowestPoint'];
    if (lowestPoint != null && lowestPoint is! String?) {
      throw FormatException(
        "Le Json est invalide : lowestPoint doit être de type String dans $json",
      );
    }

    final preview = json['preview'];
    if (preview != null && preview is! String?) {
      throw FormatException(
        "Le Json est invalide : preview doit être de type String dans $json",
      );
    }

    final outline = json['outline'];
    if (outline != null && outline is! String?) {
      throw FormatException(
        "Le Json est invalide : outline doit être de type String dans $json",
      );
    }

    final location = json['location'];
    if (location != null && location is! String?) {
      throw FormatException(
        "Le Json est invalide : location doit être de type String dans $json",
      );
    }

    final isFav = json['isFav'];
    if (isFav != null && isFav is! bool?) {
      throw FormatException(
        "Le Json est invalide : isFav doit être de type bool dans $json",
      );
    }

    return Circuit(
      id: id as String?,
      name: name as String?,
      description: description as String?,
      tags: tags?.cast<String>().toList(),
      geotags: geotags?.cast<String>().toList(),
      country: country as String?,
      city: city as String?,
      lengthKm: lengthKm as String?,
      pitboxes: pitboxes as String?,
      run: run as String?,
      yearCreation: yearCreation as int?,
      highestPoint: highestPoint as String?,
      lowestPoint: lowestPoint as String?,
      preview: preview as String?,
      outline: outline as String?,
      location: location as String?,
      isFav: isFav as bool?,
    );
  }
}
