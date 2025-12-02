import 'package:flutter/material.dart';
import '/widgets/app_drawer.dart';
import '/widgets/custom_footer.dart';
import '/widgets/custom_header.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      endDrawer: const AppDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF22E5FF), Color(0xFF3E7ACF)],
          ),
        ),
        child: Column(
          children: [
            CustomHeader(
              scaffoldKey: scaffoldKey,
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    left: 10,
                    top: 10,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        // User profiles grid
                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          children: List.generate(4, (index) {
                            return Column(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.purple[100],
                                  child: const Icon(Icons.person, size: 40, color: Colors.black54),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Name',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            );
                          }),
                        ),
                        const SizedBox(height: 30),
                        // Mission statement
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: const [
                              Text(
                                'Our Mission',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 15),
                              Text(
                                'Our mission is to create a reliable and efficient platform for reuniting lost items with their rightful owners. We aim to foster a supportive community where users can easily report, search, and recover lost belongings, enhancing trust and cooperation among individuals. By leveraging technology, we strive to reduce the time, effort, and stress associated with finding lost items, ensuring a seamless and satisfying experience for all our users.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const CustomFooter(),
          ],
        ),
      ),
    );
  }
}