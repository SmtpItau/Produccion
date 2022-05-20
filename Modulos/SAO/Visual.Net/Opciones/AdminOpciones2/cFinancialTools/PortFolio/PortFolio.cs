using System;
using System.Collections;
using System.Text;
using System.Data;
using cFinancialTools.Yield;
using cFinancialTools.Swap;
using cFinancialTools.Struct;
using cFinancialTools.Valuation;
using cFinancialTools.Rate;
using cFinancialTools.Currency;
using cFinancialTools.BussineDate;

namespace cFinancialTools.PortFolio
{

    public class PortFolio
    {

        #region "Atributos protegidos"

        private string mLog;                                    // Log Auditoria
        private DateTime mPortFolioDate;                        // Fecha PortFolio

        private DateTime mPortFolioYesterday;                   // Fecha de la Cartera t(-1)
        private DateTime mPortFolioToday;                       // Fecha de la Cartera t(0)
        private DateTime mPortFolioTomorrow;                    // Fecha de la Cartera t(0)
        private DateTime mEndofMonth;                           // Fecha de Fin de Mes
        private DateTime mEndofMonthSkillful;                   // Fecha de Fin de Mes Hábil
        private DateTime mPreviousEndofMonth;                   // Fecha de Fin de Mes Previo
        private DateTime mPreviousEndofMonthSkillful;           // Fecha de Fin de Mes Previo Hábil

        private DateTime mYieldToday;                           // Fecha de la carga de las Tasa de Mercado en t(0)
        private DateTime mYieldYesterday;                       // Fecha de la carga de las Tasa de Mercado en t(-1)

        private DateTime mCurrencyExchangeRateToday;            // Fecha de la carga de los Tipos de Cambio en t(0)
        private DateTime mCurrencyExchangeRateYesterday;        // Fecha de la carga de los Tipos de Cambio en t(-1)

        private DateTime mMarkToMarketYesterday;                // Fecha de la Tasa Mercado t(-1)
        private DateTime mMarkToMarketToday;                    // Fecha de la Tasa Mercado t(0)

        private enumPortFolioStatus mStatusDate;                // Estado de Proceso de la Fecha

        private bool mExistYield;                               // Existe curvas para el día de proceso

        private bool mIsBussineDays;                            // Es día habil
        private bool mIsEndOfMonth;                             // Es fin de mes

        private int mUserID;                                    // Código del Usuario
        private DataSet mLogData;
        private string mLogProcess;

        private Calendars mCalendar;

        #endregion

        #region "Constructor"

        public PortFolio()
        {

            mLog = "0";

            mStatusDate = enumPortFolioStatus.Init;             // Estado de la Fecha

            mPortFolioDate = new DateTime();                    // Fecha PortFolio

            mPortFolioYesterday = new DateTime();               // Fecha de la Cartera t(-1)
            mPortFolioToday = new DateTime();                   // Fecha de la Cartera t(0)
            mPortFolioTomorrow = new DateTime();                // Fecha de la Cartera t(0)
            mEndofMonth = new DateTime();                       // Fecha de Fin de Mes
            mEndofMonthSkillful = new DateTime();               // Fecha de Fin de Mes
            mPreviousEndofMonth = new DateTime();               // Fecha de Fin de Mes Previo
            mPreviousEndofMonthSkillful = new DateTime();       // Fecha de Fin de Mes Previo

            mYieldToday = new DateTime();                       // Fecha de la carga de las Tasa de Mercado en t(0)
            mYieldYesterday = new DateTime();                   // Fecha de la carga de las Tasa de Mercado en t(-1)

            mCurrencyExchangeRateToday = new DateTime();        // Fecha de la carga de los Tipos de Cambio en t(0)
            mCurrencyExchangeRateYesterday = new DateTime();    // Fecha de la carga de los Tipos de Cambio en t(-1)

            mMarkToMarketYesterday = new DateTime();            // Fecha de la Tasa Mercado t(-1)
            mMarkToMarketToday = new DateTime();                // Fecha de la Tasa Mercado t(0)

            mUserID = 0;
            mLogProcess = "0";
            mExistYield = false;
            mIsBussineDays = false;
            mIsEndOfMonth = false;

            mLogData = new DataSet();

            mCalendar = new Calendars();
            mCalendar.Load();
        }

