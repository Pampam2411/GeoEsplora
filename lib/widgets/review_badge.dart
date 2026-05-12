import 'package:flutter/material.dart';

class ReviewBadge extends StatelessWidget {
  final int reviewCount;
  final VoidCallback onTap;

  final double? rating;
  final Color textColor;
  final bool isUnderlined;

  const ReviewBadge({
    super.key,
    required this.reviewCount,
    required this.onTap,
    required this.textColor,
    this.rating,
    this.isUnderlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (rating != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                border: Border.all(color: textColor, width: 1),
                borderRadius: BorderRadius.circular(18.5),
              ),
              child: Row(
                children: [
                  Icon(Icons.star_border, color: textColor, size: 12),
                  const SizedBox(width: 4),
                  Text(
                    rating!.toStringAsFixed(1),
                    style: TextStyle(
                      color: textColor,
                      fontSize: 6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
          ],

          Text(
            '$reviewCount recensioni',
            style: TextStyle(
              color: textColor,
              fontSize: rating != null ? 6 : 10,
              fontFamily: 'AxiformaBold',
              decoration: isUnderlined
                  ? TextDecoration.underline
                  : TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
