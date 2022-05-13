import 'package:flutter/material.dart';
import 'package:todo/component/label_group.dart';
import 'package:todo/component/platform_text.dart';
import 'package:todo/const/route_argument.dart';

class LocationDetailPage extends StatefulWidget {
  const LocationDetailPage({Key? key}) : super(key: key);

  @override
  State<LocationDetailPage> createState() => _LocationDetailPageState();
}

class _LocationDetailPageState extends State<LocationDetailPage> {
  @override
  Widget build(BuildContext context) {
    LocationDetailArgument argument = ModalRoute.of(context)?.settings.arguments as LocationDetailArgument;
    return Scaffold(
      appBar: AppBar(
        title: const Text('地点详情'),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelGroup(
            labelText: '经度',
            child: Text(argument.location.longitude.toString()),
          ),
          LabelGroup(
            labelText: '纬度',
            child: Text(argument.location.latitude.toString()),
          ),
          LabelGroup(
            labelText: '位置',
            child: ConstrainedBox(
              constraints: const BoxConstraints.tightFor(height: 16),
              child: PlatformText(
                text: argument.location.description,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
