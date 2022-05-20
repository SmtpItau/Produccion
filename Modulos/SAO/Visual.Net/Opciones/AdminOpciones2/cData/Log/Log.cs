using System;
using System.Collections;
using System.Text;
using System.Data;

namespace cData.Log
{

    public class Log
    {

        #region "Atributos privados"

        private enumStatus mStatus;
        private enumSource mSource;
        private String mError;
        private String mStack;

        #endregion

        #region "Constructores"

        public Log()
        {
            Set();
        }

        #endregion

        #region "Atributos publicos"

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

        #region "Metodos publicos"

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

        public DataSet LoadLog(DateTime date)
        {

            DataSet _Log;
            DataTable _LogStatus;
            DataTable _LogSystemStatus;

            _Log = new DataSet();
            _LogStatus = new DataTable();
            _LogSystemStatus = new DataTable();

            _LogStatus = LoadLogStatus(date);
            _LogSystemStatus = LoadLogSystemStatus(date);

            _Log.Merge(_LogStatus);
            _Log.Merge(_LogSystemStatus);

            return _Log;

        }

        private DataTable LoadLogStatus(DateTime date)
        {

            DataTable _LogStatus = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                case enumSource.CurrencyValueAccount:
                    SourceSystem _System = new SourceSystem();

                    _LogStatus = _System.LoadLogStatus(date);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _LogStatus = _Bloomberg.LoadLogStatus(date);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _LogStatus = _Excel.LoadLogStatus(date);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                case enumSource.XML:
                    SourceXML _XML = new SourceXML();

                    _LogStatus = _XML.LoadLogStatus(date);
                    mStatus = _XML.Status;
                    mError = _XML.Error;
                    mStack = _XML.Stack;

                    break;

                default:
                    break;
            }

            return _LogStatus;

        }

        private DataTable LoadLogSystemStatus(DateTime date)
        {
            DataTable _LogSystemStatus = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                case enumSource.CurrencyValueAccount:
                    SourceSystem _System = new SourceSystem();

                    _LogSystemStatus = _System.LoadLogSystemStatus(date);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _LogSystemStatus = _Bloomberg.LoadLogSystemStatus(date);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _LogSystemStatus = _Excel.LoadLogSystemStatus(date);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                case enumSource.XML:
                    SourceXML _XML = new SourceXML();

                    _LogSystemStatus = _XML.LoadLogSystemStatus(date);
                    mStatus = _XML.Status;
                    mError = _XML.Error;
                    mStack = _XML.Stack;

                    break;

                default:
                    break;
            }

