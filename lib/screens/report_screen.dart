//
//
//
//
//
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'dart:io';
// import '../services/cloudinary_service.dart';
// import '/screens/report_list_screen.dart';
// import '/widgets/app_drawer.dart';
// import '/widgets/custom_footer.dart';
// import '/widgets/custom_header.dart';
//
// class ReportScreen extends StatefulWidget {
//   final bool isLostItem;
//   final Map<String, dynamic>? existingData;
//   final String? docId;
//   const ReportScreen({
//     Key? key,
//     required this.isLostItem,
//     this.existingData,
//     this.docId,
//   }) : super(key: key);
//
//   @override
//   State<ReportScreen> createState() => _ReportScreenState();
// }
//
// class _ReportScreenState extends State<ReportScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   final _nameController = TextEditingController();
//   final _itemController = TextEditingController();
//   final _locationController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   final _contactController = TextEditingController();
//   File? _imageFile;
//   String? _cloudinaryUrl;
//   bool _isUploadingImage = false;
//   bool _isHoveringSubmit = false;
//   bool _isHoveringReset = false;
//   DateTime? _selectedDate;
//   bool _isSubmitting = false;
//
//
//   String _normalizeText(String text) {
//     return text
//         .toLowerCase()
//         .replaceAll(RegExp(r'[^a-z0-9\s]'), '')
//         .replaceAll(RegExp(r'\s+'), ' ');
//   }
//
//   Future<void> _submitReport() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() => _isSubmitting = true);
//
//     try {
//       // Upload image if exists
//       if (_imageFile != null) {
//         _cloudinaryUrl = await CloudinaryService().uploadImage(_imageFile!);
//       }
//
//       // Prepare data with normalized text
//       final data = {
//         'name': _normalizeText(_nameController.text),
//         'item': _normalizeText(_itemController.text),
//         'location': _normalizeText(_locationController.text),
//         'description': _normalizeText(_descriptionController.text),
//         'contact': _contactController.text.trim(),
//         'keywords': [
//           ..._itemController.text.split(' '),
//           ..._descriptionController.text.split(' '),
//           ..._locationController.text.split(' ')
//         ].where((w) => w.length > 2).map(_normalizeText).toList(),
//         'imageUrl': _cloudinaryUrl,
//         'date': _selectedDate?.toIso8601String(),
//         'timestamp': FieldValue.serverTimestamp(),
//         'userId': FirebaseAuth.instance.currentUser!.uid,
//         'isClaimed': false,
//         'claimerId': null,
//       };
//
//       // Save to Firestore
//       final collection = widget.isLostItem ? 'lost_items' : 'found_items';
//       await FirebaseFirestore.instance.collection(collection).add(data);
//
//       // Navigate to matches
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ReportListScreen(
//             isLostItem: widget.isLostItem,
//             searchQuery: '${_itemController.text} ${_locationController.text}',
//           ),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: ${e.toString()}')),
//       );
//     } finally {
//       setState(() => _isSubmitting = false);
//     }
//   }
//
//   Future<void> _pickImage() async {
//     try {
//       // Step 1: Platform-based permission check
//       PermissionStatus status;
//       if (Platform.isAndroid) {
//         status = await Permission.storage.request();
//       } else if (Platform.isIOS) {
//         status = await Permission.photos.request();
//       } else {
//         status = await Permission.storage.request();
//       }
//
//       if (status.isDenied) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Permission denied! Settings se allow kren')),
//         );
//         return;
//       }
//
//       // Step 2: Pick image
//       final picker = ImagePicker();
//       final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//       if (pickedFile == null) return;
//
//       setState(() {
//         _imageFile = File(pickedFile.path);
//         _isUploadingImage = true; // Show loading
//       });
//
//       // Step 3: Upload to Cloudinary
//       final imageUrl = await CloudinaryService().uploadImage(_imageFile!);
//       if (imageUrl != null) {
//         setState(() {
//           _cloudinaryUrl = imageUrl; // Store URL
//           _isUploadingImage = false; // Hide loading
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Image upload ho gayi! ✅')),
//         );
//       } else {
//         throw Exception('Cloudinary upload failed');
//       }
//     } catch (e) {
//       setState(() => _isUploadingImage = false);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: ${e.toString()}')),
//       );
//     }
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null) setState(() => _selectedDate = picked);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF22E5FF), Color(0xFF3E7ACF)],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           children: [
//             //const CustomHeader(),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Form(
//                   key: _formKey,
//                   child: SingleChildScrollView(
//                     child: Column(
//                         children: [
//                         _buildTextField('Your Name', _nameController),
//                           _buildTextField(
//                             'Contact Number',
//                             _contactController,
//                             hint: 'e.g., 03XXXXXXXXX',
//                             keyboardType: TextInputType.phone,
//                           ),
//
//                           _buildTextField('Item Category ' , _itemController,maxLines: 2,
//                             hint:"e.g Electronics,Bag,Accessories,Documents,Keys,Wearables,Clothing,Others" ),
//                     _buildTextField('Location Lost/Found', _locationController,
//                         hint: 'e.g., Central Park, New York'),
//                     _buildDatePicker(),
//                     _buildTextField('Item Description', _descriptionController,
//                         maxLines: 3),
//                     _buildPhotoUpload(),
//                     const SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: _isSubmitting ? null : _submitReport,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue[800],
//                         padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                       ),
//                       child: _isSubmitting
//                           ? const CircularProgressIndicator()
//                           : const Text('Submit Report', style: TextStyle(fontSize: 18)),
//                     )],
//                     ),
//                   ),
//                 ),
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
//         int maxLines = 1,
//         String? hint,
//         TextInputType keyboardType = TextInputType.text,
//       }) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 15.0),
//       child: TextFormField(
//         controller: controller,
//         maxLines: maxLines,
//         keyboardType: keyboardType,
//         decoration: InputDecoration(
//           labelText: label,
//           hintText: hint,
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         validator: (value) => value!.isEmpty ? 'Required field' : null,
//       ),
//     );
//   }
//
//
//   Widget _buildDatePicker() {
//     return InkWell(
//       onTap: () => _selectDate(context),
//       child: InputDecorator(
//         decoration: InputDecoration(
//           labelText: 'Date',
//           filled: true,
//           fillColor: Colors.white,
//           border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10)),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(_selectedDate != null
//                 ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
//                 : 'Select Date'),
//             const Icon(Icons.calendar_today),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPhotoUpload() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text('Upload Photo :',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
//         const SizedBox(height: 8),
//         InkWell(
//           onTap: _pickImage,
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(5),
//             ),
//             child: Stack(
//               alignment: Alignment.center,
//               children: [
//                 // Image Preview
//                 if (_imageFile != null || _cloudinaryUrl != null)
//                   Container(
//                     width: 80,
//                     height: 80,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.green),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(6),
//                       child: _cloudinaryUrl != null
//                           ? Image.network(_cloudinaryUrl!, fit: BoxFit.cover)
//                           : Image.file(_imageFile!, fit: BoxFit.cover),
//                     ),
//                   ),
//
//                 // Upload Status Indicators
//                 if (_isUploadingImage)
//                   const CircularProgressIndicator(),
//                 if (_cloudinaryUrl != null && !_isUploadingImage)
//                   const Positioned(
//                     right: 0,
//                     top: 0,
//                     child: Icon(Icons.check_circle, color: Colors.green, size: 24),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//
//
// }


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import '../services/cloudinary_service.dart';
import '/screens/report_list_screen.dart';
import '/widgets/app_drawer.dart';
import '/widgets/custom_footer.dart';
import '/widgets/custom_header.dart';

class ReportScreen extends StatefulWidget {
  final bool isLostItem;
  final Map<String, dynamic>? existingData;
  final String? docId;
  const ReportScreen({
    Key? key,
    required this.isLostItem,
    this.existingData,
    this.docId,
  }) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _nameController = TextEditingController();
  final _itemController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _contactController = TextEditingController();
  File? _imageFile;
  String? _cloudinaryUrl;
  bool _isUploadingImage = false;
  bool _isHoveringSubmit = false;
  DateTime? _selectedDate;
  bool _isSubmitting = false;

  String _normalizeText(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9\s]'), '')
        .replaceAll(RegExp(r'\s+'), ' ');
  }

  Future<void> _submitReport() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      // Upload image if exists
      if (_imageFile != null) {
        _cloudinaryUrl = await CloudinaryService().uploadImage(_imageFile!);
      }

      // Prepare data with normalized text
      final data = {
        'name': _normalizeText(_nameController.text),
        'item': _normalizeText(_itemController.text),
        'location': _normalizeText(_locationController.text),
        'description': _normalizeText(_descriptionController.text),
        'contact': _contactController.text.trim(),
        'keywords': [
          ..._itemController.text.split(' '),
          ..._descriptionController.text.split(' '),
          ..._locationController.text.split(' ')
        ].where((w) => w.length > 2).map(_normalizeText).toList(),
        'imageUrl': _cloudinaryUrl,
        'date': _selectedDate?.toIso8601String(),
        'timestamp': FieldValue.serverTimestamp(),
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'isClaimed': false,
        'claimerId': null,
      };

      // Save to Firestore
      final collection = widget.isLostItem ? 'lost_items' : 'found_items';
      await FirebaseFirestore.instance.collection(collection).add(data);

      // Navigate to matches
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ReportListScreen(
            isLostItem: widget.isLostItem,
            searchQuery: '${_itemController.text} ${_locationController.text}',
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  Future<void> _pickImage() async {
    try {
      // Step 1: Platform-based permission check
      PermissionStatus status;
      if (Platform.isAndroid) {
        status = await Permission.storage.request();
      } else if (Platform.isIOS) {
        status = await Permission.photos.request();
      } else {
        status = await Permission.storage.request();
      }

      if (status.isDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Permission denied! Please allow from settings')),
        );
        return;
      }

      // Step 2: Pick image
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;

      setState(() {
        _imageFile = File(pickedFile.path);
        _isUploadingImage = true; // Show loading
      });

      // Step 3: Upload to Cloudinary
      final imageUrl = await CloudinaryService().uploadImage(_imageFile!);
      if (imageUrl != null) {
        setState(() {
          _cloudinaryUrl = imageUrl; // Store URL
          _isUploadingImage = false; // Hide loading
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Image uploaded successfully! ✅')),
        );
      } else {
        throw Exception('Cloudinary upload failed');
      }
    } catch (e) {
      setState(() => _isUploadingImage = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _selectedDate = picked);
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
              child: Padding(
                padding: EdgeInsets.all(isMobile ? 16 : 24),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
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
                        child: Form(
                          key: _formKey,
                          child: Column(
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
                                child: Text(
                                  widget.isLostItem ? 'Report Lost Item' : 'Report Found Item',
                                  style: TextStyle(
                                    fontSize: isMobile ? 28 : 32,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.1,
                                    color: Colors.white
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Please provide accurate details to help with recovery',
                                style: TextStyle(
                                  fontSize: isMobile ? 14 : 16,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 30),
                              _buildTextField('Your Name', _nameController),
                              const SizedBox(height: 20),
                              _buildTextField(
                                'Contact Number',
                                _contactController,
                                hint: 'e.g., 03XXXXXXXXX',
                                keyboardType: TextInputType.phone,
                              ),
                              const SizedBox(height: 20),
                              _buildTextField(
                                  'Item Category',
                                  _itemController,
                                  maxLines: 3,
                                  hint: "e.g Electronics, Bag, Accessories, Documents, Keys, Wearables, Clothing, Others"
                              ),
                              const SizedBox(height: 20),
                              _buildTextField(
                                  'Location Lost/Found',
                                  _locationController,
                                  hint: 'e.g., Central Park, New York'
                              ),
                              const SizedBox(height: 20),
                              _buildDatePicker(),
                              const SizedBox(height: 20),
                              _buildTextField(
                                  'Item Description',
                                  _descriptionController,
                                  maxLines: 3
                              ),
                              const SizedBox(height: 20),
                              _buildPhotoUpload(),
                              const SizedBox(height: 30),
                              MouseRegion(
                                onEnter: (_) => setState(() => _isHoveringSubmit = true),
                                onExit: (_) => setState(() => _isHoveringSubmit = false),
                                child: GestureDetector(
                                  onTap: _isSubmitting ? null : _submitReport,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      gradient: LinearGradient(
                                        colors: _isHoveringSubmit
                                            ? [const Color(0xFF00DBDE), const Color(0xFFFC00FF)]
                                            : [const Color(0xFF00DBDE).withOpacity(0.9), const Color(0xFFFC00FF).withOpacity(0.9)],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: (_isHoveringSubmit ? const Color(0xFF00DBDE) : const Color(0xFFFC00FF))
                                              .withOpacity(0.4),
                                          blurRadius: _isHoveringSubmit ? 20 : 10,
                                          offset: Offset(0, _isHoveringSubmit ? 8 : 4),
                                        ),
                                      ],
                                    ),
                                    child: _isSubmitting
                                        ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 3,
                                      ),
                                    )
                                        : const Text(
                                      'Submit Report',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
        int maxLines = 1,
        String? hint,
        TextInputType keyboardType = TextInputType.text,
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
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
            filled: true,
            fillColor: Colors.white.withOpacity(0.1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
          validator: (value) => value!.isEmpty ? 'Required field' : null,
        ),
      ],
    );
  }

  Widget _buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Date',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _selectedDate != null
                      ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
                      : 'Select Date',
                  style: const TextStyle(color: Colors.white),
                ),
                const Icon(Icons.calendar_today, color: Colors.white),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upload Photo',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            height: 150,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1.5,
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Image Preview
                if (_imageFile != null || _cloudinaryUrl != null)
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: _cloudinaryUrl != null
                          ? Image.network(_cloudinaryUrl!, fit: BoxFit.cover)
                          : Image.file(_imageFile!, fit: BoxFit.cover),
                    ),
                  ),

                // Upload Status Indicators
                if (_isUploadingImage)
                  const CircularProgressIndicator(),

                if ((_imageFile == null && _cloudinaryUrl == null) && !_isUploadingImage)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload_rounded,
                        size: 48,
                        color: Colors.white.withOpacity(0.6),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap to upload image',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),

                if (_cloudinaryUrl != null && !_isUploadingImage)
                  Positioned(
                    right: 10,
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00DBDE),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}