using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Xml;
//using Corpbanca.BloquesFrameworkNET.Comunes.Broker.Body;
using System.Data;
using cFinancialTools.BussineDate;
using System.Xml.Linq;

namespace AdminOpciones.Web.WebService.Leasing
{

    /// <summary>
    /// Servicio MDOEC1001: MesaDinero, OperacionesEstructuradas, Consulta 1003
    /// Proyecto Forward Americano Leasing stand-by por fusión.
    /// Servicios comentados, se custodia el código por solicitud de Cristian Guerra.
    /// </summary>
    //[WebService(Name = "MDOEA1001", Namespace = "http://cl.corpbanca.soa/MDOEA1001")]
    //[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1, Name = "MDOEA1001", Namespace = "http://cl.corpbanca.soa/MDOEA1001")]
    //[System.ComponentModel.ToolboxItem(false)]
    //[System.Web.Services.Protocols.SoapDocumentService(RoutingStyle = System.Web.Services.Protocols.SoapServiceRoutingStyle.RequestElement)]
    //public class MDOEA1001Service : System.Web.Services.WebService
    //{
    //    /// <summary>
    //    /// Implementación Broker de WS. Falta hacer que el parámetro Header sea obligatorio.
    //    /// </summary>
    //    /// <param name="Header"></param>
    //    /// <param name="?"></param>
    //    /// <returns></returns>
    //    [WebMethod(MessageName = "MDOEA1001")]
    //    [return: System.Xml.Serialization.XmlElement(ElementName = "return", Type = typeof(ReturnMDOEA1001))]
    //    public ReturnMDOEA1001 MDOEA1001([System.Xml.Serialization.XmlElement(IsNullable = false)]Header Header, string rutCliente, string numeroLeasing, string numeroGrupoBien, string numeroForward, string fechaEjercicio, string montoEjercicio)
    //    {
    //        string sTimeStamp = "Hora ejecución: " + System.DateTime.Now.ToString();

    //        sTimeStamp += "\n COD_CANAL: " + Header.COD_CANAL;
    //        sTimeStamp += "\n rutCliente: " + rutCliente;

    //        //Elementos obligatorios
    //        ReturnMDOEA1001 r = new ReturnMDOEA1001();
    //        Validaciones Val = new Validaciones();
    //        r.footer = new Footer("MDOEA1001", "0", "", sTimeStamp);

    //        //Elementos de Negocio
    //        //ESTOS VALORES SON LOS QUE DEBEN SER RESUELTOS POR LA LÓGICA DE NEGOCIO.

    //        DataTable _DataResults = new DataTable();
    //        DataTable _RelacionLeasing = new DataTable();
    //        DataTable _DatosGenerales = new DataTable();
    //        int Diasvec = 0;
    //        int Dias = 0;
    //        string _Resultado = "";
    //        string _ValidaRelacion = "";


    //        _DatosGenerales = cData.AccionesBD.Acciones.TraeDatosGeneralesOpciones();
    //        var FechaProceso =_DatosGenerales.AsEnumerable().FirstOrDefault().Field<DateTime>("fechaproc"); // Convert.ToDateTime("2013/11/08");


    //        if (numeroForward == "")
    //        {
    //            r.footer.errors[0].code = "1";
    //            r.footer.errors[0].description = "Debe ingresar N° Contrato";
    //            r.AgendamientoSDA = false;
    //            return r;               
    //        }

    //        if (montoEjercicio == "" || montoEjercicio == "0")
    //        {
    //            r.footer.errors[0].code = "2";
    //            r.footer.errors[0].description = "Debe ingresar Monto de anticipo";
    //            r.AgendamientoSDA = false;             
    //        }

    //        if (Val.ValidaNumeros(montoEjercicio).Equals(true))
    //        {
    //            r.footer.errors[0].code = "3";
    //            r.footer.errors[0].description = "Debe Ingresar solo Números en Monto de Anticipo";
    //            r.AgendamientoSDA = false;
    //            return r;                 
    //        }

