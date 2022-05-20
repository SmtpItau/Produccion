using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Xml.Linq;
using System.Xml;
using Corpbanca.BloquesFrameworkNET.Comunes.SOA;

namespace AdminOpciones.Web.WebService.OpcionesFX.LeasingFwdAmericano
{
    /// <summary>
    /// Descripción breve de Leasing
	/// REVISAR CONFIRMAR utilidad de este WS.
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class Leasing : System.Web.Services.WebService
    {

        [WebMethod]
        public string ValidaLeasingACLSC1001(string RutCliente, string NumeroLeasing, string NumeroGrupoBien, string MontoBien)
        {
            return ACLSC1001(RutCliente, NumeroLeasing, NumeroGrupoBien, MontoBien);
        }

        [WebMethod]
        public string ConsultaLeasingACLSC1002()
        {
            return ACLSC1002();
        }


        static public string ACLSC1001(string rutCliente, string operacion, string grupoBien, string montoBien)
        {
            SOACliente SOACliente = new SOACliente("ACLSC1001");
            

            SOACliente.Encabezado.Aplicacion = "IBANK";
            SOACliente.Encabezado.Usuario = "TSTCER1";
            SOACliente.Encabezado.IpOrigen = "172.17.4.188";// HttpContext.Current.Request.UserHostAddress;

            SOACliente.AgregarParametro("rutCliente", rutCliente);
            SOACliente.AgregarParametro("operacion", operacion);
            SOACliente.AgregarParametro("grupoBien", grupoBien);
            SOACliente.AgregarParametro("montoBien", montoBien);

            SOARespuesta SOARespuesta = SOACliente.EnviarRecibir();

            if (SOARespuesta.Exito)
            {
                if (!SOARespuesta.DescripcionError.Equals(string.Empty))
                {
                    return SOARespuesta.DescripcionError;
                }               

                Corpbanca.BloquesFrameworkNET.Comunes.Xml.Consultor Consultor = new Corpbanca.BloquesFrameworkNET.Comunes.Xml.Consultor(SOARespuesta.Respuesta);

                string retval = "";
                retval += Consultor.TraerValor("//return/grabaFrwdAmericano");
                return retval;

            }
            else
            {
                return "No se recibio respuesta desde el host";
            }
        }

        static public string ACLSC1002()
        {
            SOACliente SOACliente = new SOACliente("ACLSC1002");
            XDocument xmlResult = new XDocument();

            SOACliente.Encabezado.Aplicacion = "IBANK";
            SOACliente.Encabezado.Usuario = "TSTCER1";
            SOACliente.Encabezado.IpOrigen = "172.17.4.188";// HttpContext.Current.Request.UserHostAddress;

            SOARespuesta SOARespuesta = SOACliente.EnviarRecibir();

            if (SOARespuesta.Exito)
            {
                if (!SOARespuesta.DescripcionError.Equals(string.Empty))
                {
                    return SOARespuesta.DescripcionError;
                }

                //Corpbanca.BloquesFrameworkNET.Comunes.Xml.Consultor Consultor = new Corpbanca.BloquesFrameworkNET.Comunes.Xml.Consultor(SOARespuesta.Respuesta);
                xmlResult = XDocument.Parse(SOARespuesta.Respuesta);

                //string retval = "";
                //retval += "Mensaje utilizado:\n" + "Prueba" + "\n";
                //retval += SOARespuesta.Respuesta.ToString(); //Consultor.TraerValor("//return/matrizLesingAsociado/datosLesingAsociado/numeroLeasing");
                //return retval;

                xmlResult = XDocument.Parse(SOARespuesta.Respuesta);
                //string retval = "";
                //retval += "<?xml version=\"1.0\" encoding=\"utf-8\"?>" ;
                //retval += "<RelatedLeasingClassList xmlns:xsi= \"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns=\"http://tempuri.org/\">";
                //retval += SOARespuesta.Respuesta.ToString();
                //retval += "</RelatedLeasingClassList>";

                return xmlResult.ToString();
                //return retval;
               
            }
            else
            {
                return "No se recibio respuesta desde el host";
            }
        }
    }
}
