/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

enum Country implements _i1.SerializableModel {
  deu,
  aut,
  bel,
  bgr,
  hrv,
  cyp,
  cze,
  dnk,
  est,
  fin,
  fra,
  grc,
  hun,
  irl,
  ita,
  lva,
  ltu,
  lux,
  mlt,
  nld,
  pol,
  prt,
  rou,
  svk,
  svn,
  esp,
  swe,
  che,
  gbr,
  nor,
  isl,
  lie,
  usa,
  can,
  aus,
  nzl,
  jpn,
  chn,
  ind,
  tur,
  ukr,
  are,
  sau,
  bra,
  mex,
  zaf,
  kor,
  sgp,
  isr
  ;

  static Country fromJson(String name) {
    switch (name) {
      case 'deu':
        return Country.deu;
      case 'aut':
        return Country.aut;
      case 'bel':
        return Country.bel;
      case 'bgr':
        return Country.bgr;
      case 'hrv':
        return Country.hrv;
      case 'cyp':
        return Country.cyp;
      case 'cze':
        return Country.cze;
      case 'dnk':
        return Country.dnk;
      case 'est':
        return Country.est;
      case 'fin':
        return Country.fin;
      case 'fra':
        return Country.fra;
      case 'grc':
        return Country.grc;
      case 'hun':
        return Country.hun;
      case 'irl':
        return Country.irl;
      case 'ita':
        return Country.ita;
      case 'lva':
        return Country.lva;
      case 'ltu':
        return Country.ltu;
      case 'lux':
        return Country.lux;
      case 'mlt':
        return Country.mlt;
      case 'nld':
        return Country.nld;
      case 'pol':
        return Country.pol;
      case 'prt':
        return Country.prt;
      case 'rou':
        return Country.rou;
      case 'svk':
        return Country.svk;
      case 'svn':
        return Country.svn;
      case 'esp':
        return Country.esp;
      case 'swe':
        return Country.swe;
      case 'che':
        return Country.che;
      case 'gbr':
        return Country.gbr;
      case 'nor':
        return Country.nor;
      case 'isl':
        return Country.isl;
      case 'lie':
        return Country.lie;
      case 'usa':
        return Country.usa;
      case 'can':
        return Country.can;
      case 'aus':
        return Country.aus;
      case 'nzl':
        return Country.nzl;
      case 'jpn':
        return Country.jpn;
      case 'chn':
        return Country.chn;
      case 'ind':
        return Country.ind;
      case 'tur':
        return Country.tur;
      case 'ukr':
        return Country.ukr;
      case 'are':
        return Country.are;
      case 'sau':
        return Country.sau;
      case 'bra':
        return Country.bra;
      case 'mex':
        return Country.mex;
      case 'zaf':
        return Country.zaf;
      case 'kor':
        return Country.kor;
      case 'sgp':
        return Country.sgp;
      case 'isr':
        return Country.isr;
      default:
        return Country.deu;
    }
  }

  @override
  String toJson() => name;

  @override
  String toString() => name;
}
