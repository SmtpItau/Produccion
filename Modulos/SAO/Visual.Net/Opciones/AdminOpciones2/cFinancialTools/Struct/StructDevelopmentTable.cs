using System;
using System.Collections.Generic;
using System.Text;

namespace cFinancialTools.Struct
{

    public class StructDevelopmentTable
    {

        #region "Variables"

        private long mNumberFlow;
        private DateTime mStartingDate;
        private DateTime mExpiryDate;
        private DateTime mPaymentDate;
        private DateTime mFixingDate;
        private double mTerm;
        private double mTermBasis;
        private double mFactor;

        private double mAmortization;
        private double mAmortizationEnd;
        private double mAmortizationEndConvertion;
        private double mAmortizationFlow;

        private double mInterest;
        private double mInterestProposed;
        private double mInterestEnd;
        private double mInterestEndConvertion;
        private double mInterestFlow;

        private double mFlow;
        private double mFlowEnd;
        private double mFlowEndConvertion;
        private double mFlowPresent;

        private double mBalanceResidual;
        private double mExchangeNotional;
        private double mFixedRateEnd;                             // Tasa fija final
        private double mFixedRateEndYesterday;                    // Tasa fija final de ayer
        private double mTransferFixedRate;                        // Tasa fija transferencia
        private double mSpreadFlotanteEnd;                        // Spread Flotante Final
        private double mTransferSpreadFlotante;                   // Spread flotante transferencia

        private double mRateProject;
        private double mRateProjectTransfer;
        private double mRateDiscount;

        private double mInterestTransfer;
        private double mInterestTransferProposed;
        private double mInterestTransferEndConvertion;
        private double mInterestTransferFlow;
        private double mInterestTransferEnd;

        private enumExchangeNotional mExchangeNotionalType;       // Intercambio de Nocional
        private enumExchangeNotional mExchangeInterestType;       // Intercambios de Intereses

        private double mAditionalsFlowValue;                      // Flujos adicionales
        private double mAditionalsFlowConvertion;                 // Flujos adicionales
        private double mAditionalsFlow;                           // Flujos adicionales
        private DateTime mAditionalsFlowDate;                     // Fechas flujos adicionales

        private double mFactorDiscount;

        private double mRateStarting;
        private double mFactorRateStarting;
        private double mRateExpiry;
        private double mFactorRateExpiry;
        private double mRateFra;
        private double mFactorRateFra;

        #endregion

        #region "Constructores"

        public StructDevelopmentTable(
                                       long numberflow,
                                       DateTime startingdate,
                                       DateTime expirydate,
                                       DateTime paymentdate,
                                       DateTime fixingdate,
                                       double term,
                                       double termbasis,
                                       double factor,
                                       double amortization,
                                       double interest,
                                       double flow,
                                       double balanceresidual,
                                       double exchangenotional,
                                       double fixedrateend,
                                       double transferfixedrate,
                                       double finalspreadglotante,
                                       double transferspreadflotante,
                                       double aditionalsflowvalue,
                                       enumExchangeNotional exchangeNotionalType,
                                       enumExchangeNotional exchangeInterestType,
                                       DateTime aditionalsflowdate
                                    )
        {
            Set(
                 numberflow,
                 startingdate,
                 expirydate,
                 paymentdate,
                 fixingdate,
                 term,
                 termbasis,
                 factor,
                 amortization,
                 interest,
                 flow,
                 balanceresidual,
                 exchangenotional,
                 fixedrateend,
                 transferfixedrate,
                 finalspreadglotante,
                 transferspreadflotante,
                 exchangeNotionalType,
                 exchangeInterestType,
                 aditionalsflowvalue,
                 aditionalsflowdate
               );

        }