    //        if (Val.ValidaNumeros(numeroForward).Equals(true))
    //        {
    //            r.footer.errors[0].code = "4";
    //            r.footer.errors[0].description = "Debe Ingresar solo Números en Numero Contrato";
    //            r.AgendamientoSDA = false;
    //            return r;                
    //        }

    //        if (Convert.ToDateTime(fechaEjercicio) <= FechaProceso)
    //        {
    //            r.footer.errors[0].code = "5";
    //            r.footer.errors[0].description = "Fecha de activación no pude ser menor o igual a la de Ingreso";
    //            r.AgendamientoSDA = false;
    //            return r;                
    //        }


    //        if (Convert.ToDouble(montoEjercicio) <= 0)//Validacion Monto SDA
    //        {
    //            r.footer.errors[0].code = "6";
    //            r.footer.errors[0].description = "Monto no puede ser negativo o cero";
    //            r.AgendamientoSDA = false;
    //            return r;               
    //        }
           
    //        _RelacionLeasing = cData.AccionesBD.Acciones.ValidarelacionLeasing(numeroForward);


    //        if (_RelacionLeasing != null)
    //        {           
    //            DataRow _V = _RelacionLeasing.Rows[0];
    //            _ValidaRelacion = _V["NumFolio"].ToString();

    //            if (_ValidaRelacion != "0")
    //            {
    //                _DataResults = cData.AccionesBD.Acciones.ConValidacion_SDA(numeroForward, Convert.ToDateTime(fechaEjercicio), _ValidaRelacion);

    //                #region ValidaAgendamiento

    //                var FechaVcto = _DataResults.AsEnumerable().FirstOrDefault().Field<DateTime>("CaFechaVcto");
    //                var TotalSolicitud = _DataResults.AsEnumerable().FirstOrDefault().Field<Decimal>("TotalSolicitud");
    //                var MontoMon1 = _DataResults.AsEnumerable().FirstOrDefault().Field<Decimal>("CaMontoMon1");
    //                var FechaVencSolicitud = _DataResults.AsEnumerable().FirstOrDefault().Field<DateTime>("FechaVencSolicitud");

                   
    //              //Compensacion           
    //                Diasvec = 1;
    //                Dias = 2;

    //                if (Convert.ToDateTime(FechaVcto).AddDays(-Diasvec) <= Convert.ToDateTime(fechaEjercicio))
    //                {
    //                    r.footer.errors[0].code = "7";
    //                    r.footer.errors[0].description = "Fecha de activación debe ser menor en "  + Dias + " dias a fecha de vencimiento del contrato " + Convert.ToDateTime(FechaVcto).ToString("dd/MM/yyyy");
    //                    r.AgendamientoSDA = false;
    //                    return r;                          
    //                }

    //                double SumaTotSolicitud = Convert.ToDouble(montoEjercicio) + Convert.ToDouble(TotalSolicitud);

    //                if (Convert.ToDouble(MontoMon1) < Convert.ToDouble(SumaTotSolicitud))
    //                {
    //                    r.footer.errors[0].code = "8";
    //                    r.footer.errors[0].description = "Suma de solicitudes supera nominal de operación que es " + MontoMon1 + " TotalSolicitud solicitudes es " + TotalSolicitud;
    //                    r.AgendamientoSDA = false;
    //                    return r;                          
    //                }

    //                if (Convert.ToDouble(MontoMon1) < Convert.ToDouble(montoEjercicio))
    //                {
    //                    r.footer.errors[0].code = "9";
    //                    r.footer.errors[0].description = "El Monto del Anticipo Debe ser menor o igual al Nominal " + MontoMon1;
    //                    r.AgendamientoSDA = false;
    //                    return r;     
    //                }


