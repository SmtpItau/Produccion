using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.Services;
using System.Xml.Linq;
using cData.AccionesBD;
using cData.Dataset;
using cFinancialTools.BussineDate;
using System.IO;
using System.Xml;

namespace AdminOpciones.Web.WebService.OpcionesFX.BDOpciones
{
    /// <summary>
    /// Descripción breve de BDOpciones
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class BDOpciones : System.Web.Services.WebService
    {

        [WebMethod]
        public string InsertOption(string xdocInsert, string NomUser, string Estado, int NumFolio
                                  , int NumContrato, DateTime fProceso,bool _Turing)
        {
            string _result = string.Empty;
            string _resutLCR = string.Empty;
            string _Tipo = string.Empty;
            int InyectaTuring = 0;
            
            try
            {
                #region Definición de Variables

                XDocument _xdocInsert = new XDocument(XDocument.Parse(xdocInsert));
                IEnumerable<XElement> _EleAux = _xdocInsert.Element("Datos").Elements();
                XElement _DataHead = _xdocInsert.Element("Datos").Element("encContrato");
                XElement _DataStrip = _xdocInsert.Element("Datos").Element("OperacionStrip"); //STRIP ASIATICO

                DateTime _fechaContrato = new DateTime();
                DateTime _fechaAux = new DateTime();
                DateTime _fechaPagoEjer = new DateTime();

                decimal _NocionalEjercicio = 0;
                decimal _VersusEjercicio = 0;
                string _ModalidadPagoEjercicio = "C";

                DataSet _Datos = new DataSet();
                DataTable _DTHead = GenerateTableHead();
                DataTable _DTDetail = GenerateTableDetail();
                DataTable _DTFixing = GenerateTableFixing();
                DataTable _DTStrip = GenerateTableStrip();     //STRIP ASIATICO

                DataRow _DRHead;
                DataRow _DRDetail;
                DataRow _DRFixing;
                DataRow _DRStrip;    //STRIP ASIATICO

                Calendars _Calendar = new Calendars();

                int _FixingID;

                #endregion Definición de Variables

                _Calendar.Load();

                //int diasValuta;
                _fechaContrato = DateTime.Parse(_xdocInsert.Element("Datos").Element("encContrato").Element("Contrato").Attribute("MoFechaContrato").Value.ToString());

                if (Estado.Equals("E"))
                {
                    _NocionalEjercicio = decimal.Parse(_xdocInsert.Element("Datos").Element("encContrato").Element("Ejercer").Attribute("Nocional").Value);
                    _VersusEjercicio = decimal.Parse(_xdocInsert.Element("Datos").Element("encContrato").Element("Ejercer").Attribute("Versus").Value);
                    _ModalidadPagoEjercicio = _xdocInsert.Element("Datos").Element("encContrato").Element("Ejercer").Attribute("ModalidadPago").Value;
                }

                #region Validación de la Fecha de Pago Moneda 1 y 2
                //FechaPagoPrima
                //diasValuta = int.Parse(_xdocInsert.Element("Datos").Element("encContrato").Element("Resultados").Attribute("MoFechaPagoPrima").Value.ToString());               
                _fechaAux = _fechaContrato;//.AddDays(diasValuta);
                while (!_Calendar.IsBussineDay(6, _fechaAux))
                {
                    _fechaAux = _fechaAux.AddDays(1);
                }

                //PRD_10449
                string _FechaPagoPrima = "";
                if (_xdocInsert.Element("Datos").Element("encContrato").Element("Contrato").Attribute("MoRelacionaPAE").Value.Equals("1"))
                {
                    _FechaPagoPrima = _xdocInsert.Element("Datos").Element("detContrato").Element("Vencimiento").Attribute("MoFechaVcto").Value.ToString(); ;
                }
                else
                {
                    _FechaPagoPrima = _fechaAux.ToString("dd-MM-yyyy");
                }

                _xdocInsert.Element("Datos").Element("encContrato").Element("Resultados").Attribute("MoFechaPagoPrima").Value = _FechaPagoPrima;

                foreach (XElement _element in _xdocInsert.Descendants("detContrato"))
                {

                    _fechaPagoEjer = DateTime.Parse(_element.Element("Subyacente").Attribute("MoFechaPagoEjer").Value.ToString());

                    #region Fecha Pago Moneda 1
                    //MoFechaPagMon1
                    //diasValuta = int.Parse(_element.Element("Subyacente").Attribute("MoFechaPagMon1").Value.ToString());
                    _fechaAux = _fechaPagoEjer;//.AddDays(diasValuta);
                    while (!_Calendar.IsBussineDay(6, _fechaAux))
                    {
                        _fechaAux = _fechaAux.AddDays(1);
                    }
                    _element.Element("Subyacente").Attribute("MoFechaPagMon1").Value = _fechaAux.ToString("dd-MM-yyyy");
                    #endregion

                    #region Fecha Pago Moneda 2
                    //MoFechaPagMon2
                    // diasValuta = int.Parse(_element.Element("Subyacente").Attribute("MoFechaPagMon2").Value.ToString());
                    _fechaAux = _fechaPagoEjer;//.AddDays(diasValuta);
                    while (!_Calendar.IsBussineDay(6, _fechaAux))
                    {
                        _fechaAux = _fechaAux.AddDays(1);
                    }
                    _element.Element("Subyacente").Attribute("MoFechaPagMon2").Value = _fechaAux.ToString("dd-MM-yyyy");
                    #endregion


                }
                #endregion

                #region "AdminOpciones"
                _Datos.DataSetName = "DatosPrincipal";

                #region Llenado Dataset

                #region Llenado del Encabezado

                if (_DataHead != null)
                {
                    _DRHead = _DTHead.NewRow();

                    #region Assign Record Data

                    _DRHead["MoNumFolio"] = _DataHead.Element("Contrato").Attribute("MoNumFolio").Value.ToString();
                    _DRHead["MoTipoTransaccion"] = _DataHead.Element("Contrato").Attribute("MoTipoTransaccion").Value.ToString();
                    _DRHead["MoNumContrato"] = _DataHead.Element("Contrato").Attribute("MoNumContrato").Value.ToString();
                    _DRHead["MoFechaContrato"] = _DataHead.Element("Contrato").Attribute("MoFechaContrato").Value.ToString();
                    _DRHead["MoEstado"] = _DataHead.Element("Contrato").Attribute("MoEstado").Value.ToString();
                    _DRHead["MoGlosa"] = _DataHead.Element("Contrato").Attribute("MoGlosa").Value.ToString();
                    //PRD_10449 ASVG_20111102
                    _DRHead["MoRelacionaLeasing"] = _DataHead.Element("Contrato").Attribute("MoRelacionaLeasing").Value.ToString(); //tostring?
                    _DRHead["MoNumeroLeasing"] = _DataHead.Element("Contrato").Attribute("MoNumeroLeasing").Value.ToString(); //tostring?
                    _DRHead["MoNumeroBien"] = _DataHead.Element("Contrato").Attribute("MoNumeroBien").Value.ToString(); //tostring?
                    //Prd_16803
                    _DRHead["MoRelacionaPAE"] = _DataHead.Element("Contrato").Attribute("MoRelacionaPAE").Value.ToString(); //tostring?
                    _DRHead["MoCarteraFinanciera"] = _DataHead.Element("Carteras").Attribute("MoCarteraFinanciera").Value.ToString();
                    _DRHead["MoLibro"] = _DataHead.Element("Carteras").Attribute("MoLibro").Value.ToString();
                    _DRHead["MoCarNormativa"] = _DataHead.Element("Carteras").Attribute("MoCarNormativa").Value.ToString();
                    _DRHead["MoSubCarNormativa"] = _DataHead.Element("Carteras").Attribute("MoSubCarNormativa").Value.ToString();
                    _DRHead["MoRutCliente"] = _DataHead.Element("Contraparte").Attribute("MoRutCliente").Value.ToString();
                    _DRHead["MoCodigo"] = _DataHead.Element("Contraparte").Attribute("MoCodigo").Value.ToString();
                    _DRHead["MoTipoContrapartida"] = _DataHead.Element("Contraparte").Attribute("MoTipoContrapartida").Value.ToString();
                    _DRHead["MoOperador"] = _DataHead.Element("Trader").Attribute("MoOperador").Value.ToString();
                    _DRHead["MoCodEstructura"] = _DataHead.Element("Estructura").Attribute("MoCodEstructura").Value.ToString();
                    _DRHead["MoCVEstructura"] = _DataHead.Element("Estructura").Attribute("MoCVEstructura").Value.ToString();
                    _DRHead["MoSistema"] = _DataHead.Element("Producto").Attribute("MoSistema").Value.ToString();
                    _DRHead["MoMonPrimaTrf"] = _DataHead.Element("Resultados").Attribute("MoMonPrimaTrf").Value.ToString();
                    _DRHead["MoPrimaTrf"] = _DataHead.Element("Resultados").Attribute("MoPrimaTrf").Value.ToString();
                    _DRHead["MoPrimaTrfML"] = _DataHead.Element("Resultados").Attribute("MoPrimaTrfML").Value.ToString();
                    _DRHead["MoMonPrimaCosto"] = _DataHead.Element("Resultados").Attribute("MoMonPrimaCosto").Value.ToString();
                    _DRHead["MoPrimaCosto"] = _DataHead.Element("Resultados").Attribute("MoPrimaCosto").Value.ToString();
                    _DRHead["MoPrimaCostoML"] = _DataHead.Element("Resultados").Attribute("MoPrimaCostoML").Value.ToString();
                    _DRHead["MoCodMonPagPrima"] = _DataHead.Element("Resultados").Attribute("MoCodMonPagPrima").Value.ToString();
                    _DRHead["MoPrimaInicial"] = _DataHead.Element("Resultados").Attribute("MoPrimaInicial").Value.ToString();
                    _DRHead["MoPrimaInicialML"] = _DataHead.Element("Resultados").Attribute("MoPrimaInicialML").Value;
                    _DRHead["MoParMdaPrima"] = _DataHead.Element("Resultados").Attribute("MoParMdaPrima").Value;
                    //MoParMdaPrima
                    _DRHead["MofPagoPrima"] = _DataHead.Element("Resultados").Attribute("MofPagoPrima").Value.ToString();
                    //5843
                    _DRHead["MoResultadoVentasML"] = _DataHead.Element("Resultados").Attribute("MoResultadoVentasML").Value;
                    _DRHead["MoMonCarryPrima"] = _DataHead.Element("Resultados").Attribute("MoMonCarryPrima").Value.ToString();
                    _DRHead["MoCarryPrima"] = _DataHead.Element("Resultados").Attribute("MoCarryPrima").Value.ToString();
                    _DRHead["MoParM2Spot"] = _DataHead.Element("Resultados").Attribute("MoParM2Spot").Value.ToString();
                    _DRHead["MoParMdaPrima"] = _DataHead.Element("Resultados").Attribute("MoParMdaPrima").Value.ToString();
                    _DRHead["MoFechaPagoPrima"] = _DataHead.Element("Resultados").Attribute("MoFechaPagoPrima").Value.ToString();
                    _DRHead["MoFecValorizacion"] = _DataHead.Element("Proceso").Attribute("MoFecValorizacion").Value.ToString();
                    _DRHead["MoMon_vr"] = _DataHead.Element("MtM").Attribute("MoMon_vr").Value.ToString();
                    _DRHead["MoVr"] = _DataHead.Element("MtM").Attribute("MoVr").Value.ToString();
                    _DRHead["MoVr_Costo"] = _DataHead.Element("MtM").Attribute("MoVr_Costo").Value.ToString();
                    _DRHead["MoFormPagoUnwind"] = _DataHead.Element("MtM").Attribute("MoFormPagoUnwind").Value.ToString();
                    _DRHead["MoUnwind"] = _DataHead.Element("MtM").Attribute("UnWind").Value.ToString();
                    _DRHead["MoUnwindCosto"] = _DataHead.Element("MtM").Attribute("UnWindCosto").Value.ToString();
                    _DRHead["MoMondelta"] = _DataHead.Element("Griegas").Attribute("MoMondelta").Value.ToString();
                    _DRHead["MoMon_gamma"] = _DataHead.Element("Griegas").Attribute("MoMon_gamma").Value.ToString();
                    _DRHead["MoMon_vega"] = _DataHead.Element("Griegas").Attribute("MoMon_vega").Value.ToString();
                    _DRHead["MoMon_vanna"] = _DataHead.Element("Griegas").Attribute("MoMon_vanna").Value.ToString();
                    _DRHead["MoMon_volga"] = _DataHead.Element("Griegas").Attribute("MoMon_volga").Value.ToString();
                    _DRHead["MoMon_theta"] = _DataHead.Element("Griegas").Attribute("MoMon_theta").Value.ToString();
                    _DRHead["MoMon_rho"] = _DataHead.Element("Griegas").Attribute("MoMon_rho").Value.ToString();
                    _DRHead["MoMon_rhof"] = _DataHead.Element("Griegas").Attribute("MoMon_rhof").Value.ToString();
                    _DRHead["MoMon_charm"] = _DataHead.Element("Griegas").Attribute("MoMon_charm").Value.ToString();
                    _DRHead["MoMon_zomma"] = _DataHead.Element("Griegas").Attribute("MoMon_zomma").Value.ToString();
                    _DRHead["MoMon_speed"] = _DataHead.Element("Griegas").Attribute("MoMon_speed").Value.ToString();
                    _DRHead["MoPrimaBSSpotCont"] = _DataHead.Element("Griegas").Attribute("MoPrimaBSSpotCont").Value.ToString();
                    _DRHead["MoDeltaSpotCont"] = _DataHead.Element("Griegas").Attribute("MoDeltaSpotCont").Value.ToString();
                    _DRHead["MoDeltaForwardCont"] = _DataHead.Element("Griegas").Attribute("MoDeltaForwardCont").Value.ToString();
                    if (_DRHead["MoDeltaForwardCont"].Equals("NaN") || _DRHead["MoDeltaForwardCont"].Equals("NeuN"))
                    {
                        _DRHead["MoDeltaForwardCont"] = "0";
                    }

                    _DRHead["MoGammaCont"] = _DataHead.Element("Griegas").Attribute("MoGammaCont").Value.ToString();
                    _DRHead["MoVegaCont"] = _DataHead.Element("Griegas").Attribute("MoVegaCont").Value.ToString();
                    _DRHead["MoVannaCont"] = _DataHead.Element("Griegas").Attribute("MoVannaCont").Value.ToString();
                    _DRHead["MoVolgaCont"] = _DataHead.Element("Griegas").Attribute("MoVolgaCont").Value.ToString();
                    _DRHead["MoThetaCont"] = _DataHead.Element("Griegas").Attribute("MoThetaCont").Value.ToString();
                    _DRHead["MoRhoDomCont"] = _DataHead.Element("Griegas").Attribute("MoRhoDomCont").Value.ToString();
                    _DRHead["MoRhoForCont"] = _DataHead.Element("Griegas").Attribute("MoRhoForCont").Value.ToString();
                    _DRHead["MoCharmCont"] = _DataHead.Element("Griegas").Attribute("MoCharmCont").Value.ToString();

                    #endregion

                    _DTHead.Rows.Add(_DRHead);
                }
                #endregion

                #region Llenado del Detalle y el Fixing

                foreach (XElement _DataDetail in _xdocInsert.Element("Datos").Descendants("detContrato"))
                {
                    _DRDetail = _DTDetail.NewRow();

                    #region Assign Record Data

                    _DRDetail["MoNumFolio"] = _DataDetail.Element("Estructura").Attribute("MoNumFolio").Value.ToString();
                    _DRDetail["MoNumEstructura"] = _DataDetail.Element("Estructura").Attribute("MoNumEstructura").Value.ToString();
                    _DRDetail["MoVinculacion"] = _DataDetail.Element("Estructura").Attribute("MoVinculacion").Value.ToString();
                    _DRDetail["MoTipoOpc"] = _DataDetail.Element("DetallesOpcion").Attribute("MoTipoOpc").Value.ToString();
                    _DRDetail["MoSubyacente"] = _DataDetail.Element("DetallesOpcion").Attribute("MoSubyacente").Value.ToString();
                    _DRDetail["MoTipoPayOff"] = _DataDetail.Element("DetallesOpcion").Attribute("MoTipoPayOff").Value.ToString();
                    _DRDetail["MoCallPut"] = _DataDetail.Element("DetallesOpcion").Attribute("MoCallPut").Value.ToString();
                    _DRDetail["MoCVOpc"] = _DataDetail.Element("DetallesOpcion").Attribute("MoCVOpc").Value.ToString();
                    _DRDetail["MoTipoEmisionPT"] = _DataDetail.Element("DetallesOpcion").Attribute("MoTipoEmisionPT").Value.ToString();
                    _DRDetail["MoFechaInicioOpc"] = _DataDetail.Element("DetallesOpcion").Attribute("MoFechaInicioOpc").Value.ToString();
                    _DRDetail["MoFechaFijacion"] = _DataDetail.Element("DetallesOpcion").Attribute("MoFechaFijacion").Value.ToString();
                    _DRDetail["MoFechaVcto"] = _DataDetail.Element("Vencimiento").Attribute("MoFechaVcto").Value.ToString();
                    _DRDetail["MoFormaPagoMon1"] = _DataDetail.Element("Subyacente").Attribute("MoFormaPagoMon1").Value.ToString();
                    _DRDetail["MoFechaPagMon1"] = _DataDetail.Element("Subyacente").Attribute("MoFechaPagMon1").Value.ToString();
                    _DRDetail["MoFormaPagoMon2"] = _DataDetail.Element("Subyacente").Attribute("MoFormaPagoMon2").Value.ToString();
                    _DRDetail["MoFechaPagMon2"] = _DataDetail.Element("Subyacente").Attribute("MoFechaPagMon2").Value.ToString();
                    _DRDetail["MoFechaPagoEjer"] = _DataDetail.Element("Subyacente").Attribute("MoFechaPagoEjer").Value.ToString();
                    _DRDetail["MoCodMon1"] = _DataDetail.Element("Subyacente").Attribute("MoCodMon1").Value.ToString();
                    _DRDetail["MoMontoMon1"] = _DataDetail.Element("Subyacente").Attribute("MoMontoMon1").Value.ToString();
                    _DRDetail["MoCodMon2"] = _DataDetail.Element("Subyacente").Attribute("MoCodMon2").Value.ToString();
                    _DRDetail["MoMontoMon2"] = _DataDetail.Element("Subyacente").Attribute("MoMontoMon2").Value.ToString();
                    _DRDetail["MoModalidad"] = _DataDetail.Element("Subyacente").Attribute("MoModalidad").Value.ToString();
                    _DRDetail["MoMdaCompensacion"] = _DataDetail.Element("Subyacente").Attribute("MoMdaCompensacion").Value.ToString();
                    _DRDetail["MoBenchComp"] = _DataDetail.Element("Subyacente").Attribute("MoBenchComp").Value.ToString();
                    _DRDetail["MoParStrike"] = _DataDetail.Element("Subyacente").Attribute("MoParStrike").Value.ToString();
                    _DRDetail["MoStrike"] = _DataDetail.Element("Subyacente").Attribute("MoStrike").Value.ToString();
                    _DRDetail["MoPorcStrike"] = _DataDetail.Element("Subyacente").Attribute("MoPorcStrike").Value.ToString();
                    _DRDetail["MoTipoEjercicio"] = _DataDetail.Element("Subyacente").Attribute("MoTipoEjercicio").Value.ToString();
                    _DRDetail["MoSpotDet"] = _DataDetail.Element("Proceso").Attribute("MoSpotDet").Value.ToString();
                    _DRDetail["MoCurveMon1"] = _DataDetail.Element("Curvas").Attribute("MoCurveMon1").Value.ToString();
                    _DRDetail["MoCurveMon2"] = _DataDetail.Element("Curvas").Attribute("MoCurveMon2").Value.ToString();
                    _DRDetail["MoCurveSmile"] = _DataDetail.Element("Curvas").Attribute("MoCurveSmile").Value.ToString();
                    _DRDetail["MoWf_mon1"] = _DataDetail.Element("MtM").Attribute("MoWf_mon1").Value.ToString();
                    _DRDetail["MoWf_mon2"] = _DataDetail.Element("MtM").Attribute("MoWf_mon2").Value.ToString();
                    _DRDetail["MoVol"] = _DataDetail.Element("MtM").Attribute("MoVol").Value.ToString();
                    _DRDetail["MoFwd_teo"] = _DataDetail.Element("MtM").Attribute("MoFwd_teo").Value.ToString();
                    _DRDetail["MoFormaPagoComp"] = _DataDetail.Element("Subyacente").Attribute("MoFormaPagoComp").Value.ToString();
                    _DRDetail["MoVrDet"] = _DataDetail.Element("MtM").Attribute("MoVrDet").Value.ToString();
                    _DRDetail["MoSpotDetCosto"] = _DataDetail.Element("MtM").Attribute("MoSpotDetCosto").Value.ToString();
                    _DRDetail["MoWf_Mon1_Costo"] = _DataDetail.Element("MtM").Attribute("MoWf_Mon1_Costo").Value.ToString();
                    _DRDetail["MoWf_Mon2_Costo"] = _DataDetail.Element("MtM").Attribute("MoWf_Mon2_Costo").Value.ToString();
                    _DRDetail["MoVol_Costo"] = _DataDetail.Element("MtM").Attribute("MoVol_Costo").Value.ToString();
                    _DRDetail["MoFwd_Teo_Costo"] = _DataDetail.Element("MtM").Attribute("MoFwd_Teo_Costo").Value.ToString();
                    _DRDetail["MoVr_Costo"] = _DataDetail.Element("MtM").Attribute("MoVr_Costo").Value.ToString();
                    _DRDetail["MoVr_CostoDet"] = _DataDetail.Element("MtM").Attribute("MoVr_CostoDet").Value.ToString();
                    _DRDetail["MoPrimaBSSpotDet"] = _DataDetail.Element("MtM").Attribute("MoPrimaBSSpotDet").Value.ToString();
                    _DRDetail["MoIteAsoSis"] = _DataDetail.Element("MtM").Attribute("MoIteAsoSis").Value.ToString();
                    _DRDetail["MoIteAsoCon"] = _DataDetail.Element("MtM").Attribute("MoIteAsoCon").Value.ToString();
                    _DRDetail["MoDelta_spot"] = _DataDetail.Element("Griegas").Attribute("MoDelta_spot").Value.ToString();
                    _DRDetail["MoDelta_spot_num"] = _DataDetail.Element("Griegas").Attribute("MoDelta_spot_num").Value.ToString();
                    _DRDetail["MoDelta_fwd"] = _DataDetail.Element("Griegas").Attribute("MoDelta_fwd").Value.ToString();
                    _DRDetail["MoDelta_fwd_num"] = _DataDetail.Element("Griegas").Attribute("MoDelta_fwd_num").Value.ToString();
                    _DRDetail["MoGamma_spot"] = _DataDetail.Element("Griegas").Attribute("MoGamma_spot").Value.ToString();
                    _DRDetail["MoGamma_spot_num"] = _DataDetail.Element("Griegas").Attribute("MoGamma_spot_num").Value.ToString();
                    _DRDetail["MoGamma_fwd"] = _DataDetail.Element("Griegas").Attribute("MoGamma_fwd").Value.ToString();
                    _DRDetail["MoGamma_fwd_num"] = _DataDetail.Element("Griegas").Attribute("MoGamma_fwd_num").Value.ToString();
                    _DRDetail["MoVega"] = _DataDetail.Element("Griegas").Attribute("MoVega").Value.ToString();
                    _DRDetail["MoVega_num"] = _DataDetail.Element("Griegas").Attribute("MoVega_num").Value.ToString();
                    _DRDetail["MoVanna_spot"] = _DataDetail.Element("Griegas").Attribute("MoVanna_spot").Value.ToString();
                    _DRDetail["MoVanna_spot_num"] = _DataDetail.Element("Griegas").Attribute("MoVanna_spot_num").Value.ToString();
                    _DRDetail["MoVanna_fwd"] = _DataDetail.Element("Griegas").Attribute("MoVanna_fwd").Value.ToString();
                    _DRDetail["MoVanna_fwd_num"] = _DataDetail.Element("Griegas").Attribute("MoVanna_fwd_num").Value.ToString();
                    _DRDetail["MoVolga"] = _DataDetail.Element("Griegas").Attribute("MoVolga").Value.ToString();
                    _DRDetail["MoVolga_num"] = _DataDetail.Element("Griegas").Attribute("MoVolga_num").Value.ToString();
                    _DRDetail["MoTheta"] = _DataDetail.Element("Griegas").Attribute("MoTheta").Value.ToString();
                    _DRDetail["MoTheta_num"] = _DataDetail.Element("Griegas").Attribute("MoTheta_num").Value.ToString();
                    _DRDetail["MoRho"] = _DataDetail.Element("Griegas").Attribute("MoRho").Value.ToString();
                    _DRDetail["MoRho_num"] = _DataDetail.Element("Griegas").Attribute("MoRho_num").Value.ToString();
                    _DRDetail["MoRhof"] = _DataDetail.Element("Griegas").Attribute("MoRhof").Value.ToString();
                    _DRDetail["MoRhof_num"] = _DataDetail.Element("Griegas").Attribute("MoRhof_num").Value.ToString();
                    _DRDetail["MoCharm_spot"] = _DataDetail.Element("Griegas").Attribute("MoCharm_spot").Value.ToString();
                    _DRDetail["MoCharm_spot_num"] = _DataDetail.Element("Griegas").Attribute("MoCharm_spot_num").Value.ToString();
                    _DRDetail["MoCharm_fwd"] = _DataDetail.Element("Griegas").Attribute("MoCharm_fwd").Value.ToString();
                    _DRDetail["MoCharm_fwd_num"] = _DataDetail.Element("Griegas").Attribute("MoCharm_fwd_num").Value.ToString();

                    #endregion Assign Record Data

                    _DTDetail.Rows.Add(_DRDetail);
                    _FixingID = 0;
                    foreach (XElement _Fixing in _DataDetail.Descendants("FixingValues"))
                    {
                        _DRFixing = _DTFixing.NewRow();
                        _FixingID++;

                        #region Assign Record Data

                        _DRFixing["MoNumEstructura"] = _DataDetail.Element("Estructura").Attribute("MoNumEstructura").Value.ToString();
                        _DRFixing["ID"] = _FixingID;
                        _DRFixing["Fecha"] = _Fixing.Attribute("Fecha").Value.ToString();
                        _DRFixing["Valor"] = _Fixing.Attribute("Valor").Value.ToString();
                        _DRFixing["Peso"] = _Fixing.Attribute("Peso").Value.ToString();
                        _DRFixing["Volatilidad"] = _Fixing.Attribute("Volatilidad").Value.ToString();
                        _DRFixing["Plazo"] = _Fixing.Attribute("Plazo").Value.ToString();

                        #endregion

                        _DTFixing.Rows.Add(_DRFixing);
                    }
                }

                #endregion

                #region Llenado del Strip
                if (_DataStrip != null)
                {
                    _DRStrip = _DTStrip.NewRow();
                    _DRStrip["FechaInicioStrip"] = _DataStrip.Element("StripAsiatico").Attribute("FechaInicioStrip").Value.ToString();
                    _DRStrip["FechaVencimientoStrip"] = _DataStrip.Element("StripAsiatico").Attribute("FechaVencimientoStrip").Value.ToString();
                    _DRStrip["TotalContratosPorStrip"] = _DataStrip.Element("StripAsiatico").Attribute("TotalContratosPorStrip").Value.ToString();
                    _DRStrip["NumeroContratoActualStrip"] = _DataStrip.Element("StripAsiatico").Attribute("NumeroContratoActualStrip").Value.ToString();

                    _DTStrip.Rows.Add(_DRStrip);
                }
                #endregion

                #region Configuración Dataset

                _Datos.Tables.Add(_DTHead);
                _Datos.Tables.Add(_DTDetail);
                _Datos.Tables.Add(_DTFixing);
                if (_DataStrip != null)
                {
                    _Datos.Tables.Add(_DTStrip); //STRIP ASIATICO
                }
                #endregion

                #endregion Llenado Dataset

                try
                {
                    switch (Estado)
                    { 
                        case "M":
                            _result = Acciones.ModificaContrato(_Datos, NomUser, NumFolio, NumContrato); // No aplica en nuevo diseño de Modificacion  
                            _resutLCR = Rec.LineasOpciones.RecOpciones(_Datos, NomUser, NumContrato, "M", fProceso, InyectaTuring);
                            _Tipo = "Movimiento Modificación  Contrato N°";
                            break;

                        case "E":
                            _result = Acciones.EjerceContrato(_Datos, NomUser, NumFolio, NumContrato, _NocionalEjercicio, _VersusEjercicio, _ModalidadPagoEjercicio);
                            _Tipo = "Movimiento Ejerce N°";
                            break;
                    
                        case "C":
                            _result = Acciones.GrabaContrato(_Datos, NomUser);
                            NumContrato = int.Parse(_result);
                            _Tipo = "Movimiento Creación Contrato N°";
                            _resutLCR = Rec.LineasOpciones.RecOpciones(_Datos, NomUser, NumContrato, "C", fProceso, InyectaTuring);

                            #region GrabaRegistrosOperacion SP_Registro_ingreso_operacion
                            try
                            {
                                if (_Turing.Equals(true))
                                {
                                    Acciones.Graba_SP_Registro_ingreso_operacion("Turing", "SAO", "OPT", NumContrato, fProceso);
                                }
                                else
                                {
                                    Acciones.Graba_SP_Registro_ingreso_operacion("SAO", "SAO", "OPT", NumContrato, fProceso);
                                }
                            }
                            catch { _resutLCR += "Operación grabada sin LOG:" + NumContrato.ToString() + fProceso.ToShortDateString(); }
                            #endregion GrabaRegistrosOperacion SP_Registro_ingreso_operacion
                            break;

                        case "U":
                            _result = Acciones.AnulaAnticipaContrato(_Datos, NomUser, NumFolio, NumContrato,Estado);
                            _resutLCR = Rec.LineasOpciones.RecOpciones(_Datos, NomUser, NumContrato, "U", fProceso, InyectaTuring);
                            _Tipo = "Movimiento Anula Contrato N°" + NumContrato;
                            break;

                        case "N":  /* MAP */
                            _result = Acciones.AnulaAnticipaContrato(_Datos, NomUser, NumFolio, NumContrato,Estado);
                            break;
                    }
                }
                catch (InvalidOperationException _IOExceptionError)
                {
                    return "OBSERVACIÓN:" + _IOExceptionError.Message;
                }

                #endregion
            }
            catch (Exception _Error)
            {
                return "ERROR: "+_Tipo+" " +_result +" " + _Error.Message;
            }
            return _Tipo+" " +_result +" "+ _resutLCR;
        }

        private DataTable GenerateTableHead()
        {
            DataTable _DTHead = new DataTable();
            DataColumn _DCHead = new DataColumn();

            _DTHead.TableName = "encContrato";

            #region Generate Fileds

            #region MoNumFolio

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoNumFolio";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoNumFolio";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoTipoTransaccion

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoTipoTransaccion";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoTipoTransaccion";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoNumContrato

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoNumContrato";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoNumContrato";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoFechaContrato

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoFechaContrato";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoFechaContrato";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoEstado

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoEstado";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoEstado";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoGlosa

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoGlosa";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoGlosa";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoCarteraFinanciera

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoCarteraFinanciera";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoCarteraFinanciera";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoLibro

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoLibro";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoLibro";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoCarNormativa

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoCarNormativa";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoCarNormativa";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoSubCarNormativa

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoSubCarNormativa";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoSubCarNormativa";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoRutCliente

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoRutCliente";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoRutCliente";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoCodigo

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoCodigo";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoCodigo";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoTipoContrapartida

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoTipoContrapartida";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoTipoContrapartida";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoOperador

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoOperador";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoOperador";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoCodEstructura

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoCodEstructura";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoCodEstructura";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoCVEstructura

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoCVEstructura";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoCVEstructura";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoSistema

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoSistema";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoSistema";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoMonPrimaTrf

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoMonPrimaTrf";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoMonPrimaTrf";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoPrimaTrf

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoPrimaTrf";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoPrimaTrf";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoPrimaTrfML

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoPrimaTrfML";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoPrimaTrfML";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoMonPrimaCosto

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoMonPrimaCosto";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoMonPrimaCosto";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoPrimaCosto

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoPrimaCosto";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoPrimaCosto";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoPrimaCostoML

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoPrimaCostoML";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoPrimaCostoML";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoCodMonPagPrima

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoCodMonPagPrima";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoCodMonPagPrima";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoPrimaInicial

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoPrimaInicial";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoPrimaInicial";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoPrimaInicialML

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoPrimaInicialML";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoPrimaInicialML";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoParMdaPrima

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoParMdaPrima";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoParMdaPrima";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MofPagoPrima

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MofPagoPrima";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MofPagoPrima";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            //5843
            #region MoResultadoVentasML

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoResultadoVentasML";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoResultadoVentasML";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoMonCarryPrima

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoMonCarryPrima";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoMonCarryPrima";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoCarryPrima

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoCarryPrima";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoCarryPrima";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoParM2Spot

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoParM2Spot";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoParM2Spot";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoFechaPagoPrima

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoFechaPagoPrima";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoFechaPagoPrima";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoFecValorizacion

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoFecValorizacion";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoFecValorizacion";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoMon_vr

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoMon_vr";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoMon_vr";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoVr

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoVr";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoVr";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoVr_Costo

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoVr_Costo";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoVr_Costo";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoMondelta

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoMondelta";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoMondelta";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoMon_gamma

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoMon_gamma";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoMon_gamma";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoMon_vega

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoMon_vega";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoMon_vega";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoMon_vanna

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoMon_vanna";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoMon_vanna";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoMon_volga

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoMon_volga";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoMon_volga";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoMon_theta

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoMon_theta";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoMon_theta";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoMon_rho

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoMon_rho";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoMon_rho";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoMon_rhof

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoMon_rhof";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoMon_rhof";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoMon_charm

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoMon_charm";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoMon_charm";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoMon_zomma

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoMon_zomma";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoMon_zomma";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoMon_speed

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoMon_speed";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoMon_speed";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoPrimaBSSpotCont

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoPrimaBSSpotCont";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoPrimaBSSpotCont";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoDeltaSpotCont

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoDeltaSpotCont";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoDeltaSpotCont";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoDeltaForwardCont

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoDeltaForwardCont";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoDeltaForwardCont";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoGammaCont

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoGammaCont";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoGammaCont";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoVegaCont

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoVegaCont";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoVegaCont";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoVannaCont

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoVannaCont";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoVannaCont";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoVolgaCont

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoVolgaCont";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoVolgaCont";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoThetaCont

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoThetaCont";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoThetaCont";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoRhoDomCont

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoRhoDomCont";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoRhoDomCont";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoRhoForCont

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoRhoForCont";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoRhoForCont";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoCharmCont

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoCharmCont";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoCharmCont";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoUnwind

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoUnwind";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoUnwind";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoUnwindCosto

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoUnwindCosto";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoUnwindCosto";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoFormPagoUnwind

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoFormPagoUnwind";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoFormPagoUnwind";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            //PRD_10449 ASVG_20111102
            #region MoRelacionaPAE

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoRelacionaPAE";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoRelacionaPAE";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            //Prd_16803
            #region MoRelacionaLeasing

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoRelacionaLeasing";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoRelacionaLeasing";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoNumeroLeasing

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoNumeroLeasing";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoNumeroLeasing";
            _DTHead.Columns.Add(_DCHead);

            #endregion

            #region MoNumeroBien

            _DCHead = new DataColumn();
            _DCHead.ColumnName = "MoNumeroBien";
            _DCHead.DataType = Type.GetType("System.String");
            _DCHead.Caption = "MoNumeroBien";
            _DTHead.Columns.Add(_DCHead);

            #endregion
            //Prd_16803
            #endregion

            return _DTHead;
        }

        private DataTable GenerateTableDetail()
        {
            DataTable _DTDetail = new DataTable();
            DataColumn _DCDetail = new DataColumn();

            _DTDetail.TableName = "detContrato";

            #region Generate Fileds

            #region MoNumFolio

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoNumFolio";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoNumFolio";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoNumEstructura

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoNumEstructura";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoNumEstructura";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoVinculacion

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoVinculacion";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoVinculacion";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoTipoOpc

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoTipoOpc";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoTipoOpc";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoSubyacente

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoSubyacente";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoSubyacente";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoTipoPayOff

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoTipoPayOff";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoTipoPayOff";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoCallPut

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoCallPut";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoCallPut";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoCVOpc

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoCVOpc";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoCVOpc";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoTipoEmisionPT

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoTipoEmisionPT";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoTipoEmisionPT";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoFechaInicioOpc

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoFechaInicioOpc";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoFechaInicioOpc";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoFechaFijacion

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoFechaFijacion";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoFechaFijacion";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoFechaVcto

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoFechaVcto";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoFechaVcto";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoFormaPagoMon1

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoFormaPagoMon1";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoFormaPagoMon1";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoFechaPagMon1

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoFechaPagMon1";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoFechaPagMon1";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoFormaPagoMon2

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoFormaPagoMon2";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoFormaPagoMon2";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoFechaPagMon2

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoFechaPagMon2";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoFechaPagMon2";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoFechaPagoEjer

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoFechaPagoEjer";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoFechaPagoEjer";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoCodMon1

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoCodMon1";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoCodMon1";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoMontoMon1

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoMontoMon1";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoMontoMon1";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoCodMon2

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoCodMon2";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoCodMon2";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoMontoMon2

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoMontoMon2";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoMontoMon2";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoModalidad

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoModalidad";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoModalidad";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoMdaCompensacion

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoMdaCompensacion";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoMdaCompensacion";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoBenchComp

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoBenchComp";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoBenchComp";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoParStrike

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoParStrike";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoParStrike";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoStrike

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoStrike";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoStrike";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoPorcStrike

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoPorcStrike";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoPorcStrike";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoTipoEjercicio

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoTipoEjercicio";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoTipoEjercicio";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoSpotDet

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoSpotDet";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoSpotDet";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoCurveMon1

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoCurveMon1";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoCurveMon1";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoCurveMon2

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoCurveMon2";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoCurveMon2";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoCurveSmile

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoCurveSmile";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoCurveSmile";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoWf_mon1

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoWf_mon1";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoWf_mon1";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoWf_mon2

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoWf_mon2";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoWf_mon2";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoVol

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoVol";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoVol";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoFwd_teo

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoFwd_teo";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoFwd_teo";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoVrDet

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoVrDet";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoVrDet";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoSpotDetCosto

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoSpotDetCosto";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoSpotDetCosto";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoWf_Mon1_Costo

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoWf_Mon1_Costo";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoWf_Mon1_Costo";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoWf_Mon2_Costo

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoWf_Mon2_Costo";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoWf_Mon2_Costo";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoVol_Costo

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoVol_Costo";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoVol_Costo";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoFwd_Teo_Costo

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoFwd_Teo_Costo";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoFwd_Teo_Costo";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoVr_Costo

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoVr_Costo";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoVr_Costo";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoVr_CostoDet

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoVr_CostoDet";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoVr_CostoDet";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoPrimaBSSpotDet

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoPrimaBSSpotDet";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoPrimaBSSpotDet";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoIteAsoSis

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoIteAsoSis";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoIteAsoSis";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoIteAsoCon

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoIteAsoCon";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoIteAsoCon";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoFormaPagoComp

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoFormaPagoComp";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoFormaPagoComp";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoDelta_spot

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoDelta_spot";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoDelta_spot";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoDelta_spot_num

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoDelta_spot_num";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoDelta_spot_num";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoDelta_fwd

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoDelta_fwd";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoDelta_fwd";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoDelta_fwd_num

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoDelta_fwd_num";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoDelta_fwd_num";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoGamma_spot

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoGamma_spot";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoGamma_spot";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoGamma_spot_num

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoGamma_spot_num";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoGamma_spot_num";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoGamma_fwd

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoGamma_fwd";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoGamma_fwd";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoGamma_fwd_num

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoGamma_fwd_num";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoGamma_fwd_num";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoVega

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoVega";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoVega";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoVega_num

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoVega_num";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoVega_num";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoVanna_spot

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoVanna_spot";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoVanna_spot";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoVanna_spot_num

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoVanna_spot_num";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoVanna_spot_num";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoVanna_fwd

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoVanna_fwd";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoVanna_fwd";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoVanna_fwd_num

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoVanna_fwd_num";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoVanna_fwd_num";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoVolga

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoVolga";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoVolga";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoVolga_num

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoVolga_num";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoVolga_num";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoTheta

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoTheta";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoTheta";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoTheta_num

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoTheta_num";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoTheta_num";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoRho

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoRho";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoRho";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoRho_num

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoRho_num";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoRho_num";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoRhof

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoRhof";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoRhof";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoRhof_num

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoRhof_num";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoRhof_num";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoCharm_spot

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoCharm_spot";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoCharm_spot";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoCharm_spot_num

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoCharm_spot_num";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoCharm_spot_num";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoCharm_fwd

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoCharm_fwd";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoCharm_fwd";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoCharm_fwd_num

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoCharm_fwd_num";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoCharm_fwd_num";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region 

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #endregion

            return _DTDetail;
        }

        private DataTable GenerateTableDetailCartera()
        {
            DataTable _DTDetail = new DataTable();
            DataColumn _DCDetail = new DataColumn();

            _DTDetail.TableName = "detContrato";

            #region Generate Fileds

            #region NumFolio

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "NumContrato";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "NumFolio";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region NumEstructura

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "NumEstructura";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "NumEstructura";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoCurveMon1

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoCurveMon1";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoCurveMon1";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoCurveMon2

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoCurveMon2";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoCurveMon2";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoCurveSmile

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoCurveSmile";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoCurveSmile";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoWf_mon1

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoWf_mon1";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoWf_mon1";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoWf_mon2

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoWf_mon2";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoWf_mon2";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoVol

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoVol";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoVol";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoFwd_teo

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoFwd_teo";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoFwd_teo";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoDeltaSpot

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoDeltaSpot";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoDeltaSpot";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoVrDet

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoVrDet";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoVrDet";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoSpotDet

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoSpotDet";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoSpotDet";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoRho

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoRho";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoRho";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoRho_num

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoRho_num";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoRho_num";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoRhof

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoRhof";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoRhof";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoRhof_num

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoRhof_num";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoRhof_num";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoCharm_spot

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoCharm_spot";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoCharm_spot";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoCharm_spot_num

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoCharm_spot_num";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoCharm_spot_num";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoCharm_fwd

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoCharm_fwd";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoCharm_fwd";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoCharm_fwd_num

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoCharm_fwd_num";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoCharm_fwd_num";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoVanna_spot

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoVanna_spot";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoVanna_spot";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoVanna_spot_num

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoVanna_spot_num";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoVanna_spot_num";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoVanna_fwd

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoVanna_fwd";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoVanna_fwd";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoVanna_fwd_num

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoVanna_fwd_num";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoVanna_fwd_num";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoGamma_spot

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoGamma_spot";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoGamma_spot";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoGamma_spot_num

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoGamma_spot_num";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoGamma_spot_num";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoGamma_fwd

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoGamma_fwd";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoGamma_fwd";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoGamma_fwd_num

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoGamma_fwd_num";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoGamma_fwd_num";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoVega

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoVega";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoVega";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoVega_num

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoVega_num";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoVega_num";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoDelta_spot

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoDelta_spot";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoDelta_spot";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoDelta_spot_num

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoDelta_spot_num";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoDelta_spot_num";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoDelta_fwd

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoDelta_fwd";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoDelta_fwd";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoDelta_fwd_num

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoDelta_fwd_num";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoDelta_fwd_num";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoVolga

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoVolga";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoVolga";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoVolga_num

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoVolga_num";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoVolga_num";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoTheta

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoTheta";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoTheta";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoTheta_num

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoTheta_num";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoTheta_num";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            // MAP 20130220
            #region MoStrike      

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoStrike";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoStrike";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #region MoMontoMon2

            _DCDetail = new DataColumn();
            _DCDetail.ColumnName = "MoMontoMon2";
            _DCDetail.DataType = Type.GetType("System.String");
            _DCDetail.Caption = "MoMontoMon2";
            _DTDetail.Columns.Add(_DCDetail);

            #endregion

            #endregion

            return _DTDetail;
        }

        private DataTable GenerateTableFixing()
        {
            DataTable _DTFixing = new DataTable();
            DataColumn _DCFixing = new DataColumn();
            
            _DTFixing.TableName = "FixingData";
            
            #region Generate Fileds

            #region ID

            _DCFixing = new DataColumn();
            _DCFixing.ColumnName = "ID";
            _DCFixing.DataType = Type.GetType("System.Int16");
            _DCFixing.Caption = "ID";
            _DTFixing.Columns.Add(_DCFixing);

            #endregion

            #region MoNumContrato

            _DCFixing = new DataColumn();
            _DCFixing.ColumnName = "MoNumContrato";
            _DCFixing.DataType = Type.GetType("System.String");
            _DCFixing.Caption = "MoNumContrato";
            _DTFixing.Columns.Add(_DCFixing);

            #endregion

            #region MoNumEstructura

            _DCFixing = new DataColumn();
            _DCFixing.ColumnName = "MoNumEstructura";
            _DCFixing.DataType = Type.GetType("System.String");
            _DCFixing.Caption = "MoNumEstructura";
            _DTFixing.Columns.Add(_DCFixing);

            #endregion

            #region Fecha

            _DCFixing = new DataColumn();
            _DCFixing.ColumnName = "Fecha";
            _DCFixing.DataType = Type.GetType("System.String");
            _DCFixing.Caption = "Fecha";
            _DTFixing.Columns.Add(_DCFixing);

            #endregion

            #region Valor

            _DCFixing = new DataColumn();
            _DCFixing.ColumnName = "Valor";
            _DCFixing.DataType = Type.GetType("System.String");
            _DCFixing.Caption = "Valor";
            _DTFixing.Columns.Add(_DCFixing);

            #endregion

            #region Peso

            _DCFixing = new DataColumn();
            _DCFixing.ColumnName = "Peso";
            _DCFixing.DataType = Type.GetType("System.String");
            _DCFixing.Caption = "Peso";
            _DTFixing.Columns.Add(_DCFixing);

            #endregion

            #region Volatilidad

            _DCFixing = new DataColumn();
            _DCFixing.ColumnName = "Volatilidad";
            _DCFixing.DataType = Type.GetType("System.String");
            _DCFixing.Caption = "Volatilidad";
            _DTFixing.Columns.Add(_DCFixing);

            #endregion

            #region Plazo

            _DCFixing = new DataColumn();
            _DCFixing.ColumnName = "Plazo";
            _DCFixing.DataType = Type.GetType("System.String");
            _DCFixing.Caption = "Plazo";
            _DTFixing.Columns.Add(_DCFixing);

            #endregion

            #endregion

            return _DTFixing;
        }

        private DataTable GenerateTableStrip()
        {
            DataTable _DTStrip = new DataTable();
            DataColumn _DCStrip = new DataColumn();
            _DTStrip.TableName = "StripData";

            #region FechaInicio

            _DCStrip = new DataColumn();
            _DCStrip.ColumnName = "FechaInicioStrip";
            _DCStrip.DataType = Type.GetType("System.DateTime");
            _DCStrip.Caption = "FechaInicioStrip";
            _DTStrip.Columns.Add(_DCStrip);

            #endregion

            #region FechaVcto

            _DCStrip = new DataColumn();
            _DCStrip.ColumnName = "FechaVencimientoStrip";
            _DCStrip.DataType = Type.GetType("System.DateTime");
            _DCStrip.Caption = "FechaVencimientoStrip";
            _DTStrip.Columns.Add(_DCStrip);

            #endregion

            #region TotalContratosPorStrip

            _DCStrip = new DataColumn();
            _DCStrip.ColumnName = "TotalContratosPorStrip";
            _DCStrip.DataType = Type.GetType("System.Int32");
            _DCStrip.Caption = "TotalContratosPorStrip";
            _DTStrip.Columns.Add(_DCStrip);

            #endregion

            #region ID

            _DCStrip = new DataColumn();
            _DCStrip.ColumnName = "NumeroContratoActualStrip";
            _DCStrip.DataType = Type.GetType("System.Int32");
            _DCStrip.Caption = "NumeroContratoActualStrip";
            _DTStrip.Columns.Add(_DCStrip);

            #endregion

            return _DTStrip;
        }

        /// <summary>
        /// No hace nada, no se usa.
        /// </summary>
        /// <param name="_DRHead"></param>
        /// <param name="_DataHead"></param>
        private void SaveHead(DataRow _DRHead, XElement _DataHead)
        {
        }

        [WebMethod]
        public string RecuperaContrato(int NumContrato, int NumFolio) 
        {
            DataSet _Cartera = new DataSet();
            string _xmlReturn = string.Empty;
            try
            {
                _Cartera = Acciones.TraeContrato(NumContrato, NumFolio);

                MemoryStream stream = new MemoryStream();
                XmlDocument doc = new XmlDocument();
                _Cartera.WriteXml(stream, XmlWriteMode.IgnoreSchema);
                stream.Seek(0, SeekOrigin.Begin);
                doc.Load(stream);

                XDocument _XmlCartera = new XDocument();
                _XmlCartera = XDocument.Load(new XmlNodeReader(doc));
                _xmlReturn = _XmlCartera.ToString();
            }
            catch { }
            return _xmlReturn;
        }

        [WebMethod]
        public string UpdateOption(string xdocInsert)
        {
            try
            {
                string _result = string.Empty;
                DataSet _Datos = SaveDataOption(XDocument.Parse(xdocInsert));
                _result = Acciones.ActualizaCartera(_Datos);
                if (!Acciones.CheckSaveValuator(_Datos))
                {
                    return "Error en la valorización";
                }
                else
                {
                    Acciones.SumaVertical();
                    return _result;
                }
            }
            catch(Exception e)
            {
                return e.Message;
            }
        }

        [WebMethod]
        public string UpdateFlagValuator()
        {
            string _Value = "";
            try
            {
                DataTable _Data = Acciones.UpdateFlagValorizacion();

                if (_Data != null)
                {
                    if (_Data.Rows.Count > 0)
                    {
                        _Value = string.Format(
                                                "<Value Status='{0}' Message='{1}' />",
                                                _Data.Rows[0][0].ToString(),
                                                _Data.Rows[0][1].ToString()
                                              );
                    }
                }
                if (_Value.Equals(""))
                {
                    _Value = "<Value Status='1' Message='Error no definido' />";
                }
            }
            catch (Exception _Error)
            {
                _Value = string.Format("<Value Status='1' Message='{0}' />", _Error.Message);
            }
            return _Value;
        }

        private DataSet SaveDataOption(XDocument xmlValue)
        {

            DataTable _DTDetail = GenerateTableDetailCartera();
            DataTable _DTFixing = GenerateTableFixing();
            XElement _DataDetail;
            DataRow _DRDetail;
            DataRow _DRFixing;
            int _FixingID;
            DataSet _DSOpciones = new DataSet();

            foreach (XElement _Contract in xmlValue.Descendants("Opcion"))
            {
                _DataDetail = _Contract.Element("detContrato");

                _DRDetail = _DTDetail.NewRow();

                #region Detalle

                _DRDetail["NumContrato"] = _Contract.Attribute("NumContrato").Value.ToString();
                _DRDetail["NumEstructura"] = _Contract.Attribute("NumEstructura").Value.ToString();

                _DRDetail["MoCurveMon1"] = _DataDetail.Element("Curvas").Attribute("MoCurveMon1").Value.ToString();
                _DRDetail["MoCurveMon2"] = _DataDetail.Element("Curvas").Attribute("MoCurveMon2").Value.ToString();
                _DRDetail["MoCurveSmile"] = _DataDetail.Element("Curvas").Attribute("MoCurveSmile").Value.ToString();
                _DRDetail["MoWf_mon1"] = _DataDetail.Element("MtM").Attribute("MoWf_mon1").Value.ToString();
                _DRDetail["MoWf_mon2"] = _DataDetail.Element("MtM").Attribute("MoWf_mon2").Value.ToString();
                _DRDetail["MoVol"] = _DataDetail.Element("MtM").Attribute("MoVol").Value.ToString();
                _DRDetail["MoFwd_teo"] = _DataDetail.Element("MtM").Attribute("MoFwd_teo").Value.ToString();
                _DRDetail["MoDeltaSpot"] = _DataDetail.Element("Griegas").Attribute("MoDelta_spot").Value.ToString();
                _DRDetail["MoVrDet"] = _DataDetail.Element("MtM").Attribute("MoVrDet").Value.ToString();
                _DRDetail["MoSpotDet"] = _DataDetail.Element("Proceso").Attribute("MoSpotDet").Value.ToString();
                _DRDetail["MoRho"] = _DataDetail.Element("Griegas").Attribute("MoRho").Value.ToString();
                _DRDetail["MoRho_num"] = _DataDetail.Element("Griegas").Attribute("MoRho_num").Value.ToString();
                _DRDetail["MoRhof"] = _DataDetail.Element("Griegas").Attribute("MoRhof").Value.ToString();
                _DRDetail["MoRhof_num"] = _DataDetail.Element("Griegas").Attribute("MoRhof_num").Value.ToString();
                _DRDetail["MoCharm_spot"] = _DataDetail.Element("Griegas").Attribute("MoCharm_spot").Value.ToString();
                _DRDetail["MoCharm_spot_num"] = _DataDetail.Element("Griegas").Attribute("MoCharm_spot_num").Value.ToString();
                _DRDetail["MoCharm_fwd"] = _DataDetail.Element("Griegas").Attribute("MoCharm_fwd").Value.ToString();
                _DRDetail["MoCharm_fwd_num"] = _DataDetail.Element("Griegas").Attribute("MoCharm_fwd_num").Value.ToString();
                _DRDetail["MoVanna_spot"] = _DataDetail.Element("Griegas").Attribute("MoVanna_spot").Value.ToString();
                _DRDetail["MoVanna_spot_num"] = _DataDetail.Element("Griegas").Attribute("MoVanna_spot_num").Value.ToString();
                _DRDetail["MoVanna_fwd"] = _DataDetail.Element("Griegas").Attribute("MoVanna_fwd").Value.ToString();
                _DRDetail["MoVanna_fwd_num"] = _DataDetail.Element("Griegas").Attribute("MoVanna_fwd_num").Value.ToString();
                _DRDetail["MoGamma_spot"] = _DataDetail.Element("Griegas").Attribute("MoGamma_spot").Value.ToString();
                _DRDetail["MoGamma_spot_num"] = _DataDetail.Element("Griegas").Attribute("MoGamma_spot_num").Value.ToString();
                _DRDetail["MoGamma_fwd"] = _DataDetail.Element("Griegas").Attribute("MoGamma_fwd").Value.ToString();
                _DRDetail["MoGamma_fwd_num"] = _DataDetail.Element("Griegas").Attribute("MoGamma_fwd_num").Value.ToString();
                _DRDetail["MoVega"] = _DataDetail.Element("Griegas").Attribute("MoVega").Value.ToString();
                _DRDetail["MoVega_num"] = _DataDetail.Element("Griegas").Attribute("MoVega_num").Value.ToString();
                _DRDetail["MoDelta_spot"] = _DataDetail.Element("Griegas").Attribute("MoDelta_spot").Value.ToString();
                _DRDetail["MoDelta_spot_num"] = _DataDetail.Element("Griegas").Attribute("MoDelta_spot_num").Value.ToString();
                _DRDetail["MoDelta_fwd"] = _DataDetail.Element("Griegas").Attribute("MoDelta_fwd").Value.ToString();
                _DRDetail["MoDelta_fwd_num"] = _DataDetail.Element("Griegas").Attribute("MoDelta_fwd_num").Value.ToString();
                _DRDetail["MoVolga"] = _DataDetail.Element("Griegas").Attribute("MoVolga").Value.ToString();
                _DRDetail["MoVolga_num"] = _DataDetail.Element("Griegas").Attribute("MoVolga_num").Value.ToString();
                _DRDetail["MoTheta"] = _DataDetail.Element("Griegas").Attribute("MoTheta").Value.ToString();
                _DRDetail["MoTheta_num"] = _DataDetail.Element("Griegas").Attribute("MoTheta_num").Value.ToString();

                //PRD_12567
                _DRDetail["MoStrike"] = _DataDetail.Element("Subyacente").Attribute("MoStrike").Value.ToString(); // MAP 20120220
                _DRDetail["MoMontoMon2"] = _DataDetail.Element("Subyacente").Attribute("MoMontoMon2").Value.ToString(); // MAP 20120220

                _DTDetail.Rows.Add(_DRDetail);

                #endregion

                _FixingID = 0;
                foreach (XElement _Fixing in _DataDetail.Descendants("FixingValues"))
                {
                    _DRFixing = _DTFixing.NewRow();
                    _FixingID++;

                    #region Assign Record Data

                    _DRFixing["MoNumEstructura"] = _Contract.Attribute("NumEstructura").Value.ToString();
                    _DRFixing["MoNumContrato"] = _Contract.Attribute("NumContrato").Value.ToString();
                    _DRFixing["ID"] = _FixingID;
                    _DRFixing["Fecha"] = _Fixing.Attribute("Fecha").Value.ToString();
                    _DRFixing["Valor"] = _Fixing.Attribute("Valor").Value.ToString();
                    _DRFixing["Peso"] = _Fixing.Attribute("Peso").Value.ToString();
                    _DRFixing["Volatilidad"] = _Fixing.Attribute("Volatilidad").Value.ToString();
                    _DRFixing["Plazo"] = _Fixing.Attribute("Plazo").Value.ToString();

                    #endregion

                    _DTFixing.Rows.Add(_DRFixing);
                }
            }

            _DSOpciones.Merge(_DTDetail);
            _DSOpciones.Merge(_DTFixing);

            return _DSOpciones;
        }


        [WebMethod]
        public string getTransactionIDD(string Aplicacion, string modulo, int numOp, int numDoc, int correlativo)
        {
            DataTable _result;
            string _return ="";
            try
            {
                _result = Acciones.Obtener_Transaccion_Tabla_IDD(Aplicacion, modulo, numOp, numDoc, correlativo);
                    if (_result != null)
                    {
                        DataRow _p = _result.Rows[0];
                        for (int i = 0; i < _p.ItemArray.Length; i++)
                        {
                            _return = _return + _p[i].ToString()+Environment.NewLine;
                        }
                        _return = _return.Substring(0, _return.Length - 1);

                    }
            }
            catch(Exception e)
            {
                            _return = e.Message;
            }

            return _return;
        }





        [WebMethod]
        public string updateTransaccionIDD(int statusIDD, string Aplicacion, string modulo, int numOp, int numDoc, int correlativo, string mensajeIDD, int numeroIDD, int controlLinea)
        {
           
            string _return = "";
            try
            {
                _return = Acciones.Actualiza_Transaccion_Tabla_IDD(statusIDD, Aplicacion, modulo, numOp, numDoc, correlativo, mensajeIDD, numeroIDD, controlLinea);

            }
            catch (Exception e)
            {
                _return = e.Message;
            }

            return _return;
        }


    }
}