        #endregion

        #region "Atributos Publicos"

        public string Log
        {
            get
            {
                return mLog;
            }
        }

        public DateTime PortFolioDate
        {
            get
            {
                return mPortFolioDate;
            }
        }

        public DateTime PortFolioYesterday
        {
            get
            {
                return mPortFolioYesterday;
            }
        }

        public DateTime PortFolioToday
        {
            get
            {
                return mPortFolioToday;
            }
        }

        public DateTime PortFolioTomorrow
        {
            get
            {
                return mPortFolioTomorrow;
            }
        }

        public DateTime EndofMonth
        {
            get
            {
                return mEndofMonth;
            }
        }

        public DateTime EndofMonthSkillful
        {
            get
            {
                return mEndofMonthSkillful;
            }
        }

        public DateTime PreviousEndofMonth
        {
            get
            {
                return mPreviousEndofMonth;
            }
        }

        public DateTime PreviousEndofMonthSkillful
        {
            get
            {
                return mPreviousEndofMonthSkillful;
            }
        }

        public DateTime YieldToday
        {
            get
            {
                return mYieldToday;
            }
        }

        public DateTime YieldYesterday
        {
            get
            {
                return mYieldYesterday;
            }
        }

        public DateTime CurrencyExchangeRateToday
        {
            get
            {
                return mCurrencyExchangeRateToday;
            }
        }

        public DateTime CurrencyExchangeRateYesterday
        {
            get
            {
                return mCurrencyExchangeRateYesterday;
            }
        }

        public DateTime MarkToMarketYesterday
        {
            get
            {
                return mMarkToMarketYesterday;
            }
        }

        public DateTime MarkToMarketToday
        {
            get
            {
                return mMarkToMarketToday;
            }
        }

        public enumPortFolioStatus StatusDate
        {
            get
            {
                return mStatusDate;
            }
        }

        public string StatusDateDescription
        {
            get
            {
                string _Status;

                switch (mStatusDate)
                {
                    case enumPortFolioStatus.Init:
                        _Status = "El componente se encuentra inicializado.";
                        break;

                    case enumPortFolioStatus.NotProcess:
                        _Status = "Fecha no procesada.";
                        break;

                    case enumPortFolioStatus.Process:
                        _Status = "Fecha ya fue procesada";
                        break;

                    case enumPortFolioStatus.Today:
                        _Status = "La fecha de proceso es la del día, y ya fue procesada.";
                        break;

                    case enumPortFolioStatus.TodayNotProcess:
                        _Status = "La fecha de proceso es la del día.";
                        break;

                    default:
                        _Status = "Estado no definido.";
                        break;

                }

                return _Status;

            }

        }

        public string LogProcess
        {
            get
            {
                return mLogProcess;
            }
        }

        public int UserID
        {
            get
            {
                return mUserID;
            }
            set
            {
                mUserID = value;
            }
        }

        public bool ExistYield
        {
            get
            {
                return mExistYield;
            }
        }

        public bool IsBussineDays
        {

            get
            {
                return mIsBussineDays;
            }

        }

        public bool IsEndOfMonth
        {

            get
            {
                return mIsEndOfMonth;
            }

        }

        #endregion

        #region "Verifica fechas"

