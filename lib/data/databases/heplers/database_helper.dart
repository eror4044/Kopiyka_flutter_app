import 'package:kopiyka/models/category.dart';
import 'package:kopiyka/models/transaction.dart';
import 'package:kopiyka/models/transaction_groped_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'transactions.db');
    await deleteDatabase(path);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE categories(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        icon TEXT,
        title TEXT,
        color INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE transactions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category INTEGER,
        amount REAL,
        date TEXT,
        account TEXT,
        currency TEXT,
        description TEXT,
        FOREIGN KEY (category) REFERENCES categories(id) ON DELETE CASCADE
      )
    ''');

    // insert mock data for development
    await _insertInitialCategories(db);
    await _insertInitialTransactions(db);
  }

  Future<void> _insertInitialCategories(Database db) async {
    List<Map<String, dynamic>> initialCategories = [
      {
        'icon': 'fastfood', // Имя иконки из пакета Flutter
        'title': 'Food',
        'color': 0xFF4CAF50, // Зеленый
      },
      {
        'icon': 'directions_car',
        'title': 'Transport',
        'color': 0xFF2196F3, // Синий
      },
      {
        'icon': 'local_movies',
        'title': 'Entertainment',
        'color': 0xFFF44336, // Красный
      },
      {
        'icon': 'build',
        'title': 'Utilities',
        'color': 0xFFFFEB3B, // Желтый
      },
      {
        'icon': 'healing',
        'title': 'Health',
        'color': 0xFFE91E63, // Розовый
      },
      {
        'icon': 'school',
        'title': 'Education',
        'color': 0xFF9C27B0, // Фиолетовый
      },
      {
        'icon': 'shopping_cart',
        'title': 'Shopping',
        'color': 0xFFFF9800, // Оранжевый
      },
      {
        'icon': 'home',
        'title': 'Rent',
        'color': 0xFF3F51B5, // Индиго
      },
      {
        'icon': 'savings',
        'title': 'Savings',
        'color': 0xFF009688, // Бирюзовый
      },
    ];

    for (var category in initialCategories) {
      await db.insert('categories', category);
    }
  }

  Future<void> _insertInitialTransactions(Database db) async {
    List<Map<String, dynamic>> categories = await db.query('categories');
    Map<String, int> categoryIds = {
      for (var category in categories) category['title']: category['id'],
    };

    List<Map<String, dynamic>> initialTransactions = [
      {
        'category': categoryIds['Food'],
        'amount': 50.0,
        'account': 'Debit Card',
        'currency': 'USD',
        'description': 'Groceries',
        'date': '2023-07-25',
      },
      {
        'category': categoryIds['Transport'],
        'amount': 20.0,
        'account': 'Cash',
        'currency': 'USD',
        'description': 'Taxi ride',
        'date': '2023-07-26',
      },
      {
        'category': categoryIds['Entertainment'],
        'amount': 100.0,
        'account': 'Credit Card',
        'currency': 'USD',
        'description': 'Concert tickets',
        'date': '2023-07-27',
      },
      {
        'category': categoryIds['Utilities'],
        'amount': 150.0,
        'account': 'Bank Transfer',
        'currency': 'USD',
        'description': 'Electricity bill',
        'date': '2023-07-28',
      },
      {
        'category': categoryIds['Food'],
        'amount': 30.0,
        'account': 'Cash',
        'currency': 'USD',
        'description': 'Dinner at a restaurant',
        'date': '2023-07-29',
      },
      {
        'category': categoryIds['Health'],
        'amount': 200.0,
        'account': 'Debit Card',
        'currency': 'USD',
        'description': 'Medical check-up',
        'date': '2023-07-30',
      },
      {
        'category': categoryIds['Education'],
        'amount': 500.0,
        'account': 'Bank Transfer',
        'currency': 'USD',
        'description': 'Online course fee',
        'date': '2023-08-01',
      },
      {
        'category': categoryIds['Shopping'],
        'amount': 250.0,
        'account': 'Credit Card',
        'currency': 'USD',
        'description': 'Clothing and accessories',
        'date': '2023-08-02',
      },
      {
        'category': categoryIds['Rent'],
        'amount': 1200.0,
        'account': 'Bank Transfer',
        'currency': 'USD',
        'description': 'Monthly rent payment',
        'date': '2023-08-03',
      },
      {
        'category': categoryIds['Savings'],
        'amount': 300.0,
        'account': 'Bank Transfer',
        'currency': 'USD',
        'description': 'Monthly savings deposit',
        'date': '2023-08-04',
      },
      {
        'category': categoryIds['Entertainment'],
        'amount': 60.0,
        'account': 'Cash',
        'currency': 'USD',
        'description': 'Movie night',
        'date': '2023-08-05',
      },
      {
        'category': categoryIds['Utilities'],
        'amount': 100.0,
        'account': 'Bank Transfer',
        'currency': 'USD',
        'description': 'Water bill',
        'date': '2023-08-06',
      },
      {
        'category': categoryIds['Transport'],
        'amount': 45.0,
        'account': 'Debit Card',
        'currency': 'USD',
        'description': 'Gasoline',
        'date': '2023-08-07',
      },
      {
        'category': categoryIds['Food'],
        'amount': 70.0,
        'account': 'Credit Card',
        'currency': 'USD',
        'description': 'Weekly groceries',
        'date': '2023-08-08',
      },
      {
        'category': categoryIds['Health'],
        'amount': 35.0,
        'account': 'Cash',
        'currency': 'USD',
        'description': 'Pharmacy expenses',
        'date': '2023-08-09',
      },
      {
        'category': categoryIds['Shopping'],
        'amount': 150.0,
        'account': 'Debit Card',
        'currency': 'USD',
        'description': 'Gadgets and electronics',
        'date': '2023-08-10',
      },
    ];

    for (var transaction in initialTransactions) {
      await db.insert('transactions', transaction);
    }
  }

  Future<int> insertTransaction(TransactionModel transaction) async {
    final db = await database;
    return await db.insert('transactions', transaction.toMap());
  }

  Future<List<TransactionGroupedData>> getTransactionsWithCategories() async {
    final db = await database;

    final List<Map<String, dynamic>> transactions = await db.rawQuery('''
    SELECT transactions.*, categories.id as cat_id, categories.icon as cat_icon,
           categories.title as cat_title, categories.color as cat_color
    FROM transactions
    INNER JOIN categories ON transactions.category = categories.id
  ''');
    final List<Map<String, dynamic>> categories = await getAllCategories();

    final Map<CategoryModel, List<TransactionModel>> groupedData = {};
    //ToDo 1: Implement the logic to group transactions by categories (now it is incorrect)
    for (var map_c in categories) {
      final category = CategoryModel.fromMap(map_c);
      for (var map_t in transactions) {
        final transaction = TransactionModel.fromMap(map_t, category);
        if (transaction.category.title == category.title) {
          groupedData.update(
            category,
            (list) => list..add(transaction),
            ifAbsent: () => [transaction],
          );
        }
      }
    }

    return groupedData.entries.map((entry) {
      return TransactionGroupedData(
        categoryName: entry.key.title,
        transactions: entry.value,
      );
    }).toList();
  }

  Future<List<Map<String, dynamic>>> getAllCategories() async {
    final db = await database;
    return await db.query('categories');
  }

  Future<int> insertCategory(CategoryModel category) async {
    final db = await database;
    return await db.insert('categories', category.toMap());
  }
}
