// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_list_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TransactionListEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String userId, String month) getTransactions,
    required TResult Function(String userId, String month) refreshTransactions,
    required TResult Function(String userId, int saving, String month)
        updateSaving,
    required TResult Function(String transactionId, String month)
        deleteTransaction,
    required TResult Function(String userId, String month, String type,
            String? lastTransactionId, int? limit, String? searchQuery)
        getAllTransactionsByType,
    required TResult Function(String userId, String month, String type,
            String lastTransactionId, int? limit, String? searchQuery)
        loadMoreTransactions,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String userId, String month)? getTransactions,
    TResult? Function(String userId, String month)? refreshTransactions,
    TResult? Function(String userId, int saving, String month)? updateSaving,
    TResult? Function(String transactionId, String month)? deleteTransaction,
    TResult? Function(String userId, String month, String type,
            String? lastTransactionId, int? limit, String? searchQuery)?
        getAllTransactionsByType,
    TResult? Function(String userId, String month, String type,
            String lastTransactionId, int? limit, String? searchQuery)?
        loadMoreTransactions,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String userId, String month)? getTransactions,
    TResult Function(String userId, String month)? refreshTransactions,
    TResult Function(String userId, int saving, String month)? updateSaving,
    TResult Function(String transactionId, String month)? deleteTransaction,
    TResult Function(String userId, String month, String type,
            String? lastTransactionId, int? limit, String? searchQuery)?
        getAllTransactionsByType,
    TResult Function(String userId, String month, String type,
            String lastTransactionId, int? limit, String? searchQuery)?
        loadMoreTransactions,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_GetTransactions value) getTransactions,
    required TResult Function(_RefreshTransactions value) refreshTransactions,
    required TResult Function(_UpdateSaving value) updateSaving,
    required TResult Function(_DeleteTransaction value) deleteTransaction,
    required TResult Function(_GetAllTransactionsByType value)
        getAllTransactionsByType,
    required TResult Function(_LoadMoreTransactions value) loadMoreTransactions,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_GetTransactions value)? getTransactions,
    TResult? Function(_RefreshTransactions value)? refreshTransactions,
    TResult? Function(_UpdateSaving value)? updateSaving,
    TResult? Function(_DeleteTransaction value)? deleteTransaction,
    TResult? Function(_GetAllTransactionsByType value)?
        getAllTransactionsByType,
    TResult? Function(_LoadMoreTransactions value)? loadMoreTransactions,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_GetTransactions value)? getTransactions,
    TResult Function(_RefreshTransactions value)? refreshTransactions,
    TResult Function(_UpdateSaving value)? updateSaving,
    TResult Function(_DeleteTransaction value)? deleteTransaction,
    TResult Function(_GetAllTransactionsByType value)? getAllTransactionsByType,
    TResult Function(_LoadMoreTransactions value)? loadMoreTransactions,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionListEventCopyWith<$Res> {
  factory $TransactionListEventCopyWith(TransactionListEvent value,
          $Res Function(TransactionListEvent) then) =
      _$TransactionListEventCopyWithImpl<$Res, TransactionListEvent>;
}

/// @nodoc
class _$TransactionListEventCopyWithImpl<$Res,
        $Val extends TransactionListEvent>
    implements $TransactionListEventCopyWith<$Res> {
  _$TransactionListEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionListEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(
          _$StartedImpl value, $Res Function(_$StartedImpl) then) =
      __$$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res>
    extends _$TransactionListEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionListEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'TransactionListEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String userId, String month) getTransactions,
    required TResult Function(String userId, String month) refreshTransactions,
    required TResult Function(String userId, int saving, String month)
        updateSaving,
    required TResult Function(String transactionId, String month)
        deleteTransaction,
    required TResult Function(String userId, String month, String type,
            String? lastTransactionId, int? limit, String? searchQuery)
        getAllTransactionsByType,
    required TResult Function(String userId, String month, String type,
            String lastTransactionId, int? limit, String? searchQuery)
        loadMoreTransactions,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String userId, String month)? getTransactions,
    TResult? Function(String userId, String month)? refreshTransactions,
    TResult? Function(String userId, int saving, String month)? updateSaving,
    TResult? Function(String transactionId, String month)? deleteTransaction,
    TResult? Function(String userId, String month, String type,
            String? lastTransactionId, int? limit, String? searchQuery)?
        getAllTransactionsByType,
    TResult? Function(String userId, String month, String type,
            String lastTransactionId, int? limit, String? searchQuery)?
        loadMoreTransactions,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String userId, String month)? getTransactions,
    TResult Function(String userId, String month)? refreshTransactions,
    TResult Function(String userId, int saving, String month)? updateSaving,
    TResult Function(String transactionId, String month)? deleteTransaction,
    TResult Function(String userId, String month, String type,
            String? lastTransactionId, int? limit, String? searchQuery)?
        getAllTransactionsByType,
    TResult Function(String userId, String month, String type,
            String lastTransactionId, int? limit, String? searchQuery)?
        loadMoreTransactions,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_GetTransactions value) getTransactions,
    required TResult Function(_RefreshTransactions value) refreshTransactions,
    required TResult Function(_UpdateSaving value) updateSaving,
    required TResult Function(_DeleteTransaction value) deleteTransaction,
    required TResult Function(_GetAllTransactionsByType value)
        getAllTransactionsByType,
    required TResult Function(_LoadMoreTransactions value) loadMoreTransactions,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_GetTransactions value)? getTransactions,
    TResult? Function(_RefreshTransactions value)? refreshTransactions,
    TResult? Function(_UpdateSaving value)? updateSaving,
    TResult? Function(_DeleteTransaction value)? deleteTransaction,
    TResult? Function(_GetAllTransactionsByType value)?
        getAllTransactionsByType,
    TResult? Function(_LoadMoreTransactions value)? loadMoreTransactions,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_GetTransactions value)? getTransactions,
    TResult Function(_RefreshTransactions value)? refreshTransactions,
    TResult Function(_UpdateSaving value)? updateSaving,
    TResult Function(_DeleteTransaction value)? deleteTransaction,
    TResult Function(_GetAllTransactionsByType value)? getAllTransactionsByType,
    TResult Function(_LoadMoreTransactions value)? loadMoreTransactions,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements TransactionListEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$GetTransactionsImplCopyWith<$Res> {
  factory _$$GetTransactionsImplCopyWith(_$GetTransactionsImpl value,
          $Res Function(_$GetTransactionsImpl) then) =
      __$$GetTransactionsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId, String month});
}

