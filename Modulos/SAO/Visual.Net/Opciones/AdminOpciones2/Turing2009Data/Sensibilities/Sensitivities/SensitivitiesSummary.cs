using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Turing2009Connect;
using Turing2009Data.Definitions;
using Turing2009Definitions.Definitions;
using Turing2009Definitions.Struct;

namespace Turing2009Data.Sensibilities.Sensitivities
{

    public class SensitivitiesSummary : InterfaceQuery
    {

        public DataTable Load(DateTime portFolioDate, string conditions)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTSummary;
            string _Summary;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTSummary = new DataTable();

            _Summary = "";

            #endregion

            #region "Query Fixing Rate"

            _Summary += "DECLARE @DateProcess                DATETIME\n\n";

            _Summary += "SET @DateProcess = [@DateProcess]\n\n";

            _Summary += "SELECT 'DetailID'               = ID\n";
            _Summary += "     , 'System'                 = system\n";
            _Summary += "     , 'Family'                 = FamilyID\n";
            _Summary += "     , 'ProductID'              = productid\n";
            _Summary += "     , 'ContractDate'           = GETDATE()\n";
            _Summary += "     , 'OperationNumber'        = OperationNumber\n";
            _Summary += "     , 'DocumentNumber'         = DocumentNumber\n";
            _Summary += "     , 'OperationID'            = OperationID\n";
            _Summary += "  INTO #tmpSensibilitiesData\n";
            _Summary += "  FROM dbo.SensibilitiesData sd\n";
            _Summary += " WHERE sensibilitiesdate        = @DateProcess\n";

            if (!conditions.Equals(""))
            {
                _Summary += " AND (" + conditions + ")\n";
            }

            _Summary += "\n";

            _Summary += "UPDATE #tmpSensibilitiesData\n";
            _Summary += "   SET ContractDate = SFR.contractdate\n";
            _Summary += "  FROM dbo.SensibilitiesFixingRate SFR,\n";
            _Summary += "       #tmpSensibilitiesData       SD\n";
            _Summary += " WHERE ID           = DetailID\n\n";

            _Summary += "UPDATE #tmpSensibilitiesData\n";
            _Summary += "   SET ContractDate = SF.contractdate\n";
            _Summary += "  FROM dbo.SensibilitiesForward    SF,\n";
            _Summary += "       #tmpSensibilitiesData       SD\n";
            _Summary += " WHERE ID           = DetailID\n\n";

            _Summary += "UPDATE #tmpSensibilitiesData\n";
            _Summary += "   SET ContractDate = SFBT.contractdate\n";
            _Summary += "  FROM dbo.SensibilitiesForwardBondsTrader SFBT,\n";
            _Summary += "       #tmpSensibilitiesData       SD\n";
            _Summary += " WHERE ID           = DetailID\n\n";

            _Summary += "UPDATE #tmpSensibilitiesData\n";
            _Summary += "   SET ContractDate = SW.contractdate\n";
            _Summary += "  FROM dbo.SensibilitiesSwap SW,\n";
            _Summary += "       #tmpSensibilitiesData SD\n";
            _Summary += " WHERE ID           = DetailID\n\n";

            _Summary += "SELECT 'YieldName'                 = SY.yieldname\n";
            _Summary += "     , 'System'                    = SY.[system]\n";
            _Summary += "     , 'Family'                    = SY.Family\n";
            _Summary += "     , 'Term'                      = SY.term\n";
            _Summary += "     , 'TermDescription'           = CAST( SY.term as VARCHAR(10) )\n";
            _Summary += "     , 'Sensitivity'               = SY.sensibilities\n";
            _Summary += "     , 'SensitivityNew'            = CASE WHEN SD.contractdate = @DateProcess THEN 0 ELSE SY.sensibilities   END\n";
            _Summary += "     , 'Rate1'                     = CASE WHEN SY.[system] = 'BTR' OR (SY.System = 'BFW' AND SD.productid = 10) THEN 0 ELSE ISNULL( YV.rate1, 0 ) END\n";
            _Summary += "     , 'Rate2'                     = CASE WHEN SY.[system] = 'BTR' OR (SY.System = 'BFW' AND SD.productid = 10) THEN 0 ELSE ISNULL( YV.rate2, 0 ) END\n";
            _Summary += "     , 'BPs'                       = CASE WHEN SY.[system] = 'BTR' OR (SY.System = 'BFW' AND SD.productid = 10) THEN 0 ELSE (ISNULL( YV.rate1, 0 ) - ISNULL( YV.rate2, 0 )) * 100.0 END\n";
            _Summary += "     , 'Estimation'                = CASE WHEN SD.contractdate = @DateProcess THEN 0 ELSE SY.estimationvalue END\n";
            _Summary += "  INTO #tmpSensibilities\n";
            _Summary += "  FROM dbo.SensibilitiesYield               SY (INDEX=ix_SensibilitiesYield_01)\n";
            _Summary += "       INNER JOIN #tmpSensibilitiesData     SD  ON SD.detailid          = SY.dataid\n";
            _Summary += "       LEFT JOIN dbo.YieldValue             YV  ON YV.yielddate         = @DateProcess\n";
            _Summary += "                                               AND YV.yieldname         = SY.yieldname\n";
            _Summary += "                                               AND YV.term              = SY.term\n";
            _Summary += " WHERE SY.sensibilitiesdate          = @DateProcess\n\n";

