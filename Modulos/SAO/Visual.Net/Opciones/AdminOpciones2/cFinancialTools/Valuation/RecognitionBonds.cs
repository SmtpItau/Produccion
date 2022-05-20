using System;
using System.Collections;
using System.Text;
using cFinancialTools;
using cFinancialTools.DayCounters;
using cFinancialTools.Currency;
using cFinancialTools.Instruments;
using System.Data;

namespace cFinancialTools.Valuation
{

    public class RecognitionBonds
    {

        private enumSource mSourceID;
        private DateTime mValuatorDate;
        private DateTime mYieldDate;
        private DateTime mCurrencyDate;
        private int mModeOfCalculation;
        private MNemonics mMNemonics;
        private CurrencyList mCurrencyList;
        private int mCurrentCoupon;
        private enumValuatorFixingRate mValuatorFixingRate;
        private cFinancialTools.Yield.Yield mYield;

        public RecognitionBonds(
                                 enumSource sourceID,
                                 enumValuatorFixingRate valuatorFixingRate,
                                 DateTime valuatorDate,
                                 DateTime yieldDate,
                                 DateTime currencyDate,
                                 int modeOfCalculation,
                                 MNemonics mnemonics,
                                 CurrencyList currencyList,
                                 cFinancialTools.Yield.Yield yield
                               )
        {
            mSourceID = sourceID;
            mValuatorDate = valuatorDate;
            mYieldDate = yieldDate;
            mCurrencyDate = currencyDate;
            mModeOfCalculation = modeOfCalculation;
            mMNemonics = mnemonics;
            mCurrencyList = currencyList;
            mYield = yield;
            mValuatorFixingRate = valuatorFixingRate;
            mCurrentCoupon = 0;
        }

        public MNemonics MNemonics
        {
            get
            {
                return mMNemonics;
            }
        }

