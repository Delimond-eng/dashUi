import 'dart:io';
import 'package:dashui/models/personal.dart';
import 'package:dashui/services/sync.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common/sqlite_api.dart';

class DbHelper {
  static const String DB_NAME = 'zdata.dll';
  static Future<void> initDbLibrary() async {
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
    }
  }

  static Future<Database> init() async {
    var databaseFactory = databaseFactoryFfi;
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String path = join(appDocPath, DB_NAME);
    var db = await databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(onCreate: _onCreate, version: 1),
    );
    return db;
  }

  static _onCreate(Database db, int version) async {
    try {
      await db.execute('''
  CREATE TABLE Personals (
    id INTEGER PRIMARY KEY,
    nom TEXT,
    age INTEGER
  )
  ''');
      await db.execute(
          "CREATE TABLE IF NOT EXISTS users(user_id INTEGER NOT NULL PRIMARY KEY, user_name TEXT, user_role TEXT, user_pass TEXT, user_access TEXT)");
      await db.execute(
          "CREATE TABLE IF NOT EXISTS currency(currency_id INTEGER NOT NULL PRIMARY KEY, currency_value TEXT)");
      await db.execute(
          "CREATE TABLE IF NOT EXISTS clients(client_id INTEGER NOT NULL PRIMARY KEY, client_nom TEXT,client_tel TEXT, client_adresse TEXT, client_create_At INTEGER, client_state TEXT, user_id INTEGER)");
      await db.execute(
          "CREATE TABLE IF NOT EXISTS factures(facture_id INTEGER NOT NULL PRIMARY KEY, facture_montant REAL, facture_devise TEXT, facture_client_id INTEGER NOT NULL, facture_create_At INTEGER, facture_statut TEXT, facture_state TEXT, user_id INTEGER)");
      await db.execute(
          "CREATE TABLE IF NOT EXISTS facture_details(facture_detail_id INTEGER NOT NULL PRIMARY KEY, facture_detail_libelle TEXT, facture_detail_qte INTEGER, facture_detail_pu REAL, facture_detail_devise TEXT, facture_detail_create_At INTEGER,facture_detail_state TEXT, facture_id INTEGER)");
      await db.execute(
          "CREATE TABLE IF NOT EXISTS comptes(compte_id INTEGER NOT NULL PRIMARY KEY, compte_libelle TEXT, compte_devise TEXT,compte_status TEXT, compte_create_At INTEGER, compte_state TEXT)");
      await db.execute(
          "CREATE TABLE IF NOT EXISTS articles(article_id INTEGER NOT NULL PRIMARY KEY, article_libelle TEXT, article_create_At INTEGER, article_state TEXT)");
      await db.execute(
          "CREATE TABLE IF NOT EXISTS stocks(stock_id INTEGER NOT NULL PRIMARY KEY, stock_qte INTEGER, stock_prix_achat REAL, stock_prix_achat_devise TEXT,stock_article_id INTEGER, stock_status TEXT, stock_create_At INTEGER, stock_state TEXT)");
      await db.execute(
          "CREATE TABLE IF NOT EXISTS mouvements(mouvt_id INTEGER NOT NULL PRIMARY KEY, mouvt_qte INTEGER, mouvt_stock_id INTEGER, mouvt_create_At INTEGER, mouvt_state TEXT)");
      await db.execute(
          "CREATE TABLE IF NOT EXISTS operations(operation_id INTEGER NOT NULL PRIMARY KEY,operation_libelle TEXT,operation_type TEXT,operation_montant REAL, operation_devise TEXT, operation_compte_id INTEGER, operation_facture_id INTEGER, operation_mode TEXT, operation_user_id INTEGER, operation_create_At INTEGER, operation_state TEXT)");
      print("db initialized");
    } catch (err) {
      print("error from transaction");
    }
  }

  static Future<int> insertPersonal(Personals data) async {
    var db = await init();
    var lastInsertId = await db.insert('Personals', data.toMap());

    if (lastInsertId != null) {
      return lastInsertId;
    }
    return null;
  }

  static Future<List<Personals>> listPersonals() async {
    var db = await init();
    List<Personals> personals = [];
    var result = await db.query('Personals');

    if (result.isNotEmpty) {
      for (var res in result) {
        var person = Personals.fromMap(res);
        personals.add(person);
      }
      print("with data :${personals.length}");
      return personals;
    } else {
      print("empty data :${personals.length}");
      return [];
    }
  }

  static Future<void> delete(int _id) async {
    try {
      var db = await init();
      var id = await db.rawDelete('DELETE FROM Personals WHERE id = ?', [_id]);
      print(id);
    } catch (err) {
      print(err);
    }
  }

  static Future<void> syncData() async {
    var db = await init();
    var syncDatas = await Synchroniser.outPutData();
    try {
      if (syncDatas.users.isNotEmpty) {
        for (var user in syncDatas.users) {
          var check = await db
              .rawQuery("SELECT * FROM users WHERE user_id = '${user.userId}'");
          if (check.isNotEmpty) {
            var id = await db.update(
              "users",
              user.toMap(),
              where: "user_id",
              whereArgs: [user.userId],
            );
            print(id);
          } else {
            var id = await db.insert(
              "users",
              user.toMap(),
            );
            print(id);
          }
        }
      }
      if (syncDatas.clients.isNotEmpty) {
        for (var client in syncDatas.clients) {
          var check = await db.rawQuery(
              "SELECT * FROM clients WHERE client_id='${client.clientId}' AND NOT client_state='deleted'");
          if (check.isEmpty) {
            await db.insert(
              "clients",
              client.toMap(),
            );
          }
        }
      }
      if (syncDatas.factures.isNotEmpty) {
        for (var facture in syncDatas.factures) {
          var check = await db.rawQuery(
              "SELECT * FROM factures WHERE facture_id = '${facture.factureId}' AND NOT facture_state='deleted'");
          if (check.isEmpty) {
            await db.insert(
              "factures",
              facture.toMap(),
            );
          }
        }
      }

      if (syncDatas.factureDetails.isNotEmpty) {
        for (var detail in syncDatas.factureDetails) {
          var check = await db.rawQuery(
              "SELECT * FROM facture_details WHERE facture_detail_id = '${detail.factureDetailId}' AND NOT facture_detail_state='deleted'");
          if (check.isEmpty) {
            await db.insert(
              "facture_details",
              detail.toMap(),
            );
          }
        }
      }
      if (syncDatas.operations.isNotEmpty) {
        for (var operation in syncDatas.operations) {
          var check = await db.rawQuery(
              "SELECT * FROM operations WHERE operation_id = '${operation.operationId}' AND NOT operation_state='deleted'");
          if (check.isEmpty) {
            await db.insert(
              "operations",
              operation.toMap(),
            );
          }
        }
      }
      if (syncDatas.comptes.isNotEmpty) {
        for (var compte in syncDatas.comptes) {
          var check = await db.rawQuery(
              "SELECT * FROM comptes WHERE compte_id = '${compte.compteId}' AND NOT compte_state='deleted'");
          if (check.isNotEmpty) {
            await db.update(
              "comptes",
              compte.toMap(),
              where: "compte_id",
              whereArgs: [int.parse(compte.compteId)],
            );
          } else if (check.isEmpty) {
            await db.insert(
              "comptes",
              compte.toMap(),
            );
          }
        }
      }
      if (syncDatas.stocks.isNotEmpty) {
        for (var stock in syncDatas.stocks) {
          var check = await db.rawQuery(
              "SELECT * FROM stocks WHERE stock_id = '${stock.stockId}' AND NOT stock_state='deleted'");
          if (check.isNotEmpty && stock.stockState != "deleted") {
            await db.update(
              "stocks",
              stock.toMap(),
              where: "stock_id",
              whereArgs: [int.parse(stock.stockId.toString())],
            );
          } else if (check.isEmpty) {
            await db.insert(
              "stocks",
              stock.toMap(),
            );
          }
        }
      }
      if (syncDatas.mouvements.isNotEmpty) {
        for (var mouvt in syncDatas.mouvements) {
          var check = await db.rawQuery(
              "SELECT * FROM mouvements WHERE mouvt_id = '${mouvt.mouvtId}' AND NOT mouvt_state='deleted'");
          if (check.isNotEmpty && mouvt.mouvtState != 'deleted') {
            await db.update(
              "mouvements",
              mouvt.toMap(),
              where: "mouvt_id",
              whereArgs: [mouvt.mouvtId],
            );
          } else if (check.isEmpty) {
            await db.insert(
              "mouvements",
              mouvt.toMap(),
            );
          }
        }
      }
      if (syncDatas.articles.isNotEmpty) {
        for (var article in syncDatas.articles) {
          var check = await db.rawQuery(
              "SELECT * FROM articles WHERE article_id = '${article.articleId}' AND NOT article_state='deleted'");
          if (check.isEmpty) {
            await db.insert(
              "articles",
              article.toMap(),
            );
          }
        }
      }
    } catch (err) {
      print(err);
    }
  }
}