/// @nodoc
class __$$GetTransactionsImplCopyWithImpl<$Res>
    extends _$TransactionListEventCopyWithImpl<$Res, _$GetTransactionsImpl>
    implements _$$GetTransactionsImplCopyWith<$Res> {
  __$$GetTransactionsImplCopyWithImpl(
      _$GetTransactionsImpl _value, $Res Function(_$GetTransactionsImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? month = null,
  }) {
    return _then(_$GetTransactionsImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GetTransactionsImpl implements _GetTransactions {
  const _$GetTransactionsImpl({required this.userId, required this.month});

  @override
  final String userId;
  @override
  final String month;

  @override
  String toString() {
    return 'TransactionListEvent.getTransactions(userId: $userId, month: $month)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetTransactionsImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.month, month) || other.month == month));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId, month);

  /// Create a copy of TransactionListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetTransactionsImplCopyWith<_$GetTransactionsImpl> get copyWith =>
      __$$GetTransactionsImplCopyWithImpl<_$GetTransactionsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String userId, String month) getTransactions,
    required TResult Function(String userId, String month) refreshTransactions,
    required TResult Function(String userId, int saving, String month)
        updateSaving,
    required TResult Function(String transactionId, String month)
        deleteTransaction,
    required TResult Function(String userId, String month, String type,
            String? lastTransactionId, int? limit, String? searchQuery)
        getAllTransactionsByType,
    required TResult Function(String userId, String month, String type,
            String lastTransactionId, int? limit, String? searchQuery)
        loadMoreTransactions,
  }) {
    return getTransactions(userId, month);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String userId, String month)? getTransactions,
    TResult? Function(String userId, String month)? refreshTransactions,
    TResult? Function(String userId, int saving, String month)? updateSaving,
    TResult? Function(String transactionId, String month)? deleteTransaction,
    TResult? Function(String userId, String month, String type,
            String? lastTransactionId, int? limit, String? searchQuery)?
        getAllTransactionsByType,
    TResult? Function(String userId, String month, String type,
            String lastTransactionId, int? limit, String? searchQuery)?
        loadMoreTransactions,
  }) {
    return getTransactions?.call(userId, month);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String userId, String month)? getTransactions,
    TResult Function(String userId, String month)? refreshTransactions,
    TResult Function(String userId, int saving, String month)? updateSaving,
    TResult Function(String transactionId, String month)? deleteTransaction,
    TResult Function(String userId, String month, String type,
            String? lastTransactionId, int? limit, String? searchQuery)?
        getAllTransactionsByType,
    TResult Function(String userId, String month, String type,
            String lastTransactionId, int? limit, String? searchQuery)?
        loadMoreTransactions,
    required TResult orElse(),
  }) {
    if (getTransactions != null) {
      return getTransactions(userId, month);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_GetTransactions value) getTransactions,
    required TResult Function(_RefreshTransactions value) refreshTransactions,
    required TResult Function(_UpdateSaving value) updateSaving,
    required TResult Function(_DeleteTransaction value) deleteTransaction,
    required TResult Function(_GetAllTransactionsByType value)
        getAllTransactionsByType,
    required TResult Function(_LoadMoreTransactions value) loadMoreTransactions,
  }) {
    return getTransactions(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_GetTransactions value)? getTransactions,
    TResult? Function(_RefreshTransactions value)? refreshTransactions,
    TResult? Function(_UpdateSaving value)? updateSaving,
    TResult? Function(_DeleteTransaction value)? deleteTransaction,
    TResult? Function(_GetAllTransactionsByType value)?
        getAllTransactionsByType,
    TResult? Function(_LoadMoreTransactions value)? loadMoreTransactions,
  }) {
    return getTransactions?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_GetTransactions value)? getTransactions,
    TResult Function(_RefreshTransactions value)? refreshTransactions,
    TResult Function(_UpdateSaving value)? updateSaving,
    TResult Function(_DeleteTransaction value)? deleteTransaction,
    TResult Function(_GetAllTransactionsByType value)? getAllTransactionsByType,
    TResult Function(_LoadMoreTransactions value)? loadMoreTransactions,
    required TResult orElse(),
  }) {
    if (getTransactions != null) {
      return getTransactions(this);
    }
    return orElse();
  }
}

