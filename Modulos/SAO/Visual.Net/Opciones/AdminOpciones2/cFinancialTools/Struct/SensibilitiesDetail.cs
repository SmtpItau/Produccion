using System;
using System.Collections.Generic;
using System.Text;

namespace cFinancialTools.Struct
{

    public class SensibilitiesDetail
    {

        private int mPoint;
        private int mTerm;
        private double mSensibilitiesValue;
        private double mDeltaSensibilitiesValue;
        private double mEstimationValue;
        private double mRatePrimary;
        private double mRateSecondary;

        public SensibilitiesDetail()
        {
            Set(0, 0, 0, 0, 0);
        }

        public SensibilitiesDetail(int point, int term, double sensibilitiesValue, double deltaSensibilitiesValue, double estimationValue)
        {
            Set(point, term, sensibilitiesValue, deltaSensibilitiesValue, estimationValue);
        }

        public int Point
        {
            get
            {
                return mPoint;
            }
            set
            {
                mPoint = value;
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

        public double SensibilitiesValue
        {
            get
            {
                return mSensibilitiesValue;
            }
            set
            {
                mSensibilitiesValue = value;
            }
        }

        public double DeltaSensibilitiesValue
        {
            get
            {
                return mDeltaSensibilitiesValue;
            }
            set
            {
                mDeltaSensibilitiesValue = value;
            }
        }

        public double EstimationValue
        {
            get
            {
                return mEstimationValue;
            }
            set
            {
                mEstimationValue = value;
            }
        }

        public double RatePrimary
        {
            get
            {
                return mRatePrimary;
            }
            set
            {
                mRatePrimary = value;
            }
        }

        public double RateSecondary
        {
            get
            {
                return mRateSecondary;
            }
            set
            {
                mRateSecondary = value;
            }
        }

        private void Set(int point, int term, double sensibilitiesValue, double deltaSensibilitiesValue, double estimationValue)
        {
            mPoint = point;
            mTerm = term;
            mSensibilitiesValue = sensibilitiesValue;
            mDeltaSensibilitiesValue = deltaSensibilitiesValue;
            mEstimationValue = estimationValue;
            mRatePrimary = 0;
            mRateSecondary = 0;
        }

    }

}
