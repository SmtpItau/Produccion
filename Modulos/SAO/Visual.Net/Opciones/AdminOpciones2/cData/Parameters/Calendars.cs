using System;
using System.Collections;
using System.Text;
using System.Data;
using System.Configuration;
using System.Collections.Specialized;

namespace cData.Parameters
{

    public class Calendars
    {

        protected enumStatus mStatus;
        protected enumSource mSource;
        protected String mError;
        protected String mStack;

        public Calendars()
        {
            Set(enumSource.System);
        }

        public Calendars(enumSource id)
        {
            Set(id);
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

        public DataTable Load(int town)
        {
            DataTable _Calendars = new DataTable();

            switch (mSource)
            {
                case enumSource.System:
                case enumSource.CurrencyValueAccount:
                    SourceSystem _System = new SourceSystem();

                    _Calendars = _System.Load(town);
                    mStatus = _System.Status;
                    mError = _System.Error;
                    mStack = _System.Stack;

                    break;

                case enumSource.Bloomberg:
                    SourceBloomberg _Bloomberg = new SourceBloomberg();

                    _Calendars = _Bloomberg.Load(town);
                    mStatus = _Bloomberg.Status;
                    mError = _Bloomberg.Error;
                    mStack = _Bloomberg.Stack;

                    break;

                case enumSource.Excel:
                    SourceExcel _Excel = new SourceExcel();

                    _Calendars = _Excel.Load(town);
                    mStatus = _Excel.Status;
                    mError = _Excel.Error;
                    mStack = _Excel.Stack;

                    break;

                default:
                    break;
            }

            return _Calendars;

        }

        protected void Set(enumSource id)
        {
            mStatus = enumStatus.Initialize;
            mSource = id;
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
            }

            public virtual DataTable Load(int town)
            {
                DataTable _Calendars = new DataTable();

                return _Calendars;
            }

        }

        private class SourceSystem : Source
        {

            public override DataTable Load(int town)
            {
                String _QueryCalendars = "";

                _QueryCalendars += "SELECT 'Town'      = feplaza\n";
                _QueryCalendars += "     , 'Year'      = feano\n";
                _QueryCalendars += "     , 'January'   = feene\n";
                _QueryCalendars += "     , 'February'  = fefeb\n";
                _QueryCalendars += "     , 'March'     = femar\n";
                _QueryCalendars += "     , 'April'     = feabr\n";
                _QueryCalendars += "     , 'May'       = femay\n";
                _QueryCalendars += "     , 'June'      = fejun\n";
                _QueryCalendars += "     , 'July'      = fejul\n";
                _QueryCalendars += "     , 'August'    = feago\n";
                _QueryCalendars += "     , 'September' = fesep\n";
                _QueryCalendars += "     , 'October'   = feoct\n";
                _QueryCalendars += "     , 'November'  = fenov\n";
                _QueryCalendars += "     , 'December'  = fedic\n";
                _QueryCalendars += "  FROM BacParamSuda..FERIADO\n";
                if (!town.Equals(0))
                {
                    _QueryCalendars += " WHERE feplaza     = " + town.ToString() + "\n";
                }
                _QueryCalendars += " ORDER BY\n";
                _QueryCalendars += "       feplaza\n";
                _QueryCalendars += "     , feano\n";

                cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
                DataTable _Calendars;

                try
                {
                    // Definición de la Curva
                    Status = enumStatus.Loading;
                    _Connect.Execute(_QueryCalendars);
                    _Calendars = _Connect.QueryDataTable();
                    _Calendars.TableName = "Calendars";

                    if (_Calendars.Rows.Count.Equals(0))
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
                    _Calendars = null;
                    Status = enumStatus.ErrorLoad;
                    Error = _Error.StackTrace;
                    Stack = _Error.Message;
                }

                return _Calendars;
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
