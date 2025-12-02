import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

class CloudinaryService {
  static const String _cloudName = 'dmeso9pdg'; // Cloudinary Dashboard se lo
  static const String _uploadPreset = 'unsigned_preset'; // Unsigned preset ka naam

  Future<String?> uploadImage(File image) async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/$_cloudName/image/upload');

    // Request banayein
    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = _uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', image.path));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final jsonData = jsonDecode(responseData);
        return jsonData['secure_url']; // Image ka URL return karega
      }
      return null;
    } catch (e) {
      print('Cloudinary Error: $e');
      return null;
    }
  }
}