// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'Config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Config {
  /// Whether to add a new line after a closing brace.
  bool get addNewLineAfterClosingBrace;

  /// Whether to add a new line after an opening brace.
  bool get addNewLineAfterOpeningBrace;

  /// Whether to add a new line after a semicolon.
  bool get addNewLineAfterSemicolon;

  /// Whether to add a new line at the end of the text.
  bool get addNewLineAtEndOfText;

  /// Whether to add a new line before a closing brace.
  bool get addNewLineBeforeClosingBrace;

  /// Whether to add a new line before an opening brace.
  bool get addNewLineBeforeOpeningBrace;

  /// Whether to fix spaces.
  bool get fixSpaces;

  /// The number of spaces to use for indentation. -1 = do not change indentation.
  int get indentationSpacesPerLevel;

  /// The maximum number of empty lines to allow. -1 = do not change empty lines.
  int get maxEmptyLines;

  /// Whether to remove trailing commas.
  bool get removeTrailingCommas;

  /// Create a copy of Config
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ConfigCopyWith<Config> get copyWith =>
      _$ConfigCopyWithImpl<Config>(this as Config, _$identity);

  /// Serializes this Config to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Config &&
            (identical(other.addNewLineAfterClosingBrace,
                    addNewLineAfterClosingBrace) ||
                other.addNewLineAfterClosingBrace ==
                    addNewLineAfterClosingBrace) &&
            (identical(other.addNewLineAfterOpeningBrace,
                    addNewLineAfterOpeningBrace) ||
                other.addNewLineAfterOpeningBrace ==
                    addNewLineAfterOpeningBrace) &&
            (identical(other.addNewLineAfterSemicolon, addNewLineAfterSemicolon) ||
                other.addNewLineAfterSemicolon == addNewLineAfterSemicolon) &&
            (identical(other.addNewLineAtEndOfText, addNewLineAtEndOfText) ||
                other.addNewLineAtEndOfText == addNewLineAtEndOfText) &&
            (identical(other.addNewLineBeforeClosingBrace,
                    addNewLineBeforeClosingBrace) ||
                other.addNewLineBeforeClosingBrace ==
                    addNewLineBeforeClosingBrace) &&
            (identical(other.addNewLineBeforeOpeningBrace,
                    addNewLineBeforeOpeningBrace) ||
                other.addNewLineBeforeOpeningBrace ==
                    addNewLineBeforeOpeningBrace) &&
            (identical(other.fixSpaces, fixSpaces) ||
                other.fixSpaces == fixSpaces) &&
            (identical(other.indentationSpacesPerLevel, indentationSpacesPerLevel) ||
                other.indentationSpacesPerLevel == indentationSpacesPerLevel) &&
            (identical(other.maxEmptyLines, maxEmptyLines) ||
                other.maxEmptyLines == maxEmptyLines) &&
            (identical(other.removeTrailingCommas, removeTrailingCommas) ||
                other.removeTrailingCommas == removeTrailingCommas));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      addNewLineAfterClosingBrace,
      addNewLineAfterOpeningBrace,
      addNewLineAfterSemicolon,
      addNewLineAtEndOfText,
      addNewLineBeforeClosingBrace,
      addNewLineBeforeOpeningBrace,
      fixSpaces,
      indentationSpacesPerLevel,
      maxEmptyLines,
      removeTrailingCommas);

  @override
  String toString() {
    return 'Config(addNewLineAfterClosingBrace: $addNewLineAfterClosingBrace, addNewLineAfterOpeningBrace: $addNewLineAfterOpeningBrace, addNewLineAfterSemicolon: $addNewLineAfterSemicolon, addNewLineAtEndOfText: $addNewLineAtEndOfText, addNewLineBeforeClosingBrace: $addNewLineBeforeClosingBrace, addNewLineBeforeOpeningBrace: $addNewLineBeforeOpeningBrace, fixSpaces: $fixSpaces, indentationSpacesPerLevel: $indentationSpacesPerLevel, maxEmptyLines: $maxEmptyLines, removeTrailingCommas: $removeTrailingCommas)';
  }
}

