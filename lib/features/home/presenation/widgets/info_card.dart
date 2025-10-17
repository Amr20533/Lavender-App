import 'package:flutter/material.dart';
class InfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String icon;
  const InfoCard({super.key, required this.title, required this.subtitle, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset("assets/icons/$icon"),
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(subtitle, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

