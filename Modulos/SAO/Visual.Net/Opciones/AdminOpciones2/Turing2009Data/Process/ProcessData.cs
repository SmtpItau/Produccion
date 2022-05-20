using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Xml.Linq;
using Turing2009Connect;
using Turing2009Data.Definitions;
using Turing2009Definitions.Definitions;
using Turing2009Definitions.Struct;

namespace Turing2009Data.Process
{

    public class ProcessData : InterfaceQuery
    {

        public DataTable LoadProcess(DateTime dateProcess)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTStatus;
            string _Status;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTStatus = new DataTable();

            _Status = "";

            #endregion

            #region "Query"

            _Status += "SET NOCOUNT ON\n\n";

            _Status += "SELECT 'ID'                 = SS.id\n";
            _Status += "     , 'DateStatus'         = SS.datestatus\n";
            _Status += "     , 'PortfolioYesterday' = SS.portfolioyesterday\n";
            _Status += "     , 'PortfolioToday'     = SS.portfoliotoday\n";
            _Status += "     , 'PortfolioTomorrow'  = SS.portfoliotomorrow\n";
            _Status += "     , 'StartingDate'       = CONVERT( varchar(10), SS.startingdate, 103 )\n";
            _Status += "     , 'Status'             = SS.status\n";
            _Status += "     , 'UserID'             = SS.userid\n";
            _Status += "     , 'UserName'           = UT.name\n";
            _Status += "  FROM dbo.StatusSystem         SS\n";
            _Status += "       INNER JOIN dbo.UserTable UT on userid = UT.id\n";
            _Status += " WHERE SS.datestatus        = '{0}'\n\n";

            _Status += "SET NOCOUNT OFF\n";

            _Status = string.Format(_Status, dateProcess.ToString("yyyyMMdd"));

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("TURING", _Status, "DateStatus");
                _DTStatus = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTStatus = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTStatus;

        }

        public DataTable LoadProduct(DateTime dateProcess)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTStatus;
            string _Status;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTStatus = new DataTable();

            _Status = "";

            #endregion

            #region "Query"

            _Status += "SET NOCOUNT ON\n\n";
            _Status += "SELECT 'ID'               = LSP.ID\n";
            _Status += "     , 'DateLog'          = convert( varchar(10), LSP.datelog, 103 )\n";
            _Status += "     , 'ProcessID'        = LSP.processid\n";
            _Status += "     , 'StartingDate'     = convert( varchar(20), LSP.startingdate, 114 )\n";
            _Status += "     , 'FinishDate'       = convert( varchar(20), case when LSP.status = 1 then getdate() else LSP.finishdate end, 114 )\n";
            _Status += "     , 'TimeProcess'      = convert( varchar(20), case when LSP.status = 1 then getdate() else LSP.finishdate end - LSP.startingdate, 114 )\n";
            _Status += "     , 'StartingSaveDate' = convert( varchar(20), case when LSP.status = 1 then getdate() - getdate() else LSP.startingsavedate end, 114 )\n";
            _Status += "     , 'FinishSaveDate'   = convert( varchar(20), case when LSP.status = 1 then getdate() - getdate() when LSP.status = 2  then getdate() else LSP.finishsavedate end, 114 )\n";
            _Status += "     , 'TimeSave'         = convert( varchar(20), case when LSP.status = 1 then getdate() - getdate() else case when LSP.status = 2  then getdate() else LSP.finishsavedate end - LSP.startingsavedate end, 114 )\n";
            _Status += "     , 'TotalTime'        = convert( varchar(20), case when LSP.status <> 0 then getdate()  - LSP.startingdate \n";
            _Status += "                                                                        else LSP.finishsavedate - LSP.startingdate end, 114 )\n";
            _Status += "     , 'Status'           = LSP.status\n";
            _Status += "     , 'UserID'           = LSP.userid\n";
            _Status += "     , 'UserName'         = UT.name\n";
            _Status += "  FROM dbo.LogStatusProcess     LSP WITH(NOLOCK)\n";
            _Status += "       INNER JOIN dbo.usertable UT  WITH(NOLOCK)  on LSP.userid = UT.id\n";
            _Status += " WHERE LSP.datelog    = '{0}'\n";
            _Status += " ORDER BY LSP.processid\n\n";
            _Status += "SET NOCOUNT OFF\n";

            _Status = string.Format(_Status, dateProcess.ToString("yyyyMMdd"));

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("TURING", _Status, "ProcessStatus");
                _DTStatus = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTStatus = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTStatus;

        }

    }

}
