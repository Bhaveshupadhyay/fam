import 'package:fampay/constants/card_design_type.dart';
import 'package:fampay/cubit/card_cubit/card_cubit.dart';
import 'package:fampay/cubit/card_cubit/card_state.dart';
import 'package:fampay/cubit/data_cubit/data_cubit.dart';
import 'package:fampay/cubit/data_cubit/data_state.dart';
import 'package:fampay/models/card_group.dart';
import 'package:fampay/widgets/card_widget/card_hc1.dart';
import 'package:fampay/widgets/card_widget/card_hc3.dart';
import 'package:fampay/widgets/card_widget/card_hc5.dart';
import 'package:fampay/widgets/card_widget/card_hc9.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/famx_page.dart';
import '../widgets/card_widget/card_hc6.dart';
import '../widgets/loading.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return context.read<DataCubit>().loadData();
      },
      child: BlocBuilder<DataCubit,DataState>(
        builder: (BuildContext context, DataState state) {
          if(state is DataLoading){
            return const Loading();
          }
          else if(state is DataLoaded<List<FamxPayPage>>){
            FamxPayPage famxPayPage= state.data[0];

            return SingleChildScrollView(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF7F6F3),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)
                  ),
                ),
                child: Column(
                  children: [
                    for(CardGroup cardGroup in famxPayPage.hcGroups)
                      if(cardGroup.designType.toUpperCase() == CardDesignType.hc3)
                        _hc3(context, cardGroup)
                      else if(cardGroup.designType.toUpperCase() == CardDesignType.hc6)
                        _hc6(context, cardGroup)
                      else if(cardGroup.designType.toUpperCase() == CardDesignType.hc5)
                        _hc5(context, cardGroup)
                        else if(cardGroup.designType.toUpperCase() == CardDesignType.hc9)
                          _hc9(context, cardGroup)
                          else if(cardGroup.designType.toUpperCase() == CardDesignType.hc1)
                            _hc1(context, cardGroup),


                    const SizedBox(height: 30,),
                  ],
                ),
              ),
            );
          }
          else if(state is DataFailed){
            return Center(
              child: Text(state.errorMsg,
                style: Theme.of(context).textTheme.titleSmall?.
                copyWith(
                  color: Colors.black,
                  fontSize: 20
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }


  Widget _hc3(BuildContext context, CardGroup cardGroup){
    bool? isAppReloaded;
    if(cardGroup.cards.isEmpty) return Container();

    return BlocBuilder<SaveCardCubit,CardsState>(
      builder: (BuildContext context, CardsState state) {
        if(state is CardsLoaded<Map<String,dynamic>>){
          isAppReloaded= isAppReloaded==null? true : false;
          return cardGroup.isScrollable?
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(cardGroup.cards.length, (index){
                      if(state.data.containsKey(cardGroup.cards[index].id.toString())){
                        var data=state.data[cardGroup.cards[index].id.toString()];

                        if(data['isDismiss']
                            || (data['isRemind'] && isAppReloaded==false ) ) {
                          return Container();
                        }
                      }
                      return Padding(
                        padding: EdgeInsets.only(left: index==0? 20 : 0,right: 20,),
                        child: CardHC3(card: cardGroup.cards[index],width: MediaQuery.sizeOf(context).width * 0.8,),
                      );
                    })
                  ],
                ),
              )
          )
              :
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            child: state.data.containsKey(cardGroup.cards[0].id.toString()) &&
                (state.data[cardGroup.cards[0].id.toString()]['isDismiss'] ||
                (state.data[cardGroup.cards[0].id.toString()]['isRemind'] && isAppReloaded==false))?
                // checking if the card is dismissed or the card is in remind and if the app is not reloaded
             Container(): CardHC3(card: cardGroup.cards[0]),
          );
        }
        return Container();
      },

    );
  }

  Widget _hc6(BuildContext context, CardGroup cardGroup){
    if(cardGroup.cards.isEmpty) return Container();

    return cardGroup.isScrollable?
    Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child : SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(cardGroup.cards.length, (index){
                return Padding(
                  padding: EdgeInsets.only(left: index==0? 20 : 0,right: 20,),
                  child: CardHC6(card: cardGroup.cards[index],width: MediaQuery.sizeOf(context).width * 0.8,),
                );
              })
            ],
          ),
        )
    )
        :
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      child: CardHC6(card: cardGroup.cards[0]),
    );
  }

  Widget _hc5(BuildContext context, CardGroup cardGroup){
    if(cardGroup.cards.isEmpty) return Container();

    return cardGroup.isScrollable?
    Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child : SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(cardGroup.cards.length, (index){
                return Padding(
                  padding: EdgeInsets.only(left: index==0? 20 : 0,right: 20,),
                  child: CardHC5(card: cardGroup.cards[index],width: MediaQuery.sizeOf(context).width * 0.8,),
                );
              })
            ],
          ),
        )
    )
        :
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      child: CardHC5(card: cardGroup.cards[0]),
    );
  }

  Widget _hc9(BuildContext context, CardGroup cardGroup){

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child : SizedBox(
          height: cardGroup.height?.toDouble()??300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
              itemBuilder: (context,index){
                return Padding(
                  padding: EdgeInsets.only(left: index==0? 20 : 0,right: 20,),
                  child: CardHC9(card: cardGroup.cards[index],width: MediaQuery.sizeOf(context).width * 0.8,),
                );
              },
            itemCount: cardGroup.cards.length,
          ),
        )
    );
  }

  Widget _hc1(BuildContext context, CardGroup cardGroup){
    if(cardGroup.cards.isEmpty) return Container();

    return cardGroup.isScrollable?
    Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child : SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(cardGroup.cards.length, (index){
                return Padding(
                  padding: EdgeInsets.only(left: index==0? 20 : 0,right: 20,),
                  child: CardHC1(card: cardGroup.cards[index],width: MediaQuery.sizeOf(context).width * 0.8,),
                );
              })
            ],
          ),
        )
    )
        :
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      child: CardHC1(card: cardGroup.cards[0]),
    );
  }
}
