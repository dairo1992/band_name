import 'dart:io';

import 'package:band_name/models/band_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: "Vallenato", votes: 5),
    Band(id: '2', name: "Pop", votes: 3),
    Band(id: '3', name: "Regaeton", votes: 8),
    Band(id: '4', name: "Salsa", votes: 6),
    Band(id: '5', name: "Ranchera", votes: 5),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BandName", style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int i) {
          return _bandTile(bands[i]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: addBand,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (d) {
        print("Direccion: ${d}, id: ${band.id}");
      },
      background: Container(
        padding: EdgeInsets.only(left: 8.6),
        color: Colors.red,
        child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: const [
                Text("Delete",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
                SizedBox(),
                Icon(Icons.delete, color: Colors.white, size: 25)
              ],
            )),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(band.name.substring(0, 2)),
        ),
        title: Text(band.name),
        trailing: Text('${band.votes}', style: TextStyle(fontSize: 20)),
        onTap: () {
          print("${band.name}");
        },
      ),
    );
  }

  addBand() {
    final textController = TextEditingController();
    if (!Platform.isAndroid) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("New Band Name"),
            content: TextField(controller: textController),
            actions: [
              MaterialButton(
                  child: Text("Add"),
                  elevation: 5,
                  textColor: Colors.blue,
                  onPressed: () => addBandToList(textController.text))
            ],
          );
        },
      );
    } else {
      showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text("New Band Name"),
              content: CupertinoTextField(controller: textController),
              actions: [
                CupertinoDialogAction(
                    child: Text("Add"),
                    onPressed: () => addBandToList(textController.text)),
                CupertinoDialogAction(
                    textStyle: TextStyle(color: Colors.red),
                    isDefaultAction: true,
                    child: Text("Close"),
                    onPressed: () => Navigator.pop(context)),
              ],
            );
          });
    }
  }

  void addBandToList(String name) {
    if (name.length > 1) {
      bands.add(Band(id: DateTime.now().toString(), name: name));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
