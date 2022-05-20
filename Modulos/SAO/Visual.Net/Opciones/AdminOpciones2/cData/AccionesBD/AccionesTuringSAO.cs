using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
using System.Xml;
using System.Xml.Linq;
using DLLBacCalculoREC;

namespace cData.AccionesBD
{
    public static class AccionesTuringSAO
    {

        #region Strip Asiatico
        public static DateTime StripFechaInicio = DateTime.Now;    //STRIP ASIATICO
        public static DateTime StripFechaVcto = DateTime.Now;      //STRIP ASIATICO
        public static int ContratosPorStrip = 0,   //STRIP ASIATICO
                      IdContratoStrip = 0;      //STRIP ASIATICO

        #endregion


        #region "variable Rec"
        public static long _Rut = 0;
        public static decimal _CodCliente = 0;
        public static long _NumContratoRec = 0;
        public static DateTime _FechaContrato;
        public static DateTime _FechaVencimiento;
        public static string _Sistema;
        public static decimal _RecNocional;
        public static string _RecUsuario;
        public static string _ClPais = "";
        public static int _Metodologia = 0;
        public static decimal _Garantia = 0;

        #endregion

        #region "Atributos Privados"
        private static enumStatus mStatus;
        private static enumSource mSource;
        private static String mError;
        private static String mStack;
        #endregion

        public static DataTable ResulDB(int NumFolio)
        {
            String _Query = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _AccionUpdate;

            #region "Ejecuta Sp_MoMarcaImpreso"
            _Query = "Sp_MoMarcaImpreso " + NumFolio;
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_Query);
                _AccionUpdate = _Connect.QueryDataTable();
                _AccionUpdate.TableName = "Resultado";

                if (_AccionUpdate.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _AccionUpdate = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _AccionUpdate;
        }

        public static DataTable ResulDB_Ca(int NumContrato)
        {
            String _Query = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _AccionUpdate;

            #region "Ejecuta Sp_CaMarcaImpreso"
            _Query = "Sp_CaMarcaImpreso " + NumContrato;
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_Query);
                _AccionUpdate = _Connect.QueryDataTable();
                _AccionUpdate.TableName = "Resultado";

                if (_AccionUpdate.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _AccionUpdate = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _AccionUpdate;
        }

        public static DataTable InicioDiaProcesar(string fechaAP, string fechaProxAP, string User)
        {
            String _Query = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _AccionUpdate;

            #region "Ejecuta sp_Ini_dia_opc"
            _Query = "sp_Ini_dia_opc '" + fechaAP + "' ,'" + fechaProxAP + "','" + User + "'";
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_Query);
                _AccionUpdate = _Connect.QueryDataTable();
                // _AccionUpdate.TableName = "OpcionesGeneral";

                if (_AccionUpdate.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _AccionUpdate = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _AccionUpdate;
        }

        public static DataTable FinDiaProcesar()
        {
            String _Query = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _AccionUpdate;

            #region "Ejecuta sp_Fin_dia_opc"
            _Query = "sp_Fin_dia_opc";
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_Query);
                _AccionUpdate = _Connect.QueryDataTable();
                // _AccionUpdate.TableName = "OpcionesGeneral";

                if (_AccionUpdate.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _AccionUpdate = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _AccionUpdate;
        }

        public static DataTable ActualizaParametro()
        {
            String _Query = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _AccionUpdate;

            #region "Ejecuta Sp_ImportaDataBacParamSuda"
            _Query = "Sp_ImportaDataBacParamSuda";
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_Query);
                _AccionUpdate = _Connect.QueryDataTable();
                // _AccionUpdate.TableName = "OpcionesGeneral";

                if (_AccionUpdate.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _AccionUpdate = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _AccionUpdate;
        }

        public static DataTable SumaVertical()
        {
            String _Query = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _AccionUpdate;

            #region "Ejecuta Sp_SumaValVertical"
            _Query = "Sp_SumaValVertical";
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_Query);
                _AccionUpdate = _Connect.QueryDataTable();
                // _AccionUpdate.TableName = "OpcionesGeneral";

                if (_AccionUpdate.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _AccionUpdate = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _AccionUpdate;
        }

        public static DataTable UpdateFlagValorizacion()
        {
            string _Query = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _AccionUpdate;

            #region "Ejecuta Sp_SumaValVertical"
            _Query = "sp_actualizaflagvalorizacion";
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_Query);
                _AccionUpdate = _Connect.QueryDataTable();
                _AccionUpdate.TableName = "ActualizaFlag";

                if (_AccionUpdate.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _AccionUpdate = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _AccionUpdate;
        }

        public static DataTable CierreMesaProcesar(string Usuario_)
        {
            String _Query = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _AccionUpdate;

            #region "Ejecuta sp_Cierre_Abre_Mesa"
            _Query = "sp_Cierre_Abre_Mesa " + Usuario_;
            #endregion
            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_Query);
                _AccionUpdate = _Connect.QueryDataTable();
                // _AccionUpdate.TableName = "OpcionesGeneral";

                if (_AccionUpdate.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _AccionUpdate = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _AccionUpdate;
        }

        public static DataTable CambiaEstado(int NumContrato, string Usuario, string Estado)
        {
            String _Query = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _AccionUpdate;

            #region "Ejecuta Sp_Cambia_Estado"
            _Query = "Sp_Cambia_Estado " + NumContrato + ", '" + Usuario + "', '" + Estado + "' ";
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_Query);
                _AccionUpdate = _Connect.QueryDataTable();
                _AccionUpdate.TableName = "Resultado";

                if (_AccionUpdate.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _AccionUpdate = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _AccionUpdate;
        }

        public static DataTable DeshacerAnticipo(int NumContrato, int NumFolio)
        {
            String _Query = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _AccionUpdate;

            #region "Ejecuta Sp_Deshacer_Anticipo"
            _Query = "Sp_Deshacer_Anticipo " + NumContrato + ", " + NumFolio;
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_Query);
                _AccionUpdate = _Connect.QueryDataTable();
                _AccionUpdate.TableName = "Resultado";

                if (_AccionUpdate.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _AccionUpdate = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _AccionUpdate;
        }

        public static DataTable ModificaCotizacion(int NumContrato, int NumCotizacion)
        {
            String _Query = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _AccionUpdate;

            #region "Ejecuta Sp_Modifica_Por_Cotizacion"
            _Query = "Sp_Modifica_Por_Cotizacion " + NumContrato + ", " + NumCotizacion;
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_Query);
                _AccionUpdate = _Connect.QueryDataTable();
                _AccionUpdate.TableName = "Resultado";

                if (_AccionUpdate.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _AccionUpdate = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _AccionUpdate;
        }

        public static DataTable PrefijacionDatos(List<string> _Lista)
        {
            String _QueryInsertFix = "";
            string usuario = "";
            int _Row;
            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _AccionInsert;

            #region "Query OpcionesMenu"

            _QueryInsertFix += "declare @usuario varchar(10) " + " \n " +
                               "begin tran " + " \n ";

            if (_Lista.Count > 0)
            {
                string[] obj_ = null;
                for (_Row = 0; _Row < _Lista.Count; _Row++)
                {
                    obj_ = _Lista[_Row].Split('|');

                    int contrato = Convert.ToInt32(obj_[0].ToString());
                    usuario = obj_[1].ToString();
                    int numestruct = Convert.ToInt32(obj_[2].ToString());
                    int numfix = Convert.ToInt32(obj_[3].ToString());
                    string fechafix = obj_[4].ToString();
                    string valorfix = obj_[5].ToString().Replace(",", ".");

                    _QueryInsertFix += string.Format(cData.Properties.Resources.FixSQL, usuario, contrato, numestruct, numfix, fechafix, valorfix) + "\n ";
                }
            }
            _QueryInsertFix += "set @usuario = '" + usuario + "'" + " \n " +
                               "exec sp_Graba_FijacionPagos @usuario" + " \n " +
                               "if @@Error <> 0 " + " \n " +
                               "begin " + " \n " +
                               "    select -1 as OK " + "\n " +
                               "rollback tran " + " \n " +
                               "end " + " \n " +
                               "else " + "\n " +
                               "   begin " + "\n " +
                               "      commit tran " + "\n " +
                               "      select 0 as OK " + "\n " +
                               " end ";
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryInsertFix);
                _AccionInsert = _Connect.QueryDataTable();
                _AccionInsert.TableName = "Resultado";

                if (_AccionInsert.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _AccionInsert = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _AccionInsert;
        }

        public static DataTable InsertarCondGenerales(List<string> _Lista)
        {
            String _QueryInsertCond = "";
            string fecha = "";
            string fecha_supl = "";
            int chkCond = 0;
            int chkSupl = 0;
            int _Row;
            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _AccionInsert;

            #region "Query OpcionesMenu"

            _QueryInsertCond += "begin tran " + " \n ";
            if (_Lista.Count > 0)
            {
                string[] obj_ = null;
                for (_Row = 0; _Row < _Lista.Count; _Row++)
                {
                    obj_ = _Lista[_Row].Split('|');

                    int rut = Convert.ToInt32(obj_[0].ToString());
                    int codigo = Convert.ToInt32(obj_[1].ToString());
                    // MAP Creo que hay que tener cuidado con los formatos
                    fecha = "convert( datetime, '" + obj_[2].ToString() + "', 105 )";
                    fecha_supl = "convert( datetime, '" + obj_[3].ToString() + "', 105 )";
                    chkCond = Convert.ToInt32(obj_[4].ToString());
                    chkSupl = Convert.ToInt32(obj_[5].ToString());

                    // MAP Borrar por si existe
                    // MAP Pendiente: deberia solo actualizar lo que cambia
                    if (obj_[2].ToString() != "01-01-1900")
                    {
                        _QueryInsertCond += string.Format("Delete BreakBacParamsudaCliente where ClRut = {0} and ClCodigo = {1} \n", rut, codigo);
                        //_QueryInsertCond += string.Format("Insert into BreakBacParamsudaCliente select {0},{1},{2}", rut, codigo, fecha) + "\n "; Pendiente CWaldhorn 28-08-2009
                        _QueryInsertCond += string.Format("Insert into BreakBacParamsudaCliente select {0},{1},{2},{3},{4},{5}", rut, codigo, fecha, chkCond, fecha_supl, chkSupl) + "\n ";
                    }
                }
            }
            _QueryInsertCond += //"set @usuario = '" + usuario + "'" + " \n " +
                //"exec sp_Graba_FijacionPagos @usuario" + " \n " +
                               "if @@Error <> 0 " + " \n " +
                               "begin " + " \n " +
                               "    select -1 as OK " + "\n " +
                               "rollback tran " + " \n " +
                               "end " + " \n " +
                               "else " + "\n " +
                               "   begin " + "\n " +
                               "      commit tran " + "\n " +
                               "      select 0 as OK " + "\n " +
                               " end ";
            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryInsertCond);
                _AccionInsert = _Connect.QueryDataTable();
                _AccionInsert.TableName = "Resultado";

                if (_AccionInsert.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _AccionInsert = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _AccionInsert;
        }

        public static DataTable CambiaDecisionEj(List<string> _Lista)
        {
            String _QueryUpdateDecisionEj = "";
            string usuario = "";
            int _Row;
            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _AccionUpdateDecisionEj;

            #region "Query Sp_Cambia_Decision"

            if (_Lista.Count > 0)
            {
                string[] obj_ = null;
                for (_Row = 0; _Row < _Lista.Count; _Row++)
                {
                    obj_ = _Lista[_Row].Split('|');

                    int contrato = Convert.ToInt32(obj_[0].ToString());
                    int numcomponente = Convert.ToInt32(obj_[1].ToString());
                    int cajfolio = Convert.ToInt32(obj_[2].ToString());
                    usuario = obj_[3].ToString();
                    string estado = obj_[4].ToString();
                    string vf = obj_[5].ToString();

                    _QueryUpdateDecisionEj += string.Format(
                                                             "EXECUTE dbo.Sp_Cambia_Decision {0}, {1}, {2}, '{3}', '{4}'\n",
                                                             contrato,
                                                             numcomponente,
                                                             cajfolio,
                                                             usuario,
                                                             estado
                                                           );
                }
            }

            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryUpdateDecisionEj);
                _AccionUpdateDecisionEj = _Connect.QueryDataTable();
                _AccionUpdateDecisionEj.TableName = "Resultado";

                if (_AccionUpdateDecisionEj.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _AccionUpdateDecisionEj = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _AccionUpdateDecisionEj;
        }

