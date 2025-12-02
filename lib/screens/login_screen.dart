//
//
//
//
//
//
//
//
//
//
//
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '/screens/register_screen.dart';
// import '/screens/welcome_screen.dart';
// import '/widgets/app_drawer.dart';
// import '/widgets/custom_footer.dart';
// import '/widgets/custom_header.dart';
// import '/services/auth_service.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   bool _obscureText = true;
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//   final AuthService _authService = AuthService();
//   bool _isLoading = false;
//   String? _errorMessage;
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _signIn() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });
//
//     try {
//       await _authService.signInWithEmailAndPassword(
//         _emailController.text.trim(),
//         _passwordController.text,
//       );
//
//       if (mounted) {
//         Navigator.pushReplacementNamed(context, '/welcome');
//       }
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         switch (e.code) {
//           case 'user-not-found':
//             _errorMessage = 'No user found with this email.';
//             break;
//           case 'wrong-password':
//             _errorMessage = 'Wrong password provided.';
//             break;
//           case 'invalid-email':
//             _errorMessage = 'The email address is not valid.';
//             break;
//           case 'user-disabled':
//             _errorMessage = 'This user has been disabled.';
//             break;
//           default:
//             _errorMessage = 'An error occurred: ${e.message}';
//         }
//       });
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'An unexpected error occurred.';
//       });
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
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
//               child: Stack(
//                 children: [
//                   // Back arrow
//                   Positioned(
//                     left: 10,
//                     top: 10,
//                     child: IconButton(
//                       icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ),
//                   Center(
//                     child: SingleChildScrollView(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.all(20.0),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.2),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             const Text(
//                               'Login',
//                               style: TextStyle(
//                                 fontSize: 28,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                             ),
//                             const SizedBox(height: 30),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Email',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 TextField(
//                                   controller: _emailController,
//                                   keyboardType: TextInputType.emailAddress,
//                                   decoration: InputDecoration(
//                                     filled: true,
//                                     fillColor: Colors.white,
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(5),
//                                       borderSide: BorderSide.none,
//                                     ),
//                                     contentPadding: const EdgeInsets.symmetric(
//                                       horizontal: 16,
//                                       vertical: 14,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 20),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Password',
//                                   style: TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w500,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 8),
//                                 TextField(
//                                   controller: _passwordController,
//                                   obscureText: _obscureText,
//                                   decoration: InputDecoration(
//                                     filled: true,
//                                     fillColor: Colors.white,
//                                     border: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(5),
//                                       borderSide: BorderSide.none,
//                                     ),
//                                     contentPadding: const EdgeInsets.symmetric(
//                                       horizontal: 16,
//                                       vertical: 14,
//                                     ),
//                                     suffixIcon: IconButton(
//                                       icon: Icon(
//                                         _obscureText
//                                             ? Icons.visibility_off
//                                             : Icons.visibility,
//                                         color: Colors.grey,
//                                       ),
//                                       onPressed: () {
//                                         setState(() {
//                                           _obscureText = !_obscureText;
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             if (_errorMessage != null)
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 10.0),
//                                 child: Text(
//                                   _errorMessage!,
//                                   style: const TextStyle(
//                                     color: Colors.red,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ),
//                             const SizedBox(height: 30),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 ElevatedButton(
//                                   onPressed: _isLoading ? null : _signIn,
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.black,
//                                     minimumSize: const Size(120, 40),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(5),
//                                     ),
//                                   ).copyWith(
//                                     overlayColor: MaterialStateProperty.resolveWith<Color?>(
//                                           (Set<MaterialState> states) {
//                                         if (states.contains(MaterialState.hovered))
//                                           return Colors.grey.withOpacity(0.4);
//                                         return null;
//                                       },
//                                     ),
//                                   ),
//                                   child: _isLoading
//                                       ? const SizedBox(
//                                     width: 20,
//                                     height: 20,
//                                     child: CircularProgressIndicator(
//                                       color: Colors.white,
//                                       strokeWidth: 2,
//                                     ),
//                                   )
//                                       : const Text('Sign In'),
//                                 ),
//                                 ElevatedButton(
//                                   onPressed: _isLoading
//                                       ? null
//                                       : () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => const RegisterScreen(),
//                                       ),
//                                     );
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.white,
//                                     foregroundColor: Colors.black,
//                                     minimumSize: const Size(120, 40),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(5),
//                                     ),
//                                   ).copyWith(
//                                     overlayColor: MaterialStateProperty.resolveWith<Color?>(
//                                           (Set<MaterialState> states) {
//                                         if (states.contains(MaterialState.hovered))
//                                           return Colors.grey.withOpacity(0.2);
//                                         return null;
//                                       },
//                                     ),
//                                   ),
//                                   child: const Text('Sign Up'),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 20),
//                             TextButton(
//                               onPressed: _isLoading
//                                   ? null
//                                   : () {
//                                 Navigator.pushNamed(context, '/forgot_password');
//                               },
//                               style: ButtonStyle(
//                                 overlayColor: MaterialStateProperty.resolveWith<Color?>(
//                                       (Set<MaterialState> states) {
//                                     if (states.contains(MaterialState.hovered))
//                                       return Colors.blue.withOpacity(0.1);
//                                     return null;
//                                   },
//                                 ),
//                               ),
//                               child: const Text(
//                                 'forget Password ?',
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                   decoration: TextDecoration.underline,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
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
//



