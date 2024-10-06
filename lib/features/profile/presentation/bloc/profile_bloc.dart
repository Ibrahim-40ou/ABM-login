import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_events.dart';

part 'profile_states.dart';

class AuthBloc extends Bloc<ProfileEvent, ProfileState> {
  AuthBloc() : super(ProfileInitial());
}
