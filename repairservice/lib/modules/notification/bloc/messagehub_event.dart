part of 'messagehub_bloc.dart';

abstract class MessagehubEvent extends Equatable {
  const MessagehubEvent();

  @override
  List<Object> get props => [];
}
class MessagehubInitial extends MessagehubEvent{}
class MessagehubFetched extends MessagehubEvent{}