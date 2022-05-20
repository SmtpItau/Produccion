using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using cData.Opciones;
using System.Xml.Linq;
using AdminOpciones.Web.Struct;
using cFinancialTools.Yield;
using AdminOpcionesTool.Opciones.Functions;
using cFinancialTools.BussineDate;
using AdminOpcionesTool.Opciones.Fijaciones;

namespace AdminOpciones.Web.WebService.OpcionesFX.Asiatica
{
    /// <summary>
    /// Descripción breve de SrvAsiaticas
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class SrvAsiaticas : System.Web.Services.WebService
    {

        //[WebMethod]
        //public double arithmetic_asian_fx_momentos(string paridad, string call_put_flag, string compra_venta, double nominal, double spot, double strike, DateTime fecha_val, DateTime fecha_venc, string YieldNameCurvaDom, string YieldNameCurvaFor, int flagSmile, string stringFixing)
        //{
        //    XDocument xdocFixing = new XDocument(XDocument.Parse(stringFixing));
        //    var elements = from elementItem in xdocFixing.Descendants("FixingValues")
        //                   select new StructFixingData
        //                   {
        //                       Fecha = DateTime.Parse(elementItem.Attribute("Fecha").Value.ToString()),
        //                       Valor = double.Parse(elementItem.Attribute("Valor").Value.ToString()),
        //                       Peso = double.Parse(elementItem.Attribute("Peso").Value.ToString()),
        //                       Volatilidad = double.Parse(elementItem.Attribute("Volatilidad").Value.ToString())

        //                   };

        //    List<StructFixingData> fixingdataList = new List<StructFixingData>(elements.ToList<StructFixingData>());

        //    var fixingDateVar = from itemfixingdate in fixingdataList
        //                        select itemfixingdate.Fecha;

        //    var fixingValorVar = from itemfixingdate in fixingdataList
        //                         select itemfixingdate.Valor;

        //    var fixingPesosVar = from itemfixingdate in fixingdataList
        //                         select itemfixingdate.Peso;
            
        //    List<DateTime> fechas_fijacion = new List<DateTime>();
        //    List<double> pesos_fijacion = new List<double>();
        //    List<double> fijaciones = new List<double>();

        //    fechas_fijacion = fixingDateVar.ToList<DateTime>();
        //    fijaciones = fixingValorVar.ToList<double>();
        //    pesos_fijacion = fixingPesosVar.ToList<double>();
            
        //    //fechas_fijacion = FixingData.getFechaFijacion();            
        //    //pesos_fijacion = FixingData.getPesosFijacion();
        //    //fijaciones = FixingData.getFijaciones();

        //    Fixing _Fixing = new Fixing();
        //    _Fixing.Load(paridad, call_put_flag, compra_venta, nominal, spot, strike, fecha_val, fecha_venc, flagSmile, YieldNameCurvaDom, YieldNameCurvaFor, fechas_fijacion, pesos_fijacion, fijaciones);           


        //    return _Fixing.arithmetic_asian_fx_momentos();
            
        //}

        //[WebMethod]
        //public string getGriegas(string paridad, string call_put_flag, string compra_venta, double nominal, double spot, double strike, DateTime fecha_val, int plazo_dias, string YieldNameCurvaDom, string YieldNameCurvaFor, int flagSmile)
        //{
        //    try
        //    {
        //        List<DateTime> fechas_fijacion = new List<DateTime>();
        //        List<double> pesos_fijacion = new List<double>();
        //        List<double> fijaciones = new List<double>();

        //        fechas_fijacion = FixingData.getFechaFijacion();
        //        pesos_fijacion = FixingData.getPesosFijacion();
        //        fijaciones = FixingData.getFijaciones();

        //        Fixing _Fixing = new Fixing();
        //        _Fixing.Load(paridad, call_put_flag, compra_venta, nominal, spot, strike, fecha_val, flagSmile, YieldNameCurvaDom, YieldNameCurvaFor, fechas_fijacion, pesos_fijacion, fijaciones);

        //        return _Fixing.getGriegas();
        //    }
        //    catch {return ""; };
        //}


        //[WebMethod]
        //public string getScaledGriegas(string paridad, string call_put_flag, string compra_venta, double nominal, double spot, double strike, DateTime fecha_val, int plazo_dias, string YieldNameCurvaDom, string YieldNameCurvaFor, int flagSmile, string stringFixing)
        //{
        //    try
        //    {
        //        DateTime fecha_venc = new DateTime();
        //        fecha_venc = fecha_val.AddDays(plazo_dias);

        //        XDocument xdocFixing = new XDocument(XDocument.Parse(stringFixing));
        //        var elements = from elementItem in xdocFixing.Descendants("FixingValues")
        //                       select new StructFixingData
        //                       {
        //                           Fecha = DateTime.Parse(elementItem.Attribute("Fecha").Value.ToString()),
        //                           Valor = double.Parse(elementItem.Attribute("Valor").Value.ToString()),
        //                           Peso = double.Parse(elementItem.Attribute("Peso").Value.ToString()),
        //                           Volatilidad = double.Parse(elementItem.Attribute("Volatilidad").Value.ToString())

        //                       };

        //        List<StructFixingData> fixingdataList = new List<StructFixingData>(elements.ToList<StructFixingData>());

        //        var fixingDateVar = from itemfixingdate in fixingdataList
        //                            select itemfixingdate.Fecha;

        //        var fixingValorVar = from itemfixingdate in fixingdataList
        //                             select itemfixingdate.Valor;

        //        var fixingPesosVar = from itemfixingdate in fixingdataList
        //                             select itemfixingdate.Peso;

        //        List<DateTime> fechas_fijacion = new List<DateTime>();
        //        List<double> pesos_fijacion = new List<double>();
        //        List<double> fijaciones = new List<double>();

        //        fechas_fijacion = fixingDateVar.ToList<DateTime>();
        //        fijaciones = fixingValorVar.ToList<double>();
        //        pesos_fijacion = fixingPesosVar.ToList<double>();
        //        //List<DateTime> fechas_fijacion = new List<DateTime>();
        //        //List<double> pesos_fijacion = new List<double>();
        //        //List<double> fijaciones = new List<double>();

        //        //fechas_fijacion = FixingData.getFechaFijacion();
        //        //pesos_fijacion = FixingData.getPesosFijacion();
        //        //fijaciones = FixingData.getFijaciones();

        //        Fixing _Fixing = new Fixing();
                            
        //        _Fixing.Load(paridad, call_put_flag, compra_venta, nominal, spot, strike, fecha_val, flagSmile, YieldNameCurvaDom, YieldNameCurvaFor, fechas_fijacion, pesos_fijacion, fijaciones);

        //        return _Fixing.GetScaledGriegas();
        //    }
        //    catch { return ""; };
        //}
        
        //[WebMethod]
        //public double getScaledarithmetic_asian_fx_momentos(string paridad, string call_put_flag, string compra_venta, double nominal, double spot, double strike, DateTime fecha_val, DateTime fecha_venc, string YieldNameCurvaDom, string YieldNameCurvaFor, int flagSmile, string stringFixing)
        //{
        //    try
        //    {


        //        XDocument xdocFixing = new XDocument(XDocument.Parse(stringFixing));
        //        var elements = from elementItem in xdocFixing.Descendants("FixingValues")
        //                       select new StructFixingData
        //                       {
        //                           Fecha = DateTime.Parse(elementItem.Attribute("Fecha").Value.ToString()),
        //                           Valor = double.Parse(elementItem.Attribute("Valor").Value.ToString()),
        //                           Peso = double.Parse(elementItem.Attribute("Peso").Value.ToString()),
        //                           Volatilidad = double.Parse(elementItem.Attribute("Volatilidad").Value.ToString())

        //                       };

        //        List<StructFixingData> fixingdataList = new List<StructFixingData>(elements.ToList<StructFixingData>());

        //        var fixingDateVar = from itemfixingdate in fixingdataList
        //                            select itemfixingdate.Fecha;

        //        var fixingValorVar = from itemfixingdate in fixingdataList
        //                             select itemfixingdate.Valor;

        //        var fixingPesosVar = from itemfixingdate in fixingdataList
        //                             select itemfixingdate.Peso;

        //        List<DateTime> fechas_fijacion = new List<DateTime>();
        //        List<double> pesos_fijacion = new List<double>();
        //        List<double> fijaciones = new List<double>();

        //        fechas_fijacion = fixingDateVar.ToList<DateTime>();
        //        fijaciones = fixingValorVar.ToList<double>();
        //        pesos_fijacion = fixingPesosVar.ToList<double>();

        //        //List<DateTime> fechas_fijacion = new List<DateTime>();
        //        //List<double> pesos_fijacion = new List<double>();
        //        //List<double> fijaciones = new List<double>();            

        //        //fechas_fijacion = FixingData.getFechaFijacion();
        //        //pesos_fijacion = FixingData.getPesosFijacion();
        //        //fijaciones = FixingData.getFijaciones();


        //        Fixing _Fixing = new Fixing();
        //        _Fixing.Load(paridad, call_put_flag, compra_venta, nominal, spot, strike, fecha_val, flagSmile, YieldNameCurvaDom, YieldNameCurvaFor, fechas_fijacion, pesos_fijacion, fijaciones);

        //        return _Fixing.GetScaledArithmetic_asian_fx_momentos();
        //    }
        //    catch { return 0; }
        //}

        [WebMethod]
        public string generateFixingTable(int Town, DateTime fechaInicio, DateTime fechaFin, DateTime fecha_val, DateTime FechaSetDePrecios, string intervalo, string TipoPeso, string paridad, string call_put_flag, string compra_venta, double nominal, double spot, double strike, string YieldNameCurvaDom, string YieldNameCurvaFor, int enumSetPrecios, int flagSmile)
        {
            try
            {                
                string String_FixingData = AdminOpcionesTool.Opciones.Fijaciones.FixingDataTools.getFixingData(Town, fecha_val, fechaInicio, fechaFin, FechaSetDePrecios, intervalo, TipoPeso, "DO", paridad, call_put_flag, compra_venta, nominal, spot, strike, YieldNameCurvaDom, YieldNameCurvaFor, (enumSetPrincingLoading)enumSetPrecios, 0, 0);

                return String_FixingData;
            }
            catch { return ""; };
        }

        [WebMethod]
        public string ReLoadFixingTable(DateTime fechaInicio, DateTime fechaFin, DateTime fecha_val, DateTime FechaSetDePrecios, string intervalo, string tipoPeso, string paridad, double spot, double strike, string YieldNameCurvaDom, string YieldNameCurvaFor, int enumSetPrecios, string FixingTableXML)
        {
            try
            {
                AdminOpcionesTool.Opciones.SmileNameSpace.Smile _Smile = new AdminOpcionesTool.Opciones.SmileNameSpace.Smile(FechaSetDePrecios, paridad, spot, YieldNameCurvaDom, YieldNameCurvaFor, 0);
                _Smile.Load((enumSetPrincingLoading)enumSetPrecios);

                YieldList CurvaList = new YieldList();
                CurvaList.SetPrincingLoading = (enumSetPrincingLoading)enumSetPrecios;
                CurvaList.Load(YieldNameCurvaDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);
                CurvaList.Load(YieldNameCurvaFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);

                Intervale _Frecuencia = Intervale.Custom;
                switch (intervalo)
                {
                    case "Diaria":
                        _Frecuencia = Intervale.Diaria;
                        break;
                    case "Semanal":
                        _Frecuencia = Intervale.Semanal;
                        break;
                    case "Mensual":
                        _Frecuencia = Intervale.Mensual;
                        break;
                    case "Anual":
                        _Frecuencia = Intervale.Anual;
                        break;
                    case "Custom":
                        _Frecuencia = Intervale.Custom;
                        break;
                }

                TipoPeso _tipoPeso = TipoPeso.Custom;
                switch (tipoPeso)
                {
                    case "Proporcional al Tiempo":
                        _tipoPeso = TipoPeso.ProporcionalAlTiempo;
                        break;
                    case "Equiproporcional":
                        _tipoPeso = TipoPeso.Equiproporcional;
                        break;
                    case "Custom":
                        _tipoPeso = TipoPeso.Custom;
                        break;
                }

                var FixingListVar = from itemFixing in XDocument.Parse(FixingTableXML).Descendants("FixingValues")
                                    select new AdminOpcionesTool.Opciones.Struct.StructFixingData
                                    {
                                        Fecha = DateTime.Parse(itemFixing.Attribute("Fecha").Value),
                                        Peso = double.Parse(itemFixing.Attribute("Peso").Value),
                                        Plazo = int.Parse(itemFixing.Attribute("Plazo").Value),
                                        Valor = double.Parse(itemFixing.Attribute("Valor").Value),
                                        Volatilidad = double.Parse(itemFixing.Attribute("Volatilidad").Value)
                                    };

                List<AdminOpcionesTool.Opciones.Struct.StructFixingData> FixingList = new List<AdminOpcionesTool.Opciones.Struct.StructFixingData>(FixingListVar.ToList<AdminOpcionesTool.Opciones.Struct.StructFixingData>());

                string String_FixingData = AdminOpcionesTool.Opciones.Fijaciones.FixingDataTools.ReloadFixing(CurvaList, _Smile, fechaInicio, fechaFin, fecha_val, FechaSetDePrecios, _Frecuencia, _tipoPeso, spot, strike, YieldNameCurvaDom, YieldNameCurvaFor, FixingList);

                return String_FixingData;
            }
            catch { return ""; };

        }


        [WebMethod]
        public string Opcion(string paridad, string call_put_flag, string compraVenta, double nominal, double spot, double spot_smile, double strike, DateTime fecha_val, DateTime fecha_Vencimiento, DateTime FechaSetDePrecios, string YieldNameCurvaDom, string YieldNameCurvaFor, int enumSetPricing, int numComponente_Estruc, string PayOff, string Estruct_Indiv, string fijacionesDataXML)
        {

            Calendars calendario = new Calendars();
            calendario.Load();

            if (!calendario.IsBussineDay(6, fecha_Vencimiento))
            {
                fecha_Vencimiento = calendario.NextHolidayDate(6, fecha_Vencimiento);
                string _FechaFestivoResutl = "";
                _FechaFestivoResutl = "<Data>\n";
                _FechaFestivoResutl += "<Vencimiento MoFechaVcto='" + fecha_Vencimiento.ToString("dd-MM-yyyy") + "'/>\n"; ;
                _FechaFestivoResutl += "</Data>";

                return _FechaFestivoResutl;
            }
            else
            {

                AdminOpcionesTool.Opciones.SmileNameSpace.Smile _Smile = new AdminOpcionesTool.Opciones.SmileNameSpace.Smile(FechaSetDePrecios, paridad, spot_smile, YieldNameCurvaDom, YieldNameCurvaFor, 0);
                _Smile.Load((enumSetPrincingLoading)enumSetPricing);

                YieldList CurvaList = new YieldList();
                CurvaList.SetPrincingLoading = (enumSetPrincingLoading)enumSetPricing;
                CurvaList.Load(YieldNameCurvaDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);
                CurvaList.Load(YieldNameCurvaFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);


                XDocument xdocFixing = new XDocument(XDocument.Parse(fijacionesDataXML));
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

                int i = 0;
                while (fixingdataList[i].Fecha.CompareTo(fecha_val) < 0)
                {
                    i++;
                }
                for (int j = i; j < fixingdataList.Count; j++)
                {
                    if (fixingdataList[j].Valor == 0 && fixingdataList[j].Volatilidad == 0)
                    {
                        fixingdataList[j].Valor = Function.Forward(fecha_val, fixingdataList[j].Fecha, FechaSetDePrecios, spot, YieldNameCurvaDom, YieldNameCurvaFor, CurvaList);
                        fixingdataList[j].Volatilidad = _Smile.interp_vol(fixingdataList[j].Fecha.Subtract(fecha_val).Days, strike, 1, 1);

                    }
                }

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




                AdminOpcionesTool.Opciones.Payoffs.Asiatica _Asiatica = new AdminOpcionesTool.Opciones.Payoffs.Asiatica(CurvaList, _Smile, paridad, call_put_flag, compraVenta, nominal, spot, strike, fecha_val, fecha_Vencimiento, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, (enumSetPrincingLoading)enumSetPricing, fechas_fijacion, pesos_fijacion, fijaciones, volatilidades, plazos_fijaciones);

                if (_Smile.Volas.Count == 0)
                {
                    return "<Data/>";
                }

                string ReturnValue = _Asiatica.Opcion(numComponente_Estruc, Estruct_Indiv);

                return ReturnValue;
            }

            //return ReturnValue;
        }


      //                                                 (string paridad, string call_put_flag, string compraVenta, double nominal, double spot, double strike, DateTime fecha_val, DateTime fecha_Vencimiento, string YieldNameCurvaDom, string YieldNameCurvaFor, int enumSetPricing, int numComponente_Estruc, string PayOff, string Estruct_Indiv, string fijacionesDataXML)  
        [WebMethod]
        public double Solver_CallPut_Asiatico(string BsSpot_BsFwd_flag, string paridad, string call_put_flag, string compraVenta, double nominal, double spot, double strike, double MtM_objetivo, DateTime fecha_val, DateTime FechaVenc, DateTime FechaSetDePrecios, string YieldNameCurvaDom, string YieldNameCurvaFor, string fijacionesDataXML, int enumSetPricing)
        {
            AdminOpcionesTool.Opciones.Payoffs.Asiatica _Asiatica;
            double _Strike;

            try
            {
                XDocument xdocFixing = new XDocument(XDocument.Parse(fijacionesDataXML));
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

                YieldList CurvaList = new YieldList();
                CurvaList.SetPrincingLoading = (enumSetPrincingLoading)enumSetPricing;
                CurvaList.Load(YieldNameCurvaDom, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);
                CurvaList.Load(YieldNameCurvaFor, enumGenerate.OriginalYield, enumInterpolateType.InterpolateLineal, enumSource.System, FechaSetDePrecios);


                _Asiatica = new AdminOpcionesTool.Opciones.Payoffs.Asiatica(CurvaList, paridad, call_put_flag, compraVenta, nominal, spot, strike, fecha_val, FechaVenc, FechaSetDePrecios, YieldNameCurvaDom, YieldNameCurvaFor, (enumSetPrincingLoading)enumSetPricing, fechas_fijacion, pesos_fijacion, fijaciones, volatilidades, plazos_fijaciones, 0);

                _Strike = _Asiatica.find_strike_CallPutAsiatico(MtM_objetivo);
                //_Strike = Math.Round(_Strike, 2);
            }
            catch
            {
                return double.NaN;
            }

            return _Strike;

        }

        [WebMethod]
        public string GenerateStripTable(int Town, DateTime fechaInicio, DateTime fechaFin, DateTime fecha_val, DateTime FechaSetDePrecios, string intervalo, string TipoPeso, string paridad, string call_put_flag, string compra_venta, double nominal, double spot, double strike, string YieldNameCurvaDom, string YieldNameCurvaFor, int enumSetPrecios, int flagSmile, int Strip)
        {
            try
            {

                string String_FixingData = AdminOpcionesTool.Opciones.Fijaciones.FixingDataTools.getFixingData(Town, fecha_val, fechaInicio, fechaFin, FechaSetDePrecios, intervalo, TipoPeso, "DO", paridad, call_put_flag, compra_venta, nominal, spot, strike, YieldNameCurvaDom, YieldNameCurvaFor, (enumSetPrincingLoading)enumSetPrecios, 0, Strip);

                return String_FixingData;
            }
            catch { return ""; };

        }
    }
}
