import 'package:collection/collection.dart';

enum ScanResult {
  CHECK_IN,
  CHECK_OUT,
  REVALIDATE,
  NOT_FOUND,
  USED,
  INVALID,
  VALID,
  NOT_ALLOW,
}

enum LoginWith {
  email,
  phone,
  passkey,
}

enum Profile {
  scanner,
  producer,
  admin,
  manager,
}

enum ShowEventFor {
  SingleEvent,
  All,
  Unset,
}

enum TicketType {
  Registration,
  Regular,
  Donation,
}

enum AttendeeFilterBy {
  ALL,
  ABSENT,
  CHECK_OUT,
  CHECK_IN,
}

enum Export {
  export,
  exporting,
  exported,
}

enum RiveAnimType {
  BarcodeLoading,
  EventSyncing,
  LoadingLogo,
  AvatarSyncing,
  Syncing,
}

enum AccessPermission {
  lookup,
  canViewList,
  allEvents,
  manualEntry,
  searchAttendee,
  scan,
  stats,
  settings,
}

enum PinType {
  SYSTEM,
  ON_SITE_PIN,
}

enum EventUserType {
  seller,
  headSeller,
  manager,
}

enum AddOnStatus {
  pending,
  completed,
}


extension FFEnumExtensions<T extends Enum> on T {
  String serialize() => name;
}

extension FFEnumListExtensions<T extends Enum> on Iterable<T> {
  T? deserialize(String? value) =>
      firstWhereOrNull((e) => e.serialize() == value);
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (ScanResult):
      return ScanResult.values.deserialize(value) as T?;
    case (LoginWith):
      return LoginWith.values.deserialize(value) as T?;
    case (Profile):
      return Profile.values.deserialize(value) as T?;
    case (ShowEventFor):
      return ShowEventFor.values.deserialize(value) as T?;
    case (TicketType):
      return TicketType.values.deserialize(value) as T?;
    case (AttendeeFilterBy):
      return AttendeeFilterBy.values.deserialize(value) as T?;
    case (Export):
      return Export.values.deserialize(value) as T?;
    case (RiveAnimType):
      return RiveAnimType.values.deserialize(value) as T?;
    case (AccessPermission):
      return AccessPermission.values.deserialize(value) as T?;
    case (PinType):
      return PinType.values.deserialize(value) as T?;
    case (EventUserType):
      return EventUserType.values.deserialize(value) as T?;
    default:
      return null;
  }
}