/// @nodoc
abstract mixin class $ConfigCopyWith<$Res> {
  factory $ConfigCopyWith(Config value, $Res Function(Config) _then) =
      _$ConfigCopyWithImpl;
  @useResult
  $Res call(
      {bool addNewLineAfterClosingBrace,
      bool addNewLineAfterOpeningBrace,
      bool addNewLineAfterSemicolon,
      bool addNewLineAtEndOfText,
      bool addNewLineBeforeClosingBrace,
      bool addNewLineBeforeOpeningBrace,
      bool fixSpaces,
      int indentationSpacesPerLevel,
      int maxEmptyLines,
      bool removeTrailingCommas});
}

/// @nodoc
class _$ConfigCopyWithImpl<$Res> implements $ConfigCopyWith<$Res> {
  _$ConfigCopyWithImpl(this._self, this._then);

  final Config _self;
  final $Res Function(Config) _then;

  /// Create a copy of Config
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addNewLineAfterClosingBrace = null,
    Object? addNewLineAfterOpeningBrace = null,
    Object? addNewLineAfterSemicolon = null,
    Object? addNewLineAtEndOfText = null,
    Object? addNewLineBeforeClosingBrace = null,
    Object? addNewLineBeforeOpeningBrace = null,
    Object? fixSpaces = null,
    Object? indentationSpacesPerLevel = null,
    Object? maxEmptyLines = null,
    Object? removeTrailingCommas = null,
  }) {
    return _then(_self.copyWith(
      addNewLineAfterClosingBrace: null == addNewLineAfterClosingBrace
          ? _self.addNewLineAfterClosingBrace
          : addNewLineAfterClosingBrace // ignore: cast_nullable_to_non_nullable
              as bool,
      addNewLineAfterOpeningBrace: null == addNewLineAfterOpeningBrace
          ? _self.addNewLineAfterOpeningBrace
          : addNewLineAfterOpeningBrace // ignore: cast_nullable_to_non_nullable
              as bool,
      addNewLineAfterSemicolon: null == addNewLineAfterSemicolon
          ? _self.addNewLineAfterSemicolon
          : addNewLineAfterSemicolon // ignore: cast_nullable_to_non_nullable
              as bool,
      addNewLineAtEndOfText: null == addNewLineAtEndOfText
          ? _self.addNewLineAtEndOfText
          : addNewLineAtEndOfText // ignore: cast_nullable_to_non_nullable
              as bool,
      addNewLineBeforeClosingBrace: null == addNewLineBeforeClosingBrace
          ? _self.addNewLineBeforeClosingBrace
          : addNewLineBeforeClosingBrace // ignore: cast_nullable_to_non_nullable
              as bool,
      addNewLineBeforeOpeningBrace: null == addNewLineBeforeOpeningBrace
          ? _self.addNewLineBeforeOpeningBrace
          : addNewLineBeforeOpeningBrace // ignore: cast_nullable_to_non_nullable
              as bool,
      fixSpaces: null == fixSpaces
          ? _self.fixSpaces
          : fixSpaces // ignore: cast_nullable_to_non_nullable
              as bool,
      indentationSpacesPerLevel: null == indentationSpacesPerLevel
          ? _self.indentationSpacesPerLevel
          : indentationSpacesPerLevel // ignore: cast_nullable_to_non_nullable
              as int,
      maxEmptyLines: null == maxEmptyLines
          ? _self.maxEmptyLines
          : maxEmptyLines // ignore: cast_nullable_to_non_nullable
              as int,
      removeTrailingCommas: null == removeTrailingCommas
          ? _self.removeTrailingCommas
          : removeTrailingCommas // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.pascal)
class _Config extends Config {
  const _Config(
      {required this.addNewLineAfterClosingBrace,
      required this.addNewLineAfterOpeningBrace,
      required this.addNewLineAfterSemicolon,
      required this.addNewLineAtEndOfText,
      required this.addNewLineBeforeClosingBrace,
      required this.addNewLineBeforeOpeningBrace,
      required this.fixSpaces,
      required this.indentationSpacesPerLevel,
      required this.maxEmptyLines,
      required this.removeTrailingCommas})
      : super._();
  factory _Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);

  /// Whether to add a new line after a closing brace.
  @override
  final bool addNewLineAfterClosingBrace;

  /// Whether to add a new line after an opening brace.
  @override
  final bool addNewLineAfterOpeningBrace;

  /// Whether to add a new line after a semicolon.
  @override
  final bool addNewLineAfterSemicolon;

  /// Whether to add a new line at the end of the text.
  @override
  final bool addNewLineAtEndOfText;

  /// Whether to add a new line before a closing brace.
  @override
  final bool addNewLineBeforeClosingBrace;

  /// Whether to add a new line before an opening brace.
  @override
  final bool addNewLineBeforeOpeningBrace;

  /// Whether to fix spaces.
  @override
  final bool fixSpaces;

  /// The number of spaces to use for indentation. -1 = do not change indentation.
  @override
  final int indentationSpacesPerLevel;

  /// The maximum number of empty lines to allow. -1 = do not change empty lines.
  @override
  final int maxEmptyLines;

  /// Whether to remove trailing commas.
  @override
  final bool removeTrailingCommas;

  /// Create a copy of Config
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ConfigCopyWith<_Config> get copyWith =>
      __$ConfigCopyWithImpl<_Config>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ConfigToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Config &&
            (identical(other.addNewLineAfterClosingBrace,
                    addNewLineAfterClosingBrace) ||
                other.addNewLineAfterClosingBrace ==
                    addNewLineAfterClosingBrace) &&
            (identical(other.addNewLineAfterOpeningBrace,
                    addNewLineAfterOpeningBrace) ||
                other.addNewLineAfterOpeningBrace ==
                    addNewLineAfterOpeningBrace) &&
            (identical(other.addNewLineAfterSemicolon, addNewLineAfterSemicolon) ||
                other.addNewLineAfterSemicolon == addNewLineAfterSemicolon) &&
            (identical(other.addNewLineAtEndOfText, addNewLineAtEndOfText) ||
                other.addNewLineAtEndOfText == addNewLineAtEndOfText) &&
            (identical(other.addNewLineBeforeClosingBrace,
                    addNewLineBeforeClosingBrace) ||
                other.addNewLineBeforeClosingBrace ==
                    addNewLineBeforeClosingBrace) &&
            (identical(other.addNewLineBeforeOpeningBrace,
                    addNewLineBeforeOpeningBrace) ||
                other.addNewLineBeforeOpeningBrace ==
                    addNewLineBeforeOpeningBrace) &&
            (identical(other.fixSpaces, fixSpaces) ||
                other.fixSpaces == fixSpaces) &&
            (identical(other.indentationSpacesPerLevel, indentationSpacesPerLevel) ||
                other.indentationSpacesPerLevel == indentationSpacesPerLevel) &&
            (identical(other.maxEmptyLines, maxEmptyLines) ||
                other.maxEmptyLines == maxEmptyLines) &&
            (identical(other.removeTrailingCommas, removeTrailingCommas) ||
                other.removeTrailingCommas == removeTrailingCommas));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      addNewLineAfterClosingBrace,
      addNewLineAfterOpeningBrace,
      addNewLineAfterSemicolon,
      addNewLineAtEndOfText,
      addNewLineBeforeClosingBrace,
      addNewLineBeforeOpeningBrace,
      fixSpaces,
      indentationSpacesPerLevel,
      maxEmptyLines,
      removeTrailingCommas);

  @override
  String toString() {
    return 'Config(addNewLineAfterClosingBrace: $addNewLineAfterClosingBrace, addNewLineAfterOpeningBrace: $addNewLineAfterOpeningBrace, addNewLineAfterSemicolon: $addNewLineAfterSemicolon, addNewLineAtEndOfText: $addNewLineAtEndOfText, addNewLineBeforeClosingBrace: $addNewLineBeforeClosingBrace, addNewLineBeforeOpeningBrace: $addNewLineBeforeOpeningBrace, fixSpaces: $fixSpaces, indentationSpacesPerLevel: $indentationSpacesPerLevel, maxEmptyLines: $maxEmptyLines, removeTrailingCommas: $removeTrailingCommas)';
  }
}

