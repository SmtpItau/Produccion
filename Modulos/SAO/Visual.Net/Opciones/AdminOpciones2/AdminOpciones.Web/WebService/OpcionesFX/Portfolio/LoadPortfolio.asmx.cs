using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using cData.Parameters;
using System.Data;

namespace AdminOpciones.Web.WebService.OpcionesFX.Portfolio
{
    /// <summary>
    /// Descripción breve de LoadPortfolio
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class LoadPortfolio : System.Web.Services.WebService
    {

        [WebMethod]
        public string getPortfolioAndBook(string Username)  // PRD-3162
        {
            TuringData _DataPorfTolio = new TuringData();

            DataSet _DataSet = new DataSet();

            _DataSet = _DataPorfTolio.LoadBookAndPortfolio(Username);  // PRD-3162

            DataTable _DataTable = new DataTable();

           
            _DataTable = _DataSet.Tables["Book"];

            string RetuenValue = "<PortfolioAndBook>\n";

            for (int i = 0; i < _DataTable.Rows.Count; i++)
            {
                RetuenValue += "<BookData Codigo='" + _DataTable.Rows[i]["Codigo"].ToString().TrimEnd() + "' " +
                                          "Descripcion='" + _DataTable.Rows[i]["Descripcion"].ToString().TrimEnd() + "'/>\n"; 
            }

            _DataTable = _DataSet.Tables["FinancialPortFolio"];
            for (int i = 0; i < _DataTable.Rows.Count; i++)
            {
                RetuenValue += "<FinancialPortFolioData Codigo='" + _DataTable.Rows[i]["Codigo"].ToString().TrimEnd() + "' " +
                                          "Descripcion='" + _DataTable.Rows[i]["Descripcion"].ToString().TrimEnd() + "'/>\n";
            }

            _DataTable = _DataSet.Tables["PortFolioRules"];
            for (int i = 0; i < _DataTable.Rows.Count; i++)
            {
                RetuenValue += "<PortFolioRulesData Codigo='" + _DataTable.Rows[i]["Codigo"].ToString().TrimEnd() + "' " +
                                          "Descripcion='" + _DataTable.Rows[i]["Descripcion"].ToString().TrimEnd() + "'/>\n";
            }

            _DataTable = _DataSet.Tables["SubPortFolioRules"];
            for (int i = 0; i < _DataTable.Rows.Count; i++)
            {
                RetuenValue += "<SubPortFolioRulesData Codigo='" + _DataTable.Rows[i]["Codigo"].ToString().TrimEnd() + "' " +
                                          "Descripcion='" + _DataTable.Rows[i]["Descripcion"].ToString().TrimEnd() + "'/>\n";
            }

            //PRD-3162
            _DataTable = _DataSet.Tables["ConfiguracionPortFolio"];
            for (int i = 0; i < _DataTable.Rows.Count; i++)
            {
                RetuenValue += "<ConfiguracionPortFolioData Usuario='" + _DataTable.Rows[i]["Usuario"].ToString().TrimEnd() + "' " +
                                                "LibroCod='" + _DataTable.Rows[i]["LibroCod"].ToString().TrimEnd() + "' " +
                                                "LibroDsc='" + _DataTable.Rows[i]["LibroDsc"].ToString().TrimEnd() + "' " +
                                                "CarteraNormativaCod='" + _DataTable.Rows[i]["CarteraNormativaCod"].ToString().TrimEnd() + "' " +
                                                "CarteraNormativaDsc='" + _DataTable.Rows[i]["CarteraNormativaDsc"].ToString().TrimEnd() + "' " +
                                                "SubCarteraNormativaCod='" + _DataTable.Rows[i]["SubCarteraNormativaCod"].ToString().TrimEnd() + "' " +
                                                "SubCarteraNormativaDsc='" + _DataTable.Rows[i]["SubCarteraNormativaDsc"].ToString().TrimEnd() + "' " +
                                                "Prioridad='" + _DataTable.Rows[i]["Prioridad"].ToString().TrimEnd() + "'/>\n";
            }

            _DataTable = _DataSet.Tables["FinancialPortFolioPrioridad"];
            for (int i = 0; i < _DataTable.Rows.Count; i++)
            {
                RetuenValue += "<FinancialPortFolioPrioridadData Codigo='" + _DataTable.Rows[i]["Codigo"].ToString().TrimEnd() + "' " +
                                          "Descripcion='" + _DataTable.Rows[i]["Descripcion"].ToString().TrimEnd() + "' " +
                                          "Prioridad='" + _DataTable.Rows[i]["Prioridad"].ToString().TrimEnd() + "'/>\n";
            }



            RetuenValue += "</PortfolioAndBook>";
            return RetuenValue;
        }

        [WebMethod]
        public string getPortfolioAndBookAll()  // PRD-3162
        {

            TuringData _DataPorfTolio = new TuringData();

            DataSet _DataSet = new DataSet();

            _DataSet = _DataPorfTolio.LoadBookAndPortfolio();

            DataTable _DataTable = new DataTable();

           
            _DataTable = _DataSet.Tables["Book"];

            string RetuenValue = "<PortfolioAndBook>\n";

            for (int i = 0; i < _DataTable.Rows.Count; i++)
            {
                RetuenValue += "<BookData Codigo='" + _DataTable.Rows[i]["Codigo"].ToString().TrimEnd() + "' " +
                                          "Descripcion='" + _DataTable.Rows[i]["Descripcion"].ToString().TrimEnd() + "'/>\n"; 
            }

            _DataTable = _DataSet.Tables["FinancialPortFolio"];
            for (int i = 0; i < _DataTable.Rows.Count; i++)
            {
                RetuenValue += "<FinancialPortFolioData Codigo='" + _DataTable.Rows[i]["Codigo"].ToString().TrimEnd() + "' " +
                                          "Descripcion='" + _DataTable.Rows[i]["Descripcion"].ToString().TrimEnd() + "'/>\n";
            }

            _DataTable = _DataSet.Tables["PortFolioRules"];
            for (int i = 0; i < _DataTable.Rows.Count; i++)
            {
                RetuenValue += "<PortFolioRulesData Codigo='" + _DataTable.Rows[i]["Codigo"].ToString().TrimEnd() + "' " +
                                          "Descripcion='" + _DataTable.Rows[i]["Descripcion"].ToString().TrimEnd() + "'/>\n";
            }

            _DataTable = _DataSet.Tables["SubPortFolioRules"];
            for (int i = 0; i < _DataTable.Rows.Count; i++)
            {
                RetuenValue += "<SubPortFolioRulesData Codigo='" + _DataTable.Rows[i]["Codigo"].ToString().TrimEnd() + "' " +
                                          "Descripcion='" + _DataTable.Rows[i]["Descripcion"].ToString().TrimEnd() + "'/>\n";
            }

            //PRD-3162
            _DataTable = _DataSet.Tables["ConfiguracionPortFolio"];
            for (int i = 0; i < _DataTable.Rows.Count; i++)
            {
                RetuenValue += "<ConfiguracionPortFolioData Usuario='" + _DataTable.Rows[i]["Usuario"].ToString().TrimEnd() + "' " +
                                                "LibroCod='" + _DataTable.Rows[i]["LibroCod"].ToString().TrimEnd() + "' " +
                                                "LibroDsc='" + _DataTable.Rows[i]["LibroDsc"].ToString().TrimEnd() + "' " +
                                                "CarteraNormativaCod='" + _DataTable.Rows[i]["CarteraNormativaCod"].ToString().TrimEnd() + "' " +
                                                "CarteraNormativaDsc='" + _DataTable.Rows[i]["CarteraNormativaDsc"].ToString().TrimEnd() + "' " +
                                                "SubCarteraNormativaCod='" + _DataTable.Rows[i]["SubCarteraNormativaCod"].ToString().TrimEnd() + "' " +
                                                "SubCarteraNormativaDsc='" + _DataTable.Rows[i]["SubCarteraNormativaDsc"].ToString().TrimEnd() + "' " +
                                                "Prioridad='" + _DataTable.Rows[i]["Prioridad"].ToString().TrimEnd() + "'/>\n";
            }

            _DataTable = _DataSet.Tables["FinancialPortFolioPrioridad"];
            for (int i = 0; i < _DataTable.Rows.Count; i++)
            {
                RetuenValue += "<FinancialPortFolioPrioridadData Codigo='" + _DataTable.Rows[i]["Codigo"].ToString().TrimEnd() + "' " +
                                          "Descripcion='" + _DataTable.Rows[i]["Descripcion"].ToString().TrimEnd() + "' " +
                                          "Prioridad='" + _DataTable.Rows[i]["Prioridad"].ToString().TrimEnd() + "'/>\n";
            }



            RetuenValue += "</PortfolioAndBook>";
            return RetuenValue;
        }
    }
}