    //                if (Convert.ToDateTime(FechaVencSolicitud) == Convert.ToDateTime(fechaEjercicio))
    //                {
    //                    r.footer.errors[0].code = "10";
    //                    r.footer.errors[0].description = "Contrato N° " + numeroForward + " ya tiene fecha de activacion para el dia " + Convert.ToDateTime(fechaEjercicio).ToString("yyyyMMdd");
    //                    r.AgendamientoSDA = false;
    //                    return r;
    //                }

    //                #region Valida Feriados

    //                string FechaVencFeriado = "";
    //                DateTime ValFecActivacion = Convert.ToDateTime(fechaEjercicio);                    
    //                string _xmlResult  = Val.OpcionValFeriados(Convert.ToDateTime(fechaEjercicio));                   
                    
    //                XDocument xmlResult = new XDocument();
    //                xmlResult = XDocument.Parse(_xmlResult);

    //                IEnumerable<XElement> elements = xmlResult.Element("Data").Elements("Vencimiento");
    //                foreach (XElement element in elements)
    //                {
    //                    FechaVencFeriado = element.Attribute("MoFechaVcto").Value.ToString();
    //                }

    //                if (Convert.ToDateTime(fechaEjercicio) != Convert.ToDateTime(FechaVencFeriado))
    //                {
    //                    r.footer.errors[0].code = "11";
    //                    r.footer.errors[0].description = "No puede Ingresar dias feriados.";
    //                    r.AgendamientoSDA = false;
    //                    return r;
    //                }

    //                int DifFechas = (Convert.ToDateTime(fechaEjercicio) - Convert.ToDateTime(ValFecActivacion)).Days;
    //                if (DifFechas != 0)
    //                {
    //                    DifFechas = ((Convert.ToDateTime(fechaEjercicio) - Convert.ToDateTime(FechaProceso)).Days);
    //                }
    //                else
    //                {
    //                    DifFechas = 1;
    //                }

    //                if (Convert.ToDateTime(fechaEjercicio).AddDays(-DifFechas) == Convert.ToDateTime(FechaProceso))
    //                {
    //                    r.footer.errors[0].code = "12";
    //                    r.footer.errors[0].description = "No se puede Ingresar solicitud en T-1 o en dia Feriado";
    //                    r.AgendamientoSDA = false;
    //                    return r;                       
    //                }

    //                  string FechaEsFeriado = "";
    //                  DateTime FechaValSDA = Convert.ToDateTime(FechaProceso).AddDays(+1);
    //                  string _xmlResultFe  = Val.OpcionValFeriadosAnt(Convert.ToDateTime(FechaProceso).AddDays(+1));

                 
    //                  XDocument xmlResultFe = new XDocument();
    //                  xmlResultFe = XDocument.Parse(_xmlResultFe);

    //                  IEnumerable<XElement> elementsFe = xmlResultFe.Element("Data").Elements("Vencimiento");
    //                  foreach (XElement elementFe in elementsFe)
    //                  {
    //                     FechaEsFeriado = elementFe.Attribute("MoFechaVcto").Value.ToString();
    //                  }   

    //                  if (Convert.ToDateTime(FechaEsFeriado) != FechaValSDA && Convert.ToDateTime(fechaEjercicio) == Convert.ToDateTime(FechaEsFeriado))
    //                  {
    //                      r.footer.errors[0].code = "13";
    //                      r.footer.errors[0].description = "No se puede Ingresar solicitud en T-1 o en dia Feriado";
    //                      r.AgendamientoSDA = false;
    //                      return r;   
    //                  }

    //                #endregion Valida feriados
            
    //                #endregion ValidaAgendamiento

    //            }
    //            else
    //            {
    //                r.footer.errors[0].code = "14";
    //                r.footer.errors[0].description = "Forward no se encuentra relacionado con Leasing";
    //                r.AgendamientoSDA = false;
    //                return r;
    //            }            
    //        }

    //        _DataResults = cData.AccionesBD.Acciones.InsertaSolicitudSDA(numeroForward, DateTime.Today, DateTime.Parse(fechaEjercicio), montoEjercicio, "2", "C");


