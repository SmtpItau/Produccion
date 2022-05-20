using System;
using System.Collections;
using System.Text;
using System.Data;
using System.Configuration;
using System.Collections.Specialized;

namespace cData.Parameters
{

    public class Turing2009Data
    {

        protected enumStatus mStatus;
        protected enumSource mSource;
        protected String mError;
        protected String mStack;

        public Turing2009Data()
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
                    _Message = "";
                    break;
            }
            return _Message;
        }

        public DataTable LoadRate()
        {
            DataTable _Rate = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _Rate = _System.LoadRate();
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _Rate = _Bloomberg.LoadRate();
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _Rate = _Excel.LoadRate();
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                default:
                    break;
            }

            return _Rate;

        }

        public DataTable LoadCurrency()
        {
            DataTable _Currency = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _Currency = _System.LoadCurrency();
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _Currency = _Bloomberg.LoadCurrency();
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _Currency = _Excel.LoadCurrency();
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                default:
                    break;
            }

            return _Currency;

        }

        public DataTable LoadConvention()
        {

            DataTable _Convention = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _Convention = _System.LoadConvention();
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _Convention = _Bloomberg.LoadConvention();
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _Convention = _Excel.LoadConvention();
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                default:
                    break;
            }

            return _Convention;

        }

        public DataTable LoadYield(int system, int rateid, int currencyprimaryid, int currencysecondaryid)
        {

            DataTable _Yield = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                    SourceSystem _System = new SourceSystem();

                    _Yield = _System.LoadYield(system, rateid, currencyprimaryid, currencysecondaryid);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _Yield = _Bloomberg.LoadYield(system, rateid, currencyprimaryid, currencysecondaryid);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _Yield = _Excel.LoadYield(system, rateid, currencyprimaryid, currencysecondaryid);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                default:
                    break;
            }

            return _Yield;

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

            public virtual DataTable LoadRate()
            {
                DataTable _Rate = new DataTable();

                return _Rate;
            }

            public virtual DataTable LoadCurrency()
            {
                DataTable _Currency = new DataTable();

                return _Currency;
            }

            public virtual DataTable LoadConvention()
            {
                DataTable _Convention = new DataTable();

                return _Convention;
            }

            public virtual DataTable LoadYield(int system, int rateid, int currencyprimaryid, int currencysecondaryid)
            {
                DataTable _Yield = new DataTable();

                return _Yield;
            }

        }

        private class SourceSystem : Source
        {

            public override DataTable LoadRate()
            {

                String _RateQuery = "";

                _RateQuery += "SELECT 'Codigo'      = CAST( tbcodigo1 as int )\n";
                _RateQuery += "     , 'Descripcion' = tbglosa\n";
                _RateQuery += "  FROM dbo.TABLA_GENERAL_DETALLE\n";
                _RateQuery += " WHERE tbcateg       = 1042\n";
                _RateQuery += "   AND tbcodigo1    <> '0'\n";
                _RateQuery += " ORDER BY\n";
                _RateQuery += "      CAST( tbcodigo1 as int )\n";

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _Rate;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_RateQuery);
                    _Rate = _Connect.QueryDataTable();
                    _Rate.TableName = "Rate";

                    if (_Rate.Rows.Count.Equals(0))
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
                    _Rate = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _Rate;
            }

            public override DataTable LoadCurrency()
            {

                String _CurrencyQuery = "";

                _CurrencyQuery += "SELECT 'Codigo'        = mncodmon\n";
                _CurrencyQuery += "     , 'Nemotecnico'   = mnnemo\n";
                _CurrencyQuery += "     , 'Glosa'         = mnglosa\n";
                _CurrencyQuery += "     , 'RespectoDolar' = mnrrda\n";
                _CurrencyQuery += "  FROM dbo.MONEDA\n";
                _CurrencyQuery += " WHERE mntipmon <> 1\n";

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _Currency;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_CurrencyQuery);
                    _Currency = _Connect.QueryDataTable();
                    _Currency.TableName = "Currency";

                    if (_Currency.Rows.Count.Equals(0))
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
                    _Currency = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _Currency;
            }

            public override DataTable LoadConvention()
            {

                String _ConventionQuery = "";

                _ConventionQuery += "SELECT 'ID'          = id\n";
                _ConventionQuery += "     , 'Description' = description\n";
                _ConventionQuery += "     , 'SystemID'    = systemid\n";
                _ConventionQuery += "  FROM dbo.tblConvention\n";

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
                DataTable _Convention;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_ConventionQuery);
                    _Convention = _Connect.QueryDataTable();
                    _Convention.TableName = "Convention";

                    if (_Convention.Rows.Count.Equals(0))
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
                    _Convention = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _Convention;

            }

            public override DataTable LoadYield(int system, int rateid, int currencyprimaryid, int currencysecondaryid)
            {

                String _YieldConfigQuery = "";

                _YieldConfigQuery += "SELECT 'ID'                  = id\n";
                _YieldConfigQuery += "     , 'System'              = system\n";
                _YieldConfigQuery += "     , 'RateID'              = rateid\n";
                _YieldConfigQuery += "     , 'CurrencyPrimaryID'   = currencyprimaryid\n";
                _YieldConfigQuery += "     , 'CurrencySecondaryID' = currencysecondaryid\n";
                _YieldConfigQuery += "     , 'YieldNameProjected'  = yieldnameprojected\n";
                _YieldConfigQuery += "     , 'YieldNameDiscount'   = yieldnamediscount\n";
                _YieldConfigQuery += "     , 'TermBenchMark'       = termbenchmark\n";
                _YieldConfigQuery += "  FROM dbo.tblYieldConfig\n";
                _YieldConfigQuery += " WHERE system                = " + system.ToString() + "\n";
                _YieldConfigQuery += "   AND rateid                = " + rateid.ToString() + "\n";
                _YieldConfigQuery += "   AND currencyprimaryid     = " + currencyprimaryid.ToString() + "\n";
                _YieldConfigQuery += "   AND currencysecondaryid   = " + currencysecondaryid.ToString() + "\n";

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("TURING");
                DataTable _Currency;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_YieldConfigQuery);
                    _Currency = _Connect.QueryDataTable();
                    _Currency.TableName = "YieldConfig";

                    if (_Currency.Rows.Count.Equals(0))
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
                    _Currency = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _Currency;
               
            }

        }

        private class SourceBloomberg : Source
        {
        }

        private class SourceExcel : Source
        {
        }

    }

}
