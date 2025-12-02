//
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '/screens/login_screen.dart';
// import '/screens/welcome_screen.dart';
// import '/widgets/app_drawer.dart';
// import '/widgets/custom_footer.dart';
// import '/widgets/custom_header.dart';
// // RegisterScreen.dart ke imports mein ye add karein:
// import '/services/auth_service.dart';
//
// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({Key? key}) : super(key: key);
//
//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen> {
//   // Class ke andar AuthService ka instance banayein:
//   final AuthService _authService = AuthService();
//   bool _obscurePassword = true;
//   bool _obscureConfirmPassword = true;
//
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController = TextEditingController();
//
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//
//   String? _errorMessage;
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _register() async {
//     final name = _nameController.text.trim();
//     final email = _emailController.text.trim();
//     final password = _passwordController.text;
//     final confirmPassword = _confirmPasswordController.text;
//
//     if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
//       setState(() => _errorMessage = 'All fields are required.');
//       return;
//     }
//
//     if (password != confirmPassword) {
//       setState(() => _errorMessage = 'Passwords do not match.');
//       return;
//     }
//
//     if (password.length < 6) {
//       setState(() => _errorMessage = 'Password must be at least 6 characters.');
//       return;
//     }
//
//     setState(() => _errorMessage = null);
//
//     try {
//       // final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
//       //   email: email,
//       //   password: password,
//       // );
//       //
//       // await credential.user?.updateDisplayName(name);
//       //
//       // if (mounted) {
//       //   Navigator.pushReplacement(
//       //     context,
//       //     MaterialPageRoute(
//       //       builder: (context) => const WelcomeScreen(),
//       //     ),
//       //   );
//       // }
//       await _authService.createUserWithEmailAndPassword(name, email, password);
//
//       if (mounted) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const WelcomeScreen()),
//         );
//       }
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         switch (e.code) {
//           case 'email-already-in-use':
//             _errorMessage = 'This email is already in use.';
//             break;
//           case 'invalid-email':
//             _errorMessage = 'The email address is not valid.';
//             break;
//           case 'weak-password':
//             _errorMessage = 'The password is too weak.';
//             break;
//           default:
//             _errorMessage = 'Error: ${e.message}';
//         }
//       });
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Unexpected error: $e';
//       });
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
//             CustomHeader(scaffoldKey: scaffoldKey),
//             Expanded(
//               child: Stack(
//                 children: [
//                   Positioned(
//                     left: 10,
//                     top: 10,
//                     child: IconButton(
//                       icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
//                       onPressed: () => Navigator.of(context).pop(),
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
//                               'Register',
//                               style: TextStyle(
//                                 fontSize: 28,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.black,
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             _buildTextField('Name', _nameController),
//                             const SizedBox(height: 15),
//                             _buildTextField(
//                               'Email address',
//                               _emailController,
//                               keyboardType: TextInputType.emailAddress,
//                             ),
//                             const SizedBox(height: 15),
//                             _buildTextField(
//                               'Password',
//                               _passwordController,
//                               obscureText: _obscurePassword,
//                               toggleObscure: () => setState(() {
//                                 _obscurePassword = !_obscurePassword;
//                               }),
//                             ),
//                             const SizedBox(height: 15),
//                             _buildTextField(
//                               'Confirm Password',
//                               _confirmPasswordController,
//                               obscureText: _obscureConfirmPassword,
//                               toggleObscure: () => setState(() {
//                                 _obscureConfirmPassword = !_obscureConfirmPassword;
//                               }),
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
//                             const SizedBox(height: 25),
//                             ElevatedButton(
//                               onPressed: _register,
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.white,
//                                 foregroundColor: Colors.black,
//                                 minimumSize: const Size(200, 40),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                               ),
//                               child: const Text('Submit'),
//                             ),
//                             const SizedBox(height: 15),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const Text(
//                                   'Already have an account ? ',
//                                   style: TextStyle(color: Colors.black),
//                                 ),
//                                 GestureDetector(
//                                   onTap: () {
//                                     Navigator.pushReplacement(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => const LoginScreen(),
//                                       ),
//                                     );
//                                   },
//                                   child: MouseRegion(
//                                     cursor: SystemMouseCursors.click,
//                                     child: const Text(
//                                       'Sign in',
//                                       style: TextStyle(
//                                         color: Colors.blue,
//                                         fontWeight: FontWeight.bold,
//                                         decoration: TextDecoration.underline,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
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
//
//   Widget _buildTextField(
//       String label,
//       TextEditingController controller, {
//         bool obscureText = false,
//         TextInputType keyboardType = TextInputType.text,
//         VoidCallback? toggleObscure,
//       }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//             color: Colors.black,
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextField(
//           controller: controller,
//           obscureText: obscureText,
//           keyboardType: keyboardType,
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: Colors.white,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide: BorderSide.none,
//             ),
//             contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//             suffixIcon: toggleObscure != null
//                 ? IconButton(
//               icon: Icon(
//                 obscureText ? Icons.visibility_off : Icons.visibility,
//                 color: Colors.grey,
//               ),
//               onPressed: toggleObscure,
//             )
//                 : null,
//           ),
//         ),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/screens/login_screen.dart';
import '/screens/welcome_screen.dart';
import '/widgets/app_drawer.dart';
import '/widgets/custom_footer.dart';
import '/widgets/custom_header.dart';
import '/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthService _authService = AuthService();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  bool _isHovering = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      setState(() => _errorMessage = 'All fields are required.');
      return;
    }

    if (password != confirmPassword) {
      setState(() => _errorMessage = 'Passwords do not match.');
      return;
    }

    if (password.length < 6) {
      setState(() => _errorMessage = 'Password must be at least 6 characters.');
      return;
    }

    setState(() {
      _errorMessage = null;
      _isLoading = true;
    });

    try {
      await _authService.createUserWithEmailAndPassword(name, email, password);

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const WelcomeScreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        switch (e.code) {
          case 'email-already-in-use':
            _errorMessage = 'This email is already in use.';
            break;
          case 'invalid-email':
            _errorMessage = 'The email address is not valid.';
            break;
          case 'weak-password':
            _errorMessage = 'The password is too weak.';
            break;
          default:
            _errorMessage = 'Error: ${e.message}';
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Unexpected error: $e';
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
            CustomHeader(scaffoldKey: scaffoldKey),
            Expanded(
              child: Stack(
                children: [
                  // Back button
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
                        onPressed: () => Navigator.of(context).pop(),
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
                                'Register',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Create an account to get started',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 30),
                            _buildTextField(
                              'Name',
                              _nameController,
                              icon: Icons.person_rounded,
                            ),
                            const SizedBox(height: 20),
                            _buildTextField(
                              'Email address',
                              _emailController,
                              keyboardType: TextInputType.emailAddress,
                              icon: Icons.email_rounded,
                            ),
                            const SizedBox(height: 20),
                            _buildTextField(
                              'Password',
                              _passwordController,
                              obscureText: _obscurePassword,
                              toggleObscure: () => setState(() {
                                _obscurePassword = !_obscurePassword;
                              }),
                              icon: Icons.lock_rounded,
                            ),
                            const SizedBox(height: 20),
                            _buildTextField(
                              'Confirm Password',
                              _confirmPasswordController,
                              obscureText: _obscureConfirmPassword,
                              toggleObscure: () => setState(() {
                                _obscureConfirmPassword = !_obscureConfirmPassword;
                              }),
                              icon: Icons.lock_reset_rounded,
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
                            MouseRegion(
                              onEnter: (_) => setState(() => _isHovering = true),
                              onExit: (_) => setState(() => _isHovering = false),
                              child: GestureDetector(
                                onTap: _register,
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    gradient: LinearGradient(
                                      colors: _isHovering
                                          ? [const Color(0xFF00DBDE), const Color(0xFFFC00FF)]
                                          : [const Color(0xFF00DBDE).withOpacity(0.9), const Color(0xFFFC00FF).withOpacity(0.9)],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: (_isHovering ? const Color(0xFF00DBDE) : const Color(0xFFFC00FF))
                                            .withOpacity(0.4),
                                        blurRadius: _isHovering ? 20 : 10,
                                        offset: Offset(0, _isHovering ? 8 : 4),
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
                                    'Create Account',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Already have an account? ',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const LoginScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Sign in',
                                      style: TextStyle(
                                        color: Color(0xFF00DBDE),
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
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

  Widget _buildTextField(
      String label,
      TextEditingController controller, {
        bool obscureText = false,
        TextInputType keyboardType = TextInputType.text,
        VoidCallback? toggleObscure,
        IconData? icon,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            hintText: label,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            prefixIcon: icon != null
                ? Icon(
              icon,
              color: Colors.white.withOpacity(0.8),
            )
                : null,
            suffixIcon: toggleObscure != null
                ? IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                color: Colors.white.withOpacity(0.8),
              ),
              onPressed: toggleObscure,
            )
                : null,
          ),
        ),
      ],
    );
  }
}
