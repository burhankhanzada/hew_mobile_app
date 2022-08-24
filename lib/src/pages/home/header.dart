import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:spaces/spaces.dart';

import '../../state/app_state.dart';
import 'home_page.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userModel = context.read<AppState>().userModel;

    return Expanded(
      child: Column(
        children: [
          AppBar(
            title: const Text(
              'HEW Foundation',
            ),
            backgroundColor: c1,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications,
                ),
              )
            ],
          ),
          Expanded(
            child: Container(
              color: c1,
              width: double.infinity,
              child: SpacedColumn(
                padding: const EdgeInsets.all(16),
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    userModel!.displayName!,
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),
          Stack(
            children: [
              SvgPicture.string(
                '''
                      <svg viewBox="0 0 400 60">
                        <path d="M 0 0 Q 0 20 20 20 L 150 20 C 175 20 175 60 200 60 L 380 60 Q 400 60 400 40 L 400 0 L 0 0"/>
                      </svg>
                      ''',
                fit: BoxFit.fill,
                color: c2,
              ),
              SvgPicture.string(
                '''
                      <svg viewBox="0 0 400 60">
                        <path d="M 0 0 Q 0 20 20 20 L 200 20 C 225 20 225 60 250 60 L 380 60 Q 400 60 400 40 L 400 0 L 0 0"/>
                      </svg>
                      ''',
                fit: BoxFit.fill,
                color: c1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
