using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using cConnectionDB;

namespace cData.Turing2009.Sensitivities
{

    public class LoadSensitivities
    {

        #region "Atributos Privados"

        private enumStatus mStatus;
        private enumSource mSource;
        private String mError;
        private String mStack;

        #endregion

        #region "Atributos Publicos"

        public enumStatus Status
        {
            get
            {
                return mStatus;
            }
        }

        public String Message
        {
            get
            {
                return ReadMessage(mStatus);
            }
        }

        public String Error
        {
            get
            {
                return mError;
            }
        }

        public String Stack
        {
            get
            {
                return mStack;
            }
        }

        #endregion

        public String ReadMessage(enumStatus status)
        {
            String _Message;

            switch (status)
            {
                case enumStatus.Already:
                    _Message = "";
                    break;
                case enumStatus.ErrorLoadValue:
                    _Message = "";
                    break;
                case enumStatus.ErrorLoad:
                    _Message = "";
                    break;
                case enumStatus.ErrorLoaded:
                    _Message = "";
                    break;
                case enumStatus.Initialize:
                    _Message = "";
                    break;
                case enumStatus.Loaded:
                    _Message = "";
                    break;
                case enumStatus.Loading:
                    _Message = "";
                    break;
                case enumStatus.NotFound:
                    _Message = "";
                    break;
                case enumStatus.NotFoundValue:
                    _Message = "";
                    break;
                default:
                    _Message = "";
                    break;
            }
            return _Message;
        }

