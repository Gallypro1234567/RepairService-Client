 
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';  
import 'package:repairservice/repository/authentication_repository.dart';
import 'package:repairservice/repository/user_repository/user_repository.dart';
import 'package:repairservice/simple_bloc_observer.dart'; 
import 'app.dart';

void main() {
   EquatableConfig.stringify = kDebugMode;
   Bloc.observer = SimpleBlocObserver();
  runApp(MyApp(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  ));
}
