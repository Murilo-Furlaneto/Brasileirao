import 'package:brasileirao/controller/http_service.dart';
import 'package:brasileirao/repository/api_repository.dart';
import 'package:flutter/material.dart';
import '../model/tabela_model.dart';
import '../controller/api_service.dart';
import '../model/artilheiro_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Tabela> tabela = [];
  List<Artilheiro> artilheiros = [];
  bool isDark = false;
  final ApiRepository apiRepository = ApiRepository(HttpService());

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    try {
      final tabelaData = await apiRepository.fetchCampeonato();
      final artilheirosData = await apiRepository.fetchArtilharia();

      setState(() {
        tabela = tabelaData;
        artilheiros = artilheirosData;
      });
    } catch (e) {
      print('Erro ao buscar dados: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDark ? ThemeData.dark() : ThemeData.light(),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Brasileirão 2023'),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      isDark = !isDark;
                    });
                  },
                  icon: isDark
                      ? const Icon(Icons.light_mode)
                      : const Icon(Icons.dark_mode))
            ],
            bottom: const TabBar(
              tabs: [
                Text(
                  'Tabela',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Artilheiros',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: TabBarView(
              children: [
                ListView.builder(
                  itemCount: tabela.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text(tabela[index].posicao.toString()),
                      title: Text(tabela[index].nomeTime),
                      subtitle: Text('Pontos: ${tabela[index].pontos}'),
                    );
                  },
                ),
                ListView.builder(
                  itemCount: artilheiros.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(artilheiros[index].nomeJogador),
                      subtitle: Text('Gols: ${artilheiros[index].gols} '),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
