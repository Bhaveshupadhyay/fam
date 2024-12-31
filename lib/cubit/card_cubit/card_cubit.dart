import 'dart:convert';

import 'package:fampay/cubit/card_cubit/card_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveCardCubit extends Cubit<CardsState>{
  SaveCardCubit() : super(CardsInitial());

  bool _isAppReloaded=true;

  static const String keySavedCards="savedCards";

  Future<void> loadSavedCards() async {
    final prefs= await SharedPreferences.getInstance();
    String data=prefs.getString(SaveCardCubit.keySavedCards)??"";
    final savedCards=data.isNotEmpty? jsonDecode(data) : <String,dynamic>{};
    emit(CardsLoaded<Map<String,dynamic>>(data: savedCards,isAppReloaded: _isAppReloaded));
    _isAppReloaded=false;
  }

  Future<void> saveCard({required int cardId, bool? isDismiss, bool? isRemind, bool? isReminded}) async {
    final prefs= await SharedPreferences.getInstance();

    String data=prefs.getString(SaveCardCubit.keySavedCards)??"";
    Map<String,dynamic> savedCards=data.isNotEmpty? jsonDecode(data) : <String,dynamic>{};
    final card= savedCards.containsKey(cardId.toString())? savedCards[cardId.toString()] : {};
    card["isDismiss"]=isDismiss??false;
    card["isRemind"]=isRemind??false;
    card["isShowed"]=isReminded??false;

    savedCards[cardId.toString()]=card;

    prefs.setString(SaveCardCubit.keySavedCards, jsonEncode(savedCards));
    emit(CardsLoaded<Map<String,dynamic>>(data: savedCards,isAppReloaded: _isAppReloaded));
    _isAppReloaded=false;
  }


}