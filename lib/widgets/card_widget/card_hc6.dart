import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        padding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 15.w),
        decoration: BoxDecoration(
          color: Convert.getColorFromHex(card.bgColor),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
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
            SizedBox(width: 15.w,),
            Text(card.formattedTitle?.entities[0].text??'',
              style: Theme.of(context).textTheme.titleSmall?.
              copyWith(
                  color: Colors.black,
                  fontSize: 15.sp
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 20.sp,
            )
          ],
        ),
      ),
    );
  }
}
