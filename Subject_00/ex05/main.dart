import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subject/custom_widget/pokemon.dart';
import 'package:subject/custom_widget/pokemon_details.dart';

// Riverpod 패키지를 사용했기 때문에 pubspec.yaml에 flutter_riverpod을 추가하길 바랍니다.
final indexProvider = StateProvider<int>((ref) {
  return 0;
});

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String title = 'My Poket';
    return const MaterialApp(
      title: title,
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final index = ref.read(indexProvider);
    final backgroundColor = index == 0 ? Colors.amber : Colors.green;
    return Scaffold(
      appBar: _buildAppBar(backgroundColor),
      backgroundColor: backgroundColor[200],
      body: _buildBody(index),
      drawer: Drawer(
        child: ListView(
          // padding: EdgeInsets.zero,
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
              ),
              child: const DrawerHeader(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                      'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/85a954df-43b3-4b66-9e8d-94fe01b0451f/da9k0wb-1ae6c8d8-0b1f-46db-a6c9-3f9b44fc29bc.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiJcL2ZcLzg1YTk1NGRmLTQzYjMtNGI2Ni05ZThkLTk0ZmUwMWIwNDUxZlwvZGE5azB3Yi0xYWU2YzhkOC0wYjFmLTQ2ZGItYTZjOS0zZjliNDRmYzI5YmMucG5nIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.ySQkI8GmpoOQ3KvsCwlwXd1l_QjJ7DsuqmcGP9fwnsE',
                    ),
                  ),
                  accountName: Text('Ash Ketchum'),
                  accountEmail: Text('Ash Ketchum@pokemonmaster.com'),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.red, Colors.blue]),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                ),
              ),
            ),
            const ListTile(
              leading: Icon(
                Icons.medical_services_outlined,
              ),
              title: Text('Poketmon center'),
            ),
            const ListTile(
              leading: Icon(
                Icons.support_agent,
              ),
              title: Text('Support'),
            ),
            const ListTile(
              leading: Icon(
                Icons.logout,
              ),
              title: Text('Logout'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(backgroundColor, ref),
    );
  }

  PreferredSizeWidget _buildAppBar(Color color) => PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          title: Text(widget.title),
          backgroundColor: color,
        ),
      );

  IndexedStack _buildBody(int index) => IndexedStack(
        index: index,
        children: [
          PokemonDetails(
            pokemon: Pokemon(
              name: 'pikachu',
              level: 4,
              imageURL:
                  'https://mblogthumb-phinf.pstatic.net/MjAxNzAyMjVfMjMg/MDAxNDg3OTUzMTI3Mzc0._tG2RA_tY9IZcrw10kWz3YfLkhcuSRxm_rUQoLRhsQEg.hndrmcX4b8HI5c_EJB_JfftjG6C79zJXLQ0g6dZy9FQg.GIF.doghter4our/IMG_3900.GIF?type=w800',
              skills: [
                'Body Blow',
                'Eletric Shocks',
                'Electro Ball',
              ],
            ),
          ),
          PokemonDetails(
            pokemon: Pokemon(
              name: 'Caterpie',
              level: 2,
              imageURL:
                  'http://file3.instiz.net/data/file3/2018/08/14/d/7/b/d7b25d5d584d77103901068ed3844b9d.gif',
              skills: [
                'Body Blow',
                'Struggle',
                'BugBite',
              ],
            ),
          ),
        ],
      );

  BottomNavigationBar _buildBottomNavigationBar(
          Color backgroundColor, WidgetRef ref) =>
      BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.flash_on),
            label: 'Pikachu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bug_report_outlined),
            label: 'Caterpie',
          ),
        ],
        backgroundColor: backgroundColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: ref.read(indexProvider),
        selectedItemColor: Colors.white,
        onTap: (value) {
          setState(() {
            ref.read(indexProvider.state).update((_) => value);
          });
        },
      );
}