        public void CalculateDate(DateTime date)
        {

            #region "Definición de Variables a Utilizar"

            cFinancialTools.BussineDate.BussineDate _Date;
            int _Month;

            #endregion

            #region "Inicialización de Fechas"

            mPortFolioDate = date;

            // Fecha de la Cartera t(-1)
            _Date = new cFinancialTools.BussineDate.BussineDate(mPortFolioDate);
            mPortFolioYesterday = _Date.MovesDate(enumIntervalType.DayHoliday, -1, enumConvention.NextModified, 6, mCalendar);

            // Fecha de la Cartera t(0)
            mPortFolioToday = mPortFolioDate;

            // Fecha de la Cartera t(1)
            _Date = new cFinancialTools.BussineDate.BussineDate(mPortFolioDate);
            mPortFolioTomorrow = _Date.MovesDate(enumIntervalType.DayHoliday, 1, enumConvention.NextModified, 6, mCalendar);

            // Fin de Mes
            _Date = new cFinancialTools.BussineDate.BussineDate(mPortFolioDate);
            mEndofMonth = _Date.EnfOfMonth;

            // Fin de Mes Hábil
            _Date = new cFinancialTools.BussineDate.BussineDate(mEndofMonth);
            mEndofMonthSkillful = _Date.MovesDate(enumIntervalType.DayHoliday, -1, enumConvention.Previous, 6, mCalendar);

            // Fin de Mes Previo
            _Date = new cFinancialTools.BussineDate.BussineDate(mPortFolioDate);
            mPreviousEndofMonth = _Date.PreviousEndOfMonth;

            // Fin de Mes Hábil
            _Date = new cFinancialTools.BussineDate.BussineDate(mPreviousEndofMonth);
            mPreviousEndofMonthSkillful = _Date.MovesDate(enumIntervalType.DayHoliday, -1, enumConvention.Previous, 6, mCalendar);

            // Fecha de la carga de los Tipos de Cambio en t(0)
            mCurrencyExchangeRateToday = mPortFolioToday;

            // Fecha de la carga de los Tipos de Cambio en t(-1)
            mCurrencyExchangeRateYesterday = mPortFolioYesterday;

            mIsBussineDays = mCalendar.IsBussineDay(6, mPortFolioToday);
            mIsEndOfMonth = false;

            if (mPortFolioToday.Equals(mEndofMonth))
            {
                mIsEndOfMonth = true;
            }

            if (mPortFolioToday.Equals(mEndofMonth) && !mCalendar.IsBussineDay(6, mPortFolioToday))
            {

                // Fecha Mercado Fin de Mes
                mYieldToday = mPortFolioYesterday;

                // Fecha de carga mercado 2 días habiles antes de la fecha de proceso
                //_Date = new cFinancialTools.BussineDate.BussineDate(mPortFolioYesterday);
                mYieldYesterday = mPortFolioYesterday; // _Date.MovesDate(enumIntervalType.DayHoliday, -1, enumConvention.NextModified, 6, mCalendar);

            }
            else
            {
                // Tasa de Mercado t(0)
                mYieldToday = mPortFolioToday;

                // Tasa de Mercado t(1)
                mYieldYesterday = mPortFolioYesterday;
            }

            if (mPortFolioYesterday.Equals(mPreviousEndofMonthSkillful))
            {

                // Tasa de Mercado t(1)
                mPortFolioYesterday = mPreviousEndofMonth;

            }

            if (mPortFolioTomorrow > mEndofMonth)
            {
                mPortFolioTomorrow = mEndofMonth;
            }

            // Fecha de la carga de los Tipos de Cambio en t(0)
            mCurrencyExchangeRateToday = mPortFolioToday;

            // Fecha de la carga de los Tipos de Cambio en t(-1)
            mCurrencyExchangeRateYesterday = mPortFolioYesterday;

            #endregion

            #region "Valida que exista curva para la fecha de proceso"

            if (!ExistsYield(mYieldToday))
            {

                mYieldToday = mYieldYesterday;

                _Date = new cFinancialTools.BussineDate.BussineDate(mYieldYesterday);
                mYieldYesterday = _Date.MovesDate(enumIntervalType.DayHoliday, -1, enumConvention.NextModified, 6, mCalendar);

            }

            #endregion

            #region "Fechas de Mercado para Renta Fija"

            if (mPortFolioToday.Equals(mEndofMonth))
            {

                if (mCalendar.IsBussineDay(6, mEndofMonth))
                {
                    // Fecha Mercado Fin de Mes
                    mMarkToMarketToday = mYieldToday;
                    mMarkToMarketYesterday = mYieldYesterday;
                }
                else
                {
                    // Fecha Mercado Fin de Mes
                    mMarkToMarketToday = mPortFolioToday;

                    // Fecha de carga mercado 2 días habiles antes de la fecha de proceso
                    //_Date = new cFinancialTools.BussineDate.BussineDate(mPortFolioYesterday);
                    _Date = new cFinancialTools.BussineDate.BussineDate(mYieldToday);
                    mMarkToMarketYesterday = _Date.MovesDate(enumIntervalType.DayHoliday, -1, enumConvention.NextModified, 6, mCalendar);

                }
            }
            else
            {
                // Valida que no exista un cambio de mes inhabil entre la fecha del día y el proximo día habil
                _Month = mPortFolioTomorrow.Month - mPortFolioToday.Month;
                if (_Month.Equals(1) && (!mPortFolioToday.Equals(mEndofMonth)))
                {
                    // Fecha de la carga de la Tasa de Mercado es fin de mes especial
                    mMarkToMarketToday = mEndofMonth;
                }
                else
                {
                    // Tasa de Mercado t(0)
                    mMarkToMarketToday = mYieldToday; //mPortFolioToday;
                }

                if (mPortFolioYesterday.Equals(mPreviousEndofMonth))
                {
                    // Fecha de la carga de la Tasa de Mercado es fin de mes especial
                    mMarkToMarketYesterday = mPreviousEndofMonth;
                }
                else
                {
                    // Tasa de Mercado t(1)
                    mMarkToMarketYesterday = mYieldYesterday;
                }
            }


            //if (mPortFolioToday.Equals(mEndofMonth))
            //{

            //    if (mCalendar.IsBussineDay(mEndofMonth))
            //    {

            //        mMarkToMarketToday = mPortFolioYesterday;

            //        // Fecha de carga mercado 2 días habiles antes de la fecha de proceso
            //        //_Date = new cFinancialTools.BussineDate.BussineDate(mPortFolioYesterday);
            //        _Date = new cFinancialTools.BussineDate.BussineDate(mMarkToMarketToday);
            //        mMarkToMarketYesterday = _Date.MovesDate(enumIntervalType.DayHoliday, -1, enumConvention.NextModified, mCalendar);

            //    }
            //    else
            //    {

            //        // Fecha Mercado Fin de Mes
            //        mMarkToMarketToday = mPortFolioToday;

            //        // Fecha de carga mercado 2 días habiles antes de la fecha de proceso
            //        //_Date = new cFinancialTools.BussineDate.BussineDate(mPortFolioYesterday);
            //        _Date = new cFinancialTools.BussineDate.BussineDate(mPortFolioYesterday);
            //        mMarkToMarketYesterday = _Date.MovesDate(enumIntervalType.DayHoliday, -1, enumConvention.NextModified, mCalendar);

            //    }

            //}
            //else
            //{

            //    mMarkToMarketToday = mPortFolioYesterday;

            //    _Date = new cFinancialTools.BussineDate.BussineDate(mPortFolioYesterday);
            //    mMarkToMarketYesterday = _Date.MovesDate(enumIntervalType.DayHoliday, -1, enumConvention.NextModified, mCalendar);

            //    _Month = mPortFolioToday.Month - mMarkToMarketToday.Month;
            //    if (_Month.Equals(1))
            //    {
            //        mMarkToMarketToday = mPreviousEndOfMonth;
            //    }

            //    _Month = mMarkToMarketToday.Month - mMarkToMarketYesterday.Month;
            //    if (_Month.Equals(1))
            //    {
            //        // Fecha de la carga de la Tasa de Mercado es fin de mes especial
            //        mMarkToMarketYesterday = mPreviousEndOfMonth;
            //    }

            //}

            #endregion

            #region "Valida si ya fue procesada la fecha"

            ExistsData(mPortFolioDate);

            #endregion

            #region "Destrucción de Variables Utilizadas"

            _Date = null;

            #endregion

        }

