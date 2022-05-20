using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using cFinancialTools.DayCounters;
using AdminOpcionesTool.Opciones.Payoffs;
using AdminOpcionesTool.Opciones.SmileNameSpace;
using AdminOpcionesTool.Opciones.Functions;
using System.Xml.Linq;
using AdminOpcionesTool.Opciones.Struct;
using cFinancialTools.BussineDate;
using cFinancialTools.Yield;
using System.Collections;

namespace AdminOpcionesTool.Opciones.Fijaciones
{
    public enum FixKey
    {
        Peso = 0,
        Fijacion = 1,
        Volatilidad = 2,
        Plazo = 3,
        DeltaDias = 4
    }

    public enum Intervale
    {
        Diaria = 0,
        Semanal = 1,
        Mensual = 2,
        Anual = 3,
        Custom = 4,
    }
    public enum TipoPeso
    {
        Equiproporcional = 0,
        ProporcionalAlTiempo = 1,
        Custom = 2
    }

    public static class FixingDataTools
    {
        private static List<List<int>> CombinacionesTownsList;

        public static string getFixingData(int Town, DateTime fechaProceso, DateTime fecha_inicio, DateTime fecha_venc, DateTime FechaSetdePrecios, string intervalo, string tipoPesos, string moneda, string paridad, string call_put_flag, string compraVenta, double nominal, double spot, double strike, string YieldNameCurvaDom, string YieldNameCurvaFor, enumSetPrincingLoading setPrecios, int FlagSmle01, int Strip)
        {
            Smile _Smile = new Smile(FechaSetdePrecios, paridad, spot, YieldNameCurvaDom, YieldNameCurvaFor, FlagSmle01);
            _Smile.Load(setPrecios);

            CombinacionesTownsList = new List<List<int>>();

            YieldList CurvaList = new YieldList();
            CurvaList.SetPrincingLoading = (enumSetPrincingLoading)setPrecios;
            CurvaList.Load(YieldNameCurvaDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetdePrecios);
            CurvaList.Load(YieldNameCurvaFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetdePrecios);

            Calendars _calendar = new Calendars();
            _calendar.Load();

            string ReturnValue = getFixingData(CurvaList, _Smile, _calendar, Town, fechaProceso, fecha_inicio, fecha_venc, FechaSetdePrecios, intervalo, tipoPesos, moneda, paridad, call_put_flag, compraVenta, nominal, spot, strike, YieldNameCurvaDom, YieldNameCurvaFor, setPrecios, FlagSmle01, Strip);

            return ReturnValue;
        }


