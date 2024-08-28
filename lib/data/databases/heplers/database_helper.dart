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
        color INTEGER,
        type TEXT
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
        isIncome INTEGER,
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
        'icon': 'fastfood',
        'title': 'Food',
        'color': 0xFF4CAF50,
        'type': 'expense',
      },
      {
        'icon': 'directions_car',
        'title': 'Transport',
        'color': 0xFF2196F3,
        'type': 'expense',
      },
      {
        'icon': 'local_movies',
        'title': 'Entertainment',
        'color': 0xFFF44336,
        'type': 'expense',
      },
      {
        'icon': 'build',
        'title': 'Utilities',
        'color': 0xFFFFEB3B,
        'type': 'expense',
      },
      {
        'icon': 'healing',
        'title': 'Health',
        'color': 0xFFE91E63,
        'type': 'expense',
      },
      {
        'icon': 'school',
        'title': 'Education',
        'color': 0xFF9C27B0,
        'type': 'expense',
      },
      {
        'icon': 'shopping_cart',
        'title': 'Shopping',
        'color': 0xFFFF9800,
        'type': 'expense',
      },
      {
        'icon': 'home',
        'title': 'Rent',
        'color': 0xFF3F51B5,
        'type': 'expense',
      },
      {
        'icon': 'savings',
        'title': 'Savings',
        'color': 0xFF009688,
        'type': 'expense',
      },
      {
        'icon': 'attach_money',
        'title': 'Salary',
        'color': 0xFFDDDA41,
        'type': 'income',
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
        'isIncome': 0,
      },
      {
        'category': categoryIds['Transport'],
        'amount': 20.0,
        'account': 'Cash',
        'currency': 'USD',
        'description': 'Taxi ride',
        'date': '2023-07-26',
        'isIncome': 0,
      },
      {
        'category': categoryIds['Entertainment'],
        'amount': 100.0,
        'account': 'Credit Card',
        'currency': 'USD',
        'description': 'Concert tickets',
        'date': '2023-07-27',
        'isIncome': 0,
      },
      {
        'category': categoryIds['Utilities'],
        'amount': 150.0,
        'account': 'Bank Transfer',
        'currency': 'USD',
        'description': 'Electricity bill',
        'date': '2023-07-28',
        'isIncome': 0,
      },
      {
        'category': categoryIds['Food'],
        'amount': 30.0,
        'account': 'Cash',
        'currency': 'USD',
        'description': 'Dinner at a restaurant',
        'date': '2023-07-29',
        'isIncome': 0,
      },
      {
        'category': categoryIds['Health'],
        'amount': 200.0,
        'account': 'Debit Card',
        'currency': 'USD',
        'description': 'Medical check-up',
        'date': '2023-07-30',
        'isIncome': 0,
      },
      {
        'category': categoryIds['Education'],
        'amount': 500.0,
        'account': 'Bank Transfer',
        'currency': 'USD',
        'description': 'Online course fee',
        'date': '2023-08-01',
        'isIncome': 0,
      },
      {
        'category': categoryIds['Shopping'],
        'amount': 250.0,
        'account': 'Credit Card',
        'currency': 'USD',
        'description': 'Clothing and accessories',
        'date': '2023-08-02',
        'isIncome': 0,
      },
      {
        'category': categoryIds['Rent'],
        'amount': 1200.0,
        'account': 'Bank Transfer',
        'currency': 'USD',
        'description': 'Monthly rent payment',
        'date': '2023-08-03',
        'isIncome': 0,
      },
      {
        'category': categoryIds['Savings'],
        'amount': 300.0,
        'account': 'Bank Transfer',
        'currency': 'USD',
        'description': 'Monthly savings deposit',
        'date': '2023-08-04',
        'isIncome': 0,
      },
      {
        'category': categoryIds['Entertainment'],
        'amount': 60.0,
        'account': 'Cash',
        'currency': 'USD',
        'description': 'Movie night',
        'date': '2023-08-05',
        'isIncome': 0,
      },
      {
        'category': categoryIds['Utilities'],
        'amount': 100.0,
        'account': 'Bank Transfer',
        'currency': 'USD',
        'description': 'Water bill',
        'date': '2023-08-06',
        'isIncome': 0,
      },
      {
        'category': categoryIds['Transport'],
        'amount': 45.0,
        'account': 'Debit Card',
        'currency': 'USD',
        'description': 'Gasoline',
        'date': '2023-08-07',
        'isIncome': 0,
      },
      {
        'category': categoryIds['Food'],
        'amount': 70.0,
        'account': 'Credit Card',
        'currency': 'USD',
        'description': 'Weekly groceries',
        'date': '2023-08-08',
        'isIncome': 0,
      },
      {
        'category': categoryIds['Health'],
        'amount': 35.0,
        'account': 'Cash',
        'currency': 'USD',
        'description': 'Pharmacy expenses',
        'date': '2023-08-09',
        'isIncome': 0,
      },
      {
        'category': categoryIds['Shopping'],
        'amount': 150.0,
        'account': 'Debit Card',
        'currency': 'USD',
        'description': 'Gadgets and electronics',
        'date': '2023-08-10',
        'isIncome': 0,
      },
      {
        'category': categoryIds['Shopping'],
        'amount': 150.0,
        'account': 'Debit Card',
        'currency': 'USD',
        'description': 'Gadgets and electronics',
        'date': '2023-08-10',
        'isIncome': 0,
      },
      {
        'category': categoryIds['Salary'],
        'amount': 15000.0,
        'account': 'Debit Card',
        'currency': 'USD',
        'description': 'salary',
        'date': '2023-08-10',
        'isIncome': 1,
      }
    ];

    for (var transaction in initialTransactions) {
      await db.insert('transactions', transaction);
    }
  }

  Future<int> insertTransaction(TransactionModel transaction) async {
    final db = await database;
    final _transaction = transaction.toMap();
    return await db.insert('transactions', _transaction);
  }

  Future<List<Map<String, dynamic>>> getTransactions() async {
    final db = await database;
    return await db.rawQuery('''
    SELECT transactions.*, categories.id as cat_id, categories.icon as cat_icon,
           categories.title as cat_title, categories.color as cat_color, categories.type as cat_type
    FROM transactions
    INNER JOIN categories ON transactions.category = categories.id
  ''');
  }

  //ToDo maybe move this to another helper
  Future<List<TransactionGroupedData>> getTransactionsWithCategories() async {
    final List<Map<String, dynamic>> transactions = await getTransactions();
    final List<Map<String, dynamic>> categories = await getAllCategories();

    final List<TransactionGroupedData> groupedData = [];
    //add categories to groupedData
    for (var category in categories) {
      final categoryModel = CategoryModel.fromMap(category);
      groupedData.add(TransactionGroupedData(
        categoryName: categoryModel.title,
        transactions: [],
      ));
    }
    //add transactions to groupedData by category
    for (var transaction in transactions) {
      final category = CategoryModel(
        id: transaction['cat_id'],
        icon: transaction['cat_icon'],
        title: transaction['cat_title'],
        color: transaction['cat_color'],
        type: CategoryType.fromValue(transaction['cat_type']),
      );
      final transactionModel = TransactionModel.fromMap(transaction, category);
      for (var group in groupedData) {
        if (group.categoryName == transactionModel.category.title) {
          group.transactions.add(transactionModel);
        }
      }
    }

    return groupedData;
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
