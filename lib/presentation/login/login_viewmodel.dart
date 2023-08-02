import 'dart:async';

import 'package:advanced_flutter/domain/usecase/login_usecase.dart';
import 'package:advanced_flutter/presentation/base/baseviewmodel.dart';
import 'package:advanced_flutter/presentation/common/freezed_data_class.dart';

class LoginViewModel extends BaseViewModel
    implements LoginViewModelInputs, LoginViewModelOutputs {
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();

  var loginObject = LoginObject("", "");

  LoginUseCase _loginUseCase;
  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
  }

  @override 
  void start() {
    // TODO: implement start
  }

  @override
  setPassword(String password) {
    // TODO: implement setPassword
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    _validate();
  }

  @override
  setUsername(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(username: userName);
    _validate();
  }

  @override
  // TODO: implement inputPassword
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  // TODO: implement inputUserName
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputIsAllInputValid => _isAllInputsValidStreamController.sink;


  @override
  login() async {
    // TODO: implement login
    (await _loginUseCase.execute(
            LoginUseCaseInput(loginObject.username, loginObject.password)))
        .fold((failure) => {print(failure.message)},
            (data) => {print(data.customer?.name)});
  }

  @override
  // TODO: implement outputIsPasswordValid
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  // TODO: implement outputIsUserNameValid
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((username) => _isUsernameValid(username));

  @override
  Stream<bool> get outputIsAllInputsValid => _isAllInputsValidStreamController.stream.map((event) => _isAllInputsValid());

  // private functions

  _validate() {
    inputIsAllInputValid.add(null);
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUsernameValid(String username) {
    return username.isNotEmpty;
  }

  bool _isAllInputsValid() {
    return _isPasswordValid(loginObject.password) && _isUsernameValid(loginObject.username);
  }

}

abstract class LoginViewModelInputs {
  setUsername(String userName);
  setPassword(String password);
  login();

  Sink get inputUserName;
  Sink get inputPassword;
  Sink get inputIsAllInputValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;
  Stream<bool> get outputIsPasswordValid;
  Stream<bool> get outputIsAllInputsValid;
}
