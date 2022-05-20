using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Xml;
//using Corpbanca.BloquesFrameworkNET.Comunes.Broker.Body;
using System.Data;

namespace AdminOpciones2010.Web.WebService.Leasing
{
    /// <summary>
    /// Servicio MDOEC1002: MesaDinero, OperacionesEstructuradas, Consulta 1002
    /// Proyecto Forward Americano Leasing stand-by por fusión.
    /// Servicios comentados, se custodia el código por solicitud de Cristian Guerra.
    /// </summary>
    #region pruebas
    //[System.Xml.Serialization.XmlNamespaceDeclarations(
    //[System.Web.Services.Protocols.SoapHeader(
    //[WebService(Name = "MDOEC1002", Namespace = "http://cl.corpbanca.soa/MDOEC1002")]
    //[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    //[System.Web.Services.Configuration.
    //[System.Web.Services.Protocols.SoapDocumentService(RoutingStyle = System.Web.Services.Protocols.SoapServiceRoutingStyle.RequestElement)]
    #endregion pruebas
    //[WebService(Name = "MDOEC1002", Namespace = "http://cl.corpbanca.soa/MDOEC1002")]
    //[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1, Name = "MDOEC1002", Namespace = "http://cl.corpbanca.soa/MDOEC1002")]
    //[System.ComponentModel.ToolboxItem(false)]
    //[System.Web.Services.Protocols.SoapDocumentService(RoutingStyle=System.Web.Services.Protocols.SoapServiceRoutingStyle.RequestElement)]
    //public class MDOEC1002Service : System.Web.Services.WebService
    //{
    //    //ASVG_20141113
    //    //PRD_16803

    //    ////Servicio de prueba.
    //    //[WebMethod]
    //    //public string prueba(string rutCliente, string numeroLeasing, string numeroGrupoBien)
    //    //{
    //    //    rutCliente = "14";
    //    //    numeroLeasing = "2011981";
    //    //    numeroGrupoBien = "2";

    //    //    string sTimeStamp = "Hora ejecución: " + System.DateTime.Now.ToString();

    //    //    //sTimeStamp += "\n COD_CANAL: " + Header.COD_CANAL;
    //    //    sTimeStamp += "\n rutCliente: " + rutCliente;

    //    //    //Elementos obligatorios
    //    //    ReturnMDOEC1002 r = new ReturnMDOEC1002();
    //    //    r.footer = new Footer("MDOEC1002", "0", "", sTimeStamp);

    //    //    //Elementos de Negocio

    //    //    r.ListarForwardRelacionados = new ForwardRelacionado();
    //    //    //ESTOS VALORES SON LOS QUE DEBEN SER RESUELTOS POR LA LÓGICA DE NEGOCIO.
    //    //    int i = 0;
    //    //    string s = "";
    //    //    DataTable dt = cData.Estructurados.Estructurados.DTListarForwardRelacionados(rutCliente, numeroLeasing, numeroGrupoBien).Tables["Query"];//.Tables (;//.GetXml();
    //    //    //if (s.Equals("<NewDataSet />")) { s = ""; }
    //    //    if (dt.Rows.Count.Equals(0))
    //    //    {
    //    //        r.ListarForwardRelacionados = null;
    //    //    }
    //    //    else
    //    //    {
    //    //        //foreach (DataRow row in dt.Rows)
    //    //        r.ListarForwardRelacionados = new ForwardRelacionado(dt.Rows[0].ItemArray);
    //    //    }

    //    //    return "";
    //    //}


        
    //    /* <Header>
    //     *  <COD_USUARIO>?</COD_USUARIO>
    //     *  <ID_TERMINAL>?</ID_TERMINAL>
    //     *  <COD_CANAL>?</COD_CANAL>
    //     *  <ID_APLICACION>?</ID_APLICACION>
    //     *  <COD_ENTIDAD>?</COD_ENTIDAD>
    //     *  <IP_ORIGEN>?</IP_ORIGEN>
    //     *  <ID_SERVIDOR>?</ID_SERVIDOR>
    //     *  <COD_LENGUAJE>?</COD_LENGUAJE>
    //     *  <TIMESTAMP>?</TIMESTAMP>
    //     * </Header>
    //    */
    //    /// <summary>
    //    /// Implementación Broker de WS. Falta hacer que el parámetro Header sea obligatorio.
    //    /// </summary>
    //    /// <param name="Header"></param>
    //    /// <param name="?"></param>
    //    /// <returns></returns>
    //    [WebMethod(MessageName = "MDOEC1002")]
    //    [return: System.Xml.Serialization.XmlElement(ElementName = "return", Type = typeof(ReturnMDOEC1002))]
    //    public ReturnMDOEC1002 MDOEC1002([System.Xml.Serialization.XmlElement(IsNullable = false)]Header Header, string rutCliente, string numeroLeasing, string numeroGrupoBien)
    //    {
    //        string sTimeStamp = "Hora ejecución: " + System.DateTime.Now.ToString();

    //        sTimeStamp += "\n COD_CANAL: " + Header.COD_CANAL;
    //        sTimeStamp += "\n rutCliente: " + rutCliente;

