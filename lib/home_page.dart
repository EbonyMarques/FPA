import 'package:flutter/material.dart';
import 'package:otimizador_academico/login_page.dart';
import 'package:otimizador_academico/recommended_classes_page.dart';
import 'package:otimizador_academico/select_classes_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_service.dart';
import 'database.dart';
import 'package:firebase_core/firebase_core.dart';

class HomePage extends StatefulWidget {
  final void Function(bool) setDarkMode;
  final bool darkMode;
  final dynamic uid;
  const HomePage(
      {Key? key,
      required this.setDarkMode,
      required this.darkMode,
      required this.uid})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();
  dynamic selectedClasses = [];
  String dropdownvalue = '5';
  var items = ['3', '4', '5'];
  bool change = false;
  late bool darkMode;
  dynamic data = 0;
  String email = 'Carregando...';
  String displayName = 'Carregando...';

  @override
  initState() {
    super.initState();
    darkMode = widget.darkMode;
    getDataLocal();
    teste();
  }

  void sort() {
    setState(() {
      selectedClasses.sort((a, b) {
        return a['id'].compareTo(b['id']) as int;
      });
    });
  }

  void getDataLocal() async {
    Map<String, dynamic> data1 = await getData(widget.uid);
    print('opaaa');
    print(data1);

    dynamic data2 = [];
    dynamic data3 = [];
    setState(() {
      data1.forEach((k, v) => data2.add(v));
      data = data2;
      data2.forEach((d) => {
            if (d['isSelected']) {data3.add(d)}
          });
      selectedClasses = data3;
      sort();
      print('hahaha');
      print(selectedClasses);
    });
  }

  void teste() async {
    String? d = await authService.getDisplayName();
    String? e = await authService.getEmail();

    setState(() {
      if (d is String) {
        displayName = d as String;
      }

      email = e as String;
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    print('verificando');
    print(widget.darkMode);
    print(widget.uid);
    print(data);
    print(selectedClasses);
    print('email');
    print(displayName);
    print(email);

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Bem-vindo(a), ' + email + '!',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: !darkMode
                  ? Icon(
                      Icons.dark_mode,
                    )
                  : Icon(
                      Icons.light_mode,
                    ),
              title: Text(darkMode ? 'Modo claro' : 'Modo escuro'),
              onTap: () async {
                print('to aqui');
                String? theme = await authService.getTheme();
                print('vamos ver');
                print(theme);
                if (theme == 'light') {
                  print('troquei 1');
                  authService.setThemeMode('dark');
                  widget.setDarkMode(true);
                  setState(() {
                    darkMode = true;
                  });
                } else if (theme == 'dark') {
                  print('troquei 2');
                  authService.setThemeMode('light');
                  widget.setDarkMode(false);
                  setState(() {
                    darkMode = false;
                  });
                }

                setState(() {
                  change = true;
                });
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Sair'),
              onTap: () async {
                authService.cleanToken();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => LoginPage(
                        setDarkMode: widget.setDarkMode, darkMode: darkMode)));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Otimizador Acadêmico'),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
            child: selectedClasses.length > 0
                ? Column(
                    children: [
                      Row(children: [
                        Text(
                          selectedClasses.length == 1
                              ? '${selectedClasses.length} DISCIPLINA CURSADA'
                              : '${selectedClasses.length} DISCIPLINAS CURSADAS',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              letterSpacing: 1),
                        )
                      ]),
                      SizedBox(
                        height: 10,
                      ),
                      Flexible(
                        child: ConstrainedBox(
                            constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height - 280,
                                minHeight: 10),
                            child: ListView.builder(
                                itemCount: selectedClasses.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) => ListTile(
                                      title:
                                          Text(selectedClasses[index]['name']),
                                      subtitle: Text(
                                          '${selectedClasses[index]['timeCourse']}º período'),
                                      contentPadding:
                                          EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      visualDensity:
                                          VisualDensity(vertical: -2.5),
                                    ))),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.fromLTRB(0, 20, 0, 20)),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.blue),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                    overlayColor: MaterialStateProperty.all(
                                        Color.fromARGB(255, 107, 185, 248))),
                                child: const Text(
                                  'SELECIONAR DISCIPLINAS CURSADAS',
                                  style: TextStyle(
                                      letterSpacing: 1, color: Colors.white),
                                ),
                                onPressed: () async {
                                  var result = await Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SelectClassesPage(
                                      selectedClasses: data,
                                    );
                                  }));
                                  setState(() {
                                    print(result);
                                    data = result;
                                    dynamic data100 = [];
                                    result.forEach((d) => {
                                          if (d['isSelected']) {data100.add(d)}
                                        });
                                    selectedClasses = data100;
                                    sort();
                                    updateData(widget.uid, result);
                                  });
                                }),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: TextButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.fromLTRB(0, 20, 0, 20)),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                                overlayColor:
                                    // 0xFF8adeaf
                                    MaterialStateProperty.all(
                                        Color.fromARGB(255, 107, 185, 248))),
                            child: const Text(
                              'BUSCAR DISCIPLINAS RECOMENDADAS',
                              style: TextStyle(
                                  letterSpacing: 1, color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RecommendedClassesPage(
                                          selectedClasses: data,
                                          darkMode: darkMode,
                                        )),
                              );
                            },
                          ))
                        ],
                      )
                    ],
                    // ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Flexible(
                                child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1.0,
                                          // color: Color(0xFF3b3b3b),
                                          color: darkMode == true
                                              ? Colors.grey
                                              : Color(0xFF3b3b3b),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    child: Center(
                                      child:
                                          Text('NENHUMA DISCIPLINA SELECIONADA',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1,
                                                // color: Color(0xFF3b3b3b),
                                                color: darkMode == true
                                                    ? Colors.white
                                                    : Color(0xFF3b3b3b),
                                              )),
                                    )))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          EdgeInsets.fromLTRB(0, 20, 0, 20)),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.blue),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                      overlayColor:
                                          // 0xFF8adeaf
                                          MaterialStateProperty.all(
                                              Color.fromARGB(
                                                  255, 107, 185, 248))),
                                  child: const Text(
                                    'SELECIONAR DISCIPLINAS CURSADAS',
                                    style: TextStyle(
                                        letterSpacing: 1, color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    var result = await Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return SelectClassesPage(
                                        selectedClasses: selectedClasses,
                                      );
                                    }));
                                    setState(() {
                                      print(result);
                                      data = result;
                                      dynamic data100 = [];
                                      result.forEach((d) => {
                                            if (d['isSelected'])
                                              {data100.add(d)}
                                          });
                                      selectedClasses = data100;
                                      updateData(widget.uid, result);
                                    });
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
      ),
    );
  }
}