        public void ValuatorRecognitionBonds()
        {

            int _Cuopons = 0;
            double _Rate = 0;
            Basis _Basis = new Basis();
            double _PresenteValueUM = 0;
            double _AmountBasis100;
            DateTime _Fecha = new DateTime(1900, 1, 1);
            ArrayList _CouponList = new ArrayList();
            DevelonmentTable _DevelonmentTable = new DevelonmentTable();
            double _ExchangeRate = 0;
            int _Currency = mMNemonics.IssueCurrency;
            double _IPCtoday;
            double _IPCIssue;
            int _YearIssue = 0;
            int _MonthIssue = 0;
            int _FactorIssue = 0;
            double _FlotingRate = 4.0;
            double _Factor;
            double _ParValue1;
            double _ParValue2;
            DateTime _IPCTodayDate;

            _ExchangeRate = 1.0;

            _Basis = new Basis(mMNemonics.ValuatorBasis, mValuatorDate, mMNemonics.ExpiryDate);

            #region "Carga IPCs"

            mCurrencyList.Load(502, mSourceID, MNemonics.StartingDate, ""); // IPC Emisión
            _IPCIssue = mCurrencyList.Read(502, mSourceID, MNemonics.StartingDate).ExchangeRate;

            //_IPCTodayDate = new DateTime(mCurrencyDate.Year, mCurrencyDate.Month, 1);
            //_IPCTodayDate = _IPCTodayDate.AddMonths(-1);
            _IPCTodayDate = MNemonics.DateICP;

            if (!ValidIPC(_IPCTodayDate, mValuatorDate))
            {

                _IPCTodayDate = _IPCTodayDate.AddMonths(-1);

            }

            //mCurrencyList.Load(502, mSourceID, _IPCTodayDate, ""); // IPC hoy
            _IPCtoday = mCurrencyList.Read(502, mSourceID, _IPCTodayDate).ExchangeRate;

            #endregion

            _Cuopons = mMNemonics.Coupons;
            _Rate = mMNemonics.PurchaseRate;
            _PresenteValueUM = mMNemonics.PresentValueUM;

            mMNemonics.NetPresenteValue = 100;

            _Basis = new Basis(mMNemonics.ValuatorBasis, mValuatorDate, mMNemonics.ExpiryDate);

            CalculateFactor(MNemonics.StartingDate, mCurrencyDate, ref _YearIssue, ref _MonthIssue, ref _FactorIssue);

            _Factor = Math.Pow(1.0 + _FlotingRate * 0.01, _YearIssue + _FactorIssue) * (1.0 + _FlotingRate * 0.01 * _MonthIssue / 12.0);
            
            _ParValue1 = Math.Round(100.0 * (_IPCtoday / _IPCIssue) * _Factor, 8);
            _ParValue2 = Math.Round(100.0 * _Factor, 8);

            MNemonics.ParValue = _ParValue1;
            MNemonics.ParValue2 = _ParValue2;

            switch (mModeOfCalculation)
            {
                case 1:
                    _AmountBasis100 = AmountBasis100(MNemonics.PriceValue, MNemonics.ParValue);
                    mMNemonics.PurchaseRate = CalculateRate(_AmountBasis100);
                    NetValueCurrent();
                    mMNemonics.PresentValueUM = (MNemonics.ParValue * 0.01) * MNemonics.Nominal * (MNemonics.PriceValue * 0.01);
                    mMNemonics.PresentValueCLP = Math.Round(mMNemonics.PresentValueUM * _ExchangeRate, 0);
                    break;

                case 2:
                    NetValueCurrent();
                    _AmountBasis100 = AmountBasis100(mMNemonics.PriceValue, mMNemonics.ParValue);
                    mMNemonics.PresentValueUM = (mMNemonics.ParValue * 0.01) * mMNemonics.Nominal * (mMNemonics.PriceValue * 0.01);
                    mMNemonics.PresentValueCLP = Math.Round(mMNemonics.PresentValueUM * _ExchangeRate, 0);

                    break;

                case 3:
                    mMNemonics.PresentValueUM = Math.Round(mMNemonics.PresentValueCLP / _ExchangeRate, 4);
                    _AmountBasis100 = AmountBasis100(mMNemonics.PriceValue, mMNemonics.ParValue);
                    mMNemonics.PurchaseRate = CalculateRate(_AmountBasis100);

                    NetValueCurrent();

                    break;

                default:
                    break;
            }

            mMNemonics.DurationMacaulay = Math.Round(_Basis.TermBasis, 8);
            mMNemonics.DurationModificed = Math.Round(mMNemonics.DurationMacaulay / (1.0 + _Rate * 0.01), 2);
            mMNemonics.Convextion = Math.Round(Math.Pow(mMNemonics.DurationMacaulay, 2) / Math.Pow((1.0 + (_Rate * 0.01) * mMNemonics.DurationMacaulay), 2), 2);

            #region "Expiry Flow"

            mMNemonics.CouponAmortization = 0;
            mMNemonics.CouponInterest = 0;
            mMNemonics.CouponFlow = 0;
            mMNemonics.CouponFlowCLP = 0;

            if (mMNemonics.ExpiryDate.Equals(mValuatorDate))
            {
                mMNemonics.CouponAmortization = 0; // Falta Valor Compra
                MNemonics.CouponInterest = 0;
                mMNemonics.CouponFlow = MNemonics.Nominal;
                mMNemonics.CouponFlowCLP = Math.Round(mMNemonics.CouponFlow * _ExchangeRate, 0);
            }

            #endregion

        }

        private bool ValidIPC(DateTime dateIPC, DateTime valuatorDate)
        {

            DateTime _PublicationEntrySystem;

            _PublicationEntrySystem = mMNemonics.PublicationEntrySystem;

            if (_PublicationEntrySystem > valuatorDate)
            {

                return false;
            
            }
            else
            {

                return true;

            }
            
        }

        private double AmountBasis100(double pricer, double parValue)
        {
            return ((pricer * 0.01) * (parValue * 0.01) * 100.0);

        }

        private double Nominal(double transAmountUM, double nominal)
        {

            return ((transAmountUM / nominal) * 100.0);

        }

