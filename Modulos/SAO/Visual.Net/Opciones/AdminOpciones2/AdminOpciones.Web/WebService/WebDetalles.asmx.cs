using System.Data;
using System.Web.Services;
using cData.Detalles;
using System;
using cFinancialTools.BussineDate;
 
namespace AdminOpciones.Web.WebService
{
    /// <summary>
    /// Descripción breve de WebDetalles
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class WebDetalles : System.Web.Services.WebService
    {
        [WebMethod]
        public string MoEncContrato(int rut, int codigo, string tipocontrato)
        {
            DataTable _DataResults = new DataTable();
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";

            try
            {
                _DataResults = svcDetalles.dMoEncContrato(rut, codigo, tipocontrato);

                if (_DataResults != null)
                {
                    _ReturnValue += "<MoEncContrato Error='0' Message='' >";
                    foreach (DataRow _DataRow in _DataResults.Rows)
                    {
                        _ReturnValue += string.Format(
                                                       "<Data VF='{0}' Objeto='{1}' NumContrato='{2}' NumFolio='{3}' FechaContrato='{4}' ConOpcEstCod='{5}' " +
                                                       "ConOpcEstDsc='{6}' CliRut='{7}' CliCod='{8}' CliDv='{9}' CliNom='{10}' Operador='{11}' OpcEstCod='{12}' " +
                                                       "OpcEstDsc='{13}' TipoTransaccion='{14}' Contrapartida='{15}' FechaCreacionRegistro='{16}' " +
                                                       "Impreso='{17}' />",
                                                       "False",                                         // 00
                                                       _DataRow["objeto"].ToString(),                   // 01
                                                       _DataRow["numcontrato"].ToString(),              // 02
                                                       _DataRow["numfolio"].ToString(),                 // 03
                                                       _DataRow["fechacontrato"].ToString(),            // 04
                                                       _DataRow["conopcestcod"].ToString(),             // 05
                                                       _DataRow["conopcestdsc"].ToString(),             // 06
                                                       _DataRow["clirut"].ToString(),                   // 07
                                                       _DataRow["clicod"].ToString(),                   // 08
                                                       _DataRow["clidv"].ToString(),                    // 09
                                                       _DataRow["clinom"].ToString(),                   // 10
                                                       _DataRow["operador"].ToString(),                 // 11
                                                       _DataRow["opcestcod"].ToString(),                // 12
                                                       _DataRow["opcestdsc"].ToString(),                // 13
                                                       _DataRow["tipotransaccion"].ToString(),          // 14
                                                       _DataRow["contrapartida"].ToString(),            // 15
                                                       _DataRow["fechacreacionregistro"].ToString(),    // 16
                                                       _DataRow["impreso"].ToString()                   // 17
                                                     );

                    }
                    _ReturnValue += "</MoEncContrato>";
                }
                else
                {
                    _ReturnValue = "<MoEncContrato Error='1' Message='Ocurrio Error en Sp_MoEncContrato' />";
                }
            }
            catch (Exception _Error)
            {
                _ReturnValue = string.Format("<MoEncContrato Error='1' Message='{0}' />", _Error.Message);
            }
            return _ReturnValue;
        }

        [WebMethod]
        public string CaEncContrato(int cliRut, int cliCodigo, int Estado, string fContratoIni, string fContratoFin, string fEjercicioIni, string fEjercicioFin,string Relacionado)
        {
            DataTable _DataResults = new DataTable();
            int _Row = 0;
            DataRow _DataRow;
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";

            _DataResults = svcDetalles.dCaEncContrato(cliRut, cliCodigo, Estado, fContratoIni, fContratoFin, fEjercicioIni, fEjercicioFin, Relacionado);
            _ReturnValue += "<CaEncContrato>";            

            if (_DataResults != null)
            {
                for (_Row = 0; _Row < _DataResults.Rows.Count; _Row++)
                {
                    _DataRow = _DataResults.Rows[_Row];
                    _ReturnValue +=  "<Data " +
                                     "VF ='False' " +
                                     "Objeto ='" + (_DataRow["objeto"].ToString()).ToString() + "' " +
                                     "NumContrato ='" + (_DataRow["numcontrato"].ToString()).ToString() + "' " +
                                     "TipoTransaccion ='" + (_DataRow["TipoTransaccion"].ToString()).ToString() + "' " +
                                     "NumFolio ='" + (_DataRow["numfolio"].ToString()).ToString() + "' " +
                                     "FechaContrato ='" + (_DataRow["fechacontrato"].ToString()).ToString() + "' " +
                                     "ConOpcEstCod ='" + (_DataRow["conopcestcod"].ToString()).ToString() + "' " +
                                     "ConOpcEstDsc ='" + (_DataRow["conopcestdsc"].ToString()).ToString() + "' " +
                                     "CliRut ='" + (_DataRow["clirut"].ToString()).ToString() + "' " +
                                     "CliCod ='" + (_DataRow["clicod"].ToString()).ToString() + "' " +
                                     "CliDv ='" + (_DataRow["clidv"].ToString()).ToString() + "' " +
                                     "CliNom ='" + (_DataRow["clinom"].ToString()).ToString() + "' " +
                                     "Operador ='" + (_DataRow["operador"].ToString()).ToString() + "' " +
                                     "OpcEstCod ='" + (_DataRow["opcestcod"].ToString()).ToString() + "' " +
                                     "OpcEstDsc ='" + (_DataRow["opcestdsc"].ToString()).ToString() + "' " +
                                     "PayOffCod ='" + (_DataRow["pay_offcod"].ToString()).ToString() + "' " +
                                     "Contrapartida ='" + (_DataRow["contrapartida"].ToString()).ToString() + "' />";
                }
            }
            else
            {
                string _Mensaje = "<Data Result ='Ocurrio Error en Sp_CaEncContrato' />";
                _ReturnValue += _Mensaje;
            }
            _ReturnValue += "</CaEncContrato>";
            return _ReturnValue;
        }

        [WebMethod]
        public string RetornaFix(string F1, string F2, int NumContrato, string Usuario)
        {
            DataTable _DataResults = new DataTable();
            int _Row = 0;
            DataRow _DataRow;
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";

            _DataResults = svcDetalles.dSpCaFixDesdeHastaOpt(F1, F2, NumContrato, Usuario);
            _ReturnValue += "<RetornaFix>";

            if (_DataResults != null)
            {
                for (_Row = 0; _Row < _DataResults.Rows.Count; _Row++)
                {
                    _DataRow = _DataResults.Rows[_Row];
                    _ReturnValue += "<Data " +
                                     "NumContrato ='" + (_DataRow["numcontrato"].ToString()).ToString() + "' " +
                                     "FechaFijacion ='" + (_DataRow["fechafijacion"].ToString()).ToString() + "' " +
                                     "OpcEstDsc ='" + (_DataRow["opcestdsc"].ToString()).ToString() + "' " +
                                     "OpcEstCod ='" + (_DataRow["opcestcod"].ToString()).ToString() + "' " +
                                     "CliRut ='" + (_DataRow["clirut"].ToString()).ToString() + "' " +
                                     "CliDv ='" + (_DataRow["clidv"].ToString()).ToString() + "' " +
                                     "CliCod ='" + (_DataRow["clicod"].ToString()).ToString() + "' " +
                                     "CliNom ='" + (_DataRow["clinom"].ToString()).ToString() + "' " +
                                     "NumComponente ='" + (_DataRow["numcomponente"].ToString()).ToString() + "' " +
                                     "PayOffTipDsc ='" + (_DataRow["payofftipdsc"].ToString()).ToString() + "' " +
                                     "CallPut ='" + (_DataRow["callput"].ToString()).ToString() + "' " +
                                     "CompraVentaOpcDsc ='" + (_DataRow["compraventaopcdsc"].ToString()).ToString() + "' " +
                                     "FechaPagoEjer ='" + (_DataRow["fechapagoejer"].ToString()).ToString() + "' " +
                                     "Mon1Dsc ='" + (_DataRow["mon1dsc"].ToString()).ToString() + "' " +
                                     "ModalidadDsc ='" + (_DataRow["modalidaddsc"].ToString()).ToString() + "' " +
                                     "MdaCompensacionDsc ='" + (_DataRow["mdacompensaciondsc"].ToString()).ToString() + "' " +
                                     "Strike ='" + (_DataRow["strike"].ToString()).ToString() + "' " +
                                     "PesoFijacion ='" + (_DataRow["pesofijacion"].ToString()).ToString() + "' " +
                                     "FixBenchCompDsc ='" + (_DataRow["fixbenchcompdsc"].ToString()).ToString() + "' " +
                                     "FixParBench ='" + (_DataRow["fixparbench"].ToString()).ToString() + "' " +
                                     "FixBenchCompHora ='" + (_DataRow["fixbenchcomphora"].ToString()).ToString() + "' " +
                                     "FixValorFijacion ='" + (_DataRow["fixValorfijacion"].ToString()).ToString() + "' " +
                                     "FixBenchMdaCodValorDefValor ='" + (_DataRow["fixbenchmdacodvalordefvalor"].ToString()).ToString() + "' " +
                                     "Refijable ='" + (_DataRow["refijable"].ToString()).ToString() + "' " +
                                     "FixBenchEsEditable ='" + (_DataRow["fixbencheseditable"].ToString()).ToString() + "' " +
                                     "NumeroFijacion ='" + (_DataRow["numerofijacion"].ToString()).ToString() + "' />"; 

                  }
            }
            else
            {
                string _Mensaje = "<Data Result ='Ocurrio Error en Sp_CaFixDesdeHastaOpt' />";
                _ReturnValue += _Mensaje;
            }
            _ReturnValue += "</RetornaFix>";
            return _ReturnValue;
        }

        [WebMethod]
        public string DecisionEjercicio(string F1, string F2, int clirut, int clicod, string usuario)
        {
            DataTable _DataResults = new DataTable();
            int _Row = 0;
            DataRow _DataRow;
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";

            _DataResults = svcDetalles.dSpGridDecisionEjercicio(F1, F2, clirut, clicod, usuario);
            _ReturnValue += "<RetornaEjercicio>";

            if (_DataResults != null)
            {
                for (_Row = 0; _Row < _DataResults.Rows.Count; _Row++)
                {
                    _DataRow = _DataResults.Rows[_Row];
                    _ReturnValue += "<Data " +
                                     "VF ='False' " +
                                     "NumContrato = '" + (_DataRow["numcontrato"].ToString()).ToString() + "' " +
                                     "FechaPagoEjer = '" + (_DataRow["fechapagoejer"].ToString()).ToString() + "' " +
                                     "ModalidadDsc = '" + (_DataRow["modalidaddsc"].ToString()).ToString() + "' " +
                                     "CliRut = '" + (_DataRow["clirut"].ToString()).ToString() + "' " +
                                     "CliDv = '" + (_DataRow["clidv"].ToString()).ToString() + "' " +
                                     "CliCod = '" + (_DataRow["clicod"].ToString()).ToString() + "' " +
                                     "CliNom = '" + (_DataRow["clinom"].ToString()).ToString() + "' " +
                                     "NumComponente = '" + (_DataRow["numcomponente"].ToString()).ToString() + "' " +
                                     "NumCajFolio = '" + (_DataRow["numcajfolio"].ToString()).ToString() + "' " +
                                     "PayOffTipCod = '" + (_DataRow["payofftipcod"].ToString()).ToString() + "' " +
                                     "PayOffTipDsc = '" + (_DataRow["payofftipdsc"].ToString()).ToString() + "' " +
                                     "CompraVentaOpcDsc = '" + (_DataRow["compraventaopcdsc"].ToString()).ToString() + "' " +
                                     "MdaRecibirDsc = '" + (_DataRow["mdarecibirdsc"].ToString()).ToString() + "' " +
                                     "FormaPagoRecibirDsc = '" + (_DataRow["formapagorecibirdsc"].ToString()).ToString() + "' " +
                                     "MontoRecibir = '" + (_DataRow["montorecibir"].ToString()).ToString() + "' " +
                                     "MdaPagarDsc = '" + (_DataRow["mdapagardsc"].ToString()).ToString() + "' " +
                                     "FormaPagoPagarDsc = '" + (_DataRow["formapagopagardsc"].ToString()).ToString() + "' " +
                                     "MontoPagar = '" + (_DataRow["montopagar"].ToString()).ToString() + "' " +
                                     "MTMImplicito = '" + (_DataRow["mtmimplicito"].ToString()).ToString() + "' " +
                                     "EstadoEjercicioDsc = '" + (_DataRow["estadoejerciciodsc"].ToString()).ToString() + "' />";

                }
            }
            else
            {
                string _Mensaje = "<Data Result ='Ocurrio Error en Sp_GridDecisionEjercicio' />";
                _ReturnValue += _Mensaje;
            }
            _ReturnValue += "</RetornaEjercicio>";
            return _ReturnValue;
        }

        [WebMethod]
        public string CaLiquidacion( int clirut, int clicod, string F1, string F2, string estado, string usuario)
        {
            DataTable _DataResults = new DataTable();
            int _Row = 0;
            DataRow _DataRow;
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";

            _DataResults = svcDetalles.dSpGridCaLiquidaciones(clirut, clicod, F1, F2, estado, usuario);
            _ReturnValue += "<RetornaLiquidacion>";

            if (_DataResults != null)
            {
                for (_Row = 0; _Row < _DataResults.Rows.Count; _Row++)
                {
                    _DataRow = _DataResults.Rows[_Row];
                    _ReturnValue += "<Data " +
                                     "VF ='False' " +
                                     "NumContrato = '" + (_DataRow["numcontrato"].ToString()).ToString() + "' " +
                                     "FechaEjercicio = '" + (_DataRow["fechaejercicio"].ToString()).ToString() + "' " +
                                     "FechaContrato = '" + (_DataRow["fechacontrato"].ToString()).ToString() + "' " +
                                     "CliRut = '" + (_DataRow["clirut"].ToString()).ToString() + "' " +
                                     "CliDv = '" + (_DataRow["clidv"].ToString()).ToString() + "' " +
                                     "CliCod = '" + (_DataRow["clicod"].ToString()).ToString() + "' " +
                                     "CliNom = '" + (_DataRow["clinom"].ToString()).ToString() + "' " +
                                     "Estado = '" + (_DataRow["estado"].ToString()).ToString() + "' " +
                                     "Contrapartida = '" + (_DataRow["contrapartida"].ToString()).ToString() + "' " +
                                     "Operador = '" + (_DataRow["operador"].ToString()).ToString() + "' " +
                                     "ModalidadDsc = '" + (_DataRow["modalidaddsc"].ToString()).ToString() + "' " +
                                     "OrigenDsc = '" + (_DataRow["origendsc"].ToString()).ToString() + "' " +
                                     "Mda1Dsc = '" + (_DataRow["mda1dsc"].ToString()).ToString() + "' " +
                                     "Mda1Mto = '" + (_DataRow["mda1mto"].ToString()).ToString() + "' " +
                                     "Mda2Dsc = '" + (_DataRow["mda2dsc"].ToString()).ToString() + "' " +
                                     "Mda2Mto = '" + (_DataRow["mda2mto"].ToString()).ToString() + "' " +
                                     "CodEstructura = '" + (_DataRow["CodEstructura"].ToString()).ToString() + "' " +
                                     "TipoTransaccion = '" + (_DataRow["TipoTransaccion"].ToString()).ToString() + "' " +   //PRD_12567 Papeleta Asiaticos
                                     "TipoPayOff = '" + (_DataRow["TipoPayOff"].ToString()).ToString() + "' " +             //PRD_12567 Papeleta Asiaticos
                                     "TipoBfwOpt = '" + (_DataRow["TipoBfwOpt"].ToString()).ToString() + "' />";            //PRD_12567 Papeleta Asiaticos
                }
            }
            else
            {
                string _Mensaje = "<Data Result ='Ocurrio Error en Sp_GridCaLiquidaciones' />";
                _ReturnValue += _Mensaje;
            }
            _ReturnValue += "</RetornaLiquidacion>";
            return _ReturnValue;
        }

        [WebMethod]
        public string VerificaFixingPendientes()
        {
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";

            try
            {
                DataTable _DataResults = new DataTable();
                _DataResults = svcDetalles.VerificaFixingPendientes();

                if (_DataResults != null)
                {
                    _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
                    foreach (DataRow _DataRow in _DataResults.Rows)
                    {
                        _ReturnValue += string.Format("<Status ID='0' Message='{0}' />", _DataRow["STATUS"].ToString());
                    }
                }
                else
                {
                    _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
                    _ReturnValue += "<Status ID='1' Message='Error no definido' />";
                }

            }
            catch (Exception e)
            {
                _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
                _ReturnValue += string.Format("<Status ID='1' Message='{0}' />", e.Message);
            }

            return _ReturnValue;
        }

        [WebMethod]
        public string CaPagosComp(int clirut, int clicod, string F1, string F2)
        {
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";

            try
            {
                DataTable _DataResults = new DataTable();
                int _Row = 0;
                DataRow _DataRow;

                _DataResults = svcDetalles.dSpGridCaPagosCompensados(clirut, clicod, F1, F2);

                if (_DataResults != null)
                {
                    _ReturnValue += "<RetornaPagos Error='0' Message='' >";
                    for (_Row = 0; _Row < _DataResults.Rows.Count; _Row++)
                    {
                        _DataRow = _DataResults.Rows[_Row];
                        _ReturnValue += "<Data " +
                                         "VF ='False' " +
                                         "NumContrato = '" + (_DataRow["numcontrato"].ToString()).ToString() + "' " +
                                         "NumEstructura = '" + (_DataRow["numestructura"].ToString()).ToString() + "' " +
                                         "FechaEjercicio = '" + (_DataRow["fechaejercicio"].ToString()).ToString() + "' " +
                                         "FechaContrato = '" + (_DataRow["fechacontrato"].ToString()).ToString() + "' " +
                                         "CliRut = '" + (_DataRow["clirut"].ToString()).ToString() + "' " +
                                         "CliDv = '" + (_DataRow["clidv"].ToString()).ToString() + "' " +
                                         "CliCod = '" + (_DataRow["clicod"].ToString()).ToString() + "' " +
                                         "CliNom = '" + (_DataRow["clinom"].ToString()).ToString() + "' " +
                                         "MdaCompDsc = '" + (_DataRow["mdacompdsc"].ToString()).ToString() + "' " +
                                         "FormaPagoCompCod = '" + (_DataRow["FormaPagoCompCod"].ToString()) + "' " +
                                         "FormaPagoCompDsc = '" + (_DataRow["formapagocompdsc"].ToString()).ToString() + "' " +
                                         "MontoRecibir = '" + (_DataRow["montorecibir"].ToString()).ToString() + "' " +
                                         "MontoPagar = '" + (_DataRow["montopagar"].ToString()).ToString() + "' " +
                                         "OrigenCod = '" + (_DataRow["OrigenCod"].ToString()) + "' " +
                                         "OrigenDsc = '" + (_DataRow["origendsc"].ToString()).ToString() + "' " +
                                         // MAP 04 Septiembre 2009 Se agrega Campo.
                                         "Temporalidad = '" + (_DataRow["temporalidad"].ToString()).ToString() + "' " + 
                                         "VctoValuta = '" + (_DataRow["VctoValuta"].ToString()).ToString() + "' " +
                                         // ASVG_20110322 Para diferenciar reportes de vencimiento/pagos compensados.
                                         "CodEstructura = '" + (_DataRow["CodEstructura"].ToString()).ToString() + "' " +
                                         "TipoTransaccion = '" + (_DataRow["TipoTransaccion"].ToString()).ToString() + "' " + //PRD_12567 Papeleta Asiaticos
                                         "TipoPayOff = '" + (_DataRow["TipoPayOff"].ToString()).ToString() + "' " +           //PRD_12567 Papeleta Asiaticos
                                         "TipoBfwOpt = '" + (_DataRow["TipoBfwOpt"].ToString()).ToString() + "' />";          //PRD_12567 Papeleta Asiaticos                                                                          ///
                    }                   
                    _ReturnValue += "</RetornaPagos>";
                }
                else
                {
                    _ReturnValue += "<RetornaPagos Error='1' Message='Ocurrio Error en Sp_GridCaPagosCompensados' />";
                    //string _Mensaje = "<Data Result ='' />";
                    //_ReturnValue += _Mensaje;
                }
            }
            catch(Exception _Error)
            {
                _ReturnValue = string.Format("<?xml version=\"1.0\" encoding=\"utf-8\"?><RetornaPagos Error='2' Message='{0}' />", _Error.Message);
            }
            return _ReturnValue;
        }

        [WebMethod]
        public string CaPagosEntrega(int clirut, int clicod, string F1, string F2)
        {
            DataTable _DataResults = new DataTable();
            int _Row = 0;
            DataRow _DataRow;
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";

            _DataResults = svcDetalles.dSpGridCaPagosEntregaFisica(clirut, clicod, F1, F2);
            _ReturnValue += "<RetornaPagos>";

            if (_DataResults != null)
            {
                for (_Row = 0; _Row < _DataResults.Rows.Count; _Row++)
                {
                    _DataRow = _DataResults.Rows[_Row];
                    _ReturnValue += "<Data " +
                                     "VF ='False' " +
                                     "NumContrato = '" + (_DataRow["numcontrato"].ToString()).ToString() + "' " +
                                     "NumEstructura = '" + (_DataRow["numestructura"].ToString()).ToString() + "' " +
                                     "FechaEjercicio = '" + (_DataRow["fechaejercicio"].ToString()).ToString() + "' " +
                                     "FechaContrato = '" + (_DataRow["fechacontrato"].ToString()).ToString() + "' " +
                                     "CliRut = '" + (_DataRow["clirut"].ToString()).ToString() + "' " +
                                     "CliDv = '" + (_DataRow["clidv"].ToString()).ToString() + "' " +
                                     "CliCod = '" + (_DataRow["clicod"].ToString()).ToString() + "' " +
                                     "CliNom = '" + (_DataRow["clinom"].ToString()).ToString() + "' " +
                                     "MdaRecibirDsc = '" + (_DataRow["mdarecibirdsc"].ToString()).ToString() + "' " +
                                     "FormaPagoRecibirCod = '" + (_DataRow["FormaPagoRecibirCod"].ToString()).ToString() + "' " +
                                     "FormaPagorecibirDsc = '" + (_DataRow["formapagorecibirdsc"].ToString()).ToString() + "' " +
                                     "MontoRecibir = '" + (_DataRow["montorecibir"].ToString()).ToString() + "' " +
                                     "MdaPagarDsc = '" + (_DataRow["mdapagardsc"].ToString()).ToString() + "' " +
                                     "MontoPagar = '" + (_DataRow["montopagar"].ToString()).ToString() + "' " +
                                     "FormaPagoPagarCod = '" + (_DataRow["FormaPagoPagarCod"].ToString()).ToString() + "' " +
                                     "FormaPagoPagarDsc = '" + (_DataRow["formapagopagardsc"].ToString()).ToString() + "' " +
                                     "Temporalidad = '" + (_DataRow["temporalidad"].ToString()).ToString() + "' " +
                                     "MTMImplicito = '" + (_DataRow["mtmimplicito"].ToString()).ToString() + "' " +
                                     "VctoValutaRecibir = '" + (_DataRow["VctoValutaRecibir"].ToString()).ToString() + "' " +
                                     "VctoValutaPagar = '" + (_DataRow["VctoValutaPagar"].ToString()).ToString() + "' " +
                                     // ASVG_20110322 Para diferenciar reportes de vencimiento/pagos entrega física.
                                     "CodEstructura = '" + (_DataRow["CodEstructura"].ToString()).ToString() + "' " +
                                     "TipoBfwOpt = '" + (_DataRow["TipoBfwOpt"].ToString()).ToString() + "' />";
                }
            }
            else
            {
                string _Mensaje = "<Data Result ='Ocurrio Error en Sp_GridCaPagosEntregaFisica' />";
                _ReturnValue += _Mensaje;
            }
            _ReturnValue += "</RetornaPagos>";
            return _ReturnValue;
        }

        [WebMethod]
        public string InicioDia(string fechaProc, string fechaAnt, string fechaProx, int iniciodia)
        {
            try
            {
                AdminOpcionesTool.Debug d = new AdminOpcionesTool.Debug("InicioDia");
                d.Log(fechaProc);
                d.Log(iniciodia.ToString());
                d.LogClose();
            }
            catch (Exception e)
            {
            }

            DataTable _DataResults = new DataTable();
            int _Row = 0;
            DataRow _DataRow;
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";

            _DataResults = svcDetalles.ResulDB_IniDia(fechaProc, fechaAnt, fechaProx, iniciodia);
            _ReturnValue += "<InicioDia>";

            if (_DataResults != null)
            {
                for (_Row = 0; _Row < _DataResults.Rows.Count; _Row++)
                {
                    _DataRow = _DataResults.Rows[_Row];
                   
                    _ReturnValue += string.Format(
                                                   "<Data Status='{0}' FechaProc='{1}' FechaAnt='{2}' FechaProx='{3}' InicioDia='{4}' CierreMesa='{5}' FinDia='{6}' />",
                                                   _DataRow["Status"].ToString(),
                                                   _DataRow["fechaproc"].ToString(),
                                                   _DataRow["fechaant"].ToString(),
                                                   _DataRow["fechaprox"].ToString(),
                                                   _DataRow["iniciodia"].ToString(),
                                                   _DataRow["CierreMesa"].ToString(),
                                                   _DataRow["findia"].ToString()
                                                 );
                }
            }
            else
            {
                string _Mensaje = "<Data Status='Ocurrio Error en Sp_OpcionesGeneral_Fechas' />";
                _ReturnValue += _Mensaje;
            }
            _ReturnValue += "</InicioDia>";

            try
            {
                AdminOpcionesTool.Debug d = new AdminOpcionesTool.Debug("InicioDia");
                d.Log(_ReturnValue);
                d.LogClose();
            }
            catch (Exception e)
            {
            }

            return _ReturnValue;
        }

        [WebMethod]
        public string FechaProxH(string fechaProx, string fechaRet)
        {
            DataTable _DataResults = new DataTable();
            int _Row = 0;
            DataRow _DataRow;
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";

            _DataResults = svcDetalles.ResulDB_FechaProxHabil(fechaProx, fechaRet);
            _ReturnValue += "<FechaProxH>";

            if (_DataResults != null)
            {
                for (_Row = 0; _Row < _DataResults.Rows.Count; _Row++)
                {
                    _DataRow = _DataResults.Rows[_Row];
                    _ReturnValue += "<Data " +
                                     "FechaProx ='" + (_DataRow["FechaProx"].ToString()).ToString() + "' " +
                                     "FechaRet ='" + (_DataRow["Fecha"].ToString()).ToString() + "' />";
                }
            }
            else
            {
                string _Mensaje = "<Data Result ='Ocurrio Error en Sp_Fecha_Proxima_Habil' />";
                _ReturnValue += _Mensaje;
            }
            _ReturnValue += "</FechaProxH>";
            return _ReturnValue;
        }

        [WebMethod]
        public string RetornaCierreMesa(string fechaProc)
        {
            DataTable _DataResults = new DataTable();
            int _Row = 0;
            DataRow _DataRow;
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";

            _DataResults = svcDetalles.CierreMesa(fechaProc);
            _ReturnValue += "<CierreMesa>";

            if (_DataResults != null)
            {
                for (_Row = 0; _Row < _DataResults.Rows.Count; _Row++)
                {
                    _DataRow = _DataResults.Rows[_Row];
                    _ReturnValue += "<Data " +
                                     "CierreMesa ='" + (_DataRow["CierreMesa"].ToString()).ToString() + "' />";
                }
            }
            else
            {
                string _Mensaje = "<Data Result ='Ocurrio Error en Sp_OpcionesGeneral_Mesa' />";
                _ReturnValue += _Mensaje;
            }
            _ReturnValue += "</CierreMesa>";
            return _ReturnValue;
        }

        [WebMethod]
        public string FechaAntH(string fechaProx, string fechaRet)
        {
            DataTable _DataResults = new DataTable();
            int _Row = 0;
            DataRow _DataRow;
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";

            _DataResults = svcDetalles.ResulDB_FechaAnteriorHabil(fechaProx, fechaRet);
            _ReturnValue += "<FechaAntH>";

            if (_DataResults != null)
            {
                for (_Row = 0; _Row < _DataResults.Rows.Count; _Row++)
                {
                    _DataRow = _DataResults.Rows[_Row];
                    _ReturnValue += "<Data " +
                                     "FechaAnterior ='" + (_DataRow["FechaAnt"].ToString()).ToString() + "' />";
                                     
                }
            }
            else
            {
                string _Mensaje = "<Data Result ='Ocurrio Error en Sp_Fecha_Anterior_Habil' />";
                _ReturnValue += _Mensaje;
            }
            _ReturnValue += "</FechaAntH>";
            return _ReturnValue;
        }

        #region "Servicios directos por medio de DataTables"

        [WebMethod]
        public DataTable InterContableOpc()
        {
            DataTable _DataResults = new DataTable();            
            _DataResults = svcDetalles.dSpInterContableOpc();           
            if (_DataResults == null)
            {                                                          
                DataRow _row ;
                DataColumn _colum;
                _colum = new DataColumn();
                
                _colum.DataType = System.Type.GetType("System.String");
                _colum.ColumnName = "Resu";              
                _colum.Caption = "Resultado";

                _row = _DataResults.NewRow();
                _row["Resu"] = "Ocurrio Error en sp_inter_contable_opc";

                _DataResults.TableName = "Resultado";
                _DataResults.Columns.Add(_colum);                
                _DataResults.Rows.Add(_row);
            }

            return _DataResults;
        }

        [WebMethod]
        public DataTable InterfazDerivadosOpciones()
        {
            DataTable _DataResults = new DataTable();
            _DataResults = svcDetalles.dSpInterfazDerivadosOpciones();
            if (_DataResults == null)
            {
                DataRow _row;
                DataColumn _colum;
                _colum = new DataColumn();

                _colum.DataType = System.Type.GetType("System.String");
                _colum.ColumnName = "Resu";
                _colum.Caption = "Resultado";

                _row = _DataResults.NewRow();
                _row["Resu"] = "Ocurrio Error en Sp_Interfaz_derivados_Opciones";

                _DataResults.TableName = "Resultado";
                _DataResults.Columns.Add(_colum);
                _DataResults.Rows.Add(_row);
            }

            return _DataResults;
        }

        [WebMethod]
        public DataTable InterfazOperacionesOpciones()
        {
            DataTable _DataResults = new DataTable();
            _DataResults = svcDetalles.dSpInterfazOperacionesOpciones();
            if (_DataResults == null)
            {
                DataRow _row;
                DataColumn _colum;
                _colum = new DataColumn();

                _colum.DataType = System.Type.GetType("System.String");
                _colum.ColumnName = "Resu";
                _colum.Caption = "Resultado";

                _row = _DataResults.NewRow();
                _row["Resu"] = "Ocurrio Error en Sp_Interfaz_operaciones_Opciones";

                _DataResults.TableName = "Resultado";
                _DataResults.Columns.Add(_colum);
                _DataResults.Rows.Add(_row);
            }

            return _DataResults;
        }

        [WebMethod]
        public DataTable InterfazBalanceOpciones() 
        {
            DataTable _DataResults = new DataTable();
            _DataResults = svcDetalles.dSpInterfazBalanceOpciones();
            if (_DataResults == null)
            {
                DataRow _row;
                DataColumn _colum;
                _colum = new DataColumn();

                _colum.DataType = System.Type.GetType("System.String");
                _colum.ColumnName = "Resu";
                _colum.Caption = "Resultado";

                _row = _DataResults.NewRow();
                _row["Resu"] = "Ocurrio Error en sp_interfaz_balance_opciones";

                _DataResults.TableName = "Resultado";
                _DataResults.Columns.Add(_colum);
                _DataResults.Rows.Add(_row);
            }

            return _DataResults;
        }

        #endregion

        [WebMethod]
        public string RecalculoLineasOpciones()
        {
            DataTable _DataResults = new DataTable();
            int _Row = 0;
            DataRow _DataRow;
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";

            _DataResults = svcDetalles.dSpRecalculoLineasOpciones();
            _ReturnValue += "<Resultado>";

            if (_DataResults != null)
            {
                for (_Row = 0; _Row < _DataResults.Rows.Count; _Row++)
                {
                    _DataRow = _DataResults.Rows[_Row];
                    _ReturnValue += "<Data " +
                                     "Resultado ='" + (_DataRow[0].ToString()).ToString() + "' Mensaje='" + (_DataRow[1].ToString()).ToString() + "' />";
                }
            }
            else
            {
                string _Mensaje = "<Data Result ='Ocurrio Error en sp_recalculo_lineas_opciones' />";
                _ReturnValue += _Mensaje;
            }
            _ReturnValue += "</Resultado>";
            return _ReturnValue;
        }

        [WebMethod]
        public string GenCntVoucher(string _fecha)
        {
            DataTable _DataResults = new DataTable();
            int _Row = 0;

            DataRow _DataRow;
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";


            _DataResults = svcDetalles.dGenCntVoucher(_fecha);
            _ReturnValue += "<Resultado>";

            if (_DataResults != null)
            {
                for (_Row = 0; _Row < _DataResults.Rows.Count; _Row++)
                {
                    _DataRow = _DataResults.Rows[_Row];
                    string _Resp = _DataRow[0].ToString();
                    if (_Resp != "0")
                    {
                        _ReturnValue += "<Data " +
                                     "Resultado ='" + (_DataRow[0].ToString()).ToString() + "' />";
                        _ReturnValue += "</Resultado>";
                    }
                    else
                    {
                        _ReturnValue = _Resp;
                    }
                }
            }
            else
            {
                string _Mensaje = "<Data Result ='Ocurrio Error en SP_GenCntVoucher' />";
                _ReturnValue += _Mensaje;
                _ReturnValue += "</Resultado>";
            }
            return _ReturnValue;
        }

        [WebMethod]
        public string CondicionesGenerales() 
        {
            DataTable _DataResults = new DataTable();
            int _Row = 0;
            DataRow _DataRow;
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";
            // MAP 23 Marzo 2010 filtrando los caracteres no compatibles con xml
            String _CustomerName = "";

            _DataResults = svcDetalles.dConsultaDefiniciones();
            _ReturnValue += "<Resultado>";

            if (_DataResults != null)
            {
                for (_Row = 0; _Row < _DataResults.Rows.Count; _Row++)
                {
                    _DataRow = _DataResults.Rows[_Row];
                    DateTime d_ = DateTime.Parse(_DataRow["FechaFirma_cond_Opc"].ToString());
                    DateTime d1_ = DateTime.Parse(_DataRow["ClFechaFirma_Supl_Opc"].ToString());
                    
                    // MAP 23 Marzo 2010 filtrando caracteres no compatibles con xml
                    _CustomerName = (_DataRow["clnombre"].ToString()).Trim();

                    
                    _CustomerName = _CustomerName.Replace("  ", " ");
                    _CustomerName = _CustomerName.Replace("&", "&#38;");
                    _CustomerName = _CustomerName.Replace("Ñ", "&#209;");
                    _CustomerName = _CustomerName.Replace("Ñ", "&#241;");
                    _CustomerName = _CustomerName.Replace("'", "&#39;");

                    _CustomerName = _CustomerName.Replace("/", "-");
                    _CustomerName = _CustomerName.Replace(".", ""); 
                    
                    // falta agragar en los otros filtros

                    // MAP 23 Marzo 2010 filtrando caracteres no compatibles con xml
                    
                    _ReturnValue += "<Data " +
                                           "ClRut ='" + (_DataRow["clrut"].ToString()).ToString() + "' " +
                                           "ClDV ='" + (_DataRow["cldv"].ToString()).ToString() + "' " +

                                         // MAP 23 Marzo 2010 filtrando caracteres no compatibles con xml
                                         // Aplicando el cambio
                                         // "ClNombre ='" + (_DataRow["clnombre"].ToString()).Trim() + "' " +   
                                            "ClNombre ='" + _CustomerName.ToString() + "' " +

                                           "ClFechaFirma_Cond_Opc ='" + d_.ToShortDateString() + "' " +
                                           "ClFechaFirma_Cond_OpcChk ='" + (_DataRow["ClFechaFirma_Cond_OpcChk"].ToString()).ToString() + "' " +
                                           "ClFechaFirma_Supl_Opc ='" + d1_.ToShortDateString() + "' " +
                                           "ClFechaFirma_Supl_OpcChk ='" + (_DataRow["ClFechaFirma_Supl_OpcChk"].ToString()).ToString() + "' " +
                                           "ClCodigo ='" + (_DataRow["clcodigo"].ToString()).ToString() + "' />";
                }
            }
            else
            {
                string _Mensaje = "<Data Result ='Ocurrio Error en Query Condiciones Generales' />";
                _ReturnValue += _Mensaje;
            }
            _ReturnValue += "</Resultado>";
            return _ReturnValue;
        }

        [WebMethod]
        public string LoadFormaPago(string mnemonics, string fechaproceso)
        {
            DataTable _DTCierreMesa = svcDetalles.CierreMesa(fechaproceso);
            string _CierreMesa = "0";

            foreach (DataRow _DataRow in _DTCierreMesa.Rows)
            {
                _CierreMesa = _DataRow["CierreMesa"].ToString();
            }

            DataTable _FormaPago = cData.Opciones.LoadFront.LoadFormaDePago(mnemonics);
            string _ReturnValue = string.Format("<FormasPago Moneda='{0}' CierreMesa='{1}' >", mnemonics, _CierreMesa);

            foreach (DataRow _DRFormaPago in _FormaPago.Rows)
            {
                _ReturnValue += string.Format(
                                               "<Item Codigo='{0}' Descripcion='{1}' Valuta='{2}' />",
                                               _DRFormaPago[0].ToString(),
                                               _DRFormaPago[1].ToString(),
                                               _DRFormaPago[2].ToString()
                                             );
            }

            _ReturnValue += "</FormasPago>";
            return _ReturnValue;
        }

        [WebMethod]
        public string MoEncCotizacion(int clirut, int clicod)
        {
            DataTable _DataResults = new DataTable();
            int _Row = 0;
            DataRow _DataRow;
            string _ReturnValue = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";

            _DataResults = svcDetalles.dMoEncCotizacion(clirut, clicod);
            _ReturnValue += "<MoEncCotizacion>";

            if (_DataResults != null)
            {
                for (_Row = 0; _Row < _DataResults.Rows.Count; _Row++)
                {
                    _DataRow = _DataResults.Rows[_Row];
                    _ReturnValue += "<Data " +
                                    "VF ='False' " +
                                    "NumContrato ='" + (_DataRow["numcontrato"].ToString()).ToString() + "' " +
                                    "NumFolio ='" + (_DataRow["numfolio"].ToString()).ToString() + "' " +
                                    "CliNom ='" + (_DataRow["clinom"].ToString()).ToString() + "' " +
                                    "OpcEstDsc ='" + (_DataRow["opcestdsc"].ToString()).ToString() + "' " +
                                    "Operador ='" + (_DataRow["operador"].ToString()).ToString() + "' " +
                                    "Objeto ='" + (_DataRow["objeto"].ToString()).ToString() + "' " +
                                    "CliCod ='" + (_DataRow["clicod"].ToString()).ToString() + "' " +
                                    "CliRut ='" + (_DataRow["clirut"].ToString()).ToString() + "' " +
                                    "CliDv ='" + (_DataRow["clidv"].ToString()).ToString() + "' " +
                                    "OpcEstCod ='" + (_DataRow["opcestcod"].ToString()).ToString() + "' " +
                                    "FechaCreacionRegistro ='" + (_DataRow["fechacreacionregistro"].ToString()).ToString() + "' " +
                                    "FechaContrato ='" + (_DataRow["fechacontrato"].ToString()).ToString() + "' />";
                }
            }
            else
            {
                string _Mensaje = "<Data Result ='Ocurrio Error en Sp_MoEncCotizacion' />";
                _ReturnValue += _Mensaje;
            }
            _ReturnValue += "</MoEncCotizacion>";
            return _ReturnValue;
        }

        //Rq_13090
        [WebMethod]
        public string Trae_SDA(string NumFolio)
        {
            string _ReturnValue = "";

            DataTable _DataResults = new DataTable();

            _DataResults = svcDetalles.Trae_SDA(NumFolio);

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
                                                   "<Item NUM_CONTRATO='{0}' FECHA_INGRESO='{1}' FECHA_ACTIVACION='{2}' MONTO_SOLICITUD ='{3}' FORMA_PAGO='{4}'  TIPO_ANTICIPO='{5}' ESTADO_SOLICITUD='{6}' NUM_SOLICITUD='{7}'/>",
                                                   _DR["NUM_CONTRATO"].ToString(),
                                                   _DR["FECHA_INGRESO"].ToString(),
                                                   _DR["FECHA_ACTIVACION"].ToString(),
                                                   _DR["MONTO_SOLICITUD"].ToString(),
                                                   _DR["FORMA_PAGO"].ToString(),
                                                   _DR["TIPO_ANTICIPO"].ToString(),
                                                   _DR["ESTADO_SOLICITUD"].ToString(),
                                                   _DR["NUM_SOLICITUD"].ToString()
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
        public string AnticipaSolicitud(string NumContrato,string FechaProceso)
        {
            string _ReturnValue = "";

            DataTable _DataResults = new DataTable();

            _DataResults = svcDetalles.ConsultaSolicitud(NumContrato, FechaProceso);

            _ReturnValue = "<Result>";
            if (_DataResults.Rows.Count > 0)
            {
                _ReturnValue += "<ID Error='0' />";
                _ReturnValue += "<Status>";
                foreach (DataRow _DR in _DataResults.Rows)
                {
                    _ReturnValue += string.Format(
                                                   "<Item MONTO_SOLICITUD ='{0}' TIPO_ANTICIPO ='{1}' CaNumContrato ='{2}'/>",
                                                   _DR["MONTO_SOLICITUD"].ToString(),
                                                   _DR["TIPO_ANTICIPO"].ToString(),
                                                   _DR["CaNumContrato"].ToString()
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
        public string OpcionValFeriados(DateTime FechaVenc)
        {
            string _FechaFestivoResutl = "";
            try
            {
                Calendars calendario = new Calendars();
                calendario.Load();

                if (!calendario.IsBussineDay(6, FechaVenc))
                {
                    FechaVenc = calendario.NextHolidayDate(6, FechaVenc);

                    _FechaFestivoResutl = "<Data>\n";
                    _FechaFestivoResutl += "<Vencimiento MoFechaVcto='" + FechaVenc.ToString("dd-MM-yyyy") + "'/>\n"; ;
                    _FechaFestivoResutl += "</Data>";
                }
                else
                {
                    _FechaFestivoResutl = "<Data>\n";
                    _FechaFestivoResutl += "<Vencimiento MoFechaVcto='" + FechaVenc.ToString("dd-MM-yyyy") + "'/>\n"; ;
                    _FechaFestivoResutl += "</Data>";
                }
            }
            catch { }
            return _FechaFestivoResutl;
        }

        [WebMethod]
        public string OpcionValFeriadosAnt(DateTime FechaVenc)
        {
            string _FechaFestivoResutl = "";
            try
            {
                Calendars calendario = new Calendars();
                calendario.Load();

                if (!calendario.IsBussineDay(6, FechaVenc))
                {
                    FechaVenc = calendario.NextHolidayDate(6, FechaVenc);

                    _FechaFestivoResutl = "<Data>\n";
                    _FechaFestivoResutl += "<Vencimiento MoFechaVcto='" + FechaVenc.ToString("dd-MM-yyyy") + "'/>\n"; ;
                    _FechaFestivoResutl += "</Data>";
                }
                else
                {
                    _FechaFestivoResutl = "<Data>\n";
                    _FechaFestivoResutl += "<Vencimiento MoFechaVcto='" + FechaVenc.ToString("dd-MM-yyyy") + "'/>\n"; ;
                    _FechaFestivoResutl += "</Data>";
                }

            }
            catch { }
            return _FechaFestivoResutl;
        }

        [WebMethod]
        public string ConsultaOperacion(string NumContrato)
        {
            string _ReturnValue = "";

            DataTable _DataResults = new DataTable();

            _DataResults = svcDetalles.Trae_Operacion(NumContrato);

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
                                                   "<Item CaNumContrato='{0}' CaNumFolio='{1}' CaMontoMon1='{2}' CaFechaVcto ='{3}' CaCodEstructura='{4}' Total_Solicitud='{5}'/>",
                                                   _DR["CaNumContrato"].ToString(),
                                                   _DR["CaNumFolio"].ToString(),
                                                   _DR["CaMontoMon1"].ToString(),
                                                   _DR["CaFechaVcto"].ToString(),
                                                   _DR["CaCodEstructura"].ToString(),
                                                   _DR["Total_Solicitud"].ToString()
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
        public string Trae_EstructurasRelacionadas()
        {
            string _ReturnValue = "";

            DataTable _DataResults = new DataTable();

            _DataResults = svcDetalles.Trae_EstructuraRelacionada();

            _ReturnValue = "<Result>";
            if (_DataResults != null && _DataResults.IsInitialized && _DataResults.Rows.Count > 0)
            {
                _ReturnValue += "<ID Error='0' />";
                _ReturnValue += "<Status>";
                foreach (DataRow _DR in _DataResults.Rows)
                {
                    _ReturnValue += string.Format(
                                                   "<Item ReId='{0}' ReDescripcion='{1}'/>",
                                                   _DR["ReId"].ToString(),
                                                   _DR["ReDescripcion"].ToString()
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
        public string Trae_ForwardRelacionado(int _NumContrato)
        {
            string _ReturnValue = "";

            DataTable _DataResults = new DataTable();

            _DataResults = svcDetalles.Trae_ForwardRelacionado(_NumContrato);

            _ReturnValue = "<Result>";
            if (_DataResults.Rows.Count > 0)
            {
                _ReturnValue += "<ID Error='0' />";
                _ReturnValue += "<Status>";
                foreach (DataRow _DR in _DataResults.Rows)
                {
                    _ReturnValue += string.Format(
                                                   "<Item ReNumeroLeasing='{0}' ReNumeroBien='{1}' ReCaNumContrato='{2}' ReCaNumFolio='{3}'/>",
                                                   _DR["ReNumeroLeasing"].ToString(),
                                                   _DR["ReNumeroBien"].ToString(),
                                                   _DR["ReCaNumContrato"].ToString(),
                                                   _DR["ReCaNumFolio"].ToString()
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



        /// <summary>
        /// Revisa que esté habilitado el control de artículo 84
        /// 0 - Habilitado
        /// 1 - Deshabilitado
        /// </summary>
        /// <returns>Permiso para controlar artículo 84</returns>
        /// <remarks>Carlito's logic</remarks>
        [WebMethod]
        public bool Activar84() {
            try {
                return Convert.ToBoolean(svcDetalles.PermiteArticulo84().Rows[0][0]);
            }
            catch (System.Exception ex) {
                return false;
            }
        }

        /// <summary>
        /// Obtiene URL del WS desde BBDD
        /// </summary>
        /// <returns>URL WS Art84 (string)</returns>
        /// <remarks>Alan's logic</remarks>
        [WebMethod]
        public string GetUrl_WS_ART84()
        {
            string strReturn = string.Empty;
            try
            {
                DataTable dtResult = svcDetalles.ObtieneURLArticulo84();
                strReturn = dtResult.Rows[0][0].ToString().Trim();
                return strReturn;
            }
            catch (System.Exception ex) {
                return "Error al Obtener URL WS Art84, Detalle Error: " + ex.Message.Trim();
            }
        }

        /// <summary>
        /// Obtiene URL del WS Toma Linea desde BBDD
        /// </summary>
        /// <returns>URL WS Toma Linea (string)</returns>
        
        [WebMethod]
        public string GetUrl_WS_TomaLinea()
        {
            string strReturn = string.Empty;
            try
            {
                DataTable dtResult = svcDetalles.ObtieneURLTomaLinea();
                strReturn = dtResult.Rows[0][0].ToString().Trim();
                return strReturn;
            }
            catch (System.Exception ex)
            {
                return "Error al Obtener URL WS Toma Linea, Detalle Error: " + ex.Message.Trim();
            }
        }
    }
}
