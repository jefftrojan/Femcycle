import 'package:frontendsrc/src/model/login_register.model.dart' as modelPrefix;
import 'package:frontendsrc/src/view/login.view.dart';

class LoginController {
  final modelPrefix.LoginRegisterModel model;
  final LoginView loginView;
  final LoginView registerView;

  LoginController()
      : model = modelPrefix.LoginRegisterModel(),
        loginView = LoginView(model: modelPrefix.LoginRegisterModel()),
        registerView = LoginView(model: modelPrefix.LoginRegisterModel());

  void loginSubmit() {
    if (model.validate()) {
      if (loginView.onSubmitted != null) {
        loginView.onSubmitted!(model.email, model.password);
      }
    }
  }

  void registerSubmit() {
    if (model.validate()) {
      if (registerView.onSubmitted != null) {
        registerView.onSubmitted!(model.email, model.password);
      }
    }
  }
}

