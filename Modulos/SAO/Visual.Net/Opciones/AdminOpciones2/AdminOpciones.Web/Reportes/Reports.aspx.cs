using System;
using AdminOpciones.Web.Recursos;
using CrystalDecisions.Shared;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Web;
using System.Configuration;

//************************************************
//************************************************
//* Desarrollado por Edaurdo Castillo 30/06/2011 *
//************************************************
//************************************************

namespace AdminOpciones.Web.Reportes
{
    public partial class Reports : System.Web.UI.Page
    {
        private string NomReport;
        private int NumFolio;
        private int NumGrupo;
        private int NumContrato;
        private int RutCli01;
        private int RutCli02;
        private int RutBan01;
        private int RutBan02;
        private string Fecha;
        private string FechaDesde;
        private string FechaHasta;
        private string NomUser;
        private string TipoReporte;
        private int Codigo;
        private int Rut;

        TableLogOnInfo crTableLogOnInfo = new TableLogOnInfo();
		ConnectionInfo crConnectionInfo = new ConnectionInfo();

		Database crDatabase;
		Tables crTables;

        public class ParamReportesGenericos
        {
            public string ReportName { get; set; }
            public string Cuenta { get; set; }
            public string TipoTransac { get; set; }
            public string FechaDesde { get; set; }
            public string FechaHasta { get; set; }
            public string Usuario { get; set; }
            public string Tipo_Reporte { get; set; }
            public string NumeroContrato { get; set; }
        }

        ParamReportesGenericos valor_;

		private void Page_Load(object sender, EventArgs e)
		{
			Impresion_Reporte();
		}