            _Summary += "UPDATE #tmpSensibilities\n";
            _Summary += "   SET System    = 'BTR'\n";
            _Summary += " WHERE System    = 'BFW'\n";
            _Summary += "   AND Family   <> ''\n\n";

            _Summary += "SELECT 'YieldName'                 = yieldname\n";
            _Summary += "     , 'Family'                    = Family\n";
            _Summary += "     , 'Sensitivity'               = SUM( Sensitivity )\n";
            _Summary += "     , 'SensitivityNew'            = SUM( SensitivityNew )\n";
            _Summary += "     , 'Estimation'                = SUM( Estimation )\n";
            _Summary += "  FROM #tmpSensibilities\n";
            _Summary += " GROUP BY\n";
            _Summary += "       Yieldname\n";
            _Summary += "     , Family\n";
            _Summary += " ORDER BY\n";
            _Summary += "       Yieldname\n";
            _Summary += "     , Family\n";

            _Summary += "DROP TABLE #tmpSensibilities\n";
            _Summary += "DROP TABLE #tmpSensibilitiesData\n\n";

            _Summary += "SET NOCOUNT OFF\n";

            _Summary = _Summary.Replace("[@DateProcess]", "'" + portFolioDate.ToString("yyyyMMdd") + "'");

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _Summary, "SensitivitiesSummary");
                _DTSummary = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTSummary = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTSummary;

        }

        public DataTable Load(DateTime portFolioDate, string conditions, string yieldName, string familyID)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTDetail;
            string _Detail;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTDetail = new DataTable();

            _Detail = "";

            #endregion

            #region "Query Fixing Rate"

            _Detail += "DECLARE @DateProcess                   DATETIME\n\n";

            _Detail += "DECLARE @DateProcess                DATETIME\n\n";
            _Detail += "DECLARE @YieldName                  VARCHAR(30)\n\n";
            _Detail += "DECLARE @FamilyID                   VARCHAR(30)\n\n";

            _Detail += "SET @DateProcess = '" + portFolioDate.ToString("yyyyMMdd") + "'\n";
            _Detail += "SET @YieldName   = '" + yieldName + "'\n";
            _Detail += "SET @FamilyID    = '" + familyID + "'\n\n";

            _Detail += "SELECT 'DetailID'               = ID\n";
            _Detail += "     , 'System'                 = system\n";
            _Detail += "     , 'Family'                 = FamilyID\n";
            _Detail += "     , 'ProductID'              = productid\n";
            _Detail += "     , 'ContractDate'           = GETDATE()\n";
            _Detail += "     , 'OperationNumber'        = OperationNumber\n";
            _Detail += "     , 'DocumentNumber'         = DocumentNumber\n";
            _Detail += "     , 'OperationID'            = OperationID\n";
            _Detail += "  INTO #tmpSensibilitiesData\n";
            _Detail += "  FROM dbo.SensibilitiesData sd\n";
            _Detail += " WHERE sensibilitiesdate        = @DateProcess\n";

            if (!conditions.Equals(""))
            {
                _Detail += " AND (" + conditions + ")\n";
            }

            _Detail += "\n";

            _Detail += "UPDATE #tmpSensibilitiesData\n";
            _Detail += "   SET ContractDate = SFR.contractdate\n";
            _Detail += "  FROM dbo.SensibilitiesFixingRate SFR,\n";
            _Detail += "       #tmpSensibilitiesData       SD\n";
            _Detail += " WHERE ID           = DetailID\n\n";

            _Detail += "UPDATE #tmpSensibilitiesData\n";
            _Detail += "   SET ContractDate = SF.contractdate\n";
            _Detail += "  FROM dbo.SensibilitiesForward    SF,\n";
            _Detail += "       #tmpSensibilitiesData       SD\n";
            _Detail += " WHERE ID           = DetailID\n\n";

            _Detail += "UPDATE #tmpSensibilitiesData\n";
            _Detail += "   SET ContractDate = SFBT.contractdate\n";
            _Detail += "  FROM dbo.SensibilitiesForwardBondsTrader SFBT,\n";
            _Detail += "       #tmpSensibilitiesData       SD\n";
            _Detail += " WHERE ID           = DetailID\n\n";

            _Detail += "UPDATE #tmpSensibilitiesData\n";
            _Detail += "   SET ContractDate = SW.contractdate\n";
            _Detail += "  FROM dbo.SensibilitiesSwap SW,\n";
            _Detail += "       #tmpSensibilitiesData SD\n";
            _Detail += " WHERE ID           = DetailID\n\n";

            _Detail += "SELECT 'YieldName'                 = SY.yieldname\n";
            _Detail += "     , 'System'                    = SY.[system]\n";
            _Detail += "     , 'Family'                    = SY.Family\n";
            _Detail += "     , 'Term'                      = SY.term\n";
            _Detail += "     , 'TermDescription'           = CAST( SY.term as VARCHAR(10) )\n";
            _Detail += "     , 'Sensibilities'             = SY.sensibilities\n";
            _Detail += "     , 'SensibilitiesNew'          = CASE WHEN SD.contractdate = @DateProcess THEN 0 ELSE SY.sensibilities   END\n";
            _Detail += "     , 'Rate1'                     = CASE WHEN SY.[system] = 'BTR' OR (SY.System = 'BFW' AND SD.productid = 10) THEN 0 ELSE ISNULL( YV.rate1, 0 ) END\n";
            _Detail += "     , 'Rate2'                     = CASE WHEN SY.[system] = 'BTR' OR (SY.System = 'BFW' AND SD.productid = 10) THEN 0 ELSE ISNULL( YV.rate2, 0 ) END\n";
            _Detail += "     , 'BPs'                       = CASE WHEN SY.[system] = 'BTR' OR (SY.System = 'BFW' AND SD.productid = 10) THEN 0 ELSE (ISNULL( YV.rate1, 0 ) - ISNULL( YV.rate2, 0 )) * 100.0 END\n";
            _Detail += "     , 'Estimation'                = CASE WHEN SD.contractdate = @DateProcess THEN 0 ELSE SY.estimationvalue END\n";
            _Detail += "  INTO #tmpSensibilities\n";
            _Detail += "  FROM dbo.SensibilitiesYield               SY (INDEX=ix_SensibilitiesYield_01)\n";
            _Detail += "       INNER JOIN #tmpSensibilitiesData     SD  ON SD.detailid          = SY.dataid\n";
            _Detail += "       LEFT JOIN dbo.YieldValue             YV  ON YV.yielddate         = @DateProcess\n";
            _Detail += "                                               AND YV.yieldname         = SY.yieldname\n";
            _Detail += "                                               AND YV.term              = SY.term\n";
            _Detail += " WHERE SY.sensibilitiesdate          = @DateProcess\n\n";
            _Detail += "   AND SY.YieldName                  = @YieldName\n";
            _Detail += "   AND SY.Family                     = @FamilyID\n";

            _Detail += "UPDATE #tmpSensibilities\n";
            _Detail += "   SET System    = 'BTR'\n";
            _Detail += " WHERE System    = 'BFW'\n";
            _Detail += "   AND Family   <> ''\n\n";

            _Detail += "SELECT 'YieldName'                 = yieldname\n";
            _Detail += "     , 'System'                    = System\n";
            _Detail += "     , 'Family'                    = Family\n";
            _Detail += "     , 'Term'                      = Term\n";
            _Detail += "     , 'Sensibilities'             = SUM( Sensibilities )\n";
            _Detail += "     , 'SensibilitiesNew'          = SUM( SensibilitiesNew )\n";
            _Detail += "     , 'Rate1'                     = Rate1\n";
            _Detail += "     , 'Rate2'                     = Rate2\n";
            _Detail += "     , 'BPs'                       = BPs\n";
            _Detail += "     , 'Estimation'                = SUM( Estimation )\n";
            _Detail += "  FROM #tmpSensibilities\n";
            _Detail += " GROUP BY\n";
            _Detail += "       Yieldname\n";
            _Detail += "     , System\n";
            _Detail += "     , Family\n";
            _Detail += "     , Term\n";
            _Detail += "     , Rate1\n";
            _Detail += "     , Rate2\n";
            _Detail += "     , BPs\n";
            _Detail += " ORDER BY\n";
            _Detail += "       Yieldname\n";
            _Detail += "     , System\n";
            _Detail += "     , Family\n";
            _Detail += "     , Term\n\n";

            _Detail += "DROP TABLE #tmpSensibilities\n";
            _Detail += "DROP TABLE #tmpSensibilitiesData\n\n";

            _Detail += "SET NOCOUNT OFF\n";

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _Detail, "SensitivitiesDetail");
                _DTDetail = _Connect.Table;
            }
            catch (Exception _Error)
            {
                _DTDetail = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
            }
            finally
            {
                _Connect.Close();
                _Connect = null;
            }

            #endregion

            return _DTDetail;

        }

    }

}