abstract class _GetTransactions implements TransactionListEvent {
  const factory _GetTransactions(
      {required final String userId,
      required final String month}) = _$GetTransactionsImpl;

  String get userId;
  String get month;

  /// Create a copy of TransactionListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetTransactionsImplCopyWith<_$GetTransactionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RefreshTransactionsImplCopyWith<$Res> {
  factory _$$RefreshTransactionsImplCopyWith(_$RefreshTransactionsImpl value,
          $Res Function(_$RefreshTransactionsImpl) then) =
      __$$RefreshTransactionsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId, String month});
}

/// @nodoc
class __$$RefreshTransactionsImplCopyWithImpl<$Res>
    extends _$TransactionListEventCopyWithImpl<$Res, _$RefreshTransactionsImpl>
    implements _$$RefreshTransactionsImplCopyWith<$Res> {
  __$$RefreshTransactionsImplCopyWithImpl(_$RefreshTransactionsImpl _value,
      $Res Function(_$RefreshTransactionsImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? month = null,
  }) {
    return _then(_$RefreshTransactionsImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RefreshTransactionsImpl implements _RefreshTransactions {
  const _$RefreshTransactionsImpl({required this.userId, required this.month});

  @override
  final String userId;
  @override
  final String month;

  @override
  String toString() {
    return 'TransactionListEvent.refreshTransactions(userId: $userId, month: $month)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshTransactionsImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.month, month) || other.month == month));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId, month);

  /// Create a copy of TransactionListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RefreshTransactionsImplCopyWith<_$RefreshTransactionsImpl> get copyWith =>
      __$$RefreshTransactionsImplCopyWithImpl<_$RefreshTransactionsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String userId, String month) getTransactions,
    required TResult Function(String userId, String month) refreshTransactions,
    required TResult Function(String userId, int saving, String month)
        updateSaving,
    required TResult Function(String transactionId, String month)
        deleteTransaction,
    required TResult Function(String userId, String month, String type,
            String? lastTransactionId, int? limit, String? searchQuery)
        getAllTransactionsByType,
    required TResult Function(String userId, String month, String type,
            String lastTransactionId, int? limit, String? searchQuery)
        loadMoreTransactions,
  }) {
    return refreshTransactions(userId, month);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String userId, String month)? getTransactions,
    TResult? Function(String userId, String month)? refreshTransactions,
    TResult? Function(String userId, int saving, String month)? updateSaving,
    TResult? Function(String transactionId, String month)? deleteTransaction,
    TResult? Function(String userId, String month, String type,
            String? lastTransactionId, int? limit, String? searchQuery)?
        getAllTransactionsByType,
    TResult? Function(String userId, String month, String type,
            String lastTransactionId, int? limit, String? searchQuery)?
        loadMoreTransactions,
  }) {
    return refreshTransactions?.call(userId, month);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String userId, String month)? getTransactions,
    TResult Function(String userId, String month)? refreshTransactions,
    TResult Function(String userId, int saving, String month)? updateSaving,
    TResult Function(String transactionId, String month)? deleteTransaction,
    TResult Function(String userId, String month, String type,
            String? lastTransactionId, int? limit, String? searchQuery)?
        getAllTransactionsByType,
    TResult Function(String userId, String month, String type,
            String lastTransactionId, int? limit, String? searchQuery)?
        loadMoreTransactions,
    required TResult orElse(),
  }) {
    if (refreshTransactions != null) {
      return refreshTransactions(userId, month);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_GetTransactions value) getTransactions,
    required TResult Function(_RefreshTransactions value) refreshTransactions,
    required TResult Function(_UpdateSaving value) updateSaving,
    required TResult Function(_DeleteTransaction value) deleteTransaction,
    required TResult Function(_GetAllTransactionsByType value)
        getAllTransactionsByType,
    required TResult Function(_LoadMoreTransactions value) loadMoreTransactions,
  }) {
    return refreshTransactions(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_GetTransactions value)? getTransactions,
    TResult? Function(_RefreshTransactions value)? refreshTransactions,
    TResult? Function(_UpdateSaving value)? updateSaving,
    TResult? Function(_DeleteTransaction value)? deleteTransaction,
    TResult? Function(_GetAllTransactionsByType value)?
        getAllTransactionsByType,
    TResult? Function(_LoadMoreTransactions value)? loadMoreTransactions,
  }) {
    return refreshTransactions?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_GetTransactions value)? getTransactions,
    TResult Function(_RefreshTransactions value)? refreshTransactions,
    TResult Function(_UpdateSaving value)? updateSaving,
    TResult Function(_DeleteTransaction value)? deleteTransaction,
    TResult Function(_GetAllTransactionsByType value)? getAllTransactionsByType,
    TResult Function(_LoadMoreTransactions value)? loadMoreTransactions,
    required TResult orElse(),
  }) {
    if (refreshTransactions != null) {
      return refreshTransactions(this);
    }
    return orElse();
  }
}

