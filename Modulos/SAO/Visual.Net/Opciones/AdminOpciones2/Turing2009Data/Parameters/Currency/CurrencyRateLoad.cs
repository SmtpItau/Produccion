using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Turing2009Connect;
using Turing2009Data.Definitions;
using Turing2009Definitions.Definitions;
using Turing2009Definitions.Struct;

namespace Turing2009Data.Parameters.Currency
{

    public class CurrencyRateLoad : InterfaceQuery
    {

        public DataTable Load()
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTCurrencyRate;
            string _CurrencyRate;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTCurrencyRate = new DataTable();

            _CurrencyRate = "";

            #endregion

            #region "Query"

            _CurrencyRate += "SET NOCOUNT ON\n";
            _CurrencyRate += "SELECT 'ID'         = RC.id\n";
            _CurrencyRate += "     , 'CurrencyID' = RC.currencyid\n";
            _CurrencyRate += "     , 'RateID'     = RC.rateid\n";
            _CurrencyRate += "  FROM dbo.tblRateCurrency         RC\n";
            _CurrencyRate += "SET NOCOUNT OFF\n";

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _CurrencyRate, "CurrencyRate");
                _DTCurrencyRate = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTCurrencyRate = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTCurrencyRate;

        }

    }

}