        public StructDevelopmentTable(
                                       long numberflow,
                                       DateTime startingdate,
                                       DateTime expirydate,
                                       DateTime paymentdate,
                                       DateTime fixingdate,
                                       double fixedrateend,
                                       double transferfixedrate,
                                       double finalspreadglotante,
                                       double transferspreadflotante,
                                       double aditionalsflowvalue,
                                       DateTime aditionalsflowdate
                                     )
        {
            Set(
                 numberflow,
                 startingdate,
                 expirydate,
                 paymentdate,
                 fixingdate,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 fixedrateend,
                 transferfixedrate,
                 finalspreadglotante,
                 transferspreadflotante,
                 enumExchangeNotional.Yes,
                 enumExchangeNotional.Yes,
                 aditionalsflowvalue,
                 aditionalsflowdate
               );
        }
        
        public StructDevelopmentTable(
                                       long numberflow,
                                       DateTime startingdate,
                                       DateTime expirydate,
                                       DateTime paymentdate,
                                       DateTime fixingdate
                                     )
        {
            DateTime _date = new DateTime(1900, 1, 1);

            Set(
                 numberflow,
                 startingdate,
                 expirydate,
                 paymentdate,
                 fixingdate,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 enumExchangeNotional.Yes,
                 enumExchangeNotional.Yes,
                 0,
                 _date
               );
        }

        public StructDevelopmentTable(
                                       DateTime startingdate,
                                       DateTime expirydate,
                                       DateTime paymentdate,
                                       DateTime fixingdate
                                     )
        {
            DateTime _date = new DateTime(1900, 1, 1);

            Set(
                 0,
                 startingdate,
                 expirydate,
                 paymentdate,
                 fixingdate,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 enumExchangeNotional.Yes,
                 enumExchangeNotional.Yes,
                 0,
                 _date
               );
        }

        public StructDevelopmentTable()
        {
            DateTime _date = new DateTime(1900, 1, 1);

            Set(
                 0,
                 _date,
                 _date,
                 _date,
                 _date,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 enumExchangeNotional.Yes,
                 enumExchangeNotional.Yes,
                 0,
                 _date
               );
        }

        #endregion

        #region "Propiedades"

        public long NumberFlow
        {
            get
            {
                return mNumberFlow;
            }
            set
            {
                mNumberFlow = value;
            }
        }

        public DateTime StartingDate
        {
            get
            {
                return mStartingDate;
            }
            set
            {
                mStartingDate = value;
            }
        }

        public DateTime ExpiryDate
        {
            get
            {
                return mExpiryDate;
            }
            set
            {
                mExpiryDate = value;
            }
        }

        public DateTime PaymentDate
        {
            get
            {
                return mPaymentDate;
            }
            set
            {
                mPaymentDate = value;
            }
        }

        public DateTime FixingDate
        {
            get
            {
                return mFixingDate;
            }
            set
            {
                mFixingDate = value;
            }
        }

        public double Term
        {
            get
            {
                return mTerm;
            }
            set
            {
                mTerm = value;
            }
        }

        public double TermBasis
        {
            get
            {
                return mTermBasis;
            }
            set
            {
                mTermBasis = value;
            }
        }

        public double Factor
        {
            get
            {
                return mFactor;
            }
            set
            {
                mFactor = value;
            }
        }

        public double Amortization
        {
            get
            {
                return mAmortization;
            }
            set
            {
                mAmortization = value;
            }
        }

        public double AmortizationEnd
        {
            get
            {
                return mAmortizationEnd;
            }
            set
            {
                mAmortizationEnd = value;
            }
        }

        public double AmortizationEndConvertion
        {
            get
            {
                return mAmortizationEndConvertion;
            }
            set
            {
                mAmortizationEndConvertion = value;
            }
        }

        public double AmortizationFlow
        {
            get
            {
                return mAmortizationFlow;
            }
            set
            {
                mAmortizationFlow = value;
            }
        }

        public double Interest
        {
            get
            {
                return mInterest;
            }
            set
            {
                mInterest = value;
            }
        }

        public double InterestProposed
        {
            get
            {
                return mInterestProposed;
            }
            set
            {
                mInterestProposed = value;
            }
        }

        public double InterestEnd
        {
            get
            {
                return mInterestEnd;
            }
            set
            {
                mInterestEnd = value;
            }
        }

