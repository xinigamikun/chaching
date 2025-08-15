import 'package:drift/drift.dart';

@DataClassName('DbUser')
class Users extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get email => text()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get preferences => text().nullable()(); // JSON string

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('DbExpense')
class Expenses extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  RealColumn get amount => real()();
  DateTimeColumn get date => dateTime()();
  TextColumn get description => text().nullable()();
  TextColumn get category => text()();
  TextColumn get paidById => text().references(Users, #id)();
  TextColumn get source => text().nullable()();
  BoolColumn get isSettled => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('DbExpenseParticipant')
class ExpenseParticipants extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get expenseId => text().references(Expenses, #id)();
  TextColumn get userId => text().references(Users, #id)();
  RealColumn get share => real()();
  BoolColumn get hasPaid => boolean().withDefault(const Constant(false))();

  @override
  List<Set<Column>> get uniqueKeys => [
    {expenseId, userId}, // Each user can only appear once per expense
  ];
}

@DataClassName('DbTransactionSender')
class TransactionSenders extends Table {
  TextColumn get pattern => text()();
  DateTimeColumn get addedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {pattern};
}

@DataClassName('DbCategory')
class Categories extends Table {
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get usageCount => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {name};
}