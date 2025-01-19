/*

import 'package:awesome_dialog/awesome_dialog.dart';




  child: Container(
                                    width: 30,
                                    height: 30,
                                    child: AnimatedButton(
                                      text: 'Body with Input',
                                      color: Colors.blueGrey,
                                      pressEvent: () {
                                        late AwesomeDialog dialog;
                                        dialog = AwesomeDialog(
                                          context: context,
                                          animType: AnimType.topSlide,
                                          dialogType: DialogType.info,
                                          keyboardAware: false,
                                          body: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  width: 350,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: 40,
                                                        height: 40,
                                                        color: Colors.red,
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                        'TAREFA ATRASADA',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  width: 350,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: 40,
                                                        height: 40,
                                                        color: Colors.yellow,
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                        'TAREFA TERMINANDO',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  width: 350,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width: 40,
                                                        height: 40,
                                                        color: Colors.black,
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                        'TAREFA EM ANDAMENTO',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                AnimatedButton(
                                                  isFixedHeight: false,
                                                  text: 'Close',
                                                  color:
                                                      colorDart.VermelhoPadrao,
                                                  pressEvent: () {
                                                    dialog.dismiss();
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        )..show();


* */