abstract class _RefreshTransactions implements TransactionListEvent {
  const factory _RefreshTransactions(
      {required final String userId,
      required final String month}) = _$RefreshTransactionsImpl;

  String get userId;
  String get month;

  /// Create a copy of TransactionListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RefreshTransactionsImplCopyWith<_$RefreshTransactionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateSavingImplCopyWith<$Res> {
  factory _$$UpdateSavingImplCopyWith(
          _$UpdateSavingImpl value, $Res Function(_$UpdateSavingImpl) then) =
      __$$UpdateSavingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String userId, int saving, String month});
}

/// @nodoc
class __$$UpdateSavingImplCopyWithImpl<$Res>
    extends _$TransactionListEventCopyWithImpl<$Res, _$UpdateSavingImpl>
    implements _$$UpdateSavingImplCopyWith<$Res> {
  __$$UpdateSavingImplCopyWithImpl(
      _$UpdateSavingImpl _value, $Res Function(_$UpdateSavingImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? saving = null,
    Object? month = null,
  }) {
    return _then(_$UpdateSavingImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      saving: null == saving
          ? _value.saving
          : saving // ignore: cast_nullable_to_non_nullable
              as int,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UpdateSavingImpl implements _UpdateSaving {
  const _$UpdateSavingImpl(
      {required this.userId, required this.saving, required this.month});

  @override
  final String userId;
  @override
  final int saving;
  @override
  final String month;

  @override
  String toString() {
    return 'TransactionListEvent.updateSaving(userId: $userId, saving: $saving, month: $month)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateSavingImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.saving, saving) || other.saving == saving) &&
            (identical(other.month, month) || other.month == month));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userId, saving, month);

  /// Create a copy of TransactionListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateSavingImplCopyWith<_$UpdateSavingImpl> get copyWith =>
      __$$UpdateSavingImplCopyWithImpl<_$UpdateSavingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String userId, String month) getTransactions,
    required TResult Function(String userId, String month) refreshTransactions,
    required TResult Function(String userId, int saving, String month)
        updateSaving,
    required TResult Function(String transactionId, String month)
        deleteTransaction,
    required TResult Function(String userId, String month, String type,
            String? lastTransactionId, int? limit, String? searchQuery)
        getAllTransactionsByType,
    required TResult Function(String userId, String month, String type,
            String lastTransactionId, int? limit, String? searchQuery)
        loadMoreTransactions,
  }) {
    return updateSaving(userId, saving, month);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String userId, String month)? getTransactions,
    TResult? Function(String userId, String month)? refreshTransactions,
    TResult? Function(String userId, int saving, String month)? updateSaving,
    TResult? Function(String transactionId, String month)? deleteTransaction,
    TResult? Function(String userId, String month, String type,
            String? lastTransactionId, int? limit, String? searchQuery)?
        getAllTransactionsByType,
    TResult? Function(String userId, String month, String type,
            String lastTransactionId, int? limit, String? searchQuery)?
        loadMoreTransactions,
  }) {
    return updateSaving?.call(userId, saving, month);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String userId, String month)? getTransactions,
    TResult Function(String userId, String month)? refreshTransactions,
    TResult Function(String userId, int saving, String month)? updateSaving,
    TResult Function(String transactionId, String month)? deleteTransaction,
    TResult Function(String userId, String month, String type,
            String? lastTransactionId, int? limit, String? searchQuery)?
        getAllTransactionsByType,
    TResult Function(String userId, String month, String type,
            String lastTransactionId, int? limit, String? searchQuery)?
        loadMoreTransactions,
    required TResult orElse(),
  }) {
    if (updateSaving != null) {
      return updateSaving(userId, saving, month);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_GetTransactions value) getTransactions,
    required TResult Function(_RefreshTransactions value) refreshTransactions,
    required TResult Function(_UpdateSaving value) updateSaving,
    required TResult Function(_DeleteTransaction value) deleteTransaction,
    required TResult Function(_GetAllTransactionsByType value)
        getAllTransactionsByType,
    required TResult Function(_LoadMoreTransactions value) loadMoreTransactions,
  }) {
    return updateSaving(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_GetTransactions value)? getTransactions,
    TResult? Function(_RefreshTransactions value)? refreshTransactions,
    TResult? Function(_UpdateSaving value)? updateSaving,
    TResult? Function(_DeleteTransaction value)? deleteTransaction,
    TResult? Function(_GetAllTransactionsByType value)?
        getAllTransactionsByType,
    TResult? Function(_LoadMoreTransactions value)? loadMoreTransactions,
  }) {
    return updateSaving?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_GetTransactions value)? getTransactions,
    TResult Function(_RefreshTransactions value)? refreshTransactions,
    TResult Function(_UpdateSaving value)? updateSaving,
    TResult Function(_DeleteTransaction value)? deleteTransaction,
    TResult Function(_GetAllTransactionsByType value)? getAllTransactionsByType,
    TResult Function(_LoadMoreTransactions value)? loadMoreTransactions,
    required TResult orElse(),
  }) {
    if (updateSaving != null) {
      return updateSaving(this);
    }
    return orElse();
  }
}

