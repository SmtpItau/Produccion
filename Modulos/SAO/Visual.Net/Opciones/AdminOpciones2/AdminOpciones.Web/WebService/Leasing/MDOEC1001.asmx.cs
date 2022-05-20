using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Xml;
//using Corpbanca.BloquesFrameworkNET.Comunes.Broker.Body;

namespace AdminOpciones2010.Web.WebService.Leasing
{
    /// <summary>
    /// Servicio MDOEC1001: MesaDinero, OperacionesEstructuradas, Consulta 1001
    /// Proyecto Forward Americano Leasing stand-by por fusión.
    /// Servicios comentados, se custodia el código por solicitud de Cristian Guerra.
    /// </summary>
    #region pruebas
    //[System.Xml.Serialization.XmlNamespaceDeclarations(
    //[System.Web.Services.Protocols.SoapHeader(
    #endregion pruebas
    //[WebService(Name = "MDOEC1001", Namespace = "http://cl.corpbanca.soa/MDOEC1001")]
    //[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1, Name = "MDOEC1001", Namespace = "http://cl.corpbanca.soa/MDOEC1001")]
    //[System.ComponentModel.ToolboxItem(false)]
    //[System.Web.Services.Protocols.SoapDocumentService(RoutingStyle=System.Web.Services.Protocols.SoapServiceRoutingStyle.RequestElement)]
    //public class MDOEC1001Service : System.Web.Services.WebService
    //{
    //    /// <summary>
    //    /// Implementación Broker de WS. Falta hacer que el parámetro Header sea obligatorio.
    //    /// </summary>
    //    /// <param name="Header"></param>
    //    /// <param name="rutCliente"></param>
    //    /// <param name="numeroLeasing"></param>
    //    /// <param name="numeroGrupoBien"></param>
    //    /// <param name="numeroForward"></param>
    //    /// <returns></returns>
    //    [WebMethod(MessageName = "MDOEC1001")]
    //    //Esto se puede usar para generar el tag de return.
    //    //[SoapDocumentMethod(ResponseElementName="return")]
    //    [return: System.Xml.Serialization.XmlElement(ElementName = "return", Type = typeof(ReturnMDOEC1001))]
    //    //[System.Xml.Serialization.XmlInclude(typeof(ReturnMDOEC1001))]
    //    //public ReturnMDOEC1001 MDOEC1001([System.Xml.Serialization.XmlElement(IsNullable = false)] Header Header, int rutCliente, long numeroLeasing, long numeroGrupoBien, int numeroForward)
    //    //public ReturnMDOEC1001 MDOEC1001(Header Header, string rutCliente, string numeroLeasing, string numeroGrupoBien, string numeroForward)
    //    public ReturnMDOEC1001 MDOEC1001([System.Xml.Serialization.XmlElement(IsNullable = false)]Header Header, string rutCliente, string numeroLeasing, string numeroGrupoBien, string numeroForward)
    //    {
    //        //string rutCliente = "0";
    //        //Header _header = new Corpbanca.BloquesFrameworkNET.Comunes.Broker.Body.Header();

    //        string sTrace = "Hora ejecución: " + System.DateTime.Now.ToString();

    //        //no necesita try
    //        sTrace += "\n Header null?: ";
    //        try { sTrace += Equals(Header,null).ToString(); }
    //        catch { sTrace += "CATCH"; }

    //        sTrace += "\n Header name: ";
    //        try { sTrace += Header.GetType().AssemblyQualifiedName; }
    //        catch { sTrace += "CATCH"; }
            
    //        //try { sTrace += "\n 1: " + Header.GetType().ToString();             } catch { }
    //        //try { sTrace += "\n 2: " + Header.GetType().FullName;               } catch { }
    //        //try { sTrace += "\n 4: " + Header.ToString();                       } catch { }

    //        sTrace += "\n Header.TIMESTAMP: ";
    //        try { sTrace += Header.TIMESTAMP; }
    //        catch { sTrace += "CATCH"; }

    //        //sTrace += "\n Header.rutCliente: ";
    //        //try { sTrace += Header.rutCliente; }
    //        //catch { sTrace += "CATCH"; }

    //        //sTrace += "\n rutCliente: " + rutCliente;
    //        //sTrace += "\n numeroLeasing: " + numeroLeasing;
    //        //sTrace += "\n numeroGrupoBien: " + numeroGrupoBien;
    //        //sTrace += "\n numeroForward: " + numeroForward;

    //        //Elementos de Negocio
    //        //ESTOS VALORES SON LOS QUE DEBEN SER RESUELTOS POR LA LÓGICA DE NEGOCIO.
    //        int _ret = -1;
    //        bool b = false;

    //        //Componente: cData.Estructurados.Estructurados
    //        //esto tiene que ir en el documento DTS
    //        try
    //        {
    //            _ret = cData.Estructurados.Estructurados.DTValidarForward(rutCliente, numeroLeasing, numeroGrupoBien, numeroForward).Tables["Query"].Rows.Count;
    //            if (_ret == 1)  { b = true; }
    //            else            { b = false;}
    //        }
    //        catch
    //        {
    //            _ret = -1; //redundante?
    //        }

    //        sTrace += "\n cData.Estructurados.Estructurados.DTValidarForward: ";
    //        try { sTrace += _ret; }
    //        catch { sTrace += "CATCH"; }

    //        //Elementos obligatorios
    //        ReturnMDOEC1001 retval = new ReturnMDOEC1001();
    //        Footer _footer = new Footer("MDOEC1001", "0", "Ok", sTrace);
    //        retval.footer = _footer;
    //        if (_ret >= 0)
    //        {
    //            retval.validaForwardRelacionado = b;
    //        }

    //        return retval;
    //    }
    //}

    ///// <summary>
    ///// Genera un tag de "return" con Footer y elementos de Negocio
    ///// </summary>
    //public class ReturnMDOEC1001
    //{
    //    /// <summary>
    //    /// Footer genérico para tag de "return" en servicios Broker.
    //    /// </summary>
    //    public Footer footer;

    //    #region Elementos de Negocio
    //    /// <summary>
    //    /// Resultado de negocio del servicio, indica si la relación es válida.
    //    /// </summary>
    //    public bool validaForwardRelacionado;
    //    #endregion Elementos de Negocio
    //}
}
