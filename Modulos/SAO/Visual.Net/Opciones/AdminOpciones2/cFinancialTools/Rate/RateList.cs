using System;
using System.Collections;
using System.Text;
using System.Data;
using cData.Rate;

namespace cFinancialTools.Rate
{

    public class RateList
    {

#region "Definicion de Variables"

        private Hashtable mList;
        private String mMessage;
        private String mStack;

#endregion

#region "Constructor"

        public RateList()
        {
            mList = new Hashtable();
        }

        public RateList(int id, int currencyID, enumPeriod periodID, enumSource sourceID, DateTime date)
        {
            mList = new Hashtable();
            Load(id, currencyID, periodID, sourceID, date);
        }

#endregion

#region "Propiedades"

        public int Count
        {
            get
            {
                return mList.Count;
            }
        }

#endregion

#region "Funciones publicas"

        // Falta completar
        public enumStatus Status(int id)
        {
            //Hashtable _Ratestatus = new Hashtable();
            //cFinancialTools.Rate.Rate _Rate;
            //String _DateLoadRate = dateloadRate.ToString("yyyyMMdd");

            //_Ratestatus = (Hashtable)mList[id];
            //_Rate = (cFinancialTools.Rate.Rate)_Ratestatus[_DateLoadRate];
            //return _Rate.RateStatus;
            return enumStatus.Already;
        }

        // Falta completar
        public enumStatus Status(int id, enumSource sourceID)
        {
            return enumStatus.Already;
        }

        // Falta completar
        public enumStatus Status(int id, enumSource sourceID, DateTime date)
        {
            return enumStatus.Already;
        }

        // Falta completar
        public String Message(int id)
        {
            //Hashtable _Ratestatus = new Hashtable();
            //cData.Rate.enumStatus _Rate;
            //String _DateLoadRate = dateloadRate.ToString("yyyyMMdd");
            //String _Message;
            //cData.Rate.Rate _RateMessage = new cData.Rate.Rate();

            //_Rate = Ratestatus(rateID, dateloadRate);

            //_Message = _RateMessage.Message(_Rate);

            //return _Message;
            return "";
        }

        // Falta completar
        public String Message(int id, enumSource sourceID)
        {
            return "";
        }

        // Falta completar
        public String Message(int id, enumSource sourceID, DateTime date)
        {
            return "";
        }

        public bool Load(int id, int currencyID, enumPeriod periodID, enumSource sourceID, DateTime date)
        {
            bool _Status = true;
            _Status = Load(id, currencyID, periodID, sourceID, date, date);
            return _Status;
        }

        public bool Load(int id, int currencyID, enumPeriod periodID, enumSource sourceID, DateTime dateRateFrom, DateTime dateRateTo)
        {

            bool _Status = false;

            Rate _Rate = new Rate();
            RateCurrency _RateCurrency = new RateCurrency();
            RatePeriod _RatePeriod = new RatePeriod();
            RateSource _RateSource = new RateSource();
            bool _CheckDate = false;
            DateTime _Date = new DateTime(dateRateFrom.Year,dateRateFrom.Month,dateRateFrom.Day);

            try
            {
                if (!Find(id))
                {
                    _Rate = (Rate)LoadRate(id);
                }
                else
                {
                    _Rate = Read(id);
                }

                if (!_Rate.Find(currencyID))
                {
                    _Rate.Add(currencyID);
                }

                _RateCurrency = (RateCurrency)_Rate.Read(currencyID);

                if (!_RateCurrency.Find(periodID))
                {
                    _RateCurrency.Add(periodID);
                }

                _RatePeriod = (RatePeriod)_RateCurrency.Read(periodID);

                if (!_RatePeriod.Find(sourceID))
                {
                    _RatePeriod.Add(sourceID);
                }

                _RateSource = (RateSource)_RatePeriod.Read(sourceID);

                while (_Date <= dateRateTo)
                {
                    if (!_RateSource.Find(_Date))
                    {
                        _CheckDate = true;
                        break;
                    }
                    _Date = _Date.AddDays(1);
                }

                if (_CheckDate == true)
                {
                    LoadRateValue(id, currencyID, periodID, sourceID, dateRateFrom, dateRateTo);
                }
            }
            catch (Exception Error)
            {
                mMessage = Error.Message;
                mStack = Error.StackTrace;
                _Status = false;
            }

            return _Status;

        }

