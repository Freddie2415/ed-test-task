part of 'cache_cubit.dart';

@immutable
abstract class CacheState {}

class CacheInitial extends CacheState {}

class CacheLoading extends CacheState {}

class CacheReady extends CacheState {}

class CacheFailure extends CacheState {
  final String message;

  CacheFailure(this.message);
}
