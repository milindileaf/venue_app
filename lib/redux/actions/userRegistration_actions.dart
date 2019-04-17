import 'package:venue_app/models/User.dart';

//<editor-fold desc="Common User Details Updation Actions">
class UpdateUserAction {
  final User user;
  UpdateUserAction(this.user);
}

class UpdateUserFieldValidationAction {
  final UserFieldValidations fieldValidations;
  UpdateUserFieldValidationAction(this.fieldValidations);
}

class UpdateUserSceneValidationAction {
  final UserSceneValidations sceneValidations;
  UpdateUserSceneValidationAction(this.sceneValidations);
}
//</editor-fold>

//<editor-fold desc="Location Scene Actions">
class ValidateUserLocationAction {
  ValidateUserLocationAction();
}

class ProceedToUserMobileNoSceneAction {
  ProceedToUserMobileNoSceneAction();
}
//</editor-fold>

//<editor-fold desc="Mobile Scene Actions">
class ValidateMobileNoAction {
  ValidateMobileNoAction();
}

class ProceedToOTPSceneAction {
  ProceedToOTPSceneAction();
}
//</editor-fold>

//<editor-fold desc="OTP Scene Actions">
class ValidateOTPAction {
  ValidateOTPAction();
}

class ProceedToLandingSceneAction {
  ProceedToLandingSceneAction();
}
//</editor-fold>

//<editor-fold desc="Landing Scene Actions">
class ProceedToTutorialSceneAction {
  ProceedToTutorialSceneAction();
}
//</editor-fold>

//<editor-fold desc="Tutorial Scene Actions">
class ProceedToOwnerOrPlayerSceneAction {
  ProceedToOwnerOrPlayerSceneAction();
}
//</editor-fold>