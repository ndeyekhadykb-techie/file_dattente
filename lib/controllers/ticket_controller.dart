import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../models/ticket_model.dart';
import 'package:uuid/uuid.dart';

class TicketController extends ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();
  
  List<Ticket> _tickets = [];
  bool _isLoading = false;
  String? _erreur;

  // Getters
  List<Ticket> get tickets => _tickets;
  bool get isLoading => _isLoading;
  String? get erreur => _erreur;

  // Prendre un ticket
  Future<bool> prendreTicket(String service, String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Générer un numéro unique ex: "P-023"
      String prefixe = service[0].toUpperCase();
      int nombre = _tickets.length + 1;
      String numero = "$prefixe-${nombre.toString().padLeft(3, '0')}";

      Ticket ticket = Ticket(
        id: const Uuid().v4(),
        numero: numero,
        service: service,
        statut: 'en_attente',
        tempsAttente: (nombre * 3), // 3 min par personne
        position: nombre,
        dateCreation: DateTime.now(),
        userId: userId,
      );

      await _dbService.ajouterTicket(ticket);
      _tickets.add(ticket);
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _erreur = "Erreur lors de la création du ticket";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Charger les tickets d'un utilisateur
  Future<void> chargerTickets(String userId) async {
    _isLoading = true;
    notifyListeners();

    _tickets = await _dbService.getTicketsUser(userId);
    
    _isLoading = false;
    notifyListeners();
  }

  // Modifier le statut d'un ticket
  Future<void> modifierStatut(String id, String statut) async {
    await _dbService.modifierStatutTicket(id, statut);
    int index = _tickets.indexWhere((t) => t.id == id);
    if (index != -1) {
      _tickets[index].statut = statut;
      notifyListeners();
    }
  }
}