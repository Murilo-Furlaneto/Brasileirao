import 'package:brasileirao/provider/home_view_model.dart';
import 'package:brasileirao/provider/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<HomeViewModel>(context, listen: false);
    viewModel.initializeData();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Brasileirão'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Tabela'),
            Tab(text: 'Artilheiros'),
          ],
        ),
      ),
      body: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.errorMessage != null) {
            return Center(child: Text(viewModel.errorMessage!));
          }

          if (viewModel.tabela == null || viewModel.artilheiros == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return TabBarView(
            controller: _tabController,
            children: [
              ListView.builder(
                itemCount: viewModel.tabela!.length,
                itemBuilder: (context, index) {
                  final tabela = viewModel.tabela![index];
                  return ListTile(
                    title: Text(tabela.nomeTime),
                    subtitle: Text(
                        'Posição: ${tabela.posicao}, Pontos: ${tabela.pontos}'),
                  );
                },
              ),
              ListView.builder(
                itemCount: viewModel.artilheiros!.length,
                itemBuilder: (context, index) {
                  final artilheiro = viewModel.artilheiros![index];
                  return ListTile(
                    title: Text(artilheiro.nomeJogador),
                    subtitle: Text('Gols: ${artilheiro.gols}'),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
