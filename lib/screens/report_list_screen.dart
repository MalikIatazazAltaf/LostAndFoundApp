//
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fuzzy/fuzzy.dart';
// import 'package:collection/collection.dart';
// import '/widgets/custom_header.dart';
// import '/widgets/custom_footer.dart';
// import '/widgets/app_drawer.dart';
//
// class ReportListScreen extends StatefulWidget {
//   final bool isLostItem;
//   final String searchQuery;
//   const ReportListScreen({
//     Key? key,
//     required this.isLostItem,
//     this.searchQuery = '',
//   }) : super(key: key);
//
//   @override
//   State<ReportListScreen> createState() => _ReportListScreenState();
// }
//
// // Custom class for sorting results
// class MatchItem {
//   final DocumentSnapshot doc;
//   final double score;
//
//   MatchItem(this.doc, this.score);
// }
//
// class _ReportListScreenState extends State<ReportListScreen> {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final TextEditingController _searchController = TextEditingController();
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
//
//   @override
//   void initState() {
//     super.initState();
//     _searchController.text = widget.searchQuery;
//   }
//
//   Future<void> _handleClaim(String docId) async {
//     try {
//       final collection = widget.isLostItem ? 'found_items' : 'lost_items';
//       await _firestore.collection(collection).doc(docId).update({
//         'isClaimed': true,
//         'claimerId': FirebaseAuth.instance.currentUser!.uid,
//         'claimedAt': FieldValue.serverTimestamp(),
//       });
//       setState(() {});
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Claim failed: ${e.toString()}')),
//       );
//     }
//   }
//
//   Stream<List<DocumentSnapshot>> _getMatches() {
//     final collection = widget.isLostItem ? 'found_items' : 'lost_items';
//
//     return _firestore.collection(collection).snapshots().asyncMap((snapshot) {
//       final nameFuse = Fuzzy(
//         snapshot.docs,
//         options: FuzzyOptions(
//           keys: [WeightedKey<DocumentSnapshot>(
//             name: 'item',
//             getter: (doc) => doc['item']?.toString().toLowerCase() ?? '',
//             weight: 0.6,
//           )],
//           threshold: 0.4,
//           tokenize: true,
//         ),
//       );
//
//       final descFuse = Fuzzy(
//         snapshot.docs,
//         options: FuzzyOptions(
//           keys: [WeightedKey<DocumentSnapshot>(
//             name: 'description',
//             getter: (doc) => doc['description']?.toString().toLowerCase() ?? '',
//             weight: 0.3,
//           )],
//           threshold: 0.5,
//         ),
//       );
//
//       final locFuse = Fuzzy(
//         snapshot.docs,
//         options: FuzzyOptions(
//           keys: [WeightedKey<DocumentSnapshot>(
//             name: 'location',
//             getter: (doc) => doc['location']?.toString().toLowerCase() ?? '',
//             weight: 0.1,
//           )],
//           threshold: 0.6,
//         ),
//       );
//
//       final nameMatches = nameFuse.search(_searchController.text.toLowerCase());
//       final descMatches = descFuse.search(_searchController.text.toLowerCase());
//       final locMatches = locFuse.search(_searchController.text.toLowerCase());
//
//       final combined = [
//         ...nameMatches.map((m) => MatchItem(m.item, m.score + 1000)),
//         ...descMatches.map((m) => MatchItem(m.item, m.score + 500)),
//         ...locMatches.map((m) => MatchItem(m.item, m.score)),
//       ];
//
//       final uniqueItems = <String, MatchItem>{};
//       for (var match in combined) {
//         if (!uniqueItems.containsKey(match.doc.id) ||
//             match.score > uniqueItems[match.doc.id]!.score) {
//           uniqueItems[match.doc.id] = match;
//         }
//       }
//
//       final sortedMatches = uniqueItems.values.toList()
//         ..sort((a, b) => b.score.compareTo(a.score));
//
//       return sortedMatches.map((m) => m.doc).toList();
//     });
//   }
//
//   String _getMatchLevel(Map<String, dynamic> doc) {
//     final query = _searchController.text.toLowerCase();
//     final item = doc['item']?.toString().toLowerCase() ?? '';
//     final description = doc['description']?.toString().toLowerCase() ?? '';
//     final location = doc['location']?.toString().toLowerCase() ?? '';
//
//     if (item.contains(query)) return 'name';
//     if (description.contains(query)) return 'description';
//     if (location.contains(query)) return 'location';
//     return 'general';
//   }
//
//   Color _getMatchColor(String level) {
//     switch (level) {
//       case 'name':
//         return const Color(0xFF00DBDE);
//       case 'description':
//         return const Color(0xFFFC00FF);
//       case 'location':
//         return const Color(0xFF45B7D1);
//       default:
//         return Colors.grey;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
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
//             Padding(
//               padding: EdgeInsets.all(isMobile ? 16 : 24),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(
//                     color: Colors.white.withOpacity(0.2),
//                     width: 1.5,
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.3),
//                       blurRadius: 20,
//                       offset: const Offset(0, 10),
//                     ),
//                   ],
//                 ),
//                 child: TextField(
//                   controller: _searchController,
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     hintText: 'Search items...',
//                     hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
//                     filled: true,
//                     fillColor: Colors.transparent,
//                     contentPadding: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 18,
//                     ),
//                     border: InputBorder.none,
//                     prefixIcon: const Icon(Icons.search, color: Colors.white70),
//                     suffixIcon: IconButton(
//                       icon: const Icon(Icons.close, color: Colors.white70),
//                       onPressed: () {
//                         _searchController.clear();
//                         setState(() {});
//                       },
//                     ),
//                   ),
//                   onChanged: (value) => setState(() {}),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: StreamBuilder<List<DocumentSnapshot>>(
//                 stream: _getMatches(),
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) {
//                     return Center(
//                       child: CircularProgressIndicator(
//                         color: const Color(0xFF00DBDE),
//                       ),
//                     );
//                   }
//
//                   final items = snapshot.data!;
//                   if (items.isEmpty) {
//                     return Center(
//                       child: Text(
//                         'No matching items found',
//                         style: TextStyle(
//                           color: Colors.white.withOpacity(0.7),
//                           fontSize: 18,
//                         ),
//                       ),
//                     );
//                   }
//
//                   return ListView.builder(
//                     padding: EdgeInsets.all(isMobile ? 16 : 24),
//                     itemCount: items.length,
//                     itemBuilder: (context, index) {
//                       final doc = items[index].data() as Map<String, dynamic>;
//                       final docId = items[index].id;
//                       final matchLevel = _getMatchLevel(doc);
//                       final matchColor = _getMatchColor(matchLevel);
//
//                       return Container(
//                         margin: EdgeInsets.only(bottom: isMobile ? 16 : 20),
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.08),
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(
//                             color: matchColor.withOpacity(0.3),
//                             width: 1.5,
//                           ),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.3),
//                               blurRadius: 15,
//                               offset: const Offset(0, 8),
//                             ),
//                           ],
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.all(isMobile ? 16 : 20),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   doc['imageUrl'] != null
//                                       ? ClipRRect(
//                                     borderRadius: BorderRadius.circular(12),
//                                     child: Image.network(
//                                       doc['imageUrl'],
//                                       width: 80,
//                                       height: 80,
//                                       fit: BoxFit.cover,
//                                     ),
//                                   )
//                                       : Container(
//                                     width: 80,
//                                     height: 80,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white.withOpacity(0.1),
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     child: Icon(
//                                       Icons.image,
//                                       size: 40,
//                                       color: Colors.white.withOpacity(0.4),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 16),
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           doc['item'] ?? 'Unnamed Item',
//                                           style: const TextStyle(
//                                             fontWeight: FontWeight.w700,
//                                             fontSize: 18,
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 8),
//                                         Container(
//                                           padding: const EdgeInsets.symmetric(
//                                             horizontal: 12,
//                                             vertical: 6,
//                                           ),
//                                           decoration: BoxDecoration(
//                                             color: matchColor.withOpacity(0.2),
//                                             borderRadius: BorderRadius.circular(20),
//                                             border: Border.all(
//                                               color: matchColor,
//                                               width: 1.5,
//                                             ),
//                                           ),
//                                           child: Text(
//                                             '${matchLevel.toUpperCase()} MATCH',
//                                             style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: isMobile ? 10 : 12,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   if (!(doc['isClaimed'] ?? false))
//                                     MouseRegion(
//                                       cursor: SystemMouseCursors.click,
//                                       child: GestureDetector(
//                                         onTap: () => _handleClaim(docId),
//                                         child: Container(
//                                           padding: const EdgeInsets.symmetric(
//                                             horizontal: 16,
//                                             vertical: 8,
//                                           ),
//                                           decoration: BoxDecoration(
//                                             gradient: LinearGradient(
//                                               colors: [
//                                                 matchColor,
//                                                 matchColor.withOpacity(0.8),
//                                               ],
//                                             ),
//                                             borderRadius: BorderRadius.circular(12),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: matchColor.withOpacity(0.4),
//                                                 blurRadius: 10,
//                                                 offset: const Offset(0, 4),
//                                               ),
//                                             ],
//                                           ),
//                                           child: const Text(
//                                             'Claim',
//                                             style: TextStyle(
//                                               color: Colors.white,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   else
//                                     Container(
//                                       padding: const EdgeInsets.symmetric(
//                                         horizontal: 16,
//                                         vertical: 8,
//                                       ),
//                                       decoration: BoxDecoration(
//                                         color: Colors.green.withOpacity(0.2),
//                                         borderRadius: BorderRadius.circular(12),
//                                         border: Border.all(
//                                           color: Colors.green,
//                                           width: 1.5,
//                                         ),
//                                       ),
//                                       child: const Text(
//                                         'Claimed',
//                                         style: TextStyle(
//                                           color: Colors.green,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                     ),
//                                 ],
//                               ),
//                               const SizedBox(height: 16),
//                               Divider(
//                                 color: Colors.white.withOpacity(0.1),
//                                 thickness: 1.5,
//                               ),
//                               const SizedBox(height: 12),
//                               Row(
//                                 children: [
//                                   Icon(
//                                     Icons.location_on_rounded,
//                                     size: 20,
//                                     color: matchColor,
//                                   ),
//                                   const SizedBox(width: 8),
//                                   Expanded(
//                                     child: Text(
//                                       doc['location'] ?? 'No Location',
//                                       style: const TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 16,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 12),
//                               Text(
//                                 doc['description'] ?? 'No Description',
//                                 style: const TextStyle(
//                                   color: Colors.white70,
//                                   fontSize: 15,
//                                 ),
//                                 maxLines: null,
//                               ),
//                               const SizedBox(height: 16),
//                               Row(
//                                 children: [
//                                   Container(
//                                     padding: const EdgeInsets.all(6),
//                                     decoration: BoxDecoration(
//                                       color: const Color(0xFF00DBDE).withOpacity(0.2),
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                     child: const Icon(
//                                       Icons.person,
//                                       size: 18,
//                                       color: Color(0xFF00DBDE),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 8),
//                                   Text(
//                                     'Reported by: ${doc['name'] ?? 'Anonymous'}',
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 8),
//                               Row(
//                                 children: [
//                                   Container(
//                                     padding: const EdgeInsets.all(6),
//                                     decoration: BoxDecoration(
//                                       color: const Color(0xFFFC00FF).withOpacity(0.2),
//                                       borderRadius: BorderRadius.circular(8),
//                                     ),
//                                     child: const Icon(
//                                       Icons.phone,
//                                       size: 18,
//                                       color: Color(0xFFFC00FF),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 8),
//                                   Text(
//                                     'Contact: ${doc['contact'] ?? 'N/A'}',
//                                     style: const TextStyle(
//                                       fontWeight: FontWeight.w500,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
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
//
//
//
//
//
//
//
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:collection/collection.dart';
import '/widgets/custom_header.dart';
import '/widgets/custom_footer.dart';
import '/widgets/app_drawer.dart';

class ReportListScreen extends StatefulWidget {
  final bool isLostItem;
  final String searchQuery;
  const ReportListScreen({
    Key? key,
    required this.isLostItem,
    this.searchQuery = '',
  }) : super(key: key);

  @override
  State<ReportListScreen> createState() => _ReportListScreenState();
}

// Custom class for sorting results
class MatchItem {
  final DocumentSnapshot doc;
  final double score;

  MatchItem(this.doc, this.score);
}

class _ReportListScreenState extends State<ReportListScreen> {

  List<DocumentSnapshot> matchedItems = [];
  Set<String> alreadyShownItemIds = {};

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    List<DocumentSnapshot> getFilteredItems(
        List<DocumentSnapshot> allItems,
        String category,
        String description,
        String location,
        ) {
      // Step 1: Filter by Category
      List<DocumentSnapshot> categoryMatched = allItems.where((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return data['item']?.toString().toLowerCase().trim() == category.toLowerCase().trim();
      }).toList();

      // Step 2: Filter by Description
      List<DocumentSnapshot> descriptionMatched = categoryMatched.where((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return data['description']?.toString().toLowerCase().contains(description.toLowerCase().trim()) ?? false;
      }).toList();

      // Step 3: Filter by Location
      List<DocumentSnapshot> locationMatched = descriptionMatched.where((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return data['location']?.toString().toLowerCase().contains(location.toLowerCase().trim()) ?? false;
      }).toList();

      // Step 4: Filter out previously shown
      List<DocumentSnapshot> fresh = locationMatched.where((doc) =>
      !alreadyShownItemIds.contains(doc.id)
      ).toList();

      alreadyShownItemIds.addAll(fresh.map((e) => e.id));
      return fresh;
    }

    _searchController.text = widget.searchQuery;
  }

  Future<void> _handleClaim(String docId) async {
    try {
      final collection = widget.isLostItem ? 'found_items' : 'lost_items';
      await _firestore.collection(collection).doc(docId).update({
        'isClaimed': true,
        'claimerId': FirebaseAuth.instance.currentUser!.uid,
        'claimedAt': FieldValue.serverTimestamp(),
      });
      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Claim failed: ${e.toString()}')),
      );
    }
  }

  Stream<List<DocumentSnapshot>> _getMatches() {
    final collection = widget.isLostItem ? 'found_items' : 'lost_items';

    return _firestore.collection(collection).snapshots().asyncMap((snapshot) {
      final nameFuse = Fuzzy(
        snapshot.docs,
        options: FuzzyOptions(
          keys: [WeightedKey<DocumentSnapshot>(
            name: 'item',
            getter: (doc) => doc['item']?.toString().toLowerCase() ?? '',
            weight: 0.6,
          )],
          threshold: 0.4,
          tokenize: true,
        ),
      );

      final descFuse = Fuzzy(
        snapshot.docs,
        options: FuzzyOptions(
          keys: [WeightedKey<DocumentSnapshot>(
            name: 'description',
            getter: (doc) => doc['description']?.toString().toLowerCase() ?? '',
            weight: 0.3,
          )],
          threshold: 0.5,
        ),
      );

      final locFuse = Fuzzy(
        snapshot.docs,
        options: FuzzyOptions(
          keys: [WeightedKey<DocumentSnapshot>(
            name: 'location',
            getter: (doc) => doc['location']?.toString().toLowerCase() ?? '',
            weight: 0.1,
          )],
          threshold: 0.6,
        ),
      );

      final nameMatches = nameFuse.search(_searchController.text.toLowerCase());
      final descMatches = descFuse.search(_searchController.text.toLowerCase());
      final locMatches = locFuse.search(_searchController.text.toLowerCase());

      final combined = [
        ...nameMatches.map((m) => MatchItem(m.item, m.score + 1000)),
        ...descMatches.map((m) => MatchItem(m.item, m.score + 500)),
        ...locMatches.map((m) => MatchItem(m.item, m.score)),
      ];

      final uniqueItems = <String, MatchItem>{};
      for (var match in combined) {
        if (!uniqueItems.containsKey(match.doc.id) ||
            match.score > uniqueItems[match.doc.id]!.score) {
          uniqueItems[match.doc.id] = match;
        }
      }

      final sortedMatches = uniqueItems.values.toList()
        ..sort((a, b) => b.score.compareTo(a.score));

      return sortedMatches.map((m) => m.doc).toList();
    });
  }

  String _getMatchLevel(Map<String, dynamic> doc) {
    final query = _searchController.text.toLowerCase();
    final item = doc['item']?.toString().toLowerCase() ?? '';
    final description = doc['description']?.toString().toLowerCase() ?? '';
    final location = doc['location']?.toString().toLowerCase() ?? '';

    if (item.contains(query)) return 'name';
    if (description.contains(query)) return 'description';
    if (location.contains(query)) return 'location';
    return 'general';
  }

  Color _getMatchColor(String level) {
    switch (level) {
      case 'name':
        return const Color(0xFF00DBDE);
      case 'description':
        return const Color(0xFFFC00FF);
      case 'location':
        return const Color(0xFF45B7D1);
      default:
        return Colors.grey;
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
            Padding(
              padding: EdgeInsets.all(isMobile ? 16 : 24),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Search items...',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                    filled: true,
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                    border: InputBorder.none,
                    prefixIcon: const Icon(Icons.search, color: Colors.white70),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white70),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {});
                      },
                    ),
                  ),
                  onChanged: (value) => setState(() {}),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<List<DocumentSnapshot>>(
                stream: _getMatches(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: const Color(0xFF00DBDE),
                      ),
                    );
                  }

                  final items = snapshot.data!;
                  if (items.isEmpty) {
                    return Center(
                      child: Text(
                        'No matching items found',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 18,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.all(isMobile ? 16 : 24),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final doc = items[index].data() as Map<String, dynamic>;
                      final docId = items[index].id;
                      final matchLevel = _getMatchLevel(doc);
                      final matchColor = _getMatchColor(matchLevel);

                      return Container(
                        margin: EdgeInsets.only(bottom: isMobile ? 16 : 20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: matchColor.withOpacity(0.3),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 15,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(isMobile ? 16 : 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  doc['imageUrl'] != null
                                      ? ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      doc['imageUrl'],
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                      : Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      Icons.image,
                                      size: 40,
                                      color: Colors.white.withOpacity(0.4),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          doc['item'] ?? 'Unnamed Item',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: matchColor.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(
                                              color: matchColor,
                                              width: 1.5,
                                            ),
                                          ),
                                          child: Text(
                                            '${matchLevel.toUpperCase()} MATCH',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: isMobile ? 10 : 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (!(doc['isClaimed'] ?? false))
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () => _handleClaim(docId),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                matchColor,
                                                matchColor.withOpacity(0.8),
                                              ],
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                            boxShadow: [
                                              BoxShadow(
                                                color: matchColor.withOpacity(0.4),
                                                blurRadius: 10,
                                                offset: const Offset(0, 4),
                                              ),
                                            ],
                                          ),
                                          child: const Text(
                                            'Claim',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  else
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.green,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: const Text(
                                        'Claimed',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Divider(
                                color: Colors.white.withOpacity(0.1),
                                thickness: 1.5,
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_rounded,
                                    size: 20,
                                    color: matchColor,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      doc['location'] ?? 'No Location',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                doc['description'] ?? 'No Description',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 15,
                                ),
                                maxLines: null,
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF00DBDE).withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.person,
                                      size: 18,
                                      color: Color(0xFF00DBDE),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Reported by: ${doc['name'] ?? 'Anonymous'}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFC00FF).withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.phone,
                                      size: 18,
                                      color: Color(0xFFFC00FF),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Contact: ${doc['contact'] ?? 'N/A'}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const CustomFooter(),
          ],
        ),
      ),
    );
  }
}
