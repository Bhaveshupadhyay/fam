import 'dart:math';

import 'package:fampay/config/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/launch_url.dart';
import '../../models/card.dart';

class CardHC9 extends StatelessWidget {
  final ContextualCard card;
  final double? width;
  const CardHC9({super.key, required this.card, this.width});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        if(card.url!=null){
          LaunchUrl.launchWebUrl(card.url!);
        }
      },
      child: AspectRatio(
        aspectRatio: card.bgImage?.aspectRatio?.toDouble()?? 16/9,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: List<Color>.from(
                    card.bgGradient?.colors.map((e)=>Convert.getColorFromHex(e))??[]
                ),
              begin: _getAlignmentFromAngle(card.bgGradient?.angle.toDouble()??0),  // Custom angle of 336°
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20.r)
          ),
        ),
      ),
    );
  }

  Alignment _getAlignmentFromAngle(double angle) {
    double radians = angle * pi / 180;
    double dx = cos(radians);
    double dy = sin(radians);
    return Alignment(dx, dy);
  }
}
