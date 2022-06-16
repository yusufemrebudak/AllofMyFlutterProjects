import 'package:flutter/material.dart';

class MenuDashboard extends StatefulWidget {
  MenuDashboard({Key? key}) : super(key: key);

  @override
  State<MenuDashboard> createState() => _MenuDashboardState();
}

class _MenuDashboardState extends State<MenuDashboard>
    with SingleTickerProviderStateMixin {
  final TextStyle menuStyle =
      const TextStyle(color: Colors.white, fontSize: 20);
  final Color _backgroundColor = const Color(0xFF343442);
  late double ekranYukseklik;
  late double ekranGenislik;
  bool menuAcikMi = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _scaleMenuAnimation;

  late Animation<Offset> _menuOffsetAnimation;
  final Duration _duration = const Duration(milliseconds: 350);
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _scaleAnimation = Tween(begin: 1.0, end: 0.7).animate(_controller);
    _scaleMenuAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _menuOffsetAnimation =
        Tween(begin: const Offset(-1, 0), end: const Offset(0, 0))
            .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ekranYukseklik = MediaQuery.of(context).size.height;
    ekranGenislik = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: Stack(
          // menu ve dashboardı üst üste koyacağımız için stack kullanmamız lazım
          children: [menuOlustur(), dashboardOlustur()],
        ),
      ),
    );
  }

  Widget menuOlustur() {
    return SlideTransition(
      position:_menuOffsetAnimation,
      child: ScaleTransition(
        scale: _scaleMenuAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dashboard",
                  style: menuStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Mesajlar",
                  style: menuStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Utility Bills",
                  style: menuStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Fund Transfer",
                  style: menuStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Branches",
                  style: menuStyle,
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboardOlustur() {
    return AnimatedPositioned(
      top: 0,
      bottom: 0,
      left: menuAcikMi ? 0.3 * ekranGenislik : 0,
      right: menuAcikMi ? -0.3 * ekranGenislik : 0,
      duration: _duration,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: _backgroundColor,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (menuAcikMi) {
                              _controller.reverse();
                            } else {
                              _controller.forward();
                            }
                            menuAcikMi = !menuAcikMi;
                          });
                        },
                        child: const Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "My Favorite Cars",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      const Icon(
                        Icons.add_circle_outline,
                        color: Colors.white,
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    height: 300,
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          color: Colors.pink,
                          width: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        Container(
                          color: Colors.purple,
                          width: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        Container(
                          color: Colors.teal,
                          width: 100,
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                        )
                      ],
                    ),
                  )
                  ,SizedBox(height: 10,),
                ListView.separated(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: 50,
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Icon(Icons.person),
                      title: Text("Ogrenci:$index"),
                      trailing: Icon(Icons.add),
                    );
                  },
                ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
