using System;
using System.Collections;
using System.Text;
using cFinancialTools;
using cFinancialTools.DayCounters;
using cFinancialTools.Currency;
using cFinancialTools.Yield;
using cFinancialTools.Instruments;

namespace cFinancialTools.Valuation
{

    public class LettersOfCreditMortgage
    {

        private enumSource mSourceID;
        private DateTime mValuatorDate;
        private DateTime mYieldDate;
        private DateTime mCurrencyDate;
        private int mModeOfCalculation;
        private MNemonics mMNemonics;
        private CurrencyList mCurrencyList;
        private int mCurrentCoupon;
        private int mFlag;
        private enumValuatorFixingRate mValuatorFixingRate;
        private cFinancialTools.Yield.Yield mYield;

        public LettersOfCreditMortgage(
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
            mFlag = 0;
            mYield = yield;
            mValuatorFixingRate = valuatorFixingRate;
        }

        public MNemonics MNemonics
        {
            get
            {
                return mMNemonics;
            }
        }

        public void ValuatorLettersOfCreditMortgage()
        {

            int _Cuopons = 0;
            double _Rate = 0;
            double _PresenteValueUM = 0;
            double _AmountBasis100;
            DateTime _Fecha = new DateTime(1900, 1, 1);
            Basis _Basis = new Basis();
            ArrayList _CouponList = new ArrayList();
            DevelonmentTable _DevelonmentTable = new DevelonmentTable();
            double _ExchangeRate = 0;
            int _Currency = mMNemonics.IssueCurrency;

            if (_Currency.Equals(999))
            {
                _ExchangeRate = 1.0;
            }
            else
            {
                _ExchangeRate = mCurrencyList.Read(_Currency, mSourceID, mCurrencyDate).ExchangeRate;
            }

            _Cuopons = mMNemonics.Coupons;
            _Rate = mMNemonics.PurchaseRate;
            _PresenteValueUM = mMNemonics.PresentValueUM;

            _CouponList = mMNemonics.Read(mSourceID).ReadAll();

            for (_Cuopons = 0; _Cuopons < _CouponList.Count; _Cuopons++)
            {
                _DevelonmentTable = (DevelonmentTable)_CouponList[_Cuopons];

                if (_DevelonmentTable.ExpiryDate > mValuatorDate)
                {
                    mCurrentCoupon = _Cuopons;
                    break;
                }
            }

            mFlag = 0;

            if (mMNemonics.Mnemonics.Substring(6, 2).Equals(" *") || mMNemonics.Mnemonics.Substring(6, 2).Equals(" &"))
            {
                mCurrentCoupon++;
                mFlag = 1;
            }

            if (mMNemonics.Mnemonics.Substring(6, 2).Equals("**") || mMNemonics.Mnemonics.Substring(6, 2).Equals("&&"))
            {
                mCurrentCoupon += 2;
                mFlag = 2;
            }


            mMNemonics.NetPresenteValue = 100; // falta pasar a la clase

            _Basis = new Basis(mMNemonics.ValuatorBasis, mValuatorDate, mMNemonics.ExpiryDate);

            MNemonics.ParValue = ParValue();

            switch (mModeOfCalculation)
            {
                case 1:
                    _AmountBasis100 = AmountBasis100(MNemonics.PriceValue, MNemonics.ParValue);
                    MNemonics.PurchaseRate = CalculateRate(_AmountBasis100);
                    NetValueCurrent();
                    MNemonics.PresentValueUM = (MNemonics.ParValue / 100.0) * MNemonics.Nominal * MNemonics.PriceValue * 0.01;
                    mMNemonics.PresentValueCLP = Math.Round(mMNemonics.PresentValueUM * _ExchangeRate, 0);
                    break;

                case 2:
                    NetValueCurrent();

                    if (MNemonics.Flotanting)
                    {
                        MNemonics.NetPresenteValue = Math.Round(MNemonics.NetPresenteValue, 3);
                    }

                    if (mValuatorFixingRate.Equals(enumValuatorFixingRate.Sensibilite))
                    {
                        MNemonics.PriceValue = (MNemonics.NetPresenteValue / MNemonics.ParValue) * 100.0;
                    }
                    else
                    {
                        MNemonics.PriceValue = Math.Round((MNemonics.NetPresenteValue / MNemonics.ParValue) * 100.0, 2);
                    }

                    _AmountBasis100 = AmountBasis100(MNemonics.PriceValue, MNemonics.ParValue);
                    MNemonics.PresentValueUM = Math.Round((MNemonics.ParValue / 100.0) * MNemonics.Nominal * MNemonics.PriceValue * 0.01, 4);
                    mMNemonics.PresentValueCLP = Math.Round(mMNemonics.PresentValueUM * _ExchangeRate, 0);

                    break;

                case 3:
                    MNemonics.PresentValueUM = Math.Round(mMNemonics.PresentValueCLP / _ExchangeRate, 4);
                    _AmountBasis100 = AmountBasis100(MNemonics.PriceValue, MNemonics.ParValue);
                    MNemonics.PurchaseRate = CalculateRate(_AmountBasis100);

                    if (MNemonics.Flotanting)
                    {
                        MNemonics.PurchaseRate = Math.Round(MNemonics.PurchaseRate, 7);
                    }

                    NetValueCurrent();

                    MNemonics.PriceValue = Math.Round((MNemonics.NetPresenteValue / MNemonics.ParValue) * 100.0, 2);
                    MNemonics.PresentValueUM = (MNemonics.ParValue / 100.0) * MNemonics.Nominal * MNemonics.PriceValue * 0.01;
                    mMNemonics.PresentValueCLP = Math.Round(mMNemonics.PresentValueUM * _ExchangeRate, 0);

                    break;

                default:
                    break;
            }

            #region "Expiry Flow"

            mMNemonics.CouponAmortization = 0;
            mMNemonics.CouponInterest = 0;
            mMNemonics.CouponFlow = 0;
            mMNemonics.CouponFlowCLP = 0;

            if (!mCurrentCoupon.Equals(0))
            {
                _DevelonmentTable = (DevelonmentTable)_CouponList[mCurrentCoupon - 1];
                if (_DevelonmentTable.ExpiryDate.Equals(mValuatorDate))
                {
                    mMNemonics.CouponAmortization = mMNemonics.Nominal * _DevelonmentTable.Amortization * 0.01;
                    mMNemonics.CouponInterest = mMNemonics.Nominal * _DevelonmentTable.Interest * 0.01;
                    mMNemonics.CouponFlow = mMNemonics.Nominal * _DevelonmentTable.Flow * 0.01;
                    mMNemonics.CouponFlowCLP = Math.Round(mMNemonics.CouponFlow * _ExchangeRate, 0);
                    mMNemonics.CourtDateCoupon = _DevelonmentTable.ExpiryDate;
                }
            }

            #endregion


        }

