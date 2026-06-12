class UserModel {
  final String id;
  final String nom;
  final String email;
  final bool isAdmin;

  UserModel({
    required this.id,
    required this.nom,
    required this.email,
    required this.isAdmin,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'email': email,
      'isAdmin': isAdmin ? 1 : 0,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      nom: map['nom'],
      email: map['email'],
      isAdmin: map['isAdmin'] == 1,
    );
  }
}