        public DataTable Summary(DateTime portFolioDate, string conditions)
        {

            string _QuerySensibilities;

            #region "Query Sensibilities"

            _QuerySensibilities = "";

            _QuerySensibilities += "SET NOCOUNT ON\n\n";

            _QuerySensibilities += "DECLARE @DateProcess                DATETIME\n\n";

            _QuerySensibilities += "SET @DateProcess = [@DateProcess]\n\n";

            _QuerySensibilities += "SELECT 'DetailID'               = ID\n";
            _QuerySensibilities += "     , 'System'                 = system\n";
            _QuerySensibilities += "     , 'Family'                 = FamilyID\n";
            _QuerySensibilities += "     , 'ProductID'              = productid\n";
            _QuerySensibilities += "     , 'ContractDate'           = GETDATE()\n";
            _QuerySensibilities += "     , 'OperationNumber'        = OperationNumber\n";
            _QuerySensibilities += "     , 'DocumentNumber'         = DocumentNumber\n";
            _QuerySensibilities += "     , 'OperationID'            = OperationID\n";
            _QuerySensibilities += "  INTO #tmpSensibilitiesData\n";
            _QuerySensibilities += "  FROM dbo.SensibilitiesData sd\n";
            _QuerySensibilities += " WHERE sensibilitiesdate        = @DateProcess\n";

            if (!conditions.Equals(""))
            {
                _QuerySensibilities += " AND (" + conditions + ")\n";
            }

            _QuerySensibilities += "\n";

            _QuerySensibilities += "UPDATE #tmpSensibilitiesData\n";
            _QuerySensibilities += "   SET ContractDate = SFR.contractdate\n";
            _QuerySensibilities += "  FROM dbo.SensibilitiesFixingRate SFR,\n";
            _QuerySensibilities += "       #tmpSensibilitiesData       SD\n";
            _QuerySensibilities += " WHERE ID           = DetailID\n\n";

            _QuerySensibilities += "UPDATE #tmpSensibilitiesData\n";
            _QuerySensibilities += "   SET ContractDate = SF.contractdate\n";
            _QuerySensibilities += "  FROM dbo.SensibilitiesForward    SF,\n";
            _QuerySensibilities += "       #tmpSensibilitiesData       SD\n";
            _QuerySensibilities += " WHERE ID           = DetailID\n\n";

            _QuerySensibilities += "UPDATE #tmpSensibilitiesData\n";
            _QuerySensibilities += "   SET ContractDate = SFBT.contractdate\n";
            _QuerySensibilities += "  FROM dbo.SensibilitiesForwardBondsTrader SFBT,\n";
            _QuerySensibilities += "       #tmpSensibilitiesData       SD\n";
            _QuerySensibilities += " WHERE ID           = DetailID\n\n";

            _QuerySensibilities += "UPDATE #tmpSensibilitiesData\n";
            _QuerySensibilities += "   SET ContractDate = SW.contractdate\n";
            _QuerySensibilities += "  FROM dbo.SensibilitiesSwap SW,\n";
            _QuerySensibilities += "       #tmpSensibilitiesData SD\n";
            _QuerySensibilities += " WHERE ID           = DetailID\n\n";

            _QuerySensibilities += "SELECT 'YieldName'                 = SY.yieldname\n";
            _QuerySensibilities += "     , 'System'                    = SY.[system]\n";
            _QuerySensibilities += "     , 'Family'                    = SY.Family\n";
            _QuerySensibilities += "     , 'Term'                      = SY.term\n";
            _QuerySensibilities += "     , 'TermDescription'           = CAST( SY.term as VARCHAR(10) )\n";
            _QuerySensibilities += "     , 'Sensibilities'             = SY.sensibilities\n";
            _QuerySensibilities += "     , 'SensibilitiesNew'          = CASE WHEN SD.contractdate = @DateProcess THEN 0 ELSE SY.sensibilities   END\n";
            _QuerySensibilities += "     , 'Rate1'                     = CASE WHEN SY.[system] = 'BTR' OR (SY.System = 'BFW' AND SD.productid = 10) THEN 0 ELSE ISNULL( YV.rate1, 0 ) END\n";
            _QuerySensibilities += "     , 'Rate2'                     = CASE WHEN SY.[system] = 'BTR' OR (SY.System = 'BFW' AND SD.productid = 10) THEN 0 ELSE ISNULL( YV.rate2, 0 ) END\n";
            _QuerySensibilities += "     , 'BPs'                       = CASE WHEN SY.[system] = 'BTR' OR (SY.System = 'BFW' AND SD.productid = 10) THEN 0 ELSE (ISNULL( YV.rate1, 0 ) - ISNULL( YV.rate2, 0 )) * 100.0 END\n";
            _QuerySensibilities += "     , 'Estimation'                = CASE WHEN SD.contractdate = @DateProcess THEN 0 ELSE SY.estimationvalue END\n";
            _QuerySensibilities += "  INTO #tmpSensibilities\n";
            _QuerySensibilities += "  FROM dbo.SensibilitiesYield               SY (INDEX=ix_SensibilitiesYield_01)\n";
            _QuerySensibilities += "       INNER JOIN #tmpSensibilitiesData     SD  ON SD.detailid          = SY.dataid\n";
            _QuerySensibilities += "       LEFT JOIN dbo.YieldValue             YV  ON YV.yielddate         = @DateProcess\n";
            _QuerySensibilities += "                                               AND YV.yieldname         = SY.yieldname\n";
            _QuerySensibilities += "                                               AND YV.term              = SY.term\n";
            _QuerySensibilities += " WHERE SY.sensibilitiesdate          = @DateProcess\n\n";

            _QuerySensibilities += "UPDATE #tmpSensibilities\n";
            _QuerySensibilities += "   SET System    = 'BTR'\n";
            _QuerySensibilities += " WHERE System    = 'BFW'\n";
            _QuerySensibilities += "   AND Family   <> ''\n\n";

            _QuerySensibilities += "SELECT 'YieldName'                 = yieldname\n";
            _QuerySensibilities += "     , 'Family'                    = Family\n";
            _QuerySensibilities += "     , 'Sensibilities'             = SUM( Sensibilities )\n";
            _QuerySensibilities += "     , 'SensibilitiesNew'          = SUM( SensibilitiesNew )\n";
            _QuerySensibilities += "     , 'Estimation'                = SUM( Estimation )\n";
            _QuerySensibilities += "  FROM #tmpSensibilities\n";
            _QuerySensibilities += " GROUP BY\n";
            _QuerySensibilities += "       Yieldname\n";
            _QuerySensibilities += "     , Family\n";
            _QuerySensibilities += " ORDER BY\n";
            _QuerySensibilities += "       Yieldname\n";
            _QuerySensibilities += "     , Family\n";

            _QuerySensibilities += "DROP TABLE #tmpSensibilities\n";
            _QuerySensibilities += "DROP TABLE #tmpSensibilitiesData\n\n";

            _QuerySensibilities += "SET NOCOUNT OFF\n";

            _QuerySensibilities = _QuerySensibilities.Replace("[@DateProcess]", "'" + portFolioDate.ToString("yyyyMMdd") + "'");

            #endregion

            SqlConnectionDB _Connect = new SqlConnectionDB("TURING");
            DataTable _SensibilitiesData;

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QuerySensibilities);
                _SensibilitiesData = _Connect.QueryDataTable();
                _SensibilitiesData.TableName = "Sensibilities";

