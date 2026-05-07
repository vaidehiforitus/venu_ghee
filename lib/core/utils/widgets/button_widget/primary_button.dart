  import 'package:venu_ghee/core/utils/widgets/text_widget/text_widget/text_widget.dart';
  import 'package:venu_ghee/core/utils/exports/common_exports.dart';

  class PrimaryButton extends StatelessWidget {
    final String title;
    final double? height;
    final double? width;
    final double? customRadius;
    final EdgeInsets? padding;
    final double? prefixIconPadding;
    final VoidCallback? onPressed;
    final double? lineHeight;
    final Color? titleColor;
    final Color? buttonColor;
    final double? fontSize;
    final Widget? prefix;
    final double? prefixPadding;
    final bool isLoading;
    final Widget? suffix;
    final double? suffixPadding;
    final BorderSide? border;


    const PrimaryButton({
      super.key,
      required this.title,
      this.height,
      this.width,
      this.customRadius,
      this.padding,
      this.prefixIconPadding,
      required this.onPressed,
      this.lineHeight,
      this.titleColor,
      this.buttonColor,
      this.fontSize,
      this.isLoading = false,
      this.prefix,
      this.prefixPadding,
      this.suffix,
      this.suffixPadding,
      this.border,
    });

    @override
    Widget build(BuildContext context) {
      return SizedBox(
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            surfaceTintColor: buttonColor ?? ColorConstants.primaryColor,
            backgroundColor: buttonColor ?? ColorConstants.primaryColor,
            foregroundColor: ColorConstants.primaryColor,
            splashFactory: NoSplash.splashFactory,
            enableFeedback: false,
            elevation: 0,
            overlayColor: Colors.transparent,
            shadowColor: Colors.transparent,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            side: border,
            padding:
                padding ??
                EdgeInsets.symmetric(
                  vertical: (height != null ? height! * 0.18 : 12),
                  horizontal: 16,
                ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(customRadius ?? 10.0),
              ),
            ),
          ),
          onPressed: isLoading ? null : onPressed,
          child: isLoading
              ?  SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: ColorConstants.primaryColor,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (prefix != null)
                      Padding(
                        padding: EdgeInsets.only(right: prefixPadding ?? 8.0.r),
                        child: prefix!,
                      ),

                    TextWidget(
                      text: title,
                      color: titleColor ?? ColorConstants.primaryColor,
                      fontSize: fontSize ?? 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    if (suffix != null)
                      Padding(
                        padding: EdgeInsets.only(left: suffixPadding ?? 8.0.r),
                        child: suffix!,
                      ),
                  ],
                ),
        ),
      );
    }
  }