import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/screens/register_screen.dart';
import '/screens/welcome_screen.dart';
import '/widgets/app_drawer.dart';
import '/widgets/custom_footer.dart';
import '/widgets/custom_header.dart';
import '/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  String? _errorMessage;
  bool _isHoveringSignIn = false;
  bool _isHoveringSignUp = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _authService.signInWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (mounted) {
        Navigator.pushReplacementNamed(context, '/welcome');
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        switch (e.code) {
          case 'user-not-found':
            _errorMessage = 'No user found with this email.';
            break;
          case 'wrong-password':
            _errorMessage = 'Wrong password provided.';
            break;
          case 'invalid-email':
            _errorMessage = 'The email address is not valid.';
            break;
          case 'user-disabled':
            _errorMessage = 'This user has been disabled.';
            break;
          default:
            _errorMessage = 'An error occurred: ${e.message}';
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred.';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width <= 600;

    return Scaffold(
      key: scaffoldKey,
      endDrawer: const AppDrawer(),
      body: Container(
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
        child: Column(
          children: [
            CustomHeader(
              scaffoldKey: scaffoldKey,
            ),
            Expanded(
              child: Stack(
                children: [
                  // Back arrow
                  Positioned(
                    left: isMobile ? 16 : 24,
                    top: isMobile ? 16 : 24,
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
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(isMobile ? 16 : 24),
                      child: Container(
                        width: isMobile ? double.infinity : 500,
                        padding: EdgeInsets.all(isMobile ? 20 : 32),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.15),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 30,
                              offset: const Offset(0, 20),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [
                                  Color(0xFF00DBDE),
                                  Color(0xFFFC00FF),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Access your account to continue',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Email',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.1),
                                    hintText: 'your@email.com',
                                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.email_rounded,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Password',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                TextField(
                                  controller: _passwordController,
                                  obscureText: _obscureText,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0.1),
                                    hintText: '••••••••',
                                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.lock_rounded,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _obscureText
                                            ? Icons.visibility_off_rounded
                                            : Icons.visibility_rounded,
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (_errorMessage != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: Text(
                                  _errorMessage!,
                                  style: TextStyle(
                                    color: const Color(0xFFFF6B6B),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                MouseRegion(
                                  onEnter: (_) => setState(() => _isHoveringSignIn = true),
                                  onExit: (_) => setState(() => _isHoveringSignIn = false),
                                  child: GestureDetector(
                                    onTap: _isLoading ? null : _signIn,
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        gradient: LinearGradient(
                                          colors: _isHoveringSignIn
                                              ? [const Color(0xFF00DBDE), const Color(0xFFFC00FF)]
                                              : [const Color(0xFF00DBDE).withOpacity(0.9), const Color(0xFFFC00FF).withOpacity(0.9)],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: (_isHoveringSignIn ? const Color(0xFF00DBDE) : const Color(0xFFFC00FF))
                                                .withOpacity(0.4),
                                            blurRadius: _isHoveringSignIn ? 20 : 10,
                                            offset: Offset(0, _isHoveringSignIn ? 8 : 4),
                                          ),
                                        ],
                                      ),
                                      child: _isLoading
                                          ? const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 3,
                                        ),
                                      )
                                          : const Text(
                                        'Sign In',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                MouseRegion(
                                  onEnter: (_) => setState(() => _isHoveringSignUp = true),
                                  onExit: (_) => setState(() => _isHoveringSignUp = false),
                                  child: GestureDetector(
                                    onTap: _isLoading
                                        ? null
                                        : () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const RegisterScreen(),
                                        ),
                                      );
                                    },
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 300),
                                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.white.withOpacity(_isHoveringSignUp ? 0.2 : 0.1),
                                        border: Border.all(
                                          color: Colors.white.withOpacity(0.3),
                                          width: 1.5,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(_isHoveringSignUp ? 0.3 : 0.1),
                                            blurRadius: 10,
                                            offset: const Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: const Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: TextButton(
                                onPressed: _isLoading
                                    ? null
                                    : () {
                                  Navigator.pushNamed(context, '/forgot_password');
                                },
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Forgot Password?',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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
