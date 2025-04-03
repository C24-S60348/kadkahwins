import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html_parser;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class WebViewPage extends StatelessWidget {
  final String url;

  const WebViewPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WebView')),
      body: Center(
        child: Text(
          'WebView for URL: $url',
        ), // Replace with actual WebView implementation
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Celik Tafsir App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? htmlContent;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadHtmlContent();
  }

  Future<void> loadHtmlContent() async {
    final storedHtml = await getHtmlFromLocalStorage();
    if (storedHtml != null) {
      setState(() {
        htmlContent = storedHtml;
        isLoading = false;
      });
    } else {
      fetchAndStoreHtml();
    }
  }

  Future<void> fetchAndStoreHtml() async {
    setState(() {
      isLoading = true;
    });
    try {
      const proxyUrl = 'https://quiet-sun-5b87.afwanhaziq987.workers.dev/?url=';
      const url = '${proxyUrl}https://celiktafsir.net';
      final html = await fetchHtml(url);
      final parsedHtml = parseHtml(html);
      await saveHtmlToLocalStorage(parsedHtml);
      setState(() {
        htmlContent = parsedHtml;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error
    }
  }

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
    return document.body!.innerHtml; // clean the html here.
  }

  Future<void> saveHtmlToLocalStorage(String html) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('htmlContent', html);
  }

  Future<String?> getHtmlFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('htmlContent');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Celik Tafsir App')),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : htmlContent != null
              ? SingleChildScrollView(
                child: Html(
                  data: htmlContent!,
                  onLinkTap: (url, attributes, element) {
                    if (url != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebViewPage(url: url),
                        ),
                      );
                    }
                  },
                ),
              )
              : const Center(child: Text('Failed to load content.')),
    );
  }
}
