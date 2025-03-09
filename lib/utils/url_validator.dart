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
          return imageElement.attributes['src'];
        }

        // Extract video URL
        final videoElement = document.querySelector('video');
        if (videoElement != null) {
          return videoElement.attributes['src'];
        }
      }
      return null;
    } catch (e) {
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