        public static string getFixingData(YieldList CurvaList, Smile _Smile, Calendars _calendar, int Town, DateTime fechaProceso, DateTime fecha_inicio, DateTime fecha_venc,DateTime FechaSetdePrecios ,string intervalo, string tipoPesos, string moneda, string paridad, string call_put_flag, string compraVenta, double nominal, double spot, double strike, string YieldNameCurvaDom, string YieldNameCurvaFor, enumSetPrincingLoading setPrecios, int FlagSmle01,int Strip)
        {
            int Londres = 510;
            int Santiago = 6;
            int NewYork = 225;

            List<int> Ciudades0 = new List<int>();
            List<int> Ciudades1 = new List<int>();
            List<int> Ciudades2 = new List<int>();
            List<int> Ciudades3 = new List<int>();
            List<int> Ciudades4 = new List<int>();
            List<int> Ciudades5 = new List<int>();
            List<int> Ciudades6 = new List<int>();
            List<int> Ciudades7 = new List<int>();

            Ciudades1.Add(Londres);
            Ciudades2.Add(Santiago);
            Ciudades3.Add(Santiago);
            Ciudades3.Add(Londres);
            Ciudades4.Add(NewYork);
            Ciudades5.Add(NewYork);
            Ciudades5.Add(Londres);
            Ciudades6.Add(NewYork);
            Ciudades6.Add(Santiago);
            Ciudades7.Add(NewYork);
            Ciudades7.Add(Santiago);

            CombinacionesTownsList.Add(Ciudades0);
            CombinacionesTownsList.Add(Ciudades1);
            CombinacionesTownsList.Add(Ciudades2);
            CombinacionesTownsList.Add(Ciudades3);
            CombinacionesTownsList.Add(Ciudades4);
            CombinacionesTownsList.Add(Ciudades5);
            CombinacionesTownsList.Add(Ciudades6);
            CombinacionesTownsList.Add(Ciudades7);

            Basis _Basis365;


            DataTable _dataFijaciones;
            fecha_venc = AvanzaSiFestivo(_calendar, Town, fecha_venc);
            _dataFijaciones = cData.Opciones.FixingData.getFijaciones(fecha_inicio, fecha_venc, moneda);


            string returnFixingDataValue = "<FixingData>\n";

            DateTime _date_val = new DateTime();
            DateTime _fechaHoy = fechaProceso;

            _fechaHoy = AvanzaSiFestivo(_calendar, Town, _fechaHoy);


            _Basis365 = new Basis(enumBasis.Basis_Act_365, fecha_inicio, fecha_venc);
            int PlazoTotal = (int)_Basis365.Term;


            double _fixingValue;
            double _fixingPeso;
            double _fixingVolatilidad;

            int _delta_t;

            DateTime _date_Ant = new DateTime();
            DateTime _date_aux = new DateTime();
            DataRow[] _DataRow;

            int flagDataBase = 1;
            _date_Ant = fecha_inicio;


            Hashtable _hashData = new Hashtable();
            List<KeyValuePair<DateTime, Hashtable>> FixTable = new List<KeyValuePair<DateTime, Hashtable>>();
            KeyValuePair<DateTime, Hashtable> _par;

            Intervale _intervaleEnum = Intervale.Mensual;
            switch (intervalo)
            {
                case "Diaria":
                    _intervaleEnum = Intervale.Diaria;
                    break;
                case "Semanal":
                    _intervaleEnum = Intervale.Semanal;
                    break;
                case "Mensual":
                    _intervaleEnum = Intervale.Mensual;
                    break;
                case "Anual":
                    _intervaleEnum = Intervale.Anual;
                    break;

            }
            TipoPeso _tipoPeso = TipoPeso.Equiproporcional;
            switch (tipoPesos)
            {
                case "Equiproporcional":
                    _tipoPeso = TipoPeso.Equiproporcional;
                    break;
                case "Proporcional al Tiempo":
                    _tipoPeso = TipoPeso.ProporcionalAlTiempo;
                    break;
            }

            bool isFixedData = false;
            int _plazo;


            _date_val = fecha_inicio;

            int _incremento = 1;
            if (Strip == 0)
            {
                _date_aux = NextFixDate(_calendar, Town, fecha_inicio, _incremento, _intervaleEnum);
            }
            else
            {
                if (_intervaleEnum != Intervale.Diaria && fecha_inicio != fechaProceso)
                {
                    _incremento = 0;
                }

            _date_aux = NextFixDate(_calendar, Town, fecha_inicio, _incremento, _intervaleEnum);
            }


            while (_date_aux <= fecha_venc)
            {

                if (_date_aux < _fechaHoy)//Leer de BD
                {
                    isFixedData = true;
                    flagDataBase = 1;
                    _DataRow = null;

                    //_date_aux = AvanzaSiFestivo(_calendar, Town, _date_aux);

                    _DataRow = _dataFijaciones.Select("Fecha ='" + _date_aux + "'");

                    if (_DataRow[0] != null)
                    {
                        _fixingValue = double.Parse(_DataRow[0]["vmvalor"].ToString());

                        _Basis365 = new Basis(enumBasis.Basis_Act_365, _date_val, _date_aux);
                        _delta_t = (int)_Basis365.Term;

                        //returnFixingDataValue += "<FixingValues Fecha='" + _date_aux + "' Valor='" + _fixingValue + "' Peso='" + _fixingPeso + "' Volatilidad = '0' />\n";
                        _Basis365 = new Basis(enumBasis.Basis_Act_365, fechaProceso, _date_aux);
                        _plazo = (int)_Basis365.Term;

                        _hashData = new Hashtable();
                        _hashData.Add(FixKey.Fijacion, _fixingValue);
                        //_hashData.Add(FixKey.Peso, _fixingPeso);
                        _hashData.Add(FixKey.DeltaDias, _delta_t);
                        _hashData.Add(FixKey.Plazo, _plazo);
                        _par = new KeyValuePair<DateTime, Hashtable>(_date_aux, _hashData);
                        FixTable.Add(_par);

                    }
                    else
                    {

                        //returnFixingDataValue += "<FixingValues Fecha='" + _date_aux + "' Valor='0' Peso='0' Volatilidad = '0' />\n";

                        _Basis365 = new Basis(enumBasis.Basis_Act_365, _date_val, _date_aux);
                        _delta_t = (int)_Basis365.Term;
                        _Basis365 = new Basis(enumBasis.Basis_Act_365, fechaProceso, _date_aux);
                        _plazo = (int)_Basis365.Term;

                        _hashData = new Hashtable();
                        _hashData.Add(FixKey.Fijacion, 0);
                        //_hashData.Add(FixKey.Peso, 0);
                        _hashData.Add(FixKey.DeltaDias, _delta_t);
                        _hashData.Add(FixKey.Plazo, _plazo);
                        _par = new KeyValuePair<DateTime, Hashtable>(_date_aux, _hashData);
                        FixTable.Add(_par);

                    }

                }
                else  //cargar con Fwd;
                {
                    if (flagDataBase == 0)
                    {
                        _date_aux = _fechaHoy;
                        flagDataBase = 1;
                    }
                    else if (flagDataBase == 1)
                    {
                        flagDataBase = -1;
                    }

                    _fixingValue = Function.Forward(_fechaHoy, _date_aux,FechaSetdePrecios, spot, YieldNameCurvaDom, YieldNameCurvaFor, CurvaList);

                    _Basis365 = new Basis(enumBasis.Basis_Act_365, _date_val, _date_aux);
                    _delta_t = (int)_Basis365.Term;

                    //_fixingVolatilidad = _Smile.interp_vol(_delta_t, _fixingValue, 1, 1);
                    // returnFixingDataValue += "<FixingValues Fecha='" + _date_aux + "' Valor='" + _fixingValue + "' Peso='" + _fixingPeso + "' Volatilidad ='" + _fixingVolatilidad + "'/>\n";
                    _Basis365 = new Basis(enumBasis.Basis_Act_365, fechaProceso, _date_aux);
                    _plazo = (int)_Basis365.Term;

                    _hashData = new Hashtable();
                    _hashData.Add(FixKey.Fijacion, _fixingValue);
                    //_hashData.Add(FixKey.Peso, _fixingPeso);
                    _hashData.Add(FixKey.DeltaDias, _delta_t);
                    _hashData.Add(FixKey.Plazo, _plazo);
                    _par = new KeyValuePair<DateTime, Hashtable>(_date_aux, _hashData);
                    FixTable.Add(_par);

                }


                //incrementar en 1 mes
                _incremento++;
                _date_val = _date_aux;
                if (_intervaleEnum == Intervale.Diaria)
                {
                    _date_aux = NextFixDate(_calendar, Town, _date_aux, 1, _intervaleEnum);
                }
                else
                {
                    if (Strip == 0)
                    {
                    _date_aux = NextFixDate(_calendar, Town, fecha_inicio, _incremento, _intervaleEnum);
                }
                    else
                    {
                        _date_aux = PreviousFixDate(_calendar, Town, fecha_inicio, _incremento, _intervaleEnum);
                    }
                }

            }
            if (_date_aux > fecha_venc)
            {
                _date_aux = fecha_venc;
                if (fecha_venc < _fechaHoy && _date_val != _date_aux)//Cargar de BD dias restantes
                {
                    isFixedData = true;
                    _DataRow = null;

                    //_date_aux = AvanzaSiFestivo(_calendar, Town, _date_aux);

                    _DataRow = _dataFijaciones.Select("Fecha ='" + _date_aux + "'");

                    if (_DataRow[0] != null)
                    {

                        _fixingValue = double.Parse(_DataRow[0]["vmvalor"].ToString());

                        _Basis365 = new Basis(enumBasis.Basis_Act_365, _date_val, _date_aux);
                        _delta_t = (int)_Basis365.Term;

                        //returnFixingDataValue += "<FixingValues Fecha='" + _date_aux + "' Valor='" + _fixingValue + "' Peso='" + _fixingPeso + "' Volatilidad = '0' />\n";
                        _Basis365 = new Basis(enumBasis.Basis_Act_365, fechaProceso, _date_aux);
                        _plazo = (int)_Basis365.Term;

                        _hashData = new Hashtable();
                        _hashData.Add(FixKey.Fijacion, _fixingValue);
                        //_hashData.Add(FixKey.Peso, _fixingPeso);
                        _hashData.Add(FixKey.DeltaDias, _delta_t);
                        _hashData.Add(FixKey.Plazo, _plazo);
                        _par = new KeyValuePair<DateTime, Hashtable>(_date_aux, _hashData);
                        FixTable.Add(_par);

                    }
                    else
                    {

                        //returnFixingDataValue += "<FixingValues Fecha='" + _date_aux + "' Valor='0' Peso='0' Volatilidad = '0' />\n";

                        _Basis365 = new Basis(enumBasis.Basis_Act_365, _date_val, _date_aux);
                        _delta_t = (int)_Basis365.Term;
                        _Basis365 = new Basis(enumBasis.Basis_Act_365, fechaProceso, _date_aux);
                        _plazo = (int)_Basis365.Term;

                        _hashData = new Hashtable();
                        _hashData.Add(FixKey.Fijacion, 0);
                        //_hashData.Add(FixKey.Peso, 0);
                        _hashData.Add(FixKey.DeltaDias, _delta_t);
                        _hashData.Add(FixKey.Plazo, _plazo);
                        _par = new KeyValuePair<DateTime, Hashtable>(_date_aux, _hashData);
                        FixTable.Add(_par);


                    }

                }
                else if (fecha_venc >= _fechaHoy && _date_val != _date_aux) // cargar desde Fwd los dias restantes
                {

                    //_date_aux = AvanzaSiFestivo(_calendar, Town, _date_aux);                


                    _fixingValue = Function.Forward(_fechaHoy, _date_aux, FechaSetdePrecios,spot, YieldNameCurvaDom, YieldNameCurvaFor, CurvaList);

                    _Basis365 = new Basis(enumBasis.Basis_Act_365, _date_val, _date_aux);
                    _delta_t = (int)_Basis365.Term;

                    //_fixingVolatilidad = _Smile.interp_vol(_delta_t, _fixingValue, 1, 1);
                    //returnFixingDataValue += "<FixingValues Fecha='" + _date_aux + "' Valor='" + _fixingValue + "' Peso='" + _fixingPeso + "' Volatilidad ='" + _fixingVolatilidad + "'/>\n";
                    _Basis365 = new Basis(enumBasis.Basis_Act_365, fechaProceso, _date_aux);
                    _plazo = (int)_Basis365.Term;

                    _hashData = new Hashtable();
                    _hashData.Add(FixKey.Fijacion, _fixingValue);
                    //_hashData.Add(FixKey.Peso, _fixingPeso);
                    _hashData.Add(FixKey.DeltaDias, _delta_t);
                    _hashData.Add(FixKey.Plazo, _plazo);
                    _par = new KeyValuePair<DateTime, Hashtable>(_date_aux, _hashData);
                    FixTable.Add(_par);

                }
            }

            if (_tipoPeso == TipoPeso.Equiproporcional)
            {
                int _N = FixTable.Count;
                foreach (KeyValuePair<DateTime, Hashtable> _fixElement in FixTable)
                {
                    ((Hashtable)_fixElement.Value)[FixKey.Peso] = 1.0 / _N;
                }
            }

            if (_tipoPeso == TipoPeso.ProporcionalAlTiempo)
            {
                foreach (KeyValuePair<DateTime, Hashtable> _fixElement in FixTable.OrderBy(item => item.Key))
                {
                    int _delta = (int)((Hashtable)_fixElement.Value)[FixKey.DeltaDias];
                    ((Hashtable)_fixElement.Value)[FixKey.Peso] = (double)_delta / PlazoTotal;
                }
            }

            DateTime _fecha_fix;
            double _peso_fix, _valor_fix;
            double _rem_fix = 0;
            double _m0 = 0;
            double Kpp = 0;

            double pesosTotales = 0;
            if (isFixedData)
            {
                foreach (KeyValuePair<DateTime, Hashtable> _fixElement in FixTable.OrderBy(item => item.Key))
                {
                    _fecha_fix = _fixElement.Key;
                    _peso_fix = (double)((Hashtable)_fixElement.Value)[FixKey.Peso];
                    _valor_fix = (double)((Hashtable)_fixElement.Value)[FixKey.Fijacion];

                    if (_fecha_fix <= fechaProceso)
                    {
                        _m0 += _valor_fix * _peso_fix;
                    }
                    else
                    {
                        _rem_fix += _peso_fix;
                    }
                    pesosTotales += _peso_fix;
                }

                Kpp = (strike - _m0) / _rem_fix;
            }
            
            string NewFixingData = "<FixingData>";
            double _fixingVol;
            foreach (KeyValuePair<DateTime, Hashtable> _fixData_element in FixTable.OrderBy(item => item.Key))
            {
                if (isFixedData)
                {
                    if (_fixData_element.Key <= fechaProceso)
                        _fixingVol = 0;
                    else
                        _fixingVol = _Smile.interp_vol((int)((Hashtable)_fixData_element.Value)[FixKey.Plazo], Kpp, 1, 1);

                }
                else
                {
                    _fixingVol = _Smile.interp_vol((int)((Hashtable)_fixData_element.Value)[FixKey.Plazo], strike, 1, 1);
                }

                NewFixingData += "<FixingValues Fecha='" + _fixData_element.Key.ToString("dd-MM-yyyy") + "' Valor='" + (double)((Hashtable)_fixData_element.Value)[FixKey.Fijacion] + "' Peso='" + (double)((Hashtable)_fixData_element.Value)[FixKey.Peso] + "' Volatilidad ='" + _fixingVol + "' Plazo='" + (int)((Hashtable)_fixData_element.Value)[FixKey.Plazo] + "' />\n";

            }
            NewFixingData += "</FixingData>";


            //return xdoc.ToString();
            return NewFixingData.ToString();



        }


