import 'package:flutter/material.dart';

class ObservationForm extends StatefulWidget {

  String observations;
  Function(String observations) onSave;
  ObservationForm({Key key, this.observations, this.onSave}) : super(key: key);

  @override
  _ObservationFormState createState() => _ObservationFormState();
}

class _ObservationFormState extends State<ObservationForm> {
  final GlobalKey<FormState> observationsFormKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Form(
          key: observationsFormKey,
          child: Expanded(
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: widget.observations,
                  maxLines: 5,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    icon: const Icon(
                      Icons.text_fields,
                      color: Color(0xffED145B),
                    ),
                    hintText: 'Digite suas observações...',
                    labelText: 'Observações',
                    hintStyle: TextStyle(fontSize: 16.0),
                    labelStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                  validator: (value) {
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  onSaved: (value) {
                    widget.observations = value;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ButtonTheme(
                    buttonColor: Theme.of(context).primaryColor,
                    child: RaisedButton(
                      child: Text(
                        "Salvar Observações",
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        if (observationsFormKey.currentState.validate()) {
                          observationsFormKey.currentState.save();
                          widget.onSave(widget.observations);
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}