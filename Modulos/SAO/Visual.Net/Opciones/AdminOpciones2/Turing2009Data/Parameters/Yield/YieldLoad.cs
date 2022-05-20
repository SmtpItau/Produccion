using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Turing2009Connect;
using Turing2009Data.Definitions;
using Turing2009Definitions.Definitions;
using Turing2009Definitions.Struct;

namespace Turing2009Data.Parameters.Yield
{

    public class YieldLoad : InterfaceQuery
    {

        public DataTable Load(DateTime dateProcess, string yieldName, int setPricing)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTYield;
            string _Yield;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTYield = new DataTable();

            _Yield = "";

            #endregion

            #region "Query"

            // {0} dateProcess
            // {1} yieldName
            // {2} setPricing

            _Yield += "SET NOCOUNT ON\n";
            _Yield += "SELECT 'TENOR'       = tenor\n";
            _Yield += "     , 'BID'         = valuebid\n";
            _Yield += "     , 'ASK'         = valueask\n";
            _Yield += "     , 'MIDDLE'      = valuemid\n";
            _Yield += "  FROM dbo.tblYieldSetPricing\n";
            _Yield += " WHERE yielddate     = '{0}'\n";
            _Yield += "   AND yieldname     = '{1}'\n";
            _Yield += "   AND setpricing    = {2}\n";
            _Yield += "SET NOCOUNT OFF\n";

            _Yield = string.Format(_Yield, dateProcess.ToString("yyyyMMdd"), yieldName, setPricing.ToString());

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _Yield, "YieldData");
                _DTYield = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTYield = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTYield;
        }

        public DataTable Load(int system)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTYield;
            string _Yield;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTYield = new DataTable();

            _Yield = "";

            #endregion

            #region "Query"

            _Yield += "SELECT 'ID'                  = id\n";
            _Yield += "     , 'SystemID'            = system\n";
            _Yield += "     , 'RateID'              = rateid\n";
            _Yield += "     , 'CurrencyPrimaryID'   = currencyprimaryid\n";
            _Yield += "     , 'CurrencySecondaryID' = currencysecondaryid\n";
            _Yield += "     , 'YieldNameProjected'  = yieldnameprojected\n";
            _Yield += "     , 'YieldNameDiscount'   = yieldnamediscount\n";
            _Yield += "     , 'TermBenchMark'       = termbenchmark\n";
            _Yield += "  FROM dbo.tblYieldConfig\n";
            _Yield += " WHERE system                = {0}\n";

            _Yield = string.Format(_Yield, system);

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _Yield, "YieldConfig");
                _DTYield = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTYield = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTYield;

        }

        public DataTable Load(string yieldname, DateTime date)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTYield;
            string _Yield;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTYield = new DataTable();

            _Yield = "";

            #endregion

            #region "Query"

            _Yield += "SET NOCOUNT ON\n\n";

            _Yield += "DECLARE @Date         DATETIME\n";
            _Yield += "DECLARE @DateMax      DATETIME\n";
            _Yield += "DECLARE @YieldName    VARCHAR(20)\n\n";

            _Yield += "SET @Date      = '{1}'\n";
            _Yield += "SET @YieldName = '{0}'\n\n";

            _Yield += "SELECT @DateMax         = MAX(FechaGeneracion)\n";
            _Yield += "  FROM dbo.curvas\n";
            _Yield += " WHERE CodigoCurva      = @YieldName\n";
            _Yield += "   AND Tipo in ( '', 'CERO' )\n\n";

            _Yield += "IF (@DateMax < @Date)\n";
            _Yield += "BEGIN\n";
            _Yield += "    SET @Date = @DateMax\n\n";

            _Yield += "END\n\n";

            _Yield += "SELECT FechaGeneracion, 'TENOR'          = Dias\n";
            _Yield += "     , 'BID'            = ValorBid\n";
            _Yield += "     , 'ASK'            = ValorAsk\n";
            _Yield += "     , 'MIDDLE'         = (ValorAsk + ValorBid) / 2\n";
            _Yield += "  FROM dbo.curvas\n";
            _Yield += " WHERE FechaGeneracion  = @Date\n";
            _Yield += "   AND CodigoCurva      = @YieldName\n";
            _Yield += "   AND Tipo            in ( '', 'CERO' )\n\n";

            _Yield += "SET NOCOUNT OFF\n";

            _Yield = string.Format(_Yield, yieldname, date.ToString("yyyyMMdd"));

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("BACPARAMSUDA", _Yield, "YieldData");
                _DTYield = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTYield = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTYield;

        }

    }

}
