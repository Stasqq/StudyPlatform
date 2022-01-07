import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:study_platform/data/forms/confirmed_password.dart';
import 'package:study_platform/data/forms/email_form.dart';
import 'package:study_platform/data/forms/password_form.dart';
import 'package:study_platform/data/repositories/authentication_repository.dart';

part 'sign_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const SignUpState());

  final AuthenticationRepository _authenticationRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);

    emit(
      state.copyWith(
        email: email,
        status: Formz.validate(
          [
            email,
            state.password,
            state.confirmedPassword,
          ],
        ),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);

    emit(
      state.copyWith(
        password: password,
        status: Formz.validate(
          [
            state.email,
            password,
            state.confirmedPassword,
          ],
        ),
      ),
    );
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );

    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        status: Formz.validate(
          [
            state.email,
            state.password,
            confirmedPassword,
          ],
        ),
      ),
    );
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isValidated) return;

    emit(
      state.copyWith(
        status: FormzStatus.submissionInProgress,
      ),
    );

    try {
      await _authenticationRepository.signUp(
        email: state.email.value,
        password: state.password.value,
      );
      await _authenticationRepository.logInWithEmailAndPassword(
          email: state.email.value, password: state.password.value);

      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
        ),
      );
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.message,
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
        ),
      );
    }
  }
}
