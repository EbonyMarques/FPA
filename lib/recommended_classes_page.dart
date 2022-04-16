import 'package:flutter/material.dart';

class RecommendedClassesPage extends StatefulWidget {
  RecommendedClassesPage({Key? key, required this.selectedClasses})
      : super(key: key);

  List<Map<String, dynamic>> selectedClasses;

  @override
  _RecommendedClassesPageState createState() => _RecommendedClassesPageState();
}

class _RecommendedClassesPageState extends State<RecommendedClassesPage> {
  @override
  initState() {
    if (!widget.selectedClasses.isEmpty) {
      for (var i = 0; i < widget.selectedClasses.length; i++) {
        var currentElement = widget.selectedClasses[i]['id'];

        print(widget.selectedClasses[i]);
      }
    }

    super.initState();
    print(widget.selectedClasses);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Disciplinas recomendadas'),
          leading: BackButton(
            onPressed: () => Navigator.pop(context, widget.selectedClasses),
          ),
        ),
        body: WillPopScope(
          //WillPopScope will replace the default
          //"Mobile Back Button" and "Appbar Back button" action
          onWillPop: () {
            //on Back button press, you can use WillPopScope for another purpose also.
            Navigator.pop(
                context, widget.selectedClasses); //return data along with pop
            return new Future(
                () => false); //onWillPop is Future<bool> so return false
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  child: widget.selectedClasses.isNotEmpty
                      ? ListView.builder(
                          itemCount: widget.selectedClasses.length,
                          itemBuilder: (context, index) => ListTile(
                                // leading: Text(
                                //   _foundClasses[index]["id"].toString(),
                                //   style: const TextStyle(fontSize: 24),
                                // ),
                                title:
                                    Text(widget.selectedClasses[index]['name']),
                                // subtitle: Text(
                                //     '${_foundClasses[index]["age"].toString()} years old'),
                                trailing: widget.selectedClasses[index]
                                        ['isSelected']
                                    ? Icon(
                                        Icons.check_circle,
                                        color: Colors.green[700],
                                      )
                                    : Icon(
                                        Icons.check_circle_outline,
                                        color: Colors.grey,
                                      ),
                              ))
                      : const Text(
                          '...',
                          style: TextStyle(fontSize: 16),
                        ),
                ),
              ],
            ),
          ),
        ));
  }
}
