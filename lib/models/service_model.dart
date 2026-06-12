class ServiceModel {
  final String id;
  final String nom;
  final String icone;
  int nombreEnAttente;
  bool isOuvert;

  ServiceModel({
    required this.id,
    required this.nom,
    required this.icone,
    required this.nombreEnAttente,
    required this.isOuvert,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'icone': icone,
      'nombreEnAttente': nombreEnAttente,
      'isOuvert': isOuvert ? 1 : 0,
    };
  }

  factory ServiceModel.fromMap(Map<String, dynamic> map) {
    return ServiceModel(
      id: map['id'],
      nom: map['nom'],
      icone: map['icone'],
      nombreEnAttente: map['nombreEnAttente'],
      isOuvert: map['isOuvert'] == 1,
    );
  }
}