abstract class _UpdateSaving implements TransactionListEvent {
  const factory _UpdateSaving(
      {required final String userId,
      required final int saving,
      required final String month}) = _$UpdateSavingImpl;

  String get userId;
  int get saving;
  String get month;

  /// Create a copy of TransactionListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateSavingImplCopyWith<_$UpdateSavingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteTransactionImplCopyWith<$Res> {
  factory _$$DeleteTransactionImplCopyWith(_$DeleteTransactionImpl value,
          $Res Function(_$DeleteTransactionImpl) then) =
      __$$DeleteTransactionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String transactionId, String month});
}

/// @nodoc
class __$$DeleteTransactionImplCopyWithImpl<$Res>
    extends _$TransactionListEventCopyWithImpl<$Res, _$DeleteTransactionImpl>
    implements _$$DeleteTransactionImplCopyWith<$Res> {
  __$$DeleteTransactionImplCopyWithImpl(_$DeleteTransactionImpl _value,
      $Res Function(_$DeleteTransactionImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionId = null,
    Object? month = null,
  }) {
    return _then(_$DeleteTransactionImpl(
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$DeleteTransactionImpl implements _DeleteTransaction {
  const _$DeleteTransactionImpl(
      {required this.transactionId, required this.month});

  @override
  final String transactionId;
  @override
  final String month;

  @override
  String toString() {
    return 'TransactionListEvent.deleteTransaction(transactionId: $transactionId, month: $month)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteTransactionImpl &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.month, month) || other.month == month));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transactionId, month);

  /// Create a copy of TransactionListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteTransactionImplCopyWith<_$DeleteTransactionImpl> get copyWith =>
      __$$DeleteTransactionImplCopyWithImpl<_$DeleteTransactionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String userId, String month) getTransactions,
    required TResult Function(String userId, String month) refreshTransactions,
    required TResult Function(String userId, int saving, String month)
        updateSaving,
    required TResult Function(String transactionId, String month)
        deleteTransaction,
    required TResult Function(String userId, String month, String type,
            String? lastTransactionId, int? limit, String? searchQuery)
        getAllTransactionsByType,
    required TResult Function(String userId, String month, String type,
            String lastTransactionId, int? limit, String? searchQuery)
        loadMoreTransactions,
  }) {
    return deleteTransaction(transactionId, month);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String userId, String month)? getTransactions,
    TResult? Function(String userId, String month)? refreshTransactions,
    TResult? Function(String userId, int saving, String month)? updateSaving,
    TResult? Function(String transactionId, String month)? deleteTransaction,
    TResult? Function(String userId, String month, String type,
            String? lastTransactionId, int? limit, String? searchQuery)?
        getAllTransactionsByType,
    TResult? Function(String userId, String month, String type,
            String lastTransactionId, int? limit, String? searchQuery)?
        loadMoreTransactions,
  }) {
    return deleteTransaction?.call(transactionId, month);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String userId, String month)? getTransactions,
    TResult Function(String userId, String month)? refreshTransactions,
    TResult Function(String userId, int saving, String month)? updateSaving,
    TResult Function(String transactionId, String month)? deleteTransaction,
    TResult Function(String userId, String month, String type,
            String? lastTransactionId, int? limit, String? searchQuery)?
        getAllTransactionsByType,
    TResult Function(String userId, String month, String type,
            String lastTransactionId, int? limit, String? searchQuery)?
        loadMoreTransactions,
    required TResult orElse(),
  }) {
    if (deleteTransaction != null) {
      return deleteTransaction(transactionId, month);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_GetTransactions value) getTransactions,
    required TResult Function(_RefreshTransactions value) refreshTransactions,
    required TResult Function(_UpdateSaving value) updateSaving,
    required TResult Function(_DeleteTransaction value) deleteTransaction,
    required TResult Function(_GetAllTransactionsByType value)
        getAllTransactionsByType,
    required TResult Function(_LoadMoreTransactions value) loadMoreTransactions,
  }) {
    return deleteTransaction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_GetTransactions value)? getTransactions,
    TResult? Function(_RefreshTransactions value)? refreshTransactions,
    TResult? Function(_UpdateSaving value)? updateSaving,
    TResult? Function(_DeleteTransaction value)? deleteTransaction,
    TResult? Function(_GetAllTransactionsByType value)?
        getAllTransactionsByType,
    TResult? Function(_LoadMoreTransactions value)? loadMoreTransactions,
  }) {
    return deleteTransaction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_GetTransactions value)? getTransactions,
    TResult Function(_RefreshTransactions value)? refreshTransactions,
    TResult Function(_UpdateSaving value)? updateSaving,
    TResult Function(_DeleteTransaction value)? deleteTransaction,
    TResult Function(_GetAllTransactionsByType value)? getAllTransactionsByType,
    TResult Function(_LoadMoreTransactions value)? loadMoreTransactions,
    required TResult orElse(),
  }) {
    if (deleteTransaction != null) {
      return deleteTransaction(this);
    }
    return orElse();
  }
}

abstract class _DeleteTransaction implements TransactionListEvent {
  const factory _DeleteTransaction(
      {required final String transactionId,
      required final String month}) = _$DeleteTransactionImpl;

  String get transactionId;
  String get month;