    //        try
    //        {

    //            if (_DataResults != null)
    //            {
    //                //_DataResults.TableName = "ResultadoIngSDA";
    //                DataRow _p = _DataResults.Rows[0];
    //                _Resultado = _p["Resultado"].ToString();
    //                if (_Resultado.Equals("SI"))
    //                {
    //                    r.AgendamientoSDA = true;
    //                }
    //                else
    //                {
    //                    r.AgendamientoSDA = false;
    //                }
    //            }
    //            else
    //            {
    //                _Resultado = "ERROR";
    //                r.AgendamientoSDA = false;
    //            }

    //        }
    //        catch (Exception)
    //        {
    //            r.AgendamientoSDA = false;
    //        }
            
    //        return r;
    //    }
    //}

    //public class ReturnMDOEA1001
    //{
    //    /// <summary>
    //    /// Footer genérico para tag de "return" en servicios Broker.
    //    /// </summary>
    //    public Footer footer;

    //    #region Elementos de Negocio
    //    /// <summary>
    //    /// Resultado de negocio del servicio, indica si la relación es válida.
    //    /// </summary>
    //    public bool AgendamientoSDA;
    //    #endregion Elementos de Negocio

    //}

    //public class Validaciones
    //{
    //    public bool ValidaNumeros(string Campo)
    //    {
    //        bool Result = false;
    //        try
    //        {
    //            decimal x;
    //            string y;
    //            y = Campo;
    //            x = Convert.ToDecimal(Campo);
    //        }
    //        catch
    //        {
    //            Result = true;
    //        }
    //        return Result;
    //    }

    //    public string OpcionValFeriados(DateTime FechaVenc)
    //    {
    //        string _FechaFestivoResutl = "";
    //        try
    //        {
                
              
    //            Calendars calendario = new Calendars();
    //            calendario.Load();

    //            if (!calendario.IsBussineDay(6, FechaVenc))
    //            {
    //                FechaVenc = calendario.NextHolidayDate(6, FechaVenc);

    //                _FechaFestivoResutl = "<Data>\n";
    //                _FechaFestivoResutl += "<Vencimiento MoFechaVcto='" + FechaVenc.ToString("dd-MM-yyyy") + "'/>\n";
    //                _FechaFestivoResutl += "</Data>";
    //            }
    //            else
    //            {
    //                _FechaFestivoResutl = "<Data>\n";
    //                _FechaFestivoResutl += "<Vencimiento MoFechaVcto='" + FechaVenc.ToString("dd-MM-yyyy") + "'/>\n";
    //                _FechaFestivoResutl += "</Data>";

    //            }

    //        }
    //        catch { }
    //        return _FechaFestivoResutl;
    //    }

    //    public string OpcionValFeriadosAnt(DateTime FechaVenc)
    //    {
    //        string _FechaFestivoResutl = "";
    //        try
    //        {
    //            Calendars calendario = new Calendars();
    //            calendario.Load();

    //            if (!calendario.IsBussineDay(6, FechaVenc))
    //            {
    //                FechaVenc = calendario.NextHolidayDate(6, FechaVenc);

    //                _FechaFestivoResutl = "<Data>\n";
    //                _FechaFestivoResutl += "<Vencimiento MoFechaVcto='" + FechaVenc.ToString("dd-MM-yyyy") + "'/>\n";
    //                _FechaFestivoResutl += "</Data>";

    //            }
    //            else
    //            {
    //                _FechaFestivoResutl = "<Data>\n";
    //                _FechaFestivoResutl += "<Vencimiento MoFechaVcto='" + FechaVenc.ToString("dd-MM-yyyy") + "'/>\n";
    //                _FechaFestivoResutl += "</Data>";

    //            }

    //        }
    //        catch { }
    //        return _FechaFestivoResutl;
    //    }

    //}
   
}
