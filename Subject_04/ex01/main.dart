import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:subject/models/pixabay_data_model.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'pixabay_search',
      theme: ThemeData.dark(useMaterial3: true),
      home: const MyHomePage(title: 'Pixabay Search'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formKey = GlobalKey<FormState>();
  String query = '';
  late List<PixabayDataModel> photos;
  late TextEditingController searchController;
  late TextEditingController filterController;

  void _submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      final search = searchController.text;
      final filter = filterController.text;
      setState(() {
        query =
            '&q=${search.replaceAll(' ', '+')}+${filter.replaceAll(' ', '+')}';
      });
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Input Search Keyword'),
    ));
  }

  @override
  void initState() {
    super.initState();
    photos = [];
    searchController = TextEditingController();
    filterController = TextEditingController();
  }

  @override
  void dispose() {
    photos = [];
    searchController.dispose();
    filterController.dispose();
    super.dispose();
  }

  Future<List<PixabayDataModel>> _fetchPhotos([String? query]) async {
    String key = dotenv.get('PIXABAY_KEY');
    final response = await Client().get(
        Uri.parse('https://pixabay.com/api/?key=$key&image_type=photo$query'));
    final decode = json.decode(response.body) as Map<String, dynamic>;
    photos = [];
    for (var hit in (decode["hits"] as List<dynamic>)) {
      photos.add(PixabayDataModel.fromMap(hit));
    }
    return (photos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  helperText: ' ',
                  hintText: 'Search : Tree, Car, Space, Etc...',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.photo),
                  suffixIcon: IconButton(
                    onPressed: _submit,
                    icon: const Icon(Icons.search),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Input Search Keyword.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (value) {
                  final search = searchController.text;
                  setState(() {
                    query =
                        '&q=${search.replaceAll(' ', '+')}+${value.replaceAll(' ', '+')}';
                  });
                },
                controller: filterController,
                decoration: const InputDecoration(
                  hintText: 'Filter : ',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.photo_library_outlined),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: FutureBuilder<List<PixabayDataModel>>(
                  future: _fetchPhotos(query),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<PixabayDataModel> photos = snapshot.data!;
                      const double spacing = 10;
                      return GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 150,
                          crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                          childAspectRatio: 1, //item 의 가로 1, 세로 2 의 비율
                          mainAxisSpacing: spacing, //수평 Padding
                          crossAxisSpacing: spacing, //수직 Padding
                        ),
                        itemCount: photos.length,
                        itemBuilder: (context, index) {
                          final photo = photos[index];
                          return GridTile(
                            footer: GridTileBar(
                              backgroundColor: Colors.black54,
                              title: Text(
                                photo.tags,
                              ),
                            ),
                            child: Image.network(
                              photo.previewURL,
                              fit: BoxFit.fitHeight,
                            ),
                          );
                        },
                      );
                    }
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Something wrong'),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColorLight,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
