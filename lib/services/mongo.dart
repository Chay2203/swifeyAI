import 'package:mongo_dart/mongo_dart.dart';
import '../models/user.dart';

class MongoDBService {
  static const String MONGODB_URL = "mongodb+srv://theogpapusgang:fyjrIiEb81FHS6Re@swifey.ercx2.mongodb.net/";
  static const String USER_COLLECTION = "users";
  
  static Db? _db;

  static Future<void> connect() async {
    if (_db == null) {
      _db = await Db.create(MONGODB_URL);
      await _db!.open();
    }
  }

  static Future<void> insertUser(UserModel user) async {
    await connect();
    await _db!.collection(USER_COLLECTION).insert(user.toJson());
  }
}