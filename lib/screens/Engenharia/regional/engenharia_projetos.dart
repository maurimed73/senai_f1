import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:senai_f1/screens/Engenharia/regional/engenharia_grid_garrafas5.dart';
import 'package:senai_f1/screens/Reciclagem/reciclagem_engenharia.dart';
import 'package:senai_f1/screens/Tijolo/tijolo_engenharia.dart';
import 'package:senai_f1/screens/sessao_das_areas/HomeScreen.dart';
import 'package:senai_f1/services/login_service.dart';
import 'package:senai_f1/utils/colors.dart';
import 'package:senai_f1/widgets/customDrawer.dart';
//import 'package:awesome_dialog/awesome_dialog.dart';

class EngenhariaProjetos extends StatelessWidget {
  // ServiceGestao service = ServiceGestao();

  EngenhariaProjetos({super.key, required String campeonato});
  AuthService serviceAuth = AuthService();
  ColorsDart colorDart = ColorsDart();
// Função que exibe o AlertDialog

  // Função para exibir o Dialog
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // Permite fechar ao tocar fora
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Bordas arredondadas
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            width: 300, // Largura personalizada
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 350,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        color: Color.fromRGBO(146, 0, 0, 1),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text('TAREFA ATRASADA',
                          style:
                              TextStyle(fontFamily: 'Poppins', fontSize: 11)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 350,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        color: Color.fromRGBO(248, 200, 61, 1),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text('TAREFA TERMINANDO',
                          style:
                              TextStyle(fontFamily: 'Poppins', fontSize: 11)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 350,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        color: const Color.fromRGBO(45, 46, 45, 1),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text('TAREFA FINALIZADA',
                          style:
                              TextStyle(fontFamily: 'Poppins', fontSize: 11)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 350,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        color: const Color.fromRGBO(14, 82, 23, 1),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text('TAREFA EM ANDAMENTO',
                          style:
                              TextStyle(fontFamily: 'Poppins', fontSize: 11)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        colorDart.VermelhoPadrao, // Cor de fundo vermelha
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          4), // Bordas arredondadas com 4 de raio
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 8), // Padding opcional
                  ),
                  onPressed: () {
                    HapticFeedback.lightImpact(); // Vibração leve
                    Navigator.of(context).pop(); // Fecha o dialog
                  },
                  child: const Text(
                    'Fechar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Converte o JSON em uma lista de objetos
    //List<ProjetoModel> projetos = service.parseProjetos();

    int totalGarrafas = 700000;

    return Scaffold(
      backgroundColor: colorDart.FundoApp,
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(top: 32, bottom: 0, left: 8, right: 8),
        child: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // AppBar
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: ColorsDart().VermelhoPadrao,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.lightImpact(); // Vibração leve
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 35, // Largura da bola
                              height: 35, // Altura da bola
                              decoration: const BoxDecoration(
                                color: Colors.black, // Cor da bola (preto)
                                shape: BoxShape.circle, // Forma circular
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_back, // Ícone de casa
                                  color: Colors.white, // Cor do ícone
                                  size: 25, // Tamanho do ícone
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/logo1.png'), // Substitua pelo caminho do seu logo
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.lightImpact(); // Vibração leve
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Homescreen(),
                                  ));
                            },
                            child: Container(
                              width: 40, // Largura da bola
                              height: 35, // Altura da bola
                              decoration: const BoxDecoration(
                                color: Colors.black, // Cor da bola (preto)
                                shape: BoxShape.circle, // Forma circular
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    bottom: 0, left: 0, right: 0),
                                child: Icon(
                                  Icons.house,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),

                // // Tijolo ,  Total de Garrafas  ,  Legenda
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //GARRAFAS E TIJOLO
                          Container(
                            height: 90,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    color: colorDart.VermelhoPadrao, width: 1)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 0),
                                  child: Container(
                                    width: 65,
                                    height: 60,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/tijolo.png'), // Substitua pelo caminho do seu logo
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.07,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Engenharia',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Total de Garrafas \n arrecadadas: $totalGarrafas',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            fontFamily: 'Poppins'),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // LEGENDA
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  HapticFeedback.lightImpact(); // Vibração leve
                                  _showDialog(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(top: 5),
                                  width:
                                      45, // Largura do Container (tamanho quadrado)
                                  height:
                                      45, // Altura do Container (tamanho quadrado)
                                  decoration: BoxDecoration(
                                    color: colorDart
                                        .VermelhoPadrao, // Cor de fundo do Container
                                    borderRadius: BorderRadius.circular(
                                        8), // Bordas arredondadas (opcional)
                                  ),
                                  child: Image.asset("assets/iconlegenda.png"),
                                ),
                              ),
                              const Text(
                                'Legenda',
                                style: TextStyle(fontSize: 8),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    //Text('Conteúdo'),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: GarrafasEngenharia()),
                ),
                Spacer(),

                // Rodapé
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact(); // Vibração leve
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReciclagemEngenharia(),
                              ));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 35,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(4)),
                          child: const Text(
                            'Reciclagem',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TijoloEngenharia(),
                              ));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: 35,
                          decoration: BoxDecoration(
                              color: colorDart.VermelhoPadrao,
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(4)),
                          child: const Text(
                            'Tijolo',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
