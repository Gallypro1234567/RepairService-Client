import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:repairservice/modules/home/home_screen.dart'; 
import 'package:repairservice/repository/home_repository/home_repository.dart'; 

import 'bloc/home_bloc.dart';
class HomeProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>  HomeBloc(
         homeRepository: HomeRepository(), 
       )..add(HomeFetched()),
      child: HomePage(),
    );
  }
}