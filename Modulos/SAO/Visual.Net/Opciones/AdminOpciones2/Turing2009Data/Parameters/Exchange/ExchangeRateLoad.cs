using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Turing2009Connect;
using Turing2009Data.Definitions;
using Turing2009Definitions.Definitions;
using Turing2009Definitions.Struct;

namespace Turing2009Data.Parameters.Exchange
{

    public class ExchangeRateLoad : InterfaceQuery
    {

        public DataTable Load()
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTExchangeRate;
            string _ExchangeRate;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTExchangeRate = new DataTable();

            _ExchangeRate = "";

            #endregion

            #region "Query"

            _ExchangeRate += "SET NOCOUNT ON\n";
            _ExchangeRate += "SELECT 'ID'                  = TCR.id\n";
            _ExchangeRate += "     , 'CcurrencyPrimaryID'  = TCR.currencyprimaryid\n";
            _ExchangeRate += "     , 'CurrencySecondaryID' = TCR.currencysecondaryid\n";
            _ExchangeRate += "     , 'ExchangeRateType'    = TCR.exchangeratetype\n";
            _ExchangeRate += "     , 'Description'         = TER.description\n";
            _ExchangeRate += "     , 'OperationType'       = TCR.operationtype\n";
            _ExchangeRate += "  FROM dbo.tblCurrencyPair TCR\n";
            _ExchangeRate += "       INNER JOIN dbo.tblExchangeRate TER ON TCR.exchangeratetype = TER.ID\n";
            _ExchangeRate += "SET NOCOUNT OFF\n";

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _ExchangeRate, "ExchangeRate");
                _DTExchangeRate = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTExchangeRate = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTExchangeRate;
        }

        public DataTable Load(DateTime dateProcess, enumSourceExchangeRate sourceExchangeRate)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTExchangeRate;
            string _ExchangeRate;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTExchangeRate = new DataTable();

            _ExchangeRate = "";

            #endregion

            #region "Query"

            switch (sourceExchangeRate)
            {
                case enumSourceExchangeRate.OriginalSystem:
                    _ExchangeRate += "SET NOCOUNT ON\n";
                    _ExchangeRate += "SELECT 'CurrencyID'   = vmcodigo\n";
                    _ExchangeRate += "     , 'MNemonics'    = mnnemo\n";
                    _ExchangeRate += "     , 'ExhangeRate'  = CASE WHEN vmcodigo = 994 or vmcodigo = 998 THEN vmvalor ELSE vmptacmp END\n";
                    _ExchangeRate += "     , 'PurchaseSpot' = vmptacmp\n";
                    _ExchangeRate += "     , 'SaleSpot'     = vmptavta\n";
                    _ExchangeRate += "  FROM VALOR_MONEDA\n";
                    _ExchangeRate += "       INNER JOIN MONEDA  M on M.mncodmon = vmcodigo\n";
                    _ExchangeRate += " WHERE vmfecha    = '{0}'\n";
                    _ExchangeRate += "SET NOCOUNT OFF\n";
                    break;

                case enumSourceExchangeRate.OriginalSystemAccount:
                    _ExchangeRate += "SET NOCOUNT ON\n";
                    _ExchangeRate += "SELECT 'CurrencyID'   = Codigo_Moneda\n";
                    _ExchangeRate += "     , 'MNemonics'    = Nemo_Moneda\n";
                    _ExchangeRate += "     , 'ExhangeRate'  = Tipo_Cambio\n";
                    _ExchangeRate += "     , 'PurchaseSpot' = SpotCompra\n";
                    _ExchangeRate += "     , 'SaleSpot'     = SpotVenta\n";
                    _ExchangeRate += "  FROM VALOR_MONEDA_CONTABLE\n";
                    _ExchangeRate += " WHERE fecha    = '{0}'\n";
                    _ExchangeRate += "SET NOCOUNT ON\n";
                    break;
            }

            // {0} dateProcess.ToString("yyyyMMdd")
            _ExchangeRate = string.Format(_ExchangeRate, dateProcess.ToString("yyyyMMdd"));

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("BACPARAMSUDA", _ExchangeRate, "ExchangeRate");
                _DTExchangeRate = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTExchangeRate = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTExchangeRate;
        }

        public DataTable Load(DateTime dateProcess, int currencyID)
        {
            if (currencyID.Equals(998))
            {
                return Load(dateProcess, currencyID, enumSourceExchangeRate.OriginalSystem);
            }
            else
            {
                return Load(dateProcess, currencyID, enumSourceExchangeRate.OriginalSystemAccount);
            }
        }

        public DataTable Load(DateTime dateProcess, int currencyID, enumSourceExchangeRate sourceExchangeRate)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTExchangeRate;
            string _ExchangeRate;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTExchangeRate = new DataTable();

            _ExchangeRate = "";

            #endregion

            #region "Query"

            _ExchangeRate += "SET NOCOUNT ON\n";

            if (sourceExchangeRate == enumSourceExchangeRate.OriginalSystemAccount)
            {
                _ExchangeRate += "SELECT 'CurrencyID'   = Codigo_Moneda\n";
                _ExchangeRate += "     , 'MNemonics'    = Nemo_Moneda\n";
                _ExchangeRate += "     , 'ExhangeRate'  = Tipo_Cambio\n";
                _ExchangeRate += "     , 'PurchaseSpot' = SpotCompra\n";
                _ExchangeRate += "     , 'SaleSpot'     = SpotVenta\n";
                _ExchangeRate += "  FROM VALOR_MONEDA_CONTABLE\n";
                _ExchangeRate += " WHERE fecha          = '{0}'\n";
                _ExchangeRate += "   AND Codigo_Moneda  = {1}\n";
            }
            else
            {
                _ExchangeRate += "SELECT 'CurrencyID'   = vmcodigo\n";
                _ExchangeRate += "     , 'MNemonics'    = mnnemo\n";
                _ExchangeRate += "     , 'ExhangeRate'  = vmvalor\n";
                _ExchangeRate += "     , 'PurchaseSpot' = vmptacmp\n";
                _ExchangeRate += "     , 'SaleSpot'     = vmptavta\n";
                _ExchangeRate += "  FROM VALOR_MONEDA\n";
                _ExchangeRate += "       INNER JOIN MONEDA  M on M.mncodmon = vmcodigo\n";
                _ExchangeRate += " WHERE vmfecha        = '{0}'\n";
                _ExchangeRate += "   AND vmcodigo       = {1}\n";
            }

            _ExchangeRate += "SET NOCOUNT OFF\n";

            _ExchangeRate = string.Format(_ExchangeRate, dateProcess.ToString("yyyyMMdd"), currencyID.ToString());

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("BACPARAMSUDA", _ExchangeRate, "ExchangeRate");
                _DTExchangeRate = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTExchangeRate = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTExchangeRate;
        }

    }

}
