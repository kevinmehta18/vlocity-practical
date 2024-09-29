import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:practical/shared/constants/colors.dart';
import 'package:practical/shared/utils/responsive_manager.dart';
import 'package:practical/shared/utils/textstyles/regular_textstyles.dart';
import 'package:practical/shared/utils/textstyles/semi_bold_textstyles.dart';

class MovieInfoCard extends StatelessWidget {
  const MovieInfoCard(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.overview,
      required this.releaseDate,
      required this.rating});

  final String imageUrl;
  final String name;
  final String overview;
  final String releaseDate;
  final String rating;

  BoxDecoration get decoration => BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: kLightGrey),
          color: kWhite,
          boxShadow: [
            BoxShadow(
              color: kBlack.withOpacity(0.1), // Shadow color
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ]);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
          horizontal: ResponsiveManager.width(3),
          vertical: ResponsiveManager.height(0.5)),
      decoration: decoration,
      child: _buildCompanyInfo(),
    );
  }

  Widget _buildCompanyInfo() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: ResponsiveManager.height(12),
                width: ResponsiveManager.width(20),
                decoration: BoxDecoration(
                    border: Border.all(color: kLightGrey),
                    borderRadius: BorderRadius.circular(8),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(imageUrl))),
              ),
              SizedBox(
                width: ResponsiveManager.width(3),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildText(name, textStyle: text18SemiBold),
                    SizedBox(
                      height: ResponsiveManager.height(0.5),
                    ),
                    _buildRating(),
                    SizedBox(
                      height: ResponsiveManager.height(0.5),
                    ),
                    _buildText(overview, textStyle: text16Regular),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRating() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.star,
          color: kPrimaryColor,
          size: 15,
        ),
        SizedBox(
          width: ResponsiveManager.width(1),
        ),
        _buildText(rating, textStyle: text14Regular),
      ],
    );
  }

  Widget _buildText(String text, {TextStyle? textStyle}) {
    return Flexible(
      child: Text(
        text,
        style: textStyle ?? text18SemiBold,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
