import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomFooter extends StatelessWidget {
  const CustomFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
       //color: Color(0xFF22E5FF),
        color: Color(0xFF0F3460),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo on the left
          Image.asset(
            'assets/logo.png',
            height: 30,
            width: 30,
          ),

          // Contact info and social icons on the right
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text(
                    'Contact',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Email: info@lostandfound.com',
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.white
                    ),
                  ),
                ],
              ),
              SizedBox(width: width * 0.03),
              Row(
                children: [
                  Container(
                    height: height* 0.06,
                    width: width * 0.08,
                    //color: Colors.red,
                    child: Center(child: FaIcon(FontAwesomeIcons.twitter)),
                  ),
                  Container(
                    height: height* 0.06,
                    width: width * 0.08,
                    //color: Colors.red,
                    child: Center(child: FaIcon(FontAwesomeIcons.facebook)),
                  ),
                  Container(
                    height: height* 0.06,
                    width: width * 0.08,
                    //color: Colors.red,
                    child: Center(child: FaIcon(FontAwesomeIcons.instagram)),
                  ),
                  Container(
                    height: height* 0.06,
                    width: width * 0.08,
                    //color: Colors.red,
                    child: Center(child: FaIcon(FontAwesomeIcons.globe)),
                  )
                  // IconButton(
                  //   icon: const FaIcon(FontAwesomeIcons.twitter, size: 16),
                  //   onPressed: () {},
                  //   //constraints: const BoxConstraints(),
                  //   //padding: const EdgeInsets.all(1),
                  // ),
                  // IconButton(
                  //   icon: const FaIcon(FontAwesomeIcons.facebook, size: 16),
                  //   onPressed: () {},
                  //   //constraints: const BoxConstraints(),
                  //   //padding: const EdgeInsets.all(1),
                  // ),
                  // IconButton(
                  //   icon: const FaIcon(FontAwesomeIcons.instagram, size: 16),
                  //   onPressed: () {},
                  //   //constraints: const BoxConstraints(),
                  //   //padding: const EdgeInsets.all(1),
                  // ),
                  // IconButton(
                  //   icon: const FaIcon(FontAwesomeIcons.globe, size: 16),
                  //   onPressed: () {},
                  //   //constraints: const BoxConstraints(),
                  //   //padding: const EdgeInsets.all(1),
                  // ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}