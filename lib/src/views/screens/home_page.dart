import 'package:fivefootballgames/src/views/widgets/favorite_body.dart';
import 'package:fivefootballgames/src/views/widgets/home_body.dart';
import 'package:fivefootballgames/utils/constants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  int _currentTeamIndex = 0;

  @override
  Widget build(BuildContext context) {
    final _homeBody = [
      HomeBody(
        index: _currentTeamIndex,
      ),
      const FavoriteBody(),
    ];
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kUpBackColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _currentIndex == 0 ? "22.12" : "Favorites",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
      ),
      body: _homeBody[_currentIndex],
      bottomNavigationBar: Container(
        height: 72,
        width: size.width,
        color: kPrimaryColor,
        child: Column(
          children: [
            SizedBox(
                height: 56.0,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentIndex = 0;
                          });
                        },
                        child: Container(
                          color: _currentIndex == 0
                              ? const Color(0xff3C3C3C)
                              : kPrimaryColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.home_outlined,
                                color: Colors.white,
                              ),
                              Text(
                                "Matches",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentIndex = 1;
                          });
                        },
                        child: Container(
                          color: _currentIndex == 0
                              ? kPrimaryColor
                              : const Color(0xff3C3C3C),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.star,
                                color: Colors.white,
                              ),
                              Text(
                                "Favorites",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            Container(
              height: 16.0,
              color: kPrimaryColor,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _currentIndex == 0
          ? SizedBox(
              width: 100,
              height: 45,
              child: FloatingActionButton(
                backgroundColor: kGreenColor,
                shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.zero),
                onPressed: () {
                  if (_currentTeamIndex == 4) {
                    setState(() {
                      _currentTeamIndex = 0;
                    });
                  } else {
                    setState(() {
                      _currentTeamIndex++;
                    });
                  }
                },
                child: const Text("next Match"),
              ),
            )
          : Container(),
    );
  }
}
