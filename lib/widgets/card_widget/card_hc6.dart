import 'package:flutter/material.dart';

import '../../config/convert.dart';
import '../../config/launch_url.dart';
import '../../models/card.dart';

class CardHC6 extends StatelessWidget {
  final ContextualCard card;
  final double? width;
  const CardHC6({super.key, required this.card, this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(card.url!=null){
          LaunchUrl.launchWebUrl(card.url!);
        }
      },
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
        decoration: BoxDecoration(
          color: Convert.getColorFromHex(card.bgColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
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
            const SizedBox(width: 15,),
            Text(card.formattedTitle?.entities[0].text??'',
              style: Theme.of(context).textTheme.titleSmall?.
              copyWith(
                  color: Colors.black,
                  fontSize: 15
              ),
            ),
            const Spacer(),
            Image.asset(
              'assets/images/forward.png',
            ),
          ],
        ),
      ),
    );
  }
}
