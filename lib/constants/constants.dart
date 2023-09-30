class Constants {
  static const successNewUserCreate = 0;
  static const errorNameInUse = 1;
  static const errorPhoneNumberInUse = 2;
  static const successLogin = 3;
  static const errorLogin = 4;
  static const createCartTableSQL = '''create table if not exists cart (
            id integer primary key autoincrement, 
            userId text,
            image text,
            name text,
            price integer,
            count integer
            )''';
  static const createFavoritesTableSQL = '''create table if not exists favorites (
            id integer primary key autoincrement, 
            userId text,
            image text,
            name text,
            price integer,
            description text
            )''';
  static const createUsersTableSQL = '''create table if not exists users (
              id integer primary key autoincrement, 
              name text,
              phoneNumber text,
              password text
              )''';
}