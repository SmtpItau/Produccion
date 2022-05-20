using System;
using System.Collections.Generic;
using System.Text;
using cFinancialTools;
using cFinancialTools.Currency;
using cFinancialTools.DayCounters;
using cFinancialTools.Instruments;

namespace cFinancialTools.Valuation
{

    public class ZeroCoupon
    {

        private enumSource mSourceID;
        private DateTime mValuatorDate;
        private DateTime mYieldDate;
        private DateTime mCurrencyDate;
        private int mModeOfCalculation;
        private MNemonics mMNemonics;
        private CurrencyList mCurrencyList;
        private enumValuatorFixingRate mValuatorFixingRate;
        private cFinancialTools.Yield.Yield mYield;

        public ZeroCoupon(
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
        }

        public MNemonics MNemonics
        {
            get
            {
                return mMNemonics;
            }
        }

        public void ValuatorZeroCoupon()
        {
            int _Cuopons = 0;
            double _Rate = 0;
            double _PresenteValueUM = 0;
            double _PresenteValueCLP = 0;
            double _TransAmountBasis100 = 0;
            DateTime _Fecha = new DateTime(1900, 1, 1);
            Basis _Basis = new Basis();
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
            _PresenteValueUM = mMNemonics.PresentValueUM;

            mMNemonics.NetPresenteValue = 100; // falta pasar a la clase

            _Basis = new Basis(mMNemonics.ValuatorBasis, mValuatorDate, mMNemonics.ExpiryDate);

            if (mYield.Read(enumSource.System).Read(mYieldDate).RateType == enumRate.RateOriginal)
            {
                _Rate = mMNemonics.PurchaseRate;
            }
            else
            {
                _Rate = (mYield.Read(enumSource.System).Read(mYieldDate).Read((int)_Basis.Term).Rate);
            }

            switch (mModeOfCalculation)
            {
                case 1:
                    _TransAmountBasis100 = 0;
                    mMNemonics.PurchaseRate = 0;
                    mMNemonics.PresentValueUM = 0;
                    mMNemonics.PresentValueCLP = 0;
                    break;

                case 2:
                    break;

                case 3:
                    mMNemonics.PresentValueUM = _PresenteValueUM;
                    mMNemonics.PresentValueCLP = _PresenteValueCLP;

                    _TransAmountBasis100 = TransNominalAmount(mMNemonics.PresentValueUM, mMNemonics.Nominal);
                    mMNemonics.PurchaseRate = Math.Round((((mMNemonics.Nominal / mMNemonics.PresentValueUM) - 1.0) * 100.0) * _Basis.TermBasis, 4);
                    break;

                default:
                    break;
            }

            mMNemonics.NetPresenteValue = (100.0 / (1 + (_Rate * 0.01) * _Basis.TermBasis));
            mMNemonics.PriceValue = 0;
            mMNemonics.PresentValueUM = (mMNemonics.NetPresenteValue * 0.01) * mMNemonics.Nominal;
            mMNemonics.PresentValueCLP = Math.Round(mMNemonics.PresentValueUM * _ExchangeRate, 0);
            mMNemonics.DurationMacaulay = Math.Round(_Basis.TermBasis, 8);
            mMNemonics.DurationModificed = Math.Round(mMNemonics.DurationMacaulay / (1.0 + _Rate * 0.01), 2);
            mMNemonics.Convextion =  Math.Round(Math.Pow(mMNemonics.DurationMacaulay,2) / Math.Pow( ( 1.0 + ( _Rate * 0.01 ) * mMNemonics.DurationMacaulay ), 2 ), 2);

            #region "Expiry Flow"

            mMNemonics.CouponAmortization = 0;
            MNemonics.CouponInterest = 0;
            mMNemonics.CouponFlow = 0;
            mMNemonics.CouponFlowCLP = 0;
            mMNemonics.CourtDateCoupon = mMNemonics.ExpiryDate;

            if (mMNemonics.ExpiryDate.Equals(mValuatorDate))
            {
                mMNemonics.CouponAmortization = 0; // Falta Valor Compra
                MNemonics.CouponInterest = 0;
                mMNemonics.CouponFlow = MNemonics.Nominal;
                mMNemonics.CouponFlowCLP = Math.Round(mMNemonics.CouponFlow * _ExchangeRate, 0);
            }

            #endregion

        }
        
        private double TransNominalAmount(double transAmountNominal, double nominal)
        {
            return ((transAmountNominal / nominal) * 100.0);
        }

    }

}
