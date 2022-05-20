using System;
using System.Collections;
using System.Text;

namespace cFinancialTools.Instruments
{

    public class MNemonics
    {

        #region "Atributos privados"

        private int mMnemonicsID;
        private string mFamilyID;
        private string mMnemonicsMask;
        private string mMnemonics;
        private bool mFlagSerie;
        private long mIssuerID;
        private DateTime mStartingDate;
        private DateTime mExpiryDate;
        private DateTime mPurchaseDate;
        private double mPurchaseRate;
        private double mNominal;
        private double mIssueRate;
        private double mAnnualRateRealEffect;
        private int mIssueCurrency;
        private int mIssueBasis;
        private int mRateEstimatedID;
        private double mRateEstimated;
        private bool mFlotanting;
        private double mFlotatingRate;
        private int mCoupons;
        private int mAmortizationNumber;
        private int mExpiryCouponPeriod;
        private string mExpityCouponType;
        private int mExpiryCouponDay;
        private int mTerm;
        private int mDecimals;

        private double mCouponAmortization;
        private double mCouponInterest;
        private double mCouponFlow;
        private double mCouponFlowCLP;

        private Hashtable mList;

        private double mPresentValueUM;
        private double mPresentValueCLP;
        private double mDurationMacaulay;
        private double mDurationModificed;
        private double mConvextion;
        private enumBasis mValuatorBasis;
        private double mNetPresenteValue;
        private double mPriceValue;
        private double mParValue;
        private double mParValue2;
        private DateTime mCourtDateCoupon;
        private DateTime mDateICP;
        private DateTime mPublicationEntrySystem;

        #endregion

        #region "Constructores"

        public MNemonics()
        {
            Set(
                 0,
                 "",
                 "",
                 "",
                 false,
                 0,
                 new DateTime(1900, 1, 1),
                 new DateTime(1900, 1, 1),
                 new DateTime(1900, 1, 1),
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 0,
                 false,
                 0,
                 0,
                 0,
                 0,
                 "",
                 0,
                 0,
                 0
               );
        }

        public MNemonics(
                          int mnemonicsID,
                          string familyID,
                          string mnemonicsMask,
                          string mnemonics,
                          bool flagSerie,
                          long issuerID,
                          DateTime startingDate,
                          DateTime expiryDate,
                          DateTime purchaseDate,
                          double purchaseRate,
                          double nominal,
                          double issueRate,
                          double annualRateRealEffect,
                          int issueCurrency,
                          int issueBasis,
                          int rateEstimatedID,
                          double rateEstimated,
                          bool flotanting,
                          double flotatingRate,
                          int coupons,
                          int amortizationNumber,
                          int expiryCouponPeriod,
                          string expityCouponType,
                          int expiryCouponDay,
                          int term,
                          int decimals
                        )
        {
            Set(
                 mnemonicsID,
                 familyID,
                 mnemonicsMask,
                 mnemonics,
                 flagSerie,
                 issuerID,
                 startingDate,
                 expiryDate,
                 purchaseDate,
                 purchaseRate,
                 nominal,
                 issueRate,
                 annualRateRealEffect,
                 issueCurrency,
                 issueBasis,
                 rateEstimatedID,
                 rateEstimated,
                 flotanting,
                 flotatingRate,
                 coupons,
                 amortizationNumber,
                 expiryCouponPeriod,
                 expityCouponType,
                 expiryCouponDay,
                 term,
                 decimals
               );
        }

        #endregion

        #region "Atributos Publicos"

        public int MnemonicsID
        {
            get
            {
                return mMnemonicsID;
            }
            set
            {
                mMnemonicsID = value;
            }
        }

        public string FamilyID
        {
            get
            {
                return mFamilyID;
            }
            set
            {
                mFamilyID = value;
            }
        }

        public string MnemonicsMask
        {
            get
            {
                return mMnemonicsMask;
            }
            set
            {
                mMnemonicsMask = value;
            }
        }

        public string Mnemonics
        {
            get
            {
                return mMnemonics;
            }
            set
            {
                mMnemonics = value;
            }
        }

        public bool FlagSerie
        {
            get
            {
                return mFlagSerie;
            }
            set
            {
                mFlagSerie = value;
            }
        }

