import 'package:flutter/material.dart';

// import 'package:otimizador_academico/contact_model.dart';
import 'contact_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ClassModel> classes = [
    ClassModel("Zaman", false),
    ClassModel("Naim", false),
    ClassModel("Sardar", false),
    ClassModel("Baqer", false),
    ClassModel("Yasin", false),
    ClassModel("Hurmat", false),
    ClassModel("M.Ali", false),
  ];

  List<ClassModel> selectedclasses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Disciplinas cursadas"),
        centerTitle: false,
        backgroundColor: Colors.green[700],
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: classes.length,
                    itemBuilder: (BuildContext context, int index) {
                      // return item
                      return ClassItem(
                        classes[index].name,
                        // classes[index].phoneNumber,
                        classes[index].isSelected,
                        index,
                      );
                    }),
              ),
              selectedclasses.length > 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 10,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          color: Colors.green[700],
                          child: Text(
                            "Delete (${selectedclasses.length})",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          onPressed: () {
                            print(
                                "Delete List Lenght: ${selectedclasses.length}");
                          },
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget ClassItem(String name, bool isSelected, int index) {
    return ListTile(
      // leading: CircleAvatar(
      //   backgroundColor: Colors.green[700],
      //   child: Icon(
      //     Icons.person_outline_outlined,
      //     color: Colors.white,
      //   ),
      // ),
      title: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      // subtitle: Text(phoneNumber),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: Colors.green[700],
            )
          : Icon(
              Icons.check_circle_outline,
              color: Colors.grey,
            ),
      // ? Icon(
      //     Icons.check_box,
      //     color: Colors.green[700],
      //   )
      // : Icon(
      //     Icons.check_box_outline_blank,
      //     color: Colors.grey,
      //   ),
      onTap: () {
        setState(() {
          classes[index].isSelected = !classes[index].isSelected;
          if (classes[index].isSelected == true) {
            selectedclasses.add(ClassModel(name, true));
          } else if (classes[index].isSelected == false) {
            selectedclasses
                .removeWhere((element) => element.name == classes[index].name);
          }
          print(selectedclasses);
        });
      },
    );
  }
}