        public static String EjerceContrato(DataSet _Datos, string Usuario_, int _NumFolio, int _NumContrato, decimal nocional, decimal versus, string modalidadpago)
        {
            #region "variables GrabaContrato"

            string _Result = string.Empty,
                    MoTipoPayOff = string.Empty;
            Int64 MoNumFolio = 0,
                    MoNumContrato = 0,
                    MoRutCliente = 0;
            string _MoEncContrato = "Nulo",
                    _MoDetContrato = "Nulo",
                    _MoFixing = "Nulo";

            Dataset.DataMovimiento _DataContrato = new Dataset.DataMovimiento();
            Manager.DataManagerSQL dm_ = new cData.Manager.DataManagerSQL("");
            #endregion

            try
            {

                #region "Genera MoNumFolio"
                dm_ = new cData.Manager.DataManagerSQL(ConnectString("Opciones"));
                dm_.Fill(_DataContrato.OpcionesGeneral);
                cData.Dataset.DataMovimiento.OpcionesGeneralRow _DatosOP = _DataContrato.OpcionesGeneral[0];

                MoNumFolio = Int64.Parse(_DatosOP.numero_Folio.ToString()) + 1;
                MoNumContrato = _NumContrato;

                _DatosOP.BeginEdit();
                _DatosOP.numero_Folio++;
                _DatosOP.EndEdit();

                #endregion

                #region "Carga Datos a DataSet de Grabación"

                if (_Datos.Tables.Count > 0)
                {
                    #region "MoEncContrato"
                    DataRow _row = _Datos.Tables["encContrato"].Rows[0];
                    cData.Dataset.DataMovimiento.MoEncContratoRow _newRow = _DataContrato.MoEncContrato.NewMoEncContratoRow();

                    #region "Carga datos Numeric"
                    _newRow.MoNumFolio = MoNumFolio;
                    _newRow.MoNumContrato = _NumContrato;
                    _newRow.MoRutCliente = _row["MoRutCliente"] != "" && _row["MoRutCliente"].ToString() != "NaN" ? Int64.Parse(_row["MoRutCliente"].ToString()) : 0;
                    MoRutCliente = _row["MoRutCliente"] != "" && _row["MoRutCliente"].ToString() != "NaN" ? Int64.Parse(_row["MoRutCliente"].ToString()) : 0;
                    _newRow.MoCodigo = _row["MoCodigo"] != "" && _row["MoCodigo"].ToString() != "NaN" ? Int64.Parse(_row["MoCodigo"].ToString()) : 0;
                    _newRow.MoMonPrimaTrf = 0;
                    _newRow.MoMonPrimaCosto = 0;
                    _newRow.MoCodMonPagPrima = 0;
                    _newRow.MofPagoPrima = 0;
                    _newRow.MoMonCarryPrima = 0;
                    _newRow.MoMon_vr = 0;
                    _newRow.MoMondelta = 0;
                    _newRow.MoMon_gamma = 0;
                    _newRow.MoMon_vega = 0;
                    _newRow.MoMon_vanna = 0;
                    _newRow.MoMon_volga = 0;
                    _newRow.MoMon_theta = 0;
                    _newRow.MoMon_rho = 0;
                    _newRow.MoMon_rhof = 0;
                    _newRow.MoMon_charm = 0;
                    _newRow.MoMon_zomma = 0;
                    _newRow.MoMon_speed = 0;
                    //PRD_10449 ASVG_20111102
                    _newRow.MoRelacionaPAE = _row["MoRelacionaPAE"] != "" && _row["MoRelacionaPAE"].ToString() != "NaN" ? Int32.Parse(_row["MoRelacionaPAE"].ToString()) : 0;
                    #endregion

                    #region "Carga datos Varchar"
                    _newRow.MoTipoTransaccion = "EJERCE";
                    _newRow.MoEstado = _row["MoEstado"].ToString();
                    _newRow.MoCarteraFinanciera = _row["MoCarteraFinanciera"].ToString();
                    _newRow.MoLibro = _row["MoLibro"].ToString();
                    _newRow.MoCarNormativa = _row["MoCarNormativa"].ToString();
                    _newRow.MoSubCarNormativa = _row["MoSubCarNormativa"].ToString();
                    if (MoRutCliente > 0 && MoRutCliente < 40000000)
                    { _newRow.MoTipoContrapartida = "Interna"; }
                    if (MoRutCliente > 40000000)
                    { _newRow.MoTipoContrapartida = "Normal"; }
                    _newRow.MoOperador = Usuario_;
                    _newRow.MoCodEstructura = _row["MoCodEstructura"].ToString();
                    _newRow.MoCVEstructura = _row["MoCVEstructura"].ToString();
                    _newRow.MoSistema = "OPT";
                    _newRow.MoGlosa = _row["MoGlosa"].ToString();
                    #endregion

                    #region "Carga datos Float"
                    _newRow.MoPrimaTrf = 0;
                    _newRow.MoPrimaTrfML = 0;
                    _newRow.MoPrimaCosto = 0;
                    _newRow.MoPrimaCostoML = 0;
                    _newRow.MoCarryPrima = 0;
                    _newRow.MoParM2Spot = 0;
                    _newRow.MoParMdaPrima = 0;
                    _newRow.MoVr = 0;
                    _newRow.MoPrimaBSSpotCont = 0;
                    _newRow.MoDeltaForwardCont = 0;

                    _newRow.MoVegaCont = 0;
                    _newRow.MoVolgaCont = 0;
                    _newRow.MoThetaCont = 0;
                    _newRow.MoRhoDomCont = 0;
                    _newRow.MoRhoForCont = 0;

                    // DMV 11 Diciembre del 2009, se corrige problema de grabación de prima
                    _newRow.MoPrimaInicial = 0;
                    _newRow.MoPrimaInicialML = 0;
                    _newRow.MoParMdaPrima = 0;
                    //5843
                    _newRow.MoResultadoVentasML = _row["MoResultadoVentasML"] != "" && _row["MoResultadoVentasML"].ToString() != "NaN" ? Double.Parse(_row["MoResultadoVentasML"].ToString()) : 0;
                    #endregion

                    #region "Carga datos Datetime"
                    _newRow.MoFechaContrato = _row["MoFechaContrato"] != "" ? DateTime.Parse(_row["MoFechaContrato"].ToString()) : DateTime.Parse("01010001");
                    _newRow.MoFechaPagoPrima = _row["MoFechaPagoPrima"] != "" ? DateTime.Parse(_row["MoFechaPagoPrima"].ToString()) : DateTime.Parse("01010001");
                    _newRow.MoFecValorizacion = _row["MoFecValorizacion"] != "" ? DateTime.Parse(_row["MoFecValorizacion"].ToString()) : DateTime.Parse("01010001");
                    _newRow.MoFechaCreacionRegistro = DateTime.Now;
                    #endregion

                    _DataContrato.MoEncContrato.Rows.Add(_newRow);

                    #endregion

                    #region "MoDetContrato"
                    if (_Datos.Tables["detContrato"] != null)
                    {
                        foreach (DataRow _rowD in _Datos.Tables["detContrato"].Rows)
                        {
                            //DataRow _rowD = _Datos.Tables["detContrato"].Rows[row_];
                            cData.Dataset.DataMovimiento.MoDetContratoRow _newRowD = _DataContrato.MoDetContrato.NewMoDetContratoRow();

                            #region "Carga datos Numeric"

                            _newRowD.MoNumFolio = MoNumFolio;
                            _newRowD.MoNumEstructura = _rowD["MoNumEstructura"] != "" ? Int64.Parse(_rowD["MoNumEstructura"].ToString()) : 0;
                            _newRowD.MoFormaPagoMon1 = _rowD["MoFormaPagoMon1"] != "" ? Int64.Parse(_rowD["MoFormaPagoMon1"].ToString()) : 0;
                            _newRowD.MoFormaPagoMon2 = _rowD["MoFormaPagoMon2"] != "" ? Int64.Parse(_rowD["MoFormaPagoMon2"].ToString()) : 0;
                            _newRowD.MoCodMon1 = _rowD["MoCodMon1"] != "" ? Int64.Parse(_rowD["MoCodMon1"].ToString()) : 0;
                            _newRowD.MoCodMon2 = _rowD["MoCodMon2"] != "" ? Int64.Parse(_rowD["MoCodMon2"].ToString()) : 0;
                            _newRowD.MoMdaCompensacion = _rowD["MoMdaCompensacion"] != "" ? Int64.Parse(_rowD["MoMdaCompensacion"].ToString()) : 0;
                            _newRowD.MoBenchComp = _rowD["MoBenchComp"] != "" ? Int64.Parse(_rowD["MoBenchComp"].ToString()) : 0;
                            _newRowD.MoPorcStrike = _rowD["MoPorcStrike"] != "" ? Int64.Parse(_rowD["MoPorcStrike"].ToString()) : 0;
                            _newRowD.MoIteAsoCon = _rowD["MoIteAsoCon"] != "" ? Int64.Parse(_rowD["MoIteAsoCon"].ToString()) : 0;
                            _newRowD.MoFormaPagoComp = _rowD["MoFormaPagoComp"] != "" ? Int64.Parse(_rowD["MoFormaPagoComp"].ToString()) : 0;

                            #endregion

                            #region "Carga datos Varchar"

                            _newRowD.MoVinculacion = _rowD["MoVinculacion"].ToString();
                            _newRowD.MoTipoOpc = _rowD["MoTipoOpc"].ToString();
                            _newRowD.MoSubyacente = _rowD["MoSubyacente"].ToString();
                            _newRowD.MoTipoPayOff = _rowD["MoTipoPayOff"].ToString();
                            _newRowD.MoCallPut = _rowD["MoCallPut"].ToString();
                            _newRowD.MoCVOpc = _rowD["MoCVOpc"].ToString();
                            _newRowD.MoCurveSmile = _rowD["MoCurveSmile"].ToString();
                            _newRowD.MoIteAsoSis = _rowD["MoIteAsoSis"].ToString();
                            _newRowD.MoTipoEmisionPT = _rowD["MoTipoEmisionPT"].ToString();
                            _newRowD.MoModalidad = modalidadpago;
                            _newRowD.MoParStrike = _rowD["MoParStrike"].ToString();
                            _newRowD.MoTipoEjercicio = _rowD["MoTipoEjercicio"].ToString();
                            _newRowD.MoCurveMon1 = _rowD["MoCurveMon1"].ToString();
                            _newRowD.MoCurveMon2 = _rowD["MoCurveMon2"].ToString();

                            #endregion

                            #region "Carga datos Float"

                            _newRowD.MoStrike = _rowD["MoStrike"] != "" && _rowD["MoStrike"].ToString() != "NaN" ? Double.Parse(_rowD["MoStrike"].ToString()) : 0;
                            _newRowD.MoWf_mon1 = 0;
                            _newRowD.MoWf_mon2 = 0;
                            _newRowD.MoVol = 0;
                            _newRowD.MoFwd_teo = 0;
                            _newRowD.MoDelta_spot = 0;
                            _newRowD.MoWf_Mon1_Costo = 0;
                            _newRowD.MoWf_Mon2_Costo = 0;
                            _newRowD.MoVol_Costo = 0;
                            _newRowD.MoFwd_Teo_Costo = 0;
                            _newRowD.MoVr_CostoDet = 0;
                            _newRowD.MoPrimaBSSpotDet = 0;
                            _newRowD.MoVrDet = 0;
                            _newRowD.MoSpotDet = 0;
                            _newRowD.MoSpotDetCosto = 0;
                            _newRowD.MoCharm_fwd_num = 0;
                            _newRowD.MoRho_num = 0;
                            _newRowD.MoRhof = 0;
                            _newRowD.MoRhof_num = 0;
                            _newRowD.MoCharm_spot = 0;
                            _newRowD.MoCharm_spot_num = 0;
                            _newRowD.MoCharm_fwd = 0;
                            _newRowD.MoVanna_fwd_num = 0;
                            _newRowD.MoVolga = 0;
                            _newRowD.MoVolga_num = 0;
                            _newRowD.MoTheta = 0;
                            _newRowD.MoTheta_num = 0;
                            _newRowD.MoRho = 0;
                            _newRowD.MoGamma_fwd_num = 0;
                            _newRowD.MoVega = 0;
                            _newRowD.MoVega_num = 0;
                            _newRowD.MoVanna_spot = 0;
                            _newRowD.MoVanna_spot_num = 0;
                            _newRowD.MoVanna_fwd = 0;
                            _newRowD.MoDelta_spot_num = 0;
                            _newRowD.MoDelta_fwd = 0;
                            _newRowD.MoDelta_fwd_num = 0;
                            _newRowD.MoGamma_spot = 0;
                            _newRowD.MoGamma_spot_num = 0;
                            _newRowD.MoGamma_fwd = 0;

                            // MAP Pendiente verificar el modelo de Datos
                            _newRowD.MoMontoMon1 = nocional;
                            _newRowD.MoVrDet = (double)versus;
                            _newRowD.MoMontoMon2 = nocional * (decimal)_newRowD.MoStrike;
                            //Prd_10968
                            _RecNocional = _newRowD.MoMontoMon1;
                            #endregion

                            #region "Carga datos DateTime"

                            _newRowD.MoFechaInicioOpc = _rowD["MoFechaInicioOpc"] != "" ? DateTime.Parse(_rowD["MoFechaInicioOpc"].ToString()) : DateTime.Parse("01010001");
                            _newRowD.MoFechaFijacion = _newRow.MoFecValorizacion;
                            _newRowD.MoFechaVcto = _newRow.MoFecValorizacion;
                            _newRowD.MoFechaPagMon1 = _newRow.MoFecValorizacion;
                            _newRowD.MoFechaPagMon2 = _newRow.MoFecValorizacion;
                            _newRowD.MoFechaPagoEjer = _newRow.MoFecValorizacion;

                            #endregion

                            _DataContrato.MoDetContrato.Rows.Add(_newRowD);
                        }
                    }
                    #endregion

                    #region "MoFixing Datos por XML"

                    int cont_ = 0;
                    decimal _MoEstructura = 0;
                    cont_ = _Datos.Tables["FixingData"].Rows.Count;

                    foreach (cData.Dataset.DataMovimiento.MoDetContratoRow _DetRow in _DataContrato.MoDetContrato.Rows)
                    {
                        _MoEstructura = _DetRow.MoNumEstructura;

                        DataRow[] _DRFixings = _Datos.Tables["FixingData"].Select("MoNumEstructura = " + _MoEstructura.ToString());

                        if (_DRFixings.Length > 0)
                        {
                            #region Multiples Fixing
                            foreach (DataRow _rowF in _DRFixings)
                            {
                                //DataRow _rowF = _Datos.Tables["FixingData"].Rows[rowx_];
                                cData.Dataset.DataMovimiento.MoFixingRow _newRowF = _DataContrato.MoFixing.NewMoFixingRow();

                                #region "Carga datos Numeric"
                                _newRowF.MoNumFolio = MoNumFolio;
                                _newRowF.MoNumEstructura = _MoEstructura;
                                _newRowF.MoFixNumero = _rowF["ID"] != "" ? Int64.Parse(_rowF["ID"].ToString()) : 0;
                                //_newRowF.MoFixBenchComp = _rowF["ixBenchComparacion"] != "" ? Int64.Parse(_rowF["ixBenchComparacion"].ToString()) : 0;
                                _newRowF.MoFixBenchComp = 994;
                                #endregion

                                #region "Carga datos Varchar"
                                _newRowF.MoFixParBench = "CLP/USD";
                                //_newRowF["MoFixEstado"] = _rowF["MoFixEstado"];
                                #endregion

                                #region "Carga datos Float"
                                _newRowF.MoFijacion = _rowF["Valor"] != "" && _rowF["Valor"].ToString() != "NaN" ? float.Parse(_rowF["Valor"].ToString()) : 0;
                                _newRowF.MoVolFij = _rowF["Volatilidad"] != "" && _rowF["Volatilidad"].ToString() != "NaN" ? float.Parse(_rowF["Volatilidad"].ToString()) : 0;
                                _newRowF.MoPesoFij = _rowF["Peso"] != "" && _rowF["Peso"].ToString() != "NaN" ? float.Parse(_rowF["Peso"].ToString()) : 0;
                                #endregion

                                #region "Carga datos DateTime"
                                _newRowF.MoFixFecha = _rowF["Fecha"] != "" ? DateTime.Parse(_rowF["Fecha"].ToString()) : DateTime.Parse("01010001");
                                #endregion

                                _DataContrato.MoFixing.Rows.Add(_newRowF);
                            }
                            #endregion
                        }
                        else
                        {
                            #region Single Fixing

                            MoTipoPayOff = _DetRow.MoTipoPayOff;
                            if (MoTipoPayOff == "01")
                            {
                                cData.Dataset.DataMovimiento.MoFixingRow _newRowF = _DataContrato.MoFixing.NewMoFixingRow();

                                #region "Carga datos Numeric"
                                _newRowF.MoNumFolio = MoNumFolio;
                                _newRowF.MoNumEstructura = _MoEstructura;
                                // MAP 18 Agosto _newRowF.MoFixNumero = row_;
                                // Numero de Fijación de estructuras vanilla
                                _newRowF.MoFixNumero = 1;
                                // Bench-Mark de La Fijación
                                //_newRowF.MoFixBenchComp = _DetRow["MoBenchComp"] != "" ? int.Parse(_DetRow["MoBenchComp"].ToString()) : 0;
                                _newRowF.MoFixBenchComp = 994;
                                #endregion

                                #region "Carga datos Varchar"
                                _newRowF.MoFixParBench = "CLP/USD";
                                _newRowF.MoFixEstado = "";
                                #endregion

                                #region "Carga datos Float"
                                _newRowF.MoFijacion = 0;
                                _newRowF.MoVolFij = 0;
                                _newRowF.MoPesoFij = 100;
                                #endregion

                                #region "Carga datos DateTime"
                                _newRowF.MoFixFecha = _DetRow.MoFechaFijacion;
                                #endregion

                                _DataContrato.MoFixing.Rows.Add(_newRowF);
                            }
                            #endregion
                        }
                    }
                    #endregion

                }
                #endregion

                #region "DataConecctionInterfaceGB"

                #region "Sección Actualización"
                dm_.TransactionBegin();
                int _filasEnc = _DataContrato.MoEncContrato.Rows.Count;
                if (_filasEnc > 0)
                {
                    int _result = dm_.Update(_DataContrato.MoEncContrato);
                    if (_filasEnc == _result)
                    {
                        _MoEncContrato = "True";
                        int _filasDet = _DataContrato.MoDetContrato.Rows.Count;
                        if (_filasDet > 0)
                        {
                            int result2_ = dm_.Update(_DataContrato.MoDetContrato);
                            if (_filasDet == result2_)
                            {
                                _MoDetContrato = "True";
                                int _filasFix = _DataContrato.MoFixing.Rows.Count;
                                if (_filasFix > 0)
                                {
                                    int result3_ = dm_.Update(_DataContrato.MoFixing);
                                    if (_filasFix == result3_)
                                    { _MoFixing = "True"; }
                                    else
                                    { _MoFixing = "False"; }
                                }
                            }
                            else
                            { _MoDetContrato = "False"; }
                        }
                    }
                    else
                    { _MoEncContrato = "False"; }
                }
                #endregion

                #region "Sección Grabación"
                string Tipo = "MoEnContrato=" + _MoEncContrato + " MoDetContrato=" + _MoDetContrato + " MoFixing=" + _MoFixing;
                DataTable _resultado = new DataTable();
                string _Status = "";
                switch (Tipo)
                {
                    case "MoEnContrato=True MoDetContrato=True MoFixing=True":
                        dm_.Update(_DataContrato.OpcionesGeneral);
                        dm_.TransactionCommit();
                        _resultado = ProcesoAppMvtCar(Convert.ToInt16(MoNumFolio));
                        if (_resultado != null)
                        {
                            DataRow _p = _resultado.Rows[0];
                            _Status = _p["Column1"].ToString();
                            _Result = _p["Column2"].ToString();
                        }
                        else
                        {
                            _Status = "ERROR";
                            _Result = "Sql ERROR EjerceContrato Fixing";
                        }
                        if (_Status.ToUpper().Equals("SI"))
                        {
                            _Result += " .net OK";
                        }
                        break;
                    case "MoEnContrato=True MoDetContrato=True MoFixing=Nulo":
                        dm_.Update(_DataContrato.OpcionesGeneral);
                        dm_.TransactionCommit();
                        _resultado = ProcesoAppMvtCar(Convert.ToInt16(MoNumFolio));
                        if (_resultado != null)
                        {
                            DataRow _p = _resultado.Rows[0];
                            _Status = _p["Column1"].ToString();
                            _Result = _p["Column2"].ToString();
                        }
                        else
                        {
                            _Result = "Sql ERROR EjerceContrato Fixing Nulo";
                        }
                        _Result += " .net ERROR";
                        break;
                    case "MoEnContrato=True MoDetContrato=True MoFixing=False":
                        dm_.TransactionRollback();
                        _Result = "Error con Fila(s) en tabla MoFixing";
                        break;
                    case "MoEnContrato=True MoDetContrato=False MoFixing=Nulo":
                        dm_.TransactionRollback();
                        _Result = "Error con Fila(s) en tabla MoDetContrato";
                        break;
                    case "MoEnContrato=False MoDetContrato=Nulo MoFixing=Nulo":
                        dm_.TransactionRollback();
                        _Result = "Error con Fila(s) en tabla MoEnContrato";
                        break;
                }
                #endregion

                #endregion
            }
            catch (Exception _Error)
            {
                dm_.TransactionRollback();
                _Result = _Error.Message;
                _Result = "Error al grabar Ejercicio de Contrato";
            }

            return _Result;
        }

