import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart'; // https://materialdesignicons.com/
import 'package:flutter/services.dart';

class ConsumoApp extends StatefulWidget {
  @override
  _ConsumoAppState createState() => _ConsumoAppState();
}

class _ConsumoAppState extends State<ConsumoApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final formKeyConsumo = GlobalKey<FormState>();
  final formKeyKm = GlobalKey<FormState>();
  final formKeyCombustivel = GlobalKey<FormState>();

  final kmRodados = TextEditingController();
  final litros = TextEditingController();
  String consumo = "";

  final kmAtual = TextEditingController();
  final kmAnterior = TextEditingController();
  String kmRodadosTotal = "";
  String kmRodadosTotalToClip;

  final valorAlcool = TextEditingController();
  final valorGasolina = TextEditingController();
  String abastecer = "";

  void rendimento() {
    if (formKeyConsumo.currentState.validate()) {
      int km = int.parse(kmRodados.text);
      double lt = double.parse(litros.text);
      double result = km / lt;
      result.toStringAsFixed(2);

      setState(() {
        consumo = "${result.toStringAsFixed(2)}" + " Km/L";
      });
    }
  }

  void subtrairKm() {
    if (formKeyKm.currentState.validate()) {
      int kmA = int.parse(kmAtual.text);
      int kmB = int.parse(kmAnterior.text);
      int result = kmA - kmB;

      setState(() {
        kmRodadosTotal = "$result" + " Km";
        kmRodadosTotalToClip = "$result";
      });
    }
  }

  void compararCombustivel() {
    if (formKeyCombustivel.currentState.validate()) {
      double alcool = double.parse(valorAlcool.text);
      double gasolina = double.parse(valorGasolina.text);
      double result = alcool / gasolina;
      result.toStringAsFixed(2);

      if (result < 0.7) {
        setState(() {
          abastecer =
              "${result.toStringAsFixed(2)}: com esse valor, abasteça no alcool!";
        });
      } else {
        setState(() {
          abastecer =
              "${result.toStringAsFixed(2)}: com esse valor, abasteça na gasolina!";
        });
      }
    }
  }

  String infoConsumo =
      "No primeiro campo, insira o valor da km rodada desde seu ultimo abastecimento e no segundo campo, insira o valor de litros que você colocou no último abastecimento! O resultado será a quantidade de km que seu carro faz com um litro de combustível.";
  String infoKm =
      "No primeiro campo, insira a quilometragem atual de seu veículo e no segundo, insira a quilometragem antes do abastecimento. Pressionando em cima do resultado, você pode copiá-lo e utilizar na tela de calculo de consumo.";
  String infoComparar =
      "No primeiro campo, insira o valor atual do álcool e no segundo campo, o valor atual da gasolina. Se o resultado for menor que 0.7, compensa abastecer com álcool, se for maior, abasteça com gasolina.";

  showAlertDialog1(BuildContext context, int number) {
    // configura o button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    // configura o  AlertDialog
    if (number == 1) {
      AlertDialog alerta = AlertDialog(
        elevation: 5.0,
        content: Text(infoConsumo),
        actions: [
          okButton,
        ],
      );
      // exibe o dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alerta;
        },
      );
    } else if (number == 2) {
      AlertDialog alerta = AlertDialog(
        content: Text(infoKm),
        actions: [
          okButton,
        ],
      );
      // exibe o dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alerta;
        },
      );
    } else {
      AlertDialog alerta = AlertDialog(
        content: Text(infoComparar),
        actions: [
          okButton,
        ],
      );
      // exibe o dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alerta;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
          length: 3,
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text("Meu Carro"),
//            centerTitle: true,
              bottom: TabBar(tabs: [
                Tab(
                  text: "Consumo",
                ),
                Tab(
                  text: "Km rodados",
                ),
                Tab(
                  text: "Álcool vs \n Gasolina",
                ),
              ]),
            ),
            body: TabBarView(children: [
              // primeiro body do tabbar
              Container(
                padding: EdgeInsets.all(10.0),
                child: Form(
                    key: formKeyConsumo,
                    child: ListView(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                showAlertDialog1(context, 1);
                              },
                              child: Icon(
                                Icons.info,
                                color: Colors.lightBlue,
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              MdiIcons.carConvertible,
                              size: 100.0,
                              color: Colors.blueAccent,
                            ),
                            TextFormField(
                              controller: kmRodados,
                              validator: (value) {
                                if (value.isEmpty)
                                  return "O campo não pode ser nulo!";
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Digite a km rodada",
                                  icon: Icon(Icons.drive_eta)),
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              controller: litros,
                              validator: (value) {
                                if (value.isEmpty)
                                  return "O campo não pode ser nulo!";
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Digite a quantidade de litros",
                                  icon: Icon(MdiIcons.fuel)),
                              keyboardType: TextInputType.number,
                            ),
                            Text(consumo, style: TextStyle(fontSize: 20.0)),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                RaisedButton(
                                  onPressed: () {
                                    rendimento();
                                  },
                                  color: Colors.blueAccent,
                                  child: Text(
                                    "Calcular",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                MaterialButton(
                                    child: Text("Limpar"),
                                    onPressed: () {
                                      setState(() {
                                        consumo = "";
                                        kmRodados.text = "";
                                        litros.text = "";
                                      });
                                    })
                              ],
                            )
                          ],
                        ),
                      ],
                    )),
              ),

              //segundo body do tabbar
              Container(
                padding: EdgeInsets.all(10.0),
                child: Form(
                  key: formKeyKm,
                  child: ListView(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              showAlertDialog1(context, 2);
                            },
                            child: Icon(
                              Icons.info,
                              color: Colors.lightBlue,
                            ),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            MdiIcons.carTractionControl,
                            size: 80.0,
                            color: Colors.blueAccent,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            controller: kmAtual,
                            validator: (value) {
                              if (value.isEmpty)
                                return "O campo não pode ser nulo!";
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Digite a km atual",
                                icon: Icon(MdiIcons.speedometer)),
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            controller: kmAnterior,
                            validator: (value) {
                              if (value.isEmpty)
                                return "O campo não pode ser nulo!";
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Digite a km anterior",
                                icon: Icon(MdiIcons.speedometer)),
                            keyboardType: TextInputType.number,
                          ),
                          InkWell(
                              child: Text(kmRodadosTotal,
                                  style: TextStyle(fontSize: 20.0)),
                              onLongPress: () {
                                Clipboard.setData(new ClipboardData(
                                    text: kmRodadosTotalToClip));
                                _scaffoldKey.currentState.showSnackBar(SnackBar(
                                  content: Text('Copiado com sucesso'),
                                  duration: Duration(seconds: 3),
                                ));
                              }),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              RaisedButton(
                                color: Colors.blueAccent,
                                child: Text(
                                  "Calcular",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  subtrairKm();
                                },
                              ),
                              MaterialButton(
                                  child: Text("Limpar"),
                                  onPressed: () {
                                    setState(() {
                                      kmRodadosTotal = "";
                                      kmAtual.text = "";
                                      kmAnterior.text = "";
                                    });
                                  })
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // terceiro body do tabbar
              Container(
                padding: EdgeInsets.all(10.0),
                child: Form(
                  key: formKeyCombustivel,
                  child: ListView(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              showAlertDialog1(context, 3);
                            },
                            child: Icon(
                              Icons.info,
                              color: Colors.lightBlue,
                            ),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            MdiIcons.squareIncCash,
                            size: 80.0,
                            color: Colors.blueAccent,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            controller: valorAlcool,
                            validator: (value) {
                              if (value.isEmpty)
                                return "O campo não pode ser nulo!";
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Digite o valor do Alccol",
                                icon: Icon(MdiIcons.cashMultiple)),
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                            controller: valorGasolina,
                            validator: (value) {
                              if (value.isEmpty)
                                return "O campo não pode ser nulo!";
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Digite o valor da Gasolina",
                                icon: Icon(MdiIcons.cashMultiple)),
                            keyboardType: TextInputType.number,
                          ),
                          Padding(
                              padding:
                                  EdgeInsets.fromLTRB(30.0, 10.0, 15.0, 5.0),
                              child: Text(
                                abastecer,
                                style: TextStyle(fontSize: 20.0),
                                textAlign: TextAlign.center,
                              )),
//                              SizedBox(
//                                height: 10.0,
//                              ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              RaisedButton(
                                color: Colors.blueAccent,
                                child: Text(
                                  "Calcular",
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  compararCombustivel();
                                },
                              ),
                              MaterialButton(
                                  child: Text("Limpar"),
                                  onPressed: () {
                                    setState(() {
                                      abastecer = "";
                                      valorAlcool.text = "";
                                      valorGasolina.text = "";
                                    });
                                  })
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ]),
          )),
    );
  }
}
