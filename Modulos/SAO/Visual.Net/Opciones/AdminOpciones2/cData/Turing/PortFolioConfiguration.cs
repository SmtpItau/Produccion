using System;
using System.Collections;
using System.Text;
using System.Data;

namespace cData.Turing
{

    public class PortFolioConfiguration
    {

        protected enumStatus mStatus;
        protected enumSource mSource;
        protected String mError;
        protected String mStack;

        public PortFolioConfiguration()
        {
            mStatus = enumStatus.Initialize;
            mSource = enumSource.System;
        }

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
                    _Message = "Estado no definido";
                    break;
            }
            return _Message;
        }

        public DataTable Load()
        {
            DataTable _PortFolioConfiguration = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _PortFolioConfiguration = _System.Load();
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _PortFolioConfiguration = _Bloomberg.Load();
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _PortFolioConfiguration = _Excel.Load();
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                default:
                    break;
            }

            return _PortFolioConfiguration;

        }

        private class Source
        {

            private enumStatus mStatus;
            private String mError;
            private String mStack;

            public enumStatus Status
            {
                get
                {
                    return mStatus;
                }
                set
                {
                    mStatus = value;
                }
            }

            public String Error
            {
                get
                {
                    return mError;
                }
                set
                {
                    mError = value;
                }
            }

            public String Stack
            {
                get
                {
                    return mStack;
                }
                set
                {
                    mStack = value;
                }
            }

            public Source()
            {
                mStatus = enumStatus.Initialize;
                mError = "";
                mStack = "";
            }

            public virtual DataTable Load()
            {
                DataTable _PortFolioConfiguration = new DataTable();

                return _PortFolioConfiguration;
            }

        }

        private class SourceSystem : Source
        {

            public override DataTable Load()
            {
                String _QueryRate = "SELECT 'ModuleID'                         = M.id " +
                                    "     , 'DescriptionModule'                = M.description " +
                                    "     , 'OrderModule'                      = M.[order] " +
                                    "     , 'BookAndPortfolioRulesID'          = BPR.id " +
                                    "     , 'DescriptionBookAndPortfolioRules' = BPR.description " +
                                    "     , 'OrderBookAndPortfolioRules'       = BPR.[order] " +
                                    "     , 'FinancialPortfolioID'             = FP.id " +
                                    "     , 'DescriptionFinancialPortfolio'    = FP.description " +
                                    "     , 'OrderFinancialPortfolio'          = FP.[order] " +
                                    "     , 'ProductID'                        = P.id " +
                                    "     , 'DescriptionProduct'               = P.description " +
                                    "     , 'OrderProduct'                     = P.[order] " +
                                    "     , 'FamilyID'                         = ISNULL( F.id, 0 ) " +
                                    "     , 'DescriptionFamily'                = ISNULL( F.description, '' ) " +
                                    "     , 'OrderFamily'                      = ISNULL( F.[order], 0 ) " +
                                    "     , 'DetailID'                         = ISNULL( D.id, 0 ) " +
                                    "     , 'DescriptionDetail'                = ISNULL( D.description, '' ) " +
                                    "     , 'OrderDetail'                      = ISNULL( D.[order], 0 ) " +
                                    "  FROM dbo.Product P " +
                                    "       INNER JOIN dbo.FinancialPortfolio    FP   ON P.financialportfolioid     = FP.id " +
                                    "                                                AND FP.status                  = 'E' " +
                                    "       INNER JOIN dbo.BookAndPortfolioRules BPR  ON FP.bookandportfoliorulesid = BPR.id " +
                                    "                                                AND BPR.status                 = 'E' " +
                                    "       INNER JOIN dbo.Module                M    ON BPR.moduleid               = M.id " +
                                    "                                                AND M.status                   = 'E' " +
                                    "       LEFT  JOIN dbo.Family                F    ON F.productid                = P.id " +
                                    "                                                AND F.status                   = 'E' " +
                                    "       LEFT  JOIN dbo.Details               D    ON D.familyid                 = F.id " +
                                    "                                                AND D.status                   = 'E' " +
                                    " ORDER BY " +
                                    "       M.id " +
                                    "     , BPR.id " +
                                    "     , FP.id " +
                                    "     , P.id " +
                                    "     , ISNULL( F.id, 0 ) " +
                                    "     , ISNULL( D.id, 0 )";
                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("Turing");
                DataTable _PortFolioConfiguration;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryRate);
                    _PortFolioConfiguration = _Connect.QueryDataTable();
                    _PortFolioConfiguration.TableName = "PortFolioConfiguration";

                    if (_PortFolioConfiguration.Rows.Count.Equals(0))
                    {
                        Status = enumStatus.NotFound;
                    }
                    else
                    {
                        Status = enumStatus.Already;
                    }

                }
                catch (Exception _Error)
                {
                    _PortFolioConfiguration = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _PortFolioConfiguration;
            }

        }

        private class SourceBloomberg : Source
        {

            public override DataTable Load()
            {
                DataTable _PortFolioConfiguration = new DataTable();

                return _PortFolioConfiguration;
            }

        }

        private class SourceExcel : Source
        {

            public override DataTable Load()
            {
                DataTable _PortFolioConfiguration = new DataTable();

                return _PortFolioConfiguration;
            }

        }

    }

}
