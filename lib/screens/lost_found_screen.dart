import 'package:flutter/material.dart';
import '/screens/report_screen.dart';
import '/widgets/app_drawer.dart';
import '/widgets/custom_footer.dart';
import '/widgets/custom_header.dart';

class LostFoundScreen extends StatefulWidget {
  const LostFoundScreen({Key? key}) : super(key: key);

  @override
  State<LostFoundScreen> createState() => _LostFoundScreenState();
}

class _LostFoundScreenState extends State<LostFoundScreen> {
  bool _isHoveringLost = false;
  bool _isHoveringFound = false;

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
            //colors: [Color(0xFF22E5FF), Color(0xFF3E7ACF)],
            colors: [
              const Color(0xFF1A1A2E),
              const Color(0xFF16213E),
              const Color(0xFF0F3460),
            ],
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
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        const Text(
                          'What did you lose or find?',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 60),
                        Center(
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (_) => setState(() => _isHoveringLost = true),
                            onExit: (_) => setState(() => _isHoveringLost = false),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ReportScreen(isLostItem: true),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _isHoveringLost
                                      ? const Color(0xFF00DBDE)
                                      : const Color(0xFFFC00FF),
                                  minimumSize: const Size(200, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  elevation: _isHoveringLost ? 8 : 4,
                                ),
                                child: const Text(
                                  'Lost items',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                        Center(
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (_) => setState(() => _isHoveringFound = true),
                            onExit: (_) => setState(() => _isHoveringFound = false),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ReportScreen(isLostItem: false),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _isHoveringFound
                                      ? const Color(0xFFFC00FF)
                                      : const Color(0xFF00DBDE),
                                  minimumSize: const Size(200, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  elevation: _isHoveringFound ? 8 : 4,
                                ),
                                child: const Text(
                                  'Found items',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: const [
                              Icon(Icons.warning, color: Colors.red, size: 20),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Disclaimer: Do not try to open or investigate objects which seem suspicious.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
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




//
// import 'package:flutter/material.dart';
// import '/screens/report_screen.dart';
// import '/widgets/app_drawer.dart';
// import '/widgets/custom_footer.dart';
// import '/widgets/custom_header.dart';
//
// class LostFoundScreen extends StatefulWidget {
//   const LostFoundScreen({Key? key}) : super(key: key);
//
//   @override
//   State<LostFoundScreen> createState() => _LostFoundScreenState();
// }
//
// class _LostFoundScreenState extends State<LostFoundScreen> {
//   bool _isHoveringLost = false;
//   bool _isHoveringFound = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//     final size = MediaQuery.of(context).size;
//     final isMobile = size.width <= 600;
//
//     return Scaffold(
//       key: scaffoldKey,
//       endDrawer: const AppDrawer(),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color(0xFF1A1A2E),
//               Color(0xFF16213E),
//               Color(0xFF0F3460),
//             ],
//             stops: [0.0, 0.5, 1.0],
//           ),
//         ),
//         child: Column(
//           children: [
//             CustomHeader(
//               scaffoldKey: scaffoldKey,
//             ),
//             Expanded(
//               child: Stack(
//                 children: [
//                   // Back button
//                   Positioned(
//                     left: isMobile ? 16 : 24,
//                     top: isMobile ? 16 : 24,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.1),
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                           color: Colors.white.withOpacity(0.3),
//                           width: 1.5,
//                         ),
//                       ),
//                       child: IconButton(
//                         icon: const Icon(
//                           Icons.arrow_back_ios,
//                           color: Colors.white,
//                           size: 20,
//                         ),
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                       ),
//                     ),
//                   ),
//
//                   // Main content
//                   Padding(
//                     padding: EdgeInsets.all(isMobile ? 16 : 24),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(height: isMobile ? 20 : 40),
//                         ShaderMask(
//                           shaderCallback: (bounds) => const LinearGradient(
//                             colors: [
//                               Color(0xFF00DBDE),
//                               Color(0xFFFC00FF),
//                             ],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ).createShader(bounds),
//                           child: const Text(
//                             'What did you lose or find?',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               fontSize: 32,
//                               fontWeight: FontWeight.w800,
//                               letterSpacing: 1.1,
//                               height: 1.2,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: isMobile ? 30 : 60),
//
//                         // Lost items button
//                         MouseRegion(
//                           cursor: SystemMouseCursors.click,
//                           onEnter: (_) => setState(() => _isHoveringLost = true),
//                           onExit: (_) => setState(() => _isHoveringLost = false),
//                           child: GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => const ReportScreen(isLostItem: true),
//                                 ),
//                               );
//                             },
//                             child: AnimatedContainer(
//                               duration: const Duration(milliseconds: 300),
//                               width: isMobile ? double.infinity : 400,
//                               padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(24),
//                                 gradient: LinearGradient(
//                                   colors: _isHoveringLost
//                                       ? [const Color(0xFF00DBDE), const Color(0xFFFC00FF)]
//                                       : [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.05)],
//                                 ),
//                                 border: Border.all(
//                                   color: _isHoveringLost
//                                       ? const Color(0xFF00DBDE).withOpacity(0.6)
//                                       : Colors.white.withOpacity(0.2),
//                                   width: 1.5,
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.3),
//                                     blurRadius: 20,
//                                     offset: const Offset(0, 10),
//                                   ),
//                                   if (_isHoveringLost)
//                                     BoxShadow(
//                                       color: const Color(0xFF00DBDE).withOpacity(0.4),
//                                       blurRadius: 30,
//                                       spreadRadius: 2,
//                                       offset: const Offset(0, 15),
//                                     ),
//                                 ],
//                               ),
//                               child: Column(
//                                 children: [
//                                   const Icon(
//                                     Icons.search_off_rounded,
//                                     size: 48,
//                                     color: Colors.white,
//                                   ),
//                                   const SizedBox(height: 16),
//                                   const Text(
//                                     'Lost Items',
//                                     style: TextStyle(
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.w700,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 8),
//                                   Text(
//                                     'Report something you\'ve lost',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w300,
//                                       color: Colors.white.withOpacity(0.9),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//
//                         SizedBox(height: isMobile ? 30 : 40),
//
//                         // Found items button
//                         MouseRegion(
//                           cursor: SystemMouseCursors.click,
//                           onEnter: (_) => setState(() => _isHoveringFound = true),
//                           onExit: (_) => setState(() => _isHoveringFound = false),
//                           child: GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => const ReportScreen(isLostItem: false),
//                                 ),
//                               );
//                             },
//                             child: AnimatedContainer(
//                               duration: const Duration(milliseconds: 300),
//                               width: isMobile ? double.infinity : 400,
//                               padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(24),
//                                 gradient: LinearGradient(
//                                   colors: _isHoveringFound
//                                       ? [const Color(0xFF00DBDE), const Color(0xFFFC00FF)]
//                                       : [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.05)],
//                                 ),
//                                 border: Border.all(
//                                   color: _isHoveringFound
//                                       ? const Color(0xFFFC00FF).withOpacity(0.6)
//                                       : Colors.white.withOpacity(0.2),
//                                   width: 1.5,
//                                 ),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black.withOpacity(0.3),
//                                     blurRadius: 20,
//                                     offset: const Offset(0, 10),
//                                   ),
//                                   if (_isHoveringFound)
//                                     BoxShadow(
//                                       color: const Color(0xFFFC00FF).withOpacity(0.4),
//                                       blurRadius: 30,
//                                       spreadRadius: 2,
//                                       offset: const Offset(0, 15),
//                                     ),
//                                 ],
//                               ),
//                               child: Column(
//                                 children: [
//                                   const Icon(
//                                     Icons.find_in_page_rounded,
//                                     size: 48,
//                                     color: Colors.white,
//                                   ),
//                                   const SizedBox(height: 16),
//                                   const Text(
//                                     'Found Items',
//                                     style: TextStyle(
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.w700,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                   const SizedBox(height: 8),
//                                   Text(
//                                     'Report something you\'ve found',
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w300,
//                                       color: Colors.white.withOpacity(0.9),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//
//                         const Spacer(),
//
//                         // Disclaimer
//                         Container(
//                           width: double.infinity,
//                           padding: const EdgeInsets.all(16),
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(16),
//                             border: Border.all(
//                               color: Colors.white.withOpacity(0.2),
//                               width: 1.5,
//                             ),
//                           ),
//                           child: Row(
//                             children: [
//                               Container(
//                                 padding: const EdgeInsets.all(8),
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xFFFF6B6B).withOpacity(0.2),
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: const Icon(
//                                   Icons.warning_amber_rounded,
//                                   color: Color(0xFFFF6B6B),
//                                   size: 24,
//                                 ),
//                               ),
//                               const SizedBox(width: 12),
//                               Expanded(
//                                 child: Text(
//                                   'Disclaimer: Do not try to open or investigate objects which seem suspicious.',
//                                   style: TextStyle(
//                                     fontSize: isMobile ? 12 : 14,
//                                     color: Colors.white.withOpacity(0.9),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: isMobile ? 20 : 30),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const CustomFooter(),
//           ],
//         ),
//       ),
//     );
//   }
// }
