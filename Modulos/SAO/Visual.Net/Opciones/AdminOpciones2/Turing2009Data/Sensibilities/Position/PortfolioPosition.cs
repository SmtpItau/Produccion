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

    public class PortfolioPosition : InterfaceQuery
    {

        public DataTable Load(DateTime portFolioDateToday, DateTime portFolioDateYesterday, string conditions)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTPosition;
            string _Position;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTPosition = new DataTable();

            _Position = "";

            #endregion

            #region "Query resumen"

            _Position += "SET NOCOUNT ON\n\n";

            _Position += "DECLARE @DateProcessToday     DATETIME\n";
            _Position += "DECLARE @DateProcessYesterday DATETIME\n\n";

            _Position += "SET @DateProcessToday     = [@DateProcessToday]\n";
            _Position += "SET @DateProcessYesterday = [@DateProcessYesterday]\n\n";

            #region Tabla Detalle

            _Position += "CREATE TABLE #tmpSummaryDetail\n";
            _Position += "       (\n";
            _Position += "         system                           varchar(03)\n";
            _Position += "       , dateprocess                      datetime\n";
            _Position += "       , currency                         int\n";
            _Position += "       , leg                              char(01)\n";
            _Position += "       , marktomarket                     float\n";
            _Position += "       )\n\n";

            #endregion

            #region "Tabla Final"

            _Position += "CREATE TABLE #tmpSummary\n";
            _Position += "       (\n";
            _Position += "         system                           varchar(03) DEFAULT ''\n";
            _Position += "       , currency                         int         DEFAULT 0\n";
            _Position += "       , currencynemo                     varchar(20) DEFAULT ''\n";
            _Position += "       , marktomarketasset                float       DEFAULT 0\n";
            _Position += "       , marktomarketliabilities          float       DEFAULT 0\n";
            _Position += "       , marktomarketassetyesterday       float       DEFAULT 0\n";
            _Position += "       , marktomarketliabilitiesyesterday float       DEFAULT 0\n";
            _Position += "       )\n\n";

            #endregion

            #region "Renta Fija"

            _Position += "-- Renta Fija\n";
            _Position += "INSERT INTO #tmpSummaryDetail\n";
            _Position += "          (\n";
            _Position += "            System\n";
            _Position += "          , dateprocess\n";
            _Position += "          , currency\n";
            _Position += "          , leg\n";
            _Position += "          , marktomarket\n";
            _Position += "          )\n";
            _Position += "     SELECT SD.system\n";
            _Position += "          , SD.sensibilitiesdate\n";
            _Position += "          , SFR.currencyissue\n";
            _Position += "          , 1\n";
            _Position += "          , SUM( CASE WHEN SD.ExpiryDate > SD.sensibilitiesdate THEN SFR.marktomarketvaluetodayum ELSE 0 END )\n";
            _Position += "       FROM dbo.SensibilitiesData                  SD\n";
            _Position += "            INNER JOIN dbo.SensibilitiesFixingRate SFR  ON SD.ID             = SFR.ID\n";
            _Position += "      WHERE SD.sensibilitiesdate         in ( @DateProcessYesterday, @DateProcessToday )\n";
            _Position += "        AND SD.system                     = 'BTR'\n";
            _Position += "[@Conditions]";
            _Position += "      GROUP BY\n";
            _Position += "            SD.system\n";
            _Position += "          , SD.sensibilitiesdate\n";
            _Position += "          , SFR.currencyissue\n\n";

            #endregion

            #region "Forward"

            _Position += "-- Forward\n";

            #region "Forward Moneda Primaria"

            _Position += "-- Forward Moneda Primaria\n";
            _Position += "INSERT INTO #tmpSummaryDetail\n";
            _Position += "          (\n";
            _Position += "            System\n";
            _Position += "          , dateprocess\n";
            _Position += "          , currency\n";
            _Position += "          , leg\n";
            _Position += "          , marktomarket\n";
            _Position += "          )\n";
            _Position += "     SELECT SD.system\n";
            _Position += "          , SD.sensibilitiesdate\n";
            _Position += "          , SD.primarycurrencyid\n";
            _Position += "          , CASE WHEN SF.operationtype = 'C' THEN 1 ELSE 2 END\n";
            _Position += "          , SUM( CASE WHEN SF.paymentType = 'C' AND SF.effectivedate <= SD.sensibilitiesdate THEN 0\n";
            _Position += "                      WHEN SD.ExpiryDate    <= SD.sensibilitiesdate                          THEN 0\n";
            _Position += "                      ELSE CASE WHEN SF.operationtype = 'C' THEN SF.fairvalueassetum         ELSE SF.fairvalueliabilitiesum          END\n";
            _Position += "                 END\n";
            _Position += "               )\n";
            _Position += "       FROM dbo.SensibilitiesData               SD\n";
            _Position += "            INNER JOIN dbo.SensibilitiesForward SF  ON SD.ID            = SF.ID\n";
            _Position += "      WHERE SD.sensibilitiesdate         in ( @DateProcessYesterday, @DateProcessToday )\n";
            _Position += "        AND SD.system                     = 'BFW'\n";
            _Position += "        AND SD.productid                 <> '10'\n";
            _Position += "[@Conditions]";
            _Position += "      GROUP BY\n";
            _Position += "            SD.system\n";
            _Position += "          , SD.sensibilitiesdate\n";
            _Position += "          , SD.primarycurrencyid\n";
            _Position += "          , SF.operationtype\n\n";

            #endregion

            #region "Forward Moneda Secundaria"

            _Position += "-- Forward Moneda Secundaria\n";
            _Position += "INSERT INTO #tmpSummaryDetail\n";
            _Position += "          (\n";
            _Position += "            System\n";
            _Position += "          , dateprocess\n";
            _Position += "          , currency\n";
            _Position += "          , leg\n";
            _Position += "          , marktomarket\n";
            _Position += "          )\n";
            _Position += "     SELECT SD.system\n";
            _Position += "          , SD.sensibilitiesdate\n";
            _Position += "          , SD.secondcurrencyid\n";
            _Position += "          , CASE WHEN SF.operationtype = 'V' THEN 1 ELSE 2 END\n";
            _Position += "          , SUM( CASE WHEN SF.paymentType = 'C' AND SF.effectivedate <= SD.sensibilitiesdate THEN 0\n";
            _Position += "                      WHEN SD.ExpiryDate    <= SD.sensibilitiesdate                          THEN 0\n";
            _Position += "                      ELSE CASE WHEN SF.operationtype = 'V' THEN SF.fairvalueassetum         ELSE SF.fairvalueliabilitiesum          END\n";
            _Position += "                 END\n";
            _Position += "               )\n";
            _Position += "       FROM dbo.SensibilitiesData               SD\n";
            _Position += "            INNER JOIN dbo.SensibilitiesForward SF  ON SD.ID            = SF.ID\n";
            _Position += "      WHERE SD.sensibilitiesdate         in ( @DateProcessYesterday, @DateProcessToday )\n";
            _Position += "        AND SD.system                     = 'BFW'\n";
            _Position += "        AND SD.productid                 <> '10'\n";
            _Position += "[@Conditions]";
            _Position += "      GROUP BY\n";
            _Position += "            SD.system\n";
            _Position += "          , SD.sensibilitiesdate\n";
            _Position += "          , SD.secondcurrencyid\n";
            _Position += "          , SF.operationtype\n\n";

            #endregion

            #region "Forward Bonds Trader"

            _Position += "-- Forward Bonds Trader\n";
            _Position += "INSERT INTO #tmpSummaryDetail\n";
            _Position += "          (\n";
            _Position += "            System\n";
            _Position += "          , dateprocess\n";
            _Position += "          , currency\n";
            _Position += "          , leg\n";
            _Position += "          , marktomarket\n";
            _Position += "          )\n";
            _Position += "     SELECT 'FBT'\n";
            _Position += "          , SD.sensibilitiesdate\n";
            _Position += "          , SFBT.currencyissue\n";
            _Position += "          , CASE WHEN SFBT.operationtype = 'C' THEN 1 ELSE 2 END\n";
            _Position += "          , SUM( CASE WHEN SD.ExpiryDate > SD.sensibilitiesdate THEN SFBT.marktomarketvaluetodayum ELSE 0 END )\n";
            _Position += "       FROM dbo.SensibilitiesData                          SD\n";
            _Position += "            INNER JOIN dbo.SensibilitiesForwardBondsTrader SFBT  ON SD.ID              = SFBT.ID\n";
            _Position += "      WHERE SD.sensibilitiesdate         in ( @DateProcessYesterday, @DateProcessToday )\n";
            _Position += "        AND SD.system                     = 'BFW'\n";
            _Position += "        AND SD.productid                  = '10'\n";
            _Position += "[@Conditions]";
            _Position += "      GROUP BY\n";
            _Position += "            SD.system\n";
            _Position += "          , SD.sensibilitiesdate\n";
            _Position += "          , SFBT.currencyissue\n";
            _Position += "          , SFBT.operationtype\n\n";

            #endregion

            #endregion

            #region "SWAP"

            _Position += "-- SWAP\n";

            #region "Swap Moneda Primaria"

            _Position += "-- Swap Moneda Primaria\n";
            _Position += "INSERT INTO #tmpSummaryDetail\n";
            _Position += "          (\n";
            _Position += "            System\n";
            _Position += "          , dateprocess\n";
            _Position += "          , currency\n";
            _Position += "          , leg\n";
            _Position += "          , marktomarket\n";
            _Position += "          )\n";
            _Position += "     SELECT SD.system\n";
            _Position += "          , SD.sensibilitiesdate\n";
            _Position += "          , SD.primarycurrencyid\n";
            _Position += "          , 1\n";
            _Position += "          , SUM( CASE WHEN SD.ExpiryDate > SD.sensibilitiesdate AND SD.primaryrateid <> 13 THEN SW.fairvalueassetum ELSE 0 END )\n";
            _Position += "       FROM dbo.SensibilitiesData            SD\n";
            _Position += "            INNER JOIN dbo.SensibilitiesSwap SW  ON SD.ID            = SW.ID\n";
            _Position += "      WHERE SD.sensibilitiesdate         in ( @DateProcessYesterday, @DateProcessToday )\n";
            _Position += "        AND SD.system                     = 'PCS'\n";
            _Position += "[@Conditions]";
            _Position += "      GROUP BY\n";
            _Position += "            SD.system\n";
            _Position += "          , SD.sensibilitiesdate\n";
            _Position += "          , SD.primarycurrencyid\n\n";

            #endregion

            #region "Swap Moneda Secundaria"

            _Position += "-- Swap Moneda Secundaria\n";
            _Position += "INSERT INTO #tmpSummaryDetail\n";
            _Position += "          (\n";
            _Position += "            System\n";
            _Position += "          , dateprocess\n";
            _Position += "          , currency\n";
            _Position += "          , leg\n";
            _Position += "          , marktomarket\n";
            _Position += "          )\n";
            _Position += "     SELECT SD.system\n";
            _Position += "          , SD.sensibilitiesdate\n";
            _Position += "          , SD.secondcurrencyid\n";
            _Position += "          , 2\n";
            _Position += "          , SUM( CASE WHEN SD.ExpiryDate > SD.sensibilitiesdate AND SD.secondrateid <> 13 THEN SW.fairvalueliabilitiesum ELSE 0 END )\n";
            _Position += "       FROM dbo.SensibilitiesData            SD\n";
            _Position += "            INNER JOIN dbo.SensibilitiesSwap SW  ON SD.ID            = SW.ID\n";
            _Position += "      WHERE SD.sensibilitiesdate         in ( @DateProcessYesterday, @DateProcessToday )\n";
            _Position += "        AND SD.system                     = 'PCS'\n";
            _Position += "[@Conditions]";
            _Position += "      GROUP BY\n";
            _Position += "            SD.system\n";
            _Position += "          , SD.sensibilitiesdate\n";
            _Position += "          , SD.secondcurrencyid\n\n";

            #endregion

            #endregion

            #region "Resumen"

            _Position += "-- Resumen\n";
            _Position += "INSERT INTO #tmpSummary\n";
            _Position += "          (\n";
            _Position += "            System\n";
            _Position += "          , currency\n";
            _Position += "          , marktomarketasset\n";
            _Position += "          , marktomarketliabilities\n";
            _Position += "          , marktomarketassetyesterday\n";
            _Position += "          , marktomarketliabilitiesyesterday\n";
            _Position += "          )\n";
            _Position += "     SELECT System\n";
            _Position += "          , Currency\n";
            _Position += "          , SUM( CASE WHEN dateprocess = @DateProcessToday     AND leg = 1 THEN marktomarket ELSE 0 END )\n";
            _Position += "          , SUM( CASE WHEN dateprocess = @DateProcessToday     AND leg = 2 THEN marktomarket ELSE 0 END )\n";
            _Position += "          , SUM( CASE WHEN dateprocess = @DateProcessYesterday AND leg = 1 THEN marktomarket ELSE 0 END )\n";
            _Position += "          , SUM( CASE WHEN dateprocess = @DateProcessYesterday AND leg = 2 THEN marktomarket ELSE 0 END )\n";
            _Position += "       FROM #tmpSummaryDetail\n";
            _Position += "      GROUP BY\n";
            _Position += "            System\n";
            _Position += "          , Currency\n\n";

            #endregion

            #region "Actualización de Nemotecnico Moneda"

            _Position += "-- Actualización de Nemotecnico Moneda\n";
            _Position += "UPDATE #tmpSummary\n";
            _Position += "   SET currencynemo = mnnemo\n";
            _Position += "  FROM dbo.MONEDA\n";
            _Position += " WHERE mncodmon     = currency\n\n";

            #endregion

            #region "Query Final"

            _Position += "-- Query Final\n";
            _Position += "SELECT 'System'                  = CASE System WHEN 'BTR' THEN 'RENTA FIJA'\n";
            _Position += "                                               WHEN 'BFW' THEN 'FORWARD   '\n";
            _Position += "                                               WHEN 'FBT' THEN 'FORWARD RF'\n";
            _Position += "                                               WHEN 'PCS' THEN 'SWAP      '\n";
            _Position += "                                                          ELSE '          '\n";
            _Position += "                                   END\n";
            _Position += "     , 'CurrencyNemo'            = currencynemo\n";
            _Position += "     , 'MarkToMarketAsset'       = marktomarketasset\n";
            _Position += "     , 'MarkToMarketLiabilities' = marktomarketliabilities\n";
            _Position += "     , 'MarkToMarketNet'         = CASE WHEN System = 'FBT' THEN MarkToMarketAsset + MarkToMarketLiabilities ELSE MarkToMarketAsset - MarkToMarketLiabilities END\n";
            _Position += "     , 'MarkToMarketAssetYesterday'       = marktomarketassetyesterday\n";
            _Position += "     , 'MarkToMarketLiabilitiesYesterday' = marktomarketliabilitiesyesterday\n";
            _Position += "     , 'MarkToMarketNetYesterday'         = CASE WHEN System = 'FBT' THEN MarkToMarketAssetYesterday + MarkToMarketLiabilitiesYesterday\n";
            _Position += "                                                                     ELSE MarkToMarketAssetYesterday - MarkToMarketLiabilitiesYesterday\n";
            _Position += "                                            END\n";
            _Position += "     , 'MarkToMarketNetDelta'             = ROUND( CASE WHEN System = 'FBT' THEN MarkToMarketAssetYesterday + MarkToMarketLiabilitiesYesterday\n";
            _Position += "                                                                     ELSE MarkToMarketAssetYesterday - MarkToMarketLiabilitiesYesterday\n";
            _Position += "                                            END * (EX1.currencyvaluetoday - EX1.currencyvalueyesterday), 0 )\n";
            _Position += "  FROM #tmpSummary\n";
            _Position += "       INNER JOIN dbo.ExchangeValue EX1  ON EX1.currencydate = @DateProcessToday\n";
            _Position += "                                        AND EX1.currencyid   = CASE WHEN currency = 13 THEN 994 ELSE currency END\n";
            _Position += " ORDER BY\n";
            _Position += "       system\n";
            _Position += "     , currency\n\n";

            #endregion

            #region "Limpieza de Tabla Temporales"

            _Position += "-- Limpieza de Tabla Temporales\n";
            _Position += "DROP TABLE #tmpSummaryDetail\n";
            _Position += "DROP TABLE #tmpSummary\n\n";

            _Position += "SET NOCOUNT ON\n";

            #endregion

            #region "Actualización de Condiciones en los querys definidos"

            if (!conditions.Equals(""))
            {
                _Position = _Position.Replace("[@Conditions]", "        AND (" + conditions + ")\n");
            }
            else
            {
                _Position = _Position.Replace("[@Conditions]", "");
            }

            #endregion

            _Position = _Position.Replace("[@DateProcessToday]", "'" + portFolioDateToday.ToString("yyyyMMdd") + "'");
            _Position = _Position.Replace("[@DateProcessYesterday]", "'" + portFolioDateYesterday.ToString("yyyyMMdd") + "'");

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _Position, "Position");
                _DTPosition = _Connect.Table;
                _Connect.Close();
                _Connect = null;
            }
            catch (Exception _Error)
            {
                _DTPosition = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
                _Connect.Close();
                _Connect = null;
                throw (_Error);
            }

            #endregion

            return _DTPosition;

        }

    }

}
