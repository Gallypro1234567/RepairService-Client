part of 'messagehub_bloc.dart';

class MessagehubState extends Equatable {
  const MessagehubState({this.message});
  final String message;
  @override
  List<Object> get props => [message];

  MessagehubState copyWith({
    String message,
  }) {
    return MessagehubState(
      message: message ?? this.message,
    );
  }
}
