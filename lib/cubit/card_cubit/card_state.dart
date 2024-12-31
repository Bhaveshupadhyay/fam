abstract class CardsState{}

class CardsInitial extends CardsState{}

class CardsLoaded<T> extends CardsState{
  final T data;
  final bool? isAppReloaded;

  CardsLoaded({required this.data,this.isAppReloaded,});
}

class CardsNotAvailable extends CardsState{

}