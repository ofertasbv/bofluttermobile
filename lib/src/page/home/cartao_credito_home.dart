import 'package:bofluttermobile/src/page/cliente/cliente_create_page.dart';
import 'package:bofluttermobile/src/page/promocao/promocao_page.dart';
import 'package:flutter/material.dart';

class CartaoCreditoHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.indigo[900], Colors.deepPurple[400]],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: ListTile(
              title: Text(
                "Tem um cartão BoooOfertas?",
                style: TextStyle(
                  color: Colors.grey[100],
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "Acesse sua fatura e muito mais!",
                style: TextStyle(
                  color: Colors.yellow[800],
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: CircleAvatar(
                backgroundColor: Colors.yellow[800],
                radius: 50,
                child: IconButton(
                  color: Colors.white,
                  icon: Icon(
                    Icons.credit_card,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return PromocaoPage();
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: ListTile(
              leading: RaisedButton(
                child: Text("ENTRAR OU CADASTRAR"),
                color: Colors.grey[100],
                padding: EdgeInsets.only(left: 20, right: 20),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ClienteCreatePage();
                      },
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
