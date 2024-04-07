import 'package:google_fonts/google_fonts.dart';
import 'package:tasks/export.dart';

const kRoundedAll = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(
    Radius.circular(33.0),
  ),
);

final OutlineInputBorder kBorder = OutlineInputBorder(
  borderSide: const BorderSide(
    color: Colors.transparent,
  ),
  borderRadius: BorderRadius.circular(16),
);

final lightTheme = ThemeData(
    primaryColor: kPrimaryColor,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme().copyWith(color: kPrimaryColor),
    dividerColor: Colors.white54,
    textTheme: Typography.blackCupertino.copyWith(
      titleLarge:
          GoogleFonts.roboto(fontSize: 20.sp, fontWeight: FontWeight.w500),
      titleMedium:
          GoogleFonts.roboto(fontSize: 16.sp, fontWeight: FontWeight.w400),
      titleSmall: GoogleFonts.roboto(
          fontSize: 12.sp, fontWeight: FontWeight.w700, color: kPrimaryColor),
      labelSmall: GoogleFonts.roboto(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      ),
      displaySmall: GoogleFonts.roboto(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: GoogleFonts.roboto(
        color: kBlack,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: GoogleFonts.roboto(
        color: kBlack.withOpacity(.87),
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: GoogleFonts.roboto(
        color: kBlack.withOpacity(.6),
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
    ),
    fontFamily: 'Cairo',
    colorScheme: ColorScheme.fromSwatch(primarySwatch: kPrimaryColor)
        .copyWith(secondary: kPrimaryColor, background: kWhite));
