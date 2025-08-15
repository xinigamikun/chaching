// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, DbUser> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _preferencesMeta =
      const VerificationMeta('preferences');
  @override
  late final GeneratedColumn<String> preferences = GeneratedColumn<String>(
      'preferences', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, email, createdAt, preferences];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<DbUser> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('preferences')) {
      context.handle(
          _preferencesMeta,
          preferences.isAcceptableOrUnknown(
              data['preferences']!, _preferencesMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbUser(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      preferences: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}preferences']),
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class DbUser extends DataClass implements Insertable<DbUser> {
  final String id;
  final String name;
  final String email;
  final DateTime createdAt;
  final String? preferences;
  const DbUser(
      {required this.id,
      required this.name,
      required this.email,
      required this.createdAt,
      this.preferences});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || preferences != null) {
      map['preferences'] = Variable<String>(preferences);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: Value(name),
      email: Value(email),
      createdAt: Value(createdAt),
      preferences: preferences == null && nullToAbsent
          ? const Value.absent()
          : Value(preferences),
    );
  }

  factory DbUser.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbUser(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      preferences: serializer.fromJson<String?>(json['preferences']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'preferences': serializer.toJson<String?>(preferences),
    };
  }

  DbUser copyWith(
          {String? id,
          String? name,
          String? email,
          DateTime? createdAt,
          Value<String?> preferences = const Value.absent()}) =>
      DbUser(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        createdAt: createdAt ?? this.createdAt,
        preferences: preferences.present ? preferences.value : this.preferences,
      );
  DbUser copyWithCompanion(UsersCompanion data) {
    return DbUser(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      preferences:
          data.preferences.present ? data.preferences.value : this.preferences,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbUser(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('createdAt: $createdAt, ')
          ..write('preferences: $preferences')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, email, createdAt, preferences);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbUser &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.createdAt == this.createdAt &&
          other.preferences == this.preferences);
}

class UsersCompanion extends UpdateCompanion<DbUser> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> email;
  final Value<DateTime> createdAt;
  final Value<String?> preferences;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.preferences = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    required String name,
    required String email,
    required DateTime createdAt,
    this.preferences = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        email = Value(email),
        createdAt = Value(createdAt);
  static Insertable<DbUser> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<DateTime>? createdAt,
    Expression<String>? preferences,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (createdAt != null) 'created_at': createdAt,
      if (preferences != null) 'preferences': preferences,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? email,
      Value<DateTime>? createdAt,
      Value<String?>? preferences,
      Value<int>? rowid}) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      preferences: preferences ?? this.preferences,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (preferences.present) {
      map['preferences'] = Variable<String>(preferences.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('createdAt: $createdAt, ')
          ..write('preferences: $preferences, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses
    with TableInfo<$ExpensesTable, DbExpense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _paidByIdMeta =
      const VerificationMeta('paidById');
  @override
  late final GeneratedColumn<String> paidById = GeneratedColumn<String>(
      'paid_by_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isSettledMeta =
      const VerificationMeta('isSettled');
  @override
  late final GeneratedColumn<bool> isSettled = GeneratedColumn<bool>(
      'is_settled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_settled" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        amount,
        date,
        description,
        category,
        paidById,
        source,
        isSettled
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(Insertable<DbExpense> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('paid_by_id')) {
      context.handle(_paidByIdMeta,
          paidById.isAcceptableOrUnknown(data['paid_by_id']!, _paidByIdMeta));
    } else if (isInserting) {
      context.missing(_paidByIdMeta);
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    }
    if (data.containsKey('is_settled')) {
      context.handle(_isSettledMeta,
          isSettled.isAcceptableOrUnknown(data['is_settled']!, _isSettledMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbExpense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbExpense(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      paidById: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}paid_by_id'])!,
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source']),
      isSettled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_settled'])!,
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class DbExpense extends DataClass implements Insertable<DbExpense> {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String? description;
  final String category;
  final String paidById;
  final String? source;
  final bool isSettled;
  const DbExpense(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date,
      this.description,
      required this.category,
      required this.paidById,
      this.source,
      required this.isSettled});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['amount'] = Variable<double>(amount);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['category'] = Variable<String>(category);
    map['paid_by_id'] = Variable<String>(paidById);
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String>(source);
    }
    map['is_settled'] = Variable<bool>(isSettled);
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      title: Value(title),
      amount: Value(amount),
      date: Value(date),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      category: Value(category),
      paidById: Value(paidById),
      source:
          source == null && nullToAbsent ? const Value.absent() : Value(source),
      isSettled: Value(isSettled),
    );
  }

  factory DbExpense.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbExpense(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      amount: serializer.fromJson<double>(json['amount']),
      date: serializer.fromJson<DateTime>(json['date']),
      description: serializer.fromJson<String?>(json['description']),
      category: serializer.fromJson<String>(json['category']),
      paidById: serializer.fromJson<String>(json['paidById']),
      source: serializer.fromJson<String?>(json['source']),
      isSettled: serializer.fromJson<bool>(json['isSettled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'amount': serializer.toJson<double>(amount),
      'date': serializer.toJson<DateTime>(date),
      'description': serializer.toJson<String?>(description),
      'category': serializer.toJson<String>(category),
      'paidById': serializer.toJson<String>(paidById),
      'source': serializer.toJson<String?>(source),
      'isSettled': serializer.toJson<bool>(isSettled),
    };
  }

  DbExpense copyWith(
          {String? id,
          String? title,
          double? amount,
          DateTime? date,
          Value<String?> description = const Value.absent(),
          String? category,
          String? paidById,
          Value<String?> source = const Value.absent(),
          bool? isSettled}) =>
      DbExpense(
        id: id ?? this.id,
        title: title ?? this.title,
        amount: amount ?? this.amount,
        date: date ?? this.date,
        description: description.present ? description.value : this.description,
        category: category ?? this.category,
        paidById: paidById ?? this.paidById,
        source: source.present ? source.value : this.source,
        isSettled: isSettled ?? this.isSettled,
      );
  DbExpense copyWithCompanion(ExpensesCompanion data) {
    return DbExpense(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      amount: data.amount.present ? data.amount.value : this.amount,
      date: data.date.present ? data.date.value : this.date,
      description:
          data.description.present ? data.description.value : this.description,
      category: data.category.present ? data.category.value : this.category,
      paidById: data.paidById.present ? data.paidById.value : this.paidById,
      source: data.source.present ? data.source.value : this.source,
      isSettled: data.isSettled.present ? data.isSettled.value : this.isSettled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbExpense(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('paidById: $paidById, ')
          ..write('source: $source, ')
          ..write('isSettled: $isSettled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, amount, date, description,
      category, paidById, source, isSettled);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbExpense &&
          other.id == this.id &&
          other.title == this.title &&
          other.amount == this.amount &&
          other.date == this.date &&
          other.description == this.description &&
          other.category == this.category &&
          other.paidById == this.paidById &&
          other.source == this.source &&
          other.isSettled == this.isSettled);
}

class ExpensesCompanion extends UpdateCompanion<DbExpense> {
  final Value<String> id;
  final Value<String> title;
  final Value<double> amount;
  final Value<DateTime> date;
  final Value<String?> description;
  final Value<String> category;
  final Value<String> paidById;
  final Value<String?> source;
  final Value<bool> isSettled;
  final Value<int> rowid;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.amount = const Value.absent(),
    this.date = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.paidById = const Value.absent(),
    this.source = const Value.absent(),
    this.isSettled = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExpensesCompanion.insert({
    required String id,
    required String title,
    required double amount,
    required DateTime date,
    this.description = const Value.absent(),
    required String category,
    required String paidById,
    this.source = const Value.absent(),
    this.isSettled = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        amount = Value(amount),
        date = Value(date),
        category = Value(category),
        paidById = Value(paidById);
  static Insertable<DbExpense> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<double>? amount,
    Expression<DateTime>? date,
    Expression<String>? description,
    Expression<String>? category,
    Expression<String>? paidById,
    Expression<String>? source,
    Expression<bool>? isSettled,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (amount != null) 'amount': amount,
      if (date != null) 'date': date,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (paidById != null) 'paid_by_id': paidById,
      if (source != null) 'source': source,
      if (isSettled != null) 'is_settled': isSettled,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExpensesCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<double>? amount,
      Value<DateTime>? date,
      Value<String?>? description,
      Value<String>? category,
      Value<String>? paidById,
      Value<String?>? source,
      Value<bool>? isSettled,
      Value<int>? rowid}) {
    return ExpensesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      description: description ?? this.description,
      category: category ?? this.category,
      paidById: paidById ?? this.paidById,
      source: source ?? this.source,
      isSettled: isSettled ?? this.isSettled,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (paidById.present) {
      map['paid_by_id'] = Variable<String>(paidById.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (isSettled.present) {
      map['is_settled'] = Variable<bool>(isSettled.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('date: $date, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('paidById: $paidById, ')
          ..write('source: $source, ')
          ..write('isSettled: $isSettled, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExpenseParticipantsTable extends ExpenseParticipants
    with TableInfo<$ExpenseParticipantsTable, DbExpenseParticipant> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpenseParticipantsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _expenseIdMeta =
      const VerificationMeta('expenseId');
  @override
  late final GeneratedColumn<String> expenseId = GeneratedColumn<String>(
      'expense_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES expenses (id)'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _shareMeta = const VerificationMeta('share');
  @override
  late final GeneratedColumn<double> share = GeneratedColumn<double>(
      'share', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _hasPaidMeta =
      const VerificationMeta('hasPaid');
  @override
  late final GeneratedColumn<bool> hasPaid = GeneratedColumn<bool>(
      'has_paid', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("has_paid" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [id, expenseId, userId, share, hasPaid];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expense_participants';
  @override
  VerificationContext validateIntegrity(
      Insertable<DbExpenseParticipant> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('expense_id')) {
      context.handle(_expenseIdMeta,
          expenseId.isAcceptableOrUnknown(data['expense_id']!, _expenseIdMeta));
    } else if (isInserting) {
      context.missing(_expenseIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('share')) {
      context.handle(
          _shareMeta, share.isAcceptableOrUnknown(data['share']!, _shareMeta));
    } else if (isInserting) {
      context.missing(_shareMeta);
    }
    if (data.containsKey('has_paid')) {
      context.handle(_hasPaidMeta,
          hasPaid.isAcceptableOrUnknown(data['has_paid']!, _hasPaidMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {expenseId, userId},
      ];
  @override
  DbExpenseParticipant map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbExpenseParticipant(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      expenseId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}expense_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      share: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}share'])!,
      hasPaid: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}has_paid'])!,
    );
  }

  @override
  $ExpenseParticipantsTable createAlias(String alias) {
    return $ExpenseParticipantsTable(attachedDatabase, alias);
  }
}

class DbExpenseParticipant extends DataClass
    implements Insertable<DbExpenseParticipant> {
  final int id;
  final String expenseId;
  final String userId;
  final double share;
  final bool hasPaid;
  const DbExpenseParticipant(
      {required this.id,
      required this.expenseId,
      required this.userId,
      required this.share,
      required this.hasPaid});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['expense_id'] = Variable<String>(expenseId);
    map['user_id'] = Variable<String>(userId);
    map['share'] = Variable<double>(share);
    map['has_paid'] = Variable<bool>(hasPaid);
    return map;
  }

  ExpenseParticipantsCompanion toCompanion(bool nullToAbsent) {
    return ExpenseParticipantsCompanion(
      id: Value(id),
      expenseId: Value(expenseId),
      userId: Value(userId),
      share: Value(share),
      hasPaid: Value(hasPaid),
    );
  }

  factory DbExpenseParticipant.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbExpenseParticipant(
      id: serializer.fromJson<int>(json['id']),
      expenseId: serializer.fromJson<String>(json['expenseId']),
      userId: serializer.fromJson<String>(json['userId']),
      share: serializer.fromJson<double>(json['share']),
      hasPaid: serializer.fromJson<bool>(json['hasPaid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'expenseId': serializer.toJson<String>(expenseId),
      'userId': serializer.toJson<String>(userId),
      'share': serializer.toJson<double>(share),
      'hasPaid': serializer.toJson<bool>(hasPaid),
    };
  }

  DbExpenseParticipant copyWith(
          {int? id,
          String? expenseId,
          String? userId,
          double? share,
          bool? hasPaid}) =>
      DbExpenseParticipant(
        id: id ?? this.id,
        expenseId: expenseId ?? this.expenseId,
        userId: userId ?? this.userId,
        share: share ?? this.share,
        hasPaid: hasPaid ?? this.hasPaid,
      );
  DbExpenseParticipant copyWithCompanion(ExpenseParticipantsCompanion data) {
    return DbExpenseParticipant(
      id: data.id.present ? data.id.value : this.id,
      expenseId: data.expenseId.present ? data.expenseId.value : this.expenseId,
      userId: data.userId.present ? data.userId.value : this.userId,
      share: data.share.present ? data.share.value : this.share,
      hasPaid: data.hasPaid.present ? data.hasPaid.value : this.hasPaid,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbExpenseParticipant(')
          ..write('id: $id, ')
          ..write('expenseId: $expenseId, ')
          ..write('userId: $userId, ')
          ..write('share: $share, ')
          ..write('hasPaid: $hasPaid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, expenseId, userId, share, hasPaid);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbExpenseParticipant &&
          other.id == this.id &&
          other.expenseId == this.expenseId &&
          other.userId == this.userId &&
          other.share == this.share &&
          other.hasPaid == this.hasPaid);
}

class ExpenseParticipantsCompanion
    extends UpdateCompanion<DbExpenseParticipant> {
  final Value<int> id;
  final Value<String> expenseId;
  final Value<String> userId;
  final Value<double> share;
  final Value<bool> hasPaid;
  const ExpenseParticipantsCompanion({
    this.id = const Value.absent(),
    this.expenseId = const Value.absent(),
    this.userId = const Value.absent(),
    this.share = const Value.absent(),
    this.hasPaid = const Value.absent(),
  });
  ExpenseParticipantsCompanion.insert({
    this.id = const Value.absent(),
    required String expenseId,
    required String userId,
    required double share,
    this.hasPaid = const Value.absent(),
  })  : expenseId = Value(expenseId),
        userId = Value(userId),
        share = Value(share);
  static Insertable<DbExpenseParticipant> custom({
    Expression<int>? id,
    Expression<String>? expenseId,
    Expression<String>? userId,
    Expression<double>? share,
    Expression<bool>? hasPaid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (expenseId != null) 'expense_id': expenseId,
      if (userId != null) 'user_id': userId,
      if (share != null) 'share': share,
      if (hasPaid != null) 'has_paid': hasPaid,
    });
  }

  ExpenseParticipantsCompanion copyWith(
      {Value<int>? id,
      Value<String>? expenseId,
      Value<String>? userId,
      Value<double>? share,
      Value<bool>? hasPaid}) {
    return ExpenseParticipantsCompanion(
      id: id ?? this.id,
      expenseId: expenseId ?? this.expenseId,
      userId: userId ?? this.userId,
      share: share ?? this.share,
      hasPaid: hasPaid ?? this.hasPaid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (expenseId.present) {
      map['expense_id'] = Variable<String>(expenseId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (share.present) {
      map['share'] = Variable<double>(share.value);
    }
    if (hasPaid.present) {
      map['has_paid'] = Variable<bool>(hasPaid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseParticipantsCompanion(')
          ..write('id: $id, ')
          ..write('expenseId: $expenseId, ')
          ..write('userId: $userId, ')
          ..write('share: $share, ')
          ..write('hasPaid: $hasPaid')
          ..write(')'))
        .toString();
  }
}

class $TransactionSendersTable extends TransactionSenders
    with TableInfo<$TransactionSendersTable, DbTransactionSender> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionSendersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _patternMeta =
      const VerificationMeta('pattern');
  @override
  late final GeneratedColumn<String> pattern = GeneratedColumn<String>(
      'pattern', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addedAtMeta =
      const VerificationMeta('addedAt');
  @override
  late final GeneratedColumn<DateTime> addedAt = GeneratedColumn<DateTime>(
      'added_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [pattern, addedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transaction_senders';
  @override
  VerificationContext validateIntegrity(
      Insertable<DbTransactionSender> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('pattern')) {
      context.handle(_patternMeta,
          pattern.isAcceptableOrUnknown(data['pattern']!, _patternMeta));
    } else if (isInserting) {
      context.missing(_patternMeta);
    }
    if (data.containsKey('added_at')) {
      context.handle(_addedAtMeta,
          addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta));
    } else if (isInserting) {
      context.missing(_addedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pattern};
  @override
  DbTransactionSender map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbTransactionSender(
      pattern: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pattern'])!,
      addedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}added_at'])!,
    );
  }

  @override
  $TransactionSendersTable createAlias(String alias) {
    return $TransactionSendersTable(attachedDatabase, alias);
  }
}

class DbTransactionSender extends DataClass
    implements Insertable<DbTransactionSender> {
  final String pattern;
  final DateTime addedAt;
  const DbTransactionSender({required this.pattern, required this.addedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['pattern'] = Variable<String>(pattern);
    map['added_at'] = Variable<DateTime>(addedAt);
    return map;
  }

  TransactionSendersCompanion toCompanion(bool nullToAbsent) {
    return TransactionSendersCompanion(
      pattern: Value(pattern),
      addedAt: Value(addedAt),
    );
  }

  factory DbTransactionSender.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbTransactionSender(
      pattern: serializer.fromJson<String>(json['pattern']),
      addedAt: serializer.fromJson<DateTime>(json['addedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'pattern': serializer.toJson<String>(pattern),
      'addedAt': serializer.toJson<DateTime>(addedAt),
    };
  }

  DbTransactionSender copyWith({String? pattern, DateTime? addedAt}) =>
      DbTransactionSender(
        pattern: pattern ?? this.pattern,
        addedAt: addedAt ?? this.addedAt,
      );
  DbTransactionSender copyWithCompanion(TransactionSendersCompanion data) {
    return DbTransactionSender(
      pattern: data.pattern.present ? data.pattern.value : this.pattern,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbTransactionSender(')
          ..write('pattern: $pattern, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(pattern, addedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbTransactionSender &&
          other.pattern == this.pattern &&
          other.addedAt == this.addedAt);
}

class TransactionSendersCompanion extends UpdateCompanion<DbTransactionSender> {
  final Value<String> pattern;
  final Value<DateTime> addedAt;
  final Value<int> rowid;
  const TransactionSendersCompanion({
    this.pattern = const Value.absent(),
    this.addedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionSendersCompanion.insert({
    required String pattern,
    required DateTime addedAt,
    this.rowid = const Value.absent(),
  })  : pattern = Value(pattern),
        addedAt = Value(addedAt);
  static Insertable<DbTransactionSender> custom({
    Expression<String>? pattern,
    Expression<DateTime>? addedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (pattern != null) 'pattern': pattern,
      if (addedAt != null) 'added_at': addedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionSendersCompanion copyWith(
      {Value<String>? pattern, Value<DateTime>? addedAt, Value<int>? rowid}) {
    return TransactionSendersCompanion(
      pattern: pattern ?? this.pattern,
      addedAt: addedAt ?? this.addedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (pattern.present) {
      map['pattern'] = Variable<String>(pattern.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<DateTime>(addedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionSendersCompanion(')
          ..write('pattern: $pattern, ')
          ..write('addedAt: $addedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, DbCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _usageCountMeta =
      const VerificationMeta('usageCount');
  @override
  late final GeneratedColumn<int> usageCount = GeneratedColumn<int>(
      'usage_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [name, createdAt, usageCount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<DbCategory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('usage_count')) {
      context.handle(
          _usageCountMeta,
          usageCount.isAcceptableOrUnknown(
              data['usage_count']!, _usageCountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  DbCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbCategory(
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      usageCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}usage_count'])!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class DbCategory extends DataClass implements Insertable<DbCategory> {
  final String name;
  final DateTime createdAt;
  final int usageCount;
  const DbCategory(
      {required this.name, required this.createdAt, required this.usageCount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['usage_count'] = Variable<int>(usageCount);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      name: Value(name),
      createdAt: Value(createdAt),
      usageCount: Value(usageCount),
    );
  }

  factory DbCategory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbCategory(
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      usageCount: serializer.fromJson<int>(json['usageCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'usageCount': serializer.toJson<int>(usageCount),
    };
  }

  DbCategory copyWith({String? name, DateTime? createdAt, int? usageCount}) =>
      DbCategory(
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        usageCount: usageCount ?? this.usageCount,
      );
  DbCategory copyWithCompanion(CategoriesCompanion data) {
    return DbCategory(
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      usageCount:
          data.usageCount.present ? data.usageCount.value : this.usageCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbCategory(')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('usageCount: $usageCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(name, createdAt, usageCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbCategory &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.usageCount == this.usageCount);
}

class CategoriesCompanion extends UpdateCompanion<DbCategory> {
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<int> usageCount;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.usageCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String name,
    required DateTime createdAt,
    this.usageCount = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : name = Value(name),
        createdAt = Value(createdAt);
  static Insertable<DbCategory> custom({
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<int>? usageCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (usageCount != null) 'usage_count': usageCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith(
      {Value<String>? name,
      Value<DateTime>? createdAt,
      Value<int>? usageCount,
      Value<int>? rowid}) {
    return CategoriesCompanion(
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      usageCount: usageCount ?? this.usageCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (usageCount.present) {
      map['usage_count'] = Variable<int>(usageCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('usageCount: $usageCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $ExpenseParticipantsTable expenseParticipants =
      $ExpenseParticipantsTable(this);
  late final $TransactionSendersTable transactionSenders =
      $TransactionSendersTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [users, expenses, expenseParticipants, transactionSenders, categories];
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  required String id,
  required String name,
  required String email,
  required DateTime createdAt,
  Value<String?> preferences,
  Value<int> rowid,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> email,
  Value<DateTime> createdAt,
  Value<String?> preferences,
  Value<int> rowid,
});

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, DbUser> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ExpensesTable, List<DbExpense>>
      _expensesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.expenses,
          aliasName: $_aliasNameGenerator(db.users.id, db.expenses.paidById));

  $$ExpensesTableProcessedTableManager get expensesRefs {
    final manager = $$ExpensesTableTableManager($_db, $_db.expenses)
        .filter((f) => f.paidById.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_expensesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ExpenseParticipantsTable,
      List<DbExpenseParticipant>> _expenseParticipantsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.expenseParticipants,
          aliasName:
              $_aliasNameGenerator(db.users.id, db.expenseParticipants.userId));

  $$ExpenseParticipantsTableProcessedTableManager get expenseParticipantsRefs {
    final manager =
        $$ExpenseParticipantsTableTableManager($_db, $_db.expenseParticipants)
            .filter((f) => f.userId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_expenseParticipantsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get preferences => $composableBuilder(
      column: $table.preferences, builder: (column) => ColumnFilters(column));

  Expression<bool> expensesRefs(
      Expression<bool> Function($$ExpensesTableFilterComposer f) f) {
    final $$ExpensesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.expenses,
        getReferencedColumn: (t) => t.paidById,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExpensesTableFilterComposer(
              $db: $db,
              $table: $db.expenses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> expenseParticipantsRefs(
      Expression<bool> Function($$ExpenseParticipantsTableFilterComposer f) f) {
    final $$ExpenseParticipantsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.expenseParticipants,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExpenseParticipantsTableFilterComposer(
              $db: $db,
              $table: $db.expenseParticipants,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get preferences => $composableBuilder(
      column: $table.preferences, builder: (column) => ColumnOrderings(column));
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get preferences => $composableBuilder(
      column: $table.preferences, builder: (column) => column);

  Expression<T> expensesRefs<T extends Object>(
      Expression<T> Function($$ExpensesTableAnnotationComposer a) f) {
    final $$ExpensesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.expenses,
        getReferencedColumn: (t) => t.paidById,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExpensesTableAnnotationComposer(
              $db: $db,
              $table: $db.expenses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> expenseParticipantsRefs<T extends Object>(
      Expression<T> Function($$ExpenseParticipantsTableAnnotationComposer a)
          f) {
    final $$ExpenseParticipantsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.expenseParticipants,
            getReferencedColumn: (t) => t.userId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ExpenseParticipantsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.expenseParticipants,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$UsersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsersTable,
    DbUser,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (DbUser, $$UsersTableReferences),
    DbUser,
    PrefetchHooks Function({bool expensesRefs, bool expenseParticipantsRefs})> {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<String?> preferences = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            name: name,
            email: email,
            createdAt: createdAt,
            preferences: preferences,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String email,
            required DateTime createdAt,
            Value<String?> preferences = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UsersCompanion.insert(
            id: id,
            name: name,
            email: email,
            createdAt: createdAt,
            preferences: preferences,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$UsersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {expensesRefs = false, expenseParticipantsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (expensesRefs) db.expenses,
                if (expenseParticipantsRefs) db.expenseParticipants
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (expensesRefs)
                    await $_getPrefetchedData<DbUser, $UsersTable, DbExpense>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._expensesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0).expensesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.paidById == item.id),
                        typedResults: items),
                  if (expenseParticipantsRefs)
                    await $_getPrefetchedData<DbUser, $UsersTable,
                            DbExpenseParticipant>(
                        currentTable: table,
                        referencedTable: $$UsersTableReferences
                            ._expenseParticipantsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0)
                                .expenseParticipantsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$UsersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsersTable,
    DbUser,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (DbUser, $$UsersTableReferences),
    DbUser,
    PrefetchHooks Function({bool expensesRefs, bool expenseParticipantsRefs})>;
typedef $$ExpensesTableCreateCompanionBuilder = ExpensesCompanion Function({
  required String id,
  required String title,
  required double amount,
  required DateTime date,
  Value<String?> description,
  required String category,
  required String paidById,
  Value<String?> source,
  Value<bool> isSettled,
  Value<int> rowid,
});
typedef $$ExpensesTableUpdateCompanionBuilder = ExpensesCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<double> amount,
  Value<DateTime> date,
  Value<String?> description,
  Value<String> category,
  Value<String> paidById,
  Value<String?> source,
  Value<bool> isSettled,
  Value<int> rowid,
});

final class $$ExpensesTableReferences
    extends BaseReferences<_$AppDatabase, $ExpensesTable, DbExpense> {
  $$ExpensesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _paidByIdTable(_$AppDatabase db) => db.users
      .createAlias($_aliasNameGenerator(db.expenses.paidById, db.users.id));

  $$UsersTableProcessedTableManager get paidById {
    final $_column = $_itemColumn<String>('paid_by_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_paidByIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ExpenseParticipantsTable,
      List<DbExpenseParticipant>> _expenseParticipantsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.expenseParticipants,
          aliasName: $_aliasNameGenerator(
              db.expenses.id, db.expenseParticipants.expenseId));

  $$ExpenseParticipantsTableProcessedTableManager get expenseParticipantsRefs {
    final manager = $$ExpenseParticipantsTableTableManager(
            $_db, $_db.expenseParticipants)
        .filter((f) => f.expenseId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_expenseParticipantsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSettled => $composableBuilder(
      column: $table.isSettled, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get paidById {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.paidById,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> expenseParticipantsRefs(
      Expression<bool> Function($$ExpenseParticipantsTableFilterComposer f) f) {
    final $$ExpenseParticipantsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.expenseParticipants,
        getReferencedColumn: (t) => t.expenseId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExpenseParticipantsTableFilterComposer(
              $db: $db,
              $table: $db.expenseParticipants,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSettled => $composableBuilder(
      column: $table.isSettled, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get paidById {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.paidById,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<bool> get isSettled =>
      $composableBuilder(column: $table.isSettled, builder: (column) => column);

  $$UsersTableAnnotationComposer get paidById {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.paidById,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> expenseParticipantsRefs<T extends Object>(
      Expression<T> Function($$ExpenseParticipantsTableAnnotationComposer a)
          f) {
    final $$ExpenseParticipantsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.expenseParticipants,
            getReferencedColumn: (t) => t.expenseId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ExpenseParticipantsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.expenseParticipants,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$ExpensesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExpensesTable,
    DbExpense,
    $$ExpensesTableFilterComposer,
    $$ExpensesTableOrderingComposer,
    $$ExpensesTableAnnotationComposer,
    $$ExpensesTableCreateCompanionBuilder,
    $$ExpensesTableUpdateCompanionBuilder,
    (DbExpense, $$ExpensesTableReferences),
    DbExpense,
    PrefetchHooks Function({bool paidById, bool expenseParticipantsRefs})> {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> paidById = const Value.absent(),
            Value<String?> source = const Value.absent(),
            Value<bool> isSettled = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExpensesCompanion(
            id: id,
            title: title,
            amount: amount,
            date: date,
            description: description,
            category: category,
            paidById: paidById,
            source: source,
            isSettled: isSettled,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required double amount,
            required DateTime date,
            Value<String?> description = const Value.absent(),
            required String category,
            required String paidById,
            Value<String?> source = const Value.absent(),
            Value<bool> isSettled = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExpensesCompanion.insert(
            id: id,
            title: title,
            amount: amount,
            date: date,
            description: description,
            category: category,
            paidById: paidById,
            source: source,
            isSettled: isSettled,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ExpensesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {paidById = false, expenseParticipantsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (expenseParticipantsRefs) db.expenseParticipants
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (paidById) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.paidById,
                    referencedTable:
                        $$ExpensesTableReferences._paidByIdTable(db),
                    referencedColumn:
                        $$ExpensesTableReferences._paidByIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (expenseParticipantsRefs)
                    await $_getPrefetchedData<DbExpense, $ExpensesTable,
                            DbExpenseParticipant>(
                        currentTable: table,
                        referencedTable: $$ExpensesTableReferences
                            ._expenseParticipantsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ExpensesTableReferences(db, table, p0)
                                .expenseParticipantsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.expenseId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ExpensesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExpensesTable,
    DbExpense,
    $$ExpensesTableFilterComposer,
    $$ExpensesTableOrderingComposer,
    $$ExpensesTableAnnotationComposer,
    $$ExpensesTableCreateCompanionBuilder,
    $$ExpensesTableUpdateCompanionBuilder,
    (DbExpense, $$ExpensesTableReferences),
    DbExpense,
    PrefetchHooks Function({bool paidById, bool expenseParticipantsRefs})>;
typedef $$ExpenseParticipantsTableCreateCompanionBuilder
    = ExpenseParticipantsCompanion Function({
  Value<int> id,
  required String expenseId,
  required String userId,
  required double share,
  Value<bool> hasPaid,
});
typedef $$ExpenseParticipantsTableUpdateCompanionBuilder
    = ExpenseParticipantsCompanion Function({
  Value<int> id,
  Value<String> expenseId,
  Value<String> userId,
  Value<double> share,
  Value<bool> hasPaid,
});

final class $$ExpenseParticipantsTableReferences extends BaseReferences<
    _$AppDatabase, $ExpenseParticipantsTable, DbExpenseParticipant> {
  $$ExpenseParticipantsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ExpensesTable _expenseIdTable(_$AppDatabase db) =>
      db.expenses.createAlias($_aliasNameGenerator(
          db.expenseParticipants.expenseId, db.expenses.id));

  $$ExpensesTableProcessedTableManager get expenseId {
    final $_column = $_itemColumn<String>('expense_id')!;

    final manager = $$ExpensesTableTableManager($_db, $_db.expenses)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_expenseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users.createAlias(
      $_aliasNameGenerator(db.expenseParticipants.userId, db.users.id));

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<String>('user_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ExpenseParticipantsTableFilterComposer
    extends Composer<_$AppDatabase, $ExpenseParticipantsTable> {
  $$ExpenseParticipantsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get share => $composableBuilder(
      column: $table.share, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hasPaid => $composableBuilder(
      column: $table.hasPaid, builder: (column) => ColumnFilters(column));

  $$ExpensesTableFilterComposer get expenseId {
    final $$ExpensesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.expenseId,
        referencedTable: $db.expenses,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExpensesTableFilterComposer(
              $db: $db,
              $table: $db.expenses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExpenseParticipantsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpenseParticipantsTable> {
  $$ExpenseParticipantsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get share => $composableBuilder(
      column: $table.share, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hasPaid => $composableBuilder(
      column: $table.hasPaid, builder: (column) => ColumnOrderings(column));

  $$ExpensesTableOrderingComposer get expenseId {
    final $$ExpensesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.expenseId,
        referencedTable: $db.expenses,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExpensesTableOrderingComposer(
              $db: $db,
              $table: $db.expenses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExpenseParticipantsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpenseParticipantsTable> {
  $$ExpenseParticipantsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get share =>
      $composableBuilder(column: $table.share, builder: (column) => column);

  GeneratedColumn<bool> get hasPaid =>
      $composableBuilder(column: $table.hasPaid, builder: (column) => column);

  $$ExpensesTableAnnotationComposer get expenseId {
    final $$ExpensesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.expenseId,
        referencedTable: $db.expenses,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExpensesTableAnnotationComposer(
              $db: $db,
              $table: $db.expenses,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExpenseParticipantsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExpenseParticipantsTable,
    DbExpenseParticipant,
    $$ExpenseParticipantsTableFilterComposer,
    $$ExpenseParticipantsTableOrderingComposer,
    $$ExpenseParticipantsTableAnnotationComposer,
    $$ExpenseParticipantsTableCreateCompanionBuilder,
    $$ExpenseParticipantsTableUpdateCompanionBuilder,
    (DbExpenseParticipant, $$ExpenseParticipantsTableReferences),
    DbExpenseParticipant,
    PrefetchHooks Function({bool expenseId, bool userId})> {
  $$ExpenseParticipantsTableTableManager(
      _$AppDatabase db, $ExpenseParticipantsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpenseParticipantsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpenseParticipantsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpenseParticipantsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> expenseId = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<double> share = const Value.absent(),
            Value<bool> hasPaid = const Value.absent(),
          }) =>
              ExpenseParticipantsCompanion(
            id: id,
            expenseId: expenseId,
            userId: userId,
            share: share,
            hasPaid: hasPaid,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String expenseId,
            required String userId,
            required double share,
            Value<bool> hasPaid = const Value.absent(),
          }) =>
              ExpenseParticipantsCompanion.insert(
            id: id,
            expenseId: expenseId,
            userId: userId,
            share: share,
            hasPaid: hasPaid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ExpenseParticipantsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({expenseId = false, userId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (expenseId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.expenseId,
                    referencedTable: $$ExpenseParticipantsTableReferences
                        ._expenseIdTable(db),
                    referencedColumn: $$ExpenseParticipantsTableReferences
                        ._expenseIdTable(db)
                        .id,
                  ) as T;
                }
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable:
                        $$ExpenseParticipantsTableReferences._userIdTable(db),
                    referencedColumn: $$ExpenseParticipantsTableReferences
                        ._userIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ExpenseParticipantsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExpenseParticipantsTable,
    DbExpenseParticipant,
    $$ExpenseParticipantsTableFilterComposer,
    $$ExpenseParticipantsTableOrderingComposer,
    $$ExpenseParticipantsTableAnnotationComposer,
    $$ExpenseParticipantsTableCreateCompanionBuilder,
    $$ExpenseParticipantsTableUpdateCompanionBuilder,
    (DbExpenseParticipant, $$ExpenseParticipantsTableReferences),
    DbExpenseParticipant,
    PrefetchHooks Function({bool expenseId, bool userId})>;
typedef $$TransactionSendersTableCreateCompanionBuilder
    = TransactionSendersCompanion Function({
  required String pattern,
  required DateTime addedAt,
  Value<int> rowid,
});
typedef $$TransactionSendersTableUpdateCompanionBuilder
    = TransactionSendersCompanion Function({
  Value<String> pattern,
  Value<DateTime> addedAt,
  Value<int> rowid,
});

class $$TransactionSendersTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionSendersTable> {
  $$TransactionSendersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get pattern => $composableBuilder(
      column: $table.pattern, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get addedAt => $composableBuilder(
      column: $table.addedAt, builder: (column) => ColumnFilters(column));
}

class $$TransactionSendersTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionSendersTable> {
  $$TransactionSendersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get pattern => $composableBuilder(
      column: $table.pattern, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get addedAt => $composableBuilder(
      column: $table.addedAt, builder: (column) => ColumnOrderings(column));
}

class $$TransactionSendersTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionSendersTable> {
  $$TransactionSendersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get pattern =>
      $composableBuilder(column: $table.pattern, builder: (column) => column);

  GeneratedColumn<DateTime> get addedAt =>
      $composableBuilder(column: $table.addedAt, builder: (column) => column);
}

class $$TransactionSendersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TransactionSendersTable,
    DbTransactionSender,
    $$TransactionSendersTableFilterComposer,
    $$TransactionSendersTableOrderingComposer,
    $$TransactionSendersTableAnnotationComposer,
    $$TransactionSendersTableCreateCompanionBuilder,
    $$TransactionSendersTableUpdateCompanionBuilder,
    (
      DbTransactionSender,
      BaseReferences<_$AppDatabase, $TransactionSendersTable,
          DbTransactionSender>
    ),
    DbTransactionSender,
    PrefetchHooks Function()> {
  $$TransactionSendersTableTableManager(
      _$AppDatabase db, $TransactionSendersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionSendersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionSendersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionSendersTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> pattern = const Value.absent(),
            Value<DateTime> addedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TransactionSendersCompanion(
            pattern: pattern,
            addedAt: addedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String pattern,
            required DateTime addedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              TransactionSendersCompanion.insert(
            pattern: pattern,
            addedAt: addedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TransactionSendersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TransactionSendersTable,
    DbTransactionSender,
    $$TransactionSendersTableFilterComposer,
    $$TransactionSendersTableOrderingComposer,
    $$TransactionSendersTableAnnotationComposer,
    $$TransactionSendersTableCreateCompanionBuilder,
    $$TransactionSendersTableUpdateCompanionBuilder,
    (
      DbTransactionSender,
      BaseReferences<_$AppDatabase, $TransactionSendersTable,
          DbTransactionSender>
    ),
    DbTransactionSender,
    PrefetchHooks Function()>;
typedef $$CategoriesTableCreateCompanionBuilder = CategoriesCompanion Function({
  required String name,
  required DateTime createdAt,
  Value<int> usageCount,
  Value<int> rowid,
});
typedef $$CategoriesTableUpdateCompanionBuilder = CategoriesCompanion Function({
  Value<String> name,
  Value<DateTime> createdAt,
  Value<int> usageCount,
  Value<int> rowid,
});

class $$CategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get usageCount => $composableBuilder(
      column: $table.usageCount, builder: (column) => ColumnFilters(column));
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get usageCount => $composableBuilder(
      column: $table.usageCount, builder: (column) => ColumnOrderings(column));
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get usageCount => $composableBuilder(
      column: $table.usageCount, builder: (column) => column);
}

class $$CategoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoriesTable,
    DbCategory,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableAnnotationComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder,
    (DbCategory, BaseReferences<_$AppDatabase, $CategoriesTable, DbCategory>),
    DbCategory,
    PrefetchHooks Function()> {
  $$CategoriesTableTableManager(_$AppDatabase db, $CategoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> name = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> usageCount = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CategoriesCompanion(
            name: name,
            createdAt: createdAt,
            usageCount: usageCount,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String name,
            required DateTime createdAt,
            Value<int> usageCount = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CategoriesCompanion.insert(
            name: name,
            createdAt: createdAt,
            usageCount: usageCount,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CategoriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CategoriesTable,
    DbCategory,
    $$CategoriesTableFilterComposer,
    $$CategoriesTableOrderingComposer,
    $$CategoriesTableAnnotationComposer,
    $$CategoriesTableCreateCompanionBuilder,
    $$CategoriesTableUpdateCompanionBuilder,
    (DbCategory, BaseReferences<_$AppDatabase, $CategoriesTable, DbCategory>),
    DbCategory,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$ExpenseParticipantsTableTableManager get expenseParticipants =>
      $$ExpenseParticipantsTableTableManager(_db, _db.expenseParticipants);
  $$TransactionSendersTableTableManager get transactionSenders =>
      $$TransactionSendersTableTableManager(_db, _db.transactionSenders);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
}
