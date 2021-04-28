import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Word Generator',
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  @override
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = TextStyle(fontSize: 18.0);
  int _numberOfFavorites = 0;
  int _numberOfDeletes = 0;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            new Column(
              children: [
                Text("Startup Name Generator"),
              ],
            ),
            new Column(
              children: [
                Text("Favorites"),
                Text(_numberOfFavorites.toString())
              ],
            ),
            new Column(
              children: [Text("Deletes"), Text(_numberOfDeletes.toString())],
            )
          ],
        ),
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Wrap(
        spacing: 12,
        children: [
          IconButton(
            icon: new Icon(Icons.delete),
            onPressed: () {
              setState(() {
                if (alreadySaved) {
                  _saved.remove(pair);
                  _numberOfFavorites--;
                }
                _suggestions.remove(pair);
                _numberOfDeletes++;
              });
            },
          ),
          IconButton(
            icon: new Icon(
              alreadySaved ? Icons.favorite : Icons.favorite_outline,
              color: Colors.red,
            ),
            onPressed: () {
              setState(() {
                if (alreadySaved) {
                  _saved.remove(pair);
                  _numberOfFavorites--;
                } else {
                  _saved.add(pair);
                  _numberOfFavorites++;
                }
              });
            },
          ),
        ],
      ),
    );
  }
}
