// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:senai_f1/models/projeto_model.dart';

class garrafasSessao {
  // String banco;
  // String campeonato;
  // garrafasSessao({
  //   required this.banco,
  //   required this.campeonato,
  // });
  Future<int> numeroGarrafasTerminadas(String banco, String campeonato) async {
    int garrafasRecebidas = 0;
    List<ProjetoModel> temp = [];
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    print('*******************************  COMEÇOU');
    print('procurando no banco $banco e campeonato $campeonato');

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection("$banco$campeonato").get();

    for (var doc in snapshot.docs) {
      var projeto = ProjetoModel.fromMap(doc.data());
      temp.add(projeto);
      if ((ProjetoModel.fromMap(doc.data()).status == Status.TERMINADA)) {
        garrafasRecebidas = garrafasRecebidas + 1;
      }
    }
    print('Garras Terminadas: $garrafasRecebidas');
    return garrafasRecebidas;
  }
}
