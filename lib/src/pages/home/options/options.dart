import 'package:flutter/material.dart';

import 'option_card.dart';

class Options extends StatelessWidget {
  const Options({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        padding: const EdgeInsets.only(bottom: 8, top: 8),
        crossAxisCount: 3,
        children: const [
          OptionCard(
            text: 'Health',
            icon: Icons.health_and_safety,
          ),
          OptionCard(
            text: 'Education',
            icon: Icons.school,
          ),
          OptionCard(
            text: 'Welfare',
            icon: Icons.public,
          ),
          OptionCard(
            text: 'Marriage Bureau',
            icon: Icons.favorite,
          ),
          OptionCard(
            text: 'Blood Donation',
            icon: Icons.water_drop,
          ),
        ],
      ),
    );
  }
}
