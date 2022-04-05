import 'package:flutter/material.dart';
import 'package:otimizador_academico/select_classes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // This holds a list of fiction users
  // You can use data fetched from a database or a server as well

  List<Map<String, dynamic>> selectedClasses = [];

  @override
  initState() {
    // at the beginning, all users are shown

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Otimizador Acadêmico'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ElevatedButton(
                child: const Text('Open route'),
                onPressed: () async {
                  //there is await inside, so add async tag

                  var result = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return SelectClassesPage(
                      selectedClasses: selectedClasses,
                    );
                  })); //Navigate to another page
                  // this will return data which is assigned on Navigator.pop(context, returndata);

                  setState(() {
                    print(result);
                    selectedClasses =
                        result; //update the returndata with the return result,
                    //update UI with setState()
                  });
                })
          ],
        ),
      ),
    );
  }
}
