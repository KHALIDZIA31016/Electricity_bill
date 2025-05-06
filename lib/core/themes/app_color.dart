import 'package:flutter/material.dart';

class AppColors {
 static const kPrimary = Color(0xff2845d1);
 static const Color kWhite = Color(0xffffffff);
 static const Color kWhiteF7 = Color(0xfff7f7f7);
 static const Color kWhiteFA = Color(0xffFAFAFA);
 static const Color kWhiteEF = Color(0xffEFEFEF);
 static const Color kBgColor = Color(0xfffafafa);
 static const Color kBlack = Color(0xff000000);
 static const Color kBlack0D = Color(0xff0d0d0d);
 static const Color kDark = Color(0xff242424);
 static const Color kDarker = Color(0xFF1B1B1B);
 static const Color kDarkLighter = Color(0xff2c2c2c);

 static const Color kOffWhiteGrey = Color(0xCDF5F5F5);


 static const Color kDarkLight = Color(0xff3a3a3a); // Slightly lighter than kDarklighter
 static const Color kGreyBlack = Color(0xff404040); // A mix of grey and black
 static const Color kSoftBlack = Color(0xff505050); // Soft black tone
 static const Color kMutedBlack = Color(0xff383838); // A muted black tone
 static const Color kCharcoal = Color(0xff2f2f2f); // Dark charcoal shade


 static const Color kGrey85 = Color(0xff858585);
 static const Color kGreyB7 = Color(0xffB7B7B7);
 static const Color kGrey8E = Color(0xff8E8E8E);
 static const Color kGrey83 = Color(0xff838383);
 static const Color kGrey = Color(0xffF5F5F5);

 // use below
 static const kLightGreen1 = Color(0xFFE8F5E9); // Very light green
 static const kMediumGreen1 = Color(0xFF81C784); // Medium green
 static const kMediumGreen2 = Color(0xFF4CAF50); // Classic green
 static const kDarkGreen1 = Color(0xFF388E3C); // Dark green
 static const kDarkGreen2 = Color(0xFF1B5E20); // Very dark green
 static const kTealGreen1 = Color(0xFF26A69A); // Teal green
 static const kTealGreen2 = Color(0xFF00796B); // Dark teal green
 static const kOliveGreen = Color(0xFF8BC34A); // Olive green
 static const kLimeGreen = Color(0xFFCDDC39); // Lime green
 static const kEmeraldGreen = Color(0xFF009688); // Emerald green
 static const kForestGreen = Color(0xFF2E7D32); // Forest green
 static const kMintGreen = Color(0xFFA5D6A7); // Mint green
 static const kSeaGreen = Color(0xFF4DB6AC); // Sea green
 static const kJungleGreen = Color(0xFF1DE9B6); // Jungle green
 static const kPineGreen = Color(0xFF00695C); // Pine green

 static const  kLightAlmond1= Color(0xFFB29A6B); // Even Darker Light Almond
 static const kDarkerLightAlmond = Color(0xFFF1E2B3); // Lighter Light Almond
 static const myColor = Color(0xFFDCB568);
 static const myDarkColor = Color(0xFFC79A55);  // Darker color
 static const kLightGreen2 = Color(0xFFC8E6C9); // Light green



 static const primaryGradient = LinearGradient(
  colors: [
   Color(0xFF4CAF50), // Green (Start)
   Color(0xFF1B1B1B), // Darker black-green mix (Middle)
   Color(0xFF000000), // Black (End)
  ],
  stops: [0.1, 0.3, 1.0], // Adjust where each color appears
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
 );


 static const primaryGradient2 = LinearGradient(
  colors: [
   Color(0xFFC8E6C9),
   Color(0xffFAFAFA),// Green (Start)
   Color(0xFFC8E6C9), // Darker black-green mix (Middle)
    // Black (End)
  ],
  stops: [0.1, 0.3, 1.0], // Adjust where each color appears
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
 );
}