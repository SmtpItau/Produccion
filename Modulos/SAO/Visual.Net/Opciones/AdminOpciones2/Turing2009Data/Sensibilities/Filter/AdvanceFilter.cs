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

    public class AdvanceFilter : InterfaceQuery
    {

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
            _Filter += "SELECT 'ID'                   = id\n";
            _Filter += "     , 'System'               = system\n";
            _Filter += "     , 'BookID'               = bookid\n";
            _Filter += "     , 'PortfolioRulesID'     = portfoliorulesid\n";
            _Filter += "     , 'FinancialPortfolioID' = financialportfolioid\n";
            _Filter += "     , 'ProductID'            = productid\n";
            _Filter += "     , 'OperationNumber'      = operationnumber\n";
            _Filter += "     , 'DocumentNumber'       = documentnumber\n";
            _Filter += "     , 'OperationID'          = operationid\n";
            _Filter += "     , 'FamilyID'             = familyID\n";
            _Filter += "     , 'MnemonicsMask'        = mnemonicsmask\n";
            _Filter += "     , 'Mnemonics'            = mnemonics\n";
            _Filter += "     , 'IssueID'              = issueid\n";
            _Filter += "     , 'CustomerID'           = customerid\n";
            _Filter += "     , 'CustomerCode'         = customercode\n";
            _Filter += "  FROM dbo.SensibilitiesData\n";
            _Filter += " WHERE sensibilitiesdate = '" + date.ToString("yyyyMMdd") + "'\n";
            _Filter += "SET NOCOUNT OFF\n";

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
