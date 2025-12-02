// import 'package:flutter/material.dart';
// import '/screens/login_screen.dart';
// import '/widgets/app_drawer.dart';
// import '/widgets/custom_footer.dart';
// import '/widgets/custom_header.dart';
//
// class GetStartedScreen extends StatelessWidget {
//   const GetStartedScreen({Key? key}) : super(key: key);
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
//             colors: [Color(0xFF1A1A2E), Color(0xFF16213E),Color(0xFF0F3460)],
//           ),
//         ),
//         child: Column(
//           children: [
//             CustomHeader(
//               scaffoldKey: scaffoldKey,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 20),
//                   const Text(
//                     'Lost & Found',
//                     style: TextStyle(
//                       fontSize: 36,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   const Text(
//                     'Recover with Ease',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 20), // Reduced space
//                   Image.asset(
//                     'assets/airplane.png',
//                     height: 240,
//                     fit: BoxFit.contain,
//                   ),
//                   const SizedBox(height: 30), // Reduced space
//                   MouseRegion(
//                     cursor: SystemMouseCursors.click,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const LoginScreen(),
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF6A3DE8),
//                         minimumSize: const Size(200, 50),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                       ).copyWith(
//                         overlayColor: WidgetStateProperty.resolveWith<Color?>(
//                               (Set<WidgetState> states) {
//                             if (states.contains(WidgetState.hovered))
//                               return Colors.deepPurple.withOpacity(0.8);
//                             return null;
//                           },
//                         ),
//                         elevation: WidgetStateProperty.resolveWith<double>(
//                               (Set<MaterialState> states) {
//                             if (states.contains(MaterialState.hovered))
//                               return 8;
//                             return 4;
//                           },
//                         ),
//                       ),
//                       child: const Text(
//                         'Get Started',
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 40),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 97),
//               child: const CustomFooter(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import '/screens/login_screen.dart';
import '/widgets/app_drawer.dart';
import '/widgets/custom_footer.dart';
import '/widgets/custom_header.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late AnimationController _floatController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _floatAnimation;

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

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _floatController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.elasticOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.bounceOut,
    ));

    _floatAnimation = Tween<double>(
      begin: -15.0,
      end: 15.0,
    ).animate(CurvedAnimation(
      parent: _floatController,
      curve: Curves.easeInOut,
    ));

    // Start animations
    _fadeController.forward();
    _slideController.forward();
    _scaleController.forward();
    _floatController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    _floatController.dispose();
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
        height: size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A1A2E),
              Color(0xFF16213E),
              Color(0xFF0F3460),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Animated background elements
            _buildBackgroundElements(),

            // Main content
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                constraints: BoxConstraints(
                  minHeight: size.height,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        CustomHeader(
                          scaffoldKey: scaffoldKey,
                        ),
                        _buildMainContent(context),
                      ],
                    ),
                    const CustomFooter(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundElements() {
    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Stack(
          children: [
            // Floating particles
            Positioned(
              top: 100,
              right: -50,
              child: Transform.translate(
                offset: Offset(0, _floatAnimation.value),
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF00DBDE).withOpacity(0.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              top: 300,
              left: -30,
              child: Transform.translate(
                offset: Offset(0, -_floatAnimation.value * 0.7),
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFFFC00FF).withOpacity(0.08),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 150,
              right: 30,
              child: Transform.translate(
                offset: Offset(0, _floatAnimation.value * 0.5),
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        Colors.white.withOpacity(0.05),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMainContent(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width <= 600;

    return Padding(
      padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: isMobile ? 20 : 40),

          // Animated title section
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Column(
                children: [
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [
                          Color(0xFF00DBDE),
                          Color(0xFFFC00FF),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: const Text(
                        'Lost & Found',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                          height: 1.2,
                          color:Colors.white
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Reconnect with What Matters',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                      color: Colors.white.withOpacity(0.9),
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: isMobile ? 30 : 50),

          // Feature illustration with icons
          FadeTransition(
            opacity: _fadeAnimation,
            child: _buildFeatureIllustration(),
          ),

          SizedBox(height: isMobile ? 30 : 50),

          // Feature highlights
          FadeTransition(
            opacity: _fadeAnimation,
            child: _buildFeatureHighlights(),
          ),

          SizedBox(height: isMobile ? 30 : 40),

          // Animated get started button
          ScaleTransition(
            scale: _scaleAnimation,
            child: _buildGetStartedButton(),
          ),

          SizedBox(height: isMobile ? 40 : 60),
        ],
      ),
    );
  }

  Widget _buildFeatureIllustration() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildAnimatedFeatureIcon(
            Icons.search_rounded,
            'Report Lost',
            const Color(0xFF00DBDE),
            0.2,
          ),
          _buildAnimatedConnector(),
          _buildAnimatedFeatureIcon(
            Icons.auto_awesome_rounded,
            'Find & Match',
            const Color(0xFFFC00FF),
            0.4,
          ),
          _buildAnimatedConnector(),
          _buildAnimatedFeatureIcon(
            Icons.handshake_rounded,
            'Reunite',
            const Color(0xFF00DBDE),
            0.6,
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedFeatureIcon(IconData icon, String label, Color color, double delay) {
    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnimation.value * (0.5 + delay)),
          child: Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color.withOpacity(0.8),
                      color.withOpacity(0.5),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnimatedConnector() {
    return AnimatedBuilder(
      animation: _fadeController,
      builder: (context, child) {
        return Container(
          height: 2,
          width: 30,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF00DBDE).withOpacity(0.5),
                Colors.white.withOpacity(0.8),
                const Color(0xFFFC00FF).withOpacity(0.5),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeatureHighlights() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _buildHighlightRow(
            Icons.security_rounded,
            'Secure & Trusted',
            'Your data is protected with enterprise-grade security',
          ),
          const SizedBox(height: 16),
          _buildHighlightRow(
            Icons.bolt_rounded,
            'Lightning Fast',
            'AI-powered matching finds items in seconds',
          ),
          const SizedBox(height: 16),
          _buildHighlightRow(
            Icons.people_rounded,
            'Community Driven',
            'Join thousands helping each other find lost belongings',
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightRow(IconData icon, String title, String description) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.15),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF0F3460).withOpacity(0.6),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
              ),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGetStartedButton() {
    bool isHovering = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return AnimatedBuilder(
          animation: _floatAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _floatAnimation.value * 0.3),
              child: MouseRegion(
                onEnter: (_) => setState(() => isHovering = true),
                onExit: (_) => setState(() => isHovering = false),
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                        const LoginScreen(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: animation.drive(
                              Tween(begin: const Offset(1.0, 0.0), end: Offset.zero),
                            ),
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 300),
                      ),
                    );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: isHovering
                            ? [const Color(0xFF00DBDE), const Color(0xFFFC00FF)]
                            : [const Color(0xFF00DBDE).withOpacity(0.9), const Color(0xFFFC00FF).withOpacity(0.9)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (isHovering ? const Color(0xFF00DBDE) : const Color(0xFFFC00FF))
                              .withOpacity(0.5),
                          blurRadius: isHovering ? 30 : 15,
                          offset: Offset(0, isHovering ? 10 : 5),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Icon(
                            Icons.arrow_forward_rounded,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}