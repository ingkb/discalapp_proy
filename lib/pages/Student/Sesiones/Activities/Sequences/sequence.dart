import 'package:discalapp_proy/shared/ActivityFrame.dart';
import 'package:flutter/material.dart';

import '../../../baseActivity.dart';

class SequencesActivity extends StatefulWidget {
  SequencesActivity({Key? key, this.pasarActividad, this.indice})
      : super(key: key);
  final ValueChanged<int>? pasarActividad;
  final int? indice;
  @override
  SequencesActivityState createState() => SequencesActivityState();
}

class SequencesActivityState extends BaseActivity<SequencesActivity> {
  @override
  Widget build(BuildContext context) {
    return marcoActividad("Cualquier cosa", []);
  }

  @override
  validarResultado() {
    // TODO: implement validarResultado
    throw UnimplementedError();
  }
}
