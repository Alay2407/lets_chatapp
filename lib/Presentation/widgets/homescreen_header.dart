import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lets_chatapp/core/colors/colors.dart';

class HomeScreenHeader extends StatelessWidget {
  HomeScreenHeader({
    super.key,
    required this.headerName,
    required this.svgIconsleft,
    required this.svgIconsright,
    this.editProfilepress,
    this.searchOnpress,
  });

  final String? headerName;
  final String? svgIconsright;
  final String? svgIconsleft;
  VoidCallback? searchOnpress;
  VoidCallback? editProfilepress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 61, left: 24, right: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: searchOnpress,
            child: CircleAvatar(
              radius: 22,
              backgroundColor: ColorManager.white.withOpacity(
                0.37,
              ),
              child: SvgPicture.asset(
                svgIconsleft!,
              ),
            ),
          ),
          Text(
            headerName!,
            style: const TextStyle(
              color: ColorManager.white,
              fontSize: 20,
            ),
          ),
          InkWell(
            onTap: editProfilepress,
            child: CircleAvatar(
              radius: 22,
              backgroundColor: ColorManager.white.withOpacity(
                0.37,
              ),
              child: SvgPicture.asset(
                svgIconsright!,
              ),
            ),
          )
        ],
      ),
    );
  }
}
