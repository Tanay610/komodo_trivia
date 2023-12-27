import 'package:flutter/material.dart';
import 'package:komodo_trivia/domain/entities/categories.dart';
import 'package:komodo_trivia/presentation/providers/quiz_provider.dart';
import 'package:komodo_trivia/presentation/screens/loading_page.dart';
import 'package:komodo_trivia/presentation/screens/quiz_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TriviaCategory> categories = [];
  late TriviaCategory? selectedCategory;

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  Future<void> loadCategories() async {
    final response =
        await http.get(Uri.parse('https://opentdb.com/api_category.php'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        categories = List<TriviaCategory>.from(data['trivia_categories'].map(
          (category) => TriviaCategory(
            name: category['name'],
            id: category['id'],
          ),
        ));
        selectedCategory = categories.isNotEmpty ? categories.first : null;
      });
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Komodo Trivia',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        backgroundColor: Color.fromARGB(255, 226, 191, 231),
      ),
      body: Consumer<QuizProvider>(
        builder: (context, QuizProvider quizProvider, child) {
          return SafeArea(
            child: Center(
                child: categories.isEmpty
                    ? CircularProgressIndicator()
                    : SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Choose Category:",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 27),
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: BouncingScrollPhysics(),
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                TriviaCategory category = categories[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    tileColor: Colors.yellow[100],
                                    splashColor: Colors.purple[200],
                                    title: Text(category.name,
                                    style: TextStyle(),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        selectedCategory = categories[index];
                                      });
                                      // quizProvider
                                      //     .setSelectedCategoryId(selectedCategory!.id);
                                      // quizProvider.setOriginalContext(context);

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            // builder: (context) => QuizPage(category: selectedCategory!.id,),
                                            builder: (context) {
                                          return LoadingScreen(
                                              index: selectedCategory!.id,
                                              selectedDif: '');
                                        }),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )),
          );
        },
      ),
    );
  }
}
