import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/constants.dart';

class CurrentConditions extends StatelessWidget {

  var data;

  CurrentConditions(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '${data[0]['main'][Constants.JSONtopics[0]].round()}º',
          style: const TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.w100),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Column(
            children: [
              const SizedBox(height: 10),
              const Text("Max", style: TextStyle(color: Colors.black54, fontSize: 16)),
              const SizedBox( height: 10),
              Text('${data[0]['main']['temp_max'].round()}º', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Center(
                child: Container(
                  width: 1,
                  height: 30,
                )),
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(Constants.iconsApi +
                data[0]['weather'][0]['icon'] +
                Constants.imageEnd),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Center(
                child: Container(
                  width: 1,
                  height: 30,
                )),
          ),
          Column(
            children: [
              const SizedBox(height: 10),
              const Text("Min", style: TextStyle(color: Colors.black54, fontSize: 16)),
              const SizedBox( height: 10),
              Text('${data[0]['main']['temp_min'].round()}º', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16))
            ],
          ),
        ]),
      ],
    );
  }
}