  /// Create a copy of TransactionListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteTransactionImplCopyWith<_$DeleteTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GetAllTransactionsByTypeImplCopyWith<$Res> {
  factory _$$GetAllTransactionsByTypeImplCopyWith(
          _$GetAllTransactionsByTypeImpl value,
          $Res Function(_$GetAllTransactionsByTypeImpl) then) =
      __$$GetAllTransactionsByTypeImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String userId,
      String month,
      String type,
      String? lastTransactionId,
      int? limit,
      String? searchQuery});
}

/// @nodoc
class __$$GetAllTransactionsByTypeImplCopyWithImpl<$Res>
    extends _$TransactionListEventCopyWithImpl<$Res,
        _$GetAllTransactionsByTypeImpl>
    implements _$$GetAllTransactionsByTypeImplCopyWith<$Res> {
  __$$GetAllTransactionsByTypeImplCopyWithImpl(
      _$GetAllTransactionsByTypeImpl _value,
      $Res Function(_$GetAllTransactionsByTypeImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? month = null,
    Object? type = null,
    Object? lastTransactionId = freezed,
    Object? limit = freezed,
    Object? searchQuery = freezed,
  }) {
    return _then(_$GetAllTransactionsByTypeImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      lastTransactionId: freezed == lastTransactionId
          ? _value.lastTransactionId
          : lastTransactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      limit: freezed == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$GetAllTransactionsByTypeImpl implements _GetAllTransactionsByType {
  const _$GetAllTransactionsByTypeImpl(
      {required this.userId,
      required this.month,
      required this.type,
      this.lastTransactionId,
      this.limit,
      this.searchQuery});

  @override
  final String userId;
  @override
  final String month;
  @override
  final String type;
  @override
  final String? lastTransactionId;
  @override
  final int? limit;
  @override
  final String? searchQuery;

  @override
  String toString() {
    return 'TransactionListEvent.getAllTransactionsByType(userId: $userId, month: $month, type: $type, lastTransactionId: $lastTransactionId, limit: $limit, searchQuery: $searchQuery)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GetAllTransactionsByTypeImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.lastTransactionId, lastTransactionId) ||
                other.lastTransactionId == lastTransactionId) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, userId, month, type, lastTransactionId, limit, searchQuery);

  /// Create a copy of TransactionListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GetAllTransactionsByTypeImplCopyWith<_$GetAllTransactionsByTypeImpl>
      get copyWith => __$$GetAllTransactionsByTypeImplCopyWithImpl<
          _$GetAllTransactionsByTypeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String userId, String month) getTransactions,
    required TResult Function(String userId, String month) refreshTransactions,
    required TResult Function(String userId, int saving, String month)
        updateSaving,
    required TResult Function(String transactionId, String month)
        deleteTransaction,
    required TResult Function(String userId, String month, String type,
            String? lastTransactionId, int? limit, String? searchQuery)
        getAllTransactionsByType,
    required TResult Function(String userId, String month, String type,
            String lastTransactionId, int? limit, String? searchQuery)
        loadMoreTransactions,
  }) {
    return getAllTransactionsByType(
        userId, month, type, lastTransactionId, limit, searchQuery);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String userId, String month)? getTransactions,
    TResult? Function(String userId, String month)? refreshTransactions,
    TResult? Function(String userId, int saving, String month)? updateSaving,
    TResult? Function(String transactionId, String month)? deleteTransaction,
    TResult? Function(String userId, String month, String type,
            String? lastTransactionId, int? limit, String? searchQuery)?
        getAllTransactionsByType,
    TResult? Function(String userId, String month, String type,
            String lastTransactionId, int? limit, String? searchQuery)?
        loadMoreTransactions,
  }) {
    return getAllTransactionsByType?.call(
        userId, month, type, lastTransactionId, limit, searchQuery);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String userId, String month)? getTransactions,
    TResult Function(String userId, String month)? refreshTransactions,
    TResult Function(String userId, int saving, String month)? updateSaving,
    TResult Function(String transactionId, String month)? deleteTransaction,
    TResult Function(String userId, String month, String type,
            String? lastTransactionId, int? limit, String? searchQuery)?
        getAllTransactionsByType,
    TResult Function(String userId, String month, String type,
            String lastTransactionId, int? limit, String? searchQuery)?
        loadMoreTransactions,
    required TResult orElse(),
  }) {
    if (getAllTransactionsByType != null) {
      return getAllTransactionsByType(
          userId, month, type, lastTransactionId, limit, searchQuery);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_GetTransactions value) getTransactions,
    required TResult Function(_RefreshTransactions value) refreshTransactions,
    required TResult Function(_UpdateSaving value) updateSaving,
    required TResult Function(_DeleteTransaction value) deleteTransaction,
    required TResult Function(_GetAllTransactionsByType value)
        getAllTransactionsByType,
    required TResult Function(_LoadMoreTransactions value) loadMoreTransactions,
  }) {
    return getAllTransactionsByType(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_GetTransactions value)? getTransactions,
    TResult? Function(_RefreshTransactions value)? refreshTransactions,
    TResult? Function(_UpdateSaving value)? updateSaving,
    TResult? Function(_DeleteTransaction value)? deleteTransaction,
    TResult? Function(_GetAllTransactionsByType value)?
        getAllTransactionsByType,
    TResult? Function(_LoadMoreTransactions value)? loadMoreTransactions,
  }) {
    return getAllTransactionsByType?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_GetTransactions value)? getTransactions,
    TResult Function(_RefreshTransactions value)? refreshTransactions,
    TResult Function(_UpdateSaving value)? updateSaving,
    TResult Function(_DeleteTransaction value)? deleteTransaction,
    TResult Function(_GetAllTransactionsByType value)? getAllTransactionsByType,
    TResult Function(_LoadMoreTransactions value)? loadMoreTransactions,
    required TResult orElse(),
  }) {
    if (getAllTransactionsByType != null) {
      return getAllTransactionsByType(this);
    }
    return orElse();
  }
}

