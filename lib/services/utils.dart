import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class AppUtils {
  ///Build a dynamic link firebase
  static Future<String> buildDynamicLink() async {
    String url = "https://myevents.page.link";
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: url,
      link: Uri.parse('$url/post/Invitation'),
      androidParameters: AndroidParameters(
        packageName: "com.event.dynamic_link",
        minimumVersion: 0,
      ),

      socialMetaTagParameters: SocialMetaTagParameters(
          description: "Event Invitation",
          imageUrl:
          Uri.parse("https://images-na.ssl-images-amazon.com/images/I/41IZj0f2gCL.png"),
          title: "Event Invitation"),
    );
    final ShortDynamicLink dynamicUrl = await parameters.buildShortLink();
    return dynamicUrl.shortUrl.toString();
  }
}