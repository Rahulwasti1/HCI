import 'package:flutter/material.dart';
import 'package:hci/constants/colors.dart';
import 'package:hci/models/energy_usage_model.dart';

class RoomUsageCard extends StatelessWidget {
  final RoomUsage roomUsage;
  final VoidCallback onTap;

  const RoomUsageCard({
    super.key,
    required this.roomUsage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            // Room image with fixed size
            SizedBox(
              width: 50,
              height: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  roomUsage.roomImage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.primaryLight,
                      child: const Icon(
                        Icons.home,
                        color: AppColors.primary,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Room details with constrained width
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    roomUsage.roomName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Energy Usage',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textLight,
                    ),
                    maxLines: 1,
                  ),
                  Text(
                    '${roomUsage.usage.toStringAsFixed(1)} kWH',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Arrow icon
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_forward,
                color: AppColors.primary,
                size: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
