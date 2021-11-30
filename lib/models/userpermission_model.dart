// ignore_for_file: non_constant_identifier_names, constant_identifier_names, avoid_print

enum Permissions {
  OFFICE_VIEW,
  OFFICE_CREATE,
  OFFICE_EDIT,
  OFFICE_DELETE,
  DEALER_VIEW,
  DEALER_CREATE,
  DEALER_EDIT,
  DEALER_DELETE,
  DEAL_VIEW,
  DEAL_CREATE,
  DEAL_EDIT,
  DEAL_DELETE,
  DEALAREA_VIEW,
  DEALAREA_CREATE,
  DEALAREA_EDIT,
  DEALAREA_DELETE,
  DEALTYPE_VIEW,
  DEALTYPE_CREATE,
  DEALTYPE_EDIT,
  DEALTYPE_DELETE,
  ROLE_VIEW,
  ROLE_CREATE,
  ROLE_EDIT,
  ROLE_DELETE,
}

extension PermsName on Permissions {
  String get name => toString().split(".")[1];
}

class UserPermissionsModel {
  final Map<String, bool> perms;

  UserPermissionsModel({required this.perms});

  bool hasPermission(Permissions perm) {
    return perms[perm.name]!;
  }
}

enum Direction {
  UP,
  DOWN,
}

Direction direction = Direction.UP; //"DOWN"

// Direction.UP.toString() => "Direction.UP"

String alias(String str) => str[0] + str[str.length - 1];

extension StringExtension on String {
  String get alias => this[0] + this[length - 1];
}

var a = "Khaled".alias;

class A {
  final String firstName;
  String? middleName;
  final String lastName;

  A({
    required this.firstName,
    required this.lastName,
    this.middleName,
  });

  printParticalName() {
    print("$firstName $lastName");
  }

  printFullName() {
    print("$firstName $middleName $lastName");
  }

  printFullNameUPPER() {
    // if (middleName == null) middleName = "";

    middleName ??= "";

    print(
        "${firstName.toUpperCase()} ${middleName!.toUpperCase()} ${lastName.toUpperCase()}");
  }
}

int grade = 10;
var didPass = grade > 20 ? "PASS" : "FALIED";