        public bool Find(int id)
        {
            Rate _Rate = new Rate();
            String _ID = id.ToString();
            bool _Status = true;

            _Rate = (Rate)mList[_ID];

            if (_Rate == null)
            {
                _Status = false;
            }

            return _Status;
        }

        public Rate Read(int id)
        {
            String _ID = id.ToString();
            Rate _Rate = new Rate();

            if (Find(id))
            {
                _Rate = (Rate)mList[_ID];
            }

            return _Rate;
        }

        public RateCurrency Read(int rateID, int currencyID)
        {
            return Read(rateID).Read(currencyID);
        }

        public RatePeriod Read(int rateID, int currencyID, enumPeriod periodID)
        {
            return Read(rateID, currencyID).Read(periodID);
        }

        public RateSource Read(int rateID, int currencyID, enumPeriod periodID, enumSource sourceID)
        {
            return Read(rateID, currencyID, periodID).Read(sourceID);
        }

        public RateValue Read(int rateID, int currencyID, enumPeriod periodID, enumSource sourceID, DateTime date)
        {
            return Read(rateID, currencyID, periodID, sourceID).Read(date);
        }

        public Hashtable ReadAll()
        {
            return mList;
        }

#endregion

#region "Funciones Protegidas"

        protected Rate LoadRate(int id)
        {

            DataTable _DataRate;
            cData.Rate.Rate _LoadRate = new cData.Rate.Rate();
            String _ID = id.ToString();

            _DataRate = (DataTable)_LoadRate.Load(id);

            cFinancialTools.Rate.Rate _Rate = new Rate( 
                                                        id,
                                                        _DataRate.Rows[0]["Descripcion"].ToString(),
                                                        enumPeriod.Anual,
                                                        enumBasis.Basis_Act_360
                                                      );
            mList.Add(_ID, _Rate);

            return _Rate;

        }

        protected bool LoadRateValue(int id, int currencyID, enumPeriod periodID, enumSource sourceID, DateTime dateRateFrom, DateTime dateRateTo)
        {
            Rate _Rate;
            RateCurrency _RateCurrency;
            RatePeriod _RatePeriod;
            RateSource _RateSource;
            cData.Rate.Rate _LoadRate = new cData.Rate.Rate();
            DataTable _DataRate;
            String _ID = id.ToString();
            String _SourceID = sourceID.ToString();
            int _Row;
            DateTime _RateDate;

            _Rate = (Rate)mList[_ID];
            _RateCurrency = (RateCurrency)_Rate.Read(currencyID);
            _RatePeriod = (RatePeriod)_RateCurrency.Read(periodID);
            _RateSource = (RateSource)_RatePeriod.Read(sourceID);

            _DataRate = (DataTable)_LoadRate.LoadValue(id, dateRateFrom, dateRateTo, currencyID, periodID);

            for (_Row = 0; _Row < _DataRate.Rows.Count; _Row++)
            {
                _RateDate = (DateTime)_DataRate.Rows[_Row]["Date"];

                if (!_RateSource.Find(_RateDate))
                {
                    _RateSource.Add(_RateDate, (Double)_DataRate.Rows[_Row]["Value"]);
                }
            }

            _Rate.Status = _LoadRate.Status;
            _Rate.Message = _LoadRate.Message;
            _RatePeriod.Item(sourceID, _RateSource);
            _RateCurrency.Item(periodID, _RatePeriod);
            _Rate.Item(currencyID, _RateCurrency);

            mList[_ID] = _Rate;

            return true;

        }

#endregion

    }

}
