import 'package:flutter/material.dart';
import 'package:neumorphsim_music_player_ui/constants/app_color.dart';
import 'package:neumorphsim_music_player_ui/model/music_model.dart';
import 'package:neumorphsim_music_player_ui/widgets/neumorphicBtn.dart';

class PlayerListScreen extends StatefulWidget {
  const PlayerListScreen({super.key, required this.selecteIndex});
  final int selecteIndex;
  @override
  State<PlayerListScreen> createState() => _PlayerListScreenState();
}

class _PlayerListScreenState extends State<PlayerListScreen> {
  late int sindex;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    sindex = widget.selecteIndex;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      colclutScrollPosition(scrollController);
    });

    super.initState();
  }

  colclutScrollPosition(ScrollController scrollController) {
    int totalLength = musicList.length;
    final macScroll = scrollController.position.maxScrollExtent;
    scrollController.animateTo(
      macScroll / totalLength * sindex,
      duration: Duration(
        milliseconds: 500,
      ),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "play list".toUpperCase(),
              style: TextStyle(
                fontSize: 14,
                color: AppColor.secondaryTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: size.height * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NeumorphicBtn(
                    onPressed: () {
                      Navigator.pop(context, sindex);
                    },
                    size: 60,
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColor.secondaryTextColor,
                    ),
                  ),
                  NeumorphicBtn(
                    padding: 8,
                    distance: 20,
                    size: size.width * 0.45,
                    imageUrl: musicList[sindex].imageUrl,
                  ),
                  NeumorphicBtn(
                    size: 60,
                    child: Icon(
                      musicList[sindex].isFav
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: musicList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        sindex = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: sindex == index
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color:
                                  AppColor.secondaryTextColor.withOpacity(0.3),
                            )
                          : null,
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                musicList[index].name,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppColor.primaryTextColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                musicList[index].artist,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColor.secondaryTextColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          sindex == index
                              ? NeumorphicBtn(
                                  colors: [
                                    AppColor.blueTopDark,
                                    AppColor.blue,
                                  ],
                                  size: 50,
                                  child: Icon(
                                    Icons.pause_rounded,
                                    color: AppColor.white,
                                  ),
                                )
                              : NeumorphicBtn(
                                  size: 50,
                                  child: Icon(
                                    Icons.play_arrow_rounded,
                                    color: AppColor.secondaryTextColor,
                                  ),
                                )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
