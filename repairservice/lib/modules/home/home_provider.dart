import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:repairservice/modules/home/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:repairservice/modules/manager/models/event_model.dart'; 

import 'bloc/home_bloc.dart';
class HomeProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>  HomeBloc(http.Client())..add(HomeFetched()),
      child: HomeScreen(),
    );
  }
}