abstract class _GetAllTransactionsByType implements TransactionListEvent {
  const factory _GetAllTransactionsByType(
      {required final String userId,
      required final String month,
      required final String type,
      final String? lastTransactionId,
      final int? limit,
      final String? searchQuery}) = _$GetAllTransactionsByTypeImpl;

  String get userId;
  String get month;
  String get type;
  String? get lastTransactionId;
  int? get limit;
  String? get searchQuery;

  /// Create a copy of TransactionListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GetAllTransactionsByTypeImplCopyWith<_$GetAllTransactionsByTypeImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadMoreTransactionsImplCopyWith<$Res> {
  factory _$$LoadMoreTransactionsImplCopyWith(_$LoadMoreTransactionsImpl value,
          $Res Function(_$LoadMoreTransactionsImpl) then) =
      __$$LoadMoreTransactionsImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {String userId,
      String month,
      String type,
      String lastTransactionId,
      int? limit,
      String? searchQuery});
}

/// @nodoc
class __$$LoadMoreTransactionsImplCopyWithImpl<$Res>
    extends _$TransactionListEventCopyWithImpl<$Res, _$LoadMoreTransactionsImpl>
    implements _$$LoadMoreTransactionsImplCopyWith<$Res> {
  __$$LoadMoreTransactionsImplCopyWithImpl(_$LoadMoreTransactionsImpl _value,
      $Res Function(_$LoadMoreTransactionsImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionListEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? month = null,
    Object? type = null,
    Object? lastTransactionId = null,
    Object? limit = freezed,
    Object? searchQuery = freezed,
  }) {
    return _then(_$LoadMoreTransactionsImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      lastTransactionId: null == lastTransactionId
          ? _value.lastTransactionId
          : lastTransactionId // ignore: cast_nullable_to_non_nullable
              as String,
      limit: freezed == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int?,
      searchQuery: freezed == searchQuery
          ? _value.searchQuery
          : searchQuery // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LoadMoreTransactionsImpl implements _LoadMoreTransactions {
  const _$LoadMoreTransactionsImpl(
      {required this.userId,
      required this.month,
      required this.type,
      required this.lastTransactionId,
      this.limit,
      this.searchQuery});

  @override
  final String userId;
  @override
  final String month;
  @override
  final String type;
  @override
  final String lastTransactionId;
  @override
  final int? limit;
  @override
  final String? searchQuery;

  @override
  String toString() {
    return 'TransactionListEvent.loadMoreTransactions(userId: $userId, month: $month, type: $type, lastTransactionId: $lastTransactionId, limit: $limit, searchQuery: $searchQuery)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadMoreTransactionsImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.lastTransactionId, lastTransactionId) ||
                other.lastTransactionId == lastTransactionId) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, userId, month, type, lastTransactionId, limit, searchQuery);

  /// Create a copy of TransactionListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadMoreTransactionsImplCopyWith<_$LoadMoreTransactionsImpl>
      get copyWith =>
          __$$LoadMoreTransactionsImplCopyWithImpl<_$LoadMoreTransactionsImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String userId, String month) getTransactions,
    required TResult Function(String userId, String month) refreshTransactions,
    required TResult Function(String userId, int saving, String month)
        updateSaving,
    required TResult Function(String transactionId, String month)
        deleteTransaction,
    required TResult Function(String userId, String month, String type,
            String? lastTransactionId, int? limit, String? searchQuery)
        getAllTransactionsByType,
    required TResult Function(String userId, String month, String type,
            String lastTransactionId, int? limit, String? searchQuery)
        loadMoreTransactions,
  }) {
    return loadMoreTransactions(
        userId, month, type, lastTransactionId, limit, searchQuery);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String userId, String month)? getTransactions,
    TResult? Function(String userId, String month)? refreshTransactions,
    TResult? Function(String userId, int saving, String month)? updateSaving,
    TResult? Function(String transactionId, String month)? deleteTransaction,
    TResult? Function(String userId, String month, String type,
            String? lastTransactionId, int? limit, String? searchQuery)?
        getAllTransactionsByType,
    TResult? Function(String userId, String month, String type,
            String lastTransactionId, int? limit, String? searchQuery)?
        loadMoreTransactions,
  }) {
    return loadMoreTransactions?.call(
        userId, month, type, lastTransactionId, limit, searchQuery);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String userId, String month)? getTransactions,
    TResult Function(String userId, String month)? refreshTransactions,
    TResult Function(String userId, int saving, String month)? updateSaving,
    TResult Function(String transactionId, String month)? deleteTransaction,
    TResult Function(String userId, String month, String type,
            String? lastTransactionId, int? limit, String? searchQuery)?
        getAllTransactionsByType,
    TResult Function(String userId, String month, String type,
            String lastTransactionId, int? limit, String? searchQuery)?
        loadMoreTransactions,
    required TResult orElse(),
  }) {
    if (loadMoreTransactions != null) {
      return loadMoreTransactions(
          userId, month, type, lastTransactionId, limit, searchQuery);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_GetTransactions value) getTransactions,
    required TResult Function(_RefreshTransactions value) refreshTransactions,
    required TResult Function(_UpdateSaving value) updateSaving,
    required TResult Function(_DeleteTransaction value) deleteTransaction,
    required TResult Function(_GetAllTransactionsByType value)
        getAllTransactionsByType,
    required TResult Function(_LoadMoreTransactions value) loadMoreTransactions,
  }) {
    return loadMoreTransactions(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_GetTransactions value)? getTransactions,
    TResult? Function(_RefreshTransactions value)? refreshTransactions,
    TResult? Function(_UpdateSaving value)? updateSaving,
    TResult? Function(_DeleteTransaction value)? deleteTransaction,
    TResult? Function(_GetAllTransactionsByType value)?
        getAllTransactionsByType,
    TResult? Function(_LoadMoreTransactions value)? loadMoreTransactions,
  }) {
    return loadMoreTransactions?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_GetTransactions value)? getTransactions,
    TResult Function(_RefreshTransactions value)? refreshTransactions,
    TResult Function(_UpdateSaving value)? updateSaving,
    TResult Function(_DeleteTransaction value)? deleteTransaction,
    TResult Function(_GetAllTransactionsByType value)? getAllTransactionsByType,
    TResult Function(_LoadMoreTransactions value)? loadMoreTransactions,
    required TResult orElse(),
  }) {
    if (loadMoreTransactions != null) {
      return loadMoreTransactions(this);
    }
    return orElse();
  }
}

