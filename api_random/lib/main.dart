import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controleIp = TextEditingController();

  TextEditingController _controleIdade = TextEditingController();

  TextEditingController _controlePeso = TextEditingController();

  TextEditingController _controleGanho = TextEditingController();

  TextEditingController _controlePerca = TextEditingController();

  TextEditingController _controleHrs = TextEditingController();

  TextEditingController _controleResposta = TextEditingController();

  String _url = "";

  bool _enable = true;

  TextField box1() {
    return TextField(
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0),
              gapPadding: 2),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 2.0),
              gapPadding: 2)),
      controller: _controleIp,
      enabled: _enable,
    );
  }

  List<String> _classeTrab;

  String _valueClasseTrab;

  List<String> _escolaridade;

  String _valueEscolaridade;

  List<String> _estadoCivil;

  String _valueEstadoCivil;

  List<String> _ocupacao;

  String _valueOcupacao;

  List<String> _relacionamentoConj;

  String _valueRelacionamentoConj;

  List<String> _raca;

  String _valueRaca;

  List<String> _sexo;

  String _valueSexo;

  List<String> _pais;

  String _valuePais;

  _conectar() async {
    setState(() {
      _url = _controleIp.text;
      _enable = false;
    });

    http.Response response = await http.get(_url + "/test", headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'X-Content-Type-Options': 'nosniff'
    });

    setState(() {
      _controleResposta.text =
          response.body.toString() + "\n" + response.statusCode.toString();
    });
  }

  _processar() async {
    /*String urlCompleta = _url +"8888/prever?idade=" + _controleIdade.text+ "&classeTrabalhista=%20" + _valueClasseTrab + "&calculoCensus=" + 
    _controlePeso.text + "&escolaridade=%20" + _valueEscolaridade + "&estadoCivil=%20" + _valueEstadoCivil + "&ocupacao=%20" + _valueOcupacao +
    "&relacionamentoConjugal=%20" + _valueRelacionamentoConj + "&raca=%20" + _valueRaca + "&sexo=%20" + _valueSexo + "&ganhoCapital=" + _controleGanho.text +
    "&percaCapital=" + _controlePerca.text +  "&hrsTrab=" + _controleHrs.text + "&paisOrigem=%20" + _valuePais;
    */

    String url = _url;

    http.Response response = await http.post(url,
        headers: {"content-type": "application/json"},
        body: json.encode({
          "idade": _controleIdade.text,
          "classeTrabalhista": " " + _valueClasseTrab,
          "calculoCensus": _controlePeso.text,
          "escolaridade": " " + _valueEscolaridade,
          "estadoCivil": " " + _valueEstadoCivil,
          "ocupacao": " " + _valueOcupacao,
          "relacionamentoConjugal": " " + _valueRelacionamentoConj,
          "raca": " " + _valueRaca,
          "sexo": " " + _valueSexo,
          "ganhoCapital": _controleGanho.text,
          "percaCapital": _controlePerca.text,
          "hrsTrab": _controleHrs.text,
          "paisOrigem": " " + _valuePais
        }));

    setState(() {
      _controleResposta.text = "idade : " +
          _controleIdade.text +
          "\nclasseTrabalhista : " +
          _valueClasseTrab +
          "\ncalculoCensus : " +
          _controlePeso.text +
          "\nescolaridade : " +
          _valueEscolaridade +
          "\nestadoCivil : " +
          _valueEstadoCivil +
          "\nocupacao : " +
          _valueOcupacao +
          "\nrelacionamentoConjugal : " +
          _valueRelacionamentoConj +
          "\nraca : " +
          _valueRaca +
          "\nsexo : " +
          _valueSexo +
          "\nganhoCapital : " +
          _controleGanho.text +
          "\npercaCapital : " +
          _controlePerca.text +
          "\nhrsTrab : " +
          _controleHrs.text +
          "\npaisOrigem : " +
          _valuePais +
          "\n\n\n" +
          response.body +
          response.statusCode.toString();
    });
  }

  @override
  void initState() {
    _classeTrab = [
      "Federal-gov",
      "Local-gov",
      "Private",
      "Self-emp-inc",
      "Self-emp-not-inc",
      "State-gov",
      "Without-pay",
      "Never-worked",
      "unknown"
    ];

    _valueClasseTrab = _classeTrab[0];

    _escolaridade = [
      "10th",
      "11th",
      "12th",
      "1st-4th",
      "5th-6th",
      "7th-8th",
      "9th",
      "Assoc-acdm",
      "Assoc-voc",
      "Bachelors",
      "Doctorate",
      "HS-grad",
      "Masters",
      "Preschool",
      "Prof-school",
      "Some-college"
    ];

    _valueEscolaridade = _escolaridade[0];

    _estadoCivil = [
      "Divorced",
      "Married-AF-spouse",
      "Married-civ-spouse",
      "Married-spouse-absent",
      "Never-married",
      "Separated",
      "Widowed"
    ];

    _valueEstadoCivil = _estadoCivil[0];

    _ocupacao = [
      "Adm-clerical",
      "Armed-Forces",
      "Craft-repair",
      "Exec-managerial",
      "Farming-fishing",
      "Handlers-cleaners",
      "Machine-op-inspct",
      "Other-service",
      "Priv-house-serv",
      "Prof-specialty",
      "Protective-serv",
      "Sales",
      "Tech-support",
      "Transport-moving",
      "unknown"
    ];

    _valueOcupacao = _ocupacao[0];

    _relacionamentoConj = [
      "Husband",
      "Not-in-family",
      "Other-relative",
      "Own-child",
      "Unmarried",
      "Wife"
    ];

    _valueRelacionamentoConj = _relacionamentoConj[0];

    _raca = [
      "Amer-Indian-Eskimo",
      "Asian-Pac-Islander",
      "Black",
      "Other",
      "White"
    ];

    _valueRaca = _raca[0];

    _sexo = ["Female", "Male"];

    _valueSexo = _sexo[0];

    _pais = [
      "Cambodia",
      "Canada",
      "China",
      "Columbia",
      "Cuba",
      "Dominican-Republic",
      "Ecuador",
      "El-Salvador",
      "England",
      "France",
      "Germany",
      "Greece",
      "Guatemala",
      "Haiti",
      "Holand-Netherlands",
      "Honduras",
      "Hong",
      "Hungary",
      "India",
      "Iran",
      "Ireland",
      "Italy",
      "Jamaica",
      "Japan",
      "Laos",
      "Mexico",
      "Nicaragua",
      "Outlying-US(Guam-USVI-etc)",
      "Peru",
      "Philippines",
      "Poland",
      "Portugal",
      "Puerto-Rico",
      "Scotland",
      "South",
      "Taiwan",
      "Thailand",
      "Trinadad&Tobago",
      "United-States",
      "Vietnam",
      "Yugoslavia",
      "0"
    ];

    _valuePais = _pais[0];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:
                Text("Teste de API R", style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.red[600]),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "Insira o IP",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontFamily: 'Oswald',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: (Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * 0.065,
                        child: box1()))),
                RaisedButton(child: Text("Definir IP"), onPressed: _conectar),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "Insira as informações",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 35,
                          fontFamily: 'Oswald',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Idade",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontFamily: 'Oswald',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0),
                                  gapPadding: 2),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0),
                                  gapPadding: 2)),
                          controller: _controleIdade,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                Text(
                  "Classe Trabalhista",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontFamily: 'Oswald',
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.60,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: DropdownButton<String>(
                      items: _classeTrab.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      value: _valueClasseTrab,
                      onChanged: (String newValue) {
                        setState(() {
                          _valueClasseTrab = newValue;
                        });
                      },
                    )),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                Text(
                  "Peso Census",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontFamily: 'Oswald',
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0),
                            gapPadding: 2),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0),
                            gapPadding: 2)),
                    controller: _controlePeso,
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                Text(
                  "Escolaridade",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontFamily: 'Oswald',
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.60,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: DropdownButton<String>(
                      items: _escolaridade.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      value: _valueEscolaridade,
                      onChanged: (String newValue) {
                        setState(() {
                          _valueEscolaridade = newValue;
                        });
                      },
                    )),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                Text(
                  "Estado Civil",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontFamily: 'Oswald',
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.60,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: DropdownButton<String>(
                      items: _estadoCivil.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      value: _valueEstadoCivil,
                      onChanged: (String newValue) {
                        setState(() {
                          _valueEstadoCivil = newValue;
                        });
                      },
                    )),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                Text(
                  "Ocupação",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontFamily: 'Oswald',
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.60,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: DropdownButton<String>(
                      items: _ocupacao.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      value: _valueOcupacao,
                      onChanged: (String newValue) {
                        setState(() {
                          _valueOcupacao = newValue;
                        });
                      },
                    )),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                Text(
                  "Relacionamento conjugal",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontFamily: 'Oswald',
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.60,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: DropdownButton<String>(
                      items:
                          _relacionamentoConj.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      value: _valueRelacionamentoConj,
                      onChanged: (String newValue) {
                        setState(() {
                          _valueRelacionamentoConj = newValue;
                        });
                      },
                    )),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                Text(
                  "Raça",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontFamily: 'Oswald',
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.60,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: DropdownButton<String>(
                      items: _raca.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      value: _valueRaca,
                      onChanged: (String newValue) {
                        setState(() {
                          _valueRaca = newValue;
                        });
                      },
                    )),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                Text(
                  "Sexo",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontFamily: 'Oswald',
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.60,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: DropdownButton<String>(
                      items: _sexo.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      value: _valueSexo,
                      onChanged: (String newValue) {
                        setState(() {
                          _valueSexo = newValue;
                        });
                      },
                    )),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                Text(
                  "Ganho Capital",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontFamily: 'Oswald',
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0),
                            gapPadding: 2),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0),
                            gapPadding: 2)),
                    controller: _controleGanho,
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                Text(
                  "Perca Capital",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontFamily: 'Oswald',
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0),
                            gapPadding: 2),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0),
                            gapPadding: 2)),
                    controller: _controlePerca,
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                Text(
                  "Horas trabalhadas",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontFamily: 'Oswald',
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0),
                            gapPadding: 2),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0),
                            gapPadding: 2)),
                    controller: _controleHrs,
                  ),
                ),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                Text(
                  "País de origem",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontFamily: 'Oswald',
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.60,
                    height: MediaQuery.of(context).size.height * 0.05,
                    child: DropdownButton<String>(
                      items: _pais.map((String dropDownStringItem) {
                        return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),
                        );
                      }).toList(),
                      value: _valuePais,
                      onChanged: (String newValue) {
                        setState(() {
                          _valuePais = newValue;
                        });
                      },
                    )),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                RaisedButton(child: Text("Processar"), onPressed: _processar),
                Padding(padding: EdgeInsets.only(bottom: 40)),
                Container(
                    width: MediaQuery.of(context).size.width * 0.80,
                    height: MediaQuery.of(context).size.height * 0.20,
                    child: TextField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2.0),
                              gapPadding: 2),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 2.0),
                              gapPadding: 2)),
                      controller: _controleResposta,
                      readOnly: true,
                      expands: true,
                      maxLines: null,
                    ))
              ],
            ),
          ),
        )));
  }
}