        public static String GrabaContrato(DataSet _Datos, string Usuario_)
        {
            #region "variables GrabaContrato"

            string _Result = string.Empty,
                    MoTipoPayOff = string.Empty;
            Int64 MoNumFolio = 0,
                    MoNumContrato = 0,
                    MoRutCliente = 0;
            string _MoEncContrato = "Nulo",
                    _MoDetContrato = "Nulo",
                    _MoFixing = "Nulo";

            Dataset.DataMovimiento _DataContrato = new Dataset.DataMovimiento();
            Manager.DataManagerSQL dm_ = new cData.Manager.DataManagerSQL("");
            #endregion

            try
            {

                #region "Genera MoNumFolio"
                dm_ = new cData.Manager.DataManagerSQL(ConnectString("Opciones"));
                dm_.Fill(_DataContrato.OpcionesGeneral);
                cData.Dataset.DataMovimiento.OpcionesGeneralRow _DatosOP = _DataContrato.OpcionesGeneral[0];

                MoNumFolio = Int64.Parse(_DatosOP.numero_Folio.ToString()) + 1;
                MoNumContrato = Int64.Parse(_DatosOP.numero_Contrato.ToString()) + 1;

                _DatosOP.BeginEdit();
                _DatosOP.numero_Folio++;
                _DatosOP.numero_Contrato++;
                _DatosOP.EndEdit();

                #endregion

                #region "Carga Datos a DataSet de Grabación"

                if (_Datos.Tables.Count > 0)
                {
                    #region "MoEncContrato"
                    DataRow _row = _Datos.Tables["encContrato"].Rows[0];
                    cData.Dataset.DataMovimiento.MoEncContratoRow _newRow = _DataContrato.MoEncContrato.NewMoEncContratoRow();

                    #region "Carga datos Numeric"
                    _newRow.MoNumFolio = MoNumFolio;
                    _newRow.MoNumContrato = MoNumContrato;
                    _newRow.MoRutCliente = _row["MoRutCliente"] != "" && _row["MoRutCliente"].ToString() != "NaN" ? Int64.Parse(_row["MoRutCliente"].ToString()) : 0;
                    MoRutCliente = _row["MoRutCliente"] != "" && _row["MoRutCliente"].ToString() != "NaN" ? Int64.Parse(_row["MoRutCliente"].ToString()) : 0;
                    _newRow.MoCodigo = _row["MoCodigo"] != "" && _row["MoCodigo"].ToString() != "NaN" ? Int64.Parse(_row["MoCodigo"].ToString()) : 0;
                    _newRow.MoMonPrimaTrf = _row["MoMonPrimaTrf"] != "" && _row["MoMonPrimaTrf"].ToString() != "NaN" ? Int64.Parse(_row["MoMonPrimaTrf"].ToString()) : 0;
                    _newRow.MoMonPrimaCosto = _row["MoMonPrimaCosto"] != "" && _row["MoMonPrimaCosto"].ToString() != "NaN" ? Int64.Parse(_row["MoMonPrimaCosto"].ToString()) : 0;
                    _newRow.MoCodMonPagPrima = _row["MoCodMonPagPrima"] != "" && _row["MoCodMonPagPrima"].ToString() != "NaN" ? Int64.Parse(_row["MoCodMonPagPrima"].ToString()) : 0;
                    _newRow.MofPagoPrima = _row["MofPagoPrima"] != "" && _row["MofPagoPrima"].ToString() != "NaN" ? Int64.Parse(_row["MofPagoPrima"].ToString()) : 0;
                    _newRow.MoMonCarryPrima = _row["MoMonCarryPrima"] != "" && _row["MoMonCarryPrima"].ToString() != "NaN" ? Int64.Parse(_row["MoMonCarryPrima"].ToString()) : 0;
                    _newRow.MoMon_vr = _row["MoMon_vr"] != "" && _row["MoMon_vr"].ToString() != "NaN" ? Int64.Parse(_row["MoMon_vr"].ToString()) : 0;
                    _newRow.MoMondelta = _row["MoMondelta"] != "" && _row["MoMondelta"].ToString() != "NaN" ? Int64.Parse(_row["MoMondelta"].ToString()) : 0;
                    _newRow.MoMon_gamma = _row["MoMon_gamma"] != "" && _row["MoMon_gamma"].ToString() != "NaN" ? Int64.Parse(_row["MoMon_gamma"].ToString()) : 0;
                    _newRow.MoMon_vega = _row["MoMon_vega"] != "" && _row["MoMon_vega"].ToString() != "NaN" ? Int64.Parse(_row["MoMon_vega"].ToString()) : 0;
                    _newRow.MoMon_vanna = _row["MoMon_vanna"] != "" && _row["MoMon_vanna"].ToString() != "NaN" ? Int64.Parse(_row["MoMon_vanna"].ToString()) : 0;
                    _newRow.MoMon_volga = _row["MoMon_volga"] != "" && _row["MoMon_volga"].ToString() != "NaN" ? Int64.Parse(_row["MoMon_volga"].ToString()) : 0;
                    _newRow.MoMon_theta = _row["MoMon_theta"] != "" && _row["MoMon_theta"].ToString() != "NaN" ? Int64.Parse(_row["MoMon_theta"].ToString()) : 0;
                    _newRow.MoMon_rho = _row["MoMon_rho"] != "" && _row["MoMon_rho"].ToString() != "NaN" ? Int64.Parse(_row["MoMon_rho"].ToString()) : 0;
                    _newRow.MoMon_rhof = _row["MoMon_rhof"] != "" && _row["MoMon_rhof"].ToString() != "NaN" ? Int64.Parse(_row["MoMon_rhof"].ToString()) : 0;
                    _newRow.MoMon_charm = _row["MoMon_charm"] != "" && _row["MoMon_charm"].ToString() != "NaN" ? Int64.Parse(_row["MoMon_charm"].ToString()) : 0;
                    _newRow.MoMon_zomma = _row["MoMon_zomma"] != "" && _row["MoMon_zomma"].ToString() != "NaN" ? Int64.Parse(_row["MoMon_zomma"].ToString()) : 0;
                    _newRow.MoMon_speed = _row["MoMon_speed"] != "" && _row["MoMon_speed"].ToString() != "NaN" ? Int64.Parse(_row["MoMon_speed"].ToString()) : 0;
                    //PRD_10449 ASVG_20111102
                    _newRow.MoRelacionaPAE = _row["MoRelacionaPAE"] != "" && _row["MoRelacionaPAE"].ToString() != "NaN" ? Int32.Parse(_row["MoRelacionaPAE"].ToString()) : 0;
                    //Prd_10968
                    _Rut = MoRutCliente;
                    _CodCliente = _newRow.MoCodigo;
                    _NumContratoRec = MoNumContrato;

                    #endregion

                    #region "Carga datos Varchar"
                    _newRow.MoTipoTransaccion = "CREACION";
                    _newRow.MoEstado = _row["MoEstado"].ToString();
                    _newRow.MoCarteraFinanciera = _row["MoCarteraFinanciera"].ToString();
                    _newRow.MoLibro = _row["MoLibro"].ToString();
                    _newRow.MoCarNormativa = _row["MoCarNormativa"].ToString();
                    _newRow.MoSubCarNormativa = _row["MoSubCarNormativa"].ToString();
                    if (MoRutCliente > 0 && MoRutCliente < 40000000)
                    { _newRow.MoTipoContrapartida = "Interna"; }
                    if (MoRutCliente > 40000000)
                    { _newRow.MoTipoContrapartida = "Normal"; }
                    _newRow.MoOperador = Usuario_;
                    _newRow.MoCodEstructura = _row["MoCodEstructura"].ToString();
                    _newRow.MoCVEstructura = _row["MoCVEstructura"].ToString();
                    _newRow.MoSistema = "OPT";
                    _newRow.MoGlosa = _row["MoGlosa"].ToString();
                    #endregion

                    #region "Carga datos Float"
                    _newRow.MoPrimaTrf = _row["MoPrimaTrf"] != "" && _row["MoPrimaTrf"].ToString() != "NaN" ? Double.Parse(_row["MoPrimaTrf"].ToString()) : 0;
                    _newRow.MoPrimaTrfML = _row["MoPrimaTrfML"] != "" && _row["MoPrimaTrfML"].ToString() != "NaN" ? Double.Parse(_row["MoPrimaTrfML"].ToString()) : 0;
                    _newRow.MoPrimaCosto = _row["MoPrimaCosto"] != "" && _row["MoPrimaCosto"].ToString() != "NaN" ? Double.Parse(_row["MoPrimaCosto"].ToString()) : 0;
                    _newRow.MoPrimaCostoML = _row["MoPrimaCostoML"] != "" && _row["MoPrimaCostoML"].ToString() != "NaN" ? Double.Parse(_row["MoPrimaCostoML"].ToString()) : 0;
                    _newRow.MoCarryPrima = _row["MoCarryPrima"] != "" && _row["MoCarryPrima"].ToString() != "NaN" ? Double.Parse(_row["MoCarryPrima"].ToString()) : 0;
                    _newRow.MoParM2Spot = _row["MoParM2Spot"] != "" && _row["MoParM2Spot"].ToString() != "NaN" ? Double.Parse(_row["MoParM2Spot"].ToString()) : 0;
                    _newRow.MoVr = _row["MoVr"] != "" && _row["MoVr"].ToString() != "NaN" ? Double.Parse(_row["MoVr"].ToString()) : 0;
                    _newRow.MoPrimaBSSpotCont = _row["MoPrimaBSSpotCont"] != "" && _row["MoPrimaBSSpotCont"].ToString() != "NaN" ? Double.Parse(_row["MoPrimaBSSpotCont"].ToString()) : 0;
                    _newRow.MoDeltaForwardCont = _row["MoDeltaForwardCont"] != "" && _row["MoDeltaForwardCont"].ToString() != "NaN" ? Double.Parse(_row["MoDeltaForwardCont"].ToString()) : 0;

                    _newRow.MoVegaCont = _row["MoVegaCont"] != "" && _row["MoVegaCont"].ToString() != "NaN" ? Double.Parse(_row["MoVegaCont"].ToString()) : 0;
                    _newRow.MoVolgaCont = _row["MoVolgaCont"] != "" && _row["MoVolgaCont"].ToString() != "NaN" ? Double.Parse(_row["MoVolgaCont"].ToString()) : 0;
                    _newRow.MoThetaCont = _row["MoThetaCont"] != "" && _row["MoThetaCont"].ToString() != "NaN" ? Double.Parse(_row["MoThetaCont"].ToString()) : 0;
                    _newRow.MoRhoDomCont = _row["MoRhoDomCont"] != "" && _row["MoRhoDomCont"].ToString() != "NaN" ? Double.Parse(_row["MoRhoDomCont"].ToString()) : 0;
                    _newRow.MoRhoForCont = _row["MoRhoForCont"] != "" && _row["MoRhoForCont"].ToString() != "NaN" ? Double.Parse(_row["MoRhoForCont"].ToString()) : 0;

                    // DMV 11 Diciembre del 2009, se corrige problema de grabación de prima
                    _newRow.MoPrimaInicial = _row["MoPrimaInicial"] != "" && _row["MoPrimaInicial"].ToString() != "NaN" ? Double.Parse(_row["MoPrimaInicial"].ToString()) : 0;
                    _newRow.MoPrimaInicialML = _row["MoPrimaInicialML"] != "" && _row["MoPrimaInicialML"].ToString() != "NaN" ? Double.Parse(_row["MoPrimaInicialML"].ToString()) : 0;
                    _newRow.MoParMdaPrima = _row["MoParMdaPrima"] != "" && _row["MoParMdaPrima"].ToString() != "NaN" ? Double.Parse(_row["MoParMdaPrima"].ToString()) : 0;
                    //5843
                    _newRow.MoResultadoVentasML = _row["MoResultadoVentasML"] != "" && _row["MoResultadoVentasML"].ToString() != "NaN" ? Double.Parse(_row["MoResultadoVentasML"].ToString()) : 0;

                    #endregion

                    #region "Carga datos Datetime"
                    _newRow.MoFechaContrato = _row["MoFechaContrato"] != "" ? DateTime.Parse(_row["MoFechaContrato"].ToString()) : DateTime.Parse("01010001");
                    _newRow.MoFechaPagoPrima = _row["MoFechaPagoPrima"] != "" ? DateTime.Parse(_row["MoFechaPagoPrima"].ToString()) : DateTime.Parse("01010001");
                    _newRow.MoFecValorizacion = _row["MoFecValorizacion"] != "" ? DateTime.Parse(_row["MoFecValorizacion"].ToString()) : DateTime.Parse("01010001");
                    _newRow.MoFechaCreacionRegistro = DateTime.Now;
                    //Prd_10968
                    _FechaContrato = _newRow.MoFechaContrato;
                    _FechaVencimiento = _newRow.MoFechaPagoPrima;
                    _Sistema = _newRow.MoSistema;
                    _RecUsuario = Usuario_;

                    #endregion

                    _DataContrato.MoEncContrato.Rows.Add(_newRow);

                    #endregion

                    #region "MoDetContrato"
                    if (_Datos.Tables["detContrato"] != null)
                    {
                        foreach (DataRow _rowD in _Datos.Tables["detContrato"].Rows)
                        {
                            try
                            {
                                //DataRow _rowD = _Datos.Tables["detContrato"].Rows[row_];
                                cData.Dataset.DataMovimiento.MoDetContratoRow _newRowD = _DataContrato.MoDetContrato.NewMoDetContratoRow();

                                #region "Carga datos Numeric"

                                _newRowD.MoNumFolio = MoNumFolio;
                                _newRowD.MoNumEstructura = _rowD["MoNumEstructura"] != "" ? Int64.Parse(_rowD["MoNumEstructura"].ToString()) : 0;
                                _newRowD.MoFormaPagoMon1 = _rowD["MoFormaPagoMon1"] != "" ? Int64.Parse(_rowD["MoFormaPagoMon1"].ToString()) : 0;
                                _newRowD.MoFormaPagoMon2 = _rowD["MoFormaPagoMon2"] != "" ? Int64.Parse(_rowD["MoFormaPagoMon2"].ToString()) : 0;
                                _newRowD.MoCodMon1 = _rowD["MoCodMon1"] != "" ? Int64.Parse(_rowD["MoCodMon1"].ToString()) : 0;
                                _newRowD.MoCodMon2 = _rowD["MoCodMon2"] != "" ? Int64.Parse(_rowD["MoCodMon2"].ToString()) : 0;
                                _newRowD.MoMdaCompensacion = _rowD["MoMdaCompensacion"] != "" ? Int64.Parse(_rowD["MoMdaCompensacion"].ToString()) : 0;
                                _newRowD.MoBenchComp = _rowD["MoBenchComp"] != "" ? Int64.Parse(_rowD["MoBenchComp"].ToString()) : 0;
                                _newRowD.MoPorcStrike = _rowD["MoPorcStrike"] != "" ? Int64.Parse(_rowD["MoPorcStrike"].ToString()) : 0;
                                _newRowD.MoIteAsoCon = _rowD["MoIteAsoCon"] != "" ? Int64.Parse(_rowD["MoIteAsoCon"].ToString()) : 0;
                                _newRowD.MoFormaPagoComp = _rowD["MoFormaPagoComp"] != "" ? Int64.Parse(_rowD["MoFormaPagoComp"].ToString()) : 0;

                                #endregion

                                #region "Carga datos Varchar"

                                _newRowD.MoVinculacion = _rowD["MoVinculacion"].ToString();
                                _newRowD.MoTipoOpc = _rowD["MoTipoOpc"].ToString();
                                _newRowD.MoSubyacente = _rowD["MoSubyacente"].ToString();
                                _newRowD.MoTipoPayOff = _rowD["MoTipoPayOff"].ToString();
                                _newRowD.MoCallPut = _rowD["MoCallPut"].ToString();
                                _newRowD.MoCVOpc = _rowD["MoCVOpc"].ToString();
                                _newRowD.MoCurveSmile = _rowD["MoCurveSmile"].ToString();
                                _newRowD.MoIteAsoSis = _rowD["MoIteAsoSis"].ToString();
                                _newRowD.MoTipoEmisionPT = _rowD["MoTipoEmisionPT"].ToString();
                                _newRowD.MoModalidad = _rowD["MoModalidad"].ToString();
                                _newRowD.MoParStrike = _rowD["MoParStrike"].ToString();
                                _newRowD.MoTipoEjercicio = _rowD["MoTipoEjercicio"].ToString();
                                _newRowD.MoCurveMon1 = _rowD["MoCurveMon1"].ToString();
                                _newRowD.MoCurveMon2 = _rowD["MoCurveMon2"].ToString();

                                #endregion

                                #region "Carga datos Float"

                                _newRowD.MoStrike = __ConvertDouble(_rowD["MoStrike"].ToString());
                                _newRowD.MoWf_mon1 = __ConvertDouble(_rowD["MoWf_mon1"].ToString());
                                _newRowD.MoWf_mon2 = __ConvertDouble(_rowD["MoWf_mon2"].ToString());
                                _newRowD.MoVol = __ConvertDouble(_rowD["MoVol"].ToString());
                                _newRowD.MoFwd_teo = __ConvertDouble(_rowD["MoFwd_teo"].ToString());
                                _newRowD.MoDelta_spot = __ConvertDouble(_rowD["MoDelta_spot"].ToString());
                                _newRowD.MoWf_Mon1_Costo = __ConvertDouble(_rowD["MoWf_Mon1_Costo"].ToString());
                                _newRowD.MoWf_Mon2_Costo = __ConvertDouble(_rowD["MoWf_Mon2_Costo"].ToString());
                                _newRowD.MoVol_Costo = __ConvertDouble(_rowD["MoVol_Costo"].ToString());
                                _newRowD.MoFwd_Teo_Costo = __ConvertDouble(_rowD["MoFwd_Teo_Costo"].ToString());
                                _newRowD.MoVr_CostoDet = __ConvertDouble(_rowD["MoVr_CostoDet"].ToString());
                                _newRowD.MoPrimaBSSpotDet = __ConvertDouble(_rowD["MoPrimaBSSpotDet"].ToString());
                                _newRowD.MoVrDet = __ConvertDouble(_rowD["MoVrDet"].ToString());
                                _newRowD.MoSpotDet = __ConvertDouble(_rowD["MoSpotDet"].ToString());
                                _newRowD.MoSpotDetCosto = __ConvertDouble(_rowD["MoSpotDetCosto"].ToString());
                                _newRowD.MoCharm_fwd_num = __ConvertDouble(_rowD["MoCharm_fwd_num"].ToString());
                                _newRowD.MoRho_num = __ConvertDouble(_rowD["MoRho_num"].ToString());
                                _newRowD.MoRhof = __ConvertDouble(_rowD["MoRhof"].ToString());
                                _newRowD.MoRhof_num = __ConvertDouble(_rowD["MoRhof_num"].ToString());
                                _newRowD.MoCharm_spot = __ConvertDouble(_rowD["MoCharm_spot"].ToString());
                                _newRowD.MoCharm_spot_num = __ConvertDouble(_rowD["MoCharm_spot_num"].ToString());
                                _newRowD.MoCharm_fwd = __ConvertDouble(_rowD["MoCharm_fwd"].ToString());
                                _newRowD.MoVanna_fwd_num = __ConvertDouble(_rowD["MoVanna_fwd_num"].ToString());
                                _newRowD.MoVolga = __ConvertDouble(_rowD["MoVolga"].ToString());
                                _newRowD.MoVolga_num = __ConvertDouble(_rowD["MoVolga_num"].ToString());
                                _newRowD.MoTheta = __ConvertDouble(_rowD["MoTheta"].ToString());
                                _newRowD.MoTheta_num = __ConvertDouble(_rowD["MoTheta_num"].ToString());
                                _newRowD.MoRho = __ConvertDouble(_rowD["MoRho"].ToString());
                                _newRowD.MoGamma_fwd_num = __ConvertDouble(_rowD["MoGamma_fwd_num"].ToString());
                                _newRowD.MoVega = __ConvertDouble(_rowD["MoVega"].ToString());
                                _newRowD.MoVega_num = __ConvertDouble(_rowD["MoVega_num"].ToString());
                                _newRowD.MoVanna_spot = __ConvertDouble(_rowD["MoVanna_spot"].ToString());
                                _newRowD.MoVanna_spot_num = __ConvertDouble(_rowD["MoVanna_spot_num"].ToString());
                                _newRowD.MoVanna_fwd = __ConvertDouble(_rowD["MoVanna_fwd"].ToString());
                                _newRowD.MoDelta_spot_num = __ConvertDouble(_rowD["MoDelta_spot_num"].ToString());
                                _newRowD.MoDelta_fwd = __ConvertDouble(_rowD["MoDelta_fwd"].ToString());
                                _newRowD.MoDelta_fwd_num = __ConvertDouble(_rowD["MoDelta_fwd_num"].ToString());
                                _newRowD.MoGamma_spot = __ConvertDouble(_rowD["MoGamma_spot"].ToString());
                                _newRowD.MoGamma_spot_num = __ConvertDouble(_rowD["MoGamma_spot_num"].ToString());
                                _newRowD.MoGamma_fwd = __ConvertDouble(_rowD["MoGamma_fwd"].ToString());

                                // MAP Pendiente verificar el modelo de Datos
                                _newRowD.MoMontoMon1 = __ConvertDecimal(_rowD["MoMontoMon1"].ToString());
                                _newRowD.MoMontoMon2 = __ConvertDecimal(_rowD["MoMontoMon2"].ToString());

                                #endregion

                                #region "Carga datos DateTime"

                                _newRowD.MoFechaInicioOpc = _rowD["MoFechaInicioOpc"] != "" ? DateTime.Parse(_rowD["MoFechaInicioOpc"].ToString()) : DateTime.Parse("01010001");
                                _newRowD.MoFechaFijacion = _rowD["MoFechaFijacion"] != "" ? DateTime.Parse(_rowD["MoFechaFijacion"].ToString()) : DateTime.Parse("01010001");
                                _newRowD.MoFechaVcto = _rowD["MoFechaVcto"] != "" ? DateTime.Parse(_rowD["MoFechaVcto"].ToString()) : DateTime.Parse("01010001");
                                _newRowD.MoFechaPagMon1 = _rowD["MoFechaPagMon1"] != "" ? DateTime.Parse(_rowD["MoFechaPagMon1"].ToString()) : DateTime.Parse("01010001");
                                _newRowD.MoFechaPagMon2 = _rowD["MoFechaPagMon2"] != "" ? DateTime.Parse(_rowD["MoFechaPagMon2"].ToString()) : DateTime.Parse("01010001");
                                _newRowD.MoFechaPagoEjer = _rowD["MoFechaPagoEjer"] != "" ? DateTime.Parse(_rowD["MoFechaPagoEjer"].ToString()) : DateTime.Parse("01010001");

                                #endregion

                                _DataContrato.MoDetContrato.Rows.Add(_newRowD);
                            }
                            catch (Exception e)
                            {
                                throw new Exception(e.Message);
                            }
                        }
                    }
                    #endregion

                    #region "MoFixing Datos por XML"

                    int cont_ = 0;
                    decimal _MoEstructura = 0;
                    cont_ = _Datos.Tables["FixingData"].Rows.Count;

                    foreach (cData.Dataset.DataMovimiento.MoDetContratoRow _DetRow in _DataContrato.MoDetContrato.Rows)
                    {
                        _MoEstructura = _DetRow.MoNumEstructura;

                        DataRow[] _DRFixings = _Datos.Tables["FixingData"].Select("MoNumEstructura = '" + _MoEstructura.ToString() + "'");

                        if (_DRFixings.Length > 0)
                        {
                            #region Multiples Fixing
                            foreach (DataRow _rowF in _DRFixings)
                            {
                                //DataRow _rowF = _Datos.Tables["FixingData"].Rows[rowx_];
                                cData.Dataset.DataMovimiento.MoFixingRow _newRowF = _DataContrato.MoFixing.NewMoFixingRow();

                                #region "Carga datos Numeric"
                                _newRowF.MoNumFolio = MoNumFolio;
                                _newRowF.MoNumEstructura = _MoEstructura;
                                _newRowF.MoFixNumero = _rowF["ID"] != "" ? Int64.Parse(_rowF["ID"].ToString()) : 0;
                                //_newRowF.MoFixBenchComp = _rowF["ixBenchComparacion"] != "" ? Int64.Parse(_rowF["ixBenchComparacion"].ToString()) : 0;
                                _newRowF.MoFixBenchComp = 994;
                                #endregion

                                #region "Carga datos Varchar"
                                _newRowF.MoFixParBench = "CLP/USD";
                                //_newRowF["MoFixEstado"] = _rowF["MoFixEstado"];
                                #endregion

                                #region "Carga datos Float"
                                _newRowF.MoFijacion = _rowF["Valor"] != "" && _rowF["Valor"].ToString() != "NaN" ? double.Parse(_rowF["Valor"].ToString()) : 0;
                                _newRowF.MoVolFij = _rowF["Volatilidad"] != "" && _rowF["Volatilidad"].ToString() != "NaN" ? double.Parse(_rowF["Volatilidad"].ToString()) : 0;
                                _newRowF.MoPesoFij = _rowF["Peso"] != "" && _rowF["Peso"].ToString() != "NaN" ? double.Parse(_rowF["Peso"].ToString()) : 0;
                                #endregion

                                #region "Carga datos DateTime"
                                _newRowF.MoFixFecha = _rowF["Fecha"] != "" ? DateTime.Parse(_rowF["Fecha"].ToString()) : DateTime.Parse("01010001");
                                #endregion

                                _DataContrato.MoFixing.Rows.Add(_newRowF);
                            }
                            #endregion
                        }
                        else
                        {
                            #region Single Fixing

                            MoTipoPayOff = _DetRow.MoTipoPayOff;
                            if (MoTipoPayOff == "01")
                            {
                                cData.Dataset.DataMovimiento.MoFixingRow _newRowF = _DataContrato.MoFixing.NewMoFixingRow();

                                #region "Carga datos Numeric"
                                _newRowF.MoNumFolio = MoNumFolio;
                                _newRowF.MoNumEstructura = _MoEstructura;
                                // MAP 18 Agosto _newRowF.MoFixNumero = row_;
                                // Numero de Fijación de estructuras vanilla
                                _newRowF.MoFixNumero = 1;
                                // Bench-Mark de La Fijación
                                //_newRowF.MoFixBenchComp = _DetRow["MoBenchComp"] != "" ? int.Parse(_DetRow["MoBenchComp"].ToString()) : 0;
                                _newRowF.MoFixBenchComp = 994;
                                #endregion

                                #region "Carga datos Varchar"
                                _newRowF.MoFixParBench = "CLP/USD";
                                _newRowF.MoFixEstado = "";
                                #endregion

                                #region "Carga datos Float"
                                _newRowF.MoFijacion = 0;
                                _newRowF.MoVolFij = 0;
                                _newRowF.MoPesoFij = 100;
                                #endregion

                                #region "Carga datos DateTime"
                                _newRowF.MoFixFecha = _DetRow.MoFechaFijacion;
                                #endregion

                                _DataContrato.MoFixing.Rows.Add(_newRowF);
                            }
                            #endregion
                        }
                    }
                    #endregion

                }
                #endregion

                #region "DataConecctionInterfaceGB"

                #region "Sección Actualización"
                dm_.TransactionBegin();
                int _filasEnc = _DataContrato.MoEncContrato.Rows.Count;
                if (_filasEnc > 0)
                {
                    int _result = dm_.Update(_DataContrato.MoEncContrato);
                    if (_filasEnc == _result)
                    {
                        _MoEncContrato = "True";
                        int _filasDet = _DataContrato.MoDetContrato.Rows.Count;
                        if (_filasDet > 0)
                        {
                            int result2_ = dm_.Update(_DataContrato.MoDetContrato);
                            if (_filasDet == result2_)
                            {
                                _MoDetContrato = "True";
                                int _filasFix = _DataContrato.MoFixing.Rows.Count;
                                if (_filasFix > 0)
                                {
                                    int result3_ = dm_.Update(_DataContrato.MoFixing);
                                    if (_filasFix == result3_)
                                    { _MoFixing = "True"; }
                                    else
                                    { _MoFixing = "False"; }
                                }
                            }
                            else
                            { _MoDetContrato = "False"; }
                        }
                    }
                    else
                    { _MoEncContrato = "False"; }
                }
                #endregion

                #region "Sección Grabación"
                string Tipo = "MoEnContrato=" + _MoEncContrato + " MoDetContrato=" + _MoDetContrato + " MoFixing=" + _MoFixing;
                DataTable _resultado = new DataTable();
                string _Status = "";
                switch (Tipo)
                {
                    case "MoEnContrato=True MoDetContrato=True MoFixing=True":
                        dm_.Update(_DataContrato.OpcionesGeneral);
                        dm_.TransactionCommit();
                        _resultado = ProcesoAppMvtCar(Convert.ToInt16(MoNumFolio));
                        if (_resultado != null)
                        {
                            DataRow _p = _resultado.Rows[0];
                            _Status = _p["Column1"].ToString();
                            _Result = _p["Column2"].ToString();
                        }
                        else
                        {
                            _Status = "ERROR";
                            _Result = "Sql ERROR GrabaContrato (AppMvtCar)";
                        }
                        if (_Status.ToUpper().Equals("SI"))
                        {
                            _Result += " .net OK";
                        }
                        break;
                    case "MoEnContrato=True MoDetContrato=True MoFixing=Nulo":
                        dm_.Update(_DataContrato.OpcionesGeneral);
                        dm_.TransactionCommit();
                        _resultado = ProcesoAppMvtCar(Convert.ToInt16(MoNumFolio));
                        if (_resultado != null)
                        {
                            DataRow _p = _resultado.Rows[0];
                            _Status = _p["Column1"].ToString();
                            _Result = _p["Column2"].ToString();
                        }
                        else
                        {
                            _Result = "Sql ERROR GrabaContrato (AppMvtCar Sin Fixing)";
                        }
                        _Result += " .net ERROR";
                        break;
                    case "MoEnContrato=True MoDetContrato=True MoFixing=False":
                        dm_.TransactionRollback();
                        _Result = "Error con Fila(s) en tabla MoFixing";
                        break;
                    case "MoEnContrato=True MoDetContrato=False MoFixing=Nulo":
                        dm_.TransactionRollback();
                        _Result = "Error con Fila(s) en tabla MoDetContrato";
                        break;
                    case "MoEnContrato=False MoDetContrato=Nulo MoFixing=Nulo":
                        dm_.TransactionRollback();
                        _Result = "Error con Fila(s) en tabla MoEnContrato";
                        break;
                }
                #endregion

                #endregion
            }
            catch (Exception eGrabaContrato)
            {
                dm_.TransactionRollback();
                _Result = "Error al grabar Contrato" + eGrabaContrato.ToString();
            }

            return _Result;
        }

