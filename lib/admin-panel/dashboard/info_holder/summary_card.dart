import 'package:flutter/material.dart';
import 'package:face_recognition_design/responsiveness.dart'; // Ensure this is correctly imported.

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    Key? key,
    required this.title,
    required this.count,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String count;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    // Mobile, Tablet, and Desktop specific sizes
    double cardWidth = Responsive.isMobile(context)
        ? 150
        : (Responsive.isTablet(context) ? 180 : 220);
    double cardHeight = Responsive.isMobile(context)
        ? 100
        : (Responsive.isTablet(context) ? 120 : 140);
    double iconSize = Responsive.isMobile(context)
        ? 30
        : (Responsive.isTablet(context) ? 35 : 40);

    return Card(
      child: SizedBox(
        width: cardWidth, // Adjust width based on device size
        height: cardHeight, // Adjust height based on device size
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: iconSize), // Adjust icon size based on device
              const SizedBox(height: 10),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign
                    .center, // Ensure text is centered on small screens
              ),
              const SizedBox(height: 5),
              Text(
                count,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center, // Center text on smaller screens
              ),
            ],
          ),
        ),
      ),
    );
  }
}
