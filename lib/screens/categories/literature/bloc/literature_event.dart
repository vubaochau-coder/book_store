part of 'literature_bloc.dart';

abstract class LiteratureEvent extends Equatable {
  const LiteratureEvent();

  @override
  List<Object> get props => [];
}

class LiteratureLoadEvent extends LiteratureEvent {
  final int options;

  const LiteratureLoadEvent({required this.options});
}
