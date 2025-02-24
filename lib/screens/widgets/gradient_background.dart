import 'package:flutter/material.dart';

class GradientBackgroundWidget extends StatelessWidget {
  const GradientBackgroundWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
     child: Container(
       decoration: const BoxDecoration(
         gradient: LinearGradient(
           begin: Alignment.topLeft,
           end: Alignment.bottomRight,
           colors: [Color(0xFF0A192F), Color(0xFF112D4E)],
         ),
       ),
     ),
              );
  }
}