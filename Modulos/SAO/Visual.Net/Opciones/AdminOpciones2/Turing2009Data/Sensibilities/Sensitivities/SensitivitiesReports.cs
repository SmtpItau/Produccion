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

    public class SensitivitiesReports : InterfaceQuery
    {

        public DataTable Load(DateTime portFolioDate, string conditions)
        {

            #region "Definición de Variables"

            Turing2009Connect.Connect _Connect;
            DataTable _DTDetailByPortfolio;
            string _DetailByPortfolio;

            #endregion

            #region "Inicialización de Variables"

            _Connect = new Turing2009Connect.Connect();
            _Connect.QueryType = enumQueryType.Load;

            _DTDetailByPortfolio = new DataTable();

            _DetailByPortfolio = "";

            #endregion

            #region "Query"

            _DetailByPortfolio += "DECLARE @DateProcess                   DATETIME\n\n";

            _DetailByPortfolio += "SET @DateProcess = '" + portFolioDate.ToString("yyyyMMdd") + "'\n";

            _DetailByPortfolio += "SELECT 'DetailID'               = ID\n";
            _DetailByPortfolio += "     , 'System'                 = system\n";
            _DetailByPortfolio += "     , 'Family'                 = FamilyID\n";
            _DetailByPortfolio += "     , 'ProductID'              = productid\n";
            _DetailByPortfolio += "     , 'ContractDate'           = GETDATE()\n";
            _DetailByPortfolio += "     , 'OperationNumber'        = OperationNumber\n";
            _DetailByPortfolio += "     , 'DocumentNumber'         = DocumentNumber\n";
            _DetailByPortfolio += "     , 'OperationID'            = OperationID\n";
            _DetailByPortfolio += "  INTO #tmpSensibilitiesData\n";
            _DetailByPortfolio += "  FROM dbo.SensibilitiesData sd\n";
            _DetailByPortfolio += " WHERE sensibilitiesdate        = @DateProcess\n";

            if (!conditions.Equals(""))
            {
                _DetailByPortfolio += " AND (" + conditions + ")\n";
            }

            _DetailByPortfolio += "\n";

            _DetailByPortfolio += "UPDATE #tmpSensibilitiesData\n";
            _DetailByPortfolio += "   SET ContractDate = SFR.contractdate\n";
            _DetailByPortfolio += "  FROM dbo.SensibilitiesFixingRate SFR,\n";
            _DetailByPortfolio += "       #tmpSensibilitiesData       SD\n";
            _DetailByPortfolio += " WHERE ID           = DetailID\n\n";

            _DetailByPortfolio += "UPDATE #tmpSensibilitiesData\n";
            _DetailByPortfolio += "   SET ContractDate = SF.contractdate\n";
            _DetailByPortfolio += "  FROM dbo.SensibilitiesForward    SF,\n";
            _DetailByPortfolio += "       #tmpSensibilitiesData       SD\n";
            _DetailByPortfolio += " WHERE ID           = DetailID\n\n";

            _DetailByPortfolio += "UPDATE #tmpSensibilitiesData\n";
            _DetailByPortfolio += "   SET ContractDate = SFBT.contractdate\n";
            _DetailByPortfolio += "  FROM dbo.SensibilitiesForwardBondsTrader SFBT,\n";
            _DetailByPortfolio += "       #tmpSensibilitiesData       SD\n";
            _DetailByPortfolio += " WHERE ID           = DetailID\n\n";

            _DetailByPortfolio += "UPDATE #tmpSensibilitiesData\n";
            _DetailByPortfolio += "   SET ContractDate = SW.contractdate\n";
            _DetailByPortfolio += "  FROM dbo.SensibilitiesSwap SW,\n";
            _DetailByPortfolio += "       #tmpSensibilitiesData SD\n";
            _DetailByPortfolio += " WHERE ID           = DetailID\n\n";

            _DetailByPortfolio += "SELECT 'YieldName'                 = SY.yieldname\n";
            _DetailByPortfolio += "     , 'System'                    = SY.[system]\n";
            _DetailByPortfolio += "     , 'Family'                    = SY.Family\n";
            _DetailByPortfolio += "     , 'Term'                      = SY.term\n";
            _DetailByPortfolio += "     , 'TermDescription'           = CAST( SY.term as VARCHAR(10) )\n";
            _DetailByPortfolio += "     , 'Sensitivity'               = SY.sensibilities\n";
            _DetailByPortfolio += "     , 'SensitivityNew'            = CASE WHEN SD.contractdate = @DateProcess THEN 0 ELSE SY.sensibilities   END\n";
            _DetailByPortfolio += "     , 'Rate1'                     = CASE WHEN SY.[system] = 'BTR' OR (SY.System = 'BFW' AND SD.productid = 10) THEN 0 ELSE ISNULL( YV.rate1, 0 ) END\n";
            _DetailByPortfolio += "     , 'Rate2'                     = CASE WHEN SY.[system] = 'BTR' OR (SY.System = 'BFW' AND SD.productid = 10) THEN 0 ELSE ISNULL( YV.rate2, 0 ) END\n";
            _DetailByPortfolio += "     , 'BPs'                       = CASE WHEN SY.[system] = 'BTR' OR (SY.System = 'BFW' AND SD.productid = 10) THEN 0 ELSE (ISNULL( YV.rate1, 0 ) - ISNULL( YV.rate2, 0 )) * 100.0 END\n";
            _DetailByPortfolio += "     , 'Estimation'                = CASE WHEN SD.contractdate = @DateProcess THEN 0 ELSE SY.estimationvalue END\n";
            _DetailByPortfolio += "  INTO #tmpSensibilities\n";
            _DetailByPortfolio += "  FROM dbo.SensibilitiesYield               SY (INDEX=ix_SensibilitiesYield_01)\n";
            _DetailByPortfolio += "       INNER JOIN #tmpSensibilitiesData     SD  ON SD.detailid          = SY.dataid\n";
            _DetailByPortfolio += "       LEFT JOIN dbo.YieldValue             YV  ON YV.yielddate         = @DateProcess\n";
            _DetailByPortfolio += "                                               AND YV.yieldname         = SY.yieldname\n";
            _DetailByPortfolio += "                                               AND YV.term              = SY.term\n";
            _DetailByPortfolio += " WHERE SY.sensibilitiesdate          = @DateProcess\n\n";

            _DetailByPortfolio += "UPDATE #tmpSensibilities\n";
            _DetailByPortfolio += "   SET System    = 'BTR'\n";
            _DetailByPortfolio += " WHERE System    = 'BFW'\n";
            _DetailByPortfolio += "   AND Family   <> ''\n\n";

            _DetailByPortfolio += "SELECT 'YieldName'                 = yieldname\n";
            _DetailByPortfolio += "     , 'System'                    = System\n";
            _DetailByPortfolio += "     , 'Family'                    = Family\n";
            _DetailByPortfolio += "     , 'Term'                      = Term\n";
            _DetailByPortfolio += "     , 'Sensitivity'               = SUM( Sensitivity )\n";
            _DetailByPortfolio += "     , 'SensitivityNew'            = SUM( SensitivityNew )\n";
            _DetailByPortfolio += "     , 'Rate1'                     = Rate1\n";
            _DetailByPortfolio += "     , 'Rate2'                     = Rate2\n";
            _DetailByPortfolio += "     , 'BPs'                       = BPs\n";
            _DetailByPortfolio += "     , 'Estimation'                = SUM( Estimation )\n";
            _DetailByPortfolio += "  FROM #tmpSensibilities\n";
            _DetailByPortfolio += " GROUP BY\n";
            _DetailByPortfolio += "       Yieldname\n";
            _DetailByPortfolio += "     , System\n";
            _DetailByPortfolio += "     , Family\n";
            _DetailByPortfolio += "     , Term\n";
            _DetailByPortfolio += "     , Rate1\n";
            _DetailByPortfolio += "     , Rate2\n";
            _DetailByPortfolio += "     , BPs\n";
            _DetailByPortfolio += " ORDER BY\n";
            _DetailByPortfolio += "       Yieldname\n";
            _DetailByPortfolio += "     , System\n";
            _DetailByPortfolio += "     , Family\n";
            _DetailByPortfolio += "     , Term\n\n";

            _DetailByPortfolio += "DROP TABLE #tmpSensibilities\n";
            _DetailByPortfolio += "DROP TABLE #tmpSensibilitiesData\n\n";

            _DetailByPortfolio += "SET NOCOUNT OFF\n";

            #endregion

            #region "Ejecución del Query"

            try
            {
                _Connect.Execute("Turing", _DetailByPortfolio, "DetailForwardFixingIncome");
                _DTDetailByPortfolio = _Connect.Table;
                _Connect.Close();
                _Connect = null;
            }
            catch (Exception _Error)
            {
                _DTDetailByPortfolio = null;
                Error = new StructError(_Error);
                Status = enumStatus.ErrorExecuting;
                _Connect.Close();
                _Connect = null;
                throw (_Error);
            }

            #endregion

            return _DTDetailByPortfolio;

        }

    }
}
