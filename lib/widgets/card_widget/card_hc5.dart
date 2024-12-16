import 'package:fampay/models/card.dart';
import 'package:flutter/material.dart';

import '../../config/convert.dart';
import '../../config/launch_url.dart';

class CardHC5 extends StatelessWidget {
  final ContextualCard card;
  final double? width;
  const CardHC5({super.key, required this.card, this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(card.url!=null){
          LaunchUrl.launchWebUrl(card.url!);
        }
      },
      child: SizedBox(
        width:  width,
        child: AspectRatio(
          aspectRatio: card.bgImage?.aspectRatio?.toDouble()?? 16/9,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
            decoration: BoxDecoration(
                color: Convert.getColorFromHex(card.bgColor),
              borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                    image: NetworkImage(card.bgImage?.imageUrl??''),
                    fit: BoxFit.fill
                )
            ),
            child: Row(
              children: [
                if(card.icon!=null)
                  card.icon?.imageType == 'asset'?
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: card.icon?.aspectRatio?.toDouble()?? 16/9,
                      child: Image.asset(
                        'assets/images/${card.icon?.imageUrl??'error.png'}',
                        height: 80,
                        width: 90,
                      ),
                    ),
                  )
                      :
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: card.icon?.aspectRatio?.toDouble()?? 16/9,
                      child: Image.network(card.icon?.imageUrl??'',),
                    ),
                  ),
                const SizedBox(width: 15,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    const SizedBox(height: 5,),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
