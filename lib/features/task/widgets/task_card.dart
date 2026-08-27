import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';

class TaskCard extends StatelessWidget {
  final String id;
  final String title;
  final String subtitle;
  final String status;

  const TaskCard({
    super.key,
    required this.id,
    required this.title,
    required this.subtitle,
    required this.status,
  });

  static const Color primaryColor =
  Color(0xFF5B5FEF);

  static const Color textColor =
  Color(0xFF171725);

  static const Color mutedColor =
  Color(0xFF8C8C9A);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (id.isEmpty) {
          Get.snackbar(
            'Error',
            'Task ID not found.',
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.all(16),
          );

          return;
        }

        Get.toNamed(
          AppRoutes.taskDetails,
          arguments: id,
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: 0.04,
              ),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [

            // ICON
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFEEF0FF),
                borderRadius:
                BorderRadius.circular(15),
              ),
              child: const Icon(
                Icons.task_alt_rounded,
                color: primaryColor,
                size: 26,
              ),
            ),

            const SizedBox(width: 14),

            // TASK INFO

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow:
                    TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: textColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    subtitle.isEmpty
                        ? 'No description'
                        : subtitle,
                    maxLines: 1,
                    overflow:
                    TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: mutedColor,
                      fontSize: 12,
                    ),
                  ),

                  const SizedBox(height: 8),

                  _statusBadge(),
                ],
              ),
            ),

            const SizedBox(width: 10),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: mutedColor,
            ),
          ],
        ),
      ),
    );
  }

  // STATUS BADGE

  Widget _statusBadge() {
    final Color statusColor;

    switch (status) {
      case 'Completed':
        statusColor = Colors.green;
        break;

      case 'Progress':
        statusColor = Colors.orange;
        break;

      default:
        statusColor = primaryColor;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: statusColor.withValues(
          alpha: 0.10,
        ),
        borderRadius:
        BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: statusColor,
          fontSize: 10,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}