using System;

namespace cFinancialTools.Currency
{

    public class CurrencyValue
    {
        protected DateTime mDate;
        protected double mExchangeRate;
        protected double mParity;

        public CurrencyValue()
        {
            DateTime _date = new DateTime(1999, 1, 1);
            Set(_date, 0, 0, 0, 0);
        }

        public CurrencyValue(DateTime date, double exchangeRate)
        {
            Set(date, exchangeRate, exchangeRate, exchangeRate, 0);
        }

        public CurrencyValue(DateTime date, double exchangeRateBid, double exchangeRateOffer, double exchangeRateMid, double parity)
        {
            Set(date, exchangeRateBid, exchangeRateOffer, exchangeRateMid, parity);
        }

        public DateTime Date
        {
            get
            {
                return mDate;
            }
            set
            {
                mDate = value;
            }

        }

        public double ExchangeRate
        {
            get
            {
                return mExchangeRate;
            }
            set
            {
                mExchangeRate = value;
            }
        }

        public double ExchangeRateBid { get; set; }

        public double ExchangeRateOffer { get; set; }

        public double ExchangeRateMid { get; set; }

        public double Parity
        {
            get
            {
                return mParity;
            }
            set
            {
                mParity = value;
            }
        }

        protected void Set(DateTime date, double exchangeRateBid, double exchangeRateOffer, double exchangeRateMid, double parity)
        {
            mDate = date;
            mExchangeRate = exchangeRateBid;
            ExchangeRateBid = exchangeRateBid;
            ExchangeRateOffer = exchangeRateOffer;
            ExchangeRateMid = exchangeRateMid;
            mParity = parity;
        }

    }

}