        public static double __ConvertDouble(string value)
        {
            return value != "" && value.ToUpper() != "NAN" ? double.Parse(value) : 0;
        }

        public static decimal __ConvertDecimal(string value)
        {
            return value != "" && value.ToUpper() != "NAN" ? decimal.Parse(value) : 0;
        }

        public static String ModificaContrato(DataSet _Datos, string Usuario_, int _NumFolio, int _NumContrato)
        {
            #region "variables GrabaContrato"

            string _Result = string.Empty,
                    MoTipoPayOff = string.Empty;
            Int64 MoNumFolio = 0,
                    MoNumContrato = 0,
                    MoRutCliente = 0;
            string _MoEncContrato = "Nulo",
                    _MoDetContrato = "Nulo",
                    _MoFixing = "Nulo";

            Dataset.DataMovimiento _DataContrato = new Dataset.DataMovimiento();
            Manager.DataManagerSQL dm_ = new cData.Manager.DataManagerSQL("");
            #endregion

            try
            {

                #region "Genera MoNumFolio"
                dm_ = new cData.Manager.DataManagerSQL(ConnectString("Opciones"));
                dm_.Fill(_DataContrato.OpcionesGeneral);
                cData.Dataset.DataMovimiento.OpcionesGeneralRow _DatosOP = _DataContrato.OpcionesGeneral[0];

                MoNumFolio = Int64.Parse(_DatosOP.numero_Folio.ToString()) + 1;
                MoNumContrato = _NumContrato;

                _DatosOP.BeginEdit();
                _DatosOP.numero_Folio++;
                _DatosOP.EndEdit();

                #endregion

                #region "Carga Datos a DataSet de Grabación"

                if (_Datos.Tables.Count > 0)
                {
                    #region "MoEncContrato"
                    DataRow _row = _Datos.Tables["encContrato"].Rows[0];
                    cData.Dataset.DataMovimiento.MoEncContratoRow _newRow = _DataContrato.MoEncContrato.NewMoEncContratoRow();

                    #region "Carga datos Numeric"
                    _newRow.MoNumFolio = MoNumFolio;
                    _newRow.MoNumContrato = _NumContrato;
                    _newRow.MoRutCliente = _row["MoRutCliente"] != "" && _row["MoRutCliente"].ToString() != "NaN" ? Int64.Parse(_row["MoRutCliente"].ToString()) : 0;
                    MoRutCliente = _row["MoRutCliente"] != "" && _row["MoRutCliente"].ToString() != "NaN" ? Int64.Parse(_row["MoRutCliente"].ToString()) : 0;
                    _newRow.MoCodigo = _row["MoCodigo"] != "" && _row["MoCodigo"].ToString() != "NaN" ? Int64.Parse(_row["MoCodigo"].ToString()) : 0;
                    _newRow.MoMonPrimaTrf = _row["MoMonPrimaTrf"] != "" && _row["MoMonPrimaTrf"].ToString() != "NaN" ? Int64.Parse(_row["MoMonPrimaTrf"].ToString()) : 0;
                    _newRow.MoMonPrimaCosto = _row["MoMonPrimaCosto"] != "" && _row["MoMonPrimaCosto"].ToString() != "NaN" ? Int64.Parse(_row["MoMonPrimaCosto"].ToString()) : 0;
                    _newRow.MoCodMonPagPrima = _row["MoCodMonPagPrima"] != "" && _row["MoCodMonPagPrima"].ToString() != "NaN" ? Int64.Parse(_row["MoCodMonPagPrima"].ToString()) : 0;
                    _newRow.MofPagoPrima = _row["MofPagoPrima"] != "" && _row["MofPagoPrima"].ToString() != "NaN" ? Int64.Parse(_row["MofPagoPrima"].ToString()) : 0;
                    _newRow.MoMonCarryPrima = _row["MoMonCarryPrima"] != "" && _row["MoMonCarryPrima"].ToString() != "NaN" ? Int64.Parse(_row["MoMonCarryPrima"].ToString()) : 0;
                    _newRow.MoMon_vr = _row["MoMon_vr"] != "" && _row["MoMon_vr"].ToString() != "NaN" ? Int64.Parse(_row["MoMon_vr"].ToString()) : 0;
                    _newRow.MoMondelta = _row["MoMondelta"] != "" && _row["MoMondelta"].ToString() != "NaN" ? Int64.Parse(_row["MoMondelta"].ToString()) : 0;
                    _newRow.MoMon_gamma = _row["MoMon_gamma"] != "" && _row["MoMon_gamma"].ToString() != "NaN" ? Int64.Parse(_row["MoMon_gamma"].ToString()) : 0;
                    _newRow.MoMon_vega = _row["MoMon_vega"] != "" && _row["MoMon_vega"].ToString() != "NaN" ? Int64.Parse(_row["MoMon_vega"].ToString()) : 0;
                    _newRow.MoMon_vanna = _row["MoMon_vanna"] != "" && _row["MoMon_vanna"].ToString() != "NaN" ? Int64.Parse(_row["MoMon_vanna"].ToString()) : 0;
                    _newRow.MoMon_volga = _row["MoMon_volga"] != "" && _row["MoMon_volga"].ToString() != "NaN" ? Int64.Parse(_row["MoMon_volga"].ToString()) : 0;
                    _newRow.MoMon_theta = _row["MoMon_theta"] != "" && _row["MoMon_theta"].ToString() != "NaN" ? Int64.Parse(_row["MoMon_theta"].ToString()) : 0;
                    _newRow.MoMon_rho = _row["MoMon_rho"] != "" && _row["MoMon_rho"].ToString() != "NaN" ? Int64.Parse(_row["MoMon_rho"].ToString()) : 0;
                    _newRow.MoMon_rhof = _row["MoMon_rhof"] != "" && _row["MoMon_rhof"].ToString() != "NaN" ? Int64.Parse(_row["MoMon_rhof"].ToString()) : 0;
                    _newRow.MoMon_charm = _row["MoMon_charm"] != "" && _row["MoMon_charm"].ToString() != "NaN" ? Int64.Parse(_row["MoMon_charm"].ToString()) : 0;
                    _newRow.MoMon_zomma = _row["MoMon_zomma"] != "" && _row["MoMon_zomma"].ToString() != "NaN" ? Int64.Parse(_row["MoMon_zomma"].ToString()) : 0;
                    _newRow.MoMon_speed = _row["MoMon_speed"] != "" && _row["MoMon_speed"].ToString() != "NaN" ? Int64.Parse(_row["MoMon_speed"].ToString()) : 0;
                    //PRD_10449 ASVG_20111102
                    _newRow.MoRelacionaPAE = _row["MoRelacionaPAE"] != "" && _row["MoRelacionaPAE"].ToString() != "NaN" ? Int32.Parse(_row["MoRelacionaPAE"].ToString()) : 0;
                    #endregion

                    #region "Carga datos Varchar"
                    _newRow.MoTipoTransaccion = "MODIFICA";
                    _newRow.MoEstado = _row["MoEstado"].ToString();
                    _newRow.MoCarteraFinanciera = _row["MoCarteraFinanciera"].ToString();
                    _newRow.MoLibro = _row["MoLibro"].ToString();
                    _newRow.MoCarNormativa = _row["MoCarNormativa"].ToString();
                    _newRow.MoSubCarNormativa = _row["MoSubCarNormativa"].ToString();
                    if (MoRutCliente > 0 && MoRutCliente < 40000000)
                    { _newRow.MoTipoContrapartida = "Interna"; }
                    if (MoRutCliente > 40000000)
                    { _newRow.MoTipoContrapartida = "Normal"; }
                    _newRow.MoOperador = Usuario_;
                    _newRow.MoCodEstructura = _row["MoCodEstructura"].ToString();
                    _newRow.MoCVEstructura = _row["MoCVEstructura"].ToString();
                    _newRow.MoSistema = "OPT";
                    _newRow.MoGlosa = _row["MoGlosa"].ToString();
                    #endregion

                    #region "Carga datos Float"
                    _newRow.MoPrimaTrf = _row["MoPrimaTrf"] != "" && _row["MoPrimaTrf"].ToString() != "NaN" ? Double.Parse(_row["MoPrimaTrf"].ToString()) : 0;
                    _newRow.MoPrimaTrfML = _row["MoPrimaTrfML"] != "" && _row["MoPrimaTrfML"].ToString() != "NaN" ? Double.Parse(_row["MoPrimaTrfML"].ToString()) : 0;
                    _newRow.MoPrimaCosto = _row["MoPrimaCosto"] != "" && _row["MoPrimaCosto"].ToString() != "NaN" ? Double.Parse(_row["MoPrimaCosto"].ToString()) : 0;
                    _newRow.MoPrimaCostoML = _row["MoPrimaCostoML"] != "" && _row["MoPrimaCostoML"].ToString() != "NaN" ? Double.Parse(_row["MoPrimaCostoML"].ToString()) : 0;
                    _newRow.MoCarryPrima = _row["MoCarryPrima"] != "" && _row["MoCarryPrima"].ToString() != "NaN" ? Double.Parse(_row["MoCarryPrima"].ToString()) : 0;
                    _newRow.MoParM2Spot = _row["MoParM2Spot"] != "" && _row["MoParM2Spot"].ToString() != "NaN" ? Double.Parse(_row["MoParM2Spot"].ToString()) : 0;
                    _newRow.MoParMdaPrima = _row["MoParMdaPrima"] != "" && _row["MoParMdaPrima"].ToString() != "NaN" ? Double.Parse(_row["MoParMdaPrima"].ToString()) : 0;
                    _newRow.MoVr = _row["MoVr"] != "" && _row["MoVr"].ToString() != "NaN" ? Double.Parse(_row["MoVr"].ToString()) : 0;
                    _newRow.MoPrimaBSSpotCont = _row["MoPrimaBSSpotCont"] != "" && _row["MoPrimaBSSpotCont"].ToString() != "NaN" ? Double.Parse(_row["MoPrimaBSSpotCont"].ToString()) : 0;
                    _newRow.MoDeltaForwardCont = _row["MoDeltaForwardCont"] != "" && _row["MoDeltaForwardCont"].ToString() != "NaN" ? Double.Parse(_row["MoDeltaForwardCont"].ToString()) : 0;

                    _newRow.MoVegaCont = _row["MoVegaCont"] != "" && _row["MoVegaCont"].ToString() != "NaN" ? Double.Parse(_row["MoVegaCont"].ToString()) : 0;
                    _newRow.MoVolgaCont = _row["MoVolgaCont"] != "" && _row["MoVolgaCont"].ToString() != "NaN" ? Double.Parse(_row["MoVolgaCont"].ToString()) : 0;
                    _newRow.MoThetaCont = _row["MoThetaCont"] != "" && _row["MoThetaCont"].ToString() != "NaN" ? Double.Parse(_row["MoThetaCont"].ToString()) : 0;
                    _newRow.MoRhoDomCont = _row["MoRhoDomCont"] != "" && _row["MoRhoDomCont"].ToString() != "NaN" ? Double.Parse(_row["MoRhoDomCont"].ToString()) : 0;
                    _newRow.MoRhoForCont = _row["MoRhoForCont"] != "" && _row["MoRhoForCont"].ToString() != "NaN" ? Double.Parse(_row["MoRhoForCont"].ToString()) : 0;

                    // DMV 11 Diciembre del 2009, se corrige problema de grabación de prima
                    _newRow.MoPrimaInicial = _row["MoPrimaInicial"] != "" && _row["MoPrimaInicial"].ToString() != "NaN" ? Double.Parse(_row["MoPrimaInicial"].ToString()) : 0;
                    _newRow.MoPrimaInicialML = _row["MoPrimaInicialML"] != "" && _row["MoPrimaInicialML"].ToString() != "NaN" ? Double.Parse(_row["MoPrimaInicialML"].ToString()) : 0;
                    _newRow.MoParMdaPrima = _row["MoParMdaPrima"] != "" && _row["MoParMdaPrima"].ToString() != "NaN" ? Double.Parse(_row["MoParMdaPrima"].ToString()) : 0;
                    //5843
                    _newRow.MoResultadoVentasML = _row["MoResultadoVentasML"] != "" && _row["MoResultadoVentasML"].ToString() != "NaN" ? Double.Parse(_row["MoResultadoVentasML"].ToString()) : 0;

                    #endregion

                    #region "Carga datos Datetime"
                    _newRow.MoFechaContrato = _row["MoFechaContrato"] != "" ? DateTime.Parse(_row["MoFechaContrato"].ToString()) : DateTime.Parse("01010001");
                    _newRow.MoFechaPagoPrima = _row["MoFechaPagoPrima"] != "" ? DateTime.Parse(_row["MoFechaPagoPrima"].ToString()) : DateTime.Parse("01010001");
                    _newRow.MoFecValorizacion = _row["MoFecValorizacion"] != "" ? DateTime.Parse(_row["MoFecValorizacion"].ToString()) : DateTime.Parse("01010001");
                    _newRow.MoFechaCreacionRegistro = DateTime.Now;
                    #endregion

                    _DataContrato.MoEncContrato.Rows.Add(_newRow);

                    #endregion

                    #region "MoDetContrato"
                    if (_Datos.Tables["detContrato"] != null)
                    {
                        foreach (DataRow _rowD in _Datos.Tables["detContrato"].Rows)
                        {
                            //DataRow _rowD = _Datos.Tables["detContrato"].Rows[row_];
                            cData.Dataset.DataMovimiento.MoDetContratoRow _newRowD = _DataContrato.MoDetContrato.NewMoDetContratoRow();

                            #region "Carga datos Numeric"

                            _newRowD.MoNumFolio = MoNumFolio;
                            _newRowD.MoNumEstructura = _rowD["MoNumEstructura"] != "" ? Int64.Parse(_rowD["MoNumEstructura"].ToString()) : 0;
                            _newRowD.MoFormaPagoMon1 = _rowD["MoFormaPagoMon1"] != "" ? Int64.Parse(_rowD["MoFormaPagoMon1"].ToString()) : 0;
                            _newRowD.MoFormaPagoMon2 = _rowD["MoFormaPagoMon2"] != "" ? Int64.Parse(_rowD["MoFormaPagoMon2"].ToString()) : 0;
                            _newRowD.MoCodMon1 = _rowD["MoCodMon1"] != "" ? Int64.Parse(_rowD["MoCodMon1"].ToString()) : 0;
                            _newRowD.MoCodMon2 = _rowD["MoCodMon2"] != "" ? Int64.Parse(_rowD["MoCodMon2"].ToString()) : 0;
                            _newRowD.MoMdaCompensacion = _rowD["MoMdaCompensacion"] != "" ? Int64.Parse(_rowD["MoMdaCompensacion"].ToString()) : 0;
                            _newRowD.MoBenchComp = _rowD["MoBenchComp"] != "" ? Int64.Parse(_rowD["MoBenchComp"].ToString()) : 0;
                            _newRowD.MoPorcStrike = _rowD["MoPorcStrike"] != "" ? Int64.Parse(_rowD["MoPorcStrike"].ToString()) : 0;
                            _newRowD.MoIteAsoCon = _rowD["MoIteAsoCon"] != "" ? Int64.Parse(_rowD["MoIteAsoCon"].ToString()) : 0;
                            _newRowD.MoFormaPagoComp = _rowD["MoFormaPagoComp"] != "" ? Int64.Parse(_rowD["MoFormaPagoComp"].ToString()) : 0;

                            #endregion

                            #region "Carga datos Varchar"

                            _newRowD.MoVinculacion = _rowD["MoVinculacion"].ToString();
                            _newRowD.MoTipoOpc = _rowD["MoTipoOpc"].ToString();
                            _newRowD.MoSubyacente = _rowD["MoSubyacente"].ToString();
                            _newRowD.MoTipoPayOff = _rowD["MoTipoPayOff"].ToString();
                            _newRowD.MoCallPut = _rowD["MoCallPut"].ToString();
                            _newRowD.MoCVOpc = _rowD["MoCVOpc"].ToString();
                            _newRowD.MoCurveSmile = _rowD["MoCurveSmile"].ToString();
                            _newRowD.MoIteAsoSis = _rowD["MoIteAsoSis"].ToString();
                            _newRowD.MoTipoEmisionPT = _rowD["MoTipoEmisionPT"].ToString();
                            _newRowD.MoModalidad = _rowD["MoModalidad"].ToString();
                            _newRowD.MoParStrike = _rowD["MoParStrike"].ToString();
                            _newRowD.MoTipoEjercicio = _rowD["MoTipoEjercicio"].ToString();
                            _newRowD.MoCurveMon1 = _rowD["MoCurveMon1"].ToString();
                            _newRowD.MoCurveMon2 = _rowD["MoCurveMon2"].ToString();

                            #endregion

                            #region "Carga datos Float"

                            _newRowD.MoStrike = _rowD["MoStrike"] != "" && _rowD["MoStrike"].ToString() != "NaN" ? Double.Parse(_rowD["MoStrike"].ToString()) : 0;
                            _newRowD.MoWf_mon1 = _rowD["MoWf_mon1"] != "" && _rowD["MoWf_mon1"].ToString() != "NaN" ? Double.Parse(_rowD["MoWf_mon1"].ToString()) : 0;
                            _newRowD.MoWf_mon2 = _rowD["MoWf_mon2"] != "" && _rowD["MoWf_mon2"].ToString() != "NaN" ? Double.Parse(_rowD["MoWf_mon2"].ToString()) : 0;
                            _newRowD.MoVol = _rowD["MoVol"] != "" && _rowD["MoVol"].ToString() != "NaN" ? Double.Parse(_rowD["MoVol"].ToString()) : 0;
                            _newRowD.MoFwd_teo = _rowD["MoFwd_teo"] != "" && _rowD["MoFwd_teo"].ToString() != "NaN" ? Double.Parse(_rowD["MoFwd_teo"].ToString()) : 0;
                            _newRowD.MoDelta_spot = _rowD["MoDelta_spot"] != "" && _rowD["MoDelta_spot"].ToString() != "NaN" ? Double.Parse(_rowD["MoDelta_spot"].ToString()) : 0;
                            _newRowD.MoWf_Mon1_Costo = _rowD["MoWf_Mon1_Costo"] != "" && _rowD["MoWf_Mon1_Costo"].ToString() != "NaN" ? Double.Parse(_rowD["MoWf_Mon1_Costo"].ToString()) : 0;
                            _newRowD.MoWf_Mon2_Costo = _rowD["MoWf_Mon2_Costo"] != "" && _rowD["MoWf_Mon2_Costo"].ToString() != "NaN" ? Double.Parse(_rowD["MoWf_Mon2_Costo"].ToString()) : 0;
                            _newRowD.MoVol_Costo = _rowD["MoVol_Costo"] != "" && _rowD["MoVol_Costo"].ToString() != "NaN" ? Double.Parse(_rowD["MoVol_Costo"].ToString()) : 0;
                            _newRowD.MoFwd_Teo_Costo = _rowD["MoFwd_Teo_Costo"] != "" && _rowD["MoFwd_Teo_Costo"].ToString() != "NaN" ? Double.Parse(_rowD["MoFwd_Teo_Costo"].ToString()) : 0;
                            _newRowD.MoVr_CostoDet = _rowD["MoVr_CostoDet"] != "" && _rowD["MoVr_CostoDet"].ToString() != "NaN" ? Double.Parse(_rowD["MoVr_CostoDet"].ToString()) : 0;
                            _newRowD.MoPrimaBSSpotDet = _rowD["MoPrimaBSSpotDet"] != "" && _rowD["MoPrimaBSSpotDet"].ToString() != "NaN" ? Double.Parse(_rowD["MoPrimaBSSpotDet"].ToString()) : 0;
                            _newRowD.MoVrDet = _rowD["MoVrDet"] != "" && _rowD["MoVrDet"].ToString() != "NaN" ? Double.Parse(_rowD["MoVrDet"].ToString()) : 0;
                            _newRowD.MoSpotDet = _rowD["MoSpotDet"] != "" && _rowD["MoSpotDet"].ToString() != "NaN" ? Double.Parse(_rowD["MoSpotDet"].ToString()) : 0;
                            _newRowD.MoSpotDetCosto = _rowD["MoSpotDetCosto"] != "" && _rowD["MoSpotDetCosto"].ToString() != "NaN" ? Double.Parse(_rowD["MoSpotDetCosto"].ToString()) : 0;
                            _newRowD.MoCharm_fwd_num = _rowD["MoCharm_fwd_num"] != "" && _rowD["MoCharm_fwd_num"].ToString() != "NaN" ? Double.Parse(_rowD["MoCharm_fwd_num"].ToString()) : 0;
                            _newRowD.MoRho_num = _rowD["MoRho_num"] != "" && _rowD["MoRho_num"].ToString() != "NaN" ? Double.Parse(_rowD["MoRho_num"].ToString()) : 0;
                            _newRowD.MoRhof = _rowD["MoRhof"] != "" && _rowD["MoRhof"].ToString() != "NaN" ? Double.Parse(_rowD["MoRhof"].ToString()) : 0;
                            _newRowD.MoRhof_num = _rowD["MoRhof_num"] != "" && _rowD["MoRhof_num"].ToString() != "NaN" ? Double.Parse(_rowD["MoRhof_num"].ToString()) : 0;
                            _newRowD.MoCharm_spot = _rowD["MoCharm_spot"] != "" && _rowD["MoCharm_spot"].ToString() != "NaN" ? Double.Parse(_rowD["MoCharm_spot"].ToString()) : 0;
                            _newRowD.MoCharm_spot_num = _rowD["MoCharm_spot_num"] != "" && _rowD["MoCharm_spot_num"].ToString() != "NaN" ? Double.Parse(_rowD["MoCharm_spot_num"].ToString()) : 0;
                            _newRowD.MoCharm_fwd = _rowD["MoCharm_fwd"] != "" && _rowD["MoCharm_fwd"].ToString() != "NaN" ? Double.Parse(_rowD["MoCharm_fwd"].ToString()) : 0;
                            _newRowD.MoVanna_fwd_num = _rowD["MoVanna_fwd_num"] != "" && _rowD["MoVanna_fwd_num"].ToString() != "NaN" ? Double.Parse(_rowD["MoVanna_fwd_num"].ToString()) : 0;
                            _newRowD.MoVolga = _rowD["MoVolga"] != "" && _rowD["MoVolga"].ToString() != "NaN" ? Double.Parse(_rowD["MoVolga"].ToString()) : 0;
                            _newRowD.MoVolga_num = _rowD["MoVolga_num"] != "" && _rowD["MoVolga_num"].ToString() != "NaN" ? Double.Parse(_rowD["MoVolga_num"].ToString()) : 0;
                            _newRowD.MoTheta = _rowD["MoTheta"] != "" && _rowD["MoTheta"].ToString() != "NaN" ? Double.Parse(_rowD["MoTheta"].ToString()) : 0;
                            _newRowD.MoTheta_num = _rowD["MoTheta_num"] != "" && _rowD["MoTheta_num"].ToString() != "NaN" ? Double.Parse(_rowD["MoTheta_num"].ToString()) : 0;
                            _newRowD.MoRho = _rowD["MoRho"] != "" && _rowD["MoRho"].ToString() != "NaN" ? Double.Parse(_rowD["MoRho"].ToString()) : 0;
                            _newRowD.MoGamma_fwd_num = _rowD["MoGamma_fwd_num"] != "" && _rowD["MoGamma_fwd_num"].ToString() != "NaN" ? Double.Parse(_rowD["MoGamma_fwd_num"].ToString()) : 0;
                            _newRowD.MoVega = _rowD["MoVega"] != "" && _rowD["MoVega"].ToString() != "NaN" ? Double.Parse(_rowD["MoVega"].ToString()) : 0;
                            _newRowD.MoVega_num = _rowD["MoVega_num"] != "" && _rowD["MoVega_num"].ToString() != "NaN" ? Double.Parse(_rowD["MoVega_num"].ToString()) : 0;
                            _newRowD.MoVanna_spot = _rowD["MoVanna_spot"] != "" && _rowD["MoVanna_spot"].ToString() != "NaN" ? Double.Parse(_rowD["MoVanna_spot"].ToString()) : 0;
                            _newRowD.MoVanna_spot_num = _rowD["MoVanna_spot_num"] != "" && _rowD["MoVanna_spot_num"].ToString() != "NaN" ? Double.Parse(_rowD["MoVanna_spot_num"].ToString()) : 0;
                            _newRowD.MoVanna_fwd = _rowD["MoVanna_fwd"] != "" && _rowD["MoVanna_fwd"].ToString() != "NaN" ? Double.Parse(_rowD["MoVanna_fwd"].ToString()) : 0;
                            _newRowD.MoDelta_spot_num = _rowD["MoDelta_spot_num"] != "" && _rowD["MoDelta_spot_num"].ToString() != "NaN" ? Double.Parse(_rowD["MoDelta_spot_num"].ToString()) : 0;
                            _newRowD.MoDelta_fwd = _rowD["MoDelta_fwd"] != "" && _rowD["MoDelta_fwd"].ToString() != "NaN" ? Double.Parse(_rowD["MoDelta_fwd"].ToString()) : 0;
                            _newRowD.MoDelta_fwd_num = _rowD["MoDelta_fwd_num"] != "" && _rowD["MoDelta_fwd_num"].ToString() != "NaN" ? Double.Parse(_rowD["MoDelta_fwd_num"].ToString()) : 0;
                            _newRowD.MoGamma_spot = _rowD["MoGamma_spot"] != "" && _rowD["MoGamma_spot"].ToString() != "NaN" ? Double.Parse(_rowD["MoGamma_spot"].ToString()) : 0;
                            _newRowD.MoGamma_spot_num = _rowD["MoGamma_spot_num"] != "" && _rowD["MoGamma_spot_num"].ToString() != "NaN" ? Double.Parse(_rowD["MoGamma_spot_num"].ToString()) : 0;
                            _newRowD.MoGamma_fwd = _rowD["MoGamma_fwd"] != "" && _rowD["MoGamma_fwd"].ToString() != "NaN" ? Double.Parse(_rowD["MoGamma_fwd"].ToString()) : 0;

                            // MAP Pendiente verificar el modelo de Datos
                            _newRowD.MoMontoMon1 = _rowD["MoMontoMon1"] != "" && _rowD["MoMontoMon1"].ToString() != "NaN" ? decimal.Parse(_rowD["MoMontoMon1"].ToString()) : 0;
                            _newRowD.MoMontoMon2 = _rowD["MoMontoMon2"] != "" && _rowD["MoMontoMon2"].ToString() != "NaN" ? decimal.Parse(_rowD["MoMontoMon2"].ToString()) : 0;

                            #endregion

                            #region "Carga datos DateTime"

                            _newRowD.MoFechaInicioOpc = _rowD["MoFechaInicioOpc"] != "" ? DateTime.Parse(_rowD["MoFechaInicioOpc"].ToString()) : DateTime.Parse("01010001");
                            _newRowD.MoFechaFijacion = _rowD["MoFechaFijacion"] != "" ? DateTime.Parse(_rowD["MoFechaFijacion"].ToString()) : DateTime.Parse("01010001");
                            _newRowD.MoFechaVcto = _rowD["MoFechaVcto"] != "" ? DateTime.Parse(_rowD["MoFechaVcto"].ToString()) : DateTime.Parse("01010001");
                            _newRowD.MoFechaPagMon1 = _rowD["MoFechaPagMon1"] != "" ? DateTime.Parse(_rowD["MoFechaPagMon1"].ToString()) : DateTime.Parse("01010001");
                            _newRowD.MoFechaPagMon2 = _rowD["MoFechaPagMon2"] != "" ? DateTime.Parse(_rowD["MoFechaPagMon2"].ToString()) : DateTime.Parse("01010001");
                            _newRowD.MoFechaPagoEjer = _rowD["MoFechaPagoEjer"] != "" ? DateTime.Parse(_rowD["MoFechaPagoEjer"].ToString()) : DateTime.Parse("01010001");

                            #endregion

                            _DataContrato.MoDetContrato.Rows.Add(_newRowD);
                        }
                    }
                    #endregion

                    #region "MoFixing Datos por XML"

                    int cont_ = 0;
                    decimal _MoEstructura = 0;
                    cont_ = _Datos.Tables["FixingData"].Rows.Count;

                    foreach (cData.Dataset.DataMovimiento.MoDetContratoRow _DetRow in _DataContrato.MoDetContrato.Rows)
                    {
                        _MoEstructura = _DetRow.MoNumEstructura;

                        DataRow[] _DRFixings = _Datos.Tables["FixingData"].Select("MoNumEstructura = " + _MoEstructura.ToString());

                        if (_DRFixings.Length > 0)
                        {
                            #region Multiples Fixing
                            foreach (DataRow _rowF in _DRFixings)
                            {
                                //DataRow _rowF = _Datos.Tables["FixingData"].Rows[rowx_];
                                cData.Dataset.DataMovimiento.MoFixingRow _newRowF = _DataContrato.MoFixing.NewMoFixingRow();

                                #region "Carga datos Numeric"
                                _newRowF.MoNumFolio = MoNumFolio;
                                _newRowF.MoNumEstructura = _MoEstructura;
                                _newRowF.MoFixNumero = _rowF["ID"] != "" ? Int64.Parse(_rowF["ID"].ToString()) : 0;
                                //_newRowF.MoFixBenchComp = _rowF["ixBenchComparacion"] != "" ? Int64.Parse(_rowF["ixBenchComparacion"].ToString()) : 0;
                                _newRowF.MoFixBenchComp = 994;
                                #endregion

                                #region "Carga datos Varchar"
                                _newRowF.MoFixParBench = "CLP/USD";
                                //_newRowF["MoFixEstado"] = _rowF["MoFixEstado"];
                                #endregion

                                #region "Carga datos Float"
                                _newRowF.MoFijacion = _rowF["Valor"] != "" && _rowF["Valor"].ToString() != "NaN" ? float.Parse(_rowF["Valor"].ToString()) : 0;
                                _newRowF.MoVolFij = _rowF["Volatilidad"] != "" && _rowF["Volatilidad"].ToString() != "NaN" ? float.Parse(_rowF["Volatilidad"].ToString()) : 0;
                                _newRowF.MoPesoFij = _rowF["Peso"] != "" && _rowF["Peso"].ToString() != "NaN" ? float.Parse(_rowF["Peso"].ToString()) : 0;
                                #endregion

                                #region "Carga datos DateTime"
                                _newRowF.MoFixFecha = _rowF["Fecha"] != "" ? DateTime.Parse(_rowF["Fecha"].ToString()) : DateTime.Parse("01010001");
                                #endregion

                                _DataContrato.MoFixing.Rows.Add(_newRowF);
                            }
                            #endregion
                        }
                        else
                        {
                            #region Single Fixing

                            MoTipoPayOff = _DetRow.MoTipoPayOff;
                            if (MoTipoPayOff == "01")
                            {
                                cData.Dataset.DataMovimiento.MoFixingRow _newRowF = _DataContrato.MoFixing.NewMoFixingRow();

                                #region "Carga datos Numeric"
                                _newRowF.MoNumFolio = MoNumFolio;
                                _newRowF.MoNumEstructura = _MoEstructura;
                                // MAP 18 Agosto _newRowF.MoFixNumero = row_;
                                // Numero de Fijación de estructuras vanilla
                                _newRowF.MoFixNumero = 1;
                                // Bench-Mark de La Fijación
                                //_newRowF.MoFixBenchComp = _DetRow["MoBenchComp"] != "" ? int.Parse(_DetRow["MoBenchComp"].ToString()) : 0;
                                _newRowF.MoFixBenchComp = 994;
                                #endregion

                                #region "Carga datos Varchar"
                                _newRowF.MoFixParBench = "CLP/USD";
                                _newRowF.MoFixEstado = "";
                                #endregion

                                #region "Carga datos Float"
                                _newRowF.MoFijacion = 0;
                                _newRowF.MoVolFij = 0;
                                _newRowF.MoPesoFij = 100;
                                #endregion

                                #region "Carga datos DateTime"
                                _newRowF.MoFixFecha = _DetRow.MoFechaFijacion;
                                #endregion

                                _DataContrato.MoFixing.Rows.Add(_newRowF);
                            }
                            #endregion
                        }
                    }
                    #endregion

                }
                #endregion

                #region "DataConecctionInterfaceGB"

                #region "Sección Actualización"
                dm_.TransactionBegin();
                int _filasEnc = _DataContrato.MoEncContrato.Rows.Count;
                if (_filasEnc > 0)
                {
                    int _result = dm_.Update(_DataContrato.MoEncContrato);
                    if (_filasEnc == _result)
                    {
                        _MoEncContrato = "True";
                        int _filasDet = _DataContrato.MoDetContrato.Rows.Count;
                        if (_filasDet > 0)
                        {
                            int result2_ = dm_.Update(_DataContrato.MoDetContrato);
                            if (_filasDet == result2_)
                            {
                                _MoDetContrato = "True";
                                int _filasFix = _DataContrato.MoFixing.Rows.Count;
                                if (_filasFix > 0)
                                {
                                    int result3_ = dm_.Update(_DataContrato.MoFixing);
                                    if (_filasFix == result3_)
                                    { _MoFixing = "True"; }
                                    else
                                    { _MoFixing = "False"; }
                                }
                            }
                            else
                            { _MoDetContrato = "False"; }
                        }
                    }
                    else
                    { _MoEncContrato = "False"; }
                }
                #endregion

                #region "Sección Grabación"
                string Tipo = "MoEnContrato=" + _MoEncContrato + " MoDetContrato=" + _MoDetContrato + " MoFixing=" + _MoFixing;
                DataTable _resultado = new DataTable();
                string _Status = "";
                switch (Tipo)
                {
                    case "MoEnContrato=True MoDetContrato=True MoFixing=True":
                        dm_.Update(_DataContrato.OpcionesGeneral);
                        dm_.TransactionCommit();
                        _resultado = ProcesoAppMvtCar(Convert.ToInt16(MoNumFolio));
                        if (_resultado != null)
                        {
                            DataRow _p = _resultado.Rows[0];
                            _Status = _p["Column1"].ToString();
                            _Result = _p["Column2"].ToString();
                        }
                        else
                        {
                            _Status = "ERROR";
                            _Result = "Sql ERROR ModificaContrato (AppMvtCar)";
                        }
                        if (_Status.ToUpper().Equals("SI"))
                        {
                            _Result += " .net OK";
                        }
                        break;
                    case "MoEnContrato=True MoDetContrato=True MoFixing=Nulo":
                        dm_.Update(_DataContrato.OpcionesGeneral);
                        dm_.TransactionCommit();
                        _resultado = ProcesoAppMvtCar(Convert.ToInt16(MoNumFolio));
                        if (_resultado != null)
                        {
                            DataRow _p = _resultado.Rows[0];
                            _Status = _p["Column1"].ToString();
                            _Result = _p["Column2"].ToString();
                        }
                        else
                        {
                            _Result = "Sql ERROR ModificaContrato (AppMvtCar Sin Fixing)";
                        }
                        _Result += " .net ERROR";
                        break;
                    case "MoEnContrato=True MoDetContrato=True MoFixing=False":
                        dm_.TransactionRollback();
                        _Result = "Error con Fila(s) en tabla MoFixing";
                        break;
                    case "MoEnContrato=True MoDetContrato=False MoFixing=Nulo":
                        dm_.TransactionRollback();
                        _Result = "Error con Fila(s) en tabla MoDetContrato";
                        break;
                    case "MoEnContrato=False MoDetContrato=Nulo MoFixing=Nulo":
                        dm_.TransactionRollback();
                        _Result = "Error con Fila(s) en tabla MoEnContrato";
                        break;
                }
                #endregion

                #endregion
            }
            catch (Exception _Error)
            {
                dm_.TransactionRollback();
                _Result = _Error.Message;
                _Result = "Error al grabar Modificación de Contrato";
            }

            return _Result;
        }

