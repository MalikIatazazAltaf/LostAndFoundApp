// import 'package:flutter/material.dart';
//
// class AppDrawer extends StatefulWidget {
//   const AppDrawer({Key? key}) : super(key: key);
//
//   @override
//   State<AppDrawer> createState() => _AppDrawerState();
// }
//
// class _AppDrawerState extends State<AppDrawer> {
//   bool _isHoveringLogout = false;
//
//   // Function to show logout confirmation dialog
//   Future<void> _showLogoutConfirmation(BuildContext context) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // User must tap button to close dialog
//       builder: (BuildContext dialogContext) {
//         return AlertDialog(
//           title: const Text('Confirm Logout'),
//           content: const SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text('Are you sure you want to logout?'),
//                 SizedBox(height: 10),
//                 Text('You will need to login again to access your account.'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(dialogContext).pop(); // Close the dialog
//               },
//             ),
//             TextButton(
//               child: const Text('Logout', style: TextStyle(color: Colors.red)),
//               onPressed: () {
//                 Navigator.of(dialogContext).pop(); // Close the dialog
//
//                 // Navigate to the Get Started screen and clear all previous routes
//                 Navigator.of(context).pushNamedAndRemoveUntil(
//                   '/',
//                       (Route<dynamic> route) => false, // Remove all previous routes
//                 );
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Color(0xFF22E5FF), Color(0xFF3E7ACF)],
//           ),
//         ),
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [Color(0xFF22E5FF), Color(0xFF3E7ACF)],
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black26,
//                     blurRadius: 6,
//                     offset: Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.all(5),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(8),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.1),
//                               blurRadius: 4,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         child: Image.asset(
//                           'assets/logo.png',
//                           height: 40,
//                           width: 40,
//                         ),
//                       ),
//                       const SizedBox(width: 12),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: const [
//                           Text(
//                             'FOUND',
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                           Text(
//                             'Discover. Connect. Search.',
//                             style: TextStyle(
//                               fontSize: 11,
//                               color: Colors.black87,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.2),
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: const Text(
//                       'Navigation Menu',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             _buildDrawerItem(
//               context,
//               'Get Started',
//               Icons.home,
//                   () => Navigator.pushReplacementNamed(context, '/'),
//             ),
//             _buildDrawerItem(
//               context,
//               'Login',
//               Icons.login,
//                   () => Navigator.pushReplacementNamed(context, '/login'),
//             ),
//             _buildDrawerItem(
//               context,
//               'Register',
//               Icons.app_registration,
//                   () => Navigator.pushReplacementNamed(context, '/register'),
//             ),
//             _buildDrawerItem(
//               context,
//               'Welcome',
//               Icons.celebration,
//                   () => Navigator.pushReplacementNamed(context, '/welcome'),
//             ),
//             _buildDrawerItem(
//               context,
//               'Lost & Found',
//               Icons.search,
//                   () => Navigator.pushReplacementNamed(context, '/lost_found'),
//             ),
//             _buildDrawerItem(
//               context,
//               'Report List',
//               Icons.list_alt,
//                   () => Navigator.pushReplacementNamed(context, '/report_list'),
//             ),
//             _buildDrawerItem(
//               context,
//               'Users',
//               Icons.people,
//                   () => Navigator.pushReplacementNamed(context, '/users'),
//             ),
//             _buildDrawerItem(
//               context,
//               'Profile',
//               Icons.person,
//                   () => Navigator.pushReplacementNamed(context, '/profile'),
//             ),
//             const Divider(color: Colors.white54, thickness: 1),
//             _buildDrawerItem(
//               context,
//               'About Us',
//               Icons.info,
//                   () {},
//             ),
//             _buildDrawerItem(
//               context,
//               'Contact',
//               Icons.contact_mail,
//                   () {},
//             ),
//             const SizedBox(height: 20),
//             // ADDED: Logout option with hover effect
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//               child: MouseRegion(
//                 cursor: SystemMouseCursors.click,
//                 onEnter: (_) => setState(() => _isHoveringLogout = true),
//                 onExit: (_) => setState(() => _isHoveringLogout = false),
//                 child: GestureDetector(
//                   onTap: () => _showLogoutConfirmation(context),
//                   child: AnimatedContainer(
//                     duration: const Duration(milliseconds: 200),
//                     padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
//                     decoration: BoxDecoration(
//                       color: _isHoveringLogout ? Colors.red : Colors.red.withOpacity(0.8),
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: _isHoveringLogout
//                           ? [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.3),
//                           blurRadius: 8,
//                           offset: const Offset(0, 4),
//                         )
//                       ]
//                           : [],
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.logout,
//                           color: Colors.white,
//                           size: _isHoveringLogout ? 26 : 24,
//                         ),
//                         const SizedBox(width: 16),
//                         Text(
//                           'Logout',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: _isHoveringLogout ? 18 : 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDrawerItem(
//       BuildContext context,
//       String title,
//       IconData icon,
//       VoidCallback onTap,
//       ) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: ListTile(
//         leading: Icon(icon, color: Colors.black),
//         title: Text(
//           title,
//           style: const TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         onTap: onTap,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         hoverColor: Colors.white.withOpacity(0.2),
//         dense: true,
//       ),
//     );
//   }
// }






import 'package:flutter/material.dart';
import '/services/auth_service.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool _isHoveringLogout = false;
  final AuthService _authService = AuthService();

  // Function to show logout confirmation dialog
  Future<void> _showLogoutConfirmation(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to close dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to logout?'),
                SizedBox(height: 10),
                Text('You will need to login again to access your account.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Logout', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                Navigator.of(dialogContext).pop(); // Close the dialog

                try {
                  await _authService.signOut();
                  // Navigate to the Get Started screen and clear all previous routes
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/',
                        (Route<dynamic> route) => false, // Remove all previous routes
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error signing out: ${e.toString()}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUser;
    final bool isLoggedIn = user != null;

    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF22E5FF), Color(0xFF3E7ACF)],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF22E5FF), Color(0xFF3E7ACF)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/logo.png',
                          height: 40,
                          width: 40,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'FOUND',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Discover. Connect. Search.',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Text(
                      'Navigation Menu',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(
              context,
              'Get Started',
              Icons.home,
                  () => Navigator.pushReplacementNamed(context, '/'),
            ),
            if (!isLoggedIn) ...[
              _buildDrawerItem(
                context,
                'Login',
                Icons.login,
                    () => Navigator.pushReplacementNamed(context, '/login'),
              ),
              _buildDrawerItem(
                context,
                'Register',
                Icons.app_registration,
                    () => Navigator.pushReplacementNamed(context, '/register'),
              ),
            ],
            if (isLoggedIn) ...[
              _buildDrawerItem(
                context,
                'Welcome',
                Icons.celebration,
                    () => Navigator.pushReplacementNamed(context, '/welcome'),
              ),
              _buildDrawerItem(
                context,
                'Lost & Found',
                Icons.search,
                    () => Navigator.pushReplacementNamed(context, '/lost_found'),
              ),
              _buildDrawerItem(
                context,
                'Report List',
                Icons.list_alt,
                    () => Navigator.pushReplacementNamed(context, '/report_list'),
              ),
              _buildDrawerItem(
                context,
                'Users',
                Icons.people,
                    () => Navigator.pushReplacementNamed(context, '/users'),
              ),
              _buildDrawerItem(
                context,
                'Profile',
                Icons.person,
                    () => Navigator.pushReplacementNamed(context, '/profile'),
              ),
            ],
            const Divider(color: Colors.white54, thickness: 1),
            _buildDrawerItem(
              context,
              'About Us',
              Icons.info,
                  () {},
            ),
            _buildDrawerItem(
              context,
              'Contact',
              Icons.contact_mail,
                  () {},
            ),
            const SizedBox(height: 20),
            if (isLoggedIn)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  onEnter: (_) => setState(() => _isHoveringLogout = true),
                  onExit: (_) => setState(() => _isHoveringLogout = false),
                  child: GestureDetector(
                    onTap: () => _showLogoutConfirmation(context),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: _isHoveringLogout ? Colors.red : Colors.red.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: _isHoveringLogout
                            ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          )
                        ]
                            : [],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.white,
                            size: _isHoveringLogout ? 26 : 24,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: _isHoveringLogout ? 18 : 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context,
      String title,
      IconData icon,
      VoidCallback onTap,
      ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        hoverColor: Colors.white.withOpacity(0.2),
        dense: true,
      ),
    );
  }
}