    //        //Elementos obligatorios
    //        ReturnMDOEC1002 r = new ReturnMDOEC1002();
    //        r.footer = new Footer("MDOEC1002", "0", "", sTimeStamp);

    //        //Elementos de Negocio

    //        r.ListarForwardRelacionados = new ForwardRelacionado();
    //        //ESTOS VALORES SON LOS QUE DEBEN SER RESUELTOS POR LA LÓGICA DE NEGOCIO.
    //        int i = 0;
    //        string s = "";
    //        DataTable dt = cData.Estructurados.Estructurados.DTListarForwardRelacionados(rutCliente, numeroLeasing, numeroGrupoBien).Tables["Query"];//.Tables (;//.GetXml();
    //        //if (s.Equals("<NewDataSet />")) { s = ""; }
    //        if (dt.Rows.Count.Equals(0))
    //        {
    //            r.ListarForwardRelacionados = null;
    //        }
    //        else
    //        {
    //            //foreach (DataRow row in dt.Rows)
    //            r.ListarForwardRelacionados = new ForwardRelacionado(dt.Rows[0].ItemArray);
    //        }

    //        return r;
    //    }
    //}

    ///// <summary>
    ///// Genera un tag de "return" con Footer y elementos de Negocio
    ///// </summary>
    //public class ReturnMDOEC1002
    //{
    //    /// <summary>
    //    /// Footer genérico para tag de "return" en servicios Broker.
    //    /// </summary>
    //    public Footer footer;

    //    #region Elementos de Negocio
    //    /// <summary>
    //    /// Resultado de negocio del servicio, indica si la relación es válida.
    //    /// </summary>
    //    public ForwardRelacionado ListarForwardRelacionados; //no cambiar nombre
    //    #endregion Elementos de Negocio
    //}

    //public class ForwardRelacionado
    //{
    //    //<CaRutCliente>99500410</CaRutCliente>
    //    //<numero_leasing>10</numero_leasing>
    //    //<numero_grupo_bien>11</numero_grupo_bien>
    //    //<numero_fwd_relacion>1833</numero_fwd_relacion>
    //    //<CaFechaVcto>2013-08-01T00:00:00-04:00</CaFechaVcto>
    //    //<CaMontoMon1>1000000.000000</CaMontoMon1>

    //    private string _carutcliente;
    //    private long _numeroleasing;
    //    private long _numerogrupobien;
    //    private long _numerofwdrelacion;
    //    private string _cafechavcto;
    //    private string _camontomon1;

    //    public ForwardRelacionado(){}

    //    public ForwardRelacionado(object[] data)
    //    {
    //        this._carutcliente = data[0].ToString();
    //        this._numeroleasing = long.Parse(data[1].ToString());
    //        this._numerogrupobien = long.Parse(data[2].ToString());
    //        this._numerofwdrelacion = long.Parse(data[3].ToString());
    //        this._cafechavcto = data[4].ToString();
    //        this._camontomon1 = data[5].ToString();
    //    }

    //    public ForwardRelacionado(string XmlDataSet)
    //    {
    //        XmlDocument x = new XmlDocument();
    //        x.LoadXml(XmlDataSet);

    //        //MEJORAR cochino pero funciona
    //        this._carutcliente = x.GetElementsByTagName("CaRutCliente").Item(0).InnerText;
    //        this._numeroleasing = long.Parse(x.GetElementsByTagName("numero_leasing").Item(0).InnerText);
    //        this._numerogrupobien = long.Parse(x.GetElementsByTagName("numero_grupo_bien").Item(0).InnerText);
    //        this._numerofwdrelacion = long.Parse(x.GetElementsByTagName("numero_fwd_relacion").Item(0).InnerText);
    //        this._cafechavcto = x.GetElementsByTagName("CaFechaVcto").Item(0).InnerText;
    //        this._camontomon1 = x.GetElementsByTagName("CaMontoMon1").Item(0).InnerText;
    //    }

    //    public string CaRutCliente
    //    {
    //        get
    //        {
    //            return this._carutcliente;
    //        }
    //        set
    //        {
    //            this._carutcliente = value;
    //        }
    //    }
    //    public long numero_leasing
    //    {
    //        get
    //        {
    //            return this._numeroleasing;
    //        }
    //        set
    //        {
    //            this._numeroleasing = value;
    //        }
    //    }
    //    public long numero_grupo_bien
    //    {
    //        get
    //        {
    //            return this._numerogrupobien;
    //        }
    //        set
    //        {
    //            this._numerogrupobien = value;
    //        }
    //    }
    //    public long numero_fwd_relacion
    //    {
    //        get
    //        {
    //            return this._numerofwdrelacion;
    //        }
    //        set
    //        {
    //            this._numerofwdrelacion = value;
    //        }
    //    }
    //    public string CaFechaVcto
    //    {
    //        get
    //        {
    //            return this._cafechavcto;
    //        }
    //        set
    //        {
    //            this._cafechavcto = value;
    //        }
    //    }
    //    public string CaMontoMon1
    //    {
    //        get
    //        {
    //            return this._camontomon1;
    //        }
    //        set
    //        {
    //            this._camontomon1 = value;
    //        }
    //    }

    //}
}
