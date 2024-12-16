abstract class CardsState{}

class CardsInitial extends CardsState{}

class CardsLoaded<T> extends CardsState{
  final T data;

  CardsLoaded({required this.data});
}

class CardsNotAvailable extends CardsState{

}