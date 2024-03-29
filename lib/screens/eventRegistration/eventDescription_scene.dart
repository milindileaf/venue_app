import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:venue_app/models/Event.dart';
import 'package:venue_app/redux/actions/eventRegistration_actions.dart';
import 'package:venue_app/redux/states/app_state.dart';

class EventDescriptionScene extends StatelessWidget {
  final Store<AppState> store;

  EventDescriptionScene(this.store);
  final TextEditingController controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<AppState, _ViewModel>(
          converter: (store) => _ViewModel.create(store),
          builder: (BuildContext context, _ViewModel viewModel) => ListView(
                children: <Widget>[
                  buildTitle(),
                  buildDescription(),
                  buildEventNameField(context, viewModel),
                  buildNextButton(context, viewModel),
                ],
              )),
    );
  }

  Widget buildTitle() {
    return Padding(
      padding: EdgeInsets.only(top: 50.0, left: 20, right: 20),
      child: Text(
        "Tell us more about the event",
        style: const TextStyle(
            color: const Color(0xff000000),
            fontWeight: FontWeight.w700,
            fontFamily: "GoogleSans",
            fontStyle: FontStyle.normal,
            fontSize: 33.0),
      ),
    );
  }

  Widget buildDescription() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Text(
        "Add a detailed description about your event. What are the importance features of the event? Is it organised for a special purpose. Why should users join your event?",
        style: const TextStyle(
            color: const Color(0xffc7c7c7),
            fontWeight: FontWeight.w400,
            fontFamily: "GoogleSans",
            fontStyle: FontStyle.normal,
            fontSize: 16.7),
      ),
    );
  }

  Widget buildEventNameField(BuildContext context, _ViewModel viewModel) {
    controller
      ..text = viewModel.eventDescription
      ..selection = TextSelection.collapsed(offset: controller.text.length);

    return Padding(
      padding: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
      child: TextField(
        cursorColor: Colors.green,
        controller: controller,
        keyboardType: TextInputType.text,
        onChanged: ((value) {
          viewModel.setEventDescription(value);
        }),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 5.0),
          icon: Image.asset("assets/venueDescription.png"),
          hintText: "Enter event Description",
          errorText: viewModel.fieldValidations.isValidName == false ? "Please enter atleast 10 chars" : null,
          fillColor: Colors.green,
        ),
      ),
    );
  }

  Widget buildNextButton(BuildContext context, _ViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.only(top: 30.0, right: 20.0, bottom: 20.0),
      child: Container(
        alignment: Alignment.topRight,
        child: FloatingActionButton(
          onPressed: () {
            viewModel.canProceedToNextScene ? viewModel.proceedToNextScene() : null;
          },
          backgroundColor: viewModel.canProceedToNextScene ? Colors.green : Colors.grey,
          child: Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}

class _ViewModel {
  String eventDescription;
  final Function(String) setEventDescription;

  EventFieldValidations fieldValidations;
  bool canProceedToNextScene;
  final Function proceedToNextScene;

  _ViewModel({
    this.eventDescription,
    this.setEventDescription,
    this.fieldValidations,
    this.canProceedToNextScene,
    this.proceedToNextScene,
  });

  factory _ViewModel.create(Store<AppState> store) {
    _setEventDescription(String desc) {
      Event event = store.state.eventRegistrationState.event;
      event.description = desc;

      store.dispatch(UpdateEventAction(event));
      store.dispatch(ValidateEventDescriptionAction());
    }

    _proceedToNextScene() {
      store.dispatch(ProceedToEventSportSceneAction());
    }

    return _ViewModel(
      eventDescription: store.state.eventRegistrationState.event.description,
      setEventDescription: _setEventDescription,
      fieldValidations: store.state.eventRegistrationState.fieldValidations,
      canProceedToNextScene: store.state.eventRegistrationState.sceneValidations.isValidEventDescriptionScene,
      proceedToNextScene: _proceedToNextScene,
    );
  }
}
