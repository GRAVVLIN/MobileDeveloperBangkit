import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../data/datasources/auth_remote_datasource.dart';
import '../../../../data/models/responses/auth_response_model.dart';
import '../../../../data/datasources/auth_local_datasource.dart';
part 'register_bloc.freezed.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRemoteDatasource _authRemoteDatasource;
  RegisterBloc(this._authRemoteDatasource) : super(_Initial()) {
    on<RegisterEvent>((event, emit) async {
      await event.when(
        started: () {},
        register: (username, email, password) async {
          try {
            emit(_Loading());
            final result = await _authRemoteDatasource.register(
              username,
              email,
              password,
            );
            result.fold(
              (error) => emit(_Error(error)),
              (data) => emit(_Loaded(data)),
            );
          } catch (e) {
            emit(_Error(e.toString()));
          }
        },
      );
    });
  }
}
