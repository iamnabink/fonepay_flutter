/// PRN : "GlZ7fyBV"
/// PID : "null"
/// PS : "12.5"
/// RC : "15842"
/// UID : "UID"
/// BC : "BC"
/// INI : ""
/// P_AMT : ""
/// R_AMT : ""
/// DV : "CD7AF367A80BBFB3ACEBCE9C11D9A61B282A6C3238031B20CE97346D6C005E39F8DD4C90DE736BD09DA5C81C48F82FA6D5091CA669CBF8BFE83AF223BE30F0C5"

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
