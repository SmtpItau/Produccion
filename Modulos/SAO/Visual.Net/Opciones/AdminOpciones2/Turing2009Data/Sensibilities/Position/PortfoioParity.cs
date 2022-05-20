using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Turing2009Connect;
using Turing2009Data.Definitions;
using Turing2009Definitions.Definitions;
using Turing2009Definitions.Struct;

namespace Turing2009Data.Sensibilities.Position
{

    public class PortfoioParity : InterfaceQuery
    {

        public DataTable Load(DateTime portFolioDate)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTExchange;
            string _Exchange;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTExchange = new DataTable();

            _Exchange = "";

            #endregion

            #region "Query Swap"

            _Exchange += "SET NOCOUNT ON\n\n";

            _Exchange += "SELECT 'CurrencyID'             = EV.currencyid\n";
            _Exchange += "     , 'CurrencyNemo'           = M.mnnemo\n";
            _Exchange += "     , 'CurrencyValueTorday'    = EV.currencyvaluetoday\n";
            _Exchange += "     , 'CurrencyValueYesterday' = EV.currencyvalueyesterday\n";
            _Exchange += "  FROM dbo.ExchangeValue EV\n";
            _Exchange += "       INNER JOIN dbo.MONEDA M ON EV.currencyid = M.mncodmon\n";
            _Exchange += " WHERE currencydate = '" + portFolioDate.ToString("yyyyMMdd") + "'\n\n";

            _Exchange += "SET NOCOUNT OFF\n";

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _Exchange, "Exchange");
                _DTExchange = _Connect.Table;
                _Connect.Close();
                _Connect = null;
            }
            catch (Exception _Error)
            {
                _DTExchange = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
                _Connect.Close();
                _Connect = null;
                throw (_Error);
            }

            #endregion

            return _DTExchange;

        }

    }
}
