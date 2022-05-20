using System;
using System.Collections;
using System.Text;
using System.Data;


namespace cData.PortFolio
{

    public class PortFolioTuring
    {

        #region "Atributos Privados"

        private enumStatus mStatus;
        private enumSource mSource;
        private String mError;
        private String mStack;

        #endregion

        #region "Constructores"

        public PortFolioTuring()
        {
            Set(enumSource.System);
        }

        public PortFolioTuring(enumSource id)
        {
            Set(id);
        }

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

        #region "Metodos Publicos"

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

        public DataTable LoadPortFolio(int userCreator)
        {

            DataTable _PortFolioData = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                case enumSource.CurrencyValueAccount:
                    SourceSystem _System = new SourceSystem();

                    _PortFolioData = _System.LoadPortFolio(userCreator);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _PortFolioData = _Bloomberg.LoadPortFolio(userCreator);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _PortFolioData = _Excel.LoadPortFolio(userCreator);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                case enumSource.XML:
                    SourceXML _XML = new SourceXML();

                    _PortFolioData = _XML.LoadPortFolio(userCreator);
                    mStatus = _XML.Status;
                    mError = _XML.Error;
                    mStack = _XML.Stack;

                    break;

                default:
                    break;
            }

            return _PortFolioData;

        }

        public DataTable LoadSensibilitiesYield(DateTime portFolioDate, int portFolio, string conditions)
        {

            DataTable _PortFolioData = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                case enumSource.CurrencyValueAccount:
                    SourceSystem _System = new SourceSystem();

                    _PortFolioData = _System.LoadSensibilitiesYield(portFolioDate, portFolio, conditions);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _PortFolioData = _Bloomberg.LoadSensibilitiesYield(portFolioDate, portFolio, conditions);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _PortFolioData = _Excel.LoadSensibilitiesYield(portFolioDate, portFolio, conditions);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                case enumSource.XML:
                    SourceXML _XML = new SourceXML();

                    _PortFolioData = _XML.LoadSensibilitiesYield(portFolioDate, portFolio, conditions);
                    mStatus = _XML.Status;
                    mError = _XML.Error;
                    mStack = _XML.Stack;

                    break;

                default:
                    break;
            }