        public static String AnulaAnticipaContrato(DataSet _Datos, string Usuario_, int _NumFolio, int _NumContrato, string Estado)
        {
            #region "variables ModificaContrato"

            string _Result = string.Empty,
                    MoTipoPayOff = string.Empty;
            Int64 MoNumFolio = 0,
                    MoNumContrato = 0,
                    MoRutCliente = 0;
            string _MoEncContrato = "Nulo",
                    _MoDetContrato = "Nulo",
                    _MoFixing = "Nulo";

            Dataset.DataMovimiento _DataContrato = new Dataset.DataMovimiento();
            Dataset.DataCartera _DataCartera = new Dataset.DataCartera();
            Manager.DataManagerSQL dm_ = new cData.Manager.DataManagerSQL("");
            #endregion

            try
            {

                #region "Genera MoNumFolio"
                dm_ = new cData.Manager.DataManagerSQL(ConnectString("Opciones"));
                dm_.Fill(_DataContrato.OpcionesGeneral);
                cData.Dataset.DataMovimiento.OpcionesGeneralRow _DatosOP = _DataContrato.OpcionesGeneral[0];

                MoNumFolio = Int64.Parse(_DatosOP.numero_Folio.ToString()) + 1;

                _DatosOP.BeginEdit();
                _DatosOP.numero_Folio++;
                _DatosOP.EndEdit();

                #endregion

                #region "Carga Datos a DataSet de Grabación"

                if (_Datos.Tables.Count > 0)
                {
                    //Listo
                    #region "MoEncContrato"
                    DataRow _row = _Datos.Tables["encContrato"].Rows[0];
                    cData.Dataset.DataMovimiento.MoEncContratoRow _newRow = _DataContrato.MoEncContrato.NewMoEncContratoRow();

                    _newRow.MoNumFolio = MoNumFolio;
                    MoNumContrato = _NumContrato;

                    _DataCartera = TraeContrato(Convert.ToInt16(MoNumContrato), _NumFolio);
                    if (_DataCartera != null)
                    {
                        if (_DataCartera.CaEncContrato.Rows.Count > 0)
                        {
                            cData.Dataset.DataCartera.CaEncContratoRow _rowCaEncCon = _DataCartera.CaEncContrato[0];

                            #region "Carga datos Numeric"

                            _newRow.MoNumContrato = MoNumContrato;
                            _newRow.MoRutCliente = _row["MoRutCliente"] != "" ? Int64.Parse(_row["MoRutCliente"].ToString()) : _rowCaEncCon.CaRutCliente;
                            MoRutCliente = _row["MoRutCliente"] != "" ? Int64.Parse(_row["MoRutCliente"].ToString()) : Convert.ToInt64(_rowCaEncCon.CaRutCliente);
                            _newRow.MoCodigo = _row["MoCodigo"] != "" ? Int64.Parse(_row["MoCodigo"].ToString()) : _rowCaEncCon.CaCodigo;
                            _newRow.MoMonPrimaTrf = _row["MoMonPrimaTrf"] != "" ? Int64.Parse(_row["MoMonPrimaTrf"].ToString()) : _rowCaEncCon.CaMonPrimaTrf;
                            _newRow.MoMonPrimaCosto = _row["MoMonPrimaCosto"] != "" ? Int64.Parse(_row["MoMonPrimaCosto"].ToString()) : _rowCaEncCon.CaMonPrimaCosto;
                            _newRow.MoCodMonPagPrima = _row["MoCodMonPagPrima"] != "" ? Int64.Parse(_row["MoCodMonPagPrima"].ToString()) : _rowCaEncCon.CaCodMonPagPrima;
                            _newRow.MofPagoPrima = _row["MofPagoPrima"] != "" ? Int64.Parse(_row["MofPagoPrima"].ToString()) : _rowCaEncCon.CafPagoPrima;
                            _newRow.MoMonCarryPrima = _row["MoMonCarryPrima"] != "" ? Int64.Parse(_row["MoMonCarryPrima"].ToString()) : _rowCaEncCon.CaMonCarryPrima;
                            _newRow.MoMon_vr = _row["MoMon_vr"] != "" ? Int64.Parse(_row["MoMon_vr"].ToString()) : _rowCaEncCon.CaMon_vr;
                            _newRow.MoMondelta = _row["MoMondelta"] != "" ? Int64.Parse(_row["MoMondelta"].ToString()) : _rowCaEncCon.CaMondelta;
                            _newRow.MoMon_gamma = _row["MoMon_gamma"] != "" ? Int64.Parse(_row["MoMon_gamma"].ToString()) : _rowCaEncCon.CaMon_gamma;
                            _newRow.MoMon_vega = _row["MoMon_vega"] != "" ? Int64.Parse(_row["MoMon_vega"].ToString()) : _rowCaEncCon.CaMon_vega;
                            _newRow.MoMon_vanna = _row["MoMon_vanna"] != "" ? Int64.Parse(_row["MoMon_vanna"].ToString()) : _rowCaEncCon.CaMon_vanna;
                            _newRow.MoMon_volga = _row["MoMon_volga"] != "" ? Int64.Parse(_row["MoMon_volga"].ToString()) : _rowCaEncCon.CaMon_volga;
                            _newRow.MoMon_theta = _row["MoMon_theta"] != "" ? Int64.Parse(_row["MoMon_theta"].ToString()) : _rowCaEncCon.CaMon_theta;
                            _newRow.MoMon_rho = _row["MoMon_rho"] != "" ? Int64.Parse(_row["MoMon_rho"].ToString()) : _rowCaEncCon.CaMon_rho;
                            _newRow.MoMon_rhof = _row["MoMon_rhof"] != "" ? Int64.Parse(_row["MoMon_rhof"].ToString()) : _rowCaEncCon.CaMon_rhof;
                            _newRow.MoMon_charm = _row["MoMon_charm"] != "" ? Int64.Parse(_row["MoMon_charm"].ToString()) : _rowCaEncCon.CaMon_charm;
                            _newRow.MoMon_zomma = _row["MoMon_zomma"] != "" ? Int64.Parse(_row["MoMon_zomma"].ToString()) : _rowCaEncCon.CaMon_zomma;
                            _newRow.MoMon_speed = _row["MoMon_speed"] != "" ? Int64.Parse(_row["MoMon_speed"].ToString()) : _rowCaEncCon.CaMon_speed;
                            // DMV (20/10/2009), esto se debe por un problema con los Butterfly
                            _newRow.MoNominalUnwind = 0; // _row["MoVr"] != "" ? Decimal.Parse(_row["MoVr"].ToString()) : _rowCaEncCon.CaNominalUnwind;
                            _newRow.MoUnwindMon = 999; //_row["MoMon_vr"] != "" ? Int64.Parse(_row["MoMon_vr"].ToString()) : _rowCaEncCon.CaUnwindMon;

                            try
                            {
                                _newRow.MoUnwind = _row["MoUnwind"] != "" ? Decimal.Parse(_row["MoUnwind"].ToString()) : _rowCaEncCon.CaUnwind;
                            }
                            catch
                            {
                                _newRow.MoUnwind = 0;
                            }

                            try
                            {
                                _newRow.MoUnwindML = _row["MoUnwind"] != "" ? Decimal.Parse(_row["MoUnwind"].ToString()) : _rowCaEncCon.CaUnwindML;
                            }
                            catch
                            {
                                _newRow.MoUnwindML = 0;
                            }

                            _newRow.MoFormPagoUnwind = _row["MoFormPagoUnwind"] != "" ? Decimal.Parse(_row["MoFormPagoUnwind"].ToString()) : _rowCaEncCon.CaFormPagoUnwind;
                            _newRow.MoUnwindTransfMon = _rowCaEncCon.CaUnwindTransfMon;
                            _newRow.MoUnwindTransf = _rowCaEncCon.CaUnwindTransf;
                            _newRow.MoUnwindTransfML = _rowCaEncCon.CaUnwindTransfML;
                            _newRow.MoUnwindCostoMon = _newRow.MoUnwindMon;
                            //PRD_10449 ASVG_20111102
                            _newRow.MoRelacionaPAE = _row["MoRelacionaPAE"] != "" && _row["MoRelacionaPAE"].ToString() != "NaN" ? Int32.Parse(_row["MoRelacionaPAE"].ToString()) : 0;

                            try
                            {
                                _newRow.MoUnwindCosto = _row["MoUnwindCosto"] != "" ? Decimal.Parse(_row["MoUnwindCosto"].ToString()) : _rowCaEncCon.CaUnwindCosto;
                            }
                            catch
                            {
                                _newRow.MoUnwindCosto = 0;
                            }

                            try
                            {
                                _newRow.MoUnwindCostoML = _row["MoUnwindCosto"] != "" ? Decimal.Parse(_row["MoUnwindCosto"].ToString()) : _rowCaEncCon.CaUnwindCostoML;
                            }
                            catch
                            {
                                _newRow.MoUnwindCostoML = 0;
                            }

                            #endregion

                            #region "Carga datos Varchar"
                            if (Estado == "U")
                            {
                                _newRow.MoTipoTransaccion = "ANULA";
                            }
                            else
                            {
                                _newRow.MoTipoTransaccion = "ANTICIPA";
                            }

                            _newRow.MoEstado = _row["MoEstado"].ToString();
                            _newRow.MoCarteraFinanciera = _row["MoCarteraFinanciera"].ToString();
                            _newRow.MoLibro = _row["MoLibro"].ToString();
                            _newRow.MoCarNormativa = _row["MoCarNormativa"].ToString();
                            _newRow.MoSubCarNormativa = _row["MoSubCarNormativa"].ToString();

                            if (MoRutCliente > 0 && MoRutCliente < 40000000)
                            {
                                _newRow.MoTipoContrapartida = "Interna";
                            }
                            else if (MoRutCliente > 40000000)
                            {
                                _newRow.MoTipoContrapartida = "Normal";
                            }

                            _newRow.MoOperador = Usuario_;
                            _newRow.MoCodEstructura = _row["MoCodEstructura"].ToString();
                            _newRow.MoCVEstructura = _row["MoCVEstructura"].ToString();
                            _newRow.MoSistema = "OPT";
                            _newRow.MoGlosa = _row["MoGlosa"].ToString();
                            #endregion

                            #region "Carga datos Float"
                            // MAP 01 Septiembre 39 Pto. Planilla Corrige x NaN
                            _newRow.MoPrimaTrf = _row["MoPrimaTrf"] != "" && _row["MoPrimaTrf"].ToString() != "NaN" ? Double.Parse(_row["MoPrimaTrf"].ToString()) : 0;
                            _newRow.MoPrimaTrfML = _row["MoPrimaTrfML"] != "" && _row["MoPrimaTrfML"].ToString() != "NaN" ? Double.Parse(_row["MoPrimaTrfML"].ToString()) : 0;
                            _newRow.MoPrimaCosto = _row["MoPrimaCosto"] != "" && _row["MoPrimaCosto"].ToString() != "NaN" ? Double.Parse(_row["MoPrimaCosto"].ToString()) : 0;
                            _newRow.MoPrimaCostoML = _row["MoPrimaCostoML"] != "" && _row["MoPrimaCostoML"].ToString() != "NaN" ? Double.Parse(_row["MoPrimaCostoML"].ToString()) : 0;
                            _newRow.MoPrimaInicial = _row["MoPrimaInicial"] != "" && _row["MoPrimaInicial"].ToString() != "NaN" ? Double.Parse(_row["MoPrimaInicial"].ToString()) : 0;
                            _newRow.MoCarryPrima = _row["MoCarryPrima"] != "" && _row["MoCarryPrima"].ToString() != "NaN" ? Double.Parse(_row["MoCarryPrima"].ToString()) : 0;
                            _newRow.MoParM2Spot = _row["MoParM2Spot"] != "" && _row["MoParM2Spot"].ToString() != "NaN" ? Double.Parse(_row["MoParM2Spot"].ToString()) : 0;
                            _newRow.MoParMdaPrima = _row["MoParMdaPrima"] != "" && _row["MoParMdaPrima"].ToString() != "NaN" ? Double.Parse(_row["MoParMdaPrima"].ToString()) : 0;
                            _newRow.MoVr = _row["MoVr"] != "" && _row["MoVr"].ToString() != "NaN" ? Double.Parse(_row["MoVr"].ToString()) : 0;
                            _newRow.MoPrimaBSSpotCont = _row["MoPrimaBSSpotCont"] != "" && _row["MoPrimaBSSpotCont"].ToString() != "NaN" ? Double.Parse(_row["MoPrimaBSSpotCont"].ToString()) : 0;
                            _newRow.MoDeltaForwardCont = _row["MoDeltaForwardCont"] != "" && _row["MoDeltaForwardCont"].ToString() != "NaN" ? Double.Parse(_row["MoDeltaForwardCont"].ToString()) : 0;

                            _newRow.MoVegaCont = _row["MoVegaCont"] != "" && _row["MoVegaCont"].ToString() != "NaN" ? Double.Parse(_row["MoVegaCont"].ToString()) : 0;
                            _newRow.MoVolgaCont = _row["MoVolgaCont"] != "" && _row["MoVolgaCont"].ToString() != "NaN" ? Double.Parse(_row["MoVolgaCont"].ToString()) : 0;
                            _newRow.MoThetaCont = _row["MoThetaCont"] != "" && _row["MoThetaCont"].ToString() != "NaN" ? Double.Parse(_row["MoThetaCont"].ToString()) : 0;
                            _newRow.MoRhoDomCont = _row["MoRhoDomCont"] != "" && _row["MoRhoDomCont"].ToString() != "NaN" ? Double.Parse(_row["MoRhoDomCont"].ToString()) : 0;
                            _newRow.MoRhoForCont = _row["MoRhoForCont"] != "" && _row["MoRhoForCont"].ToString() != "NaN" ? Double.Parse(_row["MoRhoForCont"].ToString()) : 0;

                            // MAP 01 Septiembre Planilla Corrige x NaN

                            // DMV 11 Diciembre del 2009, se corrige problema de grabación de prima
                            _newRow.MoPrimaInicial = _row["MoPrimaInicial"] != "" && _row["MoPrimaInicial"].ToString() != "NaN" ? Double.Parse(_row["MoPrimaInicial"].ToString()) : 0;
                            _newRow.MoPrimaInicialML = _row["MoPrimaInicialML"] != "" && _row["MoPrimaInicialML"].ToString() != "NaN" ? Double.Parse(_row["MoPrimaInicialML"].ToString()) : 0;
                            _newRow.MoParMdaPrima = _row["MoParMdaPrima"] != "" && _row["MoParMdaPrima"].ToString() != "NaN" ? Double.Parse(_row["MoParMdaPrima"].ToString()) : 0;
                            //5843
                            _newRow.MoResultadoVentasML = _row["MoResultadoVentasML"] != "" && _row["MoResultadoVentasML"].ToString() != "NaN" ? Double.Parse(_row["MoResultadoVentasML"].ToString()) : 0;

                            _newRow.MoDeltaSpotCont = _rowCaEncCon.CaDeltaSpotCont;
                            _newRow.MoGammaSpotCont = _rowCaEncCon.CaGammaSpotCont;
                            _newRow.MoVannaSpotCont = _rowCaEncCon.CaVannaSpotCont;
                            _newRow.MoCharmSpotCont = _rowCaEncCon.CaCharmSpotCont;
                            _newRow.MoZommaSpotCont = _rowCaEncCon.CaZommaSpotCont;
                            _newRow.MoSpeedSpotCont = _rowCaEncCon.CaSpeedSpotCont;
                            _newRow.MoVr_Costo = _rowCaEncCon.CaVr_Costo;
                            _newRow.MoGammaFwdCont = _rowCaEncCon.CaGammaFwdCont;
                            _newRow.MoVannaFwdCont = _rowCaEncCon.CaVannaFwdCont;
                            _newRow.MoCharmFwdCont = _rowCaEncCon.CaCharmFwdCont;
                            _newRow.MoZommaFwdCont = _rowCaEncCon.CaZommaFwdCont;
                            _newRow.MoSpeedFwdCont = _rowCaEncCon.CaSpeedFwdCont;
                            _newRow.MoImpreso = _rowCaEncCon.CaImpreso;
                            #endregion

                            #region "Carga datos Datetime"
                            _newRow.MoFechaContrato = _row["MoFechaContrato"] != "" ? DateTime.Parse(_row["MoFechaContrato"].ToString()) : _rowCaEncCon.CaFechaContrato;
                            _newRow.MoFechaPagoPrima = _row["MoFechaPagoPrima"] != "" ? DateTime.Parse(_row["MoFechaPagoPrima"].ToString()) : _rowCaEncCon.CaFechaPagoPrima;
                            _newRow.MoFecValorizacion = _row["MoFecValorizacion"] != "" ? DateTime.Parse(_row["MoFecValorizacion"].ToString()) : _rowCaEncCon.CaFecValorizacion;
                            _newRow.MoFechaUnwind = _newRow.MoFechaContrato;
                            _newRow.MoFechaCreacionRegistro = DateTime.Now;
                            #endregion

                            _DataContrato.MoEncContrato.Rows.Add(_newRow);

                        }
                    }
                    #endregion
                }
                #endregion

                #region "DataConecctionInterfaceGB"

                #region "Sección Actualización"
                dm_.TransactionBegin();
                int _filasEnc = _DataContrato.MoEncContrato.Rows.Count;
                if (_filasEnc > 0)
                {
                    int _result = dm_.Update(_DataContrato.MoEncContrato);
                    if (_filasEnc == _result)
                    {
                        _MoEncContrato = "True";
                        _MoDetContrato = "Nulo";
                        _MoFixing = "Nulo";
                    }
                    else
                    { _MoEncContrato = "False"; }
                }
                #endregion

                #region "Sección Grabación"
                string Tipo = "MoEnContrato=" + _MoEncContrato + " MoDetContrato=" + _MoDetContrato + " MoFixing=" + _MoFixing;
                DataTable _resultado = new DataTable();
                string _Status = "";
                switch (Tipo)
                {
                    // MAP: ojo que estamos para codigo solo de anulacion
                    //case "MoEnContrato=True MoDetContrato=True MoFixing=True":
                    case "MoEnContrato=True MoDetContrato=Nulo MoFixing=Nulo":
                        dm_.Update(_DataContrato.OpcionesGeneral);
                        dm_.TransactionCommit();
                        _resultado = ProcesoAppMvtCar_Anula_Anticipa(Convert.ToInt16(MoNumFolio));
                        if (_resultado != null)
                        {
                            DataRow _p = _resultado.Rows[0];
                            _Status = _p["Column1"].ToString();
                            _Result = _p["Column2"].ToString();
                        }
                        if (_Status.ToUpper().Equals("SI"))
                        {
                            _Result += " Contrato Guardado Exitosamente";
                        }
                        break;
                    case "MoEnContrato=True MoDetContrato=True MoFixing=Nulo":
                        dm_.Update(_DataContrato.OpcionesGeneral);
                        dm_.TransactionCommit();
                        _resultado = ProcesoAppMvtCar(Convert.ToInt16(MoNumFolio));
                        if (_resultado != null)
                        {
                            DataRow _p = _resultado.Rows[0];
                            _Status = _p["Column1"].ToString();
                            _Result = _p["Column2"].ToString();
                        }
                        _Result += " Contrato Guardado Exitosamente";
                        break;
                    case "MoEnContrato=True MoDetContrato=True MoFixing=False":
                        dm_.TransactionRollback();
                        _Result = "Error con Fila(s) en tabla MoFixing";
                        break;
                    case "MoEnContrato=True MoDetContrato=False MoFixing=Nulo":
                        dm_.TransactionRollback();
                        _Result = "Error con Fila(s) en tabla MoDetContrato";
                        break;
                    case "MoEnContrato=False MoDetContrato=Nulo MoFixing=Nulo":
                        dm_.TransactionRollback();
                        _Result = "Error con Fila(s) en tabla MoEnContrato";
                        break;
                }
                #endregion

                #endregion
            }
            catch (Exception _Error)
            {
                dm_.TransactionRollback();
                _Result = "Error al grabar Anulación de Contrato: " + _Error.ToString();
            }

            return _Result;
        }

