import 'package:flutter/material.dart';
import 'package:pokemon_roti/data/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPokemonData();
  }

  Future<void> _fetchPokemonData() async {
    try {
      await apiService.getData();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Pokemon Roti'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: isLoading
        ? Center(child: Text('Tunggu'))
        : ListView.builder(
          itemCount: apiService.pokeList.length,
          itemBuilder: (context, index) {
            final pokemon = apiService.pokeList[index];
            return Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      height: 375,
                      width: 375,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(20)),
                      child: Column(children: [
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            pokemon['name'],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                          ),
                        ),
                        Image.network(
                          pokemon['img'],
                          width: 300,
                          height: 200,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Tinggi: ${pokemon['height']}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'Berat: ${pokemon['weight']}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text('Kelemahan : ${pokemon['weaknesses'].join(', ')}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],),
                    ),
                  )
                ],
              ),
            );
          },
        )
    );
  }
}