/// @nodoc
abstract mixin class _$ConfigCopyWith<$Res> implements $ConfigCopyWith<$Res> {
  factory _$ConfigCopyWith(_Config value, $Res Function(_Config) _then) =
      __$ConfigCopyWithImpl;
  @override
  @useResult
  $Res call(
      {bool addNewLineAfterClosingBrace,
      bool addNewLineAfterOpeningBrace,
      bool addNewLineAfterSemicolon,
      bool addNewLineAtEndOfText,
      bool addNewLineBeforeClosingBrace,
      bool addNewLineBeforeOpeningBrace,
      bool fixSpaces,
      int indentationSpacesPerLevel,
      int maxEmptyLines,
      bool removeTrailingCommas});
}

/// @nodoc
class __$ConfigCopyWithImpl<$Res> implements _$ConfigCopyWith<$Res> {
  __$ConfigCopyWithImpl(this._self, this._then);

  final _Config _self;
  final $Res Function(_Config) _then;

  /// Create a copy of Config
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? addNewLineAfterClosingBrace = null,
    Object? addNewLineAfterOpeningBrace = null,
    Object? addNewLineAfterSemicolon = null,
    Object? addNewLineAtEndOfText = null,
    Object? addNewLineBeforeClosingBrace = null,
    Object? addNewLineBeforeOpeningBrace = null,
    Object? fixSpaces = null,
    Object? indentationSpacesPerLevel = null,
    Object? maxEmptyLines = null,
    Object? removeTrailingCommas = null,
  }) {
    return _then(_Config(
      addNewLineAfterClosingBrace: null == addNewLineAfterClosingBrace
          ? _self.addNewLineAfterClosingBrace
          : addNewLineAfterClosingBrace // ignore: cast_nullable_to_non_nullable
              as bool,
      addNewLineAfterOpeningBrace: null == addNewLineAfterOpeningBrace
          ? _self.addNewLineAfterOpeningBrace
          : addNewLineAfterOpeningBrace // ignore: cast_nullable_to_non_nullable
              as bool,
      addNewLineAfterSemicolon: null == addNewLineAfterSemicolon
          ? _self.addNewLineAfterSemicolon
          : addNewLineAfterSemicolon // ignore: cast_nullable_to_non_nullable
              as bool,
      addNewLineAtEndOfText: null == addNewLineAtEndOfText
          ? _self.addNewLineAtEndOfText
          : addNewLineAtEndOfText // ignore: cast_nullable_to_non_nullable
              as bool,
      addNewLineBeforeClosingBrace: null == addNewLineBeforeClosingBrace
          ? _self.addNewLineBeforeClosingBrace
          : addNewLineBeforeClosingBrace // ignore: cast_nullable_to_non_nullable
              as bool,
      addNewLineBeforeOpeningBrace: null == addNewLineBeforeOpeningBrace
          ? _self.addNewLineBeforeOpeningBrace
          : addNewLineBeforeOpeningBrace // ignore: cast_nullable_to_non_nullable
              as bool,
      fixSpaces: null == fixSpaces
          ? _self.fixSpaces
          : fixSpaces // ignore: cast_nullable_to_non_nullable
              as bool,
      indentationSpacesPerLevel: null == indentationSpacesPerLevel
          ? _self.indentationSpacesPerLevel
          : indentationSpacesPerLevel // ignore: cast_nullable_to_non_nullable
              as int,
      maxEmptyLines: null == maxEmptyLines
          ? _self.maxEmptyLines
          : maxEmptyLines // ignore: cast_nullable_to_non_nullable
              as int,
      removeTrailingCommas: null == removeTrailingCommas
          ? _self.removeTrailingCommas
          : removeTrailingCommas // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