            return _PortFolioData;

        }

        public DataTable LoadSensibilitiesResult(DateTime portFolioDate, int portFolio, string conditions)
        {

            DataTable _PortFolioData = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                case enumSource.CurrencyValueAccount:
                    SourceSystem _System = new SourceSystem();

                    _PortFolioData = _System.LoadSensibilitiesResult(portFolioDate, portFolio, conditions);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _PortFolioData = _Bloomberg.LoadSensibilitiesResult(portFolioDate, portFolio, conditions);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _PortFolioData = _Excel.LoadSensibilitiesResult(portFolioDate, portFolio, conditions);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                case enumSource.XML:
                    SourceXML _XML = new SourceXML();

                    _PortFolioData = _XML.LoadSensibilitiesResult(portFolioDate, portFolio, conditions);
                    mStatus = _XML.Status;
                    mError = _XML.Error;
                    mStack = _XML.Stack;

                    break;

                default:
                    break;
            }

            return _PortFolioData;

        }

        public DataTable LoadSensibilitiesValuator(DateTime portFolioDate, int portFolio, string conditions)
        {

            DataTable _PortFolioData = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                case enumSource.CurrencyValueAccount:
                    SourceSystem _System = new SourceSystem();

                    _PortFolioData = _System.LoadSensibilitiesValuator(portFolioDate, portFolio, conditions);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _PortFolioData = _Bloomberg.LoadSensibilitiesValuator(portFolioDate, portFolio, conditions);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _PortFolioData = _Excel.LoadSensibilitiesValuator(portFolioDate, portFolio, conditions);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                case enumSource.XML:
                    SourceXML _XML = new SourceXML();

                    _PortFolioData = _XML.LoadSensibilitiesValuator(portFolioDate, portFolio, conditions);
                    mStatus = _XML.Status;
                    mError = _XML.Error;
                    mStack = _XML.Stack;

                    break;

                default:
                    break;
            }

            return _PortFolioData;

        }

        public DataTable LoadSensibilitiesConfiguration(DateTime portFolioDate, int portFolio)
        {

            DataTable _PortFolioData = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                case enumSource.CurrencyValueAccount:
                    SourceSystem _System = new SourceSystem();

                    _PortFolioData = _System.LoadSensibilitiesConfiguration(portFolioDate, portFolio);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _PortFolioData = _Bloomberg.LoadSensibilitiesConfiguration(portFolioDate, portFolio);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _PortFolioData = _Excel.LoadSensibilitiesConfiguration(portFolioDate, portFolio);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                case enumSource.XML:
                    SourceXML _XML = new SourceXML();

                    _PortFolioData = _XML.LoadSensibilitiesConfiguration(portFolioDate, portFolio);
                    mStatus = _XML.Status;
                    mError = _XML.Error;
                    mStack = _XML.Stack;

                    break;

                default:
                    break;
            }

            return _PortFolioData;

        }

        public DataTable LoadFilter()
        {

            DataTable _FilterData = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                case enumSource.CurrencyValueAccount:
                    SourceSystem _System = new SourceSystem();

                    _FilterData = _System.LoadFilter();
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _FilterData = _Bloomberg.LoadFilter();
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _FilterData = _Excel.LoadFilter();
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                case enumSource.XML:
                    SourceXML _XML = new SourceXML();

                    _FilterData = _XML.LoadFilter();
                    mStatus = _XML.Status;
                    mError = _XML.Error;
                    mStack = _XML.Stack;

                    break;

                default:
                    break;
            }

            return _FilterData;

        }

        public DataTable LoadFilterOperation(DateTime portFolioDate)
        {

            DataTable _FilterOperation = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                case enumSource.CurrencyValueAccount:
                    SourceSystem _System = new SourceSystem();

                    _FilterOperation = _System.LoadFilterOperation(portFolioDate);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _FilterOperation = _Bloomberg.LoadFilterOperation(portFolioDate);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _FilterOperation = _Excel.LoadFilterOperation(portFolioDate);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                case enumSource.XML:
                    SourceXML _XML = new SourceXML();

                    _FilterOperation = _XML.LoadFilterOperation(portFolioDate);
                    mStatus = _XML.Status;
                    mError = _XML.Error;
                    mStack = _XML.Stack;

                    break;

                default:
                    break;
            }

            return _FilterOperation;

        }

        public DataTable LoadSensibilities(DateTime portFolioDate, string conditions)
        {

            DataTable _SensibilitiesData = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                case enumSource.CurrencyValueAccount:
                    SourceSystem _System = new SourceSystem();

                    _SensibilitiesData = _System.LoadSensibilities(portFolioDate, conditions);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _SensibilitiesData = _Bloomberg.LoadSensibilities(portFolioDate, conditions);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _SensibilitiesData = _Excel.LoadSensibilities(portFolioDate, conditions);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                case enumSource.XML:
                    SourceXML _XML = new SourceXML();

                    _SensibilitiesData = _XML.LoadSensibilities(portFolioDate, conditions);
                    mStatus = _XML.Status;
                    mError = _XML.Error;
                    mStack = _XML.Stack;

                    break;

                default:
                    break;
            }

            return _SensibilitiesData;

        }

        public DataSet LoadSensibilitiesData(DateTime portFolioDate, string system, string conditions)
        {

            DataSet _SensibilitiesData = new DataSet();

            switch (mSource)
            {
                case enumSource.System:
                case enumSource.CurrencyValueAccount:
                    SourceSystem _System = new SourceSystem();

                    _SensibilitiesData = _System.LoadSensibilitiesData(portFolioDate, system, conditions);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _SensibilitiesData = _Bloomberg.LoadSensibilitiesData(portFolioDate, system, conditions);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _SensibilitiesData = _Excel.LoadSensibilitiesData(portFolioDate, system, conditions);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                case enumSource.XML:
                    SourceXML _XML = new SourceXML();

                    _SensibilitiesData = _XML.LoadSensibilitiesData(portFolioDate, system, conditions);
                    mStatus = _XML.Status;
                    mError = _XML.Error;
                    mStack = _XML.Stack;

                    break;

                default:
                    break;
            }

            return _SensibilitiesData;

        }

        public DataTable LoadSummary(DateTime portFolioDateToday, DateTime portFolioDateYesterday, string conditions)
        {

            DataTable _SensibilitiesData = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                case enumSource.CurrencyValueAccount:
                    SourceSystem _System = new SourceSystem();

                    _SensibilitiesData = _System.LoadSummary(portFolioDateToday, portFolioDateYesterday, conditions);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _SensibilitiesData = _Bloomberg.LoadSummary(portFolioDateToday, portFolioDateYesterday, conditions);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _SensibilitiesData = _Excel.LoadSummary(portFolioDateToday, portFolioDateYesterday, conditions);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                case enumSource.XML:
                    SourceXML _XML = new SourceXML();

                    _SensibilitiesData = _XML.LoadSummary(portFolioDateToday, portFolioDateYesterday, conditions);
                    mStatus = _XML.Status;
                    mError = _XML.Error;
                    mStack = _XML.Stack;

                    break;

                default:
                    break;
            }

            return _SensibilitiesData;

        }

        public DataTable LoadStandardTerm()
        {

            DataTable _StandardTerm = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                case enumSource.CurrencyValueAccount:
                    SourceSystem _System = new SourceSystem();

                    _StandardTerm = _System.LoadStandardTerm();
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _StandardTerm = _Bloomberg.LoadStandardTerm();
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _StandardTerm = _Excel.LoadStandardTerm();
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                case enumSource.XML:
                    SourceXML _XML = new SourceXML();

                    _StandardTerm = _XML.LoadStandardTerm();
                    mStatus = _XML.Status;
                    mError = _XML.Error;
                    mStack = _XML.Stack;

                    break;

                default:
                    break;
            }

            return _StandardTerm;

        }

        public DataTable LoadExchange(DateTime portFolioDate)
        {

            DataTable _Exchange = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                case enumSource.CurrencyValueAccount:
                    SourceSystem _System = new SourceSystem();

                    _Exchange = _System.LoadExchange(portFolioDate);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _Exchange = _Bloomberg.LoadExchange(portFolioDate);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _Exchange = _Excel.LoadExchange(portFolioDate);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                case enumSource.XML:
                    SourceXML _XML = new SourceXML();

                    _Exchange = _XML.LoadExchange(portFolioDate);
                    mStatus = _XML.Status;
                    mError = _XML.Error;
                    mStack = _XML.Stack;

                    break;

                default:
                    break;
            }

            return _Exchange;

        }

        public DataSet LoadReportMonthlyResult(string system, string conditions)
        {

            DataSet _SensibilitiesData = new DataSet();

            switch (mSource)
            {
                case enumSource.System:
                case enumSource.CurrencyValueAccount:
                    SourceSystem _System = new SourceSystem();

                    _SensibilitiesData = _System.LoadReportMonthlyResult(system, conditions);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _SensibilitiesData = _Bloomberg.LoadReportMonthlyResult(system, conditions);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _SensibilitiesData = _Excel.LoadReportMonthlyResult(system, conditions);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                case enumSource.XML:
                    SourceXML _XML = new SourceXML();

                    _SensibilitiesData = _XML.LoadReportMonthlyResult(system, conditions);
                    mStatus = _XML.Status;
                    mError = _XML.Error;
                    mStack = _XML.Stack;

                    break;

                default:
                    break;
            }

            return _SensibilitiesData;

        }

        public DataSet LoadFlow(string system, DateTime processdate, string conditions)
        {

            DataSet _SensibilitiesData = new DataSet();

            switch (mSource)
            {
                case enumSource.System:
                case enumSource.CurrencyValueAccount:
                    SourceSystem _System = new SourceSystem();

                    _SensibilitiesData = _System.LoadFlow(system, processdate, conditions);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _SensibilitiesData = _Bloomberg.LoadFlow(system, processdate, conditions);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _SensibilitiesData = _Excel.LoadFlow(system, processdate, conditions);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                case enumSource.XML:
                    SourceXML _XML = new SourceXML();

                    _SensibilitiesData = _XML.LoadFlow(system, processdate, conditions);
                    mStatus = _XML.Status;
                    mError = _XML.Error;
                    mStack = _XML.Stack;

                    break;

                default:
                    break;
            }

            return _SensibilitiesData;

        }

        #endregion

        #region "Metodos Privados"

        protected void Set(enumSource id)
        {
            mStatus = enumStatus.Initialize;
            mSource = id;
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
            }

            public virtual DataTable LoadPortFolio(int userCreator)
            {
                DataTable _PortFolioData = new DataTable();

                return _PortFolioData;
            }

            public virtual DataTable LoadSensibilitiesYield(DateTime portFolioDate, int portFolio, string conditions)
            {
                DataTable _PortFolioData = new DataTable();

                return _PortFolioData;
            }

            public virtual DataTable LoadSensibilitiesResult(DateTime portFolioDate, int portFolio, string conditions)
            {
                DataTable _PortFolioData = new DataTable();

                return _PortFolioData;
            }

            public virtual DataTable LoadSensibilitiesValuator(DateTime portFolioDate, int portFolio, string conditions)
            {
                DataTable _PortFolioData = new DataTable();

                return _PortFolioData;
            }

            public virtual DataTable LoadSensibilitiesConfiguration(DateTime portFolioDate, int portFolio)
            {
                DataTable _PortFolioData = new DataTable();

                return _PortFolioData;
            }

            public virtual DataTable LoadFilter()
            {
                DataTable _FilterData = new DataTable();

                return _FilterData;
            }

            public virtual DataTable LoadFilterOperation(DateTime portFolioDate)
            {
                DataTable _SensibilitiesData = new DataTable();

                return _SensibilitiesData;
            }

            public virtual DataTable LoadSensibilities(DateTime portFolioDate, string conditions)
            {
                DataTable _SensibilitiesData = new DataTable();

                return _SensibilitiesData;
            }

            public virtual DataSet LoadSensibilitiesData(DateTime portFolioDate, string system, string conditions)
            {
                DataSet _SensibilitiesData = new DataSet();

                return _SensibilitiesData;
            }

            public virtual DataTable LoadSummary(DateTime portFolioDateToday, DateTime portFolioDateYesterday, string conditions)
            {
                DataTable _Summary = new DataTable();

                return _Summary;
            }

            public virtual DataTable LoadStandardTerm()
            {
                DataTable _StandardTerm = new DataTable();

                return _StandardTerm;
            }

            public virtual DataTable LoadExchange(DateTime portFolioDate)
            {
                DataTable _Exchange = new DataTable();

                return _Exchange;
            }

            public virtual DataSet LoadReportMonthlyResult(string system, string conditions)
            {
                return new DataSet();
            }

            public virtual DataSet LoadFlow(string system, DateTime processdate, string conditions)
            {
                return new DataSet();
            }

        }

        #endregion

        #region "Datos que se obtienen del Sistema"

        private class SourceSystem : Source
        {

            public override DataTable LoadPortFolio(int userCreator)
            {

                String _QueryRate = "SELECT 'ID'          = id" +
                                    "     , 'Name'        = name" +
                                    "     , 'Description' = description" +
                                    "     , 'Public'      = [public]" +
                                    "  FROM dbo.PortFolioMaster" +
                                    " WHERE usercreator   = " + userCreator.ToString() +
                                    "    OR [public]      = 'E'";
                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
                DataTable _PortFolioData;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryRate);
                    _PortFolioData = _Connect.QueryDataTable();
                    _PortFolioData.TableName = "SensibilitiesYield";

                    if (_PortFolioData.Rows.Count.Equals(0))
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
                    _PortFolioData = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _PortFolioData;
            }

            public override DataTable LoadSensibilitiesYield(DateTime portFolioDate, int portFolioID, string conditions)
            {

                String _QueryRate = "SET NOCOUNT ON;"+
                                    "SELECT 'System'                      = SD.system" +
                                    "     , 'OperationNumber'             = SD.operationnumber" +
                                    "     , 'OperationID'                 = SD.operationid" +
                                    "  INTO #tmpFiltro" +
                                    "  FROM dbo.PortFolioDetail                  PFD" +
                                    "       INNER JOIN dbo.Module                M      ON PFD.moduleid                         = M.ID" +
                                    "       INNER JOIN dbo.BookAndPortFolioRules BAPFR  ON BAPFR.moduleid                       = PFD.moduleid" +
                                    "                                                  AND PFD.bookandportfoliorulesid         in ( 0, BAPFR.id )" +
                                    "       INNER JOIN dbo.FinancialPortFolio    FPF    ON FPF.bookandportfoliorulesid          = BAPFR.id" +
                                    "                                                  AND PFD.financialportfolioid            in ( 0, FPF.id )" +
                                    "       INNER JOIN dbo.Product               P      ON P.financialportfolioid               = FPF.id" +
                                    "                                                  AND PFD.productid                       in ( 0, P.id )" +
                                    "       INNER JOIN dbo.Family                F      ON F.productid                          = P.id" +
                                    "                                                  AND PFD.familyid                        in ( 0, F.id )" +
                                    "       LEFT JOIN dbo.Details                D      ON D.familyid                           = F.id" +
                                    "                                                  AND PFD.detailid                        in ( 0, D.id )" +
                                    "       INNER JOIN dbo.SensibilitiesData     SD     ON SD.sensibilitiesdate                 = '" + portFolioDate.ToString("yyyyMMdd") + "'" +
                                    "                                                  AND SD.system                            = P.systemid" +
                                    "                                                  AND SD.bookid                            = BAPFR.book" +
                                    "                                                  AND SD.portfoliorulesid                 in ( BAPFR.portfoliorules1, BAPFR.portfoliorules2 )" +
                                    "                                                  AND SD.financialportfolioid              = FPF.financialportfolio " +
                                    "                                                  AND SD.productid                         = P.productid" +
                                    "                                                  AND F.primarycurrency                   in ( 0, SD.primarycurrencyid )" +
                                    "                                                  AND F.secondcurrency                    in ( 0, SD.secondcurrencyid )" +
                                    "                                                  AND F.primaryrate                       in ( 0, SD.primaryrateid )" +
                                    "                                                  AND F.secondrate                        in ( 0, SD.secondrateid )" +
                                    "                                                  AND F.instruments                       in ( '', SD.familyid )" +
                                    "                                                  AND ISNULL( D.mnemonicsmask, '' )       in ( '', SD.mnemonicsmask )" +
                                    "                                                  AND ISNULL( D.issuecode, 0 )            in ( 0, SD.issueid )" +
                                    " WHERE PFD.portfolioid              = " + portFolioID.ToString();

                if (!conditions.Equals(""))
                {
                    _QueryRate += " AND (" + conditions + ")";
                }

                _QueryRate += ";";

                _QueryRate += "SELECT 'YieldName'                  = SY.yieldname" +
                              "      , 'Family'                    = SY.Family" +
                              "      , 'Term'                      = SY.term" +
                              "      , 'Sensibilities'             = SUM( SY.sensibilities )" +
                              "      , 'Estimation'                = SUM( SY.estimationvalue )" +
                              "  FROM dbo.SensibilitiesYield SY" +
                              "       INNER JOIN #tmpFiltro     F  ON SY.system           = F.system" +
                              "                                   AND SY.operationnumber  = F.operationnumber" +
                              "                                   AND F.operationid      in ( 0, SY.operationid )" +
                              " WHERE SY.sensibilitiesdate         = '" + portFolioDate.ToString("yyyyMMdd") + "'" +
                              " GROUP BY" +
                              "       SY.yieldname" +
                              "     , SY.[system]" +
                              "     , SY.family" +
                              "     , SY.term" +
                              " ORDER BY" +
                              "       SY.yieldname" +
                              "     , SY.[system]" +
                              "     , SY.family" +
                              "     , SY.term;" +
                              "DROP TABLE #tmpFiltro;" +
                              "SET NOCOUNT OFF;";

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
                DataTable _PortFolioData;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryRate);
                    _PortFolioData = _Connect.QueryDataTable();
                    _PortFolioData.TableName = "SensibilitiesYield";

                    if (_PortFolioData.Rows.Count.Equals(0))
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
                    _PortFolioData = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _PortFolioData;
            }

            public override DataTable LoadSensibilitiesResult(DateTime portFolioDate, int portFolio, string conditions)
            {

                String _QueryRate = "";
                _QueryRate = "SET NOCOUNT OFF;";
                _QueryRate += "SELECT 'System'                      = SD.system" +
                              "     , 'OperationNumber'             = SD.operationnumber" +
                              "     , 'OperationID'                 = SD.operationid" +
                              "  INTO #tmpFiltro" +
                              "  FROM dbo.PortFolioDetail                  PFD" +
                              "       INNER JOIN dbo.Module                M      ON PFD.moduleid                        = M.ID" +
                              "       INNER JOIN dbo.BookAndPortFolioRules BAPFR  ON BAPFR.moduleid                      = PFD.moduleid" +
                              "                                                  AND PFD.bookandportfoliorulesid        in ( 0, BAPFR.id )" +
                              "       INNER JOIN dbo.FinancialPortFolio    FPF    ON FPF.bookandportfoliorulesid         = BAPFR.id" +
                              "                                                  AND PFD.financialportfolioid           in ( 0, FPF.id )" +
                              "       INNER JOIN dbo.Product               P      ON P.financialportfolioid              = FPF.id" +
                              "                                                  AND PFD.productid                      in ( 0, P.id )" +
                              "       INNER JOIN dbo.Family                F      ON F.productid                         = P.id" +
                              "                                                  AND PFD.familyid                       in ( 0, F.id )" +
                              "       LEFT JOIN dbo.Details                D      ON D.familyid                          = F.id" +
                              "                                                  AND PFD.detailid                       in ( 0, D.id )" +
                              "       INNER JOIN dbo.SensibilitiesData     SD     ON SD.sensibilitiesdate                = '" + portFolioDate.ToString("yyyyMMdd") + "'" +
                              "                                                  AND SD.system                           = P.systemid" +
                              "                                                  AND SD.bookid                           = BAPFR.book" +
                              "                                                  AND SD.portfoliorulesid                in ( BAPFR.portfoliorules1, BAPFR.portfoliorules2 )" +
                              "                                                  AND SD.financialportfolioid             = FPF.financialportfolio" +
                              "                                                  AND SD.productid                        = P.productid" +
                              "                                                  AND F.primarycurrency                  in ( 0, SD.primarycurrencyid )" +
                              "                                                  AND F.secondcurrency                   in ( 0, SD.secondcurrencyid )" +
                              "                                                  AND F.primaryrate                      in ( 0, SD.primaryrateid )" +
                              "                                                  AND F.secondrate                       in ( 0, SD.secondrateid )" +
                              "                                                  AND F.instruments                      in ( '', SD.familyid )" +
                              "                                                  AND ISNULL( D.mnemonicsmask, '' )      in ( '', SD.mnemonicsmask )" +
                              "                                                  AND ISNULL( D.issuecode, 0 )           in ( 0, SD.issueid )" +
                              " WHERE PFD.portfolioid              = " + portFolio.ToString();

                if (!conditions.Equals(""))
                {
                    _QueryRate += " AND (" + conditions + ")";
                }

                _QueryRate += ";";

                _QueryRate += "DECLARE @Sensibilities    FLOAT;" +
                              "DECLARE @Estimation       FLOAT;" +
                              "SELECT @Sensibilities                = SUM( SY.sensibilities )" +
                              "     , @Estimation                   = SUM( SY.estimationvalue )" +
                              "  FROM dbo.SensibilitiesYield SY" +
                              "       INNER JOIN #tmpFiltro     F  ON SY.system          = F.system" +
                              "                                   AND SY.operationnumber = F.operationnumber" +
                              "                                   AND SY.operationid     = F.operationid" +
                              " WHERE SY.sensibilitiesdate          = '" + portFolioDate.ToString("yyyyMMdd") + "';";

                _QueryRate += "SELECT 'MarktoMarketValueYesterday'  = ISNULL( SUM( SD.marktomarketvalueyesterday ), 0 )" +
                              "     , 'MarktoMarketValueToday'      = ISNULL( SUM( SD.marktomarketvaluetoday ), 0 )" +
                              "     , 'TimeDecayValue'              = ISNULL( SUM( SD.marktomarketvaluetimedecay ), 0 )" +
                              "     , 'ExchangeRateValue'           = ISNULL( SUM( SD.marktomarketvalueexchangerate ), 0 )" +
                              "     , 'EffectRateValue'             = ISNULL( SUM( SD.marktomarketvalueeffectrate ), 0 )" +
                              "     , 'MarktoMarketRateEndMonth'    = ISNULL( SUM( SD.marktomarketrateendmonth ), 0 )" +
                              "     , 'PurchaseValue'               = ISNULL( SUM( SD.purchasevalue ), 0 )" +
                              "     , 'PresentValueOriginSystem'    = ISNULL( SUM( SD.presentvalueoriginsystem ), 0 )" +
                              "     , 'FairValueAssetSystem'        = ISNULL( SUM( SD.fairvalueassetsystem ), 0 )" +
                              "     , 'FairValueLiabilitiesSystem'  = ISNULL( SUM( SD.fairvalueliabilitiessystem ), 0 )" +
                              "     , 'FairValueNetSystem'          = ISNULL( SUM( SD.fairvaluenetsystem ), 0 )" +
                              "     , 'AccruedIntrestSystem'        = ISNULL( SUM( SD.accruedinterestsystem ), 0 )" +
                              "     , 'DailyInterestSystem'         = ISNULL( SUM( SD.dailyinterestsystem ), 0 )" +
                              "     , 'MonthlyInterestSystem'       = ISNULL( SUM( SD.monthlyinterestsystem ), 0 )" +
                              "     , 'AccruedAdjustmentSystem'     = ISNULL( SUM( SD.accruedadjustmentsystem ), 0 )" +
                              "     , 'DailyAdjustmentSystem'       = ISNULL( SUM( SD.dailyadjustmentsystem ), 0 )" +
                              "     , 'MonthlyAdjustmentSystem'     = ISNULL( SUM( SD.monthlyadjustmentsystem ), 0 )" +
                              "     , 'MacaulayDurationSystem'      = ISNULL( SUM( SD.macaulaydurationsystem ), 0 )" +
                              "     , 'ModifiedDurationSystem'      = ISNULL( SUM( SD.modifieddurationsystem ), 0 )" +
                              "     , 'Sensibilities'               = ISNULL( @Sensibilities, 0 )" +
                              "     , 'Estimation'                  = ISNULL( @Estimation, 0 )" +
                              "  FROM dbo.SensibilitiesData     SD" +
                              "       INNER JOIN #tmpFiltro     F    ON SD.system           = F.system" +
                              "                                     AND SD.operationnumber  = F.operationnumber" +
                              "                                     AND F.operationid      in ( 0, SD.operationid )" +
                              " WHERE SD.sensibilitiesdate         = '" + portFolioDate.ToString("yyyyMMdd") + "';";

                _QueryRate += "DROP TABLE #tmpFiltro;";
                _QueryRate += "SET NOCOUNT OFF;";

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
                DataTable _PortFolioData;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryRate);
                    _PortFolioData = _Connect.QueryDataTable();
                    _PortFolioData.TableName = "OperationView";

                    if (_PortFolioData.Rows.Count.Equals(0))
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
                    _PortFolioData = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _PortFolioData;
            }

            public override DataTable LoadSensibilitiesValuator(DateTime portFolioDate, int portFolio, string conditions)
            {

                String _QueryRate = "SELECT 'System'                      = M.description" +
                                    "     , 'BookAndPortFolioRules'       = BAPFR.description" +
                                    "     , 'FinancialPortFolio'          = FPF.description" +
                                    "     , 'Product'                     = P.description" +
                                    "     , 'Family'                      = F.description" +
                                    "     , 'Detail'                      = D.description" +
                                    "     , 'IssueID'                     = SD.issueid" +
                                    "     , 'ExpiryDate'                  = SD.expirydate" +
                                    "     , 'OperationNumber'             = SD.operationnumber" +
                                    "     , 'OperationID'                 = SD.operationid" +
                                    "     , 'CustomerID'                  = SD.customerid" +
                                    "     , 'CustomerCode'                = SD.customercode" +
                                    "     , 'CustomerName'                = C.clnombre" +
                                    "     , 'MarktoMarketValueYesterday'  = SD.marktomarketvalueyesterday" +
                                    "     , 'MarktoMarketValueToday'      = SD.marktomarketvaluetoday" +
                                    "     , 'TimeDecayValue'              = SD.marktomarketvaluetimedecay" +
                                    "     , 'ExchangeRateValue'           = SD.marktomarketvalueexchangerate" +
                                    "     , 'EffectRateValue'             = SD.marktomarketvalueeffectrate" +
                                    "     , 'MarktoMarketRateYesterday'   = SD.marktomarketrateyesterday" +
                                    "     , 'MarktoMarketRateToday'       = SD.marktomarketratetoday" +
                                    "     , 'MarktoMarketRateEndMonth'    = SD.marktomarketrateendmonth" +
                                    "     , 'MacaulayDuration'            = SD.macaulayduration" +
                                    "     , 'ModifiedDuration'            = SD.modifiedduration" +
                                    "     , 'Convexity'                   = SD.convexity" +
                                    "     , 'PurchaseRate'                = SD.purchaserate" +
                                    "     , 'PurchaseValue'               = SD.purchasevalue" +
                                    "     , 'PurchaseValueUM'             = SD.purchasevalueum" +
                                    "     , 'PresentValueOriginSystem'    = SD.presentvalueoriginsystem" +
                                    "     , 'FairValueAssetSystem'        = SD.fairvalueassetsystem" +
                                    "     , 'FairValueLiabilitiesSystem'  = SD.fairvalueliabilitiessystem" +
                                    "     , 'FairValueNetSystem'          = SD.fairvaluenetsystem" +
                                    "     , 'AccruedIntrestSystem'        = SD.accruedinterestsystem" +
                                    "     , 'DailyInterestSystem'         = SD.dailyinterestsystem" +
                                    "     , 'MonthlyInterestSystem'       = SD.monthlyinterestsystem" +
                                    "     , 'AccruedAdjustmentSystem'     = SD.accruedadjustmentsystem" +
                                    "     , 'DailyAdjustmentSystem'       = SD.dailyadjustmentsystem" +
                                    "     , 'MonthlyAdjustmentSystem'     = SD.monthlyadjustmentsystem" +
                                    "     , 'MacaulayDurationSystem'      = SD.macaulaydurationsystem" +
                                    "     , 'ModifiedDurationSystem'      = SD.modifieddurationsystem" +
                                    "     , 'ConvexitySystem'             = SD.convexitysystem" +
                                    "  FROM dbo.PortFolioDetail                  PFD" +
                                    "       INNER JOIN dbo.Module                M      ON PFD.moduleid                         = M.ID" +
                                    "       INNER JOIN dbo.BookAndPortFolioRules BAPFR  ON BAPFR.moduleid                       = PFD.moduleid" +
                                    "                                                  AND PFD.bookandportfoliorulesid         in ( 0, BAPFR.id )" +
                                    "       INNER JOIN dbo.FinancialPortFolio    FPF    ON FPF.bookandportfoliorulesid          = BAPFR.id" +
                                    "                                                  AND PFD.financialportfolioid            in ( 0, FPF.id )" +
                                    "       INNER JOIN dbo.Product               P      ON P.financialportfolioid               = FPF.id" +
                                    "                                                  AND PFD.productid                       in ( 0, P.id )" +
                                    "       INNER JOIN dbo.Family                F      ON F.productid                          = P.id" +
                                    "                                                  AND PFD.familyid                        in ( 0, F.id )" +
                                    "       LEFT JOIN dbo.Details                D      ON D.familyid                           = F.id" +
                                    "                                                  AND PFD.detailid                        in ( 0, D.id )" +
                                    "       INNER JOIN dbo.SensibilitiesData     SD     ON SD.sensibilitiesdate                 = '" + portFolioDate.ToString("yyyyMMdd") + "'" +
                                    "                                                  AND SD.system                            = P.systemid" +
                                    "                                                  AND SD.bookid                            = BAPFR.book" +
                                    "                                                  AND SD.portfoliorulesid                 in ( BAPFR.portfoliorules1, BAPFR.portfoliorules2 )" +
                                    "                                                  AND SD.financialportfolioid              = FPF.financialportfolio" +
                                    "                                                  AND SD.productid                         = P.productid" +
                                    "                                                  AND F.primarycurrency                   in ( 0, SD.primarycurrencyid )" +
                                    "                                                  AND F.secondcurrency                    in ( 0, SD.secondcurrencyid )" +
                                    "                                                  AND F.primaryrate                       in ( 0, SD.primaryrateid )" +
                                    "                                                  AND F.secondrate                        in ( 0, SD.secondrateid )" +
                                    "                                                  AND F.instruments                       in ( '', SD.familyid )" +
                                    "                                                  AND ISNULL( D.mnemonicsmask, '' )       in ( '', SD.mnemonicsmask )" +
                                    "                                                  AND ISNULL( D.issuecode, 0 )            in ( 0, SD.issueid )" +
                                    "       LEFT JOIN bacparamsuda.dbo.cliente   C      ON C.clrut                              = SD.CustomerID" +
                                    "                                                  AND C.clcodigo                           = SD.CustomerCode" +
                                    " WHERE portfolioid = " + portFolio.ToString();

                if (!conditions.Equals(""))
                {
                    _QueryRate += " AND (" + conditions + ")";
                }

                _QueryRate += ";";

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
                DataTable _SensibilitiesData;

                try
                {
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryRate);
                    _SensibilitiesData = _Connect.QueryDataTable();
                    _SensibilitiesData.TableName = "Sensibilities";

                    if (_SensibilitiesData.Rows.Count.Equals(0))
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
                    _SensibilitiesData = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _SensibilitiesData;
            }

            public override DataTable LoadSensibilitiesConfiguration(DateTime portFolioDate, int portFolio)
            {

                String _QueryRate = "SELECT 'ModuleID'                         = M.id" +
                                    "     , 'ModuleDescription'                = M.description" +
                                    "     , 'ModuleOrder'                      = M.[Order]" +
                                    "     , 'BookAndPortFolioRulesID'          = BAPFR.id" +
                                    "     , 'BookAndPortFolioRulesDescription' = BAPFR.description" +
                                    "     , 'BookAndPortFolioRulesOrder'       = BAPFR.[Order]" +
                                    "     , 'FinancialPortFolioID'             = FPF.id" +
                                    "     , 'FinancialPortFolioDescription'    = FPF.description" +
                                    "     , 'FinancialPortFolioOrder'          = FPF.[Order]" +
                                    "     , 'ProductID'                        = P.id" +
                                    "     , 'ProductDescription'               = P.description" +
                                    "     , 'ProductOrder'                     = P.[Order]" +
                                    "     , 'FamilyID'                         = F.id" +
                                    "     , 'FamilyDescription'                = F.description" +
                                    "     , 'FamilyOrder'                      = F.[Order]" +
                                    "     , 'DetailID'                         = ISNULL( D.id, 0 )" +
                                    "     , 'DetailDescription'                = ISNULL( D.description, '' )" +
                                    "     , 'DetailOrder'                      = ISNULL( D.[Order], 0 )" +
                                    "     , 'System'                           = SD.system" +
                                    "     , 'OperationNumber'                  = SD.OperationNumber" +
                                    "     , 'OperationID'                      = SD.OperationID" +
                                    "     , 'CustomerName'                     = ISNULL( C.clnombre, '' )" +
                                    "  FROM dbo.PortFolioDetail                  PFD" +
                                    "       INNER JOIN dbo.Module                M      ON PFD.moduleid                         = M.ID" +
                                    "       INNER JOIN dbo.BookAndPortFolioRules BAPFR  ON BAPFR.moduleid                       = PFD.moduleid" +
                                    "                                                  AND PFD.bookandportfoliorulesid         in ( 0, BAPFR.id )" +
                                    "       INNER JOIN dbo.FinancialPortFolio    FPF    ON FPF.bookandportfoliorulesid          = BAPFR.id" +
                                    "                                                  AND PFD.financialportfolioid            in ( 0, FPF.id )" +
                                    "       INNER JOIN dbo.Product               P      ON P.financialportfolioid               = FPF.id" +
                                    "                                                  AND PFD.productid                       in ( 0, P.id )" +
                                    "       INNER JOIN dbo.Family                F      ON F.productid                          = P.id" +
                                    "                                                  AND PFD.familyid                        in ( 0, F.id )" +
                                    "       LEFT JOIN dbo.Details                D      ON D.familyid                           = F.id" +
                                    "                                                  AND PFD.detailid                        in ( 0, D.id )" +
                                    "       INNER JOIN dbo.SensibilitiesData     SD     ON SD.sensibilitiesdate                 = '" + portFolioDate.ToString("yyyyMMdd") + "'" +
                                    "                                                  AND SD.system                            = P.systemid" +
                                    "                                                  AND SD.bookid                            = BAPFR.book" +
                                    "                                                  AND SD.portfoliorulesid                 in ( BAPFR.portfoliorules1, BAPFR.portfoliorules2 )" +
                                    "                                                  AND SD.financialportfolioid              = FPF.financialportfolio" +
                                    "                                                  AND SD.productid                         = P.productid" +
                                    "                                                  AND F.primarycurrency                   in ( 0, SD.primarycurrencyid )" +
                                    "                                                  AND F.secondcurrency                    in ( 0, SD.secondcurrencyid )" +
                                    "                                                  AND F.primaryrate                       in ( 0, SD.primaryrateid )" +
                                    "                                                  AND F.secondrate                        in ( 0, SD.secondrateid )" +
                                    "                                                  AND F.instruments                       in ( '', SD.familyid )" +
                                    "                                                  AND ISNULL( D.mnemonicsmask, '' )       in ( '', SD.mnemonicsmask )" +
                                    "                                                  AND ISNULL( D.issuecode, 0 )            in ( 0, SD.issueid )" +
                                    "       LEFT JOIN bacparamsuda.dbo.cliente   C      ON C.clrut                              = SD.CustomerID" +
                                    "                                                  AND C.clcodigo                           = SD.CustomerCode" +
                                    " WHERE portfolioid = " + portFolio.ToString();
                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
                DataTable _PortFolioData;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryRate);
                    _PortFolioData = _Connect.QueryDataTable();
                    _PortFolioData.TableName = "SensibilitiesConfiguration";

                    if (_PortFolioData.Rows.Count.Equals(0))
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
                    _PortFolioData = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _PortFolioData;
            }

            public override DataTable LoadFilter()
            {

                string _QueryFilter = "SELECT 'id' = FS.ID, 'filterid' = FS.filterid, 'description' = FS.description, 'patherid' = FS.patherid" +
                                      ", 'conditions' = ISNULL( FC.conditions, '' ) FROM dbo.FilterSensibilities FS LEFT JOIN dbo.FiltroConditions FC " +
                                      "ON FS.filter = FC.id";
                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
                DataTable _FilterData;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryFilter);
                    _FilterData = _Connect.QueryDataTable();
                    _FilterData.TableName = "Filter";

                    if (_FilterData.Rows.Count.Equals(0))
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
                    _FilterData = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _FilterData;

            }

            public override DataTable LoadFilterOperation(DateTime portFolioDate)
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
                                      "       LEFT JOIN BacParamSuda.dbo.cliente   C      ON C.clrut                              = SD.CustomerID\n" +
                                      "                                                  AND C.clcodigo                           = SD.CustomerCode\n" +
                                      "       LEFT JOIN BacParamSuda.dbo.emisor    E      ON E.emrut                              = SD.issueid\n" +
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
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryFilter);
                    _FilterOperation = _Connect.QueryDataTable();
                    _FilterOperation.TableName = "FilterData";

                    if (_FilterOperation.Rows.Count.Equals(0))
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
                    _FilterOperation = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _FilterOperation;

            }

            public override DataTable LoadSensibilities(DateTime portFolioDate, string conditions)
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

                _QuerySensibilities = _QuerySensibilities.Replace("[@DateProcess]", "'" + portFolioDate.ToString("yyyyMMdd") + "'");

                #endregion

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
                DataTable _SensibilitiesData;

                try
                {
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QuerySensibilities);
                    _SensibilitiesData = _Connect.QueryDataTable();
                    _SensibilitiesData.TableName = "Sensibilities";

                    if (_SensibilitiesData.Rows.Count.Equals(0))
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
                    _SensibilitiesData = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _SensibilitiesData;
            }

            #region "LoadSensibilitiesData"

            public override DataSet LoadSensibilitiesData(DateTime portFolioDate, string system, string conditions)
            {

                DataSet _DataSet = new DataSet();

                switch (system)
                {
                    case "BTR":
                        _DataSet.Merge(LoadSensibilitiesFixingRate(portFolioDate, conditions));
                        break;
                    case "FWD":
                        _DataSet.Merge(LoadSensibilitiesForward(portFolioDate, conditions));
                        break;
                    case "FBT":
                        _DataSet.Merge(LoadSensibilitiesForwardBondsTrader(portFolioDate, conditions));
                        break;
                    case "SWP":
                        _DataSet.Merge(LoadSensibilitiesSwap(portFolioDate, conditions));
                        break;
                }

                return _DataSet;

            }

            private DataTable LoadSensibilitiesFixingRate(DateTime portFolioDate, string conditions)
            {

                String _QueryRateFixing = "";

                #region "Query Fixing Rate"

                _QueryRateFixing += "DECLARE @DateProcess                   DATETIME\n\n";

                _QueryRateFixing += "SET @DateProcess = [@DateProcess]\n\n";

                _QueryRateFixing += "SELECT 'DocumentNumber'              = SY.documentnumber\n";
                _QueryRateFixing += "     , 'OperationNumber'             = SY.operationnumber\n";
                _QueryRateFixing += "     , 'OperationID'                 = SY.operationid\n";
                _QueryRateFixing += "     , 'Sensibilities'               = SUM( SY.sensibilities )\n";
                _QueryRateFixing += "     , 'Estimation'                  = SUM( SY.estimationvalue )\n";
                _QueryRateFixing += "  INTO #tmpSensibilities\n";
                _QueryRateFixing += "  FROM dbo.SensibilitiesYield SY\n";
                _QueryRateFixing += " WHERE SY.sensibilitiesdate          = @DateProcess\n";
                _QueryRateFixing += "   AND SY.system                     = 'BTR'\n";
                _QueryRateFixing += " GROUP BY\n";
                _QueryRateFixing += "       SY.DocumentNumber\n";
                _QueryRateFixing += "     , SY.OperationNumber\n";
                _QueryRateFixing += "     , SY.OperationID\n\n";

                _QueryRateFixing += "SELECT 'System'                      = SD.system\n";
                _QueryRateFixing += "     , 'DSystem'                     = 'RENTA FIJA'\n";
                _QueryRateFixing += "     , 'Book'                        = SD.bookid\n";
                _QueryRateFixing += "     , 'PortFolioRules'              = SD.portfoliorulesid\n";
                _QueryRateFixing += "     , 'FinancialPortFolio'          = SD.financialportfolioid\n";
                _QueryRateFixing += "     , 'Product'                     = SD.productid\n";
                _QueryRateFixing += "     , 'IssueID'                     = SD.issueid\n";
                _QueryRateFixing += "     , 'IssueName'                   = ISNULL( E.emgeneric, '' )\n";
                _QueryRateFixing += "     , 'ExpiryDate'                  = SD.expirydate\n";
                _QueryRateFixing += "     , 'DocumentNumber'              = SD.documentnumber\n";
                _QueryRateFixing += "     , 'OperationNumber'             = SD.operationnumber\n";
                _QueryRateFixing += "     , 'OperationID'                 = SD.operationid\n";
                _QueryRateFixing += "     , 'MNemonicsMask'               = SD.mnemonicsmask\n";
                _QueryRateFixing += "     , 'MNemonics'                   = SD.mnemonics\n";
                _QueryRateFixing += "     , 'CustomerID'                  = SD.customerid\n";
                _QueryRateFixing += "     , 'CustomerCode'                = SD.customercode\n";
                _QueryRateFixing += "     , 'CustomerName'                = RTRIM(ISNULL( C.clnombre, '' ))\n";
                _QueryRateFixing += "     , 'Nominal'                     = SFR.nominal\n";
                _QueryRateFixing += "     , 'CurrencyIssue'               = SFR.currencyissue\n";
                _QueryRateFixing += "     , 'MarktoMarketValueYesterday'  = SFR.marktomarketvalueyesterday\n";
                _QueryRateFixing += "     , 'MarktoMarketValueToday'      = SFR.marktomarketvaluetoday\n";
                _QueryRateFixing += "     , 'MarktoMarketValueTodayUM'    = SFR.MarktoMarketValueTodayUM\n";
                _QueryRateFixing += "     , 'TimeDecayValue'              = SFR.marktomarketvaluetimedecay\n";
                _QueryRateFixing += "     , 'ExchangeRateValue'           = SFR.marktomarketvalueexchangerate\n";
                _QueryRateFixing += "     , 'EffectRateValue'             = SFR.marktomarketvalueeffectrate\n";
                _QueryRateFixing += "     , 'CashFlow'                    = SFR.CashFlow\n";
                _QueryRateFixing += "     , 'MarktoMarketRateYesterday'   = SFR.marktomarketrateyesterday\n";
                _QueryRateFixing += "     , 'MarktoMarketRateToday'       = SFR.marktomarketratetoday\n";
                _QueryRateFixing += "     , 'MarktoMarketRateEndMonth'    = SFR.marktomarketrateendmonth\n";
                _QueryRateFixing += "     , 'MacaulayDuration'            = SFR.macaulayduration\n";
                _QueryRateFixing += "     , 'ModifiedDuration'            = SFR.modifiedduration\n";
                _QueryRateFixing += "     , 'Convexity'                   = SFR.convexity\n";
                _QueryRateFixing += "     , 'ContractDate'                = SFR.contractdate\n";
                _QueryRateFixing += "     , 'PurchaseRate'                = SFR.purchaserate\n";
                _QueryRateFixing += "     , 'PurchaseValue'               = SFR.purchasevalue\n";
                _QueryRateFixing += "     , 'PurchaseValueUM'             = SFR.purchasevalueum\n";
                _QueryRateFixing += "     , 'PresentValueOriginSystem'    = SFR.presentvalueoriginsystem\n";
                _QueryRateFixing += "     , 'FairValueAssetSystem'        = SFR.fairvalueassetsystem\n";
                _QueryRateFixing += "     , 'FairValueLiabilitiesSystem'  = SFR.fairvalueliabilitiessystem\n";
                _QueryRateFixing += "     , 'FairValueNetSystem'          = SFR.fairvaluenetsystem\n";
                _QueryRateFixing += "     , 'AccruedInterestSystem'       = SFR.accruedinterestsystem\n";
                _QueryRateFixing += "     , 'DailyInterestSystem'         = SFR.dailyinterestsystem\n";
                _QueryRateFixing += "     , 'MonthlyInterestSystem'       = SFR.monthlyinterestsystem\n";
                _QueryRateFixing += "     , 'AccruedAdjustmentSystem'     = SFR.accruedadjustmentsystem\n";
                _QueryRateFixing += "     , 'DailyAdjustmentSystem'       = SFR.dailyadjustmentsystem\n";
                _QueryRateFixing += "     , 'MonthlyAdjustmentSystem'     = SFR.monthlyadjustmentsystem\n";
                _QueryRateFixing += "     , 'MacaulayDurationSystem'      = SFR.macaulaydurationsystem\n";
                _QueryRateFixing += "     , 'ModifiedDurationSystem'      = SFR.modifieddurationsystem\n";
                _QueryRateFixing += "     , 'ConvexitySystem'             = SFR.convexitysystem\n";
                _QueryRateFixing += "     , 'CourtDateCoupon'             = SFR.courtdatecoupon\n";
                _QueryRateFixing += "     , 'Sensibilities'               = CASE WHEN SFR.contractdate = @DateProcess THEN 0.0 ELSE SY.sensibilities END\n";
                _QueryRateFixing += "     , 'Estimation'                  = CASE WHEN SFR.contractdate = @DateProcess THEN 0.0 ELSE SY.Estimation    END\n";
                _QueryRateFixing += "     , 'Accrual'                     = SFR.dailyinterestsystem + SFR.dailyadjustmentsystem\n";
                _QueryRateFixing += "     , 'CarryCost'                   = SFR.CorryCost\n";
                _QueryRateFixing += "     , 'AVR'                         = CASE WHEN SFR.SalesValue <> 0\n";
                _QueryRateFixing += "                                            THEN 0\n";
                _QueryRateFixing += "                                            ELSE (SFR.marktomarketvaluetoday - SFR.presentvaluetoday) - (SFR.marktomarketvalueyesterday - SFR.presentvalueyesterday)\n";
                _QueryRateFixing += "                                       END\n";
                _QueryRateFixing += "     , 'PriceDifference'             = CASE WHEN SFR.SalesValue = 0 THEN 0 ELSE SFR.SalesValue - SFR.presentvaluetoday END\n";
                _QueryRateFixing += "  FROM dbo.SensibilitiesData                    SD\n";
                _QueryRateFixing += "       LEFT JOIN BacParamSuda.dbo.cliente       C      ON C.clrut     = SD.CustomerID\n";
                _QueryRateFixing += "                                                      AND C.clcodigo  = SD.CustomerCode\n";
                _QueryRateFixing += "       LEFT JOIN BacParamSuda.dbo.emisor        E      ON E.emrut     = SD.issueid\n";
                _QueryRateFixing += "       INNER JOIN dbo.SensibilitiesFixingRate   SFR    ON SD.ID       = SFR.ID\n";
                _QueryRateFixing += "       INNER JOIN #tmpSensibilities             SY     ON SD.documentnumber    = SY.documentnumber\n";
                _QueryRateFixing += "                                                      AND SD.operationnumber   = SY.operationnumber\n";
                _QueryRateFixing += "                                                      AND SD.operationid       = SY.operationid\n";
                _QueryRateFixing += " WHERE SD.sensibilitiesdate          = @DateProcess\n";
                _QueryRateFixing += "   AND SD.system                     = 'BTR'\n";

                if (!conditions.Equals(""))
                {
                    _QueryRateFixing += " AND (" + conditions + ")\n";
                }

                _QueryRateFixing += " ORDER BY\n";
                _QueryRateFixing += "       DocumentNumber\n";
                _QueryRateFixing += "     , OperationNumber\n";
                _QueryRateFixing += "     , OperationID\n\n";

                _QueryRateFixing += "DROP TABLE #tmpSensibilities\n";

                _QueryRateFixing = _QueryRateFixing.Replace("[@DateProcess]", "'" + portFolioDate.ToString("yyyyMMdd") + "'");

                #endregion

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
                DataTable _PortFolioData;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryRateFixing);
                    _PortFolioData = _Connect.QueryDataTable();
                    _PortFolioData.TableName = "OperationFixingRate";

                    if (_PortFolioData.Rows.Count.Equals(0))
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
                    _PortFolioData = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _PortFolioData;
            }

            private DataTable LoadSensibilitiesForward(DateTime portFolioDate, string conditions)
            {

                String _QueryForward = "";

                #region "Query Forward"

                _QueryForward += "SET NOCOUNT ON\n\n";

                _QueryForward += "DECLARE @DateProcess                   DATETIME\n";
                _QueryForward += "DECLARE @UFValue                       FLOAT\n\n";

                _QueryForward += "SET @DateProcess = [@DateProcess]\n";

                _QueryForward += "SELECT @UFValue     = currencyvaluetoday\n";
                _QueryForward += "  FROM dbo.ExchangeValue\n";
                _QueryForward += " WHERE currencydate = @DateProcess\n";
                _QueryForward += "   AND currencyid   = 998\n\n";

                _QueryForward += "SELECT 'OperationNumber'             = SY.operationnumber\n";
                _QueryForward += "     , 'Sensibilities'               = SUM( SY.sensibilities )\n";
                _QueryForward += "     , 'Estimation'                  = SUM( SY.estimationvalue )\n";
                _QueryForward += "  INTO #tmpSensibilities\n";
                _QueryForward += "  FROM dbo.SensibilitiesYield SY\n";
                _QueryForward += " WHERE SY.sensibilitiesdate          = @DateProcess\n";
                _QueryForward += "   AND SY.system                     = 'BFW'\n";
                _QueryForward += " GROUP BY\n";
                _QueryForward += "       SY.OperationNumber\n\n";
                
                _QueryForward += "SELECT 'System'                       = SD.system\n";
                _QueryForward += "     , 'DSystem'                      = 'FORWARD'\n";
                _QueryForward += "     , 'Book'                         = SD.bookid\n";
                _QueryForward += "     , 'PortFolioRules'               = SD.portfoliorulesid\n";
                _QueryForward += "     , 'FinancialPortFolio'           = SD.financialportfolioid\n";
                _QueryForward += "     , 'Product'                      = SD.productid\n";
                _QueryForward += "     , 'IssueID'                      = SD.issueid\n";
                _QueryForward += "     , 'IssueName'                    = CAST( '' AS VARCHAR(30) )\n";
                _QueryForward += "     , 'ExpiryDate'                   = SD.expirydate\n";
                _QueryForward += "     , 'OperationNumber'              = SD.operationnumber\n";
                _QueryForward += "     , 'OperationID'                  = SD.operationid\n";
                _QueryForward += "     , 'CustomerID'                   = SD.customerid\n";
                _QueryForward += "     , 'MNemonicsMask'                = SD.mnemonicsmask\n";
                _QueryForward += "     , 'CustomerCode'                 = SD.customercode\n";
                _QueryForward += "     , 'CustomerName'                 = CAST( '' AS VARCHAR(30) )\n";
                _QueryForward += "     , 'EffectiveDate'                = SF.effectivedate\n";
                _QueryForward += "     , 'TermToday'                    = SF.termtoday\n";
                _QueryForward += "     , 'RateCurrencyPrimaryToday'     = SF.ratecurrencyprimarytoday\n";
                _QueryForward += "     , 'RateCurrencySecondToday'      = ratecurrencysecondtoday\n";
                _QueryForward += "     , 'TermYesterday'                = SF.termyesterday\n";
                _QueryForward += "     , 'RateCurrencyPrimaryYesterday' = SF.ratecurrencyprimaryyesterday\n";
                _QueryForward += "     , 'RateCurrencySecondYesterday'  = ratecurrencysecondyesterday\n";
                _QueryForward += "     , 'PrimaryCurrency'              = SD.primarycurrencyid\n";
                _QueryForward += "     , 'OperationType'                = SF.operationtype\n";
                _QueryForward += "     , 'PaymentType'                  = SF.paymenttype\n";
                _QueryForward += "     , 'UnWind'                       = SF.unwind\n";
                _QueryForward += "     , 'AdvancePointCost'             = SF.advancepointcost\n";
                _QueryForward += "     , 'AdvancePointForward'          = SF.advancepointforward\n";
                _QueryForward += "     , 'PrimaryAmount'                = SF.primaryamount\n";
                _QueryForward += "     , 'SecondaryCurrency'            = SD.secondcurrencyid\n";
                _QueryForward += "     , 'SecondaryAmount'              = SF.secondaryamount\n";
                _QueryForward += "     , 'PriceForward'                 = SF.priceforward\n";
                _QueryForward += "     , 'PricePointForward'            = SF.pricepointforward\n";
                _QueryForward += "     , 'UF'                           = CASE WHEN SD.secondcurrencyid = 998 THEN @UFValue ELSE 0.0 END\n";
                _QueryForward += "     , 'PriceCost'                    = SF.pricecost\n";
                _QueryForward += "     , 'PriceForwardTheory'           = SF.priceforwardtheory\n";
                _QueryForward += "     , 'ContractDate'                 = SF.contractdate\n";
                _QueryForward += "     , 'MarktoMarketValueYesterday'   = SF.marktomarketvalueyesterday\n";
                _QueryForward += "     , 'MarktoMarketValueToday'       = SF.marktomarketvaluetoday\n";
                _QueryForward += "     , 'MarktoMarketValueTodayUM'     = SF.marktomarketvaluetodayum\n";
                _QueryForward += "     , 'TimeDecayValue'               = SF.marktomarketvaluetimedecay\n";
                _QueryForward += "     , 'ExchangeRateValue'            = SF.marktomarketvalueexchangerate\n";
                _QueryForward += "     , 'EffectRateValue'              = SF.marktomarketvalueeffectrate\n";
                _QueryForward += "     , 'CashFlow'                     = SF.cashflow\n";
                _QueryForward += "     , 'ResultDistribution'           = SF.resultdistribution\n";
                _QueryForward += "     , 'MarktoMarketRateYesterday'    = SF.marktomarketrateyesterday\n";
                _QueryForward += "     , 'MarktoMarketRateToday'        = SF.marktomarketratetoday\n";
                _QueryForward += "     , 'MarktoMarketRateEndMonth'     = SF.marktomarketrateendmonth\n";
                _QueryForward += "     , 'FairValueAssetSystem'         = SF.fairvalueassetsystem\n";
                _QueryForward += "     , 'FairValueLiabilitiesSystem'   = SF.fairvalueliabilitiessystem\n";
                _QueryForward += "     , 'FairValueNetSystem'           = SF.fairvaluenetsystem\n";
                _QueryForward += "     , 'AdvancePointCost'             = SF.advancepointcost\n";
                _QueryForward += "     , 'AdvancePointForward'          = SF.advancepointforward\n";
                _QueryForward += "     , 'Sensibilities'                = CASE WHEN SF.contractdate = @DateProcess THEN 0.0 ELSE SY.sensibilities END\n";
                _QueryForward += "     , 'Estimation'                   = CASE WHEN SF.contractdate = @DateProcess THEN 0.0 ELSE SY.Estimation    END\n";
                _QueryForward += "     , 'TransferDistribution'         = CASE WHEN SF.contractdate = SD.sensibilitiesdate THEN SF.transferdistribution ELSE 0 END\n";
                _QueryForward += "     , 'MarktoMarketSpot'             = SF.marktomarketeffectrate\n";
                _QueryForward += "     , 'PointForward'                 = SF.pointforward\n";
                _QueryForward += "     , 'CarryRateUSD'                 = SF.carryrateusd\n";
                _QueryForward += "     , 'CostCarry'                    = SF.carrycostvalue\n";
                _QueryForward += "  FROM dbo.SensibilitiesData                    SD\n";
                _QueryForward += "       INNER JOIN dbo.SensibilitiesForward      SF     ON SD.ID                = SF.ID\n";
                _QueryForward += "       INNER JOIN #tmpSensibilities             SY     ON SD.operationnumber   = SY.operationnumber\n";
                _QueryForward += " WHERE SD.sensibilitiesdate          = @DateProcess\n";
                _QueryForward += "   AND SD.system                     = 'BFW'\n";
                _QueryForward += "   AND SD.productid                 <> '10'\n";

                if (!conditions.Equals(""))
                {
                    _QueryForward += " AND (" + conditions + ")\n";
                }

                _QueryForward += " ORDER BY OperationNumber, OperationID\n\n";

                _QueryForward += "DROP TABLE #tmpSensibilities\n\n";

                _QueryForward += "SET NOCOUNT OFF\n\n";

                _QueryForward = _QueryForward.Replace("[@DateProcess]", "'" + portFolioDate.ToString("yyyyMMdd") + "'");

                #endregion

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
                DataTable _PortFolioData;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryForward);
                    _PortFolioData = _Connect.QueryDataTable();
                    _PortFolioData.TableName = "OperationForward";

                    if (_PortFolioData.Rows.Count.Equals(0))
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
                    _PortFolioData = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _PortFolioData;
            }

            private DataTable LoadSensibilitiesForwardBondsTrader(DateTime portFolioDate, string conditions)
            {

                String _QueryForwardBondsTrader = "";

                #region "Query Forward Bonds Trader"

                _QueryForwardBondsTrader += "DECLARE @DateProcess                   DATETIME\n";

                _QueryForwardBondsTrader += "SET @DateProcess = [@DateProcess]\n";

                _QueryForwardBondsTrader += "SELECT 'DocumentNumber'              = SY.documentnumber\n";
                _QueryForwardBondsTrader += "     , 'OperationNumber'             = SY.operationnumber\n";
                _QueryForwardBondsTrader += "     , 'OperationID'                 = SY.operationid\n";
                _QueryForwardBondsTrader += "     , 'Sensibilities'               = SUM( SY.sensibilities )\n";
                _QueryForwardBondsTrader += "     , 'Estimation'                  = SUM( SY.estimationvalue )\n";
                _QueryForwardBondsTrader += "  INTO #tmpSensibilities\n";
                _QueryForwardBondsTrader += "  FROM dbo.SensibilitiesYield SY\n";
                _QueryForwardBondsTrader += " WHERE SY.sensibilitiesdate          = @DateProcess\n";
                _QueryForwardBondsTrader += "   AND SY.system                     = 'BFW'\n";
                _QueryForwardBondsTrader += " GROUP BY\n";
                _QueryForwardBondsTrader += "       SY.DocumentNumber\n";
                _QueryForwardBondsTrader += "     , SY.OperationNumber\n";
                _QueryForwardBondsTrader += "     , SY.OperationID\n\n";

                _QueryForwardBondsTrader += "SELECT 'System'                      = SD.system\n";
                _QueryForwardBondsTrader += "     , 'DSystem'                     = 'FORWARD RENTA FIJA'\n";
                _QueryForwardBondsTrader += "     , 'Book'                        = SD.bookid\n";
                _QueryForwardBondsTrader += "     , 'PortFolioRules'              = SD.portfoliorulesid\n";
                _QueryForwardBondsTrader += "     , 'FinancialPortFolio'          = SD.financialportfolioid\n";
                _QueryForwardBondsTrader += "     , 'Product'                     = SD.productid\n";
                _QueryForwardBondsTrader += "     , 'IssueID'                     = SD.issueid\n";
                _QueryForwardBondsTrader += "     , 'IssueName'                   = ISNULL( E.emgeneric, '' )\n";
                _QueryForwardBondsTrader += "     , 'ExpiryDate'                  = SD.expirydate\n";
                _QueryForwardBondsTrader += "     , 'OperationNumber'             = SD.operationnumber\n";
                _QueryForwardBondsTrader += "     , 'OperationID'                 = SD.operationid\n";
                _QueryForwardBondsTrader += "     , 'CustomerID'                  = SD.customerid\n";
                _QueryForwardBondsTrader += "     , 'MNemonicsMask'               = SD.mnemonicsmask\n";
                _QueryForwardBondsTrader += "     , 'MNemonics'                   = SD.mnemonics\n";
                _QueryForwardBondsTrader += "     , 'CustomerCode'                = SD.customercode\n";
                _QueryForwardBondsTrader += "     , 'CustomerName'                = RTRIM(ISNULL( C.clnombre, '' ))\n";
                _QueryForwardBondsTrader += "     , 'OperationType'               = SFBT.operationtype\n";
                _QueryForwardBondsTrader += "     , 'Nominal'                     = SFBT.nominal\n";
                _QueryForwardBondsTrader += "     , 'CurrencyIssue'               = SFBT.currencyissue\n";
                _QueryForwardBondsTrader += "     , 'RateForwardTheory'           = SFBT.rateforwardtheory\n";
                _QueryForwardBondsTrader += "     , 'ContractDate'                = SFBT.contractdate\n";
                _QueryForwardBondsTrader += "     , 'MarktoMarketValueYesterday'  = SFBT.marktomarketvalueyesterday\n";
                _QueryForwardBondsTrader += "     , 'MarktoMarketValueToday'      = SFBT.marktomarketvaluetoday\n";
                _QueryForwardBondsTrader += "     , 'MarktoMarketValueTodayUM'    = SFBT.marktomarketvaluetodayum\n";
                _QueryForwardBondsTrader += "     , 'TimeDecayValue'              = SFBT.marktomarketvaluetimedecay\n";
                _QueryForwardBondsTrader += "     , 'ExchangeRateValue'           = SFBT.marktomarketvalueexchangerate\n";
                _QueryForwardBondsTrader += "     , 'EffectRateValue'             = SFBT.marktomarketvalueeffectrate\n";
                _QueryForwardBondsTrader += "     , 'CashFlow'                    = SFBT.CashFlow\n";
                _QueryForwardBondsTrader += "     , 'MarktoMarketRateYesterday'   = SFBT.marktomarketrateyesterday\n";
                _QueryForwardBondsTrader += "     , 'MarktoMarketRateToday'       = SFBT.marktomarketratetoday\n";
                _QueryForwardBondsTrader += "     , 'MarktoMarketRateEndMonth'    = SFBT.marktomarketrateendmonth\n";
                _QueryForwardBondsTrader += "     , 'MacaulayDuration'            = SFBT.macaulayduration\n";
                _QueryForwardBondsTrader += "     , 'ModifiedDuration'            = SFBT.modifiedduration\n";
                _QueryForwardBondsTrader += "     , 'Convexity'                   = SFBT.convexity\n";
                _QueryForwardBondsTrader += "     , 'RateContract'                = SFBT.ratecontract\n";
                _QueryForwardBondsTrader += "     , 'FairValueAssetSystem'        = SFBT.fairvalueassetsystem\n";
                _QueryForwardBondsTrader += "     , 'FairValueLiabilitiesSystem'  = SFBT.fairvalueliabilitiessystem\n";
                _QueryForwardBondsTrader += "     , 'FairValueNetSystem'          = SFBT.fairvaluenetsystem\n";
                _QueryForwardBondsTrader += "     , 'MacaulayDurationSystem'      = SFBT.macaulaydurationsystem\n";
                _QueryForwardBondsTrader += "     , 'ModifiedDurationSystem'      = SFBT.modifieddurationsystem\n";
                _QueryForwardBondsTrader += "     , 'ConvexitySystem'             = SFBT.convexitysystem\n";
                _QueryForwardBondsTrader += "     , 'Sensibilities'               = CASE WHEN SFBT.contractdate = @DateProcess THEN 0.0 ELSE SY.sensibilities END\n";
                _QueryForwardBondsTrader += "     , 'Estimation'                  = CASE WHEN SFBT.contractdate = @DateProcess THEN 0.0 ELSE SY.Estimation    END\n";
                _QueryForwardBondsTrader += "  FROM dbo.SensibilitiesData                            SD\n";
                _QueryForwardBondsTrader += "       LEFT JOIN BacParamSuda.dbo.cliente               C      ON C.clrut     = SD.CustomerID\n";
                _QueryForwardBondsTrader += "                                                              AND C.clcodigo  = SD.CustomerCode\n";
                _QueryForwardBondsTrader += "       LEFT JOIN BacParamSuda.dbo.emisor                E      ON E.emrut     = SD.issueid\n";
                _QueryForwardBondsTrader += "       INNER JOIN dbo.SensibilitiesForwardBondsTrader   SFBT   ON SD.ID       = SFBT.ID\n";
                _QueryForwardBondsTrader += "       INNER JOIN #tmpSensibilities             SY     ON SD.operationnumber   = SY.operationnumber\n";
                _QueryForwardBondsTrader += " WHERE SD.sensibilitiesdate          = @DateProcess\n";
                _QueryForwardBondsTrader += "   AND SD.system                     = 'BFW'\n";
                _QueryForwardBondsTrader += "   AND SD.productid                  = '10'\n";

                if (!conditions.Equals(""))
                {
                    _QueryForwardBondsTrader += " AND (" + conditions + ")\n";
                }

                _QueryForwardBondsTrader += " ORDER BY OperationNumber, OperationID\n\n";

                _QueryForwardBondsTrader += "DROP TABLE #tmpSensibilities\n\n";

                _QueryForwardBondsTrader = _QueryForwardBondsTrader.Replace("[@DateProcess]", "'" + portFolioDate.ToString("yyyyMMdd") + "'");

                #endregion

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
                DataTable _PortFolioData;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryForwardBondsTrader);
                    _PortFolioData = _Connect.QueryDataTable();
                    _PortFolioData.TableName = "OperationForwardBondsTrader";

                    if (_PortFolioData.Rows.Count.Equals(0))
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
                    _PortFolioData = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _PortFolioData;
            }

            private DataTable LoadSensibilitiesSwap(DateTime portFolioDate, string conditions)
            {

                String _QuerySwap = "";

                #region "Query Swap"

                _QuerySwap += "DECLARE @DateProcess                   DATETIME\n\n";

                _QuerySwap += "SET @DateProcess = [@DateProcess]\n\n";

                _QuerySwap += "SELECT 'OperationNumber'             = SY.operationnumber\n";
                _QuerySwap += "     , 'Sensibilities'               = SUM( SY.sensibilities )\n";
                _QuerySwap += "     , 'Estimation'                  = SUM( SY.estimationvalue )\n";
                _QuerySwap += "  INTO #tmpSensibilities\n";
                _QuerySwap += "  FROM dbo.SensibilitiesYield SY\n";
                _QuerySwap += " WHERE SY.sensibilitiesdate          = @DateProcess\n";
                _QuerySwap += "   AND SY.system                     = 'PCS'\n";
                _QuerySwap += " GROUP BY\n";
                _QuerySwap += "       SY.OperationNumber\n";

                _QuerySwap += "SELECT 'System'                       = SD.system\n";
                _QuerySwap += "     , 'DSystem'                      = 'SWAP'\n";
                _QuerySwap += "     , 'Book'                         = SD.bookid\n";
                _QuerySwap += "     , 'PortFolioRules'               = SD.portfoliorulesid\n";
                _QuerySwap += "     , 'FinancialPortFolio'           = SD.financialportfolioid\n";
                _QuerySwap += "     , 'Product'                      = SD.productid\n";
                _QuerySwap += "     , 'IssueID'                      = SD.issueid\n";
                _QuerySwap += "     , 'IssueName'                    = ISNULL( E.emgeneric, '' )\n";
                _QuerySwap += "     , 'ExpiryDate'                   = SD.expirydate\n";
                _QuerySwap += "     , 'OperationNumber'              = SD.operationnumber\n";
                _QuerySwap += "     , 'OperationID'                  = SD.operationid\n";
                _QuerySwap += "     , 'CustomerID'                   = SD.customerid\n";
                _QuerySwap += "     , 'MNemonicsMask'                = SD.mnemonicsmask\n";
                _QuerySwap += "     , 'CustomerCode'                 = SD.customercode\n";
                _QuerySwap += "     , 'CustomerName'                 = RTRIM(ISNULL( C.clnombre, '' ))\n";
                _QuerySwap += "     , 'PrimaryCurrency'              = SD.primarycurrencyid\n";
                _QuerySwap += "     , 'PrimaryRateID'                = SD.primaryrateid\n";
                _QuerySwap += "     , 'ContractDate'                 = SW.contractdate\n";
                _QuerySwap += "     , 'AmountAsset'                  = SW.amountasset\n";
                _QuerySwap += "     , 'SecondaryCurrency'            = SD.secondcurrencyid\n";
                _QuerySwap += "     , 'SecondRateID'                 = SD.secondrateid\n";
                _QuerySwap += "     , 'AmountLiabilities'            = SW.amountliabilities\n";
                _QuerySwap += "     , 'FairValueAsset'               = SW.fairvalueasset\n";
                _QuerySwap += "     , 'FairValueAssetUM'             = SW.fairvalueassetum\n";
                _QuerySwap += "     , 'FairValueLiabilities'         = SW.fairvalueliabilities\n";
                _QuerySwap += "     , 'FairValueLiabilitiesUM'       = SW.fairvalueliabilitiesum\n";
                _QuerySwap += "     , 'MarktoMarketValueYesterday'   = SW.marktomarketvalueyesterday\n";
                _QuerySwap += "     , 'MarktoMarketValueToday'       = SW.marktomarketvaluetoday\n";
                _QuerySwap += "     , 'MarktoMarketValueTodayUM'     = SW.marktomarketvaluetodayum\n";
                _QuerySwap += "     , 'TimeDecayValue'               = SW.marktomarketvaluetimedecay\n";
                _QuerySwap += "     , 'ExchangeRateValue'            = CASE WHEN SD.primarycurrencyid <> 998 AND SD.primarycurrencyid <> 999 THEN SW.exchangerateasset - SW.fairvalueassetyesterday       ELSE 0 END +\n";
                _QuerySwap += "                                        CASE WHEN SD.secondcurrencyid  <> 998 AND SD.secondcurrencyid  <> 999 THEN SW.fairvalueliabilitiesyesterday - SW.exchangerateliabilities ELSE 0 END\n";
                _QuerySwap += "     , 'Readjustment'                 = CASE WHEN SD.primarycurrencyid = 998 THEN SW.exchangerateasset - SW.fairvalueassetyesterday       ELSE 0 END +\n";
                _QuerySwap += "                                        CASE WHEN SD.secondcurrencyid  = 998 THEN SW.fairvalueliabilitiesyesterday - SW.exchangerateliabilities ELSE 0 END\n";
                _QuerySwap += "     , 'EffectRateValue'              = SW.marktomarketvalueeffectrate\n";
                _QuerySwap += "     , 'CashFlow'                     = SW.cashflow\n";
                _QuerySwap += "     , 'MarktoMarketRateYesterday'    = SW.marktomarketrateyesterday\n";
                _QuerySwap += "     , 'MarktoMarketRateToday'        = SW.marktomarketratetoday\n";
                _QuerySwap += "     , 'MarktoMarketRateEndMonth'     = SW.marktomarketrateendmonth\n";
                _QuerySwap += "     , 'FairValueAssetSystem'         = SW.fairvalueassetsystem\n";
                _QuerySwap += "     , 'FairValueAssetUMSystem'       = SW.fairvalueassetumsystem\n";
                _QuerySwap += "     , 'FairValueLiabilitiesSystem'   = SW.fairvalueliabilitiessystem\n";
                _QuerySwap += "     , 'FairValueLiabilitiesUMSystem' = SW.fairvalueliabilitiesumsystem\n";
                _QuerySwap += "     , 'FairValueNetSystem'           = SW.fairvaluenetsystem\n";
                _QuerySwap += "     , 'CourtDateCouponAsset'         = SW.courtdatecouponasset\n";
                _QuerySwap += "     , 'CourtDateCouponLiabilities'   = SW.courtdatecouponliabilities\n";
                _QuerySwap += "     , 'Sensibilities'                = CASE WHEN SW.contractdate = @DateProcess THEN 0.0 ELSE SY.sensibilities END\n";
                _QuerySwap += "     , 'Estimation'                   = CASE WHEN SW.contractdate = @DateProcess THEN 0.0 ELSE SY.Estimation    END\n";
                _QuerySwap += "     , 'Status'                       = SW.status\n";
                _QuerySwap += "     , 'DeltaMTMYesterday'            = CASE WHEN SW.contractdate <> SD.sensibilitiesdate THEN SW.fairvaluenetportfolioyesterday - SW.fairvaluenetyesterday ELSE 0 END\n";
                _QuerySwap += "  FROM dbo.SensibilitiesData                    SD\n";
                _QuerySwap += "       LEFT JOIN BacParamSuda.dbo.cliente       C      ON C.clrut            = SD.CustomerID\n";
                _QuerySwap += "                                                      AND C.clcodigo         = SD.CustomerCode\n";
                _QuerySwap += "       LEFT JOIN BacParamSuda.dbo.emisor        E      ON E.emrut            = SD.issueid\n";
                _QuerySwap += "       INNER JOIN dbo.SensibilitiesSwap         SW     ON SD.ID              = SW.ID\n";
                _QuerySwap += "       INNER JOIN #tmpSensibilities             SY     ON SD.OperationNumber = SY.OperationNumber\n";

                _QuerySwap += " WHERE SD.sensibilitiesdate           = @DateProcess\n";
                _QuerySwap += "   AND SD.system                      = 'PCS'\n";

                if (!conditions.Equals(""))
                {
                    _QuerySwap += " AND (" + conditions + ")\n";
                }

                _QuerySwap += " ORDER BY OperationNumber, OperationID\n\n";

                _QuerySwap += "DROP TABLE #tmpSensibilities\n";

                _QuerySwap = _QuerySwap.Replace("[@DateProcess]", "'" + portFolioDate.ToString("yyyyMMdd") + "'");

                #endregion

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
                DataTable _PortFolioData;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QuerySwap);
                    _PortFolioData = _Connect.QueryDataTable();
                    _PortFolioData.TableName = "OperationSWAP";

                    if (_PortFolioData.Rows.Count.Equals(0))
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
                    _PortFolioData = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _PortFolioData;
            }

            #endregion

            public override DataTable LoadSummary(DateTime portFolioDateToday, DateTime portFolioDateYesterday, string conditions)
            {

                String _QuerySummary = "";

                #region "Query resumen"

                _QuerySummary += "SET NOCOUNT ON\n\n";

                _QuerySummary += "DECLARE @DateProcessToday     DATETIME\n";
                _QuerySummary += "DECLARE @DateProcessYesterday DATETIME\n\n";

                _QuerySummary += "SET @DateProcessToday     = [@DateProcessToday]\n";
                _QuerySummary += "SET @DateProcessYesterday = [@DateProcessYesterday]\n\n";

                #region Tabla Detalle

                _QuerySummary += "CREATE TABLE #tmpSummaryDetail\n";
                _QuerySummary += "       (\n";
                _QuerySummary += "         system                           varchar(03)\n";
                _QuerySummary += "       , dateprocess                      datetime\n";
                _QuerySummary += "       , currency                         int\n";
                _QuerySummary += "       , leg                              char(01)\n";
                _QuerySummary += "       , marktomarket                     float\n";
                _QuerySummary += "       )\n\n";

                #endregion

                #region "Tabla Final"

                _QuerySummary += "CREATE TABLE #tmpSummary\n";
                _QuerySummary += "       (\n";
                _QuerySummary += "         system                           varchar(03) DEFAULT ''\n";
                _QuerySummary += "       , currency                         int         DEFAULT 0\n";
                _QuerySummary += "       , currencynemo                     varchar(20) DEFAULT ''\n";
                _QuerySummary += "       , marktomarketasset                float       DEFAULT 0\n";
                _QuerySummary += "       , marktomarketliabilities          float       DEFAULT 0\n";
                _QuerySummary += "       , marktomarketassetyesterday       float       DEFAULT 0\n";
                _QuerySummary += "       , marktomarketliabilitiesyesterday float       DEFAULT 0\n";
                _QuerySummary += "       )\n\n";

                #endregion

                #region "Renta Fija"

                _QuerySummary += "-- Renta Fija\n";
                _QuerySummary += "INSERT INTO #tmpSummaryDetail\n";
                _QuerySummary += "          (\n";
                _QuerySummary += "            System\n";
                _QuerySummary += "          , dateprocess\n";
                _QuerySummary += "          , currency\n";
                _QuerySummary += "          , leg\n";
                _QuerySummary += "          , marktomarket\n";
                _QuerySummary += "          )\n";
                _QuerySummary += "     SELECT SD.system\n";
                _QuerySummary += "          , SD.sensibilitiesdate\n";
                _QuerySummary += "          , SFR.currencyissue\n";
                _QuerySummary += "          , 1\n";
                _QuerySummary += "          , SUM( CASE WHEN SD.ExpiryDate > SD.sensibilitiesdate THEN SFR.marktomarketvaluetodayum ELSE 0 END )\n";
                _QuerySummary += "       FROM dbo.SensibilitiesData                  SD\n";
                _QuerySummary += "            INNER JOIN dbo.SensibilitiesFixingRate SFR  ON SD.ID             = SFR.ID\n";
                _QuerySummary += "      WHERE SD.sensibilitiesdate         in ( @DateProcessYesterday, @DateProcessToday )\n";
                _QuerySummary += "        AND SD.system                     = 'BTR'\n";
                _QuerySummary += "[@Conditions]";
                _QuerySummary += "      GROUP BY\n";
                _QuerySummary += "            SD.system\n";
                _QuerySummary += "          , SD.sensibilitiesdate\n";
                _QuerySummary += "          , SFR.currencyissue\n\n";

                #endregion

                #region "Forward"

                _QuerySummary += "-- Forward\n";

                #region "Forward Moneda Primaria"

                _QuerySummary += "-- Forward Moneda Primaria\n";
                _QuerySummary += "INSERT INTO #tmpSummaryDetail\n";
                _QuerySummary += "          (\n";
                _QuerySummary += "            System\n";
                _QuerySummary += "          , dateprocess\n";
                _QuerySummary += "          , currency\n";
                _QuerySummary += "          , leg\n";
                _QuerySummary += "          , marktomarket\n";
                _QuerySummary += "          )\n";
                _QuerySummary += "     SELECT SD.system\n";
                _QuerySummary += "          , SD.sensibilitiesdate\n";
                _QuerySummary += "          , SD.primarycurrencyid\n";
                _QuerySummary += "          , CASE WHEN SF.operationtype = 'C' THEN 1 ELSE 2 END\n";
                _QuerySummary += "          , SUM( CASE WHEN SF.paymentType = 'C' AND SF.effectivedate <= SD.sensibilitiesdate THEN 0\n";
                _QuerySummary += "                      WHEN SD.ExpiryDate    <= SD.sensibilitiesdate                          THEN 0\n";
                _QuerySummary += "                      ELSE CASE WHEN SF.operationtype = 'C' THEN SF.fairvalueassetum         ELSE SF.fairvalueliabilitiesum          END\n";
                _QuerySummary += "                 END\n";
                _QuerySummary += "               )\n";
                _QuerySummary += "       FROM dbo.SensibilitiesData               SD\n";
                _QuerySummary += "            INNER JOIN dbo.SensibilitiesForward SF  ON SD.ID            = SF.ID\n";
                _QuerySummary += "      WHERE SD.sensibilitiesdate         in ( @DateProcessYesterday, @DateProcessToday )\n";
                _QuerySummary += "        AND SD.system                     = 'BFW'\n";
                _QuerySummary += "        AND SD.productid                 <> '10'\n";
                _QuerySummary += "[@Conditions]";
                _QuerySummary += "      GROUP BY\n";
                _QuerySummary += "            SD.system\n";
                _QuerySummary += "          , SD.sensibilitiesdate\n";
                _QuerySummary += "          , SD.primarycurrencyid\n";
                _QuerySummary += "          , SF.operationtype\n\n";

                #endregion

                #region "Forward Moneda Secundaria"

                _QuerySummary += "-- Forward Moneda Secundaria\n";
                _QuerySummary += "INSERT INTO #tmpSummaryDetail\n";
                _QuerySummary += "          (\n";
                _QuerySummary += "            System\n";
                _QuerySummary += "          , dateprocess\n";
                _QuerySummary += "          , currency\n";
                _QuerySummary += "          , leg\n";
                _QuerySummary += "          , marktomarket\n";
                _QuerySummary += "          )\n";
                _QuerySummary += "     SELECT SD.system\n";
                _QuerySummary += "          , SD.sensibilitiesdate\n";
                _QuerySummary += "          , SD.secondcurrencyid\n";
                _QuerySummary += "          , CASE WHEN SF.operationtype = 'V' THEN 1 ELSE 2 END\n";
                _QuerySummary += "          , SUM( CASE WHEN SF.paymentType = 'C' AND SF.effectivedate <= SD.sensibilitiesdate THEN 0\n";
                _QuerySummary += "                      WHEN SD.ExpiryDate    <= SD.sensibilitiesdate                          THEN 0\n";
                _QuerySummary += "                      ELSE CASE WHEN SF.operationtype = 'V' THEN SF.fairvalueassetum         ELSE SF.fairvalueliabilitiesum          END\n";
                _QuerySummary += "                 END\n";
                _QuerySummary += "               )\n";
                _QuerySummary += "       FROM dbo.SensibilitiesData               SD\n";
                _QuerySummary += "            INNER JOIN dbo.SensibilitiesForward SF  ON SD.ID            = SF.ID\n";
                _QuerySummary += "      WHERE SD.sensibilitiesdate         in ( @DateProcessYesterday, @DateProcessToday )\n";
                _QuerySummary += "        AND SD.system                     = 'BFW'\n";
                _QuerySummary += "        AND SD.productid                 <> '10'\n";
                _QuerySummary += "[@Conditions]";
                _QuerySummary += "      GROUP BY\n";
                _QuerySummary += "            SD.system\n";
                _QuerySummary += "          , SD.sensibilitiesdate\n";
                _QuerySummary += "          , SD.secondcurrencyid\n";
                _QuerySummary += "          , SF.operationtype\n\n";

                #endregion

                #region "Forward Bonds Trader"

                _QuerySummary += "-- Forward Bonds Trader\n";
                _QuerySummary += "INSERT INTO #tmpSummaryDetail\n";
                _QuerySummary += "          (\n";
                _QuerySummary += "            System\n";
                _QuerySummary += "          , dateprocess\n";
                _QuerySummary += "          , currency\n";
                _QuerySummary += "          , leg\n";
                _QuerySummary += "          , marktomarket\n";
                _QuerySummary += "          )\n";
                _QuerySummary += "     SELECT 'FBT'\n";
                _QuerySummary += "          , SD.sensibilitiesdate\n";
                _QuerySummary += "          , SFBT.currencyissue\n";
                _QuerySummary += "          , CASE WHEN SFBT.operationtype = 'C' THEN 1 ELSE 2 END\n";
                _QuerySummary += "          , SUM( CASE WHEN SD.ExpiryDate > SD.sensibilitiesdate THEN SFBT.marktomarketvaluetodayum ELSE 0 END )\n";
                _QuerySummary += "       FROM dbo.SensibilitiesData                          SD\n";
                _QuerySummary += "            INNER JOIN dbo.SensibilitiesForwardBondsTrader SFBT  ON SD.ID              = SFBT.ID\n";
                _QuerySummary += "      WHERE SD.sensibilitiesdate         in ( @DateProcessYesterday, @DateProcessToday )\n";
                _QuerySummary += "        AND SD.system                     = 'BFW'\n";
                _QuerySummary += "        AND SD.productid                  = '10'\n";
                _QuerySummary += "[@Conditions]";
                _QuerySummary += "      GROUP BY\n";
                _QuerySummary += "            SD.system\n";
                _QuerySummary += "          , SD.sensibilitiesdate\n";
                _QuerySummary += "          , SFBT.currencyissue\n";
                _QuerySummary += "          , SFBT.operationtype\n\n";

                #endregion

                #endregion

                #region "SWAP"

                _QuerySummary += "-- SWAP\n";

                #region "Swap Moneda Primaria"

                _QuerySummary += "-- Swap Moneda Primaria\n";
                _QuerySummary += "INSERT INTO #tmpSummaryDetail\n";
                _QuerySummary += "          (\n";
                _QuerySummary += "            System\n";
                _QuerySummary += "          , dateprocess\n";
                _QuerySummary += "          , currency\n";
                _QuerySummary += "          , leg\n";
                _QuerySummary += "          , marktomarket\n";
                _QuerySummary += "          )\n";
                _QuerySummary += "     SELECT SD.system\n";
                _QuerySummary += "          , SD.sensibilitiesdate\n";
                _QuerySummary += "          , SD.primarycurrencyid\n";
                _QuerySummary += "          , 1\n";
                _QuerySummary += "          , SUM( CASE WHEN SD.ExpiryDate > SD.sensibilitiesdate THEN SW.fairvalueassetum ELSE 0 END )\n";
                _QuerySummary += "       FROM dbo.SensibilitiesData            SD\n";
                _QuerySummary += "            INNER JOIN dbo.SensibilitiesSwap SW  ON SD.ID            = SW.ID\n";
                _QuerySummary += "      WHERE SD.sensibilitiesdate         in ( @DateProcessYesterday, @DateProcessToday )\n";
                _QuerySummary += "        AND SD.system                     = 'PCS'\n";
                _QuerySummary += "[@Conditions]";
                _QuerySummary += "      GROUP BY\n";
                _QuerySummary += "            SD.system\n";
                _QuerySummary += "          , SD.sensibilitiesdate\n";
                _QuerySummary += "          , SD.primarycurrencyid\n\n";

                #endregion

                #region "Swap Moneda Secundaria"

                _QuerySummary += "-- Swap Moneda Secundaria\n";
                _QuerySummary += "INSERT INTO #tmpSummaryDetail\n";
                _QuerySummary += "          (\n";
                _QuerySummary += "            System\n";
                _QuerySummary += "          , dateprocess\n";
                _QuerySummary += "          , currency\n";
                _QuerySummary += "          , leg\n";
                _QuerySummary += "          , marktomarket\n";
                _QuerySummary += "          )\n";
                _QuerySummary += "     SELECT SD.system\n";
                _QuerySummary += "          , SD.sensibilitiesdate\n";
                _QuerySummary += "          , SD.secondcurrencyid\n";
                _QuerySummary += "          , 2\n";
                _QuerySummary += "          , SUM( CASE WHEN SD.ExpiryDate > SD.sensibilitiesdate THEN SW.fairvalueliabilitiesum ELSE 0 END )\n";
                _QuerySummary += "       FROM dbo.SensibilitiesData            SD\n";
                _QuerySummary += "            INNER JOIN dbo.SensibilitiesSwap SW  ON SD.ID            = SW.ID\n";
                _QuerySummary += "      WHERE SD.sensibilitiesdate         in ( @DateProcessYesterday, @DateProcessToday )\n";
                _QuerySummary += "        AND SD.system                     = 'PCS'\n";
                _QuerySummary += "[@Conditions]";
                _QuerySummary += "      GROUP BY\n";
                _QuerySummary += "            SD.system\n";
                _QuerySummary += "          , SD.sensibilitiesdate\n";
                _QuerySummary += "          , SD.secondcurrencyid\n\n";

                #endregion

                #endregion

                #region "Resumen"

                _QuerySummary += "-- Resumen\n";
                _QuerySummary += "INSERT INTO #tmpSummary\n";
                _QuerySummary += "          (\n";
                _QuerySummary += "            System\n";
                _QuerySummary += "          , currency\n";
                _QuerySummary += "          , marktomarketasset\n";
                _QuerySummary += "          , marktomarketliabilities\n";
                _QuerySummary += "          , marktomarketassetyesterday\n";
                _QuerySummary += "          , marktomarketliabilitiesyesterday\n";
                _QuerySummary += "          )\n";
                _QuerySummary += "     SELECT System\n";
                _QuerySummary += "          , Currency\n";
                _QuerySummary += "          , SUM( CASE WHEN dateprocess = @DateProcessToday     AND leg = 1 THEN marktomarket ELSE 0 END )\n";
                _QuerySummary += "          , SUM( CASE WHEN dateprocess = @DateProcessToday     AND leg = 2 THEN marktomarket ELSE 0 END )\n";
                _QuerySummary += "          , SUM( CASE WHEN dateprocess = @DateProcessYesterday AND leg = 1 THEN marktomarket ELSE 0 END )\n";
                _QuerySummary += "          , SUM( CASE WHEN dateprocess = @DateProcessYesterday AND leg = 2 THEN marktomarket ELSE 0 END )\n";
                _QuerySummary += "       FROM #tmpSummaryDetail\n";
                _QuerySummary += "      GROUP BY\n";
                _QuerySummary += "            System\n";
                _QuerySummary += "          , Currency\n\n";

                #endregion

                #region "Actualización de Nemotecnico Moneda"

                _QuerySummary += "-- Actualización de Nemotecnico Moneda\n";
                _QuerySummary += "UPDATE #tmpSummary\n";
                _QuerySummary += "   SET currencynemo = mnnemo\n";
                _QuerySummary += "  FROM BacParamSuda.dbo.MONEDA\n";
                _QuerySummary += " WHERE mncodmon     = currency\n\n";

                #endregion

                #region "Query Final"

                _QuerySummary += "-- Query Final\n";
                _QuerySummary += "SELECT 'System'                  = CASE System WHEN 'BTR' THEN 'RENTA FIJA'\n";
                _QuerySummary += "                                               WHEN 'BFW' THEN 'FORWARD   '\n";
                _QuerySummary += "                                               WHEN 'FBT' THEN 'FORWARD RF'\n";
                _QuerySummary += "                                               WHEN 'PCS' THEN 'SWAP      '\n";
                _QuerySummary += "                                                          ELSE '          '\n";
                _QuerySummary += "                                   END\n";
                _QuerySummary += "     , 'CurrencyNemo'            = currencynemo\n";
                _QuerySummary += "     , 'MarkToMarketAsset'       = marktomarketasset\n";
                _QuerySummary += "     , 'MarkToMarketLiabilities' = marktomarketliabilities\n";
                _QuerySummary += "     , 'MarkToMarketNet'         = CASE WHEN System = 'FBT' THEN MarkToMarketAsset + MarkToMarketLiabilities ELSE MarkToMarketAsset - MarkToMarketLiabilities END\n";
                _QuerySummary += "     , 'MarkToMarketAssetYesterday'       = marktomarketassetyesterday\n";
                _QuerySummary += "     , 'MarkToMarketLiabilitiesYesterday' = marktomarketliabilitiesyesterday\n";
                _QuerySummary += "     , 'MarkToMarketNetYesterday'         = CASE WHEN System = 'FBT' THEN MarkToMarketAssetYesterday + MarkToMarketLiabilitiesYesterday\n";
                _QuerySummary += "                                                                     ELSE MarkToMarketAssetYesterday - MarkToMarketLiabilitiesYesterday\n";
                _QuerySummary += "                                            END\n";
                _QuerySummary += "     , 'MarkToMarketNetDelta'             = ROUND( CASE WHEN System = 'FBT' THEN MarkToMarketAssetYesterday + MarkToMarketLiabilitiesYesterday\n";
                _QuerySummary += "                                                                     ELSE MarkToMarketAssetYesterday - MarkToMarketLiabilitiesYesterday\n";
                _QuerySummary += "                                            END * (EX1.currencyvaluetoday - EX1.currencyvalueyesterday), 0 )\n";
                _QuerySummary += "  FROM #tmpSummary\n";
                _QuerySummary += "       INNER JOIN dbo.ExchangeValue EX1  ON EX1.currencydate = @DateProcessToday\n";
                _QuerySummary += "                                        AND EX1.currencyid   = CASE WHEN currency = 13 THEN 994 ELSE currency END\n";
                _QuerySummary += " ORDER BY\n";
                _QuerySummary += "       system\n";
                _QuerySummary += "     , currency\n\n";

                #endregion

                #region "Limpieza de Tabla Temporales"

                _QuerySummary += "-- Limpieza de Tabla Temporales\n";
                _QuerySummary += "DROP TABLE #tmpSummaryDetail\n";
                _QuerySummary += "DROP TABLE #tmpSummary\n\n";

                _QuerySummary += "SET NOCOUNT ON\n";

                #endregion

                #region "Actualización de Condiciones en los querys definidos"

                if (!conditions.Equals(""))
                {
                    _QuerySummary = _QuerySummary.Replace("[@Conditions]", "        AND (" + conditions + ")\n");
                }
                else
                {
                    _QuerySummary = _QuerySummary.Replace("[@Conditions]", "");
                }

                #endregion

                _QuerySummary = _QuerySummary.Replace("[@DateProcessToday]", "'" + portFolioDateToday.ToString("yyyyMMdd") + "'");
                _QuerySummary = _QuerySummary.Replace("[@DateProcessYesterday]", "'" + portFolioDateYesterday.ToString("yyyyMMdd") + "'");

                #endregion

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
                DataTable _PortFolioData;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QuerySummary);
                    _PortFolioData = _Connect.QueryDataTable();
                    _PortFolioData.TableName = "Summary";

                    if (_PortFolioData.Rows.Count.Equals(0))
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
                    _PortFolioData = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _PortFolioData;
            }

            public override DataTable LoadStandardTerm()
            {

                String _QueryStandardTerm = "";

                _QueryStandardTerm += "SELECT ID\n";
                _QueryStandardTerm += "     , Term\n";
                _QueryStandardTerm += "     , Description\n";
                _QueryStandardTerm += "  FROM dbo.StandardTerm\n";
                
                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
                DataTable _StandardTerm;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryStandardTerm);
                    _StandardTerm = _Connect.QueryDataTable();
                    _StandardTerm.TableName = "OperationView";

                    if (_StandardTerm.Rows.Count.Equals(0))
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
                    _StandardTerm = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _StandardTerm;

            }

            public override DataTable LoadExchange(DateTime portFolioDate)
            {

                String _QueryExchange = "";

                _QueryExchange += "SELECT 'CurrencyID'             = EV.currencyid\n";
                _QueryExchange += "     , 'CurrencyNemo'           = M.mnnemo\n";
                _QueryExchange += "     , 'CurrencyValueTorday'    = EV.currencyvaluetoday\n";
                _QueryExchange += "     , 'CurrencyValueYesterday' = EV.currencyvalueyesterday\n";
                _QueryExchange += "  FROM dbo.ExchangeValue EV\n";
                _QueryExchange += "       INNER JOIN BacParamSuda.dbo.MONEDA M ON EV.currencyid = M.mncodmon\n";
                _QueryExchange += " WHERE currencydate = '" + portFolioDate.ToString("yyyyMMdd") + "'\n";

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
                DataTable _Exchange;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryExchange);
                    _Exchange = _Connect.QueryDataTable();
                    _Exchange.TableName = "Exchange";

                    if (_Exchange.Rows.Count.Equals(0))
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
                    _Exchange = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _Exchange;
            }

            #region "LoadReportMonthlyResult"

            public override DataSet LoadReportMonthlyResult(string system, string conditions)
            {

                DataSet _DataSet = new DataSet();

                switch (system)
                {
                    case "RBTR":
                        _DataSet.Merge(LoadReportMonthlyResultFixingRate(conditions));
                        break;
                    case "RFWD":
                        _DataSet.Merge(LoadReportMonthlyResultForward(conditions));
                        break;
                    case "RFBT":
                        _DataSet.Merge(LoadReportMonthlyResultForwardBondsTrader(conditions));
                        break;
                    case "RSWP":
                        _DataSet.Merge(LoadReportMonthlyResultSwap(conditions));
                        break;
                }

                return _DataSet;

            }

            private DataTable LoadReportMonthlyResultFixingRate(string conditions)
            {

                String _QueryFixingRate = "";

                #region "Query Fixing Rate"

                _QueryFixingRate += "SET NOCOUNT ON\n\n";

                _QueryFixingRate += "SELECT 'SensibilitiesDate'             = SY.sensibilitiesdate\n";
                _QueryFixingRate += "     , 'DocumentNumber'                = SY.documentnumber\n";
                _QueryFixingRate += "     , 'OperationNumber'               = SY.operationnumber\n";
                _QueryFixingRate += "     , 'OperationID'                   = SY.operationid\n";
                _QueryFixingRate += "     , 'Sensibilities'                 = SUM( SY.sensibilities )\n";
                _QueryFixingRate += "     , 'Estimation'                    = SUM( SY.estimationvalue )\n";
                _QueryFixingRate += "  INTO #tmpSensibilities\n";
                _QueryFixingRate += "  FROM dbo.SensibilitiesYield SY\n";
                _QueryFixingRate += " WHERE SY.system                       = 'BTR'\n";
                _QueryFixingRate += " GROUP BY\n";
                _QueryFixingRate += "       SY.sensibilitiesdate\n";
                _QueryFixingRate += "     , SY.DocumentNumber\n";
                _QueryFixingRate += "     , SY.OperationNumber\n";
                _QueryFixingRate += "     , SY.OperationID\n\n";

                _QueryFixingRate += "SELECT 'Date'                    = SD.sensibilitiesdate\n";
                _QueryFixingRate += "     , 'EffectRate'              = SUM( CASE WHEN SFR.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
                _QueryFixingRate += "                                             THEN SFR.marktomarketvalueeffectrate - SFR.marktomarketvalueyesterday\n";
                _QueryFixingRate += "                                             ELSE 0\n";
                _QueryFixingRate += "                                        END\n";
                _QueryFixingRate += "                                      )\n";
                _QueryFixingRate += "     , 'TimeDecay'               = SUM( CASE WHEN (SFR.ContractDate               <> SD.sensibilitiesdate\n";
                _QueryFixingRate += "                                               OR  SD.ExpiryDate                 <> SD.sensibilitiesdate)\n";
                _QueryFixingRate += "                                              AND  SFR.marktomarketvaluetimedecay <> 0\n";
                _QueryFixingRate += "                                             THEN SFR.marktomarketvaluetimedecay - SFR.marktomarketvalueyesterday\n";
                _QueryFixingRate += "                                             ELSE 0\n";
                _QueryFixingRate += "                                        END +\n";
                _QueryFixingRate += "                                        CASE WHEN SFR.courtdatecoupon        = SD.sensibilitiesdate THEN SFR.cashflow\n";
                _QueryFixingRate += "                                             ELSE 0\n";
                _QueryFixingRate += "                                        END\n";
                _QueryFixingRate += "                                      )\n";
                _QueryFixingRate += "     , 'ExchangeRate'            = SUM( CASE WHEN SFR.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate  AND  SFR.currencyissue <> 998\n";
                _QueryFixingRate += "                                              AND SFR.marktomarketvalueexchangerate <> 0 THEN SFR.marktomarketvalueexchangerate - SFR.marktomarketvalueyesterday\n";
                _QueryFixingRate += "                                             ELSE 0\n";
                _QueryFixingRate += "                                        END\n";
                _QueryFixingRate += "                                      )\n";
                _QueryFixingRate += "     , 'ReadjustmentAsset'       = SUM( CASE WHEN SFR.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate  AND  SFR.currencyissue = 998\n";
                _QueryFixingRate += "                                              AND SFR.marktomarketvalueexchangerate <> 0 THEN SFR.marktomarketvalueyesterdayum\n";
                _QueryFixingRate += "                                             ELSE 0\n";
                _QueryFixingRate += "                                        END\n";
                _QueryFixingRate += "                                      )\n";
                _QueryFixingRate += "     , 'ReadjustmentLiabilities' = CAST( 0 AS FLOAT )\n";
                _QueryFixingRate += "     , 'Readjustment'            = CAST( 0 AS FLOAT )\n";
                _QueryFixingRate += "     , 'New'                     = SUM( CASE WHEN SFR.ContractDate = SD.sensibilitiesdate THEN SFR.marktomarketvaluetoday - SFR.marktomarketvalueyesterday\n";
                _QueryFixingRate += "                                                                                          ELSE 0\n";
                _QueryFixingRate += "                                        END\n";
                _QueryFixingRate += "                                      )\n";
                _QueryFixingRate += "     , 'Expiry'                  = SUM( CASE WHEN SFR.courtdatecoupon        = SD.sensibilitiesdate THEN SFR.cashflow * -1\n";
                _QueryFixingRate += "                                             ELSE 0\n";
                _QueryFixingRate += "                                        END\n";
                _QueryFixingRate += "                                      )\n";
                _QueryFixingRate += "     , 'CashFlow'                = SUM( cashflow )\n";
                _QueryFixingRate += "     , 'SubTotalNotExchangeRate' = CAST( 0 AS FLOAT )\n";
                _QueryFixingRate += "     , 'SubTotalExchangeRate'    = CAST( 0 AS FLOAT )\n";
                _QueryFixingRate += "     , 'SubTotalEffect'          = CAST( 0 AS FLOAT )\n";
                _QueryFixingRate += "     , 'Total'                   = SUM( SFR.marktomarketvaluetoday - SFR.marktomarketvalueyesterday )\n";
                _QueryFixingRate += "     , 'Estimation'              = SUM( CASE WHEN SFR.contractdate = SD.sensibilitiesdate THEN 0.0 ELSE SY.Estimation    END )\n";
                _QueryFixingRate += "     , 'Ratio'                   = CAST( 0 AS FLOAT )\n";
                _QueryFixingRate += "     , 'Accrual'                 = SUM( SFR.dailyinterestsystem + SFR.dailyadjustmentsystem )\n";
                _QueryFixingRate += "     , 'CarryCost'               = SUM( SFR.CorryCost )\n";
                _QueryFixingRate += "     , 'AVR'                     = SUM( CASE WHEN SFR.SalesValue <> 0\n";
                _QueryFixingRate += "                                             THEN 0\n";
                _QueryFixingRate += "                                             ELSE (SFR.marktomarketvaluetoday - SFR.presentvaluetoday) - (SFR.marktomarketvalueyesterday - SFR.presentvalueyesterday)\n";
                _QueryFixingRate += "                                        END )\n";
                _QueryFixingRate += "     , 'PriceDifference'         = SUM( CASE WHEN SFR.SalesValue = 0 THEN 0 ELSE SFR.SalesValue - SFR.presentvaluetoday END )\n";
                _QueryFixingRate += "  INTO #tmpResultado\n";
                _QueryFixingRate += "  FROM dbo.SensibilitiesData             SD\n";
                _QueryFixingRate += "       INNER JOIN dbo.SensibilitiesFixingRate  SFR  ON SD.id                = SFR.id\n";
                _QueryFixingRate += "       INNER JOIN #tmpSensibilities            SY   ON SD.sensibilitiesdate = SY.SensibilitiesDate\n";
                _QueryFixingRate += "                                                   AND SD.DocumentNumber    = SY.DocumentNumber\n";
                _QueryFixingRate += "                                                   AND SD.OperationNumber   = SY.OperationNumber\n";
                _QueryFixingRate += "                                                   AND SD.OperationID       = SY.OperationID\n";
                _QueryFixingRate += " WHERE SD.system                  = 'BTR'\n";

                if (!conditions.Equals(""))
                {
                    _QueryFixingRate += " AND (" + conditions + ")\n";
                }

                _QueryFixingRate += " GROUP BY\n";
                _QueryFixingRate += "       SD.sensibilitiesdate\n\n";

                _QueryFixingRate += "UPDATE #tmpResultado\n";
                _QueryFixingRate += "   SET Readjustment = (ReadjustmentAsset + ReadjustmentLiabilities) * (currencyvaluetoday - currencyvalueyesterday)\n";
                _QueryFixingRate += "  FROM dbo.ExchangeValue\n";
                _QueryFixingRate += " WHERE currencydate = [Date]\n";
                _QueryFixingRate += "   AND currencyid   = 998\n\n";

                _QueryFixingRate += "UPDATE #tmpResultado\n";
                _QueryFixingRate += "   SET SubTotalNotExchangeRate = EffectRate + TimeDecay + New + Expiry + CashFlow + Readjustment \n";
                _QueryFixingRate += "     , SubTotalExchangeRate    = EffectRate + TimeDecay + New + Expiry + CashFlow + ExchangeRate + Readjustment\n";
                _QueryFixingRate += "     , SubTotalEffect          = EffectRate + TimeDecay + New + Expiry + ExchangeRate + Readjustment\n";
                _QueryFixingRate += "     , Ratio                   = CASE WHEN EffectRate = 0 THEN 0 ELSE Estimation / EffectRate END\n\n";

                _QueryFixingRate += "SELECT [Date]\n";
                _QueryFixingRate += "     , EffectRate\n";
                _QueryFixingRate += "     , TimeDecay\n";
                _QueryFixingRate += "     , ExchangeRate\n";
                _QueryFixingRate += "     , Readjustment\n";
                _QueryFixingRate += "     , New\n";
                _QueryFixingRate += "     , Expiry\n";
                _QueryFixingRate += "     , CashFlow\n";
                _QueryFixingRate += "     , SubTotalNotExchangeRate\n";
                _QueryFixingRate += "     , SubTotalExchangeRate\n";
                _QueryFixingRate += "     , SubTotalEffect\n";
                _QueryFixingRate += "     , Total\n";
                _QueryFixingRate += "     , Estimation\n";
                _QueryFixingRate += "     , Ratio\n";
                _QueryFixingRate += "     , Accrual\n";
                _QueryFixingRate += "     , CarryCost\n";
                _QueryFixingRate += "     , AVR\n";
                _QueryFixingRate += "     , PriceDifference\n";
                _QueryFixingRate += "  FROM #tmpResultado\n";
                _QueryFixingRate += " ORDER BY\n";
                _QueryFixingRate += "       [Date]\n\n";

                _QueryFixingRate += "DROP TABLE #tmpResultado\n";
                _QueryFixingRate += "DROP TABLE #tmpSensibilities\n\n";

                _QueryFixingRate += "SET NOCOUNT OFF\n";

                #endregion

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
                DataTable _PortFolioData;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryFixingRate);
                    _PortFolioData = _Connect.QueryDataTable();
                    _PortFolioData.TableName = "ResultFixingRate";

                    if (_PortFolioData.Rows.Count.Equals(0))
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
                    _PortFolioData = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _PortFolioData;

            }

            private DataTable LoadReportMonthlyResultForward(string conditions)
            {

                String _QueryForward = "";

                #region "Query Forward"

                _QueryForward += "SET NOCOUNT ON\n\n";

                _QueryForward += "SELECT 'SensibilitiesDate'             = SY.sensibilitiesdate\n";
                _QueryForward += "     , 'OperationNumber'               = SY.operationnumber\n";
                _QueryForward += "     , 'Sensibilities'                 = SUM( SY.sensibilities )\n";
                _QueryForward += "     , 'Estimation'                    = SUM( SY.estimationvalue )\n";
                _QueryForward += "  INTO #tmpSensibilities\n";
                _QueryForward += "  FROM dbo.SensibilitiesYield SY\n";
                _QueryForward += " WHERE SY.system                       = 'BFW'\n";
                _QueryForward += " GROUP BY\n";
                _QueryForward += "       SY.sensibilitiesdate\n";
                _QueryForward += "     , SY.OperationNumber\n\n";

                _QueryForward += "SELECT 'Date'                    = SD.sensibilitiesdate\n";
                _QueryForward += "     , 'EffectRate'              = SUM( CASE WHEN SF.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
                _QueryForward += "                                             THEN SF.marktomarketvalueeffectrate - SF.marktomarketvalueyesterday\n";
                _QueryForward += "                                             ELSE 0\n";
                _QueryForward += "                                        END\n";
                _QueryForward += "                                      )\n";
                _QueryForward += "     , 'TimeDecay'               = SUM( CASE WHEN SD.expirydate                  = SD.sensibilitiesdate THEN 0\n";
                _QueryForward += "                                             WHEN SF.ContractDate                = SD.sensibilitiesdate THEN 0\n";
                _QueryForward += "                                             WHEN SF.marktomarketvaluetimedecay <> 0                    THEN SF.marktomarketvaluetimedecay - SF.marktomarketvalueyesterday\n";
                _QueryForward += "                                             ELSE 0\n";
                _QueryForward += "                                        END\n";
                _QueryForward += "                                      )\n";
                _QueryForward += "     , 'ExchangeRate'            = SUM( CASE WHEN SF.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
                _QueryForward += "                                              AND SF.marktomarketvalueexchangerate <> 0 THEN SF.marktomarketvalueexchangerate - SF.marktomarketvalueyesterday\n";
                _QueryForward += "                                             ELSE 0\n";
                _QueryForward += "                                        END\n";
                _QueryForward += "                                      )\n";
                _QueryForward += "     , 'ReadjustmentAsset'       = SUM( CASE WHEN SF.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
                _QueryForward += "                                              AND SF.marktomarketvalueexchangerate <> 0 AND SD.primarycurrencyid = 998 AND OperationType = 'C'\n";
                _QueryForward += "                                                  THEN SF.fairvalueassetyesterdayum\n";
                _QueryForward += "                                             WHEN SF.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
                _QueryForward += "                                              AND SF.marktomarketvalueexchangerate <> 0 AND SD.secondcurrencyid = 998 AND OperationType = 'V'\n";
                _QueryForward += "                                                  THEN SF.fairvalueliabilitiesyesterdayum\n";
                _QueryForward += "                                             ELSE 0\n";
                _QueryForward += "                                        END\n";
                _QueryForward += "                                      )\n";
                _QueryForward += "     , 'ReadjustmentLiabilities' = SUM( CASE WHEN SF.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
                _QueryForward += "                                              AND SF.marktomarketvalueexchangerate <> 0 AND SD.primarycurrencyid = 998 AND OperationType = 'V'\n";
                _QueryForward += "                                                  THEN -SF.fairvalueliabilitiesyesterdayum\n";
                _QueryForward += "                                             WHEN SF.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
                _QueryForward += "                                              AND SF.marktomarketvalueexchangerate <> 0 AND SD.secondcurrencyid = 998 AND OperationType = 'C'\n";
                _QueryForward += "                                                  THEN -SF.fairvalueliabilitiesyesterdayum\n";
                _QueryForward += "                                             ELSE 0\n";
                _QueryForward += "                                        END\n";
                _QueryForward += "                                      )\n";
                _QueryForward += "     , 'Readjustment'            = CAST( 0 AS FLOAT )\n";
                _QueryForward += "     , 'New'                     = SUM( CASE WHEN SF.ContractDate = SD.sensibilitiesdate THEN SF.marktomarketvaluetoday - SF.marktomarketvalueyesterday\n";
                _QueryForward += "                                                                                          ELSE 0\n";
                _QueryForward += "                                        END\n";
                _QueryForward += "                                      )\n";
                _QueryForward += "     , 'Expiry'                  = SUM( CASE WHEN SD.expirydate        = SD.sensibilitiesdate THEN SF.cashflow * -1\n";
                _QueryForward += "                                             ELSE 0\n";
                _QueryForward += "                                        END\n";
                _QueryForward += "                                      )\n";
                _QueryForward += "     , 'CashFlowByDistribution'  = SUM( CASE WHEN SD.ExpiryDate = SD.sensibilitiesdate\n";
                _QueryForward += "                                             THEN SF.primaryamount * (CASE WHEN SF.operationtype = 'C' THEN 1 ELSE -1 END) * \n";
                _QueryForward += "                                                 (SF.pricepointforward - (SF.priceforward * CASE secondcurrencyid WHEN 998 THEN currencyvaluetoday ELSE 1 END))\n";
                _QueryForward += "                                             ELSE 0\n";
                _QueryForward += "                                        END\n";
                _QueryForward += "                                      )\n";
                _QueryForward += "     , 'CashFlowByPoint'         = SUM( CASE WHEN SD.ExpiryDate = SD.sensibilitiesdate\n";
                _QueryForward += "                                             THEN SF.primaryamount * (CASE WHEN SF.operationtype = 'C' THEN 1 ELSE -1 END) * (SF.pricecost - SF.pricepointforward + SF.advancepointcost)\n";
                _QueryForward += "                                             ELSE 0\n";
                _QueryForward += "                                        END\n";
                _QueryForward += "                                      )\n";
                _QueryForward += "     , 'CashFlowByExchange'      = CAST( 0 AS FLOAT )\n";
                _QueryForward += "     , 'CashFlow'                = SUM( cashflow )\n";
                _QueryForward += "     , 'SubTotalNotExchangeRate' = CAST( 0 AS FLOAT )\n";
                _QueryForward += "     , 'SubTotalExchangeRate'    = CAST( 0 AS FLOAT )\n";
                _QueryForward += "     , 'SubTotalEffect'          = CAST( 0 AS FLOAT )\n";
                _QueryForward += "     , 'Total'                   = SUM( SF.marktomarketvaluetoday - SF.marktomarketvalueyesterday )\n";
                _QueryForward += "     , 'Estimation'              = SUM( CASE WHEN SF.contractdate = SD.sensibilitiesdate THEN 0.0 ELSE SY.Estimation    END )\n";
                _QueryForward += "     , 'Ratio'                   = CAST( 0 AS FLOAT )\n";
                _QueryForward += "     , 'Distribution'            = SUM( CASE WHEN SF.contractdate = SD.sensibilitiesdate and SF.UnWind <> 'A'\n";
                _QueryForward += "                                             THEN SF.transferdistribution\n";
                _QueryForward += "                                             ELSE 0\n";
                _QueryForward += "                                        END\n";
                _QueryForward += "                                      )\n";
                _QueryForward += "     , 'RateNew'                 = SUM( CASE WHEN SF.ContractDate = SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
                _QueryForward += "                                             THEN SF.marktomarketvalueeffectrate - SF.marktomarketvalueyesterday - SF.transferdistribution\n";
                _QueryForward += "                                             ELSE 0\n";
                _QueryForward += "                                        END\n";
                _QueryForward += "                                      )\n";
                _QueryForward += "     , 'ExchangerateNew'         = SUM( CASE WHEN SF.contractdate = SD.sensibilitiesdate and SF.UnWind <> 'A'\n";
                _QueryForward += "                                              AND SF.marktomarketvalueexchangerate <> 0 THEN SF.marktomarketvalueexchangerate - SF.marktomarketvalueyesterday\n";
                _QueryForward += "                                             ELSE 0\n";
                _QueryForward += "                                        END\n";
                _QueryForward += "                                      )\n";
                _QueryForward += "     , 'MarktoMarketSpot'        = SUM( 0 ) -- marktomarketeffectrate - SF.marktomarketvaluetoday )\n";
                _QueryForward += "     , 'CostCarry'               = SUM( carrycostvalue )\n";
                _QueryForward += "  INTO #tmpResultado\n";
                _QueryForward += "  FROM dbo.SensibilitiesData                SD\n";
                _QueryForward += "       INNER JOIN dbo.SensibilitiesForward  SF  ON SD.id                = SF.id\n";
                _QueryForward += "       INNER JOIN #tmpSensibilities         SY  ON SD.sensibilitiesdate = SY.SensibilitiesDate\n";
                _QueryForward += "                                               AND SD.OperationNumber   = SY.OperationNumber\n";
                _QueryForward += "       INNER JOIN dbo.ExchangeValue         EV  ON EV.currencydate      = SD.sensibilitiesdate\n";
                _QueryForward += "                                               AND EV.currencyid        = 998\n";
                _QueryForward += " WHERE SD.system                  = 'BFW'\n";
                _QueryForward += "   AND SD.productid              <> '10'\n";

                if (!conditions.Equals(""))
                {
                    _QueryForward += " AND (" + conditions + ")\n";
                }

                _QueryForward += " GROUP BY\n";
                _QueryForward += "       SD.sensibilitiesdate\n\n";

                _QueryForward += "UPDATE #tmpResultado\n";
                _QueryForward += "   SET Readjustment = (ReadjustmentAsset + ReadjustmentLiabilities) * (currencyvaluetoday - currencyvalueyesterday)\n";
                _QueryForward += "  FROM dbo.ExchangeValue\n";
                _QueryForward += " WHERE currencydate = [Date]\n";
                _QueryForward += "   AND currencyid   = 998\n\n";

                _QueryForward += "UPDATE #tmpResultado\n";
                _QueryForward += "   SET ExchangeRate = ExchangeRate - Readjustment\n\n";

                _QueryForward += "UPDATE #tmpResultado\n";
                _QueryForward += "   SET SubTotalNotExchangeRate = EffectRate + TimeDecay + New + Expiry + CashFlow + Readjustment \n";
                _QueryForward += "     , SubTotalExchangeRate    = EffectRate + TimeDecay + New + Expiry + CashFlow + ExchangeRate + Readjustment\n";
                _QueryForward += "     , SubTotalEffect          = EffectRate + TimeDecay + New + Expiry + ExchangeRate + Readjustment\n";
                _QueryForward += "     , Ratio                   = CASE WHEN EffectRate = 0 THEN 0 ELSE Estimation / EffectRate END\n";
                _QueryForward += "     , CashFlowByExchange      = CashFlow - (CashFlowByPoint + CashFlowByDistribution)\n\n";

                _QueryForward += "SELECT [Date]\n";
                _QueryForward += "     , EffectRate\n";
                _QueryForward += "     , TimeDecay\n";
                _QueryForward += "     , ExchangeRate\n";
                _QueryForward += "     , Readjustment\n";
                _QueryForward += "     , New\n";
                _QueryForward += "     , Expiry\n";
                _QueryForward += "     , CashFlowByPoint\n";
                _QueryForward += "     , CashFlowByDistribution\n";
                _QueryForward += "     , CashFlowByExchange\n";
                _QueryForward += "     , CashFlow\n";
                _QueryForward += "     , SubTotalNotExchangeRate\n";
                _QueryForward += "     , SubTotalExchangeRate\n";
                _QueryForward += "     , SubTotalEffect\n";
                _QueryForward += "     , Total\n";
                _QueryForward += "     , Estimation\n";
                _QueryForward += "     , Ratio\n";
                _QueryForward += "     , Distribution\n";
                _QueryForward += "     , RateNew\n";
                _QueryForward += "     , ExchangerateNew\n";
                _QueryForward += "     , MarktoMarketSpot\n";
                _QueryForward += "     , CostCarry\n";
                _QueryForward += "  FROM #tmpResultado\n";
                _QueryForward += " ORDER BY\n";
                _QueryForward += "       [Date]\n\n";

                _QueryForward += "DROP TABLE #tmpResultado\n";
                _QueryForward += "DROP TABLE #tmpSensibilities\n\n";

                _QueryForward += "SET NOCOUNT OFF\n\n";

                #endregion

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
                DataTable _PortFolioData;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryForward);
                    _PortFolioData = _Connect.QueryDataTable();
                    _PortFolioData.TableName = "ResultForward";

                    if (_PortFolioData.Rows.Count.Equals(0))
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
                    _PortFolioData = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _PortFolioData;

            }

            private DataTable LoadReportMonthlyResultForwardBondsTrader(string conditions)
            {

                String _QueryForwardBondsTrader = "";

                #region "Query Forward Bonds Traders"

                _QueryForwardBondsTrader += "SET NOCOUNT ON\n\n";

                _QueryForwardBondsTrader += "SELECT 'SensibilitiesDate'             = SY.sensibilitiesdate\n";
                _QueryForwardBondsTrader += "     , 'OperationNumber'               = SY.operationnumber\n";
                _QueryForwardBondsTrader += "     , 'Sensibilities'                 = SUM( SY.sensibilities )\n";
                _QueryForwardBondsTrader += "     , 'Estimation'                    = SUM( SY.estimationvalue )\n";
                _QueryForwardBondsTrader += "  INTO #tmpSensibilities\n";
                _QueryForwardBondsTrader += "  FROM dbo.SensibilitiesYield SY\n";
                _QueryForwardBondsTrader += " WHERE SY.system                       = 'BFW'\n";
                _QueryForwardBondsTrader += " GROUP BY\n";
                _QueryForwardBondsTrader += "       SY.sensibilitiesdate\n";
                _QueryForwardBondsTrader += "     , SY.OperationNumber\n\n";

                _QueryForwardBondsTrader += "SELECT 'Date'                    = SD.sensibilitiesdate\n";
                _QueryForwardBondsTrader += "     , 'EffectRate'              = SUM( CASE WHEN SFBT.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
                _QueryForwardBondsTrader += "                                             THEN SFBT.marktomarketvalueeffectrate - SFBT.marktomarketvalueyesterday\n";
                _QueryForwardBondsTrader += "                                             ELSE 0\n";
                _QueryForwardBondsTrader += "                                        END\n";
                _QueryForwardBondsTrader += "                                      )\n";
                _QueryForwardBondsTrader += "     , 'TimeDecay'               = SUM( CASE WHEN (SFBT.ContractDate               <> SD.sensibilitiesdate\n";
                _QueryForwardBondsTrader += "                                               OR  SD.ExpiryDate                 <> SD.sensibilitiesdate)\n";
                _QueryForwardBondsTrader += "                                              AND  SFBT.marktomarketvaluetimedecay <> 0\n";
                _QueryForwardBondsTrader += "                                             THEN SFBT.marktomarketvaluetimedecay - SFBT.marktomarketvalueyesterday\n";
                _QueryForwardBondsTrader += "                                             ELSE 0\n";
                _QueryForwardBondsTrader += "                                        END +\n";
                _QueryForwardBondsTrader += "                                        CASE WHEN SD.expirydate        = SD.sensibilitiesdate THEN SFBT.cashflow\n";
                _QueryForwardBondsTrader += "                                             ELSE 0\n";
                _QueryForwardBondsTrader += "                                        END\n";
                _QueryForwardBondsTrader += "                                      )\n";
                _QueryForwardBondsTrader += "     , 'ExchangeRate'            = SUM( CASE WHEN SFBT.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
                _QueryForwardBondsTrader += "                                              AND SFBT.marktomarketvalueexchangerate <> 0 THEN SFBT.marktomarketvalueexchangerate - SFBT.marktomarketvalueyesterday\n";
                _QueryForwardBondsTrader += "                                             ELSE 0\n";
                _QueryForwardBondsTrader += "                                        END\n";
                _QueryForwardBondsTrader += "                                      )\n";
                _QueryForwardBondsTrader += "     , 'ReadjustmentAsset'       = SUM( CASE WHEN SFBT.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
                _QueryForwardBondsTrader += "                                              AND SFBT.marktomarketvalueexchangerate <> 0 AND SD.primarycurrencyid = 998 THEN SFBT.marktomarketvalueyesterdayum\n";
                _QueryForwardBondsTrader += "                                             ELSE 0\n";
                _QueryForwardBondsTrader += "                                        END\n";
                _QueryForwardBondsTrader += "                                      )\n";
                _QueryForwardBondsTrader += "     , 'ReadjustmentLiabilities' = SUM( CASE WHEN SFBT.marktomarketvalueexchangerate <> 0 AND SD.secondcurrencyid = 998 THEN -SFBT.marktomarketvalueyesterdayum\n";
                _QueryForwardBondsTrader += "                                             ELSE 0\n";
                _QueryForwardBondsTrader += "                                        END\n";
                _QueryForwardBondsTrader += "                                      )\n";
                _QueryForwardBondsTrader += "     , 'Readjustment'            = CAST( 0 AS FLOAT )\n";
                _QueryForwardBondsTrader += "     , 'New'                     = SUM( CASE WHEN SFBT.ContractDate = SD.sensibilitiesdate THEN SFBT.marktomarketvaluetoday - SFBT.marktomarketvalueyesterday\n";
                _QueryForwardBondsTrader += "                                                                                           ELSE 0\n";
                _QueryForwardBondsTrader += "                                        END\n";
                _QueryForwardBondsTrader += "                                      )\n";
                _QueryForwardBondsTrader += "     , 'Expiry'                  = SUM( CASE WHEN SD.expirydate        = SD.sensibilitiesdate THEN SFBT.cashflow * -1\n";
                _QueryForwardBondsTrader += "                                             ELSE 0\n";
                _QueryForwardBondsTrader += "                                        END\n";
                _QueryForwardBondsTrader += "                                      )\n";
                _QueryForwardBondsTrader += "     , 'CashFlow'                = SUM( cashflow )\n";
                _QueryForwardBondsTrader += "     , 'SubTotalNotExchangeRate' = CAST( 0 AS FLOAT )\n";
                _QueryForwardBondsTrader += "     , 'SubTotalExchangeRate'    = CAST( 0 AS FLOAT )\n";
                _QueryForwardBondsTrader += "     , 'SubTotalEffect'          = CAST( 0 AS FLOAT )\n";
                _QueryForwardBondsTrader += "     , 'Total'                   = SUM( SFBT.marktomarketvaluetoday - SFBT.marktomarketvalueyesterday )\n";
                _QueryForwardBondsTrader += "     , 'Estimation'              = SUM( CASE WHEN SFBT.contractdate = SD.sensibilitiesdate THEN 0.0 ELSE SY.Estimation    END )\n";
                _QueryForwardBondsTrader += "     , 'Ratio'                   = CAST( 0 AS FLOAT )\n";
                _QueryForwardBondsTrader += "  INTO #tmpResultado\n";
                _QueryForwardBondsTrader += "  FROM dbo.SensibilitiesData                           SD\n";
                _QueryForwardBondsTrader += "       INNER JOIN dbo.SensibilitiesForwardBondsTrader  SFBT  ON SD.id                = SFBT.id\n";
                _QueryForwardBondsTrader += "       INNER JOIN #tmpSensibilities                    SY    ON SD.sensibilitiesdate = SY.SensibilitiesDate\n";
                _QueryForwardBondsTrader += "                                                            AND SD.OperationNumber   = SY.OperationNumber\n";
                _QueryForwardBondsTrader += " WHERE SD.system                  = 'BFW'\n";
                _QueryForwardBondsTrader += "   AND SD.productid               = '10'\n";

                if (!conditions.Equals(""))
                {
                    _QueryForwardBondsTrader += " AND (" + conditions + ")\n";
                }

                _QueryForwardBondsTrader += " GROUP BY\n";
                _QueryForwardBondsTrader += "       SD.sensibilitiesdate\n\n";

                _QueryForwardBondsTrader += "UPDATE #tmpResultado\n";
                _QueryForwardBondsTrader += "   SET Readjustment = (ReadjustmentAsset + ReadjustmentLiabilities) * (currencyvaluetoday - currencyvalueyesterday)\n";
                _QueryForwardBondsTrader += "  FROM dbo.ExchangeValue\n";
                _QueryForwardBondsTrader += " WHERE currencydate = [Date]\n";
                _QueryForwardBondsTrader += "   AND currencyid   = 998\n\n";

                _QueryForwardBondsTrader += "UPDATE #tmpResultado\n";
                _QueryForwardBondsTrader += "   SET ExchangeRate = ExchangeRate - Readjustment\n\n";

                _QueryForwardBondsTrader += "UPDATE #tmpResultado\n";
                _QueryForwardBondsTrader += "   SET SubTotalNotExchangeRate = EffectRate + TimeDecay + New + Expiry + CashFlow + Readjustment \n";
                _QueryForwardBondsTrader += "     , SubTotalExchangeRate    = EffectRate + TimeDecay + New + Expiry + CashFlow + ExchangeRate + Readjustment\n";
                _QueryForwardBondsTrader += "     , SubTotalEffect          = EffectRate + TimeDecay + New + Expiry + ExchangeRate + Readjustment\n";
                _QueryForwardBondsTrader += "     , Ratio                   = CASE WHEN EffectRate = 0 THEN 0 ELSE Estimation / EffectRate END\n\n";

                _QueryForwardBondsTrader += "SELECT [Date]\n";
                _QueryForwardBondsTrader += "     , EffectRate\n";
                _QueryForwardBondsTrader += "     , TimeDecay\n";
                _QueryForwardBondsTrader += "     , ExchangeRate\n";
                _QueryForwardBondsTrader += "     , Readjustment\n";
                _QueryForwardBondsTrader += "     , New\n";
                _QueryForwardBondsTrader += "     , Expiry\n";
                _QueryForwardBondsTrader += "     , CashFlow\n";
                _QueryForwardBondsTrader += "     , SubTotalNotExchangeRate\n";
                _QueryForwardBondsTrader += "     , SubTotalExchangeRate\n";
                _QueryForwardBondsTrader += "     , SubTotalEffect\n";
                _QueryForwardBondsTrader += "     , Total\n";
                _QueryForwardBondsTrader += "     , Estimation\n";
                _QueryForwardBondsTrader += "     , Ratio\n";
                _QueryForwardBondsTrader += "  FROM #tmpResultado\n";
                _QueryForwardBondsTrader += " ORDER BY\n";
                _QueryForwardBondsTrader += "       [Date]\n\n";

                _QueryForwardBondsTrader += "DROP TABLE #tmpResultado\n";
                _QueryForwardBondsTrader += "DROP TABLE #tmpSensibilities\n\n";

                _QueryForwardBondsTrader += "SET NOCOUNT OFF\n";

                #endregion

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
                DataTable _PortFolioData;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryForwardBondsTrader);
                    _PortFolioData = _Connect.QueryDataTable();
                    _PortFolioData.TableName = "ResultForwardBondsTrader";

                    if (_PortFolioData.Rows.Count.Equals(0))
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
                    _PortFolioData = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _PortFolioData;

            }

            private DataTable LoadReportMonthlyResultSwap(string conditions)
            {

                String _QuerySwap = "";

                #region "Query Swap"

                _QuerySwap += "SET NOCOUNT ON\n\n";

                _QuerySwap += "SELECT 'SensibilitiesDate'             = SY.sensibilitiesdate\n";
                _QuerySwap += "     , 'OperationNumber'               = SY.operationnumber\n";
                _QuerySwap += "     , 'Sensibilities'                 = SUM( SY.sensibilities )\n";
                _QuerySwap += "     , 'Estimation'                    = SUM( SY.estimationvalue )\n";
                _QuerySwap += "  INTO #tmpSensibilities\n";
                _QuerySwap += "  FROM dbo.SensibilitiesYield SY\n";
                _QuerySwap += " WHERE SY.system                       = 'PCS'\n";
                _QuerySwap += " GROUP BY\n";
                _QuerySwap += "       SY.sensibilitiesdate\n";
                _QuerySwap += "     , SY.OperationNumber\n\n";

                _QuerySwap += "SELECT 'Date'                    = SD.sensibilitiesdate\n";
                _QuerySwap += "     , 'EffectRate'              = SUM( CASE WHEN SW.status = 'N' THEN 0\n";
                _QuerySwap += "                                             WHEN SW.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
                _QuerySwap += "                                             THEN SW.marktomarketvalueeffectrate - SW.marktomarketvalueyesterday\n";
                _QuerySwap += "                                             ELSE 0\n";
                _QuerySwap += "                                        END\n";
                _QuerySwap += "                                      )\n";
                _QuerySwap += "     , 'TimeDecay'               = SUM( CASE WHEN SW.status                      = 'N'                  THEN 0\n";
                _QuerySwap += "                                             WHEN SW.courtdatecouponasset        = SD.sensibilitiesdate THEN 0\n";
                _QuerySwap += "                                             WHEN SW.courtdatecouponliabilities  = SD.sensibilitiesdate THEN 0\n";
                _QuerySwap += "                                             WHEN (SW.ContractDate               <> SD.sensibilitiesdate\n";
                _QuerySwap += "                                               OR  SD.ExpiryDate                 <> SD.sensibilitiesdate)\n";
                _QuerySwap += "                                              AND  SW.marktomarketvaluetimedecay <> 0\n";
                _QuerySwap += "                                                  THEN SW.marktomarketvaluetimedecay - SW.marktomarketvalueyesterday\n";
                _QuerySwap += "                                                  ELSE 0\n";
                _QuerySwap += "                                        END +\n";
                _QuerySwap += "                                        CASE WHEN SW.status                      = 'N'                  THEN 0\n";
                _QuerySwap += "                                             WHEN SW.courtdatecouponasset        = SD.sensibilitiesdate THEN 0\n";
                _QuerySwap += "                                             WHEN SW.courtdatecouponliabilities  = SD.sensibilitiesdate THEN 0\n";
                _QuerySwap += "                                             WHEN SW.courtdatecouponasset        = SD.sensibilitiesdate THEN SW.cashflow\n";
                _QuerySwap += "                                             WHEN SW.courtdatecouponliabilities  = SD.sensibilitiesdate THEN SW.cashflow\n";
                _QuerySwap += "                                             ELSE 0\n";
                _QuerySwap += "                                        END\n";
                _QuerySwap += "                                      )\n";
                _QuerySwap += "     , 'ExchangeRateAsset'       = SUM( CASE WHEN SW.status                      = 'N'                  THEN 0\n";
                _QuerySwap += "                                             WHEN SW.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
                _QuerySwap += "                                              AND SW.marktomarketvalueexchangerate <> 0 AND SD.primarycurrencyid <> 998 AND SD.primarycurrencyid <> 999 THEN SW.exchangerateasset - SW.fairvalueassetyesterday\n";
                _QuerySwap += "                                             ELSE 0\n";
                _QuerySwap += "                                        END\n";
                _QuerySwap += "                                      )\n";
                _QuerySwap += "     , 'ExchangeRateLiabilities' = SUM( CASE WHEN SW.status                      = 'N'                  THEN 0\n";
                _QuerySwap += "                                             WHEN SW.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
                _QuerySwap += "                                              AND SW.marktomarketvalueexchangerate <> 0 AND SD.secondcurrencyid <> 998 AND SD.secondcurrencyid <> 999 THEN SW.fairvalueliabilitiesyesterday - SW.exchangerateliabilities\n";
                _QuerySwap += "                                             ELSE 0\n";
                _QuerySwap += "                                        END\n";
                _QuerySwap += "                                      )\n";
                _QuerySwap += "     , 'ExchangeRate'            = CAST( 0 AS FLOAT )\n";
                _QuerySwap += "     , 'ReadjustmentAsset'       = SUM( CASE WHEN SW.status                      = 'N'                  THEN 0\n";
                _QuerySwap += "                                             WHEN SW.ContractDate <> SD.sensibilitiesdate AND SD.ExpiryDate <> SD.sensibilitiesdate\n";
                _QuerySwap += "                                              AND SW.marktomarketvalueexchangerate <> 0 AND SD.primarycurrencyid = 998 THEN SW.exchangerateasset - SW.fairvalueassetyesterday\n";
                _QuerySwap += "                                             ELSE 0\n";
                _QuerySwap += "                                        END\n";
                _QuerySwap += "                                      )\n";
                _QuerySwap += "     , 'ReadjustmentLiabilities' = SUM( CASE WHEN SW.status                      = 'N'                  THEN 0\n";
                _QuerySwap += "                                             WHEN SW.marktomarketvalueexchangerate <> 0 AND SD.secondcurrencyid = 998 THEN SW.fairvalueliabilitiesyesterday - SW.exchangerateliabilities\n";
                _QuerySwap += "                                             ELSE 0\n";
                _QuerySwap += "                                        END\n";
                _QuerySwap += "                                      )\n";
                _QuerySwap += "     , 'Readjustment'            = CAST( 0 AS FLOAT )\n";
                _QuerySwap += "     , 'New'                     = SUM( CASE WHEN SW.ContractDate = SD.sensibilitiesdate THEN SW.marktomarketvaluetoday - SW.marktomarketvalueyesterday\n";
                _QuerySwap += "                                                                                         ELSE 0\n";
                _QuerySwap += "                                        END\n";
                _QuerySwap += "                                      )\n";
                _QuerySwap += "     , 'Expiry'                  = SUM( CASE WHEN SW.status                      = 'N'                  THEN -SW.marktomarketvalueyesterday\n";
                _QuerySwap += "                                             WHEN SW.courtdatecouponasset        = SD.sensibilitiesdate THEN SW.cashflow * -1\n";
                _QuerySwap += "                                             WHEN SW.courtdatecouponliabilities  = SD.sensibilitiesdate THEN SW.cashflow * -1\n";
                _QuerySwap += "                                             ELSE 0\n";
                _QuerySwap += "                                        END\n";
                _QuerySwap += "                                      )\n";
                _QuerySwap += "     , 'CashFlow'                = SUM( cashflow )\n";
                _QuerySwap += "     , 'SubTotalNotExchangeRate' = CAST( 0 AS FLOAT )\n";
                _QuerySwap += "     , 'SubTotalExchangeRate'    = CAST( 0 AS FLOAT )\n";
                _QuerySwap += "     , 'SubTotalEffect'          = CAST( 0 AS FLOAT )\n";
                _QuerySwap += "     , 'Total'                   = SUM( SW.marktomarketvaluetoday - SW.marktomarketvalueyesterday )\n";
                _QuerySwap += "     , 'Estimation'              = SUM( CASE WHEN SW.contractdate = SD.sensibilitiesdate THEN 0.0 ELSE SY.Estimation    END )\n";
                _QuerySwap += "     , 'Ratio'                   = CAST( 0 AS FLOAT )\n";
                _QuerySwap += "     , 'SubTotal'                = CAST( 0 AS FLOAT )\n";
                _QuerySwap += "     , 'DeltaMTMYesterday'       = SUM( CASE WHEN SW.contractdate <> SD.sensibilitiesdate THEN SW.fairvaluenetportfolioyesterday - SW.fairvaluenetyesterday ELSE 0 END )\n";
                _QuerySwap += "  INTO #tmpResultado\n";
                _QuerySwap += "  FROM dbo.SensibilitiesData             SD\n";
                _QuerySwap += "       INNER JOIN dbo.SensibilitiesSwap  SW  ON SD.id                = SW.id\n";
                _QuerySwap += "       INNER JOIN #tmpSensibilities      SY  ON SD.sensibilitiesdate = SY.SensibilitiesDate\n";
                _QuerySwap += "                                            AND SD.OperationNumber   = SY.OperationNumber\n";
                _QuerySwap += " WHERE SD.system                  = 'PCS'\n";

                if (!conditions.Equals(""))
                {
                    _QuerySwap += " AND (" + conditions + ")\n";
                }

                _QuerySwap += " GROUP BY\n";
                _QuerySwap += "       SD.sensibilitiesdate\n\n";

                _QuerySwap += "UPDATE #tmpResultado\n";
                _QuerySwap += "   SET Readjustment = ReadjustmentAsset + ReadjustmentLiabilities\n";
                _QuerySwap += "     , ExchangeRate = ExchangeRateAsset + ExchangeRateLiabilities\n";
                _QuerySwap += "  FROM dbo.ExchangeValue\n";
                _QuerySwap += " WHERE currencydate = [Date]\n";
                _QuerySwap += "   AND currencyid   = 998\n\n";

                _QuerySwap += "UPDATE #tmpResultado\n";
                _QuerySwap += "   SET SubTotalNotExchangeRate = EffectRate + TimeDecay + New + Expiry + CashFlow + Readjustment \n";
                _QuerySwap += "     , SubTotalExchangeRate    = EffectRate + TimeDecay + New + Expiry + CashFlow + ExchangeRate + Readjustment\n";
                _QuerySwap += "     , SubTotalEffect          = EffectRate + TimeDecay + New + Expiry + ExchangeRate + Readjustment\n";
                _QuerySwap += "     , SubTotal                = Total + CashFlow + New + Expiry - ExchangeRate\n";
                _QuerySwap += "     , Ratio                   = CASE WHEN EffectRate = 0 THEN 0 ELSE Estimation / EffectRate END\n\n";

                _QuerySwap += "SELECT [Date]\n";
                _QuerySwap += "     , EffectRate\n";
                _QuerySwap += "     , TimeDecay\n";
                _QuerySwap += "     , ExchangeRate\n";
                _QuerySwap += "     , Readjustment\n";
                _QuerySwap += "     , New\n";
                _QuerySwap += "     , Expiry\n";
                _QuerySwap += "     , CashFlow\n";
                _QuerySwap += "     , SubTotalNotExchangeRate\n";
                _QuerySwap += "     , SubTotalExchangeRate\n";
                _QuerySwap += "     , SubTotalEffect\n";
                _QuerySwap += "     , Total\n";
                _QuerySwap += "     , SubTotal\n";
                _QuerySwap += "     , Estimation\n";
                _QuerySwap += "     , Ratio\n";
                _QuerySwap += "     , DeltaMTMYesterday\n";
                _QuerySwap += "  FROM #tmpResultado\n";
                _QuerySwap += " ORDER BY\n";
                _QuerySwap += "       [Date]\n\n";

                _QuerySwap += "DROP TABLE #tmpResultado\n";
                _QuerySwap += "DROP TABLE #tmpSensibilities\n\n";

                _QuerySwap += "SET NOCOUNT OFF\n";

                #endregion

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
                DataTable _PortFolioData;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QuerySwap);
                    _PortFolioData = _Connect.QueryDataTable();
                    _PortFolioData.TableName = "ResultSWAP";

                    if (_PortFolioData.Rows.Count.Equals(0))
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
                    _PortFolioData = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _PortFolioData;

            }

            #endregion

            #region "LoadFlow"

            public override DataSet LoadFlow(string system, DateTime processdate, string conditions)
            {

                DataSet _DataSet = new DataSet();
                String _System = "";

                switch (system)
                {
                    case "FBTR":
                        _DataSet.Merge(LoadFlowFixingIncome(processdate, conditions));
                        _System = "BTR";
                        break;
                    case "FFWD":
                        _DataSet.Merge(LoadFlowForward(processdate, conditions));
                        _System = "FWD";
                        break;
                    case "FFBT":
                        _DataSet.Merge(LoadFlowForwardBondsTrader(processdate, conditions));
                        _System = "FWD";
                        break;
                    case "FSWP":
                        _DataSet.Merge(LoadRFlowSwap(processdate, conditions));
                        _System = "PCS";
                        break;
                }

                _DataSet.Merge(LoadFlow(processdate, _System, conditions));

                return _DataSet;

            }

            private DataTable LoadFlowFixingIncome(DateTime processdate, string conditions)
            {

                return new DataTable();

            }

            private DataTable LoadFlowForward(DateTime processdate, string conditions)
            {

                return new DataTable();

            }

            private DataTable LoadFlowForwardBondsTrader(DateTime processdate, string conditions)
            {

                return new DataTable();

            }

            private DataTable LoadRFlowSwap(DateTime processdate, string conditions)
            {

                String _QuerySwap = "";

                #region "Query Swap"

                _QuerySwap += "SET NOCOUNT ON\n\n";

                _QuerySwap += "SELECT 'ID'                              = SD.id\n";
                _QuerySwap += "     , 'SensibilitiesDate'               = SD.sensibilitiesdate\n";
                _QuerySwap += "     , 'System'                          = SD.System\n";
                _QuerySwap += "     , 'BookID'                          = SD.bookid\n";
                _QuerySwap += "     , 'PortFolioRulesID'                = SD.portfoliorulesid\n";
                _QuerySwap += "     , 'FinancialPortFolioID'            = SD.financialportfolioid\n";
                _QuerySwap += "     , 'Productid'                       = SD.productid\n";
                _QuerySwap += "     , 'PrimaryCurrencyID'               = SD.primarycurrencyid\n";
                _QuerySwap += "     , 'SecondCurrencyID'                = SD.secondcurrencyid\n";
                _QuerySwap += "     , 'PrimaryRateID'                   = SD.primaryrateid\n";
                _QuerySwap += "     , 'SecondRateID'                    = SD.secondrateid\n";
                _QuerySwap += "     , 'FamilyID'                        = SD.familyid\n";
                _QuerySwap += "     , 'MNemonicsMask'                   = SD.mnemonicsmask\n";
                _QuerySwap += "     , 'MNemonics'                       = SD.mnemonics\n";
                _QuerySwap += "     , 'IssueID'                         = SD.issueid\n";
                _QuerySwap += "     , 'FlagQuotes'                      = SD.flagquotes\n";
                _QuerySwap += "     , 'ExpiryDate'                      = SD.expirydate\n";
                _QuerySwap += "     , 'DocumentNumber'                  = SD.documentnumber\n";
                _QuerySwap += "     , 'Operationnumber'                 = SD.operationnumber\n";
                _QuerySwap += "     , 'OperationID'                     = SD.operationid\n";
                _QuerySwap += "     , 'CustomerID'                      = SD.customerid\n";
                _QuerySwap += "     , 'CustomerCode'                    = SD.customercode\n";
                _QuerySwap += "     , 'UserID'                          = SD.userid\n";
                _QuerySwap += "     , 'Sensibilitiesdate'               = SS.sensibilitiesdate\n";
                _QuerySwap += "     , 'Contractdate'                    = SS.contractdate\n";
                _QuerySwap += "     , 'Amountasset'                     = SS.amountasset\n";
                _QuerySwap += "     , 'Amountliabilities'               = SS.amountliabilities\n";
                _QuerySwap += "     , 'MarkToMarketValueYesterday'      = SS.marktomarketvalueyesterday\n";
                _QuerySwap += "     , 'MarkToMarketValueYesterdayUM'    = SS.marktomarketvalueyesterdayum\n";
                _QuerySwap += "     , 'MarkToMarketValueToday'          = SS.marktomarketvaluetoday\n";
                _QuerySwap += "     , 'MarkToMarketValueTodayUM'        = SS.marktomarketvaluetodayum\n";
                _QuerySwap += "     , 'MarkToMarketValueTimeDecay'      = SS.marktomarketvaluetimedecay\n";
                _QuerySwap += "     , 'MarkToMarketValueExchangeRate'   = SS.marktomarketvalueexchangerate\n";
                _QuerySwap += "     , 'MarkToMarketValueRffectTate'     = SS.marktomarketvalueeffectrate\n";
                _QuerySwap += "     , 'MarkToMarketVateYesterday'       = SS.marktomarketrateyesterday\n";
                _QuerySwap += "     , 'MarkToMarketRateToday'           = SS.marktomarketratetoday\n";
                _QuerySwap += "     , 'MarkToMarketRateEndMonth'        = SS.marktomarketrateendmonth\n";
                _QuerySwap += "     , 'CashFlow'                        = SS.cashflow\n";
                _QuerySwap += "     , 'CourtDatecouponasset'            = SS.courtdatecouponasset\n";
                _QuerySwap += "     , 'CourtDatecouponliabilities'      = SS.courtdatecouponliabilities\n";
                _QuerySwap += "     , 'OperationNew'                    = SS.operationnew\n";
                _QuerySwap += "     , 'RateAsset'                       = SS.rateasset\n";
                _QuerySwap += "     , 'SpreadAsset'                     = SS.spreadasset\n";
                _QuerySwap += "     , 'ConventionAsset'                 = SS.conventionasset\n";
                _QuerySwap += "     , 'FairValueAsset'                  = SS.fairvalueasset\n";
                _QuerySwap += "     , 'FairValueAssetUM'                = SS.fairvalueassetum\n";
                _QuerySwap += "     , 'FairValueAssetYesterday'         = SS.fairvalueassetyesterday\n";
                _QuerySwap += "     , 'FairValueAssetYesterdayUM'       = SS.fairvalueassetyesterdayum\n";
                _QuerySwap += "     , 'RateLiabilities'                 = SS.rateliabilities\n";
                _QuerySwap += "     , 'SpreadLiabilities'               = SS.spreadliabilities\n";
                _QuerySwap += "     , 'ConventionLiabilities'           = SS.conventionliabilities\n";
                _QuerySwap += "     , 'FairValueLiabilities'            = SS.fairvalueliabilities\n";
                _QuerySwap += "     , 'FairValueLiabilitiesUM'          = SS.fairvalueliabilitiesum\n";
                _QuerySwap += "     , 'FairValueLiabilitiesYesterday'   = SS.fairvalueliabilitiesyesterday\n";
                _QuerySwap += "     , 'FairValueLiabilitiesYesterdayUM' = SS.fairvalueliabilitiesyesterdayum\n";
                _QuerySwap += "     , 'FairValueNet'                    = SS.fairvaluenet\n";
                _QuerySwap += "     , 'FairValueNetYesterday'           = SS.fairvaluenetyesterday\n";
                _QuerySwap += "     , 'FairValueAssetSystem'            = SS.fairvalueassetsystem\n";
                _QuerySwap += "     , 'FairValueAssetUMSystem'          = SS.fairvalueassetumsystem\n";
                _QuerySwap += "     , 'FairValueLiabilitiesSystem'      = SS.fairvalueliabilitiessystem\n";
                _QuerySwap += "     , 'FairValueLiabilitiesUMSystem'    = SS.fairvalueliabilitiesumsystem\n";
                _QuerySwap += "     , 'FairValueNetSystem'              = SS.fairvaluenetsystem\n";
                _QuerySwap += "     , 'Status'                          = SS.status\n";
                _QuerySwap += "  FROM dbo.SensibilitiesData SD\n";
                _QuerySwap += "       INNER JOIN dbo.SensibilitiesSwap SS  on SS.ID = SD.id\n";
                _QuerySwap += " WHERE SD.sensibilitiesdate      = '" + processdate.ToString("yyyyMMdd") + "'\n";

                if (!conditions.Equals(""))
                {
                    _QuerySwap += " AND (" + conditions + ")\n";
                }

                _QuerySwap += "\n";

                _QuerySwap += "SET NOCOUNT OFF\n";

                #endregion

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
                DataTable _PortFolioData;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QuerySwap);
                    _PortFolioData = _Connect.QueryDataTable();
                    _PortFolioData.TableName = "FlowSwap";

                    if (_PortFolioData.Rows.Count.Equals(0))
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
                    _PortFolioData = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _PortFolioData;

            }

            private DataTable LoadFlow(DateTime processdate, string systemid, string conditions)
            {

                String _QueryFlow = "";

                #region "Query Flow"

                _QueryFlow += "SET NOCOUNT ON\n\n";

                _QueryFlow += "SELECT 'ID'                       = SF.id\n";
                _QueryFlow += "     , 'SensibilitiesDate'        = SF.sensibilitiesdate\n";
                _QueryFlow += "     , 'System'                   = SF.system\n";
                _QueryFlow += "     , 'DataID'                   = SF.dataid\n";
                _QueryFlow += "     , 'OperationID'              = SF.operationid\n";
                _QueryFlow += "     , 'LegID'                    = SF.legid\n";
                _QueryFlow += "     , 'FixingDate'               = SF.fixingdate\n";
                _QueryFlow += "     , 'StartingDate'             = SF.startingdate\n";
                _QueryFlow += "     , 'ExpiryDate'               = SF.expirydate\n";
                _QueryFlow += "     , 'PaymentDate'              = SF.paymentdate\n";
                _QueryFlow += "     , 'Balance'                  = SF.balance\n";
                _QueryFlow += "     , 'OutStanding'              = SF.balance + SF.amortizationflow\n";
                _QueryFlow += "     , 'ExchangePrincipal'        = SF.exchangeprincipal\n";
                _QueryFlow += "     , 'PostPounding'             = SF.postpounding\n";
                _QueryFlow += "     , 'Rate'                     = SF.rate\n";
                _QueryFlow += "     , 'Spread'                   = SF.spread\n";
                _QueryFlow += "     , 'AmortizationFlow'         = SF.amortizationflow\n";
                _QueryFlow += "     , 'InterestFlow'             = SF.interestflow\n";
                _QueryFlow += "     , 'AditionalFlow'            = SF.aditionalflow\n";
                _QueryFlow += "     , 'TotalFlow'                = SF.totalflow\n";
                _QueryFlow += "     , 'RateDicount'              = SF.ratediscount\n";
                _QueryFlow += "     , 'WellFactor'               = SF.wellfactor\n";
                _QueryFlow += "     , 'AmortizationPresentValue' = SF.amortizationpresentvalue\n";
                _QueryFlow += "     , 'InterestPresentValue'     = SF.interestpresentvalue\n";
                _QueryFlow += "     , 'AditionalPresentValue'    = SF.aditionalpresentvalue\n";
                _QueryFlow += "     , 'PresentValue'             = SF.presentvalue\n";
                _QueryFlow += "  FROM dbo.SensibilitiesData SD\n";
                _QueryFlow += "       INNER JOIN dbo.SensibilitiesFlow SF ON SF.DataID = SD.id\n";
                _QueryFlow += " WHERE SD.sensibilitiesdate      = '" + processdate.ToString("yyyyMMdd") + "'\n";
                _QueryFlow += "   AND SD.system                 = '" + systemid + "'\n";

                if (!conditions.Equals(""))
                {
                    _QueryFlow += " AND (" + conditions + ")\n";
                }

                _QueryFlow += "\n";

                _QueryFlow += "SET NOCOUNT OFF\n";

                #endregion

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
                DataTable _PortFolioData;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryFlow);
                    _PortFolioData = _Connect.QueryDataTable();
                    _PortFolioData.TableName = "Flow";

                    if (_PortFolioData.Rows.Count.Equals(0))
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
                    _PortFolioData = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _PortFolioData;

            }

            #endregion

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