        public long IssuerID
        {
            get
            {
                return mIssuerID;
            }
            set
            {
                mIssuerID = value;
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

        public DateTime PurchaseDate
        {
            get
            {
                return mPurchaseDate;
            }
            set
            {
                mPurchaseDate = value;
            }
        }

        public double PurchaseRate
        {
            get
            {
                return mPurchaseRate;
            }
            set
            {
                mPurchaseRate = value;
            }
        }

        public double Nominal
        {
            get
            {
                return mNominal;
            }
            set
            {
                mNominal = value;
            }
        }

        public double IssueRate
        {
            get
            {
                return mIssueRate;
            }
            set
            {
                mIssueRate = value;
            }
        }

        public double AnnualRateRealEffect
        {
            get
            {
                return mAnnualRateRealEffect;
            }
            set
            {
                mAnnualRateRealEffect = value;
            }
        }

        public int IssueCurrency
        {
            get
            {
                return mIssueCurrency;
            }
            set
            {
                mIssueCurrency = value;
            }
        }

        public int IssueBasis
        {
            get
            {
                return mIssueBasis;
            }
            set
            {
                mIssueBasis = value;
            }
        }

        public int RateEstimatedID
        {
            get
            {
                return RateEstimatedID;
            }
            set
            {
                mRateEstimatedID = value;
            }
        }

        public double RateEstimated
        {
            get
            {
                return mRateEstimated;
            }
            set
            {
                mRateEstimated = value;
            }
        }

        public bool Flotanting
        {
            get
            {
                return mFlotanting;
            }
            set
            {
                mFlotanting = value;
            }
        }

        public double FlotatingRate
        {
            get
            {
                return mFlotatingRate;
            }
            set
            {
                mFlotatingRate = value;
            }
        }

        public int Coupons
        {
            get
            {
                return mCoupons;
            }
            set
            {
                mCoupons = value;
            }
        }

        public int AmortizationNumber
        {
            get
            {
                return mAmortizationNumber;
            }
            set
            {
                mAmortizationNumber = value;
            }
        }

        public int ExpiryCouponPeriod
        {
            get
            {
                return mExpiryCouponPeriod;
            }
            set
            {
                mExpiryCouponPeriod = value;
            }
        }

        public string ExpityCouponType
        {
            get
            {
                return mExpityCouponType;
            }
            set
            {
                mExpityCouponType = value;
            }
        }

        public int ExpiryCouponDay
        {
            get
            {
                return mExpiryCouponDay;
            }
            set
            {
                mExpiryCouponDay = value;
            }
        }

        public int Term
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

        public int Decimals
        {
            get
            {
                return mDecimals;
            }
            set
            {
                mDecimals = value;
            }
        }

        public double PresentValueUM
        {
            get
            {
                return mPresentValueUM;
            }
            set
            {
                mPresentValueUM = value;
            }
        }

        public double PresentValueCLP
        {
            get
            {
                return mPresentValueCLP;
            }
            set
            {
                mPresentValueCLP = value;
            }
        }

        public double DurationMacaulay
        {
            get
            {
                return mDurationMacaulay;
            }
            set
            {
                mDurationMacaulay = value;
            }
        }

        public double DurationModificed
        {
            get
            {
                return mDurationModificed;
            }
            set
            {
                mDurationModificed = value;
            }
        }

        public double Convextion
        {
            get
            {
                return mConvextion;
            }
            set
            {
                mConvextion = value;
            }
        }

        public enumBasis ValuatorBasis
        {
            get
            {
                return mValuatorBasis;
            }
        }

        public double NetPresenteValue
        {
            get
            {
                return mNetPresenteValue;
            }
            set
            {
                mNetPresenteValue = value;
            }
        }

        public double PriceValue
        {
            get
            {
                return mPriceValue;
            }
            set
            {
                mPriceValue = value;
            }
        }

        public double ParValue
        {
            get
            {
                return mParValue;
            }
            set
            {
                mParValue = value;
            }
        }

        public double ParValue2
        {
            get
            {
                return mParValue2;
            }
            set
            {
                mParValue2 = value;
            }
        }

        public double CouponAmortization
        {
            get
            {
                return mCouponAmortization;
            }
            set
            {
                mCouponAmortization = value;
            }
        }

        public double CouponInterest
        {
            get
            {
                return mCouponInterest;
            }
            set
            {
                mCouponInterest = value;
            }
        }

        public double CouponFlow
        {
            get
            {
                return mCouponFlow;
            }
            set
            {
                mCouponFlow = value;
            }
        }

        public double CouponFlowCLP
        {
            get
            {
                return mCouponFlowCLP;
            }
            set
            {
                mCouponFlowCLP = value;
            }
        }

        public DateTime CourtDateCoupon
        {
            get
            {
                return mCourtDateCoupon;
            }
            set
            {
                mCourtDateCoupon = value;
            }
        }

        public DateTime DateICP
        {
            get
            {
                return mDateICP;
            }
            set
            {
                mDateICP = value;
            }
        }

        public DateTime PublicationEntrySystem
        { 
            get
            {
                return mPublicationEntrySystem;
            }
            set
            {
                mPublicationEntrySystem = value;
            }
        }

        #endregion

        #region "Manejo de Cupones"

        public bool Add(enumSource sourceID)
        {
            bool _Status = true;
            String _SourceID = sourceID.ToString();

            if (Find(sourceID))
            {
                _Status = false;
            }
            else
            {
                MnemonicsSource _ItemList = new MnemonicsSource(sourceID);
                mList.Add(_SourceID, _ItemList);
            }

            return _Status;

        }

        public bool Find(enumSource sourceID)
        {

            MnemonicsSource _Source = new MnemonicsSource();
            String _SourceID = sourceID.ToString();
            bool _Status = true;

            _Source = (MnemonicsSource)mList[_SourceID];

            if (_Source == null)
            {
                _Status = false;
            }

            return _Status;
        }

        public MnemonicsSource Read(enumSource sourceID)
        {

            String _SourceID = sourceID.ToString();
            MnemonicsSource _Source = new MnemonicsSource();

            if (Find(sourceID))
            {
                _Source = (MnemonicsSource)mList[_SourceID];
            }

            return _Source;
        }

        public Hashtable ReadAll()
        {
            return mList;
        }

        public bool Item(enumSource sourceID, MnemonicsSource _Item)
        {

            bool _Status = true;
            String _SourceID = sourceID.ToString();

            if (Find(sourceID))
            {
                mList[_SourceID] = _Item;
            }
            else
            {
                _Status = false;
            }

            return _Status;

        }

        public bool Remove(enumSource sourceID)
        {
            bool _Status = true;
            String _SourceID = sourceID.ToString();

            if (Find(sourceID))
            {
                mList.Remove(sourceID);
            }
            else
            {
                _Status = false;
            }

            return _Status;
        }

        #endregion

        #region "Metodos Privados"

        private void Set(
                          int mnemonicsID,
                          string familyID,
                          string mnemonicsMask,
                          string mnemonics,
                          bool flagSerie,
                          long issuerID,
                          DateTime startingDate,
                          DateTime expiryDate,
                          DateTime purchaseDate,
                          double purchaseRate,
                          double nominal,
                          double issueRate,
                          double annualRateRealEffect,
                          int issueCurrency,
                          int issueBasis,
                          int rateEstimatedID,
                          double rateEstimated,
                          bool flotanting,
                          double flotatingRate,
                          int coupons,
                          int amortizationNumber,
                          int expiryCouponPeriod,
                          string expityCouponType,
                          int expiryCouponDay,
                          int term,
                          int decimals
                        )
        {
            mMnemonicsID = mnemonicsID;
            mFamilyID = familyID;
            mMnemonicsMask = mnemonicsMask;
            mMnemonics = mnemonics;
            mFlagSerie = flagSerie;
            mIssuerID = issuerID;
            mStartingDate = startingDate;
            mExpiryDate = expiryDate;
            mPurchaseDate = purchaseDate;
            mPurchaseRate = purchaseRate;
            mNominal = nominal;
            mIssueRate = issueRate;
            mAnnualRateRealEffect = annualRateRealEffect;
            mIssueCurrency = issueCurrency;
            mIssueBasis = issueBasis;
            mRateEstimatedID = rateEstimatedID;
            mRateEstimated = rateEstimated;
            mFlotanting = flotanting;
            mFlotatingRate = flotatingRate;
            mCoupons = coupons;
            mAmortizationNumber = amortizationNumber;
            mExpiryCouponPeriod = expiryCouponPeriod;
            mExpityCouponType = expityCouponType;
            mExpiryCouponDay = expiryCouponDay;
            mTerm = term;
            mDecimals = decimals;
            mPresentValueUM = 0;
            mPresentValueCLP = 0;
            mDurationMacaulay = 0;
            mDurationModificed = 0;
            mConvextion = 0;
            mNetPresenteValue = 0;
            mPriceValue = 0;
            mParValue = 0;
            mParValue2 = 0;

            mCouponAmortization = 0;
            mCouponInterest = 0;
            mCouponFlow = 0;
            mCouponFlowCLP = 0;
            mDateICP = DateTime.Now;

            switch (mIssueBasis)
            {
                case 30:
                    mValuatorBasis = enumBasis.Basis_Act_30;
                    break;
                case 360:
                    mValuatorBasis = enumBasis.Basis_Act_360;
                    break;
                case 365:
                    mValuatorBasis = enumBasis.Basis_Act_365;
                    break;
                default:
                    mValuatorBasis = enumBasis.Basis_Act_365;
                    break;
            }

            mCourtDateCoupon = new DateTime(1900, 1, 1);
            mList = new Hashtable();
        }

        #endregion

    }

}