        public double InterestEndConvertion
        {
            get
            {
                return mInterestEndConvertion;
            }
            set
            {
                mInterestEndConvertion = value;
            }
        }

        public double InterestFlow
        {
            get
            {
                return mInterestFlow;
            }
            set
            {
                mInterestFlow = value;
            }
        }

        public double Flow
        {
            get
            {
                return mFlow;
            }
            set
            {
                mFlow = value;
            }
        }

        public double FlowEnd
        {
            get
            {
                return mFlowEnd;
            }
            set
            {
                mFlowEnd = value;
            }
        }

        public double FlowEndConvertion
        {
            get
            {
                return mFlowEndConvertion;
            }
            set
            {
                mFlowEndConvertion = value;
            }
        }

        public double FlowPresent
        {
            get
            {
                return mFlowPresent;
            }
            set
            {
                mFlowPresent = value;
            }
        }

        public double BalanceResidual
        {
            get
            {
                return mBalanceResidual;
            }
            set
            {
                mBalanceResidual = value;
            }
        }

        public double ExchangeNotional
        {
            get
            {
                return mExchangeNotional;
            }
            set
            {
                mExchangeNotional = value;
            }
        }

        public double FixedRateEnd
        {
            get
            {
                return mFixedRateEnd;
            }
            set
            {
                mFixedRateEnd = value;
            }
        }

        public double FixedRateEndYesterday
        {
            get
            {
                return mFixedRateEndYesterday;
            }
            set
            {
                mFixedRateEndYesterday = value;
            }
        }

        public double TransferFixedRate
        {
            get
            {
                return mTransferFixedRate;
            }
            set
            {
                mTransferFixedRate = value;
            }
        }

        public double SpreadFlotanteEnd
        {
            get
            {
                return mSpreadFlotanteEnd;
            }
            set
            {
                mSpreadFlotanteEnd = value;
            }
        }

        public double TransferSpreadFlotante
        {
            get
            {
                return mTransferSpreadFlotante;
            }
            set
            {
                mTransferSpreadFlotante = value;
            }
        }

        public double InterestTransfer
        {
            get
            {
                return mInterestTransfer;
            }
            set
            {
                mInterestTransfer = value;
            }
        }

        public double InterestTransferProposed
        {
            get
            {
                return mInterestTransferProposed;
            }
            set
            {
                mInterestTransferProposed = value;
            }
        }

        public double InterestTransferEnd
        {
            get
            {
                return mInterestTransferEnd;
            }
            set
            {
                mInterestTransferEnd = value;
            }
        }

        public double InterestTransferEndConvertion
        {
            get
            {
                return mInterestTransferEndConvertion;
            }
            set
            {
                mInterestTransferEndConvertion = value;
            }
        }

        public double InterestTransferFlow
        {
            get
            {
                return mInterestTransferFlow;
            }
            set
            {
                mInterestTransferFlow = value;
            }
        }

        public double RateProject
        {
            get
            {
                return mRateProject;
            }
            set
            {
                mRateProject = value;
            }
        }

        public double RateProjectTransfer
        {
            get
            {
                return mRateProjectTransfer;
            }
            set
            {
                mRateProjectTransfer = value;
            }
        }

        public double RateDiscount
        {

            get
            {
                return mRateDiscount;
            }
            set
            {
                mRateDiscount = value;
            }

        }

        public double FactorDiscount
        {

            get
            {
                return mFactorDiscount;
            }
            set
            {
                mFactorDiscount = value;
            }

        }

        // Intercambio de Nocional
        public enumExchangeNotional ExchangeNotionalType
        {
            get
            {
                return mExchangeNotionalType;
            }
            set
            {
                mExchangeNotionalType = value;
            }
        }

        // Intercambios de Intereses
        public enumExchangeNotional ExchangeInterestType
        {
            get
            {
                return mExchangeInterestType;
            }
            set
            {
                mExchangeInterestType = value;
            }
        }

        public double AditionalsFlowValue
        {
            get
            {
                return mAditionalsFlowValue;
            }
            set
            {
                mAditionalsFlowValue = value;
            }
        }

