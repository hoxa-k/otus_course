// Mocks generated by Mockito 5.4.0 from annotations
// in otus_course/test/move_command_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:mockito/mockito.dart' as _i1;
import 'package:otus_course/game/u_object.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [UObject].
///
/// See the documentation for Mockito's code generation for more information.
class MockUObject extends _i1.Mock implements _i2.UObject {
  @override
  Map<String, dynamic> get properties => (super.noSuchMethod(
        Invocation.getter(#properties),
        returnValue: <String, dynamic>{},
        returnValueForMissingStub: <String, dynamic>{},
      ) as Map<String, dynamic>);
  @override
  dynamic getProperty(String? key) => super.noSuchMethod(
        Invocation.method(
          #getProperty,
          [key],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setProperty(
    String? key,
    dynamic value,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #setProperty,
          [
            key,
            value,
          ],
        ),
        returnValueForMissingStub: null,
      );
}