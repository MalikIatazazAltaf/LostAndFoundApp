//
//
//
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'report_screen.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   final User? _user = FirebaseAuth.instance.currentUser;
//   final double _headerHeight = 200.0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           _buildProfileHeader(),
//           _buildReportsSection(),
//         ],
//       ),
//     );
//   }
//
//   SliverAppBar _buildProfileHeader() {
//     return SliverAppBar(
//       expandedHeight: _headerHeight,
//       flexibleSpace: FlexibleSpaceBar(
//         background: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFF22E5FF), Color(0xFF3E7ACF)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.only(top: 48.0, left: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CircleAvatar(
//                   radius: 40,
//                   backgroundImage: NetworkImage(
//                       _user?.photoURL ?? 'https://via.placeholder.com/150'),
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   _user?.displayName ?? 'Guest User',
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   _user?.email ?? 'No email',
//                   style: const TextStyle(color: Colors.white70),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       actions: [
//         IconButton(
//           icon: const Icon(Icons.logout, color: Colors.white),
//           onPressed: _confirmLogout,
//         ),
//       ],
//     );
//   }
//
//   SliverToBoxAdapter _buildReportsSection() {
//     return SliverToBoxAdapter(
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildReportTypeSection('Lost Items', 'lost_items'),
//             const SizedBox(height: 24),
//             _buildReportTypeSection('Found Items', 'found_items'),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildReportTypeSection(String title, String collection) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection(collection)
//           .where('userId', isEqualTo: _user?.uid)
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return _buildErrorWidget('Error: ${snapshot.error}');
//         }
//
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return _buildLoadingIndicator();
//         }
//
//         final reports = snapshot.data?.docs ?? [];
//
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xFF3E7ACF),
//                 ),
//               ),
//             ),
//             ...reports.map((doc) => _buildReportCard(doc, collection)),
//             if (reports.isEmpty) _buildEmptyState(title),
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildReportCard(QueryDocumentSnapshot doc, String collection) {
//     final data = doc.data() as Map<String, dynamic>;
//     final date = data['date'] != null
//         ? DateTime.parse(data['date']).toLocal()
//         : null;
//
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Image Preview
//                 if (data['imageUrl'] != null)
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: CachedNetworkImage(
//                       imageUrl: data['imageUrl']!,
//                       width: 100,
//                       height: 100,
//                       fit: BoxFit.cover,
//                       placeholder: (context, url) => Container(
//                         color: Colors.grey[200],
//                         child: const Icon(Icons.image),
//                       ),
//                       errorWidget: (context, url, error) =>
//                       const Icon(Icons.broken_image),
//                     ),
//                   ),
//                 const SizedBox(width: 16),
//                 // Details
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         data['item'] ?? 'No Title',
//                         style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 8),
//                       if (date != null)
//                         Text(
//                           'Date: ${date.day}/${date.month}/${date.year}',
//                           style: TextStyle(color: Colors.grey[600]),
//                         ),
//                       const SizedBox(height: 4),
//                       Text(
//                         data['location'] ?? 'No Location',
//                         style: TextStyle(color: Colors.grey[600]),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         data['description'] ?? 'No Description',
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Actions
//                 PopupMenuButton<String>(
//                   icon: const Icon(Icons.more_vert),
//                   onSelected: (value) => _handleReportAction(
//                       value, doc.id, collection, data),
//                   itemBuilder: (context) => [
//                     const PopupMenuItem(
//                       value: 'edit',
//                       child: ListTile(
//                         leading: Icon(Icons.edit),
//                         title: Text('Edit'),
//                       ),
//                     ),
//                     const PopupMenuItem(
//                       value: 'delete',
//                       child: ListTile(
//                         leading: Icon(Icons.delete, color: Colors.red),
//                         title: Text('Delete'),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _handleReportAction(
//       String action, String docId, String collection, Map<String, dynamic> data) {
//     switch (action) {
//       case 'edit':
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ReportScreen(
//               isLostItem: collection == 'lost_items',
//               existingData: data,
//               docId: docId,
//             ),
//           ),
//         );
//         break;
//       case 'delete':
//         _confirmDelete(docId, collection);
//         break;
//     }
//   }
//
//   Future<void> _confirmDelete(String docId, String collection) async {
//     return showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Confirm Delete'),
//         content: const Text('Are you sure you want to delete this report?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () async {
//               await FirebaseFirestore.instance
//                   .collection(collection)
//                   .doc(docId)
//                   .delete();
//               Navigator.pop(context);
//             },
//             child: const Text('Delete', style: TextStyle(color: Colors.red)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _confirmLogout() async {
//     return showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Confirm Logout'),
//         content: const Text('Are you sure you want to logout?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () async {
//               await FirebaseAuth.instance.signOut();
//               Navigator.popUntil(context, (route) => route.isFirst);
//             },
//             child: const Text('Logout'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLoadingIndicator() {
//     return const Padding(
//       padding: EdgeInsets.symmetric(vertical: 24),
//       child: Center(child: CircularProgressIndicator()),
//     );
//   }
//
//   Widget _buildErrorWidget(String message) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Text(
//         message,
//         style: const TextStyle(color: Colors.red),
//       ),
//     );
//   }
//
//   Widget _buildEmptyState(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 16),
//       child: Center(
//         child: Text(
//           'No $title found',
//           style: TextStyle(
//               color: Colors.grey[600],
//               fontStyle: FontStyle.italic),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '/widgets/app_drawer.dart';
import '/widgets/custom_footer.dart';
import '/widgets/custom_header.dart';
import 'report_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final User? _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const AppDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF22E5FF), Color(0xFF3E7ACF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            //CustomHeader(scaffoldKey: _scaffoldKey),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 180.0,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF3E7ACF), Color(0xFF22E5FF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 48.0, left: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white.withOpacity(0.3),
                                child: _user?.photoURL != null
                                    ? ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: _user!.photoURL!,
                                    width: 76,
                                    height: 76,
                                    fit: BoxFit.cover,
                                  ),
                                )
                                    : Text(
                                  _user?.displayName?.isNotEmpty == true
                                      ? _user!.displayName![0]
                                      .toUpperCase()
                                      : 'U',
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text(
                                _user?.displayName ?? 'Guest User',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  _user?.email ?? 'No email',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton.icon(
                                  onPressed: _confirmLogout,
                                  icon: const Icon(Icons.logout, size: 18),
                                  label: const Text('Logout'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: const Color(0xFF3E7ACF),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      //elevation: 2,
                                    ),
                                  ),
                                )],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildReportTypeSection('Lost Items', 'lost_items'),
                          const SizedBox(height: 24),
                          _buildReportTypeSection('Found Items', 'found_items'),
                        ],
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

  Widget _buildReportTypeSection(String title, String collection) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection(collection)
          .where('userId', isEqualTo: _user?.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return _buildErrorWidget('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingIndicator();
        }

        final reports = snapshot.data?.docs ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            ...reports.map((doc) => _buildReportCard(doc, collection)),
            if (reports.isEmpty) _buildEmptyState(title),
          ],
        );
      },
    );
  }

  Widget _buildReportCard(QueryDocumentSnapshot doc, String collection) {
    final data = doc.data() as Map<String, dynamic>;
    final date = data['date'] != null
        ? DateTime.parse(data['date']).toLocal()
        : null;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.white.withOpacity(0.85),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (data['imageUrl'] != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: data['imageUrl']!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[200],
                        child: const Icon(Icons.image, color: Color(0xFF3E7ACF)),
                      ),
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.broken_image, color: Color(0xFF3E7ACF)),
                    ),
                  ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['item'] ?? 'No Title',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2A2A2A),
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (date != null)
                        Text(
                          'Date: ${date.day}/${date.month}/${date.year}',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 14,
                          ),
                        ),
                      const SizedBox(height: 4),
                      Text(
                        data['location'] ?? 'No Location',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        data['description'] ?? 'No Description',
                        style: const TextStyle(
                          color: Color(0xFF2A2A2A),
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, color: Color(0xFF3E7ACF)),
                  onSelected: (value) => _handleReportAction(
                      value, doc.id, collection, data),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: ListTile(
                        leading: Icon(Icons.edit, color: Color(0xFF3E7ACF)),
                        title: Text('Edit', style: TextStyle(color: Color(0xFF3E7ACF))),
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: ListTile(
                        leading: Icon(Icons.delete, color: Colors.red),
                        title: Text('Delete', style: TextStyle(color: Colors.red)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _handleReportAction(
      String action, String docId, String collection, Map<String, dynamic> data) {
    switch (action) {
      case 'edit':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReportScreen(
              isLostItem: collection == 'lost_items',
              existingData: data,
              docId: docId,
            ),
          ),
        );
        break;
      case 'delete':
        _confirmDelete(docId, collection);
        break;
    }
  }

  Future<void> _confirmDelete(String docId, String collection) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete', style: TextStyle(color: Color(0xFF3E7ACF))),
        content: const Text('Are you sure you want to delete this report?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF3E7ACF))),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection(collection)
                  .doc(docId)
                  .delete();
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmLogout() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Logout', style: TextStyle(color: Color(0xFF3E7ACF))),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF3E7ACF))),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Text(
          'No $title found',
          style: const TextStyle(
            color: Colors.white70,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}