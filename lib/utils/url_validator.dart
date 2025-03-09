import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class UrlValidator {
  static bool isPinterestUrl(String url) {
    return url.contains('pinterest.com');
  }

  static Future<String?> getMediaUrl(String pinterestUrl) async {
    try {
      final response = await http.get(Uri.parse(pinterestUrl));
      if (response.statusCode == 200) {
        final document = parser.parse(response.body);

        // Extract image URL
        final imageElement = document.querySelector('img');
        if (imageElement != null) {
          final imageUrl = imageElement.attributes['src'];
          print('Extracted image URL: $imageUrl'); // Debug log
          return imageUrl;
        }

        // Extract video URL
        final videoElement = document.querySelector('video');
        if (videoElement != null) {
          final videoUrl = videoElement.attributes['src'];
          print('Extracted video URL: $videoUrl'); // Debug log
          return videoUrl;
        }
      }
      return null;
    } catch (e) {
      print('Error extracting media URL: $e'); // Debug log
      return null;
    }
  }

  static String getMediaType(String mediaUrl) {
    if (mediaUrl.contains('.jpg') || mediaUrl.contains('.png')) {
      return 'image';
    } else if (mediaUrl.contains('.mp4')) {
      return 'video';
    } else if (mediaUrl.contains('.gif')) {
      return 'gif';
    }
    return 'unknown';
  }
}