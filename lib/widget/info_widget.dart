import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  final Map<String, dynamic> infoMap;

  const InfoWidget({
    Key? key,
    required this.infoMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool colorSwitcher = false;
    return infoMap.isEmpty
      ? const Center(child: CircularProgressIndicator(color: Color(0xFF008069),))
      : ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          children: infoMap.keys.map(
            (String mapKey) {
              colorSwitcher = !colorSwitcher;
              final value = infoMap[mapKey];
              return Container(
                color: colorSwitcher ? const Color(0xFF008069).withOpacity(0.2) : Colors.white,
                padding: const EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: AutoSizeText(
                        mapKey,
                        maxLines: 3,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,),
                      ),
                    ),
                    Expanded(
                      child: AutoSizeText(
                        '$value',
                        maxLines: 1000,
                      ),
                    ),
                  ],
                ),
              );
            },
          ).toList(),
        );
  }
}
