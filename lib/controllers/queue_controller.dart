import 'package:flutter/material.dart';
import '../models/service_model.dart';
import '../services/database_service.dart';

class QueueController extends ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();

  List<ServiceModel> _services = [];
  bool _isLoading = false;

  // Getters
  List<ServiceModel> get services => _services;
  bool get isLoading => _isLoading;

  // Initialiser les services par défaut
  Future<void> initialiserServices() async {
    _services = [
      ServiceModel(
        id: '1',
        nom: 'Paiement',
        icone: '💳',
        nombreEnAttente: 12,
        isOuvert: true,
      ),
      ServiceModel(
        id: '2',
        nom: 'Retrait',
        icone: '💰',
        nombreEnAttente: 8,
        isOuvert: true,
      ),
      ServiceModel(
        id: '3',
        nom: 'Assistance',
        icone: '🎧',
        nombreEnAttente: 5,
        isOuvert: true,
      ),
      ServiceModel(
        id: '4',
        nom: 'Autre service',
        icone: '📋',
        nombreEnAttente: 3,
        isOuvert: true,
      ),
    ];
    notifyListeners();
  }

  // Ajouter une personne dans la file
  void ajouterDansFile(String serviceId) {
    int index = _services.indexWhere((s) => s.id == serviceId);
    if (index != -1) {
      _services[index].nombreEnAttente++;
      notifyListeners();
    }
  }

  // Retirer une personne de la file
  void retirerDeLaFile(String serviceId) {
    int index = _services.indexWhere((s) => s.id == serviceId);
    if (index != -1 && _services[index].nombreEnAttente > 0) {
      _services[index].nombreEnAttente--;
      notifyListeners();
    }
  }
}