        private static DateTime NextFixDate(Calendars _calendar, int townsIndic, DateTime StartDate, int incremento, Intervale intervale)
        {
            DateTime newDate = new DateTime();
            switch (intervale)
            {
                case Intervale.Diaria:
                    newDate = StartDate.AddDays(incremento);
                    newDate = AvanzaSiFestivo(_calendar, townsIndic, newDate);
                    break;
                case Intervale.Semanal:
                    newDate = StartDate.AddDays(incremento * 7);
                    newDate = AvanzaSiFestivo(_calendar, townsIndic, newDate);
                    break;
                case Intervale.Mensual:
                    newDate = StartDate.AddMonths(incremento);
                    newDate = AvanzaSiFestivo(_calendar, townsIndic, newDate);
                    break;
                case Intervale.Anual:
                    newDate = StartDate.AddYears(incremento);
                    newDate = AvanzaSiFestivo(_calendar, townsIndic, newDate);
                    break;
            }

            return newDate;

        }


        private static DateTime AvanzaSiFestivo(Calendars _calendar, int townsIndicator, DateTime Fecha_Evaluar)
        {

            DateTime _fechaEvaluar = new DateTime();

            _fechaEvaluar = Fecha_Evaluar;

            switch (CombinacionesTownsList[townsIndicator].Count)
            {
                case 1:

                    while (!_calendar.IsBussineDay(CombinacionesTownsList[townsIndicator][0], _fechaEvaluar))
                    {
                        _fechaEvaluar = _calendar.NextHolidayDate(CombinacionesTownsList[townsIndicator][0], _fechaEvaluar);

                    }

                    break;
                case 2:

                    while (!_calendar.IsBussineDay(CombinacionesTownsList[townsIndicator][0], _fechaEvaluar) || !_calendar.IsBussineDay(CombinacionesTownsList[townsIndicator][1], _fechaEvaluar))
                    {
                        if (!_calendar.IsBussineDay(CombinacionesTownsList[townsIndicator][0], _fechaEvaluar))
                        {
                            _fechaEvaluar = _calendar.NextHolidayDate(CombinacionesTownsList[townsIndicator][0], _fechaEvaluar);
                        }

                        if (!_calendar.IsBussineDay(CombinacionesTownsList[townsIndicator][1], _fechaEvaluar))
                        {
                            _fechaEvaluar = _calendar.NextHolidayDate(CombinacionesTownsList[townsIndicator][1], _fechaEvaluar);
                        }

                    }

                    break;
                case 3:

                    while (!_calendar.IsBussineDay(CombinacionesTownsList[townsIndicator][0], _fechaEvaluar) || !_calendar.IsBussineDay(CombinacionesTownsList[townsIndicator][1], _fechaEvaluar) || !_calendar.IsBussineDay(CombinacionesTownsList[townsIndicator][2], _fechaEvaluar))
                    {
                        if (!_calendar.IsBussineDay(CombinacionesTownsList[townsIndicator][0], _fechaEvaluar))
                        {
                            _fechaEvaluar = _calendar.NextHolidayDate(CombinacionesTownsList[townsIndicator][0], _fechaEvaluar);
                        }

                        if (!_calendar.IsBussineDay(CombinacionesTownsList[townsIndicator][1], _fechaEvaluar))
                        {
                            _fechaEvaluar = _calendar.NextHolidayDate(CombinacionesTownsList[townsIndicator][1], _fechaEvaluar);
                        }
                        if (!_calendar.IsBussineDay(CombinacionesTownsList[townsIndicator][2], _fechaEvaluar))
                        {
                            _fechaEvaluar = _calendar.NextHolidayDate(CombinacionesTownsList[townsIndicator][2], _fechaEvaluar);
                        }

                    }

                    break;
            }

            return _fechaEvaluar;


        }


