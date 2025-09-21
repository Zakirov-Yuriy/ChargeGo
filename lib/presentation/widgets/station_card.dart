import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../domain/entities/station.dart';

class StationCard extends StatelessWidget {
  final Station station;
  final VoidCallback? onTap;
  final bool showArrow;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  const StationCard({
    super.key,
    required this.station,
    this.onTap,
    this.showArrow = true,
    this.backgroundColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(UIConstants.borderRadiusM),
      child: Container(
        padding: padding ?? const EdgeInsets.all(UIConstants.spacingL),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(UIConstants.borderRadiusM),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Station icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(UIConstants.borderRadiusS),
              ),
              child: Icon(
                Icons.power,
                color: Colors.grey.shade600,
                size: 24,
              ),
            ),
            const SizedBox(width: UIConstants.spacingM),

            // Station info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    station.name,
                    style: TextStyle(
                      fontSize: UIConstants.fontSizeL,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: UIConstants.spacingXS),
                  Text(
                    station.location,
                    style: TextStyle(
                      fontSize: UIConstants.fontSizeM,
                      color: Colors.grey.shade600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const SizedBox(height: UIConstants.spacingXS),
                  Text(
                    'ID: ${station.id}',
                    style: TextStyle(
                      fontSize: UIConstants.fontSizeS,
                      color: Colors.grey.shade500,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),

            // Arrow
            if (showArrow)
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey.shade400,
                size: 16,
              ),
          ],
        ),
      ),
    );
  }
}

// Компактная версия карточки станции
class CompactStationCard extends StatelessWidget {
  final Station station;
  final VoidCallback? onTap;
  final bool isSelected;

  const CompactStationCard({
    super.key,
    required this.station,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(UIConstants.borderRadiusS),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: UIConstants.spacingM,
          vertical: UIConstants.spacingS,
        ),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(UIConstants.borderRadiusS),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.power,
              color: isSelected ? Colors.black : Colors.grey.shade600,
              size: 20,
            ),
            const SizedBox(width: UIConstants.spacingS),
            Expanded(
              child: Text(
                station.name,
                style: TextStyle(
                  fontSize: UIConstants.fontSizeM,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected ? Colors.black : Colors.grey.shade700,
                  fontFamily: 'Inter',
                ),
              ),
            ),
            Text(
              station.id,
              style: TextStyle(
                fontSize: UIConstants.fontSizeS,
                color: Colors.grey.shade500,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Карточка станции в виде списка
class StationListItem extends StatelessWidget {
  final Station station;
  final VoidCallback? onTap;
  final Widget? trailing;

  const StationListItem({
    super.key,
    required this.station,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(UIConstants.borderRadiusS),
        ),
        child: Icon(
          Icons.power,
          color: Colors.grey.shade600,
          size: 20,
        ),
      ),
      title: Text(
        station.name,
        style: TextStyle(
          fontSize: UIConstants.fontSizeL,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
      ),
      subtitle: Text(
        station.location,
        style: TextStyle(
          fontSize: UIConstants.fontSizeM,
          color: Colors.grey.shade600,
          fontFamily: 'Inter',
        ),
      ),
      trailing: trailing ?? Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey.shade400,
        size: 16,
      ),
    );
  }
}
