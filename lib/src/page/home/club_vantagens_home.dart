import 'package:bofluttermobile/src/page/cliente/cliente_create_page.dart';
import 'package:bofluttermobile/src/page/promocao/promocao_page.dart';
import 'package:flutter/material.dart';

class ClubVantagensHome extends StatelessWidget {
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
          colors: [Colors.deepPurple[800], Colors.deepPurple[300]],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: ListTile(
              title: Text(
                "Ser cliente vip bookofertas tém compensas",
                style: TextStyle(
                  color: Colors.grey[100],
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "Junte moedas atraves de suas compras e troque por recompensas incriveis",
                style: TextStyle(
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: CircleAvatar(
                backgroundColor: Colors.deepPurpleAccent,
                radius: 50,
                child: IconButton(
                  color: Colors.white,
                  icon: Icon(
                    Icons.wallet_giftcard,
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
