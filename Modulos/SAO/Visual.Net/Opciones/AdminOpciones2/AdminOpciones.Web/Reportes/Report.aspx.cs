using System;
using AdminOpciones.Web.Recursos;
//evaluar eliminar estos using.
using CrystalDecisions.Shared;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Web;
using System.Configuration; // MAP 20090618

namespace AdminOpciones.Web.Reportes
{
    public partial class Report : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Decodificar
            SecureQueryString qs = new SecureQueryString(Context.Request.QueryString["d"]);
            Response.Redirect("Reports.aspx?" + Context.Request.QueryString.ToString());
        }
    }
}