        public double AditionalsFlow
        {
            get
            {
                return mAditionalsFlow;
            }
            set
            {
                mAditionalsFlow = value;
            }
        }

        public double AditionalsFlowConvertion
        {
            get
            {
                return mAditionalsFlowConvertion;
            }
            set
            {
                mAditionalsFlowConvertion = value;
            }
        }

        public DateTime AditionalsFlowDate
        {
            get
            {
                return mAditionalsFlowDate;
            }
            set
            {
                mAditionalsFlowDate = value;
            }
        }

        public double RateStarting
        {

            get
            {
                return mRateStarting;
            }
            set
            {
                mRateStarting = value;
            }

        }

        public double FactorRateStarting
        {

            get
            {
                return mFactorRateStarting;
            }
            set
            {
                mFactorRateStarting = value;
            }

        }

        public double RateExpiry
        {

            get
            {
                return mRateExpiry;
            }
            set
            {
                mRateExpiry = value;
            }

        }

        public double FactorRateExpiry
        {

            get
            {
                return mFactorRateExpiry;
            }
            set
            {
                mFactorRateExpiry = value;
            }

        }

        public double RateFra
        {

            get
            {
                return mRateFra;
            }
            set
            {
                mRateFra = value;
            }

        }

        public double FactorRateFra
        {

            get
            {
                return mFactorRateFra;
            }
            set
            {
                mFactorRateFra = value;
            }

        }

        public double PresentValueFlow
        {

            get
            {
                return mInterestEnd + mAditionalsFlow + mAmortizationEnd;
            }

        }

        #endregion

        #region "Funciones protegidas"

        protected void Set(
                            long numberflow,
                            DateTime startingdate,
                            DateTime expirydate,
                            DateTime paymentdate,
                            DateTime fixingdate,
                            double term,
                            double termbasis,
                            double factor,
                            double amortization,
                            double interest,
                            double flow,
                            double balanceresidual,
                            double exchangenotional,
                            double fixedrateend,
                            double transferfixedrate,
                            double finalspreadglotante,
                            double transferspreadflotante,
                            enumExchangeNotional exchangeNotionalType,
                            enumExchangeNotional exchangeInterestType,
                            double aditionalsflowvalue,
                            DateTime aditionalsflowdate
                          )
        {

            this.NumberFlow = numberflow;
            this.StartingDate = startingdate;
            this.ExpiryDate = expirydate;
            this.PaymentDate = paymentdate;
            this.FixingDate = fixingdate;
            mTerm = term;
            mTermBasis = termbasis;
            mFactor = factor;

            mAmortization = amortization;
            mAmortizationEnd = 0;
            mAmortizationEndConvertion = 0;
            mAmortizationFlow = 0;

            mInterest = interest;
            mInterestProposed = 0;
            mInterestEnd = 0;
            mInterestEndConvertion = 0;
            mInterestFlow = 0;

            mFlow = flow;
            mFlowEnd = 0;
            mFlowEndConvertion = 0;
            mFlowPresent = 0;

            mBalanceResidual = balanceresidual;
            mExchangeNotional = exchangenotional;
            mFixedRateEnd = fixedrateend;                           // tasa fija final
            mTransferFixedRate = transferfixedrate;                 // tasa fija transferencia
            mSpreadFlotanteEnd = finalspreadglotante;               // Spread Flotante Final
            mTransferSpreadFlotante = transferspreadflotante;       // spread flotante transferencia

            mInterestTransfer = 0;
            mInterestTransferProposed = 0;
            mInterestTransferEnd = 0;
            mInterestTransferEndConvertion = 0;
            mInterestTransferFlow = 0;

            mExchangeNotionalType = exchangeNotionalType;           // intercambio de Nocional
            mExchangeInterestType = exchangeInterestType;           // intercambios de Intereses

            mAditionalsFlowValue = aditionalsflowvalue;             // flujos adicionales
            mAditionalsFlow = 0;                                    // flujos adicionales
            mAditionalsFlowDate = aditionalsflowdate;               // fechas flujos adicionales

        }

        #endregion

    }

}