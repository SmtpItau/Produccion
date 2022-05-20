using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using AdminOpciones.Recursos;
using cData.AccionesBD;
using System.Data;
using System.Configuration;

namespace AdminOpciones.Web.Rec
{
    public class LineasOpcionesTuringSAO
    {
        #region "Declara variables"
        public static int _MetodologiaRec = 0;
        public static double _ThresholdRec = 0;
        public static string _DescClienteRec = "";
        public static int _RutRec = 0;
        public static int _CodCliRec = 0;



        #endregion

        public static string RecOpciones(DataSet _Datos, string Usuario_, int _NumContrato, string _Operacion, DateTime fProceso)
        {
            string _Glosa = "";

            #region "Calculo Lineas Creación"

            DataTable _Resultado = new DataTable();
            DataTable _Parametros = new DataTable();
            double _MontoRec = 0;

            _Parametros = AccionesTuringSAO.TraeClienteLCR(_Datos, _Operacion);


            DataRow _P = _Parametros.Rows[0];
            _MetodologiaRec = Convert.ToInt32(_P["MetodologiaLCR"].ToString());
            _ThresholdRec = Convert.ToDouble(_P["Mto_Lin_Threshold"].ToString());
            _DescClienteRec = (_P["Clnombre"].ToString());


            DataRow _Dat = _Datos.Tables[0].Rows[0];
            _RutRec = Convert.ToInt32(_Dat["MoRutCliente"].ToString());
            _CodCliRec = Convert.ToInt32(_Dat["MoCodigo"].ToString());

            if (_Operacion == "C")
            {

                if (_MetodologiaRec == 2 | _MetodologiaRec == 3 | _MetodologiaRec == 5)
                {

                    short _Rec_metodologia = Convert.ToInt16(_MetodologiaRec);

                    _MontoRec = AccionesTuringSAO.EjecutaCalculoRec(_RutRec,
                                                            _CodCliRec,
                                                            _DescClienteRec,
                                                            _ThresholdRec,
                                                            _Rec_metodologia);

                    _Resultado.Rows.Clear();
                    _Resultado.Columns.Add("AvrCLP", System.Type.GetType("System.Decimal"));
                    _Resultado.Columns.Add("PorcAddOn", System.Type.GetType("System.Decimal"));
                    _Resultado.Columns.Add("MontoAddOn", System.Type.GetType("System.Decimal"));
                    _Resultado.Columns.Add("LCRDrv", System.Type.GetType("System.Decimal"));

                    _Resultado.Rows.Add(0, 0, 0, _MontoRec);


                }
                else
                {
                    _Resultado.Rows.Clear();
                    _Resultado = AccionesTuringSAO.CalculaLCROpciones(_NumContrato, _Operacion);

                }

                _Glosa = AccionesTuringSAO.EjecutaProcesoLineasOpciones(_Resultado, _Datos, Usuario_, _NumContrato, _Operacion);

            }
            #endregion

            #region "Calculo Lineas Anulacion"
            if (_Operacion == "U")
            {

                string _Result = string.Empty;


                if (_MetodologiaRec == 2 | _MetodologiaRec == 3 | _MetodologiaRec == 5)
                {


                    short _Rec_metodologia = Convert.ToInt16(_MetodologiaRec);

                    _MontoRec = AccionesTuringSAO.EjecutaCalculoRec(_RutRec,
                                                    _CodCliRec,
                                                    _DescClienteRec,
                                                    _ThresholdRec,
                                                    _Rec_metodologia);


                    _Resultado.Rows.Clear();
                    _Resultado.Columns.Add("AvrCLP", System.Type.GetType("System.Decimal"));
                    _Resultado.Columns.Add("PorcAddOn", System.Type.GetType("System.Decimal"));
                    _Resultado.Columns.Add("MontoAddOn", System.Type.GetType("System.Decimal"));
                    _Resultado.Columns.Add("LCRDrv", System.Type.GetType("System.Decimal"));
                    _Resultado.Rows.Add(0, 0, 0, _MontoRec);

                    _Glosa = _Result + AccionesTuringSAO.EjecutaProcesoLineasOpciones(_Resultado, _Datos, Usuario_, _NumContrato, _Operacion);

                }
                else
                {
                    DataTable _resultado = new DataTable();
                    _resultado = AccionesTuringSAO.EjecutaSP_LineasAnula(_NumContrato, fProceso);

                    if (_resultado != null)
                    {
                        DataRow _p = _resultado.Rows[0];

                        _Result = _p["Column2"].ToString();

                        _Glosa = _Result;
                    }
                }
            }
            #endregion

            #region "Calculo Lineas Modifica"
            if (_Operacion == "M")
            {

                if (_MetodologiaRec == 2 | _MetodologiaRec == 3 | _MetodologiaRec == 5)
                {

                    short _Rec_metodologia = Convert.ToInt16(_MetodologiaRec);

                    _MontoRec = AccionesTuringSAO.EjecutaCalculoRec(_RutRec,
                                                    _CodCliRec,
                                                    _DescClienteRec,
                                                    _ThresholdRec,
                                                    _Rec_metodologia);



                    _Resultado.Rows.Clear();
                    _Resultado.Columns.Add("AvrCLP", System.Type.GetType("System.Decimal"));
                    _Resultado.Columns.Add("PorcAddOn", System.Type.GetType("System.Decimal"));
                    _Resultado.Columns.Add("MontoAddOn", System.Type.GetType("System.Decimal"));
                    _Resultado.Columns.Add("LCRDrv", System.Type.GetType("System.Decimal"));

                    _Resultado.Rows.Add(0, 0, 0, _MontoRec);


                    _Glosa = AccionesTuringSAO.EjecutaProcesoLineasOpciones(_Resultado, _Datos, Usuario_, _NumContrato, _Operacion);



                }

                else
                {

                    DataTable _resultado = new DataTable();
                    _resultado = AccionesTuringSAO.EjecutaSP_LineasAnula(_NumContrato, fProceso);
                    string _Status = "";
                    string _Result = string.Empty;

                    if (_resultado != null)
                    {
                        DataRow _p = _resultado.Rows[0];
                        _Status = _p["Column1"].ToString();
                        _Result = _p["Column2"].ToString();
                    }

                    _Resultado.Rows.Clear();
                    _Resultado = AccionesTuringSAO.CalculaLCROpciones(_NumContrato, _Operacion);

                    _Glosa = AccionesTuringSAO.EjecutaProcesoLineasOpciones(_Resultado, _Datos, Usuario_, _NumContrato, _Operacion);

                }

            }

            #endregion

            return _Glosa;
        }
    }
}
