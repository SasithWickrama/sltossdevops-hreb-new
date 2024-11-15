class Users {
  String? sID;
  String? nAME;
  String? rTOM;
  String? lEVEL;
  String? cONTACTNO;
  String? tITLE;
  String? mAIL;
  String? gROUP;
  String? sN;

  Users(
      {this.sID,
        this.nAME,
        this.rTOM,
        this.lEVEL,
        this.cONTACTNO,
        this.tITLE,
        this.mAIL,
        this.gROUP,
        this.sN});

  Users.fromJson(Map<String, dynamic> json) {
    sID = json['SID'];
    nAME = json['NAME'];
    rTOM = json['RTOM'];
    lEVEL = json['LEVEL'];
    cONTACTNO = json['CONTACTNO'];
    tITLE = json['TITLE'];
    mAIL = json['MAIL'];
    gROUP = json['GROUP'];
    sN = json['SN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SID'] = this.sID;
    data['NAME'] = this.nAME;
    data['RTOM'] = this.rTOM;
    data['LEVEL'] = this.lEVEL;
    data['CONTACTNO'] = this.cONTACTNO;
    data['TITLE'] = this.tITLE;
    data['MAIL'] = this.mAIL;
    data['GROUP'] = this.gROUP;
    data['SN'] = this.sN;
    return data;
  }
}


class HrUsers {
  bool? success;
  String? authtoken;
  String? name;
  int? personId;
  String? employeeNumber;
  String? job;
  String? email;
  String? gender;
  String? employee;
  String? manager;

  HrUsers(
      {this.success,
        this.authtoken,
        this.name,
        this.personId,
        this.employeeNumber,
        this.job,
        this.email,
        this.gender,
        this.employee,
        this.manager});

  HrUsers.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    authtoken = json['authtoken'];
    name = json['name'];
    personId = json['person_id'];
    employeeNumber = json['employee_number'];
    job = json['job'];
    email = json['email'];
    gender = json['gender'];
    employee = json['employee'];
    manager = json['manager'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['authtoken'] = this.authtoken;
    data['name'] = this.name;
    data['person_id'] = this.personId;
    data['employee_number'] = this.employeeNumber;
    data['job'] = this.job;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['employee'] = this.employee;
    data['manager'] = this.manager;
    return data;
  }
}