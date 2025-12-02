// import 'package:flutter/material.dart';
// import 'package:final_year_project/screens//lost_found_screen.dart';
// import '/widgets/app_drawer.dart';
// import '/widgets/custom_footer.dart';
// import '/widgets/custom_header.dart';
//
// class WelcomeScreen extends StatefulWidget {
//   const WelcomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<WelcomeScreen> createState() => _WelcomeScreenState();
// }
//
// class _WelcomeScreenState extends State<WelcomeScreen> {
//   bool _isHovering = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//
//     return Scaffold(
//       key: scaffoldKey,
//       endDrawer: const AppDrawer(),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Color(0xFF22E5FF), Color(0xFF3E7ACF)],
//           ),
//         ),
//         child: Column(
//           children: [
//             CustomHeader(
//               scaffoldKey: scaffoldKey,
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Stack(
//                   children: [
//                     Positioned(
//                       left: 10,
//                       top: 10,
//                       child: IconButton(
//                         icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Column(
//                         children: [
//                           // Wrapping with GestureDetector to ensure navigation works
//                           GestureDetector(
//                             onTap: () {
//                               print("Navigating to LostFoundScreen...");
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => const LostFoundScreen(),
//                                 ),
//                               );
//                             },
//                             child: MouseRegion(
//                               cursor: SystemMouseCursors.click,
//                               onEnter: (_) => setState(() => _isHovering = true),
//                               onExit: (_) => setState(() => _isHovering = false),
//                               child: AnimatedContainer(
//                                 duration: const Duration(milliseconds: 200),
//                                 width: double.infinity,
//                                 margin: const EdgeInsets.only(top: 20),
//                                 padding: const EdgeInsets.all(20),
//                                 decoration: BoxDecoration(
//                                   color: _isHovering
//                                       ? const Color(0xFF2196F3)
//                                       : const Color(0xFF4FC3F7),
//                                   borderRadius: BorderRadius.circular(10),
//                                   boxShadow: _isHovering
//                                       ? [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity(0.3),
//                                       blurRadius: 10,
//                                       offset: const Offset(0, 5),
//                                     )
//                                   ]
//                                       : [],
//                                   border: _isHovering
//                                       ? Border.all(color: Colors.white, width: 2)
//                                       : null,
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     Text(
//                                       'Welcome to Our Lost and Found Website!',
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                         color: _isHovering ? Colors.white : Colors.black,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 15),
//                                     Text(
//                                       'We re excited to help you find and recover lost items. Easily report lost belongings, search for found items, and connect with others. Our user-friendly platform aims to reunite you with your lost possessions quickly and efficiently.',
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         color: _isHovering ? Colors.white : Colors.black,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 15),
//                                     Text(
//                                       'Thank you for choosing our service. If you need assistance, feel free to contact us.',
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         color: _isHovering ? Colors.white : Colors.black,
//                                       ),
//                                     ),
//                                     const SizedBox(height: 10),
//                                     Text(
//                                       'Happy searching and best of luck!',
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.bold,
//                                         color: _isHovering ? Colors.white : Colors.black,
//                                       ),
//                                     ),
//                                     if (_isHovering) ...[
//                                       const SizedBox(height: 15),
//                                       const Text(
//                                         'Click to continue',
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ],
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 30),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: const [
//                               Text(
//                                 'Find &',
//                                 style: TextStyle(
//                                   fontSize: 40,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               Text(
//                                 'Recover',
//                                 style: TextStyle(
//                                   fontSize: 40,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                               Text(
//                                 'With Ease',
//                                 style: TextStyle(
//                                   fontSize: 40,
//                                   fontWeight: FontWeight.bold,
//                                   color: Color(0xFF006400),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 40),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const CustomFooter(),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//





import 'package:flutter/material.dart';
import 'package:final_year_project/screens/lost_found_screen.dart';
import '/widgets/app_drawer.dart';
import '/widgets/custom_footer.dart';
import '/widgets/custom_header.dart';
import 'dart:math';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  bool _isHovering = false;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _backgroundController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _backgroundAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _backgroundController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    _backgroundAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _backgroundController, curve: Curves.linear),
    );

    // Start animations
    _fadeController.forward();
    _slideController.forward();
    _backgroundController.repeat();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1024;
    final isTablet = size.width > 600 && size.width <= 1024;
    final isMobile = size.width <= 600;

    return Scaffold(
      key: scaffoldKey,
      endDrawer: const AppDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF1A1A2E),
              const Color(0xFF16213E),
              const Color(0xFF0F3460),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: Column(
          children: [
            CustomHeader(scaffoldKey: scaffoldKey),
            Expanded(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Stack(
                      children: [
                        // Animated background particles
                        Positioned.fill(
                          child: AnimatedBuilder(
                            animation: _backgroundAnimation,
                            builder: (context, child) {
                              return CustomPaint(
                                painter: BackgroundPainter(_backgroundAnimation.value),
                                size: Size.infinite,
                              );
                            },
                          ),
                        ),

                        // Back button
                        Positioned(
                          left: 24,
                          top: 24,
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1.5,
                                ),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 16.0 : 24.0,
                            vertical: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: isMobile ? 40 : 60),

                              // Hero Title Section
                              FadeTransition(
                                opacity: _fadeAnimation,
                                child: SlideTransition(
                                  position: _slideAnimation,
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(24),
                                        ),
                                        child: Text(
                                          '🔍',
                                          style: TextStyle(
                                            fontSize: isDesktop ? 64 : (isTablet ? 48 : 40),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      ShaderMask(
                                        shaderCallback: (bounds) => const LinearGradient(
                                          colors: [
                                            Color(0xFF00DBDE),
                                            Color(0xFFFC00FF),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ).createShader(bounds),
                                        child: Text(
                                          'Find & Recover',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: isDesktop ? 56 : (isTablet ? 42 : 32),
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: 1.5,
                                            height: 1.2,
                                            color: Colors.white
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        'With Magical Ease ✨',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: isDesktop ? 24 : (isTablet ? 20 : 16),
                                          fontWeight: FontWeight.w300,
                                          color: Colors.white.withOpacity(0.9),
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: isMobile ? 40 : 60),

                              // Main Interactive Card
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LostFoundScreen(),
                                    ),
                                  );
                                },
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  onEnter: (_) => setState(() => _isHovering = true),
                                  onExit: (_) => setState(() => _isHovering = false),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInOut,
                                    width: double.infinity,
                                    constraints: BoxConstraints(
                                      maxWidth: isDesktop ? 700 : double.infinity,
                                    ),
                                    padding: EdgeInsets.all(isMobile ? 24 : 32),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                      border: Border.all(
                                        color: _isHovering
                                            ? const Color(0xFF00DBDE).withOpacity(0.6)
                                            : Colors.white.withOpacity(0.15),
                                        width: 1.5,
                                      ),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.white.withOpacity(_isHovering ? 0.08 : 0.05),
                                          Colors.white.withOpacity(_isHovering ? 0.03 : 0.01),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.4),
                                          blurRadius: 30,
                                          offset: const Offset(0, 20),
                                        ),
                                        if (_isHovering)
                                          BoxShadow(
                                            color: const Color(0xFF00DBDE).withOpacity(0.3),
                                            blurRadius: 50,
                                            spreadRadius: 2,
                                            offset: const Offset(0, 15),
                                          ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.auto_awesome,
                                              color: const Color(0xFFFC00FF),
                                              size: isMobile ? 24 : 28,
                                            ),
                                            const SizedBox(width: 16),
                                            Flexible(
                                              child: Text(
                                                'Welcome to the Future of Lost & Found!',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: isMobile ? 20 : 24,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: isMobile ? 20 : 24),

                                        Text(
                                          'Experience the next generation of item recovery! Our AI-powered platform uses advanced matching algorithms to reunite you with your lost treasures faster than ever before.',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: isMobile ? 14 : 16,
                                            color: Colors.white.withOpacity(0.85),
                                            height: 1.6,
                                          ),
                                        ),

                                        SizedBox(height: isMobile ? 16 : 20),

                                        Wrap(
                                          spacing: 12,
                                          runSpacing: 8,
                                          children: [
                                            _buildFeatureTag(
                                              Icons.rocket_launch,
                                              '99% Success Rate',
                                              isMobile,
                                            ),
                                            _buildFeatureTag(
                                              Icons.bolt,
                                              'Lightning Fast',
                                              isMobile,
                                            ),
                                            _buildFeatureTag(
                                              Icons.security,
                                              'Secure Platform',
                                              isMobile,
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: isMobile ? 20 : 24),

                                        AnimatedContainer(
                                          duration: const Duration(milliseconds: 300),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: isMobile ? 32 : 40,
                                            vertical: isMobile ? 14 : 18,
                                          ),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: _isHovering
                                                  ? [
                                                const Color(0xFF00DBDE),
                                                const Color(0xFFFC00FF),
                                              ]
                                                  : [
                                                const Color(0xFF00DBDE).withOpacity(0.8),
                                                const Color(0xFFFC00FF).withOpacity(0.8),
                                              ],
                                              stops: [0.1, 0.9],
                                            ),
                                            borderRadius: BorderRadius.circular(30),
                                            boxShadow: [
                                              BoxShadow(
                                                color: (_isHovering ? const Color(0xFF00DBDE) : const Color(0xFFFC00FF))
                                                    .withOpacity(0.4),
                                                blurRadius: 15,
                                                offset: const Offset(0, 6),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Start Your Journey',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: isMobile ? 16 : 18,
                                                  letterSpacing: 0.8,
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Icon(
                                                Icons.arrow_forward_rounded,
                                                color: Colors.white,
                                                size: isMobile ? 20 : 24,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: isMobile ? 40 : 60),

                              // Feature Cards
                              FadeTransition(
                                opacity: _fadeAnimation,
                                child: GridView.count(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  crossAxisCount: isDesktop ? 3 : (isTablet ? 2 : 1),
                                  mainAxisSpacing: 20,
                                  crossAxisSpacing: 20,
                                  childAspectRatio: 1.1,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 0 : 24,
                                  ),
                                  children: [
                                    _buildFeatureCard(
                                      Icons.search_off_rounded,
                                      'Smart Matching',
                                      'AI-powered item recognition with deep learning',
                                      isDesktop,
                                      isMobile,
                                    ),
                                    _buildFeatureCard(
                                      Icons.notifications_active_rounded,
                                      'Instant Alerts',
                                      'Real-time notifications when matches are found',
                                      isDesktop,
                                      isMobile,
                                    ),
                                    _buildFeatureCard(
                                      Icons.enhanced_encryption_rounded,
                                      'Secure Platform',
                                      'Military-grade encryption for your privacy',
                                      isDesktop,
                                      isMobile,
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: isMobile ? 60 : 80),
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

  Widget _buildFeatureTag(IconData icon, String text, bool isMobile) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF0F3460).withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.15),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: isMobile ? 16 : 18,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: isMobile ? 12 : 14,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, String subtitle, bool isDesktop, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF0F3460).withOpacity(0.4),
            const Color(0xFF16213E).withOpacity(0.4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF00DBDE).withOpacity(0.3),
                  const Color(0xFFFC00FF).withOpacity(0.3),
                ],
              ),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: isMobile ? 32 : 40,
            ),
          ),
          SizedBox(height: isMobile ? 16 : 24),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: isMobile ? 18 : 20,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: isMobile ? 8 : 12),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: isMobile ? 14 : 16,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final double animationValue;

  BackgroundPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.03)
      ..style = PaintingStyle.fill;

    // Draw animated floating particles
    for (int i = 0; i < 15; i++) {
      final double x = (i * 137.5) % size.width;
      final double y = (i * 89.3) % size.height;
      final double radius = 2 + (animationValue * 3) + (i % 2) * 1.5;

      // Animated movement
      final double offsetX = sin(animationValue * 2 + i) * 20;
      final double offsetY = cos(animationValue * 3 + i) * 15;

      paint.color = Colors.white.withOpacity(0.05 + (i % 5) * 0.01);
      canvas.drawCircle(Offset(x + offsetX, y + offsetY), radius, paint);
    }
  }

  @override
  bool shouldRepaint(BackgroundPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}