using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace cData.Turing2009.Filter
{
    public static class  FilterData
    {
           
        #region "Atributos Privados"

        private static enumStatus mStatus;
        private static enumSource mSource;
        private static String mError;
        private static String mStack;

        #endregion

        public static DataTable LoadFilter()
        {

            string _QueryFilter = "SELECT 'id' = FS.ID, 'filterid' = FS.filterid, 'description' = FS.description, 'patherid' = FS.patherid" +
                                  ", 'conditions' = ISNULL( FC.conditions, '' ) FROM dbo.FilterSensibilities FS LEFT JOIN dbo.FiltroConditions FC " +
                                  "ON FS.filter = FC.id";
            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
            DataTable _FilterData;

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryFilter);
                _FilterData = _Connect.QueryDataTable();
                _FilterData.TableName = "Filter";

                if (_FilterData.Rows.Count.Equals(0))
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
                _FilterData = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _FilterData;

        }

        public static DataTable LoadFilterOperation(DateTime portFolioDate)
        {



            string _QueryFilter = "SELECT 'ID'                          = SD.id\n" +
                                  "     , 'System'                      = SD.System\n" +
                                  "     , 'FamilyID'                    = SD.familyid\n" +
                                  "     , 'MNemonicsMask'               = SD.mnemonicsmask\n" +
                                  "     , 'MNemonics'                   = SD.mnemonics\n" +
                                  "     , 'BookID'                      = SD.bookid\n" +
                                  "     , 'PortFolioRulesID'            = SD.portfoliorulesid\n" +
                                  "     , 'FinancialPortFolioID'        = SD.financialportfolioid\n" +
                                  "     , 'ProductID'                   = CASE WHEN SD.productid <> 'CP' AND SYSTEM = 'BTR' THEN 'CP' ELSE SD.productid END\n" + //SD.productid\n" +
                                  "     , 'IssueID'                     = SD.issueid\n" +
                                  "     , 'IssueName'                   = ISNULL( E.emgeneric, '' )\n" +
                                  "     , 'OperationNumber'             = SD.operationnumber\n" +
                                  "     , 'OperationID'                 = SD.operationid\n" +
                                  "     , 'CustomerName'                = RTRIM(ISNULL( C.clnombre, '' ))\n" +
                                  "  FROM dbo.SensibilitiesData                SD\n" +
                                  "       LEFT JOIN cliente                    C      ON C.clrut                              = SD.CustomerID\n" +
                                  "                                                  AND C.clcodigo                           = SD.CustomerCode\n" +
                                  "       LEFT JOIN emisor                     E      ON E.emrut                              = SD.issueid\n" +
                                  " WHERE SD.sensibilitiesdate          = '" + portFolioDate.ToString("yyyyMMdd") + "'\n" +
                                  " ORDER BY\n" +
                                  "       SD.System\n" +
                                  "     , MNemonicsMask\n" +
                                  "     , SD.OperationNumber\n" +
                                  "     , SD.OperationID;";
            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
            DataTable _FilterOperation;

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryFilter);
                _FilterOperation = _Connect.QueryDataTable();
                _FilterOperation.TableName = "FilterData";

                if (_FilterOperation.Rows.Count.Equals(0))
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
                _FilterOperation = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _FilterOperation;

        }

    }
}