abstract class _LoadMoreTransactions implements TransactionListEvent {
  const factory _LoadMoreTransactions(
      {required final String userId,
      required final String month,
      required final String type,
      required final String lastTransactionId,
      final int? limit,
      final String? searchQuery}) = _$LoadMoreTransactionsImpl;

  String get userId;
  String get month;
  String get type;
  String get lastTransactionId;
  int? get limit;
  String? get searchQuery;

  /// Create a copy of TransactionListEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadMoreTransactionsImplCopyWith<_$LoadMoreTransactionsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TransactionListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(TransactionListResponseModel data) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function(TransactionListResponseModel data)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(TransactionListResponseModel data)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
    required TResult Function(_Loaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Error value)? error,
    TResult? Function(_Loaded value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionListStateCopyWith<$Res> {
  factory $TransactionListStateCopyWith(TransactionListState value,
          $Res Function(TransactionListState) then) =
      _$TransactionListStateCopyWithImpl<$Res, TransactionListState>;
}

/// @nodoc
class _$TransactionListStateCopyWithImpl<$Res,
        $Val extends TransactionListState>
    implements $TransactionListStateCopyWith<$Res> {
  _$TransactionListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$TransactionListStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'TransactionListState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(TransactionListResponseModel data) loaded,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function(TransactionListResponseModel data)? loaded,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(TransactionListResponseModel data)? loaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
    required TResult Function(_Loaded value) loaded,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Error value)? error,
    TResult? Function(_Loaded value)? loaded,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements TransactionListState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$TransactionListStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'TransactionListState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(TransactionListResponseModel data) loaded,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function(TransactionListResponseModel data)? loaded,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(TransactionListResponseModel data)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
    required TResult Function(_Loaded value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Error value)? error,
    TResult? Function(_Loaded value)? loaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements TransactionListState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$TransactionListStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'TransactionListState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of TransactionListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(TransactionListResponseModel data) loaded,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function(TransactionListResponseModel data)? loaded,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(TransactionListResponseModel data)? loaded,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
    required TResult Function(_Loaded value) loaded,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Error value)? error,
    TResult? Function(_Loaded value)? loaded,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements TransactionListState {
  const factory _Error(final String message) = _$ErrorImpl;

  String get message;

  /// Create a copy of TransactionListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({TransactionListResponseModel data});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$TransactionListStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$LoadedImpl(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as TransactionListResponseModel,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(this.data);

  @override
  final TransactionListResponseModel data;

  @override
  String toString() {
    return 'TransactionListState.loaded(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of TransactionListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(TransactionListResponseModel data) loaded,
  }) {
    return loaded(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String message)? error,
    TResult? Function(TransactionListResponseModel data)? loaded,
  }) {
    return loaded?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(TransactionListResponseModel data)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Error value) error,
    required TResult Function(_Loaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Error value)? error,
    TResult? Function(_Loaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Error value)? error,
    TResult Function(_Loaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements TransactionListState {
  const factory _Loaded(final TransactionListResponseModel data) = _$LoadedImpl;

  TransactionListResponseModel get data;

  /// Create a copy of TransactionListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