        private bool ExistsYield(DateTime yieldDate)
        {

            cData.Yield.Yield _Yield = new cData.Yield.Yield();
            DataTable _YieldData = new DataTable();
            DataRow _YieldDataRow;
            bool _Status = true;
            int _Count;

            _YieldData = _Yield.ValidYield(yieldDate);

            if (_YieldData.Rows.Count.Equals(0))
            {

                _Status = false;

            }
            else
            {

                _YieldDataRow = _YieldData.Rows[0];
                _Count = int.Parse(_YieldDataRow["Registros"].ToString());

                if (_Count.Equals(0))
                {
                    _Status = false;
                }

            }

            mExistYield = _Status;
            return _Status;

        }

        private bool ExistsCurrency(DateTime currencyDate)
        {

            cData.Currency.Currency _Currency = new cData.Currency.Currency();
            DataTable _CurrencyData = new DataTable();
            DataRow _CurrencyDataRow;
            bool _Status = true;
            int _Count;

            _CurrencyData = _Currency.ValidCurrency(currencyDate);

            if (_CurrencyData.Rows.Count.Equals(0))
            {

                _Status = false;

            }
            else
            {

                _CurrencyDataRow = _CurrencyData.Rows[0];
                _Count = int.Parse(_CurrencyDataRow["Registros"].ToString());

                if (_Count.Equals(0))
                {
                    _Status = false;
                }

            }

            mExistYield = _Status;
            return _Status;

        }