                if (_SensibilitiesData.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _SensibilitiesData = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _SensibilitiesData;
        }

        public DataTable Detail(DateTime portFolioDate, string conditions, string yieldName, string familyID)
        {

            string _QuerySensibilities;

            #region "Query Sensibilities"

            _QuerySensibilities = "";

            _QuerySensibilities += "SET NOCOUNT ON\n\n";

            _QuerySensibilities += "DECLARE @DateProcess                DATETIME\n\n";
            _QuerySensibilities += "DECLARE @YieldName                  VARCHAR(30)\n\n";
            _QuerySensibilities += "DECLARE @FamilyID                   VARCHAR(30)\n\n";

            _QuerySensibilities += "SET @DateProcess = '" + portFolioDate.ToString("yyyyMMdd") + "'\n";
            _QuerySensibilities += "SET @YieldName   = '" + yieldName + "'\n";
            _QuerySensibilities += "SET @FamilyID    = '" + familyID + "'\n\n";

            _QuerySensibilities += "SELECT 'DetailID'               = ID\n";
            _QuerySensibilities += "     , 'System'                 = system\n";
            _QuerySensibilities += "     , 'Family'                 = FamilyID\n";
            _QuerySensibilities += "     , 'ProductID'              = productid\n";
            _QuerySensibilities += "     , 'ContractDate'           = GETDATE()\n";
            _QuerySensibilities += "     , 'OperationNumber'        = OperationNumber\n";
            _QuerySensibilities += "     , 'DocumentNumber'         = DocumentNumber\n";
            _QuerySensibilities += "     , 'OperationID'            = OperationID\n";
            _QuerySensibilities += "  INTO #tmpSensibilitiesData\n";
            _QuerySensibilities += "  FROM dbo.SensibilitiesData sd\n";
            _QuerySensibilities += " WHERE sensibilitiesdate        = @DateProcess\n";

            if (!conditions.Equals(""))
            {
                _QuerySensibilities += " AND (" + conditions + ")\n";
            }

            _QuerySensibilities += "\n";

            _QuerySensibilities += "UPDATE #tmpSensibilitiesData\n";
            _QuerySensibilities += "   SET ContractDate = SFR.contractdate\n";
            _QuerySensibilities += "  FROM dbo.SensibilitiesFixingRate SFR,\n";
            _QuerySensibilities += "       #tmpSensibilitiesData       SD\n";
            _QuerySensibilities += " WHERE ID           = DetailID\n\n";

            _QuerySensibilities += "UPDATE #tmpSensibilitiesData\n";
            _QuerySensibilities += "   SET ContractDate = SF.contractdate\n";
            _QuerySensibilities += "  FROM dbo.SensibilitiesForward    SF,\n";
            _QuerySensibilities += "       #tmpSensibilitiesData       SD\n";
            _QuerySensibilities += " WHERE ID           = DetailID\n\n";

            _QuerySensibilities += "UPDATE #tmpSensibilitiesData\n";
            _QuerySensibilities += "   SET ContractDate = SFBT.contractdate\n";
            _QuerySensibilities += "  FROM dbo.SensibilitiesForwardBondsTrader SFBT,\n";
            _QuerySensibilities += "       #tmpSensibilitiesData       SD\n";
            _QuerySensibilities += " WHERE ID           = DetailID\n\n";

            _QuerySensibilities += "UPDATE #tmpSensibilitiesData\n";
            _QuerySensibilities += "   SET ContractDate = SW.contractdate\n";
            _QuerySensibilities += "  FROM dbo.SensibilitiesSwap SW,\n";
            _QuerySensibilities += "       #tmpSensibilitiesData SD\n";
            _QuerySensibilities += " WHERE ID           = DetailID\n\n";

            _QuerySensibilities += "SELECT 'YieldName'                 = SY.yieldname\n";
            _QuerySensibilities += "     , 'System'                    = SY.[system]\n";
            _QuerySensibilities += "     , 'Family'                    = SY.Family\n";
            _QuerySensibilities += "     , 'Term'                      = SY.term\n";
            _QuerySensibilities += "     , 'TermDescription'           = CAST( SY.term as VARCHAR(10) )\n";
            _QuerySensibilities += "     , 'Sensibilities'             = SY.sensibilities\n";
            _QuerySensibilities += "     , 'SensibilitiesNew'          = CASE WHEN SD.contractdate = @DateProcess THEN 0 ELSE SY.sensibilities   END\n";
            _QuerySensibilities += "     , 'Rate1'                     = CASE WHEN SY.[system] = 'BTR' OR (SY.System = 'BFW' AND SD.productid = 10) THEN 0 ELSE ISNULL( YV.rate1, 0 ) END\n";
            _QuerySensibilities += "     , 'Rate2'                     = CASE WHEN SY.[system] = 'BTR' OR (SY.System = 'BFW' AND SD.productid = 10) THEN 0 ELSE ISNULL( YV.rate2, 0 ) END\n";
            _QuerySensibilities += "     , 'BPs'                       = CASE WHEN SY.[system] = 'BTR' OR (SY.System = 'BFW' AND SD.productid = 10) THEN 0 ELSE (ISNULL( YV.rate1, 0 ) - ISNULL( YV.rate2, 0 )) * 100.0 END\n";
            _QuerySensibilities += "     , 'Estimation'                = CASE WHEN SD.contractdate = @DateProcess THEN 0 ELSE SY.estimationvalue END\n";
            _QuerySensibilities += "  INTO #tmpSensibilities\n";
            _QuerySensibilities += "  FROM dbo.SensibilitiesYield               SY (INDEX=ix_SensibilitiesYield_01)\n";
            _QuerySensibilities += "       INNER JOIN #tmpSensibilitiesData     SD  ON SD.detailid          = SY.dataid\n";
            _QuerySensibilities += "       LEFT JOIN dbo.YieldValue             YV  ON YV.yielddate         = @DateProcess\n";
            _QuerySensibilities += "                                               AND YV.yieldname         = SY.yieldname\n";
            _QuerySensibilities += "                                               AND YV.term              = SY.term\n";
            _QuerySensibilities += " WHERE SY.sensibilitiesdate          = @DateProcess\n\n";
            _QuerySensibilities += "   AND SY.YieldName                  = @YieldName\n";
            _QuerySensibilities += "   AND SY.Family                     = @FamilyID\n";

            _QuerySensibilities += "UPDATE #tmpSensibilities\n";
            _QuerySensibilities += "   SET System    = 'BTR'\n";
            _QuerySensibilities += " WHERE System    = 'BFW'\n";
            _QuerySensibilities += "   AND Family   <> ''\n\n";

            _QuerySensibilities += "SELECT 'YieldName'                 = yieldname\n";
            _QuerySensibilities += "     , 'System'                    = System\n";
            _QuerySensibilities += "     , 'Family'                    = Family\n";
            _QuerySensibilities += "     , 'Term'                      = Term\n";
            _QuerySensibilities += "     , 'Sensibilities'             = SUM( Sensibilities )\n";
            _QuerySensibilities += "     , 'SensibilitiesNew'          = SUM( SensibilitiesNew )\n";
            _QuerySensibilities += "     , 'Rate1'                     = Rate1\n";
            _QuerySensibilities += "     , 'Rate2'                     = Rate2\n";
            _QuerySensibilities += "     , 'BPs'                       = BPs\n";
            _QuerySensibilities += "     , 'Estimation'                = SUM( Estimation )\n";
            _QuerySensibilities += "  FROM #tmpSensibilities\n";
            _QuerySensibilities += " GROUP BY\n";
            _QuerySensibilities += "       Yieldname\n";
            _QuerySensibilities += "     , System\n";
            _QuerySensibilities += "     , Family\n";
            _QuerySensibilities += "     , Term\n";
            _QuerySensibilities += "     , Rate1\n";
            _QuerySensibilities += "     , Rate2\n";
            _QuerySensibilities += "     , BPs\n";
            _QuerySensibilities += " ORDER BY\n";
            _QuerySensibilities += "       Yieldname\n";
            _QuerySensibilities += "     , System\n";
            _QuerySensibilities += "     , Family\n";
            _QuerySensibilities += "     , Term\n\n";

            _QuerySensibilities += "DROP TABLE #tmpSensibilities\n";
            _QuerySensibilities += "DROP TABLE #tmpSensibilitiesData\n\n";

            _QuerySensibilities += "SET NOCOUNT OFF\n";

            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
            DataTable _SensibilitiesData;

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QuerySensibilities);
                _SensibilitiesData = _Connect.QueryDataTable();
                _SensibilitiesData.TableName = "Sensibilities";

