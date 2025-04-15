import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/SocialMediaLink.dart';

class SocialLinksRepository {
  Future<List<SocialMediaLink>> getLinksForLanguage(String langCode) async {
    try {
      return await _getLinksFor(langCode);
    } catch (_) {
      return await _getLinksFor('en'); // fallback to English
    }
  }

  Future<List<SocialMediaLink>> _getLinksFor(String langCode) async {
    final subcollectionRef = FirebaseFirestore.instance
        .collection(langCode)
        .doc('social_links')
        .collection('ios'); // you can make this dynamic based on Platform.isIOS

    final snapshot = await subcollectionRef.get();

    if (snapshot.docs.isEmpty) {
      throw Exception("No social links found for language: $langCode");
    }

    return snapshot.docs.map((doc) {
      final data = doc.data();

      return SocialMediaLink(
        doc.id,               // platform ID (e.g., "telegram")
        data['url'] ?? '',    // fallback to empty string if null
        data['icon'] ?? '',   // fallback to empty string if null
        data['name'] ?? doc.id.toUpperCase(), // fallback to platform name
      );
    }).toList();
  }
}