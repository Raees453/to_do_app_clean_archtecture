import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/src/auth/data/datasources/auth_repo_remote_datasource.dart';
import 'package:to_do_app/src/auth/data/repos/auth_repo_impl.dart';
import 'package:to_do_app/src/home/data/datasources/tasks_datasource.dart';
import 'package:to_do_app/src/home/data/repos/tasks_repo.dart';

final instance = GetIt.instance;

class DependencyInjectionEnv {
  const DependencyInjectionEnv._();

  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();

    instance
      ..registerLazySingleton<SharedPreferences>(() => prefs)
      ..registerLazySingleton<AuthRepoRemoteDataSrcImpl>(
          () => AuthRepoRemoteDataSrcImpl(instance<FirebaseFirestore>(), instance<FirebaseAuth>()))
      ..registerLazySingleton<AuthRepoImpl>(
          () => AuthRepoImpl(instance<AuthRepoRemoteDataSrcImpl>()))
      ..registerLazySingleton<TasksRepoImpl>(
          () => TasksRepoImpl(instance<TasksRepoRemoteDataSrcImpl>()))
      ..registerLazySingleton<TasksRepoRemoteDataSrcImpl>(
          () => TasksRepoRemoteDataSrcImpl(instance<FirebaseFirestore>()))
      ..registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance)
      ..registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  }
}
