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

    public class RealTimeExchangeRateLoad : InterfaceQuery
    {


        public DataTable Load()
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTRealTimeExchangeRate;
            string _RealTimeExchangeRate;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTRealTimeExchangeRate = new DataTable();

            _RealTimeExchangeRate = "";

            #endregion

            #region "Query"

            _RealTimeExchangeRate += "SET NOCOUNT ON\n";

            _RealTimeExchangeRate += "SELECT 'ID'                  = tCP.id\n";
            _RealTimeExchangeRate += "     , 'Description'         = CASE WHEN tCP.exchangeratetype = 0 THEN CP.mnemonic + '/' + CS.mnemonic ELSE ER.description END\n";
            _RealTimeExchangeRate += "     , 'CurrencyPrimaryID'   = tCP.currencyprimaryid\n";
            _RealTimeExchangeRate += "     , 'CurrencySecondaryID' = tCP.currencysecondaryid\n";
            _RealTimeExchangeRate += "     , 'ExchangeRateType'    = tCP.exchangeratetype\n";
            _RealTimeExchangeRate += "     , 'OperationType'       = tCP.operationtype\n";
            _RealTimeExchangeRate += "  FROM dbo.tblCurrencyPair tCP\n";
            _RealTimeExchangeRate += "       INNER JOIN dbo.tblExchangeRate ER ON  tCP.exchangeratetype  = ER.ID\n";
            _RealTimeExchangeRate += "       INNER JOIN dbo.tblCurrency     CP ON  tCP.currencyprimaryid = CP.ID\n";
            _RealTimeExchangeRate += "       INNER JOIN dbo.tblCurrency     CS ON  tCP.currencyprimaryid = CS.ID\n";

            _RealTimeExchangeRate += "SET NOCOUNT OFF\n";

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _RealTimeExchangeRate, " RealTimeExchangeRate");
                _DTRealTimeExchangeRate = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTRealTimeExchangeRate = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTRealTimeExchangeRate;

        }

        public DataTable Load(DateTime dateProcess, int setPricing)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTRealTimeExchangeRate;
            string _RealTimeExchangeRate;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTRealTimeExchangeRate = new DataTable();

            _RealTimeExchangeRate = "";

            #endregion

            #region "Query"

            _RealTimeExchangeRate += "SET NOCOUNT ON\n";

            _RealTimeExchangeRate += "SELECT 'ExchangeRateID'     = CSP.exchangerateid\n";
            _RealTimeExchangeRate += "     , 'Description'        = ER.description\n";
            _RealTimeExchangeRate += "     , 'ValueBid'           = CSP.valuebid\n";
            _RealTimeExchangeRate += "     , 'ValueAsk'           = CSP.valueask\n";
            _RealTimeExchangeRate += "     , 'ValueMid'           = CSP.valuemid\n";
            _RealTimeExchangeRate += "  FROM dbo.tblCurrencySetPricing      CSP\n";
            _RealTimeExchangeRate += "       INNER JOIN dbo.tblExchangeRate ER   ON CSP.exchangerateid = ER.id\n";
            _RealTimeExchangeRate += " WHERE CSP.exchangeratedate  = '{0}'\n";
            _RealTimeExchangeRate += "   AND CSP.setpricing        = {1}\n";

            _RealTimeExchangeRate += "SET NOCOUNT OFF\n";

            _RealTimeExchangeRate = string.Format(_RealTimeExchangeRate, dateProcess.ToString("yyyyMMdd"), setPricing.ToString());

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _RealTimeExchangeRate, " RealTimeExchangeRate");
                _DTRealTimeExchangeRate = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTRealTimeExchangeRate = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTRealTimeExchangeRate;

        }

        public DataTable Load(DateTime dateProcess)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTRealTimeExchangeRate;
            string _RealTimeExchangeRate;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTRealTimeExchangeRate = new DataTable();

            _RealTimeExchangeRate = "";

            #endregion

            #region "Query"

            _RealTimeExchangeRate += "SET NOCOUNT ON\n\n";

            _RealTimeExchangeRate += "DECLARE @Date         DATETIME\n";
            _RealTimeExchangeRate += "DECLARE @DateDO       DATETIME\n";
            _RealTimeExchangeRate += "DECLARE @CLPUSD       FLOAT\n";
            _RealTimeExchangeRate += "DECLARE @CLPUF        FLOAT\n";
            _RealTimeExchangeRate += "DECLARE @USDEUR       FLOAT\n";
            _RealTimeExchangeRate += "DECLARE @CLPEUR       FLOAT\n";
            _RealTimeExchangeRate += "DECLARE @UFEUR        FLOAT\n";
            _RealTimeExchangeRate += "DECLARE @UFUSD        FLOAT\n\n";

            _RealTimeExchangeRate += "SET @Date = '{0}'\n\n";

            _RealTimeExchangeRate += "CREATE TABLE #tmpParidad\n";
            _RealTimeExchangeRate += "       (\n";
            _RealTimeExchangeRate += "         ExchangeRateID    int\n";
            _RealTimeExchangeRate += "       , Description       varchar(20)\n";
            _RealTimeExchangeRate += "       , ValueBid          float\n";
            _RealTimeExchangeRate += "       , ValueAsk          float\n";
            _RealTimeExchangeRate += "       , ValueMid          float\n";
            _RealTimeExchangeRate += "       )\n\n";

            _RealTimeExchangeRate += "SELECT @CLPUSD        = ISNULL( Tipo_Cambio, 0 )\n";
            _RealTimeExchangeRate += "  FROM Valor_Moneda_Contable\n";
            _RealTimeExchangeRate += " WHERE Fecha          = @Date\n";
            _RealTimeExchangeRate += "   AND Codigo_Moneda  = 994\n\n";

            _RealTimeExchangeRate += "IF @@ROWCOUNT = 0\n";
            _RealTimeExchangeRate += "BEGIN\n";
            _RealTimeExchangeRate += "    SELECT @DateDO         = MAX(Fecha)\n";
            _RealTimeExchangeRate += "      FROM Valor_Moneda_Contable\n";
            _RealTimeExchangeRate += "     WHERE Fecha          < @Date\n";
            _RealTimeExchangeRate += "       AND Codigo_Moneda  = 994\n\n";

            _RealTimeExchangeRate += "    SELECT @CLPUSD        = ISNULL( Tipo_Cambio, 0 )\n";
            _RealTimeExchangeRate += "      FROM Valor_Moneda_Contable\n";
            _RealTimeExchangeRate += "     WHERE Fecha          = @DateDO\n";
            _RealTimeExchangeRate += "       AND Codigo_Moneda  = 994\n\n";

            _RealTimeExchangeRate += "END\n\n";

            _RealTimeExchangeRate += "SELECT @CLPUF         = ISNULL( vmvalor, 0 )\n";
            _RealTimeExchangeRate += "  FROM Valor_Moneda\n";
            _RealTimeExchangeRate += " WHERE vmfecha        = @Date\n";
            _RealTimeExchangeRate += "   AND vmcodigo       = 998\n\n";

            _RealTimeExchangeRate += "SELECT @USDEUR        = ISNULL( vmptacmp, 0 )\n";
            _RealTimeExchangeRate += "  FROM Valor_Moneda\n";
            _RealTimeExchangeRate += " WHERE vmfecha        = @Date\n";
            _RealTimeExchangeRate += "   AND vmcodigo       = 142\n\n";

            _RealTimeExchangeRate += "SET @CLPUSD = ISNULL( @CLPUSD, 0 )\n";
            _RealTimeExchangeRate += "SET @CLPUF  = ISNULL(  @CLPUF, 0 )\n";
            _RealTimeExchangeRate += "SET @USDEUR = ISNULL( @USDEUR, 0 )\n";
            _RealTimeExchangeRate += "SET @CLPEUR = @USDEUR * @CLPUSD\n";
            _RealTimeExchangeRate += "SET @UFUSD  = CASE WHEN @CLPUSD = 0 THEN 0 ELSE @CLPUF / @CLPUSD END\n";
            _RealTimeExchangeRate += "SET @UFEUR  = CASE WHEN @USDEUR = 0 THEN 0 ELSE @CLPUF / @USDEUR END\n\n";

            _RealTimeExchangeRate += "INSERT INTO #tmpParidad VALUES ( 1, 'CLP/USD', @CLPUSD, @CLPUSD, @CLPUSD )\n";
            _RealTimeExchangeRate += "INSERT INTO #tmpParidad VALUES ( 2, 'CLP/EUR', @CLPEUR, @CLPEUR, @CLPEUR )\n";
            _RealTimeExchangeRate += "INSERT INTO #tmpParidad VALUES ( 3,  'CLP/UF',  @CLPUF,  @CLPUF,  @CLPUF )\n";
            _RealTimeExchangeRate += "INSERT INTO #tmpParidad VALUES ( 4, 'USD/EUR', @USDEUR, @USDEUR, @USDEUR )\n";
            _RealTimeExchangeRate += "INSERT INTO #tmpParidad VALUES ( 6,  'USD/UF',  @UFUSD,  @UFUSD,  @UFUSD )\n";
            _RealTimeExchangeRate += "INSERT INTO #tmpParidad VALUES ( 6,  'EUR/UF',  @UFEUR,  @UFEUR,  @UFEUR )\n\n";

            _RealTimeExchangeRate += "SELECT *\n";
            _RealTimeExchangeRate += "  FROM #tmpParidad\n\n";

            _RealTimeExchangeRate += "DROP TABLE #tmpParidad\n\n";

            _RealTimeExchangeRate += "SET NOCOUNT OFF\n";

            _RealTimeExchangeRate = string.Format(_RealTimeExchangeRate, dateProcess.ToString("yyyyMMdd"));

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("BacParamSuda", _RealTimeExchangeRate, " RealTimeExchangeRate");
                _DTRealTimeExchangeRate = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTRealTimeExchangeRate = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTRealTimeExchangeRate;

        }

        public DataTable Load(DateTime dateProcess, int setPricing, int currencyPrimaryID, int currencySecondaryID)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTRealTimeExchangeRate;
            string _RealTimeExchangeRate;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTRealTimeExchangeRate = new DataTable();

            _RealTimeExchangeRate = "";

            #endregion

            #region "Query"

            _RealTimeExchangeRate += "SET NOCOUNT ON\n";

            _RealTimeExchangeRate += "SELECT 'ExchangeRateID'     = CSP.exchangerateid\n";
            _RealTimeExchangeRate += "     , 'Description'        = ER.description\n";
            _RealTimeExchangeRate += "     , 'ValueBid'           = CSP.valuebid\n";
            _RealTimeExchangeRate += "     , 'ValueAsk'           = CSP.valueask\n";
            _RealTimeExchangeRate += "     , 'ValueMid'           = CSP.valuemid\n";
            _RealTimeExchangeRate += "  FROM dbo.tblCurrencySetPricing       CSP\n";
            _RealTimeExchangeRate += "       INNER JOIN dbo.tblCurrency      ERTCP  ON ERTCP.systemid         = {2}\n";
            _RealTimeExchangeRate += "       INNER JOIN dbo.tblCurrency      ERTCS  ON ERTCS.systemid         = {3}\n";
            _RealTimeExchangeRate += "       INNER JOIN dbo.tblCurrencyPair  CP     ON CP.currencyprimaryid   = ERTCP.id\n";
            _RealTimeExchangeRate += "                                             AND CP.currencysecondaryid = ERTCS.id\n";
            _RealTimeExchangeRate += "       INNER JOIN dbo.tblExchangeRate  ER     ON CP.exchangeratetype    = ER.id\n";
            _RealTimeExchangeRate += " WHERE CSP.exchangeratedate = '{0}'\n";
            _RealTimeExchangeRate += "   AND CSP.setpricing       = {1}\n";
            _RealTimeExchangeRate += "   AND CSP.ExchangeRateID   = CP.exchangeratetype\n\n";

            _RealTimeExchangeRate += "SET NOCOUNT OFF\n";

            _RealTimeExchangeRate = string.Format(
                                                   _RealTimeExchangeRate,
                                                   dateProcess.ToString("yyyyMMdd"),
                                                   setPricing.ToString(),
                                                   currencyPrimaryID.ToString(),
                                                   currencySecondaryID.ToString()
                                                 );

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _RealTimeExchangeRate, " RealTimeExchangeRate");
                _DTRealTimeExchangeRate = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTRealTimeExchangeRate = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTRealTimeExchangeRate;

        }



    }
}