        public static string ReloadFixing(YieldList CurvaList, Smile _Smile, DateTime Fecha_inicio, DateTime Fecha_Fin, DateTime Fecha_Val, DateTime FechaSetDePrecios ,Intervale Frecuencia, TipoPeso PesoTipo, double spot, double Strike, string CurvaDom, string CurvaFor, List<StructFixingData> FixingList)
        {
            int _N = FixingList.Count;
            double PlazoTotal = (double)Fecha_Fin.Subtract(Fecha_inicio).Days;
            bool isFixedData = FixingList[0].Fecha < Fecha_Val ? true : false;

            if (PesoTipo == TipoPeso.Equiproporcional)
            {
                foreach (StructFixingData _fixElement in FixingList)
                {
                    _fixElement.Peso = 1.0 / _N;
                }
            }

            if (PesoTipo == TipoPeso.ProporcionalAlTiempo)
            {
                FixingList[0].Peso = ((double)FixingList[0].Fecha.Subtract(Fecha_inicio).Days) / PlazoTotal;
                for (int i = 1; i < _N; i++)
                {
                    FixingList[i].Peso = ((double)FixingList[i].Fecha.Subtract(FixingList[i - 1].Fecha).Days) / PlazoTotal;
                }
            }

            DateTime _fecha_fix;
            double _peso_fix, _valor_fix;
            double _rem_fix = 0;
            double _m0 = 0;
            double Kpp = 0;

            double pesosTotales = 0;
            if (isFixedData)
            {
                foreach (StructFixingData _fixElement in FixingList.OrderBy(item => item.Fecha))
                {
                    _fecha_fix = _fixElement.Fecha;
                    _peso_fix = _fixElement.Peso;
                    _valor_fix = _fixElement.Valor;

                    if (_fecha_fix <= Fecha_Val)
                    {
                        _m0 += _valor_fix * _peso_fix;
                    }
                    else
                    {
                        _rem_fix += _peso_fix;
                    }
                    pesosTotales += _peso_fix;
                }

                Kpp = (Strike - _m0) / _rem_fix;
            }

            string NewFixingData = "<FixingData>";
            double _fixingVol;
            foreach (StructFixingData _fixData_element in FixingList.OrderBy(item => item.Fecha))
            {
                _fixData_element.Valor = Function.Forward(Fecha_Val, _fixData_element.Fecha, FechaSetDePrecios, spot, CurvaDom, CurvaFor, CurvaList);

                if (isFixedData)
                {
                    if (_fixData_element.Fecha <= Fecha_Val)
                        _fixingVol = 0;
                    else
                        _fixingVol = _Smile.interp_vol(_fixData_element.Plazo, Kpp, 1, 1);

                }
                else
                {
                    _fixingVol = _Smile.interp_vol(_fixData_element.Plazo, Strike, 1, 1);
                }

                NewFixingData += "<FixingValues Fecha='" + _fixData_element.Fecha.ToString("dd-MM-yyyy") + "' Valor='" + _fixData_element.Valor + "' Peso='" + _fixData_element.Peso + "' Volatilidad ='" + _fixingVol + "' Plazo='" + _fixData_element.Plazo + "' />\n";

            }
            NewFixingData += "</FixingData>";


            //return xdoc.ToString();
            return NewFixingData.ToString();

        }