        private double CalculateRate(double presentValueBasis100)
        {

            double _Rate = 0;
            double _CalculateRate = 0;
            double _EndRate = 0;
            double _NetValueCurrent = 0;
            int _Iteration = 0;
            double _MaxRate = 50;
            double _MinRate = -50;
            DevelonmentTable _DevelonmentTable = new DevelonmentTable();
            ArrayList _CouponList = new ArrayList();

            _CalculateRate = MNemonics.AnnualRateRealEffect;

            _CouponList = MNemonics.Read(mSourceID).ReadAll();

            if (_Rate.Equals(0))
            {
                _DevelonmentTable = (DevelonmentTable)_CouponList[mCurrentCoupon];
                _CalculateRate = _DevelonmentTable.Rate;
            }

            _EndRate = _CalculateRate;
            MNemonics.PurchaseRate = _CalculateRate;

            for (_Iteration = 0; _Iteration < 50; _Iteration++)
            {
                _NetValueCurrent = 0;

                if (!((1.0 + _CalculateRate * .01) == 0))
                {
                    NetValueCurrent();
                    _NetValueCurrent = MNemonics.NetPresenteValue;
                }

                _EndRate = Math.Round(_CalculateRate, 4);

                if (_NetValueCurrent < presentValueBasis100)
                {
                    _MaxRate = _CalculateRate;
                }
                else
                {
                    _MinRate = _CalculateRate;
                }

                _CalculateRate = ((_MaxRate - _MinRate) / 2.0) + _MinRate;

                if (Math.Round(_EndRate, 4) == Math.Round(_CalculateRate, 4))
                {
                    if (_EndRate == 50)
                    {
                        _Rate = 0;
                    }
                    else
                    {
                        _Rate = Math.Round(_EndRate, 2);
                    }

                    break;
                }

            }

            MNemonics.PurchaseRate = Math.Round(_Rate, 2);
            return Math.Round(_Rate, 2);

        }

        private void NetValueCurrent()
        {


            double _IPCtoday;
            double _IPCIssue;
            int _YearValuator;
            int _MonthValuator;
            int _FactorValuator;
            double _FlotingRate = 4.0;
            double _Factor;
            Basis _Basis = new Basis();
            double _Van1;
            double _Van2;
            double _Rate;
            DateTime _IPCTodayDate;

            #region "Carga IPCs"

            _IPCIssue = mCurrencyList.Read(502, mSourceID, MNemonics.StartingDate).ExchangeRate;

            _IPCTodayDate = new DateTime(mCurrencyDate.Year, mCurrencyDate.Month, 1);
            _IPCTodayDate = _IPCTodayDate.AddMonths(-1);

            _IPCtoday = mCurrencyList.Read(502, mSourceID, _IPCTodayDate).ExchangeRate;

            #endregion

            _Basis = new Basis(enumBasis.Basis_Act_365, mValuatorDate, mMNemonics.ExpiryDate);

            if (mYield.Read(enumSource.System).Read(mYieldDate).RateType == enumRate.RateOriginal)
            {
                _Rate = mMNemonics.PurchaseRate;
            }
            else
            {
                _Rate = (mYield.Read(enumSource.System).Read(mYieldDate).Read((int)_Basis.Term).Rate);
            }

            _YearValuator = 0;
            _MonthValuator = 0;
            _FactorValuator = 0;

            CalculateFactor(MNemonics.StartingDate, mMNemonics.ExpiryDate, ref _YearValuator, ref _MonthValuator, ref _FactorValuator);


            _Factor = Math.Pow(1.0 + _FlotingRate * 0.01, _YearValuator + _FactorValuator) * (1.0 + _FlotingRate * 0.01 * _MonthValuator / 12.0);

            _Van2 = Math.Round(100.0 * _Factor, 8);

            _Van1 = _Van2 / Math.Pow(1.0 + _Rate * 0.01, _Basis.TermBasis);

            mMNemonics.PriceValue = Math.Round((_Van1 / mMNemonics.ParValue2) * 100.0, 2);
            mMNemonics.NetPresenteValue = Math.Round((mMNemonics.PriceValue * 0.01) * mMNemonics.Nominal * (mMNemonics.ParValue * 0.01));

        }

        private void CalculateFactor(DateTime dateFrom, DateTime dateTo, ref int year, ref int month, ref int factor)
        {

            int _MonthFrom;
            int _MonthTo;

            year = dateTo.Year - dateFrom.Year;

            _MonthFrom = dateFrom.Month + 1;
            _MonthTo = dateTo.Month;    
            factor = 0;

            if (_MonthTo > 12)
            {
                factor = -1;
                _MonthFrom -= 12;
            }
            else if (_MonthTo > _MonthFrom)
            {
                month = _MonthTo - _MonthFrom;
            }
            else
            {
                month = (_MonthTo + 12) - _MonthFrom;
                factor = -1;
            }

        }

    }

}
