import 'package:fampay/config/convert.dart';
import 'package:fampay/config/launch_url.dart';
import 'package:fampay/cubit/card_cubit/card_cubit.dart';
import 'package:fampay/cubit/slider_cubit/slider_cubit.dart';
import 'package:fampay/models/cta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/card.dart';

class CardHC3 extends StatelessWidget {
  final ContextualCard card;
  final double? width;
  const CardHC3({super.key, required this.card, this.width});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliderCubit,bool>(
      builder: (BuildContext context, bool showButtons) {
        return InkWell(
          onLongPress: (){
            context.read<SliderCubit>().changeSliderState();
          },
          child: SizedBox(
            width: width,
            child: AspectRatio(
              aspectRatio: card.bgImage?.aspectRatio?.toDouble()?? 16/9,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Visibility(
                        visible: showButtons,
                        child: InkWell(
                          onTap: ()=>
                              context.read<SliderCubit>().changeSliderState(),
                          child: Padding(
                            padding:  const EdgeInsets.symmetric(horizontal: 20),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: ()=>
                                        context.read<SaveCardCubit>()
                                            .saveCard(cardId: card.id,isRemind: true),
                                      child: _btn(text: 'remind later', assetPath: 'assets/images/notification.png')
                                  ),

                                  InkWell(
                                      onTap: ()=>
                                          context.read<SaveCardCubit>()
                                              .saveCard(cardId: card.id,isDismiss: true),
                                      child: _btn(text: 'dismiss now', assetPath: 'assets/images/dismiss.png')
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      AspectRatio(
                        aspectRatio: card.bgImage?.aspectRatio?.toDouble()?? 16/9,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: InkWell(
                            onTap: (){
                              if(card.url!=null){
                                LaunchUrl.launchWebUrl(card.url!);
                              }
                            },
                            child: Container(
                              padding:  EdgeInsets.symmetric(vertical: MediaQuery.sizeOf(context).height * 0.03,
                                  horizontal: MediaQuery.sizeOf(context).width * 0.09
                              ),
                              decoration: BoxDecoration(
                                  color: Convert.getColorFromHex(card.bgColor),
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                      image: NetworkImage(card.bgImage?.imageUrl??''),
                                      fit: BoxFit.fill
                                  )
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  if(card.icon!=null)
                                    card.icon?.imageType == 'asset'?
                                    SizedBox(
                                      width: 50,
                                      child: AspectRatio(
                                        aspectRatio: card.icon?.aspectRatio?.toDouble()?? 16/9,
                                        child: Image.asset(
                                          'assets/images/${card.icon?.imageUrl??'error.png'}',
                                        ),
                                      ),
                                    )
                                        :
                                    SizedBox(
                                      width: 40,
                                      child: AspectRatio(
                                        aspectRatio: card.icon?.aspectRatio?.toDouble()?? 16/9,
                                        child: Image.network(card.icon?.imageUrl??'',),
                                      ),
                                    ),

                                  const SizedBox(height: 5,),


                                  RichText(
                                      text: TextSpan(
                                          text: '${(card.formattedTitle?.entities.length??0)>=1 ?
                                          card.formattedTitle?.entities[0].text : ''}',
                                          style: Theme.of(context).textTheme.titleSmall?.
                                          copyWith(
                                              color: Convert.getColorFromHex(card.formattedTitle?.entities[0].color),
                                              fontSize: 35
                                          ),
                                          children: [
                                            TextSpan(
                                              text: '${card.formattedTitle?.text.replaceAll('{}', '')}',
                                              style: Theme.of(context).textTheme.titleSmall?.
                                              copyWith(
                                                  color: Colors.white,
                                                  fontSize: 35
                                              ),
                                            ),
                                            if((card.formattedTitle?.entities.length??0)>=2)
                                              TextSpan(
                                                text: '${card.formattedTitle?.entities[1].text} ',
                                                style: Theme.of(context).textTheme.bodySmall?.
                                                copyWith(
                                                    color: Convert.getColorFromHex(card.formattedTitle?.entities[1].color),
                                                    fontSize: 15
                                                ),
                                              ),
                                          ]
                                      )
                                  ),
                                  const SizedBox(height: 10,),

                                  for(Cta cta in card.cta!)
                                    Container(
                                      padding: const EdgeInsets.symmetric(vertical: 13,horizontal: 40),
                                      decoration: BoxDecoration(
                                          color: Convert.getColorFromHex(cta.bgColor),
                                          borderRadius: BorderRadius.circular(6)
                                      ),
                                      child: Text(
                                        cta.text,
                                        style: Theme.of(context).textTheme.bodySmall?.
                                        copyWith(
                                          color: Convert.getColorFromHex(cta.textColor),
                                          fontSize: 14,
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _btn({required String text, required String assetPath}){
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: const Color(0xffF7F6F3),
          borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        children: [
          Image.asset(assetPath),
          Text(text,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 11
            ),
          ),

        ],
      ),
    );
  }
}
