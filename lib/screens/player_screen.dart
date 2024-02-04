import 'package:flutter/material.dart';
import 'package:neumorphsim_music_player_ui/constants/app_color.dart';
import 'package:neumorphsim_music_player_ui/screens/player_list_screen.dart';

import '../model/music_model.dart';
import '../widgets/neumorphicBtn.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  int _currentItmePlaying = 0;
  double _currentPlayBack = 0;
  String fotmatePlayerTime(double time) {
    final minute = time ~/ 60;
    final second = time % 60;
    return "$minute:${second.toStringAsFixed(0).padRight(2, "0")}";
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColor.bgColor,
      // appBar: AppBar(

      // ),b
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NeumorphicBtn(
                    size: 60,
                    child: Icon(
                      musicList[_currentItmePlaying].isFav
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: AppColor.secondaryTextColor,
                    ),
                  ),
                  Text(
                    'playing now'.toUpperCase(),
                    style: TextStyle(
                      color: AppColor.secondaryTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  NeumorphicBtn(
                    size: 60,
                    child: Icon(
                      Icons.menu,
                      color: AppColor.secondaryTextColor,
                    ),
                    onPressed: () async {
                      int selecnsexI = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PlayerListScreen(
                                  selecteIndex: _currentItmePlaying,
                                )),
                      );
                      setState(() {
                        _currentItmePlaying = selecnsexI;
                      });
                    },
                  ),
                ],
              ),
              NeumorphicBtn(
                padding: 10,
                distance: 20,
                size: size.width * 0.7,
                imageUrl: musicList[_currentItmePlaying].imageUrl,
              ),
              Column(
                children: [
                  Text(
                    musicList[_currentItmePlaying].name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryTextColor,
                    ),
                  ),
                  Text(
                    musicList[_currentItmePlaying].artist,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColor.secondaryTextColor,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          fotmatePlayerTime(_currentPlayBack),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryTextColor,
                          ),
                        ),
                        Text(
                          fotmatePlayerTime(
                                  musicList[_currentItmePlaying].length)
                              .toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColor.secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Slider(
                    thumbColor: AppColor.blue,
                    activeColor: AppColor.blue,
                    inactiveColor: AppColor.bgDark,
                    value: _currentPlayBack,
                    max: musicList[_currentItmePlaying].length,
                    onChanged: (value) {
                      setState(() {
                        _currentPlayBack = value;
                      });
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NeumorphicBtn(
                    onPressed: () {
                      if (_currentItmePlaying > 0) {
                        setState(() {
                          _currentItmePlaying--;
                        });
                      }
                    },
                    size: 80,
                    child: Icon(
                      Icons.skip_previous_rounded,
                      size: 35,
                      color: AppColor.secondaryTextColor,
                    ),
                  ),
                  NeumorphicBtn(
                    colors: [
                      AppColor.blueTopDark,
                      AppColor.blue,
                    ],
                    size: 80,
                    child: Icon(
                      Icons.pause_rounded,
                      size: 35,
                      color: AppColor.white,
                    ),
                  ),
                  NeumorphicBtn(
                    onPressed: () {
                      if (_currentItmePlaying < musicList.length - 1) {
                        setState(() {
                          _currentItmePlaying++;
                        });
                      }
                    },
                    size: 80,
                    child: Icon(
                      Icons.skip_next_rounded,
                      size: 35,
                      color: AppColor.secondaryTextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/*
class NeumorphicBtn extends StatelessWidget {
  const NeumorphicBtn({
    required this.size,
    required this.blur,
    required this.distance,
    this.onPressed,
    required this.child,
    super.key, 
  });
final double size;
  final double blur;
  final double distance;
  List<Color> colors;
  final VoidCallback? onPressed;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(3),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      width: 60,
      height: 60,
      decoration: const BoxDecoration(
        color: AppColor.bgColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              offset: Offset(-10, -10), color: AppColor.white, blurRadius: 20),
          BoxShadow(
              offset: Offset(10, 10), color: AppColor.bgDark, blurRadius: 20),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.bgColor,
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColor.white,
                  AppColor.bgDark,
                ])),
      ),
    );
  }
}
*/