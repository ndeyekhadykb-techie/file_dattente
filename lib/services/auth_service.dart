import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Inscription
  Future<User?> inscrire(String email, String motDePasse) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: motDePasse,
      );
      return result.user;
    } catch (e) {
      print("Erreur inscription : $e");
      return null;
    }
  }

  // Connexion
  Future<User?> connecter(String email, String motDePasse) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: motDePasse,
      );
      return result.user;
    } catch (e) {
      print("Erreur connexion : $e");
      return null;
    }
  }

  // Déconnexion
  Future<void> deconnecter() async {
    await _auth.signOut();
  }

  // Vérifier si connecté
  User? get utilisateurActuel => _auth.currentUser;
}