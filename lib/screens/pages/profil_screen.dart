import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:skripsi_rapor_sd/screens/pages/profil_pages/profil.dart';
import 'package:skripsi_rapor_sd/screens/pages/profil_pages/visimisi.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ProfilSklh extends StatefulWidget {
  const ProfilSklh({Key? key}) : super(key: key);

  @override
  State<ProfilSklh> createState() => _ProfilSklhState();
}

class _ProfilSklhState extends State<ProfilSklh> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final List<Widget> imageSliders = [
    Image.asset('assets/images/profil1.jpg'),
    Image.asset('assets/images/profil2.jpg'),
    Image.asset('assets/images/profil3.jpg'),
    Image.asset('assets/images/profil4.jpg'),
    Image.asset('assets/images/profil5.jpg'),
  ];

  late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();
    const url = 'https://www.youtube.com/watch?v=SVGKwjU_r28&t=79s';
    controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url)!,
      flags: const YoutubePlayerFlags(
        mute: false,
        loop: false,
        autoPlay: false,
      ),
    );
  }

  @override
  void deactivate() {
    controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: controller,
        ),
        builder: (context, player) => Scaffold(
          appBar: NewGradientAppBar(
            title: const Text(
              'Profil Sekolah',
              style: TextStyle(fontFamily: 'Montserrat Medium'),
            ),
            gradient: const LinearGradient(
                colors: [Colors.green, Colors.cyan, Colors.blue]),
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back)),
          ),
          body: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CarouselSlider(
                      items: imageSliders,
                      carouselController: _controller,
                      options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 1.5,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _current = index;
                            });
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imageSliders.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => _controller.animateToPage(entry.key),
                          child: Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.only(
                                bottom: 12, left: 4, right: 4),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.lightBlue)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                Card(
                  margin: const EdgeInsets.only(top: 30),
                  elevation: 8,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  child: Stack(
                    children: [
                      Ink.image(
                        image:
                            const AssetImage('assets/images/profilcard2.jpg'),
                        height: 240,
                        fit: BoxFit.cover,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ProfilSD()));
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        right: 24,
                        child: Text(
                          'Profil Sekolah',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Card(
                  margin: const EdgeInsets.only(top: 40),
                  elevation: 8,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Ink.image(
                        image: const AssetImage('assets/images/profilcard.jpg'),
                        height: 240,
                        fit: BoxFit.cover,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const VisiMisi()));
                          },
                        ),
                      ),
                      Text(
                        'Visi dan Misi\nSDN 2 Winduherang',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/youtube.png',
                        width: 200,
                        height: 40,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      player,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
