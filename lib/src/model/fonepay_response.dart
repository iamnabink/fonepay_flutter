part of fonepay_flutter;

class FonePayResponse {
  FonePayResponse({
    this.prn,
    this.pid,
    this.ps,
    this.rc,
    this.uid,
    this.bc,
    this.ini,
    this.pAmt,
    this.rAmt,
    this.dv,
  });

  String? prn;
  String? pid;
  String? ps;
  String? rc;
  String? uid;
  String? bc;
  String? ini;
  String? pAmt;
  String? rAmt;
  String? dv;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['PRN'] = prn;
    map['PID'] = pid;
    map['PS'] = ps;
    map['RC'] = rc;
    map['UID'] = uid;
    map['BC'] = bc;
    map['INI'] = ini;
    map['P_AMT'] = pAmt;
    map['R_AMT'] = rAmt;
    map['DV'] = dv;
    return map;
  }
}
