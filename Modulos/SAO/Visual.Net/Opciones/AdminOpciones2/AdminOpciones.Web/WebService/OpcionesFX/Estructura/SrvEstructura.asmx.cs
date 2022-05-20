using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Xml.Linq;
using AdminOpcionesTool.Opciones.Payoffs;
using AdminOpcionesTool.Opciones.Struct;
using cFinancialTools.Yield;
using cFinancialTools.BussineDate;
using AdminOpcionesTool.Opciones.Functions;
using AdminOpciones.OpcionesFX.Front; //se usa???

namespace AdminOpciones.Web.WebService.OpcionesFX.Estructura
{
    /// <summary>
    /// Descripción breve de SrvEstructura
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class SrvEstructura : System.Web.Services.WebService
    {
        [WebMethod]
        public string ForwardSintetico(string strikes_delta_flag, string vanilla_asiatica, string BsSpot_BsFwd, string Fijaciones, string estructura, string payoff, double puntosCosto, DateTime fecha_Val, DateTime fecha_Vencto, DateTime FechaSetDePrecios, string call_put, string paridad, string compra_venta, double nocional, double spot, double spotsmile, string Strikes_Delta_XML, string YieldNameDom, string YieldNameFor, int enumSetPricing)
        {
            try
            {
                Calendars calendario = new Calendars();
                calendario.Load();

                if (!calendario.IsBussineDay(6, fecha_Vencto))
                {
                    fecha_Vencto = calendario.NextHolidayDate(6, fecha_Vencto);
                    string _FechaFestivoResutl = "";
                    _FechaFestivoResutl = "<Data>\n";
                    _FechaFestivoResutl += "<Vencimiento MoFechaVcto='" + fecha_Vencto.ToString("dd-MM-yyyy") + "'/>\n"; ;
                    _FechaFestivoResutl += "</Data>";

                    return _FechaFestivoResutl;
                }

                YieldList CurvaList = new YieldList();
                CurvaList.SetPrincingLoading = (enumSetPrincingLoading)enumSetPricing;
                CurvaList.Load(YieldNameDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);
                CurvaList.Load(YieldNameFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);

                AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura _Estructura = new AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura(CurvaList, strikes_delta_flag, Fijaciones, estructura, payoff, fecha_Val, fecha_Vencto,FechaSetDePrecios, paridad, nocional, Strikes_Delta_XML,
                      compra_venta, spot, spotsmile, puntosCosto, YieldNameDom, YieldNameFor, (enumSetPrincingLoading)enumSetPricing);

                string _ReturnValue = "<ForwardSintetico>\n";

                _ReturnValue += _Estructura.ForwardSintetico(vanilla_asiatica, BsSpot_BsFwd);

                _ReturnValue += "</ForwardSintetico>";

                return _ReturnValue;

            }
            catch { return ""; };
        }

        [WebMethod]
        public double Solver_FwdSintetico(double price_objective, string strikes_delta_flag, string vanilla_asiatica, string BsSpot_BsFwd, string Fijaciones, string estructura, string payoff, double puntos_fwd_costo, DateTime fecha_Val, DateTime fecha_Vencto, DateTime FechaSetDePrecios, string paridad, string compra_venta, double nocional, double spot, string Strike_Delta_Values_XML, string YieldNameDom, string YieldNameFor, int setPrecios)
        {
            double _Variador;
            Vanilla _Vanila;
            AdminOpcionesTool.Opciones.Payoffs.Asiatica _Asiatica;
            
            try
            {
                YieldList CurvaList = new YieldList();
                CurvaList.SetPrincingLoading = (enumSetPrincingLoading)setPrecios;
                CurvaList.Load(YieldNameDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);
                CurvaList.Load(YieldNameFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);

                               

                if (payoff.Equals("Vanilla"))
                {
                    //_Vanila = new Vanilla(CurvaList, paridad, "c", compra_venta, nocional, spot, puntos_fwd_costo, putnosFwd + spotFwd, fecha_Val, fecha_Vencto, YieldNameDom, YieldNameFor, (enumSetPrincingLoading)setPrecios, 0);
                    _Vanila = new Vanilla(CurvaList, paridad, "c", compra_venta, nocional, spot, puntos_fwd_costo, spot, fecha_Val, fecha_Vencto,FechaSetDePrecios, YieldNameDom, YieldNameFor, (enumSetPrincingLoading)setPrecios, 0, BsSpot_BsFwd);

                    _Variador = _Vanila.find_strike_price_ForwardSintetico(price_objective, BsSpot_BsFwd);
                }
                else 
                {

                    XDocument xdocFixing = new XDocument(XDocument.Parse(Fijaciones));
                    var elements = from elementItem in xdocFixing.Descendants("FixingValues")
                                   select new StructFixingData
                                   {
                                       Fecha = DateTime.Parse(elementItem.Attribute("Fecha").Value.ToString()),
                                       Valor = double.Parse(elementItem.Attribute("Valor").Value.ToString()),
                                       Peso = double.Parse(elementItem.Attribute("Peso").Value.ToString()),
                                       Volatilidad = double.Parse(elementItem.Attribute("Volatilidad").Value.ToString()),
                                       Plazo = int.Parse(elementItem.Attribute("Plazo").Value.ToString())

                                   };

                    List<StructFixingData> fixingdataList = new List<StructFixingData>(elements.ToList<StructFixingData>());

                    var fixingDateVar = from itemfixingdate in fixingdataList
                                        select itemfixingdate.Fecha;

                    var fixingValorVar = from itemfixingdate in fixingdataList
                                         select itemfixingdate.Valor;

                    var fixingPesosVar = from itemfixingdate in fixingdataList
                                         select itemfixingdate.Peso;

                    var fixingVolatilidadVar = from itemfixingdate in fixingdataList
                                               select itemfixingdate.Volatilidad;

                    var fixingPlazosVar = from itemfixingdate in fixingdataList
                                          select itemfixingdate.Plazo;

                    List<DateTime> fechas_fijacion = new List<DateTime>();
                    List<double> pesos_fijacion = new List<double>();
                    List<double> fijaciones = new List<double>();
                    List<double> volatilidades = new List<double>();
                    List<int> plazos_fijaciones = new List<int>();

                    fechas_fijacion = fixingDateVar.ToList<DateTime>();
                    fijaciones = fixingValorVar.ToList<double>();
                    pesos_fijacion = fixingPesosVar.ToList<double>();
                    volatilidades = fixingVolatilidadVar.ToList<double>();
                    plazos_fijaciones = fixingPlazosVar.ToList<int>();


                    _Asiatica = new AdminOpcionesTool.Opciones.Payoffs.Asiatica(CurvaList,paridad, "c", compra_venta, nocional, spot, spot, fecha_Val, fecha_Vencto, FechaSetDePrecios, YieldNameDom, YieldNameFor, (enumSetPrincingLoading)setPrecios, fechas_fijacion, pesos_fijacion, fijaciones, volatilidades, plazos_fijaciones, 0);
                   _Variador =  _Asiatica.find_strike_ForwardAsiatico(price_objective);

                }

                                               


            }
            catch
            {
                return double.NaN;
            }

            return _Variador;

        }

        [WebMethod]
        public string Straddle(string strikes_delta_flag, string vanilla_asiatica, string BsSpot_BsFwd, string Fijaciones, string estructura, string payoff, double puntos_fwd_costo, DateTime fecha_Val, DateTime fecha_Vencto, DateTime FechaSetDePrecios, string call_put, string paridad, string compra_venta, double nocional, double spot, double spotsmile, string Strikes_Delta_XML, string YieldNameDom, string YieldNameFor, int setPrecios)
        {
            try
            {

                Calendars calendario = new Calendars();
                calendario.Load();

                if (!calendario.IsBussineDay(6, fecha_Vencto))
                {
                    fecha_Vencto = calendario.NextHolidayDate(6, fecha_Vencto);
                    string _FechaFestivoResutl = "";
                    _FechaFestivoResutl = "<Data>\n";
                    _FechaFestivoResutl += "<Vencimiento MoFechaVcto='" + fecha_Vencto.ToString("dd-MM-yyyy") + "'/>\n"; ;
                    _FechaFestivoResutl += "</Data>";

                    return _FechaFestivoResutl;
                }
                YieldList CurvaList = new YieldList();
                CurvaList.SetPrincingLoading = (enumSetPrincingLoading)setPrecios;
                CurvaList.Load(YieldNameDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);
                CurvaList.Load(YieldNameFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);

                AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura _Estructura = new AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura(CurvaList, strikes_delta_flag, Fijaciones, estructura, payoff, fecha_Val, fecha_Vencto, FechaSetDePrecios, paridad, nocional, Strikes_Delta_XML, compra_venta, spot, spotsmile, puntos_fwd_costo, YieldNameDom, YieldNameFor, (enumSetPrincingLoading)setPrecios);
                
                string _ReturnValue = "<Straddle>\n";

                _ReturnValue += _Estructura.Straddle(vanilla_asiatica, BsSpot_BsFwd);

                _ReturnValue += "</Straddle>";
                return _ReturnValue;
            }
            catch { return ""; };
        }

        [WebMethod]
        public string Strangle(string strikes_delta_flag, string vanilla_asiatica, string BsSpot_BsFwd, string Fijaciones, string estructura, string payoff, double puntos_fwd_costo, DateTime fecha_Val, DateTime fecha_Vencto, DateTime FechaSetDePrecios, string call_put, string paridad, string compra_venta, double nocional, double spot, double spotsmile, string Strike_Delta_Values_XML, string YieldNameDom, string YieldNameFor, int setPrecios)
        {
            try
            {
                Calendars calendario = new Calendars();
                calendario.Load();

                if (!calendario.IsBussineDay(6, fecha_Vencto))
                {
                    fecha_Vencto = calendario.NextHolidayDate(6, fecha_Vencto);
                    string _FechaFestivoResutl = "";
                    _FechaFestivoResutl = "<Data>\n";
                    _FechaFestivoResutl += "<Vencimiento MoFechaVcto='" + fecha_Vencto.ToString("dd-MM-yyyy") + "'/>\n"; ;
                    _FechaFestivoResutl += "</Data>";

                    return _FechaFestivoResutl;
                }

                YieldList CurvaList = new YieldList();
                CurvaList.SetPrincingLoading = (enumSetPrincingLoading)setPrecios;
                CurvaList.Load(YieldNameDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);
                CurvaList.Load(YieldNameFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);


                AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura _Estructura = new AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura(CurvaList, strikes_delta_flag, Fijaciones, estructura, payoff, fecha_Val, fecha_Vencto, FechaSetDePrecios, paridad, nocional, Strike_Delta_Values_XML, compra_venta, spot, spotsmile, puntos_fwd_costo, YieldNameDom, YieldNameFor, (enumSetPrincingLoading)setPrecios);

                string _ReturnValue = "<Strangle>\n";

                _ReturnValue += _Estructura.Strangle(vanilla_asiatica, BsSpot_BsFwd);

                _ReturnValue += "</Strangle>";

                return _ReturnValue;
            }
            catch { return ""; };
        }

        [WebMethod]
        public string Butterfly(string strikes_delta_flag, string vanilla_asiatica, string BsSpot_BsFwd, string Fijaciones, string estructura, bool VegaWeighted, double NocionalStrangle, string payoff, double puntos_fwd_costo, DateTime fecha_Val, DateTime fecha_Vencto, DateTime FechaSetDePrecios, string call_put, string paridad, string compra_venta, double nocional, double spot, double spotsmile, string Strike_Delta_Values_XML, string YieldNameDom, string YieldNameFor, int setPrecios)
        {
            try
            {
                Calendars calendario = new Calendars();
                calendario.Load();

                if (!calendario.IsBussineDay(6, fecha_Vencto))
                {
                    fecha_Vencto = calendario.NextHolidayDate(6, fecha_Vencto);
                    string _FechaFestivoResutl = "";
                    _FechaFestivoResutl = "<Data>\n";
                    _FechaFestivoResutl += "<Vencimiento MoFechaVcto='" + fecha_Vencto.ToString("dd-MM-yyyy") + "'/>\n"; ;
                    _FechaFestivoResutl += "</Data>";

                    return _FechaFestivoResutl;
                }

                YieldList CurvaList = new YieldList();
                CurvaList.SetPrincingLoading = (enumSetPrincingLoading)setPrecios;
                CurvaList.Load(YieldNameDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);
                CurvaList.Load(YieldNameFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);


                AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura _Estructura = new AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura(CurvaList, strikes_delta_flag, Fijaciones, estructura, payoff, fecha_Val, fecha_Vencto, FechaSetDePrecios, paridad, nocional, Strike_Delta_Values_XML, compra_venta, spot, spotsmile, puntos_fwd_costo, YieldNameDom, YieldNameFor, (enumSetPrincingLoading)setPrecios);

                string _ReturnValue = "<Butterfly>\n";

                _ReturnValue += _Estructura.Butterfly(vanilla_asiatica, BsSpot_BsFwd, VegaWeighted, NocionalStrangle);

                _ReturnValue += "</Butterfly>";

                return _ReturnValue;
            }
            catch { return ""; };
        }

        [WebMethod]
        public string RiskReversal(string strikes_delta_flag, string vanilla_asiatica, string BsSpot_BsFwd, string Fijaciones, string estructura, string payoff, double puntos_fwd_costo, DateTime fecha_Val, DateTime fecha_Vencto, DateTime FechaSetDePrecios, string call_put, string paridad, string compra_venta, double nocional, double spot, double spotSmile, string Strike_Delta_Values_XML, string YieldNameDom, string YieldNameFor, int setPrecios)
        {
            try
            {
                Calendars calendario = new Calendars();
                calendario.Load();

                if (!calendario.IsBussineDay(6, fecha_Vencto))
                {
                    fecha_Vencto = calendario.NextHolidayDate(6, fecha_Vencto);
                    string _FechaFestivoResutl = "";
                    _FechaFestivoResutl = "<Data>\n";
                    _FechaFestivoResutl += "<Vencimiento MoFechaVcto='" + fecha_Vencto.ToString("dd-MM-yyyy") + "'/>\n"; ;
                    _FechaFestivoResutl += "</Data>";

                    return _FechaFestivoResutl;
                }
            
                YieldList CurvaList = new YieldList();
                CurvaList.SetPrincingLoading = (enumSetPrincingLoading)setPrecios;
                CurvaList.Load(YieldNameDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);
                CurvaList.Load(YieldNameFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);

                AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura _Estructura = new AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura(CurvaList, strikes_delta_flag, Fijaciones, estructura, payoff, fecha_Val, fecha_Vencto, FechaSetDePrecios, paridad, nocional, Strike_Delta_Values_XML, compra_venta, spot, spotSmile, puntos_fwd_costo, YieldNameDom, YieldNameFor, (enumSetPrincingLoading)setPrecios);

                string _ReturnValue = "<RiskReversal>\n";

                _ReturnValue += _Estructura.RiskReversal(vanilla_asiatica, BsSpot_BsFwd);

                _ReturnValue += "</RiskReversal>";
                return _ReturnValue;
            }
            catch { return ""; };
        }

        [WebMethod]
        public string ForwardAmericano(string value)
        {
            try
            {
                Calendars calendario = new Calendars();
                calendario.Load();
                XDocument _xmlValue = XDocument.Parse(value);
                DateTime fecha_Vencto = DateTime.Parse(_xmlValue.Element("Pricing").Element("Tickets").Element("Ticket").Attribute("ExpiryDate").Value);

                if (!calendario.IsBussineDay(6, fecha_Vencto))
                {
                    fecha_Vencto = calendario.NextHolidayDate(6, fecha_Vencto);
                    string _FechaFestivoResutl = "";
                    _FechaFestivoResutl = "<Data>\n";
                    _FechaFestivoResutl += "<Opcion>\n";
                    _FechaFestivoResutl += "<detContrato>\n";
                    _FechaFestivoResutl += "<Vencimiento MoFechaVcto='" + fecha_Vencto.ToString("dd-MM-yyyy") + "'/>\n";
                    _FechaFestivoResutl += "</detContrato>\n";
                    _FechaFestivoResutl += "</Opcion>";
                    _FechaFestivoResutl += "</Data>";

                    return _FechaFestivoResutl;
                }
            }
            catch { }

            return string.Format(
                                  "<Data>{0}</Data>",
                                  AdminOpcionesTool.ValorizadorCartera.ValuatorOptions.Valuator(value)
                                );
        }

        [WebMethod]
        public string TestForwardAmericano()
        {
            string xml = "<Pricing><Tickets><Ticket OperationNumber='0' StructureID='0' Notional='10000' Strike='500,00' ExpiryDate='07-08-2023' Position='V' Exercize='A' Gennus='PUT' StructureType='8' MTM='78750' /></Tickets><Data SetPrice='0' ValuatorDate='04-07-2013 0:00:00' IsGreek='N' ><Spot Value='507,875' /><Yields Value='CurvaSwapCLP,CurvaSwapUSDLocal'><Foreign YieldName='CurvaSwapUSDLocal' Type='FOREIGN'></Foreign><Domestic YieldName='CurvaSwapCLP' Type='DOMESTIC'></Domestic></Yields></Data></Pricing>";
            return string.Format(
                                  "<Data>{0}</Data>",
                                  AdminOpcionesTool.ValorizadorCartera.ValuatorOptions.Valuator(xml)
                                );
        }

        [WebMethod]
        public double Solver_RiskReversal(double price_objective, string Ceiling_Floor, string strikes_delta_flag, string vanilla_asiatica, string BsSpot_BsFwd, string Fijaciones, string estructura, string payoff, double puntos_fwd_costo, DateTime fecha_Val, DateTime fecha_Vencto, DateTime FechaSetDePrecios, string paridad, string compra_venta, double nocional, double spot, double spotsmile, string Strike_Delta_Values_XML, string YieldNameDom, string YieldNameFor, int setPrecios)
        {
            double _Variador;
            try
            {
                YieldList CurvaList = new YieldList();
                CurvaList.SetPrincingLoading = (enumSetPrincingLoading)setPrecios;
                CurvaList.Load(YieldNameDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);
                CurvaList.Load(YieldNameFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);

                AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura _Estructura = new AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura(CurvaList, strikes_delta_flag, Fijaciones, estructura, payoff, fecha_Val, fecha_Vencto, FechaSetDePrecios, paridad, nocional, Strike_Delta_Values_XML, compra_venta, spot, spotsmile, puntos_fwd_costo, YieldNameDom, YieldNameFor, (enumSetPrincingLoading)setPrecios);

                if (Ceiling_Floor.Equals("Ceiling"))
                {
                    _Variador = _Estructura.find_strikeCeiling_RiskReversal(price_objective, BsSpot_BsFwd);
                }
                else
                {
                    _Variador = _Estructura.find_strikeFloor_RiskReversal(price_objective, BsSpot_BsFwd);
                }
            }
            catch
            {
                return double.NaN;
            }

            return _Variador;
        }

        [WebMethod]
        public string ForwardGananciaAcotada(string strikes_delta_flag, string vanilla_asiatica, string BsSpot_BsFwd, string Fijaciones, string estructura, string payoff, double puntosCosto, DateTime fecha_Val, DateTime fecha_Vencto, DateTime FechaSetDePrecios, string call_put, string paridad, string compra_venta, double nocional, double spot, double spotsmile, string Strike_Delta_Values_XML, string YieldNameDom, string YieldNameFor, int setPrecios)
        {
            try
            {
                Calendars calendario = new Calendars();
                calendario.Load();

                if (!calendario.IsBussineDay(6, fecha_Vencto))
                {
                    fecha_Vencto = calendario.NextHolidayDate(6, fecha_Vencto);
                    string _FechaFestivoResutl = "";
                    _FechaFestivoResutl = "<Data>\n";
                    _FechaFestivoResutl += "<Vencimiento MoFechaVcto='" + fecha_Vencto.ToString("dd-MM-yyyy") + "'/>\n"; ;
                    _FechaFestivoResutl += "</Data>";

                    return _FechaFestivoResutl;
                }

                YieldList CurvaList = new YieldList();
                CurvaList.SetPrincingLoading = (enumSetPrincingLoading)setPrecios;
                CurvaList.Load(YieldNameDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);
                CurvaList.Load(YieldNameFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);

                AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura _Estructura = new AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura(CurvaList, strikes_delta_flag, Fijaciones, estructura, payoff, fecha_Val, fecha_Vencto, FechaSetDePrecios, paridad, nocional, Strike_Delta_Values_XML, compra_venta, spot, spotsmile, puntosCosto, YieldNameDom, YieldNameFor, (enumSetPrincingLoading)setPrecios);

                string _ReturnValue = "<ForwardGananciaAcotada>\n";

                _ReturnValue += _Estructura.FwdGananciaAcotada(vanilla_asiatica, BsSpot_BsFwd);

                _ReturnValue += "</ForwardGananciaAcotada>";
                return _ReturnValue;
            }
            catch { return ""; };
        }

        [WebMethod]
        public string ForwardPerdidaAcotada(string strikes_delta_flag, string vanilla_asiatica, string BsSpot_BsFwd, string Fijaciones, string estructura, string payoff, double puntos_fwd_costo, DateTime fecha_Val, DateTime fecha_Vencto, DateTime FechaSetDePrecios, string call_put, string paridad, string compra_venta, double nocional, double spot, double spotsmile, string Strike_Delta_Values_XML, string YieldNameDom, string YieldNameFor, int setPrecios)
        {
            try
            {
                Calendars calendario = new Calendars();
                calendario.Load();

                if (!calendario.IsBussineDay(6, fecha_Vencto))
                {
                    fecha_Vencto = calendario.NextHolidayDate(6, fecha_Vencto);
                    string _FechaFestivoResutl = "";
                    _FechaFestivoResutl = "<Data>\n";
                    _FechaFestivoResutl += "<Vencimiento MoFechaVcto='" + fecha_Vencto.ToString("dd-MM-yyyy") + "'/>\n"; ;
                    _FechaFestivoResutl += "</Data>";

                    return _FechaFestivoResutl;
                }

                YieldList CurvaList = new YieldList();
                CurvaList.SetPrincingLoading = (enumSetPrincingLoading)setPrecios;
                CurvaList.Load(YieldNameDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);
                CurvaList.Load(YieldNameFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);


                AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura _Estructura = new AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura(CurvaList, strikes_delta_flag, Fijaciones, estructura, payoff, fecha_Val, fecha_Vencto, FechaSetDePrecios, paridad, nocional, Strike_Delta_Values_XML, compra_venta, spot, spotsmile, puntos_fwd_costo, YieldNameDom, YieldNameFor, (enumSetPrincingLoading)setPrecios);

                string _ReturnValue = "<ForwardPerdidaAcotada>\n";

                _ReturnValue += _Estructura.FwdPerdidaAcotada(vanilla_asiatica, BsSpot_BsFwd);

                _ReturnValue += "</ForwardPerdidaAcotada>";
                return _ReturnValue;
            }
            catch { return ""; };
        }

        [WebMethod]
        public double Solver_FwdAcotado(double price_objective, string Puntos_Cota, string Perdida_Ganancia, string strikes_delta_flag, string vanilla_asiatica, string BsSpot_BsFwd, string Fijaciones, string estructura, string payoff, double puntos_fwd_costo, DateTime fecha_Val, DateTime fecha_Vencto, DateTime FechaSetDePrecios, string call_put, string paridad, string compra_venta, double nocional, double spot, double spotsmile, string Strike_Delta_Values_XML, string YieldNameDom, string YieldNameFor, double spotFwd, double putnosFwd, int setPrecios)
        {
            double _Variador;
            try
            {
                YieldList CurvaList = new YieldList();
                CurvaList.SetPrincingLoading = (enumSetPrincingLoading)setPrecios;
                CurvaList.Load(YieldNameDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);
                CurvaList.Load(YieldNameFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);

                AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura _Estructura = new AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura(CurvaList, strikes_delta_flag, Fijaciones, estructura, payoff, fecha_Val, fecha_Vencto, FechaSetDePrecios, paridad, nocional, Strike_Delta_Values_XML, compra_venta, spot, spotsmile, puntos_fwd_costo, YieldNameDom, YieldNameFor, (enumSetPrincingLoading)setPrecios);

                if (Puntos_Cota.Equals("Cota"))
                {
                    _Variador = _Estructura.find_strikeVanilla_price_ForwardAcotado(price_objective, Perdida_Ganancia, BsSpot_BsFwd);
                }
                else
                {
                    _Variador = _Estructura.find_strikeForward_price_ForwardAcotado(price_objective, Perdida_Ganancia, BsSpot_BsFwd);

                }


            }
            catch
            {
                return double.NaN;
            }

            return _Variador;

        }

        [WebMethod]
        public string Solver_ForwardAmericano(string value)
        {
            return string.Format(
                                  "<Data>{0}</Data>",
                                  AdminOpcionesTool.ValorizadorCartera.ValuatorOptions.Solver(value)
                                );
        }

        //PRD_7274
        [WebMethod]
        /// <summary>
        /// Retorna XML <StripAsiatico> con la Estructura
        /// </summary>
        public string StripAsiatico(string strikes_delta_flag, string vanilla_asiatica, string BsSpot_BsFwd, string Fijaciones, string estructura, string payoff, double puntosCosto, DateTime fecha_Val, DateTime fecha_Vencto, DateTime FechaSetDePrecios, string call_put, string paridad, string compra_venta, double nocional, double spot, double spotsmile, string Strikes_Delta_XML, string YieldNameDom, string YieldNameFor, int enumSetPricing, string xmlStrip)
        {
            try
            {
                Calendars calendario = new Calendars();
                calendario.Load();

                if (!calendario.IsBussineDay(6, fecha_Vencto))
                {
                    fecha_Vencto = calendario.NextHolidayDate(6, fecha_Vencto);
                    string _FechaFestivoResutl = "";
                    _FechaFestivoResutl = "<Data>\n";
                    _FechaFestivoResutl += "<Vencimiento MoFechaVcto='" + fecha_Vencto.ToString("dd-MM-yyyy") + "'/>\n"; ;
                    _FechaFestivoResutl += "</Data>";

                    return _FechaFestivoResutl;
                }

                YieldList CurvaList = new YieldList();
                CurvaList.SetPrincingLoading = (enumSetPrincingLoading)enumSetPricing;
                CurvaList.Load(YieldNameDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);
                CurvaList.Load(YieldNameFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);

                AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura _Estructura =
                    new AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura(CurvaList, strikes_delta_flag, Fijaciones, estructura, payoff, fecha_Val, fecha_Vencto, FechaSetDePrecios, paridad, nocional, Strikes_Delta_XML,
                      compra_venta, spot, spotsmile, puntosCosto, YieldNameDom, YieldNameFor, (enumSetPrincingLoading)enumSetPricing, xmlStrip);

                string _ReturnValue = "<StripAsiatico>\n";

                //_ReturnValue += _Estructura.ForwardSintetico(vanilla_asiatica, BsSpot_BsFwd);

                _ReturnValue += _Estructura.StripAsiatico(vanilla_asiatica, BsSpot_BsFwd, call_put, xmlStrip);

                _ReturnValue += "</StripAsiatico>";

                return _ReturnValue;
            }
            catch { return ""; };
        }

        //PRD_7274
        [WebMethod]
        public double Solver_StripAsiatico(double MtM_objetivo, string strikes_delta_flag, string vanilla_asiatica, string BsSpot_BsFwd, string Fijaciones, string estructura, string payoff, double puntosCosto, DateTime fecha_Val, DateTime fecha_Vencto, DateTime FechaSetDePrecios, string call_put, string paridad, string compra_venta, double nocional, double spot, double spotsmile, string Strikes_Delta_XML, string YieldNameDom, string YieldNameFor, int enumSetPricing, string xmlStrip)
        {
            AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura _Estructura;
            try
            {
                YieldList CurvaList = new YieldList();
                CurvaList.SetPrincingLoading = (enumSetPrincingLoading)enumSetPricing;
                CurvaList.Load(YieldNameDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);
                CurvaList.Load(YieldNameFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);

                _Estructura = new AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura(
                    CurvaList, strikes_delta_flag, Fijaciones, estructura, payoff, fecha_Val, fecha_Vencto, FechaSetDePrecios, paridad, nocional, Strikes_Delta_XML,
                      compra_venta, spot, spotsmile, puntosCosto, YieldNameDom, YieldNameFor, (enumSetPrincingLoading)enumSetPricing, xmlStrip);

                //de esto solo me interesa la grabación del this.__xmlStrip
                string _ReturnValue = _Estructura.StripAsiatico(vanilla_asiatica, BsSpot_BsFwd, call_put, xmlStrip);
            }
            catch { return 0.0; };

            return _Estructura.find_StripAsiatico(MtM_objetivo, vanilla_asiatica, BsSpot_BsFwd, call_put);

        }

        //PRD_Call/Put Spread
        [WebMethod]
        public string CallPutSpread(string strikes_delta_flag, string vanilla_asiatica, string BsSpot_BsFwd, string Fijaciones, string estructura, string payoff, double puntos_fwd_costo, DateTime fecha_Val, DateTime fecha_Vencto, DateTime FechaSetDePrecios, string call_put, string paridad, string compra_venta, double nocional, double spot, double spotSmile, string Strike_Delta_Values_XML, string YieldNameDom, string YieldNameFor, int setPrecios, string TipoEstructura)
        {
           try
            {
                Calendars calendario = new Calendars();
                calendario.Load();

                if (!calendario.IsBussineDay(6, fecha_Vencto))
                {
                    fecha_Vencto = calendario.NextHolidayDate(6, fecha_Vencto);
                    string _FechaFestivoResutl = "";
                    _FechaFestivoResutl = "<Data>\n";
                    _FechaFestivoResutl += "<Vencimiento MoFechaVcto='" + fecha_Vencto.ToString("dd-MM-yyyy") + "'/>\n"; ;
                    _FechaFestivoResutl += "</Data>";

                    return _FechaFestivoResutl;
                }


                YieldList CurvaList = new YieldList();
                CurvaList.SetPrincingLoading = (enumSetPrincingLoading)setPrecios;
                CurvaList.Load(YieldNameDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);
                CurvaList.Load(YieldNameFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);

                AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura _Estructura = new AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura(CurvaList, strikes_delta_flag, Fijaciones, estructura, payoff, fecha_Val, fecha_Vencto, FechaSetDePrecios, paridad, nocional, Strike_Delta_Values_XML, compra_venta, spot, spotSmile, puntos_fwd_costo, YieldNameDom, YieldNameFor, (enumSetPrincingLoading)setPrecios);
               
                string _ReturnValue = "<CallPutSpread>\n";
                //Producto indicara la estructura (11 -> Call Spread y 12 -> Put Spread)
                _ReturnValue += _Estructura.CallPutSpread(vanilla_asiatica, BsSpot_BsFwd, TipoEstructura);

                _ReturnValue += "</CallPutSpread>";
                return _ReturnValue;
            }
            catch { return ""; };
        }

        //PRD_Call/Put Spread
        [WebMethod]
        public double Solver_CallPutSpread(double price_objective, string Ceiling_Floor, string strikes_delta_flag, string vanilla_asiatica, string BsSpot_BsFwd, string Fijaciones, string estructura, string payoff, double puntos_fwd_costo, DateTime fecha_Val, DateTime fecha_Vencto, DateTime FechaSetDePrecios, string paridad, string compra_venta, double nocional, double spot, double spotsmile, string Strike_Delta_Values_XML, string YieldNameDom, string YieldNameFor, int setPrecios, string TipoEstruct)
        {
            double _Variador;
            try
            {
                YieldList CurvaList = new YieldList();
                CurvaList.SetPrincingLoading = (enumSetPrincingLoading)setPrecios;
                CurvaList.Load(YieldNameDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);
                CurvaList.Load(YieldNameFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);


                AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura _Estructura = new AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura(CurvaList, strikes_delta_flag, Fijaciones, estructura, payoff, fecha_Val, fecha_Vencto, FechaSetDePrecios, paridad, nocional, Strike_Delta_Values_XML, compra_venta, spot, spotsmile, puntos_fwd_costo, YieldNameDom, YieldNameFor, (enumSetPrincingLoading)setPrecios);

                if (Ceiling_Floor.Equals("Ceiling"))
                {
                    _Variador = _Estructura.find_strikeCeiling_CallPutSpread(price_objective, BsSpot_BsFwd, TipoEstruct);
                }
                else
                {
                    _Variador = _Estructura.find_strikeFloor_CallPutSpread(price_objective, BsSpot_BsFwd, TipoEstruct);

                }
            }
            catch
            {
                return double.NaN;
            }

            return _Variador;

        }

        //PRD_12567 Forward Asiatico Entrada Salida
        [WebMethod]
        public string ForwardAsiaticoEntradaSalida(string strikes_delta_flag, string vanilla_asiatica, string BsSpot_BsFwd, string Fijaciones, string estructura, string payoff, double puntosCosto, DateTime fecha_Val, DateTime fecha_Vencto, DateTime FechaSetDePrecios, string call_put, string paridad, string compra_venta, double nocional, double spot, double spotsmile, string Strikes_Delta_XML, string YieldNameDom, string YieldNameFor, int enumSetPricing)
        {
            try
            {
                AdminOpcionesTool.Debug d = new AdminOpcionesTool.Debug("ForwardAsiaticoEntradaSalida");
                d.Log(estructura); 
                d.Log(Fijaciones);                
                d.LogClose();
            }
            catch (Exception e)
            {
            }

            try
            {
                Calendars calendario = new Calendars();
                calendario.Load();

                if (!calendario.IsBussineDay(6, fecha_Vencto))
                {
                    fecha_Vencto = calendario.NextHolidayDate(6, fecha_Vencto);
                    string _FechaFestivoResutl = "";
                    _FechaFestivoResutl = "<Data>\n";
                    _FechaFestivoResutl += "<Vencimiento MoFechaVcto='" + fecha_Vencto.ToString("dd-MM-yyyy") + "'/>\n"; ;
                    _FechaFestivoResutl += "</Data>";

                    return _FechaFestivoResutl;
                }

                //OJO Aqui se deben cargar todas las curvas
                YieldList CurvaList = new YieldList();
                CurvaList.SetPrincingLoading = (enumSetPrincingLoading)enumSetPricing;
                CurvaList.Load(YieldNameDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);
                CurvaList.Load(YieldNameFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);
                CurvaList.Load("CurvaFwCLP", enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);
                CurvaList.Load("CurvaFwUSD", enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);

                AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura _Estructura = new AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura(CurvaList, strikes_delta_flag, Fijaciones, estructura, payoff, fecha_Val, fecha_Vencto, FechaSetDePrecios, paridad, nocional, Strikes_Delta_XML,
                      compra_venta, spot, spotsmile, puntosCosto, YieldNameDom, YieldNameFor, (enumSetPrincingLoading)enumSetPricing);

                //SOBRA
                //CurvasDomFor = "";
                //CurvasDomFor += CurvaList.GetYield("CurvaFwCLP", 0, FechaSetDePrecios);
                //CurvasDomFor += CurvaList.GetYield("CurvaFwUSD", 0, FechaSetDePrecios);

                XElement __CurvasMoneda = new XElement("CurvasMoneda");

                //string a = TagXML_CurvaDesdeYieldList("CurvaSwapCLP", CurvaList, FechaSetDePrecios);
                //string b = TagXML_CurvaDesdeYieldList("CurvaSwapUSDLocal", CurvaList, FechaSetDePrecios);
                //string c = TagXML_CurvaDesdeYieldList("CurvaFwCLP", CurvaList, FechaSetDePrecios);
                //string d = TagXML_CurvaDesdeYieldList("CurvaFwUSD", CurvaList, FechaSetDePrecios);
                
                //CurvasDomFor = "<CurvasMoneda>\n" + a + b + c + d + "</CurvasMoneda>";

                string _ReturnValue = "<ForwardSintetico>\n";

                _ReturnValue += _Estructura.ForwardAsiaticoEntradaSalida(vanilla_asiatica, BsSpot_BsFwd);

                _ReturnValue += "</ForwardSintetico>";

                return _ReturnValue;

            }
            catch { return ""; };
        }

        //PRD_20559 Call Spread Doble
        /// <summary>
        /// Servicio para obtener estructura de Call Spread Doble.
        /// Implementación limitada a alcance de PRD_20559.
        /// </summary>
        /// <param name="strikes_delta_flag">Siempre "strikes", no se implementa "delta".</param>
        /// <param name="vanilla_asiatica">Siempre "Vanilla", no se implementa "Asiaticas".</param>
        /// <param name="BsSpot_BsFwd"></param>
        /// <param name="Fijaciones"></param>
        /// <param name="estructura"></param>
        /// <param name="payoff"></param>
        /// <param name="puntos_fwd_costo"></param>
        /// <param name="fecha_Val"></param>
        /// <param name="fecha_Vencto"></param>
        /// <param name="FechaSetDePrecios"></param>
        /// <param name="call_put"></param>
        /// <param name="paridad"></param>
        /// <param name="compra_venta"></param>
        /// <param name="nocional"></param>
        /// <param name="spot"></param>
        /// <param name="spotSmile"></param>
        /// <param name="Strike_Delta_Values_XML"></param>
        /// <param name="YieldNameDom"></param>
        /// <param name="YieldNameFor"></param>
        /// <param name="setPrecios"></param>
        /// <returns></returns>
        [WebMethod]
        public string CallSpreadDoble(string strikes_delta_flag, string vanilla_asiatica, string BsSpot_BsFwd, string Fijaciones, string estructura, string payoff, double puntos_fwd_costo, DateTime fecha_Val, DateTime fecha_Vencto, DateTime FechaSetDePrecios, string call_put, string paridad, string compra_venta, double nocional, double spot, double spotSmile, string Strike_Delta_Values_XML, string YieldNameDom, string YieldNameFor, int setPrecios)
        {
            try
            {
                Calendars calendario = new Calendars();
                calendario.Load();

                if (!calendario.IsBussineDay(6, fecha_Vencto))
                {
                    fecha_Vencto = calendario.NextHolidayDate(6, fecha_Vencto);
                    string _FechaFestivoResutl = "";
                    _FechaFestivoResutl = "<Data>\n";
                    _FechaFestivoResutl += "<Vencimiento MoFechaVcto='" + fecha_Vencto.ToString("dd-MM-yyyy") + "'/>\n";
                    _FechaFestivoResutl += "</Data>";

                    return _FechaFestivoResutl;
                }

                YieldList CurvaList = new YieldList();
                CurvaList.SetPrincingLoading = (enumSetPrincingLoading)setPrecios;
                CurvaList.Load(YieldNameDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);
                CurvaList.Load(YieldNameFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);

                AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura _Estructura = new AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura(CurvaList, strikes_delta_flag, Fijaciones, estructura, payoff, fecha_Val, fecha_Vencto, FechaSetDePrecios, paridad, nocional, Strike_Delta_Values_XML, compra_venta, spot, spotSmile, puntos_fwd_costo, YieldNameDom, YieldNameFor, (enumSetPrincingLoading)setPrecios);

                string _ReturnValue = "<CallSpreadDoble>\n";
                _ReturnValue += _Estructura.CallSpreadDoble(BsSpot_BsFwd);
                _ReturnValue += "</CallSpreadDoble>";

                return _ReturnValue;
            }
            catch { return ""; }
        }

        //PRD_20559 Call Spread Doble
        [WebMethod]
        public double Solver_CallSpreadDoble(double price_objective, string Ceiling_Floor, string strikes_delta_flag, string vanilla_asiatica, string BsSpot_BsFwd, string Fijaciones, string estructura, string payoff, double puntos_fwd_costo, DateTime fecha_Val, DateTime fecha_Vencto, DateTime FechaSetDePrecios, string paridad, string compra_venta, double nocional, double spot, double spotsmile, string Strike_Delta_Values_XML, string YieldNameDom, string YieldNameFor, int setPrecios, string TipoEstruct)
        {
            double _Variador;
            try
            {
                YieldList CurvaList = new YieldList();
                CurvaList.SetPrincingLoading = (enumSetPrincingLoading)setPrecios;
                CurvaList.Load(YieldNameDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);
                CurvaList.Load(YieldNameFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);

                string revisar = Strike_Delta_Values_XML;
                AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura _Estructura = new AdminOpcionesTool.Opciones.Payoffs.Estructuras.Estructura(CurvaList, strikes_delta_flag, Fijaciones, estructura, payoff, fecha_Val, fecha_Vencto, FechaSetDePrecios, paridad, nocional, Strike_Delta_Values_XML, compra_venta, spot, spotsmile, puntos_fwd_costo, YieldNameDom, YieldNameFor, (enumSetPrincingLoading)setPrecios);

                _Variador = _Estructura.find_strike_CallSpreadDoble(price_objective, BsSpot_BsFwd, TipoEstruct, Ceiling_Floor);
            }
            catch
            {
                return double.NaN;
            }

            return _Variador;
        }

        /// <summary>
        /// Genera tag XML con información de curva.
        /// OJO: no veo set de precios involucrado (Riesgo o Costo).
        /// </summary>
        /// <param name="nombre_curva">Nombre de la curva</param>
        /// <param name="yl">Estructura de lista de Yield con los datos</param>
        /// <param name="FechaSetDePrecios">Fecha del Set de Precios, en general es igual a la fecha de proceso.</param>
        /// <returns></returns>
        private string TagXML_CurvaDesdeYieldList(string nombre_curva, YieldList yl, DateTime FechaSetDePrecios)
        {
            XDocument ___CurvaFwCLP = new XDocument(XDocument.Parse(yl.GetYield(nombre_curva, 0, FechaSetDePrecios)));

            string s_Curva = "<"+nombre_curva+">\n";

            foreach (XElement xe in ___CurvaFwCLP.Descendants("Point"))
            {
                //REVISAR, hay otra parte del cdigo que agrega elementos al xml de curva
                s_Curva += string.Format(
                                            "<itemCurva FechaGeneracion='{0}' CodigoCurva='{1}' " +
                                            "Dias='{2}' ValorBid='{3}' ValorAsk='{4}' />\n"
                                            ,FechaSetDePrecios
                                            ,nombre_curva
                                            ,xe.Attribute("Tenor").Value.ToString()
                                            ,xe.Attribute("Rate").Value.ToString()
                                            ,xe.Attribute("Rate").Value.ToString()
                                            );
            }

            s_Curva += "</"+nombre_curva+">\n";

            return s_Curva;
        }

        /// <summary>
        /// NO UTILIZAR, NO IMPLEMENTADA.
        /// </summary>
        [WebMethod]
        public double Solver_ForwardAsiaticoEntradaSalida(double price_objective, string strikes_delta_flag, string vanilla_asiatica, string BsSpot_BsFwd, string Fijaciones, string estructura, string payoff, double puntos_fwd_costo, DateTime fecha_Val, DateTime fecha_Vencto, DateTime FechaSetDePrecios, string paridad, string compra_venta, double nocional, double spot, string Strike_Delta_Values_XML, string YieldNameDom, string YieldNameFor, int setPrecios)
        {
            double _Variador;
            Vanilla _Vanila;
            AdminOpcionesTool.Opciones.Payoffs.Asiatica _Asiatica;

            try
            {
                YieldList CurvaList = new YieldList();
                CurvaList.SetPrincingLoading = (enumSetPrincingLoading)setPrecios;
                CurvaList.Load(YieldNameDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);
                CurvaList.Load(YieldNameFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);

                if (payoff.Equals("Vanilla"))
                {
                    //_Vanila = new Vanilla(CurvaList, paridad, "c", compra_venta, nocional, spot, puntos_fwd_costo, putnosFwd + spotFwd, fecha_Val, fecha_Vencto, YieldNameDom, YieldNameFor, (enumSetPrincingLoading)setPrecios, 0);
                    _Vanila = new Vanilla(CurvaList, paridad, "c", compra_venta, nocional, spot, puntos_fwd_costo, spot, fecha_Val, fecha_Vencto, FechaSetDePrecios, YieldNameDom, YieldNameFor, (enumSetPrincingLoading)setPrecios, 0, BsSpot_BsFwd);

                    _Variador = _Vanila.find_strike_price_ForwardSintetico(price_objective, BsSpot_BsFwd);
                }
                else
                {
                    XDocument xdocFixing = new XDocument(XDocument.Parse(Fijaciones));
                    var elements = from elementItem in xdocFixing.Descendants("FixingValues")
                                   select new StructFixingData
                                   {
                                       Fecha = DateTime.Parse(elementItem.Attribute("Fecha").Value.ToString()),
                                       Valor = double.Parse(elementItem.Attribute("Valor").Value.ToString()),
                                       Peso = double.Parse(elementItem.Attribute("Peso").Value.ToString()),
                                       Volatilidad = double.Parse(elementItem.Attribute("Volatilidad").Value.ToString()),
                                       Plazo = int.Parse(elementItem.Attribute("Plazo").Value.ToString())

                                   };

                    List<StructFixingData> fixingdataList = new List<StructFixingData>(elements.ToList<StructFixingData>());

                    var fixingDateVar = from itemfixingdate in fixingdataList
                                        select itemfixingdate.Fecha;

                    var fixingValorVar = from itemfixingdate in fixingdataList
                                         select itemfixingdate.Valor;

                    var fixingPesosVar = from itemfixingdate in fixingdataList
                                         select itemfixingdate.Peso;

                    var fixingVolatilidadVar = from itemfixingdate in fixingdataList
                                               select itemfixingdate.Volatilidad;

                    var fixingPlazosVar = from itemfixingdate in fixingdataList
                                          select itemfixingdate.Plazo;

                    List<DateTime> fechas_fijacion = new List<DateTime>();
                    List<double> pesos_fijacion = new List<double>();
                    List<double> fijaciones = new List<double>();
                    List<double> volatilidades = new List<double>();
                    List<int> plazos_fijaciones = new List<int>();

                    fechas_fijacion = fixingDateVar.ToList<DateTime>();
                    fijaciones = fixingValorVar.ToList<double>();
                    pesos_fijacion = fixingPesosVar.ToList<double>();
                    volatilidades = fixingVolatilidadVar.ToList<double>();
                    plazos_fijaciones = fixingPlazosVar.ToList<int>();


                    _Asiatica = new AdminOpcionesTool.Opciones.Payoffs.Asiatica(CurvaList, paridad, "c", compra_venta, nocional, spot, spot, fecha_Val, fecha_Vencto, FechaSetDePrecios, YieldNameDom, YieldNameFor, (enumSetPrincingLoading)setPrecios, fechas_fijacion, pesos_fijacion, fijaciones, volatilidades, plazos_fijaciones, 0);
                    _Variador = _Asiatica.find_strike_ForwardAsiatico(price_objective);
                }
            }
            catch
            {
                return double.NaN;
            }

            return _Variador;
        }
    }
}
