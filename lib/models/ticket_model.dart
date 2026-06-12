class Ticket {
  final String id;
  final String numero;
  final String service;
  String statut;
  final int tempsAttente;
  final int position;
  final DateTime dateCreation;
  final String userId;

  Ticket({
    required this.id,
    required this.numero,
    required this.service,
    required this.statut,
    required this.tempsAttente,
    required this.position,
    required this.dateCreation,
    required this.userId,
  });

  // Convertir un Ticket en Map pour SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'numero': numero,
      'service': service,
      'statut': statut,
      'tempsAttente': tempsAttente,
      'position': position,
      'dateCreation': dateCreation.toIso8601String(),
      'userId': userId,
    };
  }

  // Convertir un Map SQLite en Ticket
  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      id: map['id'],
      numero: map['numero'],
      service: map['service'],
      statut: map['statut'],
      tempsAttente: map['tempsAttente'],
      position: map['position'],
      dateCreation: DateTime.parse(map['dateCreation']),
      userId: map['userId'],
    );
  }
}