        //Agregado_20130318 PA
     
        private static DateTime RetrocedeSiFestivo(Calendars _calendar, int townsIndicator, DateTime Fecha_Evaluar)
        {

            DateTime _fechaEvaluar = new DateTime();

            _fechaEvaluar = Fecha_Evaluar;

            switch (CombinacionesTownsList[townsIndicator].Count)
            {
                case 1:

                    while (!_calendar.IsBussineDay(CombinacionesTownsList[townsIndicator][0], _fechaEvaluar))
                    {
                        //_fechaEvaluar = _calendar.NextHolidayDate(CombinacionesTownsList[townsIndicator][0], _fechaEvaluar);
                        _fechaEvaluar = _calendar.PreviousHolidayDate(CombinacionesTownsList[townsIndicator][0], _fechaEvaluar);


                    }

                    break;
                case 2:

                    while (!_calendar.IsBussineDay(CombinacionesTownsList[townsIndicator][0], _fechaEvaluar) || !_calendar.IsBussineDay(CombinacionesTownsList[townsIndicator][1], _fechaEvaluar))
                    {
                        if (!_calendar.IsBussineDay(CombinacionesTownsList[townsIndicator][0], _fechaEvaluar))
                        {
                            _fechaEvaluar = _calendar.PreviousHolidayDate(CombinacionesTownsList[townsIndicator][0], _fechaEvaluar);
                        }

                        if (!_calendar.IsBussineDay(CombinacionesTownsList[townsIndicator][1], _fechaEvaluar))
                        {
                            _fechaEvaluar = _calendar.PreviousHolidayDate(CombinacionesTownsList[townsIndicator][1], _fechaEvaluar);
                        }

                    }

                    break;
                case 3:

                    while (!_calendar.IsBussineDay(CombinacionesTownsList[townsIndicator][0], _fechaEvaluar) || !_calendar.IsBussineDay(CombinacionesTownsList[townsIndicator][1], _fechaEvaluar) || !_calendar.IsBussineDay(CombinacionesTownsList[townsIndicator][2], _fechaEvaluar))
                    {
                        if (!_calendar.IsBussineDay(CombinacionesTownsList[townsIndicator][0], _fechaEvaluar))
                        {
                            _fechaEvaluar = _calendar.PreviousHolidayDate(CombinacionesTownsList[townsIndicator][0], _fechaEvaluar);
                        }

                        if (!_calendar.IsBussineDay(CombinacionesTownsList[townsIndicator][1], _fechaEvaluar))
                        {
                            _fechaEvaluar = _calendar.NextHolidayDate(CombinacionesTownsList[townsIndicator][1], _fechaEvaluar);
                        }
                        if (!_calendar.IsBussineDay(CombinacionesTownsList[townsIndicator][2], _fechaEvaluar))
                        {
                            _fechaEvaluar = _calendar.PreviousHolidayDate(CombinacionesTownsList[townsIndicator][2], _fechaEvaluar);
                        }

                    }

                    break;
            }

            return _fechaEvaluar;


        }

        private static DateTime PreviousFixDate(Calendars _calendar, int townsIndic, DateTime StartDate, int incremento, Intervale intervale)
        {
            DateTime newDate = new DateTime();
            switch (intervale)
            {
                case Intervale.Diaria:
                    newDate = StartDate.AddDays(incremento);
                    newDate = RetrocedeSiFestivo(_calendar, townsIndic, newDate);
                    break;
                case Intervale.Semanal:
                    newDate = StartDate.AddDays(incremento * 7);
                    newDate = RetrocedeSiFestivo(_calendar, townsIndic, newDate);
                    break;
                case Intervale.Mensual:
                    newDate = StartDate.AddMonths(incremento);
                    newDate = RetrocedeSiFestivo(_calendar, townsIndic, newDate);
                    break;
                case Intervale.Anual:
                    newDate = StartDate.AddYears(incremento);
                    newDate = RetrocedeSiFestivo(_calendar, townsIndic, newDate);
                    break;
            }

            return newDate;

        }



    }
}
