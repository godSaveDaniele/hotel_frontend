import 'package:flutter/material.dart';
import 'package:hotel_frontend/model/UI/tools/Communicator.dart';
import 'package:word_cloud/word_cloud_data.dart';
import 'package:word_cloud/word_cloud_view.dart';


class WordCloud extends StatefulWidget {
  const WordCloud({super.key, required this.title});

  final String title;

  @override
  State<WordCloud> createState() => _WordCloud();
}

class _WordCloud extends State<WordCloud> {

  @override
  Widget build(BuildContext context) {

    WordCloudData wcdata = WordCloudData(data: Communicator.sharedInstance.wordCloudListMap);

    return Scaffold(
      body: SizedBox.expand(
        child: WordCloudView(
          data: wcdata,
          mapcolor: Color.fromARGB(255, 174, 183, 235),
          mapwidth: 800,
          mapheight: 350,
          fontWeight: FontWeight.bold,
          colorlist: [Colors.black, Colors.redAccent, Colors.indigoAccent],
        ),
      )
    );
  }
}