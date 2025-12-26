import 'package:flutter/material.dart';
import 'package:ocr_scanner/app_colors.dart';

class MainAppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      // Basic theme properties
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.whiteColor,

      // Color Scheme
      colorScheme: ColorScheme.light(
        primary: AppColors.primaryColor,
        secondary: AppColors.primaryColor.withValues(alpha: 0.4),
        tertiary: AppColors.secondaryColor,
        surface: AppColors.whiteColor,
        onPrimary: Colors.white,
        onSecondary: AppColors.fontColor,
        onSurface: AppColors.fontColor,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.whiteColor,
        surfaceTintColor: AppColors.whiteColor,
        titleTextStyle: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 24,
          fontWeight: FontWeight.w700,
          height: 1.5,
          letterSpacing: 0,
        ),
      ),

      textTheme: const TextTheme().copyWith(
        headlineMedium: TextStyle(
          fontVariations: [const FontVariation('wght', 700)],
          fontSize: 24,
          height: 1.5,
          letterSpacing: -1,
          color: AppColors.fontColor,
        ),
        titleMedium: TextStyle(
          fontVariations: [const FontVariation('wght', 500)],
          fontSize: 16,
          height: 1.5,
          letterSpacing: 0,
          color: AppColors.fontColor,
        ),
        displayMedium: TextStyle(
          fontVariations: [const FontVariation('wght', 600)],
          fontSize: 20,
          height: 1.5,
          letterSpacing: 0,
          color: AppColors.fontColor,
        ),
        bodyLarge: TextStyle(
          fontVariations: [const FontVariation('wght', 500)],
          fontSize: 20,
          height: 1.5,
          letterSpacing: -1,
          color: AppColors.primaryColor,
        ),
        bodyMedium: TextStyle(
          fontVariations: [const FontVariation('wght', 500)],
          fontSize: 14,
          height: 1.5,
          letterSpacing: 0,
          color: AppColors.primaryColor,
        ),
        labelMedium: TextStyle(
          fontVariations: [const FontVariation('wght', 500)],
          fontSize: 14,
          height: 1.5,
          letterSpacing: 0,
          color: AppColors.fontColor,
        ),
      ),

      // Filled Button Theme
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: AppColors.whiteColor,
          minimumSize: const Size(double.infinity, 42),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          textStyle: TextStyle(
            fontVariations: [const FontVariation('wght', 500)],
            fontSize: 14,
            height: 1.5,
            letterSpacing: 0,
            color: AppColors.whiteColor,
          ),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          alignment: Alignment.centerRight,
          foregroundColor: AppColors.primaryColor,
          textStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            height: 1.5,
            letterSpacing: 0,
            color: AppColors.primaryColor,
          ),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          side: BorderSide(color: AppColors.primaryColor, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          minimumSize: const Size(0, 42),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
          textStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            height: 1.5,
            letterSpacing: 0,
            color: AppColors.primaryColor,
          ),
        ),
      ),

      // Input Decoration Theme (for TextFields)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.gray50,
        errorStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          height: 1.25,
          letterSpacing: 0,
          color: AppColors.errorColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.gray300, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.gray300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.gray300, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.errorColor, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: AppColors.errorColor, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        hintStyle: TextStyle(
          fontVariations: [const FontVariation('wght', 400)],
          fontSize: 14,
          height: 1.25,
          letterSpacing: 0,
          color: AppColors.gray500,
        ),
        floatingLabelStyle: TextStyle(
          fontSize: 14,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Text Selection Theme (cursor/caret color)
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.primaryColor,
        selectionColor: AppColors.primaryColor.withValues(alpha: 0.4),
        selectionHandleColor: AppColors.primaryColor,
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryColor;
          }
          return AppColors.gray50;
        }),
        checkColor: WidgetStateProperty.all(AppColors.whiteColor),
        side: BorderSide(color: AppColors.gray300, width: 0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.gray50,
        selectedColor: AppColors.primaryColor,
        side: BorderSide(color: AppColors.gray300, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        labelStyle: TextStyle(
          fontVariations: [const FontVariation('wght', 500)],
          fontSize: 14,
          height: 1.5,
          letterSpacing: 0,
          color: AppColors.gray500,
        ),
        secondaryLabelStyle: TextStyle(
          fontVariations: [const FontVariation('wght', 500)],
          fontSize: 14,
          height: 1.5,
          letterSpacing: 0,
          color: AppColors.whiteColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        showCheckmark: false,
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.fontColor,
        ),
        contentTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: AppColors.fontColor,
        ),
      ),

      // Drawer
      drawerTheme: const DrawerThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
        ),
      ),

      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          height: 1.5,
          letterSpacing: 0,
          color: AppColors.fontColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
          constraints: const BoxConstraints(minHeight: 42, maxHeight: 42),
          hintStyle: TextStyle(
            fontVariations: [const FontVariation('wght', 400)],
            fontSize: 14,
            height: 1.25,
            letterSpacing: 0,
            color: AppColors.gray500,
          ),
          filled: true,
          fillColor: AppColors.gray50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.gray300, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.gray300, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: AppColors.gray300, width: 1),
          ),
        ),
        menuStyle: MenuStyle(
          minimumSize: WidgetStateProperty.all(const Size(double.infinity, 0)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          padding: WidgetStateProperty.all(const EdgeInsets.all(8)),
        ),
      ),

      // Menu Button Theme (for dropdown menu items)
      menuButtonTheme: MenuButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected) ||
                states.contains(WidgetState.focused)) {
              return AppColors.gray100;
            }
            return Colors.transparent;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected) ||
                states.contains(WidgetState.focused)) {
              return AppColors.primaryColor;
            }
            return AppColors.fontColor;
          }),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
          textStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected) ||
                states.contains(WidgetState.focused)) {
              return const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                height: 1.5,
                letterSpacing: 0,
              );
            }
            return const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 1.5,
              letterSpacing: 0,
            );
          }),
        ),
      ),

      // Divider Theme
      dividerTheme: DividerThemeData(color: AppColors.gray200, thickness: 1),

      // Popup Menu Button
      popupMenuTheme: PopupMenuThemeData(
        color: AppColors.whiteColor,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        textStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          height: 1.5,
          letterSpacing: 0,
          color: AppColors.fontColor,
        ),
        position: PopupMenuPosition.under,
      ),
    );
  }
}
