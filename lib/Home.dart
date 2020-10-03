import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  
  TextEditingController _controllerResultado = TextEditingController();

  TextEditingController _controllerCep = TextEditingController();

  _recuperarCep() async{

    String url = "https://viacep.com.br/ws/${_controllerCep.text}/json/";

    Future<Map<String, dynamic>> _retorno() async {

      http.Response resposta = await http.get(url);

      return json.decode(resposta.body);
    }

    _retorno().then( (retorno) {
      if(retorno["cep"]!=null){
          setState(() {
             _controllerResultado.text = "${retorno["logradouro"]}, \n${retorno["complemento"]}, \n${retorno["bairro"]}, \n${retorno["localidade"]} - ${retorno["uf"]}\n\nCEP: ${retorno["cep"]}";
          });
        }
        else{
          setState(() {
            _controllerResultado.text = "CEP não encontrado.";
          });
        }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Consulta CEP"),
            backgroundColor: Colors.green
        ),
        body: SingleChildScrollView(
          child: Container(
              color: Colors.grey[200],
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text("Consulte um CEP",
                                    style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 40,
                                          fontFamily: 'Oswald',
                                        ),
                                    textAlign: TextAlign.center,
                                    ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10,bottom: 20),
                        child: Text("Digite um CEP (sem - )",
                                    style: TextStyle(
                                      fontSize: 15
                                    ),
                                )
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: (
                          TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 2.0),
                                gapPadding: 2
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 2.0),
                                gapPadding: 2
                              )
                            ),
                            maxLength: 8,
                            controller: _controllerCep,
                          )
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(top: 5, start: 5, end: 5),
                        child: Container(
                          height: 300,
                          child: TextField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                        disabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey[400], width: 1.5)
                                        ),
                                    ),
                                    style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                    ),
                                    expands: true, 
                                    maxLines: null,
                                    textAlign: TextAlign.start,
                                    textAlignVertical: TextAlignVertical.top,
                                    controller: _controllerResultado,
                          ),
                        ),
                      ),
                      ],
                    ),
              ),
          ),
        ),
        floatingActionButton: Transform.scale(
          scale: 1.65,
          child: FloatingActionButton(
            child: Icon(Icons.search),
            backgroundColor: Colors.greenAccent[400],
            onPressed: _recuperarCep,
          )
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.green[400],
          child: Container(height: 55.0),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}