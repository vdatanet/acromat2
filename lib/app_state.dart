import 'package:flutter/material.dart';
import 'backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _JWT = prefs.getString('ff_JWT') ?? _JWT;
    _Empleado = prefs.getString('ff_Empleado') ?? _Empleado;
    _GrupoApp = prefs.getString('ff_GrupoApp') ?? _GrupoApp;
    _Destino = prefs.getString('ff_Destino') ?? _Destino;
    _Take = prefs.getInt('ff_Take') ?? _Take;
    _PtOpciones = prefs.getStringList('ff_PtOpciones') ?? _PtOpciones;
    _PtAcciones = prefs.getStringList('ff_PtAcciones') ?? _PtAcciones;
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _JWT = '';
  String get JWT => _JWT;
  set JWT(String _value) {
    _JWT = _value;
    prefs.setString('ff_JWT', _value);
  }

  String _Empleado = '';
  String get Empleado => _Empleado;
  set Empleado(String _value) {
    _Empleado = _value;
    prefs.setString('ff_Empleado', _value);
  }

  String _GrupoApp = '';
  String get GrupoApp => _GrupoApp;
  set GrupoApp(String _value) {
    _GrupoApp = _value;
    prefs.setString('ff_GrupoApp', _value);
  }

  String _Destino = '';
  String get Destino => _Destino;
  set Destino(String _value) {
    _Destino = _value;
    prefs.setString('ff_Destino', _value);
  }

  int _Take = 20;
  int get Take => _Take;
  set Take(int _value) {
    _Take = _value;
    prefs.setInt('ff_Take', _value);
  }

  List<String> _PtOpciones = [
    'Identificación',
    'Cliente / Dom. Servicio',
    'Ubicación',
    'Producto / Obs',
    'Descripción Servicio',
    'Actividades',
    'Materiales',
    'Trabajos Realizados',
    'CRMs',
    'TCs',
    'Fotos PT',
    'Fotos PV',
    'Fotos OV'
  ];
  List<String> get PtOpciones => _PtOpciones;
  set PtOpciones(List<String> _value) {
    _PtOpciones = _value;
    prefs.setStringList('ff_PtOpciones', _value);
  }

  void addToPtOpciones(String _value) {
    _PtOpciones.add(_value);
    prefs.setStringList('ff_PtOpciones', _PtOpciones);
  }

  void removeFromPtOpciones(String _value) {
    _PtOpciones.remove(_value);
    prefs.setStringList('ff_PtOpciones', _PtOpciones);
  }

  void removeAtIndexFromPtOpciones(int _index) {
    _PtOpciones.removeAt(_index);
    prefs.setStringList('ff_PtOpciones', _PtOpciones);
  }

  List<String> _PtAcciones = [
    'Cargar Fotos',
    'Abrir Actividad',
    'Cerrar Actividad',
    'Agregar Trabajo',
    'Agregar Material',
    'Informar',
    'Cambiar F/H Concertada',
    'Cobro / Pago Efectivo',
    'Nuevo PC',
    'Guardar Ubicación',
    'Cerrar PT'
  ];
  List<String> get PtAcciones => _PtAcciones;
  set PtAcciones(List<String> _value) {
    _PtAcciones = _value;
    prefs.setStringList('ff_PtAcciones', _value);
  }

  void addToPtAcciones(String _value) {
    _PtAcciones.add(_value);
    prefs.setStringList('ff_PtAcciones', _PtAcciones);
  }

  void removeFromPtAcciones(String _value) {
    _PtAcciones.remove(_value);
    prefs.setStringList('ff_PtAcciones', _PtAcciones);
  }

  void removeAtIndexFromPtAcciones(int _index) {
    _PtAcciones.removeAt(_index);
    prefs.setStringList('ff_PtAcciones', _PtAcciones);
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}
