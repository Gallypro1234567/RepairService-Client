part of 'servicebloc_bloc.dart';

abstract class ServiceblocState extends Equatable {
  const ServiceblocState();
  
  @override
  List<Object> get props => [];
}

class ServiceblocInitial extends ServiceblocState {}
