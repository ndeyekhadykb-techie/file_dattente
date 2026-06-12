import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/ticket_model.dart';
import '../models/user_model.dart';
import '../models/service_model.dart';

class DatabaseService {
  static Database? _database;

  // Ouvrir/créer la base de données
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'file_attente.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );
  }

  // Créer les tables
  Future<void> _createTables(Database db, int version) async {
    // Table users
    await db.execute('''
      CREATE TABLE users(
        id TEXT PRIMARY KEY,
        nom TEXT,
        email TEXT,
        isAdmin INTEGER
      )
    ''');

    // Table services
    await db.execute('''
      CREATE TABLE services(
        id TEXT PRIMARY KEY,
        nom TEXT,
        icone TEXT,
        nombreEnAttente INTEGER,
        isOuvert INTEGER
      )
    ''');

    // Table tickets
    await db.execute('''
      CREATE TABLE tickets(
        id TEXT PRIMARY KEY,
        numero TEXT,
        service TEXT,
        statut TEXT,
        tempsAttente INTEGER,
        position INTEGER,
        dateCreation TEXT,
        userId TEXT
      )
    ''');
  }

  // ============ CRUD TICKETS ============

  // CREATE - Ajouter un ticket
  Future<void> ajouterTicket(Ticket ticket) async {
    final db = await database;
    await db.insert('tickets', ticket.toMap());
  }

  // READ - Lire tous les tickets d'un utilisateur
  Future<List<Ticket>> getTicketsUser(String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'tickets',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return maps.map((map) => Ticket.fromMap(map)).toList();
  }

  // UPDATE - Modifier le statut d'un ticket
  Future<void> modifierStatutTicket(String id, String statut) async {
    final db = await database;
    await db.update(
      'tickets',
      {'statut': statut},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // DELETE - Supprimer un ticket
  Future<void> supprimerTicket(String id) async {
    final db = await database;
    await db.delete(
      'tickets',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}