                if (_SensibilitiesData.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _SensibilitiesData = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _SensibilitiesData;
        }



        //---------------------

        public DataTable DetailByPortfolio(DateTime portFolioDate)
        {

            string _QuerySensibilities;
            string conditions = ""; // Por mientras, debe ser un parametro, se alimenta del filtro

            #region "Query Sensibilities"

            _QuerySensibilities = "";

            _QuerySensibilities += "SET NOCOUNT ON\n\n";

            _QuerySensibilities += "DECLARE @DateProcess                DATETIME\n\n";

            _QuerySensibilities += "SET @DateProcess = '" + portFolioDate.ToString("yyyyMMdd") + "'\n";

            _QuerySensibilities += "SELECT 'DetailID'               = ID\n";
            _QuerySensibilities += "     , 'System'                 = system\n";
            _QuerySensibilities += "     , 'Family'                 = FamilyID\n";
            _QuerySensibilities += "     , 'ProductID'              = productid\n";
            _QuerySensibilities += "     , 'ContractDate'           = GETDATE()\n";
            _QuerySensibilities += "     , 'OperationNumber'        = OperationNumber\n";
            _QuerySensibilities += "     , 'DocumentNumber'         = DocumentNumber\n";
            _QuerySensibilities += "     , 'OperationID'            = OperationID\n";
            _QuerySensibilities += "  INTO #tmpSensibilitiesData\n";
            _QuerySensibilities += "  FROM dbo.SensibilitiesData sd\n";
            _QuerySensibilities += " WHERE sensibilitiesdate        = @DateProcess\n";

            if (!conditions.Equals(""))
            {
                _QuerySensibilities += " AND (" + conditions + ")\n";
            }

            _QuerySensibilities += "\n";

            _QuerySensibilities += "UPDATE #tmpSensibilitiesData\n";
            _QuerySensibilities += "   SET ContractDate = SFR.contractdate\n";
            _QuerySensibilities += "  FROM dbo.SensibilitiesFixingRate SFR,\n";
            _QuerySensibilities += "       #tmpSensibilitiesData       SD\n";
            _QuerySensibilities += " WHERE ID           = DetailID\n\n";

            _QuerySensibilities += "UPDATE #tmpSensibilitiesData\n";
            _QuerySensibilities += "   SET ContractDate = SF.contractdate\n";
            _QuerySensibilities += "  FROM dbo.SensibilitiesForward    SF,\n";
            _QuerySensibilities += "       #tmpSensibilitiesData       SD\n";
            _QuerySensibilities += " WHERE ID           = DetailID\n\n";

            _QuerySensibilities += "UPDATE #tmpSensibilitiesData\n";
            _QuerySensibilities += "   SET ContractDate = SFBT.contractdate\n";
            _QuerySensibilities += "  FROM dbo.SensibilitiesForwardBondsTrader SFBT,\n";
            _QuerySensibilities += "       #tmpSensibilitiesData       SD\n";
            _QuerySensibilities += " WHERE ID           = DetailID\n\n";

            _QuerySensibilities += "UPDATE #tmpSensibilitiesData\n";
            _QuerySensibilities += "   SET ContractDate = SW.contractdate\n";
            _QuerySensibilities += "  FROM dbo.SensibilitiesSwap SW,\n";
            _QuerySensibilities += "       #tmpSensibilitiesData SD\n";
            _QuerySensibilities += " WHERE ID           = DetailID\n\n";

            _QuerySensibilities += "SELECT 'YieldName'                 = SY.yieldname\n";
            _QuerySensibilities += "     , 'System'                    = SY.[system]\n";
            _QuerySensibilities += "     , 'Family'                    = SY.Family\n";
            _QuerySensibilities += "     , 'Term'                      = SY.term\n";
            _QuerySensibilities += "     , 'TermDescription'           = CAST( SY.term as VARCHAR(10) )\n";
            _QuerySensibilities += "     , 'Sensibilities'             = SY.sensibilities\n";
            _QuerySensibilities += "     , 'SensibilitiesNew'          = CASE WHEN SD.contractdate = @DateProcess THEN 0 ELSE SY.sensibilities   END\n";
            _QuerySensibilities += "     , 'Rate1'                     = CASE WHEN SY.[system] = 'BTR' OR (SY.System = 'BFW' AND SD.productid = 10) THEN 0 ELSE ISNULL( YV.rate1, 0 ) END\n";
            _QuerySensibilities += "     , 'Rate2'                     = CASE WHEN SY.[system] = 'BTR' OR (SY.System = 'BFW' AND SD.productid = 10) THEN 0 ELSE ISNULL( YV.rate2, 0 ) END\n";
            _QuerySensibilities += "     , 'BPs'                       = CASE WHEN SY.[system] = 'BTR' OR (SY.System = 'BFW' AND SD.productid = 10) THEN 0 ELSE (ISNULL( YV.rate1, 0 ) - ISNULL( YV.rate2, 0 )) * 100.0 END\n";
            _QuerySensibilities += "     , 'Estimation'                = CASE WHEN SD.contractdate = @DateProcess THEN 0 ELSE SY.estimationvalue END\n";
            _QuerySensibilities += "  INTO #tmpSensibilities\n";
            _QuerySensibilities += "  FROM dbo.SensibilitiesYield               SY (INDEX=ix_SensibilitiesYield_01)\n";
            _QuerySensibilities += "       INNER JOIN #tmpSensibilitiesData     SD  ON SD.detailid          = SY.dataid\n";
            _QuerySensibilities += "       LEFT JOIN dbo.YieldValue             YV  ON YV.yielddate         = @DateProcess\n";
            _QuerySensibilities += "                                               AND YV.yieldname         = SY.yieldname\n";
            _QuerySensibilities += "                                               AND YV.term              = SY.term\n";
            _QuerySensibilities += " WHERE SY.sensibilitiesdate          = @DateProcess\n\n";

            _QuerySensibilities += "UPDATE #tmpSensibilities\n";
            _QuerySensibilities += "   SET System    = 'BTR'\n";
            _QuerySensibilities += " WHERE System    = 'BFW'\n";
            _QuerySensibilities += "   AND Family   <> ''\n\n";

            _QuerySensibilities += "SELECT 'YieldName'                 = yieldname\n";
            _QuerySensibilities += "     , 'System'                    = System\n";
            _QuerySensibilities += "     , 'Family'                    = Family\n";
            _QuerySensibilities += "     , 'Term'                      = Term\n";
            _QuerySensibilities += "     , 'Sensibilities'             = SUM( Sensibilities )\n";
            _QuerySensibilities += "     , 'SensibilitiesNew'          = SUM( SensibilitiesNew )\n";
            _QuerySensibilities += "     , 'Rate1'                     = Rate1\n";
            _QuerySensibilities += "     , 'Rate2'                     = Rate2\n";
            _QuerySensibilities += "     , 'BPs'                       = BPs\n";
            _QuerySensibilities += "     , 'Estimation'                = SUM( Estimation )\n";
            _QuerySensibilities += "  FROM #tmpSensibilities\n";
            _QuerySensibilities += " GROUP BY\n";
            _QuerySensibilities += "       Yieldname\n";
            _QuerySensibilities += "     , System\n";
            _QuerySensibilities += "     , Family\n";
            _QuerySensibilities += "     , Term\n";
            _QuerySensibilities += "     , Rate1\n";
            _QuerySensibilities += "     , Rate2\n";
            _QuerySensibilities += "     , BPs\n";
            _QuerySensibilities += " ORDER BY\n";
            _QuerySensibilities += "       Yieldname\n";
            _QuerySensibilities += "     , System\n";
            _QuerySensibilities += "     , Family\n";
            _QuerySensibilities += "     , Term\n\n";

            _QuerySensibilities += "DROP TABLE #tmpSensibilities\n";
            _QuerySensibilities += "DROP TABLE #tmpSensibilitiesData\n\n";

            _QuerySensibilities += "SET NOCOUNT OFF\n";

            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
            DataTable _SensibilitiesData;

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QuerySensibilities);
                _SensibilitiesData = _Connect.QueryDataTable();
                _SensibilitiesData.TableName = "Sensibilities";

                if (_SensibilitiesData.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _SensibilitiesData = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _SensibilitiesData;
        }



    }

}
