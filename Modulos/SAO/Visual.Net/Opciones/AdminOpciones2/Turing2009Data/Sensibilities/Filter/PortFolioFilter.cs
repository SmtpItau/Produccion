using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Turing2009Connect;
using Turing2009Data.Definitions;
using Turing2009Definitions.Definitions;
using Turing2009Definitions.Struct;

namespace Turing2009Data.Sensibilities.Filter
{

    public class PortFolioFilter : InterfaceQuery
    {

        public DataTable Load()
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTFilter;
            string _Filter;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTFilter = new DataTable();

            _Filter = "";

            #endregion

            #region "Query"

            _Filter += "SET NOCOUNT ON\n";
            _Filter += "SELECT 'ID' = FS.ID\n";
            _Filter += "     , 'FilterID'    = FS.filterid\n";
            _Filter += "     , 'Description' = FS.description\n";
            _Filter += "     , 'PatherID'    = FS.patherid\n";
            _Filter += "     , 'Conditions' = ISNULL( FC.conditions, '' )\n";
            _Filter += "  FROM dbo.FilterSensibilities FS\n";
            _Filter += "       LEFT JOIN dbo.FilterConditions FC ON FS.filter = FC.id\n";
            _Filter += "SET NOCOUNT OFF\n";

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _Filter, "Filter");
                _DTFilter = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTFilter = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTFilter;

        }

        public DataTable Load(DateTime date)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTFilter;
            string _Filter;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTFilter = new DataTable();

            _Filter = "";

            #endregion

            #region "Query"

            _Filter += "SET NOCOUNT ON\n";
            _Filter += "SELECT 'ID'                          = SD.id\n";
            _Filter += "     , 'System'                      = SD.System\n";
            _Filter += "     , 'FamilyID'                    = SD.familyid\n";
            _Filter += "     , 'MNemonicsMask'               = SD.mnemonicsmask\n";
            _Filter += "     , 'MNemonics'                   = SD.mnemonics\n";
            _Filter += "     , 'BookID'                      = SD.bookid\n";
            _Filter += "     , 'PortFolioRulesID'            = SD.portfoliorulesid\n";
            _Filter += "     , 'FinancialPortFolioID'        = SD.financialportfolioid\n";
            _Filter += "     , 'ProductID'                   = CASE WHEN SD.productid <> 'CP' AND SYSTEM = 'BTR' THEN 'CP' ELSE SD.productid END\n";
            _Filter += "     , 'IssueID'                     = SD.issueid\n";
            _Filter += "     , 'IssueName'                   = ISNULL( E.emgeneric, '' )\n";
            _Filter += "     , 'OperationNumber'             = SD.operationnumber\n";
            _Filter += "     , 'OperationID'                 = SD.operationid\n";
            _Filter += "     , 'CustomerName'                = RTRIM(ISNULL( C.clnombre, '' ))\n";
            _Filter += "  FROM dbo.SensibilitiesData                SD\n";
            _Filter += "       LEFT JOIN cliente                    C      ON C.clrut                              = SD.CustomerID\n";
            _Filter += "                                                  AND C.clcodigo                           = SD.CustomerCode\n";
            _Filter += "       LEFT JOIN emisor                     E      ON E.emrut                              = SD.issueid\n";
            _Filter += " WHERE SD.sensibilitiesdate          = '{0}'\n";
            _Filter += " ORDER BY\n";
            _Filter += "       SD.System\n";
            _Filter += "     , MNemonicsMask\n";
            _Filter += "     , SD.OperationNumber\n";
            _Filter += "     , SD.OperationID\n";
            _Filter += "SET NOCOUNT OFF\n";

            _Filter = string.Format(_Filter, date.ToString("yyyyMMdd"));

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _Filter, "FilterData");
                _DTFilter = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTFilter = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTFilter;

        }

    }

}