        private double ParValue()
        {
            int _Coupon;
            DevelonmentTable _DevelonmentTable = new DevelonmentTable();
            Basis _Basis = new Basis();
            double _Value;
            double _ParValue;
            Basis _BasisDays = new Basis();
            Basis _BasisCouponDays = new Basis();
            DateTime _Date;
            DateTime _ValuatorDate;
            ArrayList _CouponList = new ArrayList();
            int _Days = 0;

            _ValuatorDate = mValuatorDate;
            _CouponList = mMNemonics.Read(mSourceID).ReadAll();

            if (_ValuatorDate.Day > 30)
            {
                _ValuatorDate = _ValuatorDate.AddDays(30 - _ValuatorDate.Day);
            }

            if (mFlag == 0)
            {
                if (mCurrentCoupon <= 0)
                {
                    _Date = mMNemonics.StartingDate;
                }
                else
                {
                    _DevelonmentTable = (DevelonmentTable)_CouponList[mCurrentCoupon - 1];

                    _Date = _DevelonmentTable.ExpiryDate;
                }

                _DevelonmentTable = (DevelonmentTable)_CouponList[mCurrentCoupon];
                _BasisDays = new Basis(enumBasis.Basis_30E_360, _Date, _ValuatorDate);
                _ParValue = Math.Round((_DevelonmentTable.Balance + _DevelonmentTable.Amortization) * Math.Pow(1.0 + mMNemonics.AnnualRateRealEffect * 0.01,
                                       _BasisDays.TermBasis), 8);
            }
            else
            {
                //SELECT @fVpar = SUM( tdflujo/POWER((1+@nTera/100),(((30*DATEDIFF(MONTH,@dFeccal,tdfecven))-DATEPART(DAY,@dFeccal))+1)/360))
                //  FROM #Temp
                //WHERE tdmascara=SUBSTRING(@cMascara,1,6) AND tdcupon>@nNumucup 
                _ParValue = 0;
                _Value = 0;
                _DevelonmentTable = (DevelonmentTable)_CouponList[mCurrentCoupon - 1];

                _Date = _DevelonmentTable.ExpiryDate;

                for (_Coupon = mCurrentCoupon; _Coupon < _CouponList.Count; _Coupon++)
                {
                    _DevelonmentTable = (DevelonmentTable)_CouponList[_Coupon];
                    _Days = (360 * (_DevelonmentTable.ExpiryDate.Year - _ValuatorDate.Year)) +
                            (30 * (_DevelonmentTable.ExpiryDate.Month - _ValuatorDate.Month)) - _ValuatorDate.Day * 1 + 1;
                    _Value = (_DevelonmentTable.Flow / Math.Pow(1.0 + mMNemonics.AnnualRateRealEffect * 0.01, _Days / 360.0));
                    _ParValue += _Value;
                    _Date = _DevelonmentTable.ExpiryDate;

                }

            }

            return _ParValue;

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

            int _Coupon;
            double _NetCurrentValue = 0;
            double _DurationMacaulay = 0;
            double _Convextion = 0;
            double _Period = 12 / (double)MNemonics.ExpiryCouponPeriod;
            double _Days;
            double _Rate;
            ArrayList _CouponList = new ArrayList();
            DevelonmentTable _DevelonmentTable = new DevelonmentTable();

            _CouponList = mMNemonics.Read(mSourceID).ReadAll();

            for (_Coupon = mCurrentCoupon; _Coupon < _CouponList.Count; _Coupon++)
            {
                _DevelonmentTable = (DevelonmentTable)_CouponList[_Coupon];
                _Days = (360 * (_DevelonmentTable.ExpiryDate.Year - mValuatorDate.Year)) +
                        (30 * (_DevelonmentTable.ExpiryDate.Month - mValuatorDate.Month)) - mValuatorDate.Day;

                if (mYield.Read(enumSource.System).Read(mYieldDate).RateType == enumRate.RateOriginal)
                {
                    _Rate = 1.0 + MNemonics.PurchaseRate * 0.01;
                }
                else
                {
                    _Rate = 1.0 + (mYield.Read(enumSource.System).Read(mYieldDate).Read((int)_Days).Rate) * 0.01;
                }

                _NetCurrentValue += (_DevelonmentTable.Flow / Math.Pow(_Rate, (_Days + 1.0) / mMNemonics.IssueBasis));
                _DurationMacaulay += (_DevelonmentTable.Flow * _Days / mMNemonics.IssueBasis) / Math.Pow(_Rate, _Days / mMNemonics.IssueBasis);
                _Convextion += (_DevelonmentTable.Flow * _Days / mMNemonics.IssueBasis) * (_Days / mMNemonics.IssueBasis + 1.0) /
                               Math.Pow(_Rate, _Days / mMNemonics.IssueBasis);

            }

            MNemonics.NetPresenteValue = _NetCurrentValue;
            MNemonics.DurationMacaulay = Math.Round(_DurationMacaulay / _NetCurrentValue, 8);
            MNemonics.Convextion = Math.Round((_Convextion / Math.Pow(1.0 + MNemonics.PurchaseRate * 0.01, 2)) / MNemonics.NetPresenteValue, 8);
            MNemonics.DurationModificed = Math.Round(MNemonics.DurationMacaulay / (1.0 + (MNemonics.PurchaseRate * 0.01 / _Period)), 8);

        }

    }

}
