using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using cData.Opciones;
using System.Data;

namespace AdminOpciones.Web.WebService.OpcionesFX.Customers
{
    /// <summary>
    /// Descripción breve de SrvCustomers
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class SrvCustomers : System.Web.Services.WebService
    {

        [WebMethod]
        public string getCustomersData()
        {
            DataTable _CustomersData = new DataTable();

           _CustomersData = CustomersData.GetCustomersData();

            DataRow _Row;

           //alanrevisar
           /* alanrevisar esto es viejo, se cambio por performance al parecer
           string ReturnValue = "<CustomrsData>\n";
           string _CustomerName = "";

           for (int i = 0; i < _CustomersData.Rows.Count; i++)
           {
               _Row = _CustomersData.Rows[i];

               _CustomerName = _Row["Clnombre"].ToString().TrimEnd();
               _CustomerName = _CustomerName.Replace("  ", " ");
               _CustomerName = _CustomerName.Replace("&", "&#38;");
               _CustomerName = _CustomerName.Replace("Ñ", "&#209;");
               _CustomerName = _CustomerName.Replace("Ñ", "&#241;");
               _CustomerName = _CustomerName.Replace("'", "&#39;");

               ReturnValue += "<Data " +
                                "Clrut='" + _Row["Clrut"].ToString() + "' " +
                                "Cldv='" + _Row["Cldv"].ToString() + "' " +
                                "Clcodigo='" + _Row["Clcodigo"].ToString() + "' " +
                                "Clnombre='" + _CustomerName + "' " +
                                //"Cldirecc='" + _Row["Cldirecc"].ToString().Replace("  ", "").Replace(",", " ").Replace(" - ", "") + "' " +
                                "/>";
           }
           ReturnValue += "</CustomrsData>";

           return ReturnValue;
	   */

           //alanrevisar esto es lo nuevo hasta el return incluido
            string _Customer = "";
            string _CustomerName = "";
            string _Value = "<CustomrsData>\n";

            for (int i = 0; i < _CustomersData.Rows.Count; i++)
            {
                _Row = _CustomersData.Rows[i];

                _CustomerName = _Row["Clnombre"].ToString().TrimEnd();
                _CustomerName = _CustomerName.Replace("  ", " ");
                /*
                _CustomerName = _CustomerName.Replace("&", "&#38;");
                _CustomerName = _CustomerName.Replace("Ñ", "&#209;");
                _CustomerName = _CustomerName.Replace("Ñ", "&#241;"); //esta es minuscula
                _CustomerName = _CustomerName.Replace("'", "&#39;");
                */

                //alanrevisar esto hay que arreglarlo
                _CustomerName = _CustomerName.Replace("&", "&#38;");
                _CustomerName = _CustomerName.Replace("À", "&#192;");
                _CustomerName = _CustomerName.Replace("Á", "&#193;");
                _CustomerName = _CustomerName.Replace("Â", "&#194;");
                _CustomerName = _CustomerName.Replace("Ã", "&#195;");
                _CustomerName = _CustomerName.Replace("Ä", "&#196;");
                _CustomerName = _CustomerName.Replace("Å", "&#197;");
                _CustomerName = _CustomerName.Replace("È", "&#200;");
                _CustomerName = _CustomerName.Replace("É", "&#201;");
                _CustomerName = _CustomerName.Replace("Ê", "&#202;");
                _CustomerName = _CustomerName.Replace("Ë", "&#203;");
                _CustomerName = _CustomerName.Replace("Ì", "&#204;");
                _CustomerName = _CustomerName.Replace("Í", "&#205;");
                _CustomerName = _CustomerName.Replace("Î", "&#206;");
                _CustomerName = _CustomerName.Replace("Ï", "&#207;");
                _CustomerName = _CustomerName.Replace("Ñ", "&#209;");
                _CustomerName = _CustomerName.Replace("Ò", "&#210;");
                _CustomerName = _CustomerName.Replace("Ó", "&#211;");
                _CustomerName = _CustomerName.Replace("Ô", "&#212;");
                _CustomerName = _CustomerName.Replace("Õ", "&#213;");
                _CustomerName = _CustomerName.Replace("Ö", "&#214;");
                _CustomerName = _CustomerName.Replace("Ù", "&#217;");
                _CustomerName = _CustomerName.Replace("Ú", "&#218;");
                _CustomerName = _CustomerName.Replace("Û", "&#219;");
                _CustomerName = _CustomerName.Replace("Ü", "&#220;");
                _CustomerName = _CustomerName.Replace("Ý", "&#221;");
                _CustomerName = _CustomerName.Replace("/", "&#47;");
                _CustomerName = _CustomerName.Replace("\\", "&#92;");
                _CustomerName = _CustomerName.Replace("à", "&#224;");
                _CustomerName = _CustomerName.Replace("á", "&#225;");
                _CustomerName = _CustomerName.Replace("â", "&#226;");
                _CustomerName = _CustomerName.Replace("ã", "&#227;");
                _CustomerName = _CustomerName.Replace("ä", "&#228;");
                _CustomerName = _CustomerName.Replace("å", "&#229;");
                _CustomerName = _CustomerName.Replace("è", "&#232;");
                _CustomerName = _CustomerName.Replace("é", "&#233;");
                _CustomerName = _CustomerName.Replace("ê", "&#234;");
                _CustomerName = _CustomerName.Replace("ë", "&#235;");
                _CustomerName = _CustomerName.Replace("ì", "&#236;");
                _CustomerName = _CustomerName.Replace("í", "&#237;");
                _CustomerName = _CustomerName.Replace("î", "&#238;");
                _CustomerName = _CustomerName.Replace("ï", "&#239;");
                _CustomerName = _CustomerName.Replace("ñ", "&#241;");
                _CustomerName = _CustomerName.Replace("ò", "&#242;");
                _CustomerName = _CustomerName.Replace("ó", "&#243;");
                _CustomerName = _CustomerName.Replace("ô", "&#244;");
                _CustomerName = _CustomerName.Replace("õ", "&#245;");
                _CustomerName = _CustomerName.Replace("ö", "&#246;");
                _CustomerName = _CustomerName.Replace("ù", "&#249;");
                _CustomerName = _CustomerName.Replace("ú", "&#250;");
                _CustomerName = _CustomerName.Replace("û", "&#251;");
                _CustomerName = _CustomerName.Replace("ü", "&#252;");
                _CustomerName = _CustomerName.Replace("ý", "&#253;");
                _CustomerName = _CustomerName.Replace("ÿ", "&#255;");
                _CustomerName = _CustomerName.Replace("°", "&#176;");
                _CustomerName = _CustomerName.Replace("º", "&#186;");//repetido ?
                _CustomerName = _CustomerName.Replace("´", "&#180;");
                _CustomerName = _CustomerName.Replace("•", "&#183;");
                _CustomerName = _CustomerName.Replace("'", "&#39;");

                
                _Customer = "<Data " +
                                   "Clrut='" + _Row["Clrut"].ToString() + "' " +
                                   "Cldv='" + _Row["Cldv"].ToString() + "' " +
                                   "Clcodigo='" + _Row["Clcodigo"].ToString() + "' " +
                                   "Clnombre='" + _CustomerName + "' " +
                            "/>";
                _Value += _Customer;
            }
            _Value += "</CustomrsData>";

            return _Value;
        }


        [WebMethod]
        public string getCustomersDataCondicionesGenerales()
        {
            DataTable _CustomersData = new DataTable();

            _CustomersData = CustomersData.GetCustomersDataCondicionesGenerales();

            DataRow _Row;

            string ReturnValue = "<CustomrsData>\n";
            string _CustomerName = "";

            for (int i = 0; i < _CustomersData.Rows.Count; i++)
            {
                _Row = _CustomersData.Rows[i];

                _CustomerName = _Row["Clnombre"].ToString().TrimEnd();
                _CustomerName = _CustomerName.Replace("  ", " ");
                _CustomerName = _CustomerName.Replace("&", "&#38;");
                _CustomerName = _CustomerName.Replace("Ñ", "&#209;");
                _CustomerName = _CustomerName.Replace("Ñ", "&#241;");
                _CustomerName = _CustomerName.Replace("'", "&#39;");

                ReturnValue += "<Data " +
                                 "Clrut='" + _Row["Clrut"].ToString() + "' " +
                                 "Cldv='" + _Row["Cldv"].ToString() + "' " +
                                 "Clcodigo='" + _Row["Clcodigo"].ToString() + "' " +
                                 "Clnombre='" + _CustomerName + "' />";            }
            ReturnValue += "</CustomrsData>";

            return ReturnValue;

        }
    }
}
