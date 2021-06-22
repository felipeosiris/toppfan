import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const leftMargin = 40.0;

//Esta clase es un plus que quise agregar para contextualizar la vista de gradas y tambien para mostrar un poco de lo que aprendi
//de animaciones y trasnformaciones, este es un codigo que ya tenia creado solo lo adapte para ayudar un poco mas al ejemplo sin embargo
//me gustaria mencionar que siempre es de mi agrado agregar animaciones a mis aplicaciones
class Stadium {
  final int price;
  final String available;
  final String name;
  final String image;
  final Color color;
  final Color textColor;

  const Stadium({
    this.price,
    this.available,
    this.name,
    this.image,
    this.color,
    this.textColor,
  });
}

const stadiums = [
  const Stadium(
      price: 590,
      name: 'Estadio uno',
      available: 'Comprar',
      color: Colors.black,
      textColor: Colors.white,
      image:
          'https://lh3.googleusercontent.com/proxy/C9zfzScSynQpSxtczEy38NmyveGzNmqWi9rOJVZanWBzlwFo2L_2OfWzSDZn4kq7tZexB1dc4AqVRyY69mrWLWPvlxxjzfOMb0XXsTOQPEhN'),
  const Stadium(
      price: 700,
      name: 'Estadio dos',
      available: 'Comprar',
      color: Color(0xFF07205A),
      textColor: Colors.white,
      image:
          'https://interactivo.eluniversal.com.mx/2019/wanda-metropolitano/img/estadio5.png'),
  const Stadium(
      price: 3100,
      name: 'Estadio tres',
      available: 'Comprar',
      color: Color(0xFF6EE897),
      textColor: Colors.black,
      image:
          'https://interactivo.eluniversal.com.mx/2019/wanda-metropolitano/img/estadio7.png'),
  const Stadium(
      price: 4250,
      name: 'Estadio cuatro',
      available: 'Comprar',
      color: Color(0xFF743AD6),
      textColor: Colors.white,
      image: 'https://ec.all.biz/img/ec/catalog/9199.png'),
];

class StadiumPage extends StatefulWidget {
  @override
  _StadiumPageState createState() => _StadiumPageState();
}

class _StadiumPageState extends State<StadiumPage> {
  final _priceNotifier = ValueNotifier<int>(stadiums.first.price);

  final _pageController = PageController(viewportFraction: 0.9);

  final _pageNotifier = ValueNotifier<double>(0.0);

  Widget _buildHeader() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: leftMargin),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Comprar boletos',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 26,
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.grey[400],
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Divider()
      ],
    );
  }

  Widget _buildBottomNavigationBar() => BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[300],
        elevation: 4,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.home,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.shopping_basket,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.shopping_cart,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.wb_sunny,
            ),
          )
        ],
      );

  Widget _buildBottomWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: leftMargin),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(
                  'https://media-exp3.licdn.com/dms/image/C4E03AQEHwUV3apMhVA/profile-displayphoto-shrink_200_200/0/1616745020571?e=1628726400&v=beta&t=f_x2ef5vABCV84WE5y0YTHDpK7qR2qmxbqebzwOr5xg'),
            ),
            title: Text(
              'Felipe Mendoza',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              'Flutter Developer',
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  void _listener() {
    _pageNotifier.value = _pageController.page;
    setState(() {});
  }

  @override
  void initState() {
    lastPrice = stadiums.first.price;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.addListener(_listener);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_listener);
    _pageController.dispose();
    _pageNotifier.dispose();
    _priceNotifier.dispose();
    super.dispose();
  }

  int lastPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: _buildBottomNavigationBar(),
          body: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 46),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          width: MediaQuery.of(context).size.width / 3,
                          bottom: 20,
                          child: Padding(
                            padding: const EdgeInsets.only(left: leftMargin),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 10,
                                ),
                                ValueListenableBuilder<int>(
                                    valueListenable: _priceNotifier,
                                    builder: (context, value, child) {
                                      return TweenAnimationBuilder<int>(
                                        duration:
                                            const Duration(milliseconds: 200),
                                        tween: IntTween(
                                            begin: lastPrice, end: value),
                                        builder:
                                            (context, animationValue, child) {
                                          return Text(
                                            "\$$animationValue",
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey[700],
                                            ),
                                          );
                                        },
                                      );
                                    }),
                                Spacer(),
                                Text(
                                  'Boletos disponibles',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                        ValueListenableBuilder<double>(
                          valueListenable: _pageNotifier,
                          builder: (context, value, child) => PageView.builder(
                            controller: _pageController,
                            itemCount: stadiums.length,
                            onPageChanged: (index) {
                              //every time the page changed, get the current page and get the price from the balls array
                              //update the value to the notifier and object inside [ValueListenableBuilder] will rebuild
                              _priceNotifier.value = stadiums[index].price;
                              lastPrice = stadiums[index].price;
                            },
                            itemBuilder: (context, index) {
                              final lerp = lerpDouble(
                                  1, 0, (index - _pageNotifier.value).abs());

                              double opacity = lerpDouble(1.0, 0.0,
                                  (index - _pageNotifier.value).abs());
                              opacity = opacity < 0 ? 0 : opacity;
                              return Opacity(
                                opacity: opacity,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8.0,
                                              left: 20,
                                            ),
                                            child: Hero(
                                              tag:
                                                  'hero_text_${stadiums[index].name}',
                                              child: Material(
                                                color: Colors.transparent,
                                                child: Text(
                                                  stadiums[index]
                                                      .name
                                                      .split(" ")
                                                      .join("\n"),
                                                  maxLines: 2,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black,
                                                    fontSize: 24,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              // Navigator.of(context)
                                              //     .push(PageRouteBuilder(
                                              //   transitionDuration:
                                              //       const Duration(
                                              //           milliseconds: 800),
                                              //   pageBuilder: (_, animation, __) =>
                                              //       FadeTransition(
                                              //     opacity: animation,
                                              //     child: SportsStoreDetailPage(
                                              //       ball: balls[index],
                                              //     ),
                                              //   ),
                                              // ));
                                            },
                                            child: Hero(
                                              tag:
                                                  'hero_background_${stadiums[index].name}',
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: stadiums[index].color,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            30),
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      child: InkWell(
                                                        onTap: () {
                                                          Get.back();
                                                        },
                                                        child: Text(
                                                          stadiums[index]
                                                              .available
                                                              .split(" ")
                                                              .join("\n"),
                                                          maxLines: 2,
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            color:
                                                                stadiums[index]
                                                                    .textColor,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Center(
                                      child: Transform.scale(
                                        alignment: Alignment.centerRight,
                                        scale: lerp,
                                        child: Hero(
                                          tag:
                                              'hero_ball_${stadiums[index].name}',
                                          child: Image.network(
                                            stadiums[index].image,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _buildBottomWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
