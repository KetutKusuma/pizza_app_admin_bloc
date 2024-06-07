// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pizza_repository/pizza_repository.dart';

part 'create_pizza_event.dart';
part 'create_pizza_state.dart';

class CreatePizzaBloc extends Bloc<CreatePizzaEvent, CreatePizzaState> {
  final PizzaRepo pizzaRepo;
  CreatePizzaBloc(
    this.pizzaRepo,
  ) : super(CreatePizzaInitial()) {
    on<CreatePizza>((event, emit) async {
      emit(CreatePizzaProcess());
      try {
        await pizzaRepo.createPizza(event.pizza);
        emit(CreatePizzaSuccess());
      } catch (e) {
        emit(CreatePizzaFailure());
      }
    });
  }
}
