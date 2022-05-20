using System;
using System.Web.UI;
using AdminOpciones.Web.Recursos;


namespace AdminOpciones.Web
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) 
        {
            string _cNombreArchivo = "PageSwicht";             
            Response.Clear();
            Response.AddHeader("content-disposition", "attachment;filename=" + _cNombreArchivo);
            Response.Charset = "";
            Response.ContentType = "application/vnd.text";
            System.IO.StringWriter stringWrite = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);

            SecureQueryString qs = new SecureQueryString();
            string tipo_ = Request.Params["Tipo"];
            switch (tipo_) 
            {
                case "Liquidacion":
                case "LiquidacionPrima":
                    qs["NumGrupo"] = Request.Params["NumGrupo"];
                    qs["RepName"] = Request.Params["RepName"];
                    qs["Tipo"] = Request.Params["Tipo"];
                    qs["Usuario"] = Request.Params["Usuario"];
                    qs["FechaDesde"] = Request.Params["FechaDesde"];
                    qs["FechaHasta"] = Request.Params["FechaHasta"];
                    break;
                case "Movimiento":
                    qs["NumGrupo"] = Request.Params["NumGrupo"];
                    qs["RepName"] = Request.Params["RepName"];
                    qs["Tipo"] = Request.Params["Tipo"];
                    qs["Usuario"] = Request.Params["Usuario"];                    
                    qs["NumeroContrato"] = Request.Params["NumeroContrato"];
                    break;
                case "Cartera":
                case "Fax":
                    qs["NumContrato"] = Request.Params["NumContrato"];
                    qs["RepName"] = Request.Params["RepName"];
                    qs["Tipo"] = Request.Params["Tipo"];
                    qs["Usuario"] = Request.Params["Usuario"];
                    qs["Fecha"] = Request.Params["Fecha"];                   
                    break;
                case "Vanilla":
                case "Asiatica":
                case "Generico":
                    qs["NumContrato"] = Request.Params["NumContrato"];
                    qs["RepName"] = Request.Params["RepName"];
                    qs["Tipo"] = Request.Params["Tipo"];
                    qs["Usuario"] = Request.Params["Usuario"];
                    qs["Fecha"] = Request.Params["Fecha"];
                    qs["RutRepCli01"] = Request.Params["RutRepCli01"];
                    qs["RutRepCli02"] = Request.Params["RutRepCli02"];
                    qs["RutRepBan01"] = Request.Params["RutRepBan01"];
                    qs["RutRepBan02"] = Request.Params["RutRepBan02"];
                    break;
                case "CondicionGeneral":
                    qs["Rut"] = Request.Params["Rut"];
                    qs["Codigo"] = Request.Params["Codigo"];
                    qs["RepName"] = Request.Params["RepName"];
                    qs["Tipo"] = Request.Params["Tipo"];
                    qs["Usuario"] = Request.Params["Usuario"];
                    qs["RutRepCli01"] = Request.Params["RutRepCli01"];
                    qs["RutRepCli02"] = Request.Params["RutRepCli02"];
                    qs["RutRepBan01"] = Request.Params["RutRepBan01"];
                    qs["RutRepBan02"] = Request.Params["RutRepBan02"];
                    break;
                case "ICartera":
                    qs["Usuario"] = Request.Params["Usuario"];
                    qs["RepName"] = Request.Params["RepName"];
                    qs["Tipo"] = Request.Params["Tipo"];
                    qs["FechaDesde"] = Request.Params["FechaDesde"];
                    qs["TipoTransaccion"] = Request.Params["TipoTransaccion"];
                    qs["NumeroContrato"] = Request.Params["NumeroContrato"];
                    break;
                case "ICarteraOpciones":
                case "Voucher":
                case "Balance":
                    qs["Usuario"] = Request.Params["Usuario"];
                    qs["RepName"] = Request.Params["RepName"];
                    qs["Tipo"] = Request.Params["Tipo"];
                    qs["FechaDesde"] = Request.Params["FechaDesde"];
                    break;
                case "ListMovFechas":
                case "ListContrPreci":
                    qs["Usuario"] = Request.Params["Usuario"];
                    qs["RepName"] = Request.Params["RepName"];
                    qs["Tipo"] = Request.Params["Tipo"];
                    qs["FechaDesde"] = Request.Params["FechaDesde"];
                    qs["FechaHasta"] = Request.Params["FechaHasta"];
                    qs["NumeroContrato"] = Request.Params["NumeroContrato"];
                    break;
                case "ListAnulaciones":
                    qs["Usuario"] = Request.Params["Usuario"];
                    qs["RepName"] = Request.Params["RepName"];
                    qs["Tipo"] = Request.Params["Tipo"];
                    qs["FechaDesde"] = Request.Params["FechaDesde"];
                    qs["FechaHasta"] = Request.Params["FechaHasta"];
                    qs["TipoTransac"] = Request.Params["TipoTransac"];
                    qs["NumeroContrato"] = Request.Params["NumeroContrato"];
                    break;                                    
                case "MovPorCta":
                    qs["Usuario"] = Request.Params["Usuario"];
                    qs["RepName"] = Request.Params["RepName"];
                    qs["Tipo"] = Request.Params["Tipo"];
                    qs["FechaDesde"] = Request.Params["FechaDesde"];
                    qs["FechaHasta"] = Request.Params["FechaHasta"];
                    qs["Cuenta"] = Request.Params["Cuenta"];
                    break;
                case "CntVoucher":
                case "IntDerivados":
                case "IntOperaciones":
                case "IntBalance":
                    qs["Fecha"] = Request.Params["Fecha"];
                    qs["Tipo"] = Request.Params["Tipo"];
                    break;                                    
            }            
            Response.Write(qs.ToString());
            stringWrite.Dispose();
            htmlWrite.Dispose();
            Response.End();
        }
    }
}