            return _LogSystemStatus;

        }

        public DataTable SaveLog(string logID, DateTime dateLog, int processID, int userID)
        {

            DataTable _Log = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                case enumSource.CurrencyValueAccount:
                    SourceSystem _System = new SourceSystem();

                    _Log = _System.SaveLog(logID, dateLog, processID, userID);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _Log = _Bloomberg.SaveLog(logID, dateLog, processID, userID);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _Log = _Excel.SaveLog(logID, dateLog, processID, userID);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                case enumSource.XML:
                    SourceXML _XML = new SourceXML();

                    _Log = _XML.SaveLog(logID, dateLog, processID, userID);
                    mStatus = _XML.Status;
                    mError = _XML.Error;
                    mStack = _XML.Stack;

                    break;

                default:
                    break;
            }

            return _Log;

        }

        public DataTable SaveSystemStatus(
                                           string logID,
                                           DateTime dateStatus,
                                           DateTime portFolioYesterday,
                                           DateTime portFolioToday,
                                           DateTime portFolioTomorrow,
                                           DateTime portFolioEndOfMonth,
                                           DateTime portFolioPreviousEndOfMonth,
                                           DateTime yieldYesterday,
                                           DateTime yieldToday,
                                           DateTime currencyYesterday,
                                           DateTime currencyToday,
                                           DateTime markToMarketYesterday,
                                           DateTime markToMarketToday,
                                           int userID
                                         )
        {

            DataTable _LogSystemStatus = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                case enumSource.CurrencyValueAccount:
                    SourceSystem _System = new SourceSystem();

                    _LogSystemStatus = _System.SaveSystemStatus(
                                                                 logID,
                                                                 dateStatus,
                                                                 portFolioYesterday,
                                                                 portFolioToday,
                                                                 portFolioTomorrow,
                                                                 portFolioEndOfMonth,
                                                                 portFolioPreviousEndOfMonth,
                                                                 yieldYesterday,
                                                                 yieldToday,
                                                                 currencyYesterday,
                                                                 currencyToday,
                                                                 markToMarketYesterday,
                                                                 markToMarketToday,
                                                                 userID
                                                               );
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _LogSystemStatus = _Bloomberg.SaveSystemStatus(
                                                                    logID,
                                                                    dateStatus,
                                                                    portFolioYesterday,
                                                                    portFolioToday,
                                                                    portFolioTomorrow,
                                                                    portFolioEndOfMonth,
                                                                    portFolioPreviousEndOfMonth,
                                                                    yieldYesterday,
                                                                    yieldToday,
                                                                    currencyYesterday,
                                                                    currencyToday,
                                                                    markToMarketYesterday,
                                                                    markToMarketToday,
                                                                    userID
                                                                  );
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _LogSystemStatus = _Excel.SaveSystemStatus(
                                                                logID,
                                                                dateStatus,
                                                                portFolioYesterday,
                                                                portFolioToday,
                                                                portFolioTomorrow,
                                                                portFolioEndOfMonth,
                                                                portFolioPreviousEndOfMonth,
                                                                yieldYesterday,
                                                                yieldToday,
                                                                currencyYesterday,
                                                                currencyToday,
                                                                markToMarketYesterday,
                                                                markToMarketToday,
                                                                userID
                                                              );
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                case enumSource.XML:
                    SourceXML _XML = new SourceXML();

                    _LogSystemStatus = _XML.SaveSystemStatus(
                                                              logID,
                                                              dateStatus,
                                                              portFolioYesterday,
                                                              portFolioToday,
                                                              portFolioTomorrow,
                                                              portFolioEndOfMonth,
                                                              portFolioPreviousEndOfMonth,
                                                              yieldYesterday,
                                                              yieldToday,
                                                              currencyYesterday,
                                                              currencyToday,
                                                              markToMarketYesterday,
                                                              markToMarketToday,
                                                              userID
                                                            );
                    mStatus = _XML.Status;
                    mError = _XML.Error;
                    mStack = _XML.Stack;

                    break;

                default:
                    break;
            }

            return _LogSystemStatus;

        }

        #endregion

        #region "Metodos privados"

        protected void Set()
        {
            mStatus = enumStatus.Initialize;
            mSource = enumSource.System;
        }

        #endregion

        #region "Clases para obtener la información"

        #region "Clase Source"

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

            public virtual DataTable LoadLogStatus(DateTime date)
            {
                DataTable _LogStatus = new DataTable();

                return _LogStatus;
            }

            public virtual DataTable LoadLogSystemStatus(DateTime date)
            {
                DataTable _LoadLogSystemStatus = new DataTable();

                return _LoadLogSystemStatus;
            }

            public virtual DataTable SaveLog(string logID, DateTime dateLog, int processID, int userID)
            {
                DataTable _SaveLog = new DataTable();

                return _SaveLog;
            }

            public virtual DataTable SaveSystemStatus(
                                                       string logID,
                                                       DateTime dateStatus,
                                                       DateTime portFolioYesterday,
                                                       DateTime portFolioToday,
                                                       DateTime portFolioTomorrow,
                                                       DateTime portFolioEndOfMonth,
                                                       DateTime portFolioPreviousEndOfMonth,
                                                       DateTime yieldYesterday,
                                                       DateTime yieldToday,
                                                       DateTime currencyYesterday,
                                                       DateTime currencyToday,
                                                       DateTime markToMarketYesterday,
                                                       DateTime markToMarketToday,
                                                       int userID
                                                     )
            {
                DataTable _SaveSystemStatus = new DataTable();

                return _SaveSystemStatus;
            }

        }

        #endregion

        #region "Datos que se obtienen del Sistema"

        private class SourceSystem : Source
        {

            public override DataTable LoadLogStatus(DateTime date)
            {

                String _QueryLogStatus = "";

                #region "Query Load Log System"

                _QueryLogStatus += "SET NOCOUNT ON\n";

                _QueryLogStatus += "DECLARE @Date        DATETIME\n";

                _QueryLogStatus += "SET @Date = [@date]\n";

                _QueryLogStatus += "SELECT 'ID'               = id\n";
                _QueryLogStatus += "     , 'Date'             = datelog\n";
                _QueryLogStatus += "     , 'Process'          = processid\n";
                _QueryLogStatus += "     , 'StartingDate'     = startingdate\n";
                _QueryLogStatus += "     , 'FinishDate'       = finishdate\n";
                _QueryLogStatus += "     , 'StartingSaveDate' = startingsavedate\n";
                _QueryLogStatus += "     , 'FinishSaveDate'   = finishsavedate\n";
                _QueryLogStatus += "     , 'Status'           = status\n";
                _QueryLogStatus += "     , 'UserID'           = userid\n";
                _QueryLogStatus += "  FROM dbo.LogStatusProcess\n";
                _QueryLogStatus += " WHERE datelog = @Date\n";

                _QueryLogStatus += "SET NOCOUNT OFF\n";

                _QueryLogStatus = _QueryLogStatus.Replace("[@date]", "'" + date.ToString("yyyyMMdd") + "'");

                #endregion

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
                DataTable _LogStatus;

                try
                {
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryLogStatus);
                    _LogStatus = _Connect.QueryDataTable();
                    _LogStatus.TableName = "LogStatus";

                    if (_LogStatus.Rows.Count.Equals(0))
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
                    _LogStatus = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _LogStatus;

            }

            public override DataTable LoadLogSystemStatus(DateTime date)
            {

                string _QueryLoadLogSystemStatus;

                #region "Query Load Log System Status"

                _QueryLoadLogSystemStatus = "";
                _QueryLoadLogSystemStatus += "SET NOCOUNT ON\n";

                _QueryLoadLogSystemStatus += "DECLARE @Date        DATETIME\n";

                _QueryLoadLogSystemStatus += "SET @Date = [@Date]\n";

                _QueryLoadLogSystemStatus += "SELECT 'ID'                          = S.id\n";
                _QueryLoadLogSystemStatus += "     , 'DateStatus'                  = S.datestatus\n";
                _QueryLoadLogSystemStatus += "     , 'PortFolioYesterday'          = S.portfolioyesterday\n";
                _QueryLoadLogSystemStatus += "     , 'PortFolioToday'              = S.portfoliotoday\n";
                _QueryLoadLogSystemStatus += "     , 'PortFolioTomorrow'           = S.portfoliotomorrow\n";
                _QueryLoadLogSystemStatus += "     , 'PortFolioEndOfMonth'         = S.portfolioendofmonth\n";
                _QueryLoadLogSystemStatus += "     , 'PortFolioPreviousEndOfMonth' = S.portfoliopreviousendofmonth\n";
                _QueryLoadLogSystemStatus += "     , 'YieldYesterday'              = S.yieldyesterday\n";
                _QueryLoadLogSystemStatus += "     , 'YieldToday'                  = S.yieldtoday\n";
                _QueryLoadLogSystemStatus += "     , 'CurrencyYesterday'           = S.currencyyesterday\n";
                _QueryLoadLogSystemStatus += "     , 'CurrencyToday'               = S.currencytoday\n";
                _QueryLoadLogSystemStatus += "     , 'MarkToMarketYesterday'       = S.marktomarketyesterday\n";
                _QueryLoadLogSystemStatus += "     , 'MarkToMarketToday'           = S.marktomarkettoday\n";
                _QueryLoadLogSystemStatus += "     , 'StartingDate'                = S.startingdate\n";
                _QueryLoadLogSystemStatus += "     , 'FinishDate'                  = S.finishdate\n";
                _QueryLoadLogSystemStatus += "     , 'Status'                      = S.status\n";
                _QueryLoadLogSystemStatus += "     , 'UserID'                      = S.userid\n";
                _QueryLoadLogSystemStatus += "     , 'UserName'                    = U.name\n";
                _QueryLoadLogSystemStatus += "  FROM dbo.StatusSystem S\n";
                _QueryLoadLogSystemStatus += "       INNER JOIN dbo.UserTable U ON U.ID = S.userid\n";
                _QueryLoadLogSystemStatus += " WHERE S.datestatus                  = @Date\n";

                _QueryLoadLogSystemStatus += "SET NOCOUNT OFF\n";

                _QueryLoadLogSystemStatus = _QueryLoadLogSystemStatus.Replace("[@Date]", "'" + date.ToString("yyyyMMdd") + "'");

                #endregion

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
                DataTable _LoadLogSystemStatus;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryLoadLogSystemStatus);
                    _LoadLogSystemStatus = _Connect.QueryDataTable();
                    _LoadLogSystemStatus.TableName = "LoadLogSystemStatus";

                    if (_LoadLogSystemStatus.Rows.Count.Equals(0))
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
                    _LoadLogSystemStatus = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _LoadLogSystemStatus;

            }

            public override DataTable SaveLog(string logID, DateTime dateLog, int processID, int userID)
            {

                string _QueryLog;

                #region "Save Log"

                _QueryLog = "";
                _QueryLog += "SET NOCOUNT ON\n\n";

                _QueryLog += "DECLARE @LogID                          NUMERIC(18)\n";
                _QueryLog += "DECLARE @Date                           DATETIME\n";
                _QueryLog += "DECLARE @Process                        INT\n";
                _QueryLog += "DECLARE @UserID                         INT\n";
                _QueryLog += "DECLARE @Status                         INT\n\n";

                _QueryLog += "SET @LogID        = [@LogID]\n";
                _QueryLog += "SET @Date         = [@Date]\n";
                _QueryLog += "SET @Process      = [@Process]\n";
                _QueryLog += "SET @UserID       = [@UserID]\n\n";

                _QueryLog += "IF (@LogID = 0)\n";
                _QueryLog += "BEGIN\n";

                _QueryLog += "    DELETE dbo.LogStatusProcess WHERE datelog = @Date AND processid = @Process\n\n";

                _QueryLog += "    SET @LogID = CONVERT( NUMERIC(18), REPLACE( CONVERT( VARCHAR(10), @Date, 102 ), '.', '' ) ) * 100000000 + @Process\n\n";

                _QueryLog += "    INSERT INTO dbo.LogStatusProcess (     id, datelog, processid, startingdate, finishdate, startingsavedate, finishsavedate, status,  userid )\n";
                _QueryLog += "           VALUES                    ( @LogID,   @Date,  @Process,    GETDATE(),  GETDATE(),        GETDATE(),      GETDATE(),      1, @UserID )\n\n";

                _QueryLog += "END ELSE\n";
                _QueryLog += "BEGIN\n";
                _QueryLog += "    SELECT @Status = status\n";
                _QueryLog += "      FROM dbo.LogStatusProcess\n";
                _QueryLog += "     WHERE id         = @LogID\n\n";

                _QueryLog += "    IF @Status = 1\n";
                _QueryLog += "    BEGIN\n";
                _QueryLog += "        UPDATE dbo.LogStatusProcess\n";
                _QueryLog += "           SET finishdate       = GETDATE()\n";
                _QueryLog += "             , startingsavedate = GETDATE()\n";
                _QueryLog += "             , status           = 2\n";
                _QueryLog += "         WHERE id               = @LogID\n\n";

                _QueryLog += "    END ELSE\n";
                _QueryLog += "    BEGIN\n";
                _QueryLog += "        UPDATE dbo.LogStatusProcess\n";
                _QueryLog += "           SET finishsavedate = GETDATE()\n";
                _QueryLog += "             , status         = 0\n";
                _QueryLog += "         WHERE id             = @LogID\n\n";

                _QueryLog += "    END\n";

                _QueryLog += "END\n\n";

                _QueryLog += "SELECT 'ID'               = id\n";
                _QueryLog += "     , 'Date'             = datelog\n";
                _QueryLog += "     , 'Process'          = processid\n";
                _QueryLog += "     , 'StartingDate'     = startingdate\n";
                _QueryLog += "     , 'FinishDate'       = finishdate\n";
                _QueryLog += "     , 'StartingSaveDate' = startingsavedate\n";
                _QueryLog += "     , 'FinishSaveDate'   = finishsavedate\n";
                _QueryLog += "     , 'Status'           = status\n";
                _QueryLog += "     , 'UserID'           = userid\n";
                _QueryLog += "  FROM dbo.LogStatusProcess\n";
                _QueryLog += " WHERE id             = @LogID\n\n";

                _QueryLog += "SET NOCOUNT OFF\n";

                _QueryLog = _QueryLog.Replace("[@LogID]", logID);
                _QueryLog = _QueryLog.Replace("[@Date]", "'" + dateLog.ToString("yyyyMMdd") + "'");
                _QueryLog = _QueryLog.Replace("[@Process]", processID.ToString());
                _QueryLog = _QueryLog.Replace("[@UserID]", userID.ToString());

                #endregion

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
                DataTable _LogStatus;

                try
                {
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryLog);
                    _LogStatus = _Connect.QueryDataTable();
                    _LogStatus.TableName = "LogStatus";

                    if (_LogStatus.Rows.Count.Equals(0))
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
                    _LogStatus = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _LogStatus;

            }

            public override DataTable SaveSystemStatus(
                                                        string logID,
                                                        DateTime dateStatus,
                                                        DateTime portFolioYesterday,
                                                        DateTime portFolioToday,
                                                        DateTime portFolioTomorrow,
                                                        DateTime portFolioEndOfMonth,
                                                        DateTime portFolioPreviousEndOfMonth,
                                                        DateTime yieldYesterday,
                                                        DateTime yieldToday,
                                                        DateTime currencyYesterday,
                                                        DateTime currencyToday,
                                                        DateTime markToMarketYesterday,
                                                        DateTime markToMarketToday,
                                                        int userID
                                                      )
            {

                string _QuerySystemStatus;

                #region "Save Log System Status"

                _QuerySystemStatus = "";
                _QuerySystemStatus += "SET NOCOUNT ON\n\n";

                _QuerySystemStatus += "DECLARE @LogID                          NUMERIC(18)\n";
                _QuerySystemStatus += "DECLARE @Date                           DATETIME\n";
                _QuerySystemStatus += "DECLARE @PortFolioYesterday             DATETIME\n";
                _QuerySystemStatus += "DECLARE @PortFolioToday                 DATETIME\n";
                _QuerySystemStatus += "DECLARE @PortFolioTomorrow              DATETIME\n";
                _QuerySystemStatus += "DECLARE @PortFolioEndOfMonth            DATETIME\n";
                _QuerySystemStatus += "DECLARE @PortFolioPreviousEndOfMonth    DATETIME\n";
                _QuerySystemStatus += "DECLARE @YieldYesterday                 DATETIME\n";
                _QuerySystemStatus += "DECLARE @YieldToday                     DATETIME\n";
                _QuerySystemStatus += "DECLARE @CurrencyYesterday              DATETIME\n";
                _QuerySystemStatus += "DECLARE @CurrencyToday                  DATETIME\n";
                _QuerySystemStatus += "DECLARE @MarkToMarketYesterday          DATETIME\n";
                _QuerySystemStatus += "DECLARE @MarkToMarketToday              DATETIME\n";
                _QuerySystemStatus += "DECLARE @UserID                         INT\n\n";

                _QuerySystemStatus += "SET @LogID                       = [@LogID]\n";
                _QuerySystemStatus += "SET @Date                        = [@Date]\n";
                _QuerySystemStatus += "SET @PortFolioYesterday          = [@PortFolioYesterday]\n";
                _QuerySystemStatus += "SET @PortFolioToday              = [@PortFolioToday]\n";
                _QuerySystemStatus += "SET @PortFolioTomorrow           = [@PortFolioTomorrow]\n";
                _QuerySystemStatus += "SET @PortFolioEndOfMonth         = [@PortFolioEndOfMonth]\n";
                _QuerySystemStatus += "SET @PortFolioPreviousEndOfMonth = [@PortFolioPreviousEndOfMonth]\n";
                _QuerySystemStatus += "SET @YieldYesterday              = [@YieldYesterday]\n";
                _QuerySystemStatus += "SET @YieldToday                  = [@YieldToday]\n";
                _QuerySystemStatus += "SET @CurrencyYesterday           = [@CurrencyYesterday]\n";
                _QuerySystemStatus += "SET @CurrencyToday               = [@CurrencyToday]\n";
                _QuerySystemStatus += "SET @MarkToMarketYesterday       = [@MarkToMarketYesterday]\n";
                _QuerySystemStatus += "SET @MarkToMarketToday           = [@MarkToMarketToday]\n";
                _QuerySystemStatus += "SET @UserID                      = [@UserID]\n\n";

                _QuerySystemStatus += "IF (@LogID = 0)\n";
                _QuerySystemStatus += "BEGIN\n";

                _QuerySystemStatus += "    DELETE dbo.StatusSystem WHERE datestatus = @Date\n\n";

                _QuerySystemStatus += "    SET @LogID = CONVERT( NUMERIC(18), REPLACE( CONVERT( VARCHAR(10), @Date, 102 ), '.', '' ) ) * 100000000\n\n";

                _QuerySystemStatus += "    INSERT INTO dbo.StatusSystem ( id, datestatus, portfolioyesterday, portfoliotoday, portfoliotomorrow, portfolioendofmonth, portfoliopreviousendofmonth\n";
                _QuerySystemStatus += "                                 , yieldyesterday, yieldtoday, currencyyesterday, currencytoday, marktomarketyesterday, marktomarkettoday, status\n";
                _QuerySystemStatus += "                                 , startingdate, userid )\n";
                _QuerySystemStatus += "           VALUES                ( @LogID, @Date, @PortFolioYesterday, @PortFolioToday, @PortFolioTomorrow, @PortFolioEndOfMonth, @PortFolioPreviousEndOfMonth\n";
                _QuerySystemStatus += "                                 , @YieldYesterday, @YieldToday, @CurrencyYesterday, @CurrencyToday, @MarkToMarketYesterday, @MarkToMarketToday, 1\n";
                _QuerySystemStatus += "                                 , GETDATE(), @UserID )\n\n";

                _QuerySystemStatus += "END ELSE\n";
                _QuerySystemStatus += "BEGIN\n";

                _QuerySystemStatus += "    UPDATE dbo.StatusSystem\n";
                _QuerySystemStatus += "       SET status     = 0\n";
                _QuerySystemStatus += "         , finishdate = GETDATE()\n";
                _QuerySystemStatus += "     WHERE id         = @LogID\n\n";

                _QuerySystemStatus += "END\n\n";

                _QuerySystemStatus += "SELECT 'ID'                          = id\n";
                _QuerySystemStatus += "     , 'DateStatus'                  = datestatus\n";
                _QuerySystemStatus += "     , 'PortFolioYesterday'          = portfolioyesterday\n";
                _QuerySystemStatus += "     , 'PortFolioToday'              = portfoliotoday\n";
                _QuerySystemStatus += "     , 'PortFolioTomorrow'           = portfoliotomorrow\n";
                _QuerySystemStatus += "     , 'PortFolioEndOfMonth'         = portfolioendofmonth\n";
                _QuerySystemStatus += "     , 'PortFolioPreviousEndOfMonth' = portfoliopreviousendofmonth\n";
                _QuerySystemStatus += "     , 'YieldYesterday'              = yieldyesterday\n";
                _QuerySystemStatus += "     , 'YieldToday'                  = yieldtoday\n";
                _QuerySystemStatus += "     , 'CurrencyYesterday'           = currencyyesterday\n";
                _QuerySystemStatus += "     , 'CurrencyToday'               = currencytoday\n";
                _QuerySystemStatus += "     , 'MarkToMarketYesterday'       = marktomarketyesterday\n";
                _QuerySystemStatus += "     , 'MarkToMarketToday'           = marktomarkettoday\n";
                _QuerySystemStatus += "     , 'StartingDate'                = startingdate\n";
                _QuerySystemStatus += "     , 'FinishDate'                  = finishdate\n";
                _QuerySystemStatus += "     , 'Status'                      = status\n";
                _QuerySystemStatus += "     , 'UserID'                      = userid\n";
                _QuerySystemStatus += "  FROM dbo.StatusSystem\n";
                _QuerySystemStatus += " WHERE id             = @LogID\n\n";

                _QuerySystemStatus += "SET NOCOUNT OFF\n";

                _QuerySystemStatus = _QuerySystemStatus.Replace("[@LogID]", logID);
                _QuerySystemStatus = _QuerySystemStatus.Replace("[@Date]", "'" + dateStatus.ToString("yyyyMMdd") + "'");
                _QuerySystemStatus = _QuerySystemStatus.Replace("[@PortFolioYesterday]", "'" + portFolioYesterday.ToString("yyyyMMdd") + "'");
                _QuerySystemStatus = _QuerySystemStatus.Replace("[@PortFolioToday]", "'" + portFolioToday.ToString("yyyyMMdd") + "'");
                _QuerySystemStatus = _QuerySystemStatus.Replace("[@PortFolioTomorrow]", "'" + portFolioTomorrow.ToString("yyyyMMdd") + "'");
                _QuerySystemStatus = _QuerySystemStatus.Replace("[@PortFolioEndOfMonth]", "'" + portFolioEndOfMonth.ToString("yyyyMMdd") + "'");
                _QuerySystemStatus = _QuerySystemStatus.Replace("[@PortFolioPreviousEndOfMonth]", "'" + portFolioPreviousEndOfMonth.ToString("yyyyMMdd") + "'");
                _QuerySystemStatus = _QuerySystemStatus.Replace("[@YieldYesterday]", "'" + yieldYesterday.ToString("yyyyMMdd") + "'");
                _QuerySystemStatus = _QuerySystemStatus.Replace("[@YieldToday]", "'" + yieldToday.ToString("yyyyMMdd") + "'");
                _QuerySystemStatus = _QuerySystemStatus.Replace("[@CurrencyYesterday]", "'" + currencyYesterday.ToString("yyyyMMdd") + "'");
                _QuerySystemStatus = _QuerySystemStatus.Replace("[@CurrencyToday]", "'" + currencyToday.ToString("yyyyMMdd") + "'");
                _QuerySystemStatus = _QuerySystemStatus.Replace("[@MarkToMarketYesterday]", "'" + markToMarketYesterday.ToString("yyyyMMdd") + "'");
                _QuerySystemStatus = _QuerySystemStatus.Replace("[@MarkToMarketToday]", "'" + markToMarketToday.ToString("yyyyMMdd") + "'");
                _QuerySystemStatus = _QuerySystemStatus.Replace("[@UserID]", userID.ToString());

                #endregion

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
                DataTable _LoadLogSystemStatus;

                try
                {
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QuerySystemStatus);
                    _LoadLogSystemStatus = _Connect.QueryDataTable();
                    _LoadLogSystemStatus.TableName = "LogStatus";

                    if (_LoadLogSystemStatus.Rows.Count.Equals(0))
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
                    _LoadLogSystemStatus = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _LoadLogSystemStatus;

            }

        }

        #endregion

        #region "Datos que se obtienen del Sistema"

        private class SourceCurrencyValueAccount : Source
        {
        }

        #endregion

        #region "Datos que se obtinen del Bloomberg"

        private class SourceBloomberg : Source
        {
        }

        #endregion

        #region "Datos que se obtinen de Excel"

        private class SourceExcel : Source
        {
        }

        #endregion

        #region "Datos que se obtinen de XML"

        private class SourceXML : Source
        {
        }

        #endregion

        #endregion

    }

}
