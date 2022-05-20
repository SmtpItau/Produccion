using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.Services;
using cData.AccionesBD;
using System.Xml.Linq;

namespace AdminOpciones.Web.WebService
{
    /// <summary>
    /// Descripción breve de WebAcciones
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class WebAcciones : System.Web.Services.WebService
    {
        public class ListaFijacion
        {
            public string contrato { get; set; }
            public string usuario { get; set; }
            public string numestruct { get; set; }
            public string numfijacion { get; set; }
            public string valorfix { get; set; }
        }

        [WebMethod]
        public string ActualizaMoEnc(List<string> _ListNumFolio)
        {
            DataTable _DataResults = new DataTable();
            int _Row, _Row2 = 0; 
            DataRow _DataRow;
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
            _ReturnValue += "<Resultado>";

            if (_ListNumFolio.Count > 0)
            {
                for (_Row = 0; _Row < _ListNumFolio.Count; _Row++)
                {
                    _DataResults = Acciones.ResulDB(int.Parse((_ListNumFolio[_Row].ToString())));

                    if (_DataResults != null)
                    {
                        for (_Row2 = 0; _Row2 < _DataResults.Rows.Count; _Row2++)
                        {
                            _DataRow = _DataResults.Rows[_Row2];
                            _ReturnValue += "<Data " +
                                            "Folio ='" + _ListNumFolio[_Row].ToString() + "' " +
                                            "Result ='" + (_DataRow["column1"].ToString()).ToString() + "' />";
                        }
                    }
                    else
                    {
                        _ReturnValue += "<Data Folio ='" + _ListNumFolio[_Row].ToString() + "' " +
                                        "Result ='Ocurrio Error en Sp_MoMarcaImpreso' />";
                    }
                }
            }
            _ReturnValue += "</Resultado>";
            return _ReturnValue;
        }

        [WebMethod]
        public string ActualizaCaEnc(List<string> _ListNumContrato)
        {
            DataTable _DataResults = new DataTable();
            int _Row, _Row2 = 0;
            DataRow _DataRow;
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
            _ReturnValue += "<Resultado>";

            if (_ListNumContrato.Count > 0)
            {
                for (_Row = 0; _Row < _ListNumContrato.Count; _Row++)
                {
                    _DataResults = Acciones.ResulDB_Ca(int.Parse((_ListNumContrato[_Row].ToString())));

                    if (_DataResults != null)
                    {
                        for (_Row2 = 0; _Row2 < _DataResults.Rows.Count; _Row2++)
                        {
                            _DataRow = _DataResults.Rows[_Row2];
                            _ReturnValue += "<Data " +
                                            "Contrato ='" + _ListNumContrato[_Row].ToString() + "' " +
                                            "Result ='" + (_DataRow["column1"].ToString()).ToString() + "' />";
                        }
                    }
                    else
                    {
                        _ReturnValue += "<Data Contrato ='" + _ListNumContrato[_Row].ToString() + "' " +
                                        "Result ='Ocurrio Error en Sp_CaMarcaImpreso' />";
                    }
                }
            }
            _ReturnValue += "</Resultado>";
            return _ReturnValue;
        }

        [WebMethod]
        public string ActualizaInicioDia(string fechaap, string fechaproxap, string user)
        {
            DataTable _DataResults = new DataTable();
            DataRow _DataRow;
            int _Row = 0;
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
            _ReturnValue += "<Resultado>";
            _DataResults = Acciones.InicioDiaProcesar(fechaap, fechaproxap, user);

            if (_DataResults != null)
            {
                for (_Row = 0; _Row < _DataResults.Rows.Count; _Row++)
                {
                    _DataRow = _DataResults.Rows[_Row];
                    _ReturnValue += "<Data " + "MsgStatus ='" + (_DataRow["Mensaje"].ToString()).ToString() + "' />";
                }
            }
            else
            {
                _ReturnValue += "<Data Result ='Ocurrio Error en dbo.Sp_Ini_Dia_Opc'/>";
            }

            _ReturnValue += "</Resultado>";
            return _ReturnValue;      
        }

        [WebMethod]
        public string ModificaCotiza(int numcontrato, int numcotizacion)
        {
            DataTable _DataResults = new DataTable();
            DataRow _DataRow;
            int _Row = 0;
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
            _ReturnValue += "<Resultado>";
            _DataResults = Acciones.ModificaCotizacion(numcontrato, numcotizacion);

            if (_DataResults != null)
            {
                for (_Row = 0; _Row < _DataResults.Rows.Count; _Row++)
                {
                    _DataRow = _DataResults.Rows[_Row];
                    _ReturnValue += "<Data " + "MsgStatus ='" + (_DataRow["Mensaje"].ToString()).ToString() + "' />";
                }
            }
            else
            {
                _ReturnValue += "<Data Result ='Ocurrio Error en dbo.Sp_Modifica_Por_Cotizacion'/>";
            }

            _ReturnValue += "</Resultado>";
            return _ReturnValue;
        }

        [WebMethod]
        public string DeshaceAnticipo(int numcontrato, int numfolio)
        {
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";

            try
            {
                DataTable _DataResults = new DataTable();
                DataRow _DataRow;
                int _Row = 0; 

                _ReturnValue += "<Resultado>";
                _DataResults = Acciones.DeshacerAnticipo(numcontrato, numfolio);

                if (_DataResults != null)
                {
                    for (_Row = 0; _Row < _DataResults.Rows.Count; _Row++)
                    {
                        _DataRow = _DataResults.Rows[_Row];
                        _ReturnValue += "<Data " + "MsgStatus ='" + (_DataRow["Mensaje"].ToString()).ToString() + "' />";
                    }
                    _ReturnValue += "</Resultado>";
                }
                else
                {
                    _ReturnValue += "<Data MsgStatus ='Ocurrio Error en Sp_Deshacer_Anticipo' />";
                    _ReturnValue += "</Resultado>";
                    //string _Mensaje = "<Data Result ='' />";
                    //_ReturnValue += _Mensaje;
                }
            }
            catch(Exception _Error)
            {
                _ReturnValue = string.Format("<?xml version=\"1.0\" encoding=\"utf-8\"?><Resultado><Data Error='2' MsgStatus='{0}' /></Resultado>", _Error.Message);
            }
            return _ReturnValue; 
        }
   
        [WebMethod]
        public string ActualizaFinDia()
        {
            DataTable _DataResults = new DataTable();
            DataRow _DataRow;
            int _Row = 0;
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
            _ReturnValue += "<Resultado>";

            _DataResults = Acciones.FinDiaProcesar();

            if (_DataResults != null)
            {
                for (_Row = 0; _Row < _DataResults.Rows.Count; _Row++)
                {
                    _DataRow = _DataResults.Rows[_Row];
                    _ReturnValue += "<Data " + "MsgStatus ='" + (_DataRow["MsgStatus"].ToString()).ToString() + "' />";
                }
            }
            else
            {
                _ReturnValue += "<Data Result ='Ocurrio Error en sp_Fin_dia_opc' />";
            }

            _ReturnValue += "</Resultado>";
            return _ReturnValue;
        }

        [WebMethod]
        public string ActualizaParam()
        {
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";

            try
            {
                DataTable _DataResults = new DataTable();
                DataRow _DataRow;
                int _Row = 0;

                _ReturnValue += "<Resultado>";
                _DataResults = Acciones.ActualizaParametro();

                if (_DataResults != null)
                {
                    for (_Row = 0; _Row < _DataResults.Rows.Count; _Row++)
                    {
                        _DataRow = _DataResults.Rows[_Row];
                        _ReturnValue += "<Data " + "MsgStatus ='" + (_DataRow["Mensaje"].ToString()).ToString() + "' />";
                        //_ReturnValue += "<Data " + "MsgStatus ='Actualización OK' />";
                    }
                    _ReturnValue += "</Resultado>";
                }
                else
                {
                    _ReturnValue += "<Data MsgStatus ='Ocurrio Error en Sp_ImportaDataBacParamSuda' />";
                    _ReturnValue += "</Resultado>";
                    //string _Mensaje = "<Data Result ='' />";
                    //_ReturnValue += _Mensaje;
                }
            }
            catch (Exception _Error)
            {
                _ReturnValue = string.Format("<?xml version=\"1.0\" encoding=\"utf-8\"?><Resultado><Data Error='2' MsgStatus='{0}' /></Resultado>", _Error.Message);
            }
            return _ReturnValue;
        }

        [WebMethod]
        public string ActualizaSumaVertical()
        {
            DataTable _DataResults = new DataTable();
            DataRow _DataRow;
            int _Row = 0;
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
            _ReturnValue += "<Resultado>";

            _DataResults = Acciones.SumaVertical();

            if (_DataResults != null)
            {
                for (_Row = 0; _Row < _DataResults.Rows.Count; _Row++)
                {
                    _DataRow = _DataResults.Rows[_Row];
                    _ReturnValue += "<Data " + "Mensaje ='" + (_DataRow["Mensaje"].ToString()).ToString() + "' />";
                }
            }
            else
            {
                _ReturnValue += "<Data Result ='Ocurrio Error en Sp_SumaValVertical' />";
            }

            _ReturnValue += "</Resultado>";
            return _ReturnValue;
        }

        [WebMethod]
        public string ActualizaCierreMesa(string usuario)
        {
            DataTable _DataResults = new DataTable();
            DataRow _DataRow;
            int _Row = 0;
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
            _ReturnValue += "<Resultado>";

            _DataResults = Acciones.CierreMesaProcesar(usuario);

            if (_DataResults != null)
            {
                for (_Row = 0; _Row < _DataResults.Rows.Count; _Row++)
                {
                    _DataRow = _DataResults.Rows[_Row];
                    _ReturnValue += "<Data " + "MsgStatus ='" + (_DataRow["MsgStatus"].ToString()).ToString() + "' />";
                }
            }
            else
            {
                _ReturnValue += "<Data Result ='Ocurrio Error en sp_Cierre_Abre_Mesa' />";
            }

            _ReturnValue += "</Resultado>";
            return _ReturnValue;
        }

        [WebMethod]
        public string ActualizaEstado(List<string> _ListNumContrato, string Usuario, string Estado)
        {
            DataTable _DataResults = new DataTable();
            int _Row, _Row2 = 0;
            DataRow _DataRow;
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
            _ReturnValue += "<Resultado>";

            if (_ListNumContrato.Count > 0)
            {
                for (_Row = 0; _Row < _ListNumContrato.Count; _Row++)
                {
                    _DataResults = Acciones.CambiaEstado(int.Parse((_ListNumContrato[_Row].ToString())), Usuario, Estado);

                    if (_DataResults != null)
                    {
                        for (_Row2 = 0; _Row2 < _DataResults.Rows.Count; _Row2++)
                        {
                            _DataRow = _DataResults.Rows[_Row2];
                            _ReturnValue += "<Data " +
                                            "Contrato ='" + _ListNumContrato[_Row].ToString() + "' " +
                                            "Fecha ='" + (_DataRow["FechaContrato"].ToString()).ToString() + "' " +
                                            "Result ='" + (_DataRow["Mensaje"].ToString()).ToString() + "' />";
                        }
                    }
                    else
                    {
                        _ReturnValue += "<Data Contrato ='" + _ListNumContrato[_Row].ToString() + "' " +
                                        "Result ='Ocurrio Error en Sp_Cambia_Estado' />";
                    }
                }
            }
            _ReturnValue += "</Resultado>";
            return _ReturnValue;
        }

        [WebMethod]
        public string InsertFix(List<string> _ListaFix)
        {
            int _Row2 = 0;
            DataRow _DataRow;
            DataTable _DataResults = new DataTable();
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
            _ReturnValue += "<Resultado>";

            if (_ListaFix.Count > 0)
            {
                _DataResults = Acciones.PrefijacionDatos(_ListaFix);

                if (_DataResults != null)
                {
                    for (_Row2 = 0; _Row2 < _DataResults.Rows.Count; _Row2++)
                    {
                        _DataRow = _DataResults.Rows[_Row2];
                        _ReturnValue += "<Data " +
                                        "Result ='" + (_DataRow["Resultado"].ToString()).ToString() + "' />";
                    }
                }
                else
                {
                    _ReturnValue += "<Data " + "Result ='-1' />";
                }
            }
             _ReturnValue += "</Resultado>";

            return _ReturnValue;
        }

        [WebMethod]
        public string InsertCondiciones(List<string> _ListaCond)
        {
            int _Row2 = 0;
            DataRow _DataRow;
            DataTable _DataResults = new DataTable();
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
            _ReturnValue += "<Resultado>";

            if (_ListaCond.Count > 0)
            {
                _DataResults = Acciones.InsertarCondGenerales(_ListaCond);

                if (_DataResults != null)
                {
                    for (_Row2 = 0; _Row2 < _DataResults.Rows.Count; _Row2++)
                    {
                        _DataRow = _DataResults.Rows[_Row2];
                        _ReturnValue += "<Data " + "Result ='Grabación OK' />";
                    }
                }
                else
                {
                    _ReturnValue += "<Data " + "Result ='-1' />";
                }
            }
            _ReturnValue += "</Resultado>";

            return _ReturnValue;
        }

        [WebMethod]
        public string ActualizaEstadoDecisionEj(List<string> _Lista)
        {
            DataTable _DataResults = new DataTable();
            int _Row2 = 0;
            DataRow _DataRow;
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";

            _ReturnValue += "<Resultado>";

            if (_Lista.Count > 0)
            {
                _DataResults = Acciones.CambiaDecisionEj(_Lista);

                if (_DataResults != null)
                {
                    for (_Row2 = 0; _Row2 < _DataResults.Rows.Count; _Row2++)
                    {
                        _DataRow = _DataResults.Rows[_Row2];
                        _ReturnValue += string.Format(
                                                       "<Data Estado='{0}' Mensaje='{1}' />",
                                                       _DataRow["Estado"].ToString(),
                                                       _DataRow["Mensaje"].ToString()
                                                     );
                    }
                }
                else
                {
                    _ReturnValue += string.Format(
                                                   "<Data Estado='{0}' Mensaje='{1}' />",
                                                   "----",
                                                   "Ocurrio un Error en Sp_Cambia_Decision"
                                                 );
                }
            }
            _ReturnValue += "</Resultado>";

            return _ReturnValue;
        }

        [WebMethod]
        public string InsertImpresion(string xmlValue)
        {
            XDocument _XmlValue = XDocument.Parse(xmlValue);
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
            DataTable _DTImpresion = Acciones.InsertImpresion(xmlValue);
            if (_DTImpresion.Rows.Count > 0)
            {
                _ReturnValue += string.Format(
                                               "<ID Error='0' Value='{0}' ReportCode='{1}' />",
                                               _DTImpresion.Rows[0]["ID"].ToString(),
                                               _XmlValue.Element("Options").Attribute("ReportCode").Value
                                             );
            }
            else
            {
                _ReturnValue += "<ID Error='1' />";
            }
            return _ReturnValue;
        }

        [WebMethod]
        public string InsertLogAuditoria(string xmlValue)
        {
            XDocument _XmlValue = XDocument.Parse(xmlValue);
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
            DataTable _DTLog = Acciones.InsertLogAuditoria(xmlValue);
            return _ReturnValue;
        }

        [WebMethod]
        public string ActualizaFormaPagoCompensacion(Int64 numeroContrato, Int64 numeroEstructura, string origen, int formaPago)
        {
            string _ReturnValue;
            DataTable _Result = cData.AccionesBD.Acciones.ActualizaFormaPagoCompensacion(numeroContrato, numeroEstructura, origen, formaPago);

            _ReturnValue = "<Result>";
            if (_Result.Rows.Count > 0)
            {
                _ReturnValue += "<ID Error='0' />";
                _ReturnValue += "<Status>";
                foreach (DataRow _DR in _Result.Rows)
                {
                    _ReturnValue += string.Format(
                                                   "<Item RegType='{0}' Error='{1}' FilasModificadas='{2}' />",
                                                   _DR["RegType"].ToString(),
                                                   _DR["Error"].ToString(),
                                                   _DR["FilasModificadas"].ToString()
                                                 );
                }
                _ReturnValue += "</Status>";
            }
            else
            {
                _ReturnValue += "<ID Error='1' />";
            }
            _ReturnValue += "</Result>";
            
            return _ReturnValue;
        }

        [WebMethod]
        public string ActualizaFormaPagoEntregaFisica(Int64 numeroContrato, Int64 numeroEstructura, int formaPagoPagar, int formaPagoRecibir)
        {
            string _ReturnValue;
            DataTable _Result = cData.AccionesBD.Acciones.ActualizaFormaPagoEntregaFisica(numeroContrato, numeroEstructura, formaPagoPagar, formaPagoRecibir);

            _ReturnValue = "<Result>";
            if (_Result.Rows.Count > 0)
            {
                _ReturnValue += "<ID Error='0' />";
                _ReturnValue += "<Status>";
                foreach (DataRow _DR in _Result.Rows)
                {
                    _ReturnValue += string.Format(
                                                   "<Item RegType='{0}' Error='{1}' FilasModificadas='{2}' />",
                                                   _DR["RegType"].ToString(),
                                                   _DR["Error"].ToString(),
                                                   _DR["FilasModificadas"].ToString()
                                                 );
                }
                _ReturnValue += "</Status>";
            }
            else
            {
                _ReturnValue += "<ID Error='1' />";
            }
            _ReturnValue += "</Result>";

            return _ReturnValue;
        }

        [WebMethod]
        public string CheckValuator(DateTime dateProcess)
        {
            string _Value = cData.AccionesBD.Acciones.CheckValuator(dateProcess);

            return string.Format("<CheckValue>{0}</CheckValue>", _Value);
        }

        [WebMethod]
        public string SaveLogAuditoria(DateTime FechaProceso, string terminal, string usuario, string codigomenu, string codigoevento, string detalletransaccion)
        {
            bool _Status = cData.Log.LogAuditoria.Save(FechaProceso, terminal, usuario, codigomenu, codigoevento, detalletransaccion);
            return _Status ? "OK" : "ERROR";
        }

        // Inico Rq_13090
        [WebMethod]
        public string SaveSolicitudSDA(string NumContrato, DateTime FechaIngreso, DateTime FecActivacion,
                                       string MontoAnticipo, string FormaPago, string TipoAnticipo)
        {                            
            DataTable _DataResults = new DataTable();
            string _Resultado = "";
            
            _DataResults = Acciones.InsertaSolicitudSDA(NumContrato, FechaIngreso, FecActivacion, MontoAnticipo, FormaPago, TipoAnticipo);

            try
            {
                if (_DataResults != null)
                {
                    _DataResults.TableName = "ResultadoIngSDA";
                    DataRow _p = _DataResults.Rows[0];
                    _Resultado = _p["Resultado"].ToString();
                }
                else
                {
                    _Resultado = "ERROR";
                }
            }
            catch (Exception)
            {}            
            return _Resultado;
        }

        [WebMethod]
        public string AnticipaOpConSDA( string fechaproxap, string user)
        {
            string _Resultado = "";
            DataTable _DataResults = new DataTable();
           
            _DataResults = Acciones.AnticipaOP_SDA(fechaproxap, user);

            try
            {
                if (_DataResults != null)
                {
                    _DataResults.TableName = "PreparaAnticipo";
                    DataRow _p = _DataResults.Rows[0];
                    _Resultado = _p["Resultado"].ToString();
                }
                else
                {
                    _Resultado = "ERROR";
                }
            }
            catch (Exception)
            { }
            return _Resultado;
        }

        [WebMethod]
        public string ValidaSDA(string NumContrato, DateTime FechaActivacion, string NumFolio)
        {
            string _ReturnValue = "";
            DataTable _DataResults = new DataTable();
            _DataResults = Acciones.ConValidacion_SDA(NumContrato, FechaActivacion, NumFolio);

            //string _ReturnValue;
            //DataTable _Result = cData.AccionesBD.Acciones.ActualizaFormaPagoCompensacion(numeroContrato, numeroEstructura, origen, formaPago);

            _ReturnValue = "<Result>";
            if (_DataResults.Rows.Count > 0)
            {
                _ReturnValue += "<ID Error='0' />";
                _ReturnValue += "<Status>";
                foreach (DataRow _DR in _DataResults.Rows)
                {
                    _ReturnValue += string.Format(
                                                   "<Item CaNumContrato='{0}' CaFechaVcto='{1}' CaMontoMon1='{2}' FechaVencSolicitud='{3}' TotalSolicitud='{4}' Fecha_Activacion='{5}'/>",
                                                   _DR["CaNumContrato"].ToString(),
                                                   _DR["CaFechaVcto"].ToString(),
                                                   _DR["CaMontoMon1"].ToString(),
                                                   _DR["FechaVencSolicitud"].ToString(),
                                                   _DR["TotalSolicitud"].ToString(),
                                                   _DR["Fecha_Activacion"].ToString()
                                                 );
                }
                _ReturnValue += "</Status>";
            }
            else
            {
                _ReturnValue += "<ID Error='1' />";
            }
            _ReturnValue += "</Result>";
            return _ReturnValue;
        }

        [WebMethod]
        public string AnulaSDA(string NumContrato, string NumFolio)
        {
            string _Resultado = "";
            DataTable _DataResults = new DataTable();
            _DataResults = Acciones.Anula_SDA(NumContrato, NumFolio);

            try
            {
                if (_DataResults != null)
                {
                    _DataResults.TableName = "AnulaSDA";
                    DataRow _p = _DataResults.Rows[0];
                    _Resultado = _p["Resultado"].ToString();
                }
                else
                {
                    _Resultado = "ERROR";
                }
            }
            catch (Exception)
            { }
            return _Resultado;
        }

        [WebMethod]
        public string ModificaSolicitudSDA(string NumFolio,string NumContrato, DateTime FechaIngreso, DateTime FecActivacion,
                                           string MontoAnticipo, string FormaPago, string TipoAnticipo)
        {
            DataTable _DataResults = new DataTable();
            string _Resultado = "";

            _DataResults = Acciones.ModicicaSolicitudSDA(NumFolio,NumContrato, FechaIngreso, FecActivacion, MontoAnticipo, FormaPago, TipoAnticipo);

            try
            {
                if (_DataResults != null)
                {
                    _DataResults.TableName = "ResultadoIngSDA";
                    DataRow _p = _DataResults.Rows[0];
                    _Resultado = _p["Resultado"].ToString();
                }
                else
                {
                    _Resultado = "ERROR";
                }
            }
            catch (Exception)
            { }
            return _Resultado;
        }
        //Fin Rq_13090

        //Prd_16803
        //[WebMethod]
        //public string GrabaListaLeasing(string ArrayLeasing,string FechaProceso)
        //{
        //    DataTable _DataResults;
        //    string _Resultado = "";

        //    _DataResults = Acciones.GrabaListaLeasing(ArrayLeasing, FechaProceso);

        //    try
        //    {
        //        if (_DataResults != null)
        //        {
        //            _DataResults.TableName = "ListaLeasing";
        //            DataRow _p = _DataResults.Rows[0];
        //            _Resultado = _p["Resultado"].ToString();
        //        }
        //        else
        //        {
        //            _Resultado = "-1"; // Error al Grabar
        //        }
        //    }
        //    catch (Exception)
        //    { }
        //    return _Resultado;
        //}

        //[WebMethod]
        //public string ValidaFechaListaLeasing(string FechaProceso)
        //{
        //    DataTable _DataResults;
        //    string _Resultado = "";

        //    _DataResults = Acciones.ValidaFechaListaLeasing(FechaProceso);

        //    try
        //    {
        //        if (_DataResults != null)
        //        {
        //            _DataResults.TableName = "FechaLeasing";
        //            DataRow _p = _DataResults.Rows[0];
        //            _Resultado = _p["Resultado"].ToString();
        //        }
        //        else
        //        {
        //            _Resultado = "-1"; // Error al Grabar
        //        }
        //    }
        //    catch (Exception)
        //    { }
        //    return _Resultado;
        //}

    }
}