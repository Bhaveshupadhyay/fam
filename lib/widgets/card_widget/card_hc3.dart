import 'package:fampay/config/convert.dart';
import 'package:fampay/config/launch_url.dart';
import 'package:fampay/cubit/card_cubit/card_cubit.dart';
import 'package:fampay/cubit/slider_cubit/slider_cubit.dart';
import 'package:fampay/models/cta.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/card.dart';

class CardHC3 extends StatelessWidget {
  final ContextualCard card;
  final double? width;
  const CardHC3({super.key, required this.card, this.width});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SliderCubit(),
      child: BlocBuilder<SliderCubit,bool>(
        builder: (BuildContext context, bool showButtons) {
          return InkWell(
            onLongPress: (){
              context.read<SliderCubit>().changeSliderState();
            },
            child: SizedBox(
              width: width,
              child: AspectRatio(
                aspectRatio: card.bgImage?.aspectRatio?.toDouble()?? 8/9,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
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
                              padding:  EdgeInsets.symmetric(horizontal: 20.w),
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
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: InkWell(
                              onTap: (){
                                if(card.url!=null){
                                  LaunchUrl.launchWebUrl(card.url!);
                                }
                              },
                              child: Container(
                                padding:  EdgeInsets.symmetric(vertical: 0.03.sh,
                                    horizontal: 0.09.sw
                                ),
                                decoration: BoxDecoration(
                                    color: Convert.getColorFromHex(card.bgColor),
                                    borderRadius: BorderRadius.circular(12.r),
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
                                        width: 50.w,
                                        child: AspectRatio(
                                          aspectRatio: card.icon?.aspectRatio?.toDouble()?? 16/9,
                                          child: Image.asset(
                                            'assets/images/${card.icon?.imageUrl??'error.png'}',
                                          ),
                                        ),
                                      )
                                          :
                                      SizedBox(
                                        width: 40.w,
                                        child: AspectRatio(
                                          aspectRatio: card.icon?.aspectRatio?.toDouble()?? 16/9,
                                          child: Image.network(card.icon?.imageUrl??'',),
                                        ),
                                      ),

                                    SizedBox(height: 5.h,),


                                    RichText(
                                        text: TextSpan(
                                            text: '${(card.formattedTitle?.entities.length??0)>=1 ?
                                            card.formattedTitle?.entities[0].text : ''}',
                                            style: Theme.of(context).textTheme.titleSmall?.
                                            copyWith(
                                                color: Convert.getColorFromHex(card.formattedTitle?.entities[0].color),
                                                fontSize: 40.sp
                                            ),
                                            children: [
                                              TextSpan(
                                                text: '${card.formattedTitle?.text.replaceAll('{}', '')}',
                                                style: Theme.of(context).textTheme.titleSmall?.
                                                copyWith(
                                                    color: Colors.white,
                                                    fontSize: 40.sp
                                                ),
                                              ),
                                              if((card.formattedTitle?.entities.length??0)>=2)
                                                TextSpan(
                                                  text: '\n${card.formattedTitle?.entities[1].text}\n',
                                                  style: Theme.of(context).textTheme.bodySmall?.
                                                  copyWith(
                                                      color: Convert.getColorFromHex(card.formattedTitle?.entities[1].color),
                                                      fontSize: 16.sp
                                                  ),
                                                ),
                                            ]
                                        )
                                    ),
                                    SizedBox(height: 10.h,),

                                    for(Cta cta in card.cta!)
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical: 13.h,horizontal: 40.w),
                                        decoration: BoxDecoration(
                                            color: Convert.getColorFromHex(cta.bgColor),
                                            borderRadius: BorderRadius.circular(6.r)
                                        ),
                                        child: Text(
                                          cta.text,
                                          style: Theme.of(context).textTheme.bodySmall?.
                                          copyWith(
                                            color: Convert.getColorFromHex(cta.textColor),
                                            fontSize: 14.sp,
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
      ),
    );
  }

  Widget _btn({required String text, required String assetPath}){
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
          color: const Color(0xffF7F6F3),
          borderRadius: BorderRadius.circular(12.r)
      ),
      child: Column(
        children: [
          Image.asset(assetPath,),
          Text(text,
            style: TextStyle(
                color: Colors.black,
                fontSize: 11.sp
            ),
          ),

        ],
      ),
    );
  }
}
