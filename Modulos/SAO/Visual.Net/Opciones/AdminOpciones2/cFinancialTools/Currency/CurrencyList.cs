using System;
using System.Collections;
using System.Text;
using System.Data;
using cData.Currency;
using Turing2009Data.Parameters.Exchange;

namespace cFinancialTools.Currency
{

    public class CurrencyList
    {

        #region "Definicion de Variables"

        private Hashtable mList;
        private String mMessage;
        private String mStack;
        private ArrayList mCurrency;

        #endregion

        #region "Constructor"

        public CurrencyList()
        {
            mList = new Hashtable();
            mCurrency = new ArrayList();
        }

        public CurrencyList(int id, enumSource sourceID, DateTime date)
        {
            mList = new Hashtable();
            Load(id, sourceID, date, "");
        }

        public CurrencyList(int id, enumSource sourceID, DateTime date, String curveID)
        {
            mList = new Hashtable();
            Load(id, sourceID, date, curveID);
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

        public ArrayList Currency
        {
            get
            {
                return mCurrency;
            }
        }

        public enumSetPrincingLoading SetPricingLoading { get; set; }

        #endregion

        #region "Funciones publicas"

        #region "Status"

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

        #endregion

        #region "Load"

        public bool Load(int id, enumSource sourceID, DateTime date, String curveID)
        {
            bool _Status = false;

            Currency _Currency = new Currency();
            CurrencySource _CurrencySource = new CurrencySource();
            DateTime _Date = date;

            try
            {
                if (!Find(id))
                {
                    _Currency = (Currency)LoadCurrency(id);
                    _Currency.CurveID = curveID;
                }
                else
                {
                    _Currency = Read(id);
                }

                if (!_Currency.Find(sourceID))
                {
                    _Currency.Add(sourceID);
                }

                _CurrencySource = (CurrencySource)_Currency.Read(sourceID);

                if (SetPricingLoading == enumSetPrincingLoading.OrginalSystem || id.Equals(800))
                {
                    LoadCurrencyValue(id, sourceID, date);
                }
                else
                {
                    LoadCurrencyValue(id, sourceID, date, (int)SetPricingLoading);
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

        public bool Load(int id, enumSource sourceID, DateTime dateRateFrom, DateTime dateRateTo, String curveID)
        {

            bool _Status = false;

            Currency _Currency = new Currency();
            CurrencySource _CurrencySource = new CurrencySource();
            bool _CheckDate = false;
            DateTime _Date = dateRateFrom;

            try
            {
                if (!Find(id))
                {
                    _Currency = (Currency)LoadCurrency(id);
                    _Currency.CurveID = curveID;
                }
                else
                {
                    _Currency = Read(id);
                }

                if (!_Currency.Find(sourceID))
                {
                    _Currency.Add(sourceID);
                }

                _CurrencySource = (CurrencySource)_Currency.Read(sourceID);


                while (_Date <= dateRateTo)
                {
                    if (!_CurrencySource.Find(_Date))
                    {
                        _CheckDate = true;
                        break;
                    }
                    _Date = _Date.AddDays(1);
                }

                if (_CheckDate == true)
                {
                    if (SetPricingLoading == enumSetPrincingLoading.OrginalSystem || id.Equals(800))
                    {
                        LoadCurrencyValue(id, sourceID, dateRateFrom, dateRateTo);
                    }
                    else
                    {
                        LoadCurrencyValue(id, sourceID, dateRateFrom, (int)SetPricingLoading);
                    }
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

        #endregion

        #region "Find"

        public bool Find(int id)
        {
            Currency _Currency = new Currency();
            String _ID = id.ToString();
            bool _Status = true;

            _Currency = (Currency)mList[_ID];

            if (_Currency == null)
            {
                _Status = false;
            }

            return _Status;
        }

        public bool Find(int id, enumSource sourceID, DateTime date)
        {
            bool _Status = false;
            if (Find(id))
            {
                if (Read(id).Find(sourceID))
                {
                    if (Read(id).Read(sourceID).Find(date))
                    {
                        _Status = true;
                    }
                }
            }
            return _Status;
        }

        #endregion

        #region "Add"

        public void Add(Currency currency)
        {

            string _ID = currency.ID.ToString();

            mList.Add(_ID, currency);

        }

        #endregion

        #region "Read"

        public Currency Read(int id)
        {
            String _ID = id.ToString();
            Currency _Currency = new Currency();

            if (Find(id))
            {
                _Currency = (Currency)mList[_ID];
            }

            return _Currency;
        }

        public CurrencySource Read(int id, enumSource sourceID)
        {
            return Read(id).Read(sourceID);
        }

        public CurrencyValue Read(int id, enumSource sourceID, DateTime date)
        {
            return Read(id, sourceID).Read(date);
        }

        #endregion

        #region "ReadAll"

        public Hashtable ReadAll()
        {
            return mList;
        }

        #endregion

        #region "Save"

        public void Save(int id, DateTime portFolioDate, enumSource source, DateTime dateYield1, DateTime dateYield2, int userid)
        {

            string _Query;

            CurrencyValue _CurrencyYesterday = new CurrencyValue();
            CurrencyValue _CurrencyToday = new CurrencyValue();

            _CurrencyToday = Read(id, source, dateYield1);
            _CurrencyYesterday = Read(id, source, dateYield2);

            _Query = "";
            _Query += "DECLARE @ID       NUMERIC(18)\n";
            _Query += "DECLARE @Date     DATETIME\n";
            _Query += "DECLARE @Currency INTEGER\n\n";

            _Query += "SET @Date     = '[@Date]'\n";
            _Query += "SET @Currency = [@Currency]\n\n";

            _Query += "DELETE dbo.ExchangeValue WHERE currencyDate = @Date AND currencyid = @Currency\n\n";

            _Query += "SET @ID = CONVERT( NUMERIC(18), REPLACE( CONVERT( VARCHAR(10), @Date, 102 ), '.', '' ) ) * 100000000 + \n";
            _Query += "          CASE @Currency WHEN 13 THEN 1 WHEN 994 THEN 2 WHEN 998 THEN 3 WHEN 999 THEN 4 ELSE 5 END\n\n";

            _Query += "INSERT INTO dbo.ExchangeValue ( ";
            _Query += "id";
            _Query += ", currencydate";
            _Query += ", currencyid";
            _Query += ", currencyvaluetoday";
            _Query += ", currencyvalueyesterday";
            _Query += ", creatordate";
            _Query += ", creatoruser";
            _Query += ")";
            _Query += "VALUES (";
            _Query += "@ID";
            _Query += ", @Date" ;
            _Query += ", @Currency";
            _Query += ", [@RateToday]";
            _Query += ", [@RateYesterDay]";
            _Query += ", GETDATE()";
            _Query += ", [@User]";
            _Query += ")";

            _Query = _Query.Replace("[@Date]", dateYield1.ToString("yyyyMMdd"));
            _Query = _Query.Replace("[@Currency]", id.ToString());
            _Query = _Query.Replace("[@RateToday]", _CurrencyToday.ExchangeRate.ToString().Replace(",", "."));
            _Query = _Query.Replace("[@RateYesterDay]", _CurrencyYesterday.ExchangeRate.ToString().Replace(",", "."));
            _Query = _Query.Replace("[@User]", userid.ToString());

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("Turing");
            _Connect.Execute(_Query);
            _Connect = null;

        }

        #endregion

        #endregion

        #region "Funciones Protegidas"

        protected Currency LoadCurrency(int id)
        {

            DataTable _DataCurrency;
            cData.Currency.Currency _LoadCurrency = new cData.Currency.Currency();
            String _ID = id.ToString();
            enumRelacionRespectoDolar _RelacionRespectoDolar = enumRelacionRespectoDolar.Divide;
            enumBasis _Basis = enumBasis.Basis_Act_360;
            int _Decimals = 0;

            _DataCurrency = (DataTable)_LoadCurrency.Load(id);

            if (_DataCurrency.Rows[0]["RelacionRespectoDolar"].ToString() == "M")
            {
                _RelacionRespectoDolar = enumRelacionRespectoDolar.Multiplica;
            }

            if (_DataCurrency.Rows[0]["Base"].ToString() == "30")
            {
                _Basis = enumBasis.Basis_Act_30;
            }
            else if (_DataCurrency.Rows[0]["Base"].ToString() == "360")
            {
                _Basis = enumBasis.Basis_Act_360;
            }
            else if (_DataCurrency.Rows[0]["Base"].ToString() == "365")
            {
                _Basis = enumBasis.Basis_Act_365;
            }
            else
            {
                _Basis = enumBasis.Basis_Act_360;
            }
            _Decimals = int.Parse(_DataCurrency.Rows[0]["Decimales"].ToString());

            Currency _Currency = new Currency( 
                                               id,
                                               _DataCurrency.Rows[0]["Descripcion"].ToString(),
                                               _DataCurrency.Rows[0]["Nemotecnico"].ToString(),
                                               _RelacionRespectoDolar,
                                               _Basis,
                                               _Decimals
                                             );

            mList.Add(_ID, _Currency);
            mCurrency.Add(_ID);

            return _Currency;

        }

        protected bool LoadCurrencyValue(int id, enumSource sourceID, DateTime date)
        {
            Currency _Currency;
            CurrencySource _CurrencySource;
            cData.Currency.Currency _LoadCurrency = new cData.Currency.Currency(sourceID);
            DataTable _DataCurrency;
            String _ID = id.ToString();
            String _SourceID = sourceID.ToString();
            int _Row;
            DateTime _Date;

            _Currency = (Currency)mList[_ID];
            _CurrencySource = (CurrencySource)_Currency.Read(sourceID);

            if (id.Equals(999) || id.Equals(13))
            {

                _CurrencySource.Add(date, (double)1); // ojo si se cargan mas 

                _Currency.Status = _LoadCurrency.Status;
                _Currency.Message = _LoadCurrency.Message;
            }
            else
            {
                _DataCurrency = (DataTable)_LoadCurrency.LoadValue(id, date);

                for (_Row = 0; _Row < _DataCurrency.Rows.Count; _Row++)
                {
                    _Date = (DateTime)_DataCurrency.Rows[_Row]["Date"];

                    if (!_CurrencySource.Find(_Date))
                    {
                        _CurrencySource.Add(_Date, (Double)_DataCurrency.Rows[_Row]["Value"]);
                    }
                }

                _Currency.Status = _LoadCurrency.Status;
                _Currency.Message = _LoadCurrency.Message;
            }

            _Currency.Item(sourceID, _CurrencySource);
            mList[_ID] = _Currency;

            return true;

        }

        protected bool LoadCurrencyValue(int id, enumSource sourceID, DateTime dateFrom, DateTime dateTo)
        {
            Currency _Currency;
            CurrencySource _CurrencySource;
            cData.Currency.Currency _LoadCurrency = new cData.Currency.Currency(sourceID);
            DataTable _DataCurrency;
            String _ID = id.ToString();
            String _SourceID = sourceID.ToString();
            int _Row;
            DateTime _Date;

            _Currency = (Currency)mList[_ID];
            _CurrencySource = (CurrencySource)_Currency.Read(sourceID);

            if (id.Equals(999) || id.Equals(13))
            {
                _Date = new DateTime(dateFrom.Year, dateFrom.Month, dateFrom.Day);

                while (dateTo >= _Date)
                {
                    _CurrencySource.Add(_Date, (Double)1); // ojo si se cargan mas 
                    _Date = _Date.AddDays(1);
                }

                _Currency.Status = _LoadCurrency.Status;
                _Currency.Message = _LoadCurrency.Message;
            }
            else
            {
                _DataCurrency = (DataTable)_LoadCurrency.LoadValue(id, dateFrom, dateTo);

                for (_Row = 0; _Row < _DataCurrency.Rows.Count; _Row++)
                {
                    _Date = (DateTime)_DataCurrency.Rows[_Row]["Date"];

                    if (!_CurrencySource.Find(_Date))
                    {
                        _CurrencySource.Add(_Date, (Double)_DataCurrency.Rows[_Row]["Value"]);
                    }
                }

                _Currency.Status = _LoadCurrency.Status;
                _Currency.Message = _LoadCurrency.Message;
            }

            _Currency.Item(sourceID, _CurrencySource);
            mList[_ID] = _Currency;

            return true;

        }

        protected bool LoadCurrencyValue(int id, enumSource sourceID, DateTime date, int setPricingLoading)
        {

            Currency _Currency;
            CurrencySource _CurrencySource;
            Turing2009Data.Parameters.Exchange.RealTimeExchangeRateLoad _LoadCurrency = new RealTimeExchangeRateLoad();

            DataTable _DataCurrency;
            String _ID = id.ToString();
            String _SourceID = sourceID.ToString();
            int _Row;
            DateTime _Date;

            _Currency = (Currency)mList[_ID];
            _CurrencySource = (CurrencySource)_Currency.Read(sourceID);

            if (id.Equals(999) || id.Equals(13))
            {
                _Date = new DateTime(date.Year, date.Month, date.Day);

                _CurrencySource.Add(_Date, 1, 1, 1); // ojo si se cargan mas 
                _Date = _Date.AddDays(1);

                //_Currency.Status = (enumStatus)_LoadCurrency.Status; _LoadCurrency.Status;
                //_Currency.Message = _LoadCurrency.Message;
            }
            else
            {

                int _CurrencyPrimary = 0;
                int _CurrencySecondary = 0;

                switch (id)
                {
                    case 994:
                        _CurrencyPrimary = 13;
                        _CurrencySecondary = 999;
                        break;
                    case 998:
                        _CurrencyPrimary = 998;
                        _CurrencySecondary = 999;
                        break;
                    case 142:
                        _CurrencyPrimary = 142;
                        _CurrencySecondary = 999;
                        break;
                }

                _DataCurrency = (DataTable)_LoadCurrency.Load(date, setPricingLoading, _CurrencyPrimary, _CurrencySecondary);

                for (_Row = 0; _Row < _DataCurrency.Rows.Count; _Row++)
                {
                    _Date = date;

                    if (!_CurrencySource.Find(_Date))
                    {
                        _CurrencySource.Add(
                                             _Date,
                                             double.Parse(_DataCurrency.Rows[_Row]["ValueBid"].ToString()),
                                             double.Parse(_DataCurrency.Rows[_Row]["ValueAsk"].ToString()),
                                             double.Parse(_DataCurrency.Rows[_Row]["ValueMid"].ToString())
                                           );
                    }
                }

                //_Currency.Status = _LoadCurrency.Status;
                //_Currency.Message = _LoadCurrency.Message;
            }

            _Currency.Item(sourceID, _CurrencySource);
            mList[_ID] = _Currency;

            return true;

        }

        #endregion

    }

}
