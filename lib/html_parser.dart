import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;

class HtmlParser {
  Future<String> fetchHtml(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load HTML');
    }
  }

  String parseHtml(String html) {
    var document = html_parser.parse(html);
    // Perform any parsing or modification you need here
    return document.outerHtml;
  }
}