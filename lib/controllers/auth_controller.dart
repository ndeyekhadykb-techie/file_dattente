import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends ChangeNotifier {
  final AuthService _authService = AuthService();
  
  User? _utilisateur;
  bool _isLoading = false;
  String? _erreur;

  // Getters
  User? get utilisateur => _utilisateur;
  bool get isLoading => _isLoading;
  String? get erreur => _erreur;
  bool get estConnecte => _utilisateur != null;

  // Inscription
  Future<bool> inscrire(String email, String motDePasse) async {
    _isLoading = true;
    _erreur = null;
    notifyListeners();

    _utilisateur = await _authService.inscrire(email, motDePasse);
    
    if (_utilisateur == null) {
      _erreur = "Erreur lors de l'inscription";
    }

    _isLoading = false;
    notifyListeners();
    return _utilisateur != null;
  }

  // Connexion
  Future<bool> connecter(String email, String motDePasse) async {
    _isLoading = true;
    _erreur = null;
    notifyListeners();

    _utilisateur = await _authService.connecter(email, motDePasse);
    
    if (_utilisateur == null) {
      _erreur = "Email ou mot de passe incorrect";
    }

    _isLoading = false;
    notifyListeners();
    return _utilisateur != null;
  }

  // Déconnexion
  Future<void> deconnecter() async {
    await _authService.deconnecter();
    _utilisateur = null;
    notifyListeners();
  }
}