import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SeraAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SeraAppBar({
    super.key,
    this.title,
    this.showShadow = true,
    this.leading,
    this.leadingWidth,
    this.actions,
    this.bottom,
    this.isTransparent = false,
    this.showRadius = true,
    this.titleSpacing,
    this.centerTitle = true,
    this.automaticallyImplyLeading = true,
    this.iconTheme,
    this.systemUiOverlayStyle,
  });

  final dynamic title;
  final bool showShadow;
  final Widget? leading;
  final double? leadingWidth;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final bool isTransparent;
  final bool showRadius;
  final bool centerTitle;
  final double? titleSpacing;
  final bool automaticallyImplyLeading;
  final IconThemeData? iconTheme;
  final SystemUiOverlayStyle? systemUiOverlayStyle;

  final _preferredSize = const Size(double.infinity, kToolbarHeight);

  Widget? _buildTitle(BuildContext context, dynamic text) {
    if (text != null) {
      if (text is String) {
        return Text(
          text,
        );
      }
      return text;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: _preferredSize,
      child: Container(
        decoration: BoxDecoration(
            color: isTransparent ? Colors.transparent : Colors.white,
            boxShadow: showShadow && !isTransparent
                ? [
                   BoxShadow(
                    color: Colors.black.withOpacity(0.16),
                    offset: const Offset(0, 2.0),
                    blurRadius: 8.0,
                    spreadRadius: 0.0)
                ]
                : null,
            borderRadius: bottom != null && !isTransparent && showRadius
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0))
                : null),
        child: AppBar(
          iconTheme: iconTheme,
          elevation: isTransparent ? 0.0 : null,
          forceMaterialTransparency: isTransparent,
          shape: bottom != null
              ? const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0)),
                )
              : null,
          centerTitle: centerTitle,
          backgroundColor: isTransparent ? Colors.transparent : Colors.white,
          leading: leading,
          toolbarHeight: leadingWidth,
          leadingWidth: leadingWidth,
          title: _buildTitle(context, title),
          actions: actions,
          bottom: bottom,
          titleSpacing: titleSpacing,
          surfaceTintColor: Colors.white,
          systemOverlayStyle: systemUiOverlayStyle ??
              const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness: Brightness.light),
          automaticallyImplyLeading: automaticallyImplyLeading,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => bottom != null
      ? Size.fromHeight(kToolbarHeight + bottom!.preferredSize.height)
      : _preferredSize;
}
