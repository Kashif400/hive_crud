import 'package:flutter/material.dart';

class Count extends StatefulWidget {
  const Count({Key? key}) : super(key: key);

  @override
  _CountState createState() => _CountState();
}

class _CountState extends State<Count> {
  List<int> counts = List.generate(14, (index) => 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Item"),
      ),
      body: ListView.builder(
        itemCount: 14,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("item ${index + 1}"),
            trailing: FittedBox(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        counts[index]++;
                      });
                    },
                    icon: Icon(Icons.add),
                  ),
                  Text(counts[index].toString()),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (counts[index] > 0) {
                          counts[index]--;
                        }
                      });
                    },
                    icon: Icon(Icons.remove),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Count(),
  ));
}