		private void Impresion_Reporte() 
		{
			ReportDocument crReportDocument = new ReportDocument();   

            SecureQueryString qs = new SecureQueryString(Context.Request.QueryString["d"]);
            string NomReport = qs["RepName"];
            string TipoReporte = qs["Tipo"];

            //this.Title = NomReport;

            NomReport = NomReport.Replace("/", "\\");
            NomReport = NomReport.Replace("~", ".");
            NomReport = Request.PhysicalApplicationPath + NomReport;

            CrystalReportViewer1.ReportSource = qs["RepName"];
            crReportDocument.Load(NomReport);

            #region switch TipoReporte setea parámetros
            switch (TipoReporte)
            {
                case "LiquidacionPrima":
                case "Liquidacion":
                    NumGrupo = int.Parse(qs["NumGrupo"]);
                    FechaDesde = qs["FechaDesde"];
                    FechaHasta = qs["FechaHasta"];
                    NomUser = qs["Usuario"];

                    crReportDocument.SetParameterValue("@Usuario", NomUser);
                    crReportDocument.SetParameterValue("@NumGrupo", NumGrupo);
                    crReportDocument.SetParameterValue("@FechaPagoDesde", new DateTime(int.Parse(FechaDesde.Substring(0, 4)), int.Parse(FechaDesde.Substring(4, 2)), int.Parse(FechaDesde.Substring(6, 2)))); ;
                    crReportDocument.SetParameterValue("@FechaPagoHasta", new DateTime(int.Parse(FechaHasta.Substring(0, 4)), int.Parse(FechaHasta.Substring(4, 2)), int.Parse(FechaHasta.Substring(6, 2)))); ;
                    break;

                case "Movimiento":
                case "Ejercicio":
                    NumGrupo = int.Parse(qs["NumGrupo"]);
                    NomUser = qs["Usuario"];
                    
                    crReportDocument.SetParameterValue("@NumGrupo", NumGrupo);
                    crReportDocument.SetParameterValue("@Usuario", NomUser);
                    break;

                case "Cartera":
                case "Fax":
                    NumContrato = int.Parse(qs["NumContrato"]);
                    Fecha = qs["Fecha"];
                    NomUser = qs["Usuario"];

                    crReportDocument.SetParameterValue("@Grupo", NumContrato);
                    crReportDocument.SetParameterValue("@Usuario", NomUser);
                    break;

                case "Vanilla":
                case "Asiatica":
                case "Generico":
                    NumContrato = int.Parse(qs["NumContrato"]);
                    NomUser = qs["Usuario"];
                    RutCli01 = int.Parse(qs["RutRepCli01"]);
                    RutCli02 = int.Parse(qs["RutRepCli02"]);
                    RutBan01 = int.Parse(qs["RutRepBan01"]);
                    RutBan02 = int.Parse(qs["RutRepBan02"]);

                    crReportDocument.SetParameterValue("@Usuario", NomUser);
                    crReportDocument.SetParameterValue("@RutRepCli01", RutCli01);
                    crReportDocument.SetParameterValue("@RutRepCli02", RutCli02);
                    crReportDocument.SetParameterValue("@RutRepBan01", RutBan01);
                    crReportDocument.SetParameterValue("@RutRepBan02", RutBan02);
                    crReportDocument.SetParameterValue("@Grupo", NumContrato);
                    break;

                case "CondicionGeneral":
                    Rut = int.Parse(qs["Rut"]);
                    Codigo = int.Parse(qs["Codigo"]);
                    NomUser = qs["Usuario"];
                    RutCli01 = int.Parse(qs["RutRepCli01"]);
                    RutCli02 = int.Parse(qs["RutRepCli02"]);
                    RutBan01 = int.Parse(qs["RutRepBan01"]);
                    RutBan02 = int.Parse(qs["RutRepBan02"]);

                    crReportDocument.SetParameterValue("@CliRut", Rut);
                    crReportDocument.SetParameterValue("@CliCodigo", Codigo);
                    crReportDocument.SetParameterValue("@Usuario", NomUser);
                    crReportDocument.SetParameterValue("@RutRepCli01", RutCli01);
                    crReportDocument.SetParameterValue("@RutRepCli02", RutCli02);
                    crReportDocument.SetParameterValue("@RutRepBan01", RutBan01);
                    crReportDocument.SetParameterValue("@RutRepBan02", RutBan02);
                    break;

                case "ICartera":
                    valor_ = new ParamReportesGenericos
                    {
                        FechaDesde = qs["FechaDesde"] != "" ? qs["FechaDesde"] : "",
                        Usuario = qs["Usuario"],
                        TipoTransac = qs["TipoTransaccion"],
                        NumeroContrato = qs["NumeroContrato"]
                    };

                    crReportDocument.SetParameterValue("@Fecha", DateTime.Parse(valor_.FechaDesde));
                    crReportDocument.SetParameterValue("@Usuario", valor_.Usuario);
                    crReportDocument.SetParameterValue("@TipoTransaccion", valor_.TipoTransac);
                    crReportDocument.SetParameterValue("@NumeroContrato", valor_.NumeroContrato);
                    break; //asvg en desarrollo

                case "ICarteraOpciones":
                case "Voucher":
                case "Balance":
                    valor_ = new ParamReportesGenericos
                    {
                        FechaDesde = qs["FechaDesde"] != "" ? qs["FechaDesde"] : "",
                        Usuario = qs["Usuario"]
                    };

                    crReportDocument.SetParameterValue("@Fecha", DateTime.Parse(valor_.FechaDesde));
                    crReportDocument.SetParameterValue("@Usuario", valor_.Usuario);
                    break;

                case "ListMovFechas":
                    valor_ = new ParamReportesGenericos
                    {
                        FechaDesde = qs["FechaDesde"] != "" ? qs["FechaDesde"] : "",
                        FechaHasta = qs["FechaHasta"] != "" ? qs["FechaHasta"] : "",
                        Usuario = qs["Usuario"],
                        NumeroContrato = qs["NumeroContrato"]
                    };

                    crReportDocument.SetParameterValue("@Tipo", " ");
                    crReportDocument.SetParameterValue("@FechaDesde", DateTime.Parse(valor_.FechaDesde));
                    crReportDocument.SetParameterValue("@FechaHasta", DateTime.Parse(valor_.FechaHasta));
                    crReportDocument.SetParameterValue("@Usuario", valor_.Usuario);
                    crReportDocument.SetParameterValue("@NumeroContrato", "0");
                    break;

                case "ListContrPreci":
                    valor_ = new ParamReportesGenericos
                    {
                        FechaDesde = qs["FechaDesde"] != "" ? qs["FechaDesde"] : "",
                        FechaHasta = qs["FechaHasta"] != "" ? qs["FechaHasta"] : "",
                        Usuario = qs["Usuario"],
                        NumeroContrato = "0"
                    };

                    crReportDocument.SetParameterValue("@Tipo", " ");
                    crReportDocument.SetParameterValue("@FechaDesde", DateTime.Parse(valor_.FechaDesde));
                    crReportDocument.SetParameterValue("@FechaHasta", DateTime.Parse(valor_.FechaHasta));
                    crReportDocument.SetParameterValue("@Usuario", valor_.Usuario);
                    break;

                case "ListAnulaciones":
                    valor_ = new ParamReportesGenericos
                    {
                        FechaDesde = qs["FechaDesde"] != "" ? qs["FechaDesde"] : "",
                        FechaHasta = qs["FechaHasta"] != "" ? qs["FechaHasta"] : "",
                        TipoTransac = qs["TipoTransac"] != "" ? qs["TipoTransac"] : "",
                        Usuario = qs["Usuario"],
                        NumeroContrato = "0"
                    };

                    crReportDocument.SetParameterValue("@Tipo", " ");
                    crReportDocument.SetParameterValue("@FechaDesde", DateTime.Parse(valor_.FechaDesde));
                    crReportDocument.SetParameterValue("@FechaHasta", DateTime.Parse(valor_.FechaHasta));
                    crReportDocument.SetParameterValue("@Usuario", valor_.Usuario);
                    crReportDocument.SetParameterValue("@NumeroContrato", "0");
                    break;

                case "MovPorCta":
                    valor_ = new ParamReportesGenericos
                    {
                        FechaDesde = qs["FechaDesde"] != "" ? qs["FechaDesde"] : "",
                        FechaHasta = qs["FechaHasta"] != "" ? qs["FechaHasta"] : "",
                        Cuenta = qs["Cuenta"] != "" ? qs["Cuenta"] : "",
                        Usuario = qs["Usuario"]
                    };

                    crReportDocument.SetParameterValue("@F1", DateTime.Parse(valor_.FechaDesde));
                    crReportDocument.SetParameterValue("@F2", DateTime.Parse(valor_.FechaHasta));
                    crReportDocument.SetParameterValue("@Usuario", valor_.Usuario);
                    crReportDocument.SetParameterValue("@Cuenta", valor_.Cuenta);
                    break;
                //default:
            }
            #endregion switch TipoReporte setea parámetros

            String _AppConfig = ConnectString(ConfigurationManager.AppSettings["OPCIONES"]);
            char[] _Separator = { ',' };
            
            String[] _Config = _AppConfig.Split(_Separator);

            crConnectionInfo.ServerName = _Config[4].ToString();
            crConnectionInfo.DatabaseName = _Config[5].ToString();
            crConnectionInfo.UserID = _Config[6].ToString();
            crConnectionInfo.Password = _Config[7].ToString();

            crDatabase = crReportDocument.Database;
            crTables = crDatabase.Tables;

			foreach(Table crTable in crTables)
			{
				crTableLogOnInfo = crTable.LogOnInfo;
				crTableLogOnInfo.ConnectionInfo = crConnectionInfo;
				crTable.ApplyLogOnInfo(crTableLogOnInfo);
			}

            CrystalReportViewer1.DisplayPage            = true; //Muestra el reporte.
            CrystalReportViewer1.DisplayStatusbar       = true;
			CrystalReportViewer1.DisplayToolbar         = true; //Muestra los botones para exportar y navegar.
            CrystalReportViewer1.ToolPanelView          = CrystalDecisions.Web.ToolPanelViewType.None; //Contrae el arbol de grupos.

            //CrystalReportViewer1.BestFitPage
            //CrystalReportViewer1.Width                  = 30;
			//CrystalReportViewer1.Height                 = 10;
			//OBSOLETO CrystalReportViewer1.DisplayGroupTree       = false;
            //CrystalReportViewer1.GroupTreeStyle         = CrystalDecisions.Shared.GroupTreeStyle
            
            CrystalReportViewer1.HasRefreshButton       = false;
			CrystalReportViewer1.ReportSource           = crReportDocument;
            CrystalReportViewer1.AllowedExportFormats   = (int)CrystalDecisions.Shared.ViewerExportFormats.PdfFormat + (int)CrystalDecisions.Shared.ViewerExportFormats.WordFormat;

			CrystalReportViewer1.DataBind();
		}

        private static string ConnectString(string connectstring)
        {
            char[] _Separator = { ',' };
            string[] _ListConnect = connectstring.Split(_Separator);
            string _Password = _ListConnect[7];
            string _PasswordDes = AdminOpcionesEncript.Encript.DesEcrypt(_Password);
            connectstring = connectstring.Replace(_Password, _PasswordDes);
            return connectstring;
        }
    }
}