        private void ExistsData(DateTime date)
        {

            cData.Log.Log _Log = new cData.Log.Log();
            DataTable _DataLog = new DataTable();
            DataTable _DataSystem = new DataTable();

            mLogData = new DataSet();
            mLogData = _Log.LoadLog(date);

            _DataLog = mLogData.Tables["LogStatus"];
            _DataSystem = mLogData.Tables["LoadLogSystemStatus"];

            if (_DataSystem == null)
            {
                mStatusDate = enumPortFolioStatus.NotProcess;
            }
            else if (_DataSystem.Rows.Count.Equals(0))
            {
                if (date.ToString("yyyyMMdd").Equals(DateTime.Now.ToString("yyyyMMdd")))
                {
                    mStatusDate = enumPortFolioStatus.TodayNotProcess;
                }
                else
                {
                    mStatusDate = enumPortFolioStatus.NotProcess;
                }
            }
            else
            {
                if (date.ToString("yyyyMMdd").Equals(DateTime.Now.ToString("yyyyMMdd")))
                {
                    mStatusDate = enumPortFolioStatus.Today;
                }
                else
                {
                    mStatusDate = enumPortFolioStatus.Process;
                }

                mLog = _DataSystem.Rows[0]["ID"].ToString();

            }

            _DataLog = null;
            _DataSystem = null;
            _Log = null;

        }

        public DataRow SaveSystemDate(string log)
        {

            cData.Log.Log _Log = new cData.Log.Log();
            DataTable _Data = new DataTable();

            _Data = _Log.SaveSystemStatus(
                                           log,
                                           PortFolioDate,
                                           PortFolioYesterday,
                                           PortFolioToday,
                                           PortFolioTomorrow,
                                           mEndofMonth,
                                           mPreviousEndofMonth,
                                           mYieldYesterday,
                                           mYieldToday,
                                           mCurrencyExchangeRateYesterday,
                                           mCurrencyExchangeRateToday,
                                           mMarkToMarketYesterday,
                                           mMarkToMarketToday,
                                           mUserID
                                         );


            mLog = _Data.Rows[0]["ID"].ToString();

            return _Data.Rows[0];

        }

        public void InitLogProcess()
        {
            mLogProcess = "0";
        }

        public DataRow SaveLog(int processid)
        {

            cData.Log.Log _Log = new cData.Log.Log();
            DataTable _Data = new DataTable();
            DataRow _DataRow;

            _Data = _Log.SaveLog(mLogProcess, PortFolioDate, processid, mUserID);

            _DataRow = _Data.Rows[0];
            mLogProcess = _DataRow["ID"].ToString();

            _Log = null;
            _Data = null;

            return _DataRow;

        }

        public DataSet LogData()
        {

            ExistsData(mPortFolioDate);

            return mLogData;

        }

        #endregion

    }

}