        public static Dataset.DataCartera TraeContrato(int _NumContrato, int _NumFolio)
        {

            #region "Variables TraeContrato"
            Dataset.DataCartera _Cartera = new Dataset.DataCartera();
            Manager.DataManagerSQL dm_ = new Manager.DataManagerSQL("");
            string _result = string.Empty;
            #endregion

            try
            {
                #region "Coneccion a BD y recuperación de datos"

                if (_NumContrato != 0)
                {
                    dm_ = new Manager.DataManagerSQL(ConnectString("Opciones"));
                    dm_.Fill(_Cartera.CaEncContrato, new Manager.DataParam("CaNumContrato", _NumContrato), new Manager.DataParam("CaNumFolio", _NumFolio));
                    dm_.Fill(_Cartera.CaDetContrato, new Manager.DataParam("CaNumContrato", _NumContrato));
                    dm_.Fill(_Cartera.CaFixing, new Manager.DataParam("CaNumContrato", _NumContrato));
                    dm_.Fill(_Cartera.CaCaja, new Manager.DataParam("CaNumContrato", _NumContrato));
                }

                #endregion
            }
            catch
            { }
            return _Cartera;
        }

        public static DataTable ProcesoAppMvtCar(int _NumFolio)
        {
            String _Query = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _AccionUpdate;

            #region "Ejecuta Sp_CaMarcaImpreso"
            _Query = "Sp_AppMvtCar " + _NumFolio;
            #endregion

            #region "Ejectuta Codigo"
            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_Query);
                _AccionUpdate = _Connect.QueryDataTable();
                _AccionUpdate.TableName = "Resultado";

