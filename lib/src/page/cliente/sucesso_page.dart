import 'package:bofluttermobile/src/page/home/home_page.dart';
import 'package:bofluttermobile/src/util/snackbar/snackbar_global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SucessoPage extends StatefulWidget {
  @override
  _SucessoPageState createState() => _SucessoPageState();
}

class _SucessoPageState extends State<SucessoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalScaffold.instance.scaffkey,
      appBar: AppBar(
        elevation: 0,
        title: Text("Confirmação de inscrição"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check,
                color: Colors.green,
                size: 50,
              ),
              Text(
                "Sua iscrição foi realizada...",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              RaisedButton.icon(
                color: Theme.of(context).accentColor,
                padding: EdgeInsets.only(left: 20, right: 20),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context){
                        return HomePage();
                      }
                    )
                  );
                },
                icon: Icon(Icons.home),
                label: Text("Voltar pro início"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
