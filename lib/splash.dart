import 'package:consumo_app/app.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

// créditos do icone: Ícone feito por  Freepik  de  www.flaticon.com
// link: https://br.flaticon.com/icone-gratis/carro_171240#term=carro&page=1&position=68

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [
                    0.1,
                    0.5,
                    0.7,
                    0.9
                  ],
                  colors: [
                    Colors.lightBlue[300],
                    Colors.lightBlue[200],
                    Colors.lightBlue[100],
                    Colors.lightBlue[50],
                  ])),
          child: Center(
            child: Container(
              width: 800,
              height: 800,
              child: FlareActor(
                "assets/carro.flr",
                animation: "cars",
              ),
            ),
          ),
        )
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((_) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => ConsumoApp()));
    });
  }
}