                if (_AccionUpdate.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _AccionUpdate = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }
            #endregion

            return _AccionUpdate;
        }

        //ECC Creado por problemas en la cantidad de DataTables retornados.
        public static DataTable ProcesoAppMvtCar_Anula_Anticipa(int _NumFolio)
        {
            String _Query = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _AccionUpdate;

            #region "Ejecuta Sp_AppMvtCar"
            _Query = "Sp_AppMvtCar " + _NumFolio;
            #endregion

            #region "Ejectuta Codigo"
            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_Query);
                //ASVG_20110413 El SP_AppMvtCar retorna más de un set de datos, por lo que se genera más de un datatable.
                //en estricto rigor lo que se busca es el último DataSet
                //int _ultimoDataSet = _Connect.QueryDataSet().Tables.Count();
                //_AccionUpdate = _Connect.QueryDataSet().Tables[1];
                _AccionUpdate = _Connect.QueryDataSet().Tables[1];
                _AccionUpdate.TableName = "Resultado";

                if (_AccionUpdate.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _AccionUpdate = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }
            #endregion

            return _AccionUpdate;
        }

        public static String ActualizaCartera(DataSet _Datos)
        {

            #region "variables GrabaContrato"

            string _Result = string.Empty;
            Dataset.DataCartera _DataCartera = new Dataset.DataCartera();
            DataRow[] _DRFixings;

            #endregion

            #region "Genera MoNumFolio"
            Manager.DataManagerSQL dm_ = new cData.Manager.DataManagerSQL(ConnectString("Opciones"));
            dm_.Fill(_DataCartera.CaDetContrato);
            dm_.Fill(_DataCartera.CaFixing);
            string CaTipoPayOff = string.Empty;

            #endregion

            #region "Carga Datos a DataSet"
            decimal _Contrato = 0;
            decimal _Estructura = 0;

            try
            {
                if (_Datos.Tables.Count > 0)
                {
                    #region "CaDetContrato"
                    foreach (DataRow _rowData in _Datos.Tables["detContrato"].Rows)
                    {
                        _Contrato = decimal.Parse(_rowData["NumContrato"].ToString());
                        _Estructura = decimal.Parse(_rowData["NumEstructura"].ToString());

                        string _Key = string.Format(
                                                     "CaNumContrato = {0} AND CaNumEstructura = {1}",
                                                     _rowData["NumContrato"].ToString(),
                                                     _rowData["NumEstructura"].ToString()
                                                   );
                        DataRow[] _p = _DataCartera.CaDetContrato.Select(_Key);

                        cData.Dataset.DataCartera.CaDetContratoRow orow_ = _DataCartera.CaDetContrato.FindByCaNumContratoCaNumEstructura(Convert.ToDecimal(_Contrato), Convert.ToDecimal(_Estructura));

                        #region Update CaDetContrato
                        orow_.BeginEdit();

                        orow_.CaCurveMon1 = _rowData["MoCurveMon1"].ToString();
                        orow_.CaCurveMon2 = _rowData["MoCurveMon2"].ToString();
                        orow_.CaCurveSmile = _rowData["MoCurveSmile"].ToString();
                        orow_.CaWf_mon1 = CheckValue(_rowData["MoWf_mon1"].ToString());
                        orow_.CaWf_mon1 = CheckValue(_rowData["MoWf_mon2"].ToString());
                        orow_.CaVol = CheckValue(_rowData["MoVol"].ToString());
                        orow_.CaFwd_teo = CheckValue(_rowData["MoFwd_teo"].ToString());
                        orow_.CaDelta_spot = CheckValue(_rowData["MoDeltaSpot"].ToString());
                        orow_.CaVrDet = CheckValue(_rowData["MoVrDet"].ToString());
                        orow_.CaSpotDet = CheckValue(_rowData["MoSpotDet"].ToString());
                        orow_.CaRho = CheckValue(_rowData["MoRho"].ToString());
                        orow_.CaRho_num = CheckValue(_rowData["MoRho_num"].ToString());
                        orow_.CaRhof = CheckValue(_rowData["MoRhof"].ToString());
                        orow_.CaRhof_num = CheckValue(_rowData["MoRhof_num"].ToString());
                        orow_.CaCharm_spot = CheckValue(_rowData["MoCharm_spot"].ToString());
                        orow_.CaCharm_spot_num = CheckValue(_rowData["MoCharm_spot_num"].ToString());
                        orow_.CaCharm_fwd = CheckValue(_rowData["MoCharm_fwd"].ToString());
                        orow_.CaCharm_fwd_num = CheckValue(_rowData["MoCharm_fwd_num"].ToString());
                        orow_.CaVanna_spot = CheckValue(_rowData["MoVanna_spot"].ToString());
                        orow_.CaVanna_spot_num = CheckValue(_rowData["MoVanna_spot_num"].ToString());
                        orow_.CaVanna_fwd = CheckValue(_rowData["MoVanna_fwd"].ToString());
                        orow_.CaVanna_fwd_num = CheckValue(_rowData["MoVanna_fwd_num"].ToString());
                        orow_.CaGamma_spot = CheckValue(_rowData["MoGamma_spot"].ToString());
                        orow_.CaGamma_spot_num = CheckValue(_rowData["MoGamma_spot_num"].ToString());
                        orow_.CaGamma_fwd = CheckValue(_rowData["MoGamma_fwd"].ToString());
                        orow_.CaGamma_fwd_num = CheckValue(_rowData["MoGamma_fwd_num"].ToString());
                        orow_.CaVega = CheckValue(_rowData["MoVega"].ToString());
                        orow_.CaVega_num = CheckValue(_rowData["MoVega_num"].ToString());
                        orow_.CaDelta_spot = CheckValue(_rowData["MoDelta_spot"].ToString());
                        orow_.CaDelta_spot_num = CheckValue(_rowData["MoDelta_spot_num"].ToString());
                        orow_.CaDelta_fwd = CheckValue(_rowData["MoDelta_fwd"].ToString());
                        orow_.CaDelta_fwd_num = CheckValue(_rowData["MoDelta_fwd_num"].ToString());
                        orow_.CaVolga = CheckValue(_rowData["MoVolga"].ToString());
                        orow_.CaVolga_num = CheckValue(_rowData["MoVolga_num"].ToString());
                        orow_.CaTheta = CheckValue(_rowData["MoTheta"].ToString());
                        orow_.CaTheta_num = CheckValue(_rowData["MoTheta_num"].ToString());

                        orow_.EndEdit();
                        #endregion

                        int pos_ = _DataCartera.CaDetContrato.Rows.IndexOf(_p[0]);
                        cData.Dataset.DataCartera.CaDetContratoRow _Cartera = _DataCartera.CaDetContrato[pos_];

                        string _KeyDataFixing = string.Format(
                                                               "MoNumContrato = {0} AND MoNumEstructura = {1}",
                                                               _rowData["NumContrato"].ToString(),
                                                               _rowData["NumEstructura"].ToString()
                                                             );
                        _DRFixings = _Datos.Tables["FixingData"].Select(_KeyDataFixing);

                        if (_DRFixings.Length > 0)
                        {
                            #region Fixing
                            foreach (DataRow _rowF in _DRFixings)
                            {
                                // MAP , solo if 
                                if (_Estructura == decimal.Parse(_rowF["MoNumEstructura"].ToString()))
                                {
                                    cData.Dataset.DataCartera.CaFixingRow _newRowF = _DataCartera.CaFixing.NewCaFixingRow();
                                    string _KeyFixing = string.Format(
                                                                       "CaNumContrato = {0} AND CaNumEstructura = {1} AND CaFixNumero = {2}",
                                                                       _rowData["NumContrato"].ToString(),
                                                                       _rowData["NumEstructura"].ToString(),
                                                                       _rowF["ID"].ToString()
                                                                     );

                                    decimal _ID = decimal.Parse(_rowF["ID"].ToString());

                                    DataRow[] _Fixing = _DataCartera.CaFixing.Select(_KeyFixing);
                                    cData.Dataset.DataCartera.CaFixingRow _DRFixing = _DataCartera.CaFixing.FindByCaNumContratoCaNumEstructuraCaFixNumero(_Contrato, _Estructura, _ID);

                                    #region "Carga datos Float"
                                    _DRFixing.CaFijacion = CheckValue(_rowF["Valor"].ToString());
                                    _DRFixing.CaVolFij = CheckValue(_rowF["Volatilidad"].ToString());
                                    #endregion

                                    _DRFixing.EndEdit();

                                    int _PosFixing = _DataCartera.CaFixing.Rows.IndexOf(_Fixing[0]);
                                    cData.Dataset.DataCartera.CaFixingRow _FixingData = _DataCartera.CaFixing[_PosFixing];
                                }
                            }
                            #endregion
                        }
                    }
                    #endregion
                }
            }
            catch (Exception _Error)
            {
                _Result = "Error" + _Error.Message + " " + _Contrato.ToString();
                throw new Exception(_Result);
            }

            #region "DataConecctionInterfaceGB"

            try
            {
                dm_.TransactionBegin();
                int _filasEnc = _DataCartera.CaDetContrato.Rows.Count;
                if (_filasEnc > 0)
                {
                    int _result = dm_.Update(_DataCartera.CaDetContrato);
                    int _resultFixing = dm_.Update(_DataCartera.CaFixing);
                    if (_result > 0)
                    {
                        dm_.TransactionCommit();
                    }
                    else
                    { dm_.TransactionRollback(); }
                }
            }

            catch { }
            #endregion

            #endregion

            return _Result;
        }

        private static double CheckValue(string data)
        {
            if (data != "")
            {
                if (data != "NeuN")
                {
                    return double.Parse(data);
                }
            }
            return 0;
        }

        public static bool CheckSaveValuator(DataSet datos)
        {
            #region "variables GrabaContrato"

            string _Result = string.Empty;
            Dataset.DataCartera _DataCartera = new Dataset.DataCartera();
            DataRow[] _DRFixings;

            #endregion

            #region "Genera MoNumFolio"

            Manager.DataManagerSQL dm_ = new cData.Manager.DataManagerSQL(ConnectString("Opciones"));
            dm_.Fill(_DataCartera.CaDetContrato);
            dm_.Fill(_DataCartera.CaFixing);
            string CaTipoPayOff = string.Empty;

            #endregion

            #region "Carga Datos a DataSet"

            try
            {
                if (datos.Tables.Count > 0)
                {
                    #region "CaDetContrato"
                    foreach (DataRow _rowData in datos.Tables["detContrato"].Rows)
                    {
                        decimal _Contrato = decimal.Parse(_rowData["NumContrato"].ToString());
                        decimal _Estructura = decimal.Parse(_rowData["NumEstructura"].ToString());

                        string _Key = string.Format(
                                                     "CaNumContrato = {0} AND CaNumEstructura = {1}",
                                                     _rowData["NumContrato"].ToString(),
                                                     _rowData["NumEstructura"].ToString()
                                                   );
                        DataRow[] _p = _DataCartera.CaDetContrato.Select(_Key);

                        cData.Dataset.DataCartera.CaDetContratoRow _orow = _DataCartera.CaDetContrato.FindByCaNumContratoCaNumEstructura(Convert.ToDecimal(_Contrato), Convert.ToDecimal(_Estructura));

                        #region Validación de MTM

                        double _MTM = (_rowData["MoVrDet"] != "" ? double.Parse(_rowData["MoVrDet"].ToString()) : 0);

                        if (_orow.CaVrDet != _MTM)
                        {
                            return false;
                        }

                        #endregion

                        string _KeyDataFixing = string.Format(
                                                               "MoNumContrato = {0} AND MoNumEstructura = {1}",
                                                               _rowData["NumContrato"].ToString(),
                                                               _rowData["NumEstructura"].ToString()
                                                             );
                        _DRFixings = datos.Tables["FixingData"].Select(_KeyDataFixing);

                        if (_DRFixings.Length > 0)
                        {
                            #region Fixing
                            foreach (DataRow _rowF in _DRFixings)
                            {
                                cData.Dataset.DataCartera.CaFixingRow _newRowF = _DataCartera.CaFixing.NewCaFixingRow();
                                string _KeyFixing = string.Format(
                                                                   "CaNumContrato = {0} AND CaNumEstructura = {1} AND CaFixNumero = {2}",
                                                                   _rowData["NumContrato"].ToString(),
                                                                   _rowData["NumEstructura"].ToString(),
                                                                   _rowF["ID"].ToString()
                                                                 );

                                decimal _ID = decimal.Parse(_rowF["ID"].ToString());

                                DataRow[] _Fixing = _DataCartera.CaFixing.Select(_KeyFixing);
                                cData.Dataset.DataCartera.CaFixingRow _DRFixing = _DataCartera.CaFixing.FindByCaNumContratoCaNumEstructuraCaFixNumero(_Contrato, _Estructura, _ID);

                                #region "Carga datos Float"

                                double _Value = _rowF["Valor"].ToString() != "NaN" ? double.Parse(_rowF["Valor"].ToString()) : 0;
                                double _Volatility = _rowF["Volatilidad"].ToString() != "NaN" ? double.Parse(_rowF["Volatilidad"].ToString()) : 0;

                                if ((_DRFixing.CaFijacion != _Value) && (_DRFixing.CaVolFij != _Value))
                                {
                                    return false;
                                }

                                #endregion

                            }
                            #endregion
                        }
                    }
                    #endregion
                }
                return true;
            }
            catch
            {
                return false;
            }

            #endregion
        }

        public static DataTable InsertImpresion(string xmlValue)
        {
            XDocument _XMLValue = XDocument.Parse(xmlValue);
            string _Query = "";
            string _User = _XMLValue.Element("Options").Attribute("User").Value;
            DataTable _InsertImresion;

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");

            #region Query

            _Query += "DECLARE @id      INT\n";
            _Query += "SELECT @id = ISNULL( MAX(ImpGrupo), 0 ) + 1 FROM dbo.IMPRESION\n";

            foreach (XElement _Item in _XMLValue.Descendants("Option"))
            {

                _Query += string.Format(
                                         "INSERT INTO dbo.IMPRESION ( ImpGrupo, ImpNumContrato, ImpFolio, ImpUsuario ) " +
                                         "VALUES ( @id, {0}, {1}, '{2}' )\n",
                                         _Item.Attribute("Contrato").Value,
                                         _Item.Attribute("Folio").Value,
                                         _User
                                       );

            }

            _Query += "SELECT 'ID' = @id";

            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_Query);
                _InsertImresion = _Connect.QueryDataTable();
                _InsertImresion.TableName = "InsertImpresion";

                if (_InsertImresion.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _InsertImresion = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _InsertImresion;
        }

        public static DataTable InsertLogAuditoria(string xmlValue)
        {
            XDocument _XMLValue = XDocument.Parse(xmlValue);
            string _Query = "";
            //string _User = _XMLValue.Element("Options").Attribute("User").Value;
            DataTable _InsertLogAuditoria;

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");

            #region Query

            _Query += "DECLARE @msg      char(15)\n";
            _Query += "SELECT @msg = 'OK' \n";

            foreach (XElement _Item in _XMLValue.Descendants("Option"))
            {

                _Query += string.Format(
                                         "INSERT INTO lnkBAC.bacparamsuda.dbo.log_auditoria ( Entidad, FechaProceso, FechaSistema" +
                                         ", HoraProceso, Terminal, Usuario, Id_Sistema, CodigoMenu, Codigo_Evento, DetalleTransac, TablaInvolucrada, ValorAntiguo, ValorNuevo) " +
                                         "VALUES ( '{0}', '{1}', '{2}', '{3}', '{4}', '{5}', '{6}', '{7}', '{8}', '{9}', '{10}', '{11}', '{12}'  )\n",
                                         _Item.Attribute("Entidad").Value,
                                         _Item.Attribute("FechaProceso").Value,
                                         _Item.Attribute("FechaSistema").Value,
                                         _Item.Attribute("HoraProceso").Value,
                                         _Item.Attribute("Terminal").Value,
                                         _Item.Attribute("Usuario").Value,
                                         _Item.Attribute("Id_Sistema").Value,
                                         _Item.Attribute("CodigoMenu").Value,
                                         _Item.Attribute("Codigo_Evento").Value,
                                         _Item.Attribute("DetalleTransac").Value,
                                         _Item.Attribute("TablaInvolucrada").Value,
                                         _Item.Attribute("ValorAntiguo").Value,
                                         _Item.Attribute("ValorNuevo").Value

                                       );

            }
            _Query += "\n";
            _Query += "SELECT 'MSG' = @msg";



            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_Query);
                _InsertLogAuditoria = _Connect.QueryDataTable();
                _InsertLogAuditoria.TableName = "InsertImpresion";

                if (_InsertLogAuditoria.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _InsertLogAuditoria = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _InsertLogAuditoria;
        }

        public static DataTable ActualizaFormaPagoCompensacion(Int64 numeroContrato, Int64 numeroEstructura, string origen, int formaPago)
        {
            String _Query = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _AccionUpdate;

            #region "Ejecuta Sp_CaMarcaImpreso"
            _Query = string.Format(
                                    "SP_ActualizaFormaPagoCompensacion {0}, {1}, '{2}', {3}",
                                    numeroContrato.ToString(),
                                    numeroEstructura.ToString(),
                                    origen,
                                    formaPago.ToString()
                                  );
            #endregion

            #region "Ejectuta Codigo"
            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_Query);
                _AccionUpdate = _Connect.QueryDataTable();
                _AccionUpdate.TableName = "Resultado";

                if (_AccionUpdate.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _AccionUpdate = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }
            #endregion

            return _AccionUpdate;

        }

        public static DataTable ActualizaFormaPagoEntregaFisica(Int64 numeroContrato, Int64 numeroEstructura, int formaPagoPagar, int formaPagoRecibir)
        {
            String _Query = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _AccionUpdate;

            #region "Ejecuta Sp_CaMarcaImpreso"
            _Query = string.Format(
                                    "SP_ActualizaFormaPagoEntregaFisica {0}, {1}, {2}, {3}",
                                    numeroContrato.ToString(),
                                    numeroEstructura.ToString(),
                                    formaPagoPagar.ToString(),
                                    formaPagoRecibir.ToString()
                                  );
            #endregion

            #region "Ejectuta Codigo"
            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_Query);
                _AccionUpdate = _Connect.QueryDataTable();
                _AccionUpdate.TableName = "Resultado";

                if (_AccionUpdate.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _AccionUpdate = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }
            #endregion

            return _AccionUpdate;

        }

        public static string CheckValuator(DateTime dateProcess)
        {
            string _StatusSmile = "0";
            string _StatusYield1 = "0";
            string _StatusYield2 = "0";
            string _StatusSpot = "0";

            if (CheckSmile(dateProcess) == null || CheckSmile(dateProcess).Rows.Count == 0)
            {
                _StatusSmile = "1";
            }

            if (CheckYield(dateProcess, "CurvaSWAPCLP") == null || CheckYield(dateProcess, "CurvaSWAPCLP").Rows.Count == 0)
            {
                _StatusYield1 = "1";
            }

            if (CheckYield(dateProcess, "CurvaSWAPUSDLocal") == null || CheckYield(dateProcess, "CurvaSWAPUSDLocal").Rows.Count == 0)
            {
                _StatusYield2 = "1";
            }
            if (CheckSpot(dateProcess, "DO") == null || CheckSpot(dateProcess, "DO").Rows.Count == 0)
            {
                _StatusSpot = "1";
            }

            return string.Format("<Value Smile='{0}' Yield1='{1}' Yield2='{2}'  Spot='{3}' />", _StatusSmile, _StatusYield1, _StatusYield2, _StatusSpot);
        }

        private static DataTable CheckSmile(DateTime dateProcess)
        {
            String _Query = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _AccionUpdate;

            #region "Ejecuta Sp_CaMarcaImpreso"

            _Query += "SELECT SmlFecha\n";
            _Query += "     , SmlParFor\n";
            _Query += "     , SmlEstructura\n";
            _Query += "     , SmlDelta\n";
            _Query += "     , SmlDias\n";
            _Query += "     , SmlBid\n";
            _Query += "     , SmlAsk\n";
            _Query += "     , SmlMid\n";
            _Query += "  FROM dbo.Smile\n";
            _Query += string.Format(" WHERE SmlFecha = '{0}'\n", dateProcess.ToString("yyyyMMdd"));

            #endregion

            #region "Ejectuta Codigo"
            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_Query);
                _AccionUpdate = _Connect.QueryDataTable();
                _AccionUpdate.TableName = "CheckSmile";

                if (_AccionUpdate.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _AccionUpdate = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }
            #endregion

            return _AccionUpdate;
        }

        private static DataTable CheckYield(DateTime dateProcess, string yieldName)
        {
            String _Query = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
            DataTable _AccionUpdate;

            #region "Ejecuta Sp_CaMarcaImpreso"

            _Query += "SELECT FechaGeneracion\n";
            _Query += "     , CodigoCurva\n";
            _Query += "     , Dias\n";
            _Query += "     , ValorBid\n";
            _Query += "     , ValorAsk\n";
            _Query += "     , Tipo\n";
            _Query += "     , Origen\n";
            _Query += "  FROM dbo.Curvas\n";
            _Query += string.Format(" WHERE FechaGeneracion = '{0}'\n", dateProcess.ToString("yyyyMMdd"));
            _Query += string.Format("   AND CodigoCurva     = '{0}'\n", yieldName);

            #endregion

            #region "Ejectuta Codigo"
            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_Query);
                _AccionUpdate = _Connect.QueryDataTable();
                _AccionUpdate.TableName = "CheckYield";

                if (_AccionUpdate.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _AccionUpdate = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }
            #endregion

            return _AccionUpdate;
        }

        private static DataTable CheckSpot(DateTime dateProcess, string NemoMoneda)
        {
            String _Query = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
            DataTable _AccionUpdate;

            #region "Ejecuta Sp_CaMarcaImpreso"

            _Query += "SELECT Tipo_Cambio FROM valor_moneda_contable \n";
            _Query += string.Format("WHERE Fecha = '{0}' AND Nemo_Moneda='{1}' \n", dateProcess.ToString("yyyyMMdd"), NemoMoneda);


            #endregion

            #region "Ejectuta Codigo"
            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_Query);
                _AccionUpdate = _Connect.QueryDataTable();
                _AccionUpdate.TableName = "CheckSpot";

                if (_AccionUpdate.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _AccionUpdate = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }
            #endregion

            return _AccionUpdate;
        }

        private static string ConnectString(string connectName)
        {
            char[] _Separator = { ';' };
            string _ConnectString = System.Configuration.ConfigurationManager.ConnectionStrings[connectName].ConnectionString;
            string[] _ListConnect = _ConnectString.Split(_Separator);
            string _Password = _ListConnect[_ListConnect.Length - 1];
            string _PasswordDes = "Password=" + AdminOpcionesEncript.Encript.DesEcrypt(_Password.Replace("Password=", ""));
            _ConnectString = _ConnectString.Replace(_Password, _PasswordDes);
            return _ConnectString;
        }
        //Prd_10968
        public static DataTable TraeClienteLCR(DataSet _Datos, string _Operacion)
        {

            String _Query = "";
            Int32 _Pais = 0;
            String _Status = "";


            DataRow _D = _Datos.Tables[0].Rows[0];
            _Rut = Convert.ToInt32(_D["MoRutCliente"].ToString());
            _CodCliente = Convert.ToInt32(_D["MoCodigo"].ToString());



            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _AccionUpdate;

            #region "Ejecuta SP_CON_CLIENTE_LCR"
            _Query = "SP_CON_CLIENTE_LCR " + _Rut + " ," + _CodCliente;
            #endregion

            #region "Carga Datos Clientes LCR"
            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_Query);
                _AccionUpdate = _Connect.QueryDataTable();



                if (_AccionUpdate.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _AccionUpdate = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }


            if (_AccionUpdate != null)
            {
                DataRow _p = _AccionUpdate.Rows[0];
                _Pais = Convert.ToInt32(_p["Clpais"].ToString());
                _Metodologia = Convert.ToInt32(_p["MetodologiaLCR"].ToString());


                if (_Pais != 6)
                {
                    _ClPais = "N";
                }
                else
                {
                    _ClPais = "S";
                }

            }
            else
            {
                _Status = "ERROR";

            }
            #endregion
            return _AccionUpdate;
        }

        public static string EjecutaProcesoLineasOpciones(DataTable _Resultado, DataSet _Datos,
                                                          string Usuario_, int _NumContrato, string _Operacion)
        {


            #region "Asigna Variables"
            DataRow _R = _Resultado.Rows[0];
            decimal _AvrCLP = 0;
            decimal _PorcAddOn = 0;
            decimal _MontoAddon = 0;
            decimal _LCRDrv = 0;


            DataRow _DEnc = _Datos.Tables["encContrato"].Rows[0];
            _Rut = Convert.ToInt32(_DEnc["MoRutCliente"].ToString());
            _CodCliente = Convert.ToInt32(_DEnc["MoCodigo"].ToString());
            _FechaContrato = Convert.ToDateTime(_DEnc["MoFechaContrato"].ToString());


            DataRow _DDet = _Datos.Tables["detContrato"].Rows[0];
            _RecNocional = Convert.ToDecimal(_DDet["MoMontoMon1"].ToString());
            _FechaVencimiento = Convert.ToDateTime(_DDet["MoFechaVcto"].ToString());

            if (_Operacion != "C")
            {
                _NumContratoRec = _NumContrato;
            }

            _Sistema = "OPT";
            _RecUsuario = Usuario_;


            if (_Metodologia == 2 | _Metodologia == 3 | _Metodologia == 5)
            {
                if (_Resultado != null)
                {
                    _AvrCLP = Convert.ToDecimal(_R["AvrCLP"].ToString());
                    _PorcAddOn = Convert.ToDecimal(_R["PorcAddOn"].ToString());
                    _MontoAddon = Convert.ToDecimal(_R["MontoAddon"].ToString());
                    if (_Operacion == "U")
                        _RecNocional = -1;
                    _LCRDrv = Convert.ToDecimal(_R["LCRDrv"].ToString());
                }

            }
            else
            {
                if (_Resultado != null)
                {
                    _AvrCLP = Convert.ToDecimal(_R["Avr"].ToString());
                    _PorcAddOn = Convert.ToDecimal(_R["Porcentaje_AddOn"].ToString());
                    _MontoAddon = Convert.ToDecimal(_R["Monto_AddOn"].ToString());
                    _RecNocional = Convert.ToDecimal(_R["Monto_Imputacion"].ToString());
                    _LCRDrv = 0;
                }


            }

            string _Result = string.Empty;
            String _Query = "";
            #endregion


            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACLINEAS");
            DataTable _AccionUpdate;

            #region "Ejecuta LnkBac.BacLineas.dbo.SP_EJECUCION_PROCESOS_LINEAS_OPCIONES_PTONET"
            _Query = "SP_EJECUCION_PROCESOS_LINEAS_OPCIONES_PTONET ";
            _Query = _Query + " '" + _Sistema + "'";
            _Query = _Query + ", '" + _FechaContrato.ToString("yyyyMMdd") + "'";            // @fechini
            _Query = _Query + ", '" + _Sistema + "'";                                       // @Posicion1
            _Query = _Query + ", " + _NumContratoRec + " ";                                 // @NumOper
            _Query = _Query + ", " + _Rut + " ";                                            // @Rut1
            _Query = _Query + ", " + _CodCliente + " ";                                     // @CodCli1
            _Query = _Query + ", " + Convert.ToString(_RecNocional).Replace(",", ".") + ""; // @MtoMda1       
            _Query = _Query + ", '" + _FechaVencimiento.ToString("yyyyMMdd") + "' ";        // @Fecvcto
            _Query = _Query + ", 999 ";                                                     // @Moneda
            _Query = _Query + ", " + Convert.ToString(_AvrCLP).Replace(",", ".") + " ";     // @AvrClp
            _Query = _Query + ", " + Convert.ToString(_PorcAddOn).Replace(",", ".") + " ";  // @PorcAddOn     
            _Query = _Query + ", " + Convert.ToString(_MontoAddon).Replace(",", ".") + " "; // @MontoAddOn
            _Query = _Query + ", '" + _Sistema + "' ";                                      // @producto      
            _Query = _Query + ", '" + _ClPais + "' ";                                       // @MercadoLC
            _Query = _Query + ", 999 ";                                                     // @ContraMoneda
            _Query = _Query + ", 999 ";                                                     // @nMonedaOpera 
            _Query = _Query + ",'" + _RecUsuario + "' ";                                    // @Usuario
            _Query = _Query + ", " + _Metodologia;                                          // @MetodoLCR
            _Query = _Query + ", " + _Garantia;                                             // @Garantia
            _Query = _Query + ", " + Convert.ToString(_LCRDrv).Replace(",", ".") + " ";     // @ResultadoDRV

            //_Query = _Query + _Rut + _CodCliente + ", 1000000, '20111024', 999, 123456, 0.5, 20000, 'OPT', 'S', 999, 999, 'JDELRIO' ";
            #endregion


            #region "Ejectuta Codigo"
            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_Query);
                //ASVG_20110413 El SP_AppMvtCar retorna más de un set de datos, por lo que se genera más de un datatable.
                //_AccionUpdate = _Connect.QueryDataSet().Tables[1];
                _AccionUpdate = _Connect.QueryDataSet().Tables[0];  // Ver porque estaba asi para 
                _AccionUpdate.TableName = "Resultado";

                string estadoGrb = "1";

                if (_AccionUpdate.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                    estadoGrb = "0";
                }

               //TURING  >>>>>
                if (_Sistema == "OPT")
                {                      
                    string[] Columna1 = new string[2];
                    string[] Columna2 = new string[2];
                    string _XmlResp = "";

                    _XmlResp = "<OperacionOPT>"+
                               "<ProcesoBAC>" +
                               "<SistemaBAC>" + _Sistema  + "</SistemaBAC>" +
                               "<Operacion>" + _NumContratoRec + "</Operacion>" +
                               "<Status>" + estadoGrb + "</Status>" ;

                    for (int i = 0; i < _AccionUpdate.DataSet.Tables[0].Rows.Count; i++)
                    {                     
                        Columna1[i] = _AccionUpdate.DataSet.Tables[0].Rows[i].ItemArray[0].ToString();
                        Columna2[i] = _AccionUpdate.DataSet.Tables[0].Rows[i].ItemArray[1].ToString();

                        _XmlResp += " <" + Columna1[i] + ">" + Columna2[i] + "</" + Columna1[i] + ">";
                        if (Columna1[i] == "Linea")
                        {
                            _XmlResp += " <Threshold></Threshold>";
                        }                        
                    }
                    
                    _XmlResp += "<Precio></Precio> " +
                                "<ValidacionBAC></ValidacionBAC>" +
                                "</ProcesoBAC>" +
                                "</OperacionOPT>";
                    _Result = _XmlResp;
                }
                //TURING  <<<<<
            }
            catch (Exception _Error)
            {
                _AccionUpdate = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }
            #endregion


            #region "Carga Mensaje Lineas"
            string _Status = "";
            try
            {

                if (_AccionUpdate.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _AccionUpdate = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }


            if (_AccionUpdate != null)
            {
                DataRow _p = _AccionUpdate.Rows[0];
                _Status = _p["Column1"].ToString();
                //_Result = _p["Column2"].ToString();
                //_Result = _XmlResp;
            }
            else
            {
                _Status = "ERROR";
                _Result = "Sql ERROR GrabaContratoF";
            }
            #endregion

            return _Result;
        }


        public static DataTable CalculaLCROpciones(int _NumContrato, string _Operacion)
        {


            String _Query = "";

            if (_Operacion != "C")
            {
                _NumContratoRec = _NumContrato;
            }

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _AccionUpdate;

            #region "Ejecuta SP_CON_CLIENTE_LCR"
            _Query = "SP_Calculo_LCR_Interno_Opciones " + _NumContratoRec + " , 'S'";
            #endregion

            #region "Carga Datos Clientes LCR"
            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_Query);
                _AccionUpdate = _Connect.QueryDataTable();



                if (_AccionUpdate.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _AccionUpdate = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            #endregion
            return _AccionUpdate;
        }

        public static DataTable EjecutaSP_LineasAnula(int _NumContrato, DateTime fProceso)
        {

            String _Query = "";



            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _AccionUpdate;

            #region "Ejecuta SP_CON_CLIENTE_LCR"
            _Query = "SP_LLAMA_A_LINEAS_ANULA '" + fProceso.ToString("yyyyMMdd") + "', 'OPT'," + _NumContrato;
            #endregion

            #region "Carga Datos Clientes LCR"
            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_Query);
                _AccionUpdate = _Connect.QueryDataTable();



                if (_AccionUpdate.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _AccionUpdate = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            #endregion
            return _AccionUpdate;

        }

        public static double EjecutaCalculoRec(int _RutRec, int _CodCliRec, string _DescClienteRec, double _ThresholdRec, short _Rec_metodologia)
        {
            double _MontoRec = 0;
            string _PasswordRec = "";
            string _ServerNameRec = "";


            cConnectionDB.SqlConnectionDB _ConnectBD = new cConnectionDB.SqlConnectionDB("BACLINEAS");
            _ServerNameRec = _ConnectBD.ServerName;
            _PasswordRec = _ConnectBD.Password;



            string _Rec_Carteracurso = "ControlFinanciero";
            string _Rec_Sistema = "OPT";
            string _Rec_Error = "";
            short _Rec_Num = 1;

            CLSBacCalculoREC p = new CLSBacCalculoREC();


            _MontoRec = p.ProcesoCalculoRECFunDLL(ref _RutRec,
                                                     ref _CodCliRec,
                                                     ref _DescClienteRec,
                                                     ref _Rec_Carteracurso,
                                                     ref _Rec_Sistema,
                                                     ref _ThresholdRec,
                                                     ref _Rec_metodologia,
                                                     ref _Rec_Error,
                                                     ref _Rec_Num,
                                                     ref _ServerNameRec,
                                                     ref _PasswordRec);

            return _MontoRec;


        }
    }
}
