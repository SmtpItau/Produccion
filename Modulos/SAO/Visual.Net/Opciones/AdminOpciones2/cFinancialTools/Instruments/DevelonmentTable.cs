using System;
using System.Collections.Generic;
using System.Text;

namespace cFinancialTools.Instruments
{

    public class DevelonmentTable
    {

        private int mCoupon;
        private DateTime mExpiryDate;
        private double mInterest;
        private double mAmortization;
        private double mFlow;
        private double mBalance;
        private double mRate;
        private double mParValue;
        private double mNetValueCurrent;
        private double mDurationMacaulay;
        private double mDurationModificed;
        private double mConvex;

        public DevelonmentTable()
        {
            Set(0, new DateTime(1900, 1, 1), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
        }

        public DevelonmentTable(
                                 int coupon,
                                 DateTime expiryDate,
                                 double interest,
                                 double amortization,
                                 double flow,
                                 double balance,
                                 double rate,
                                 double parValue,
                                 double netValueCurrent,
                                 double durationMacaulay,
                                 double durationModificed,
                                 double convex
                               )
        {
            Set(coupon, expiryDate, interest, amortization, flow, balance, rate, parValue, netValueCurrent, durationMacaulay, durationModificed, convex);
        }

        public int Coupon
        {
            get
            {
                return mCoupon;
            }
            set
            {
                mCoupon = value;
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

        public double Balance
        {
            get
            {
                return mBalance;
            }
            set
            {
                mBalance = value;
            }
        }

        public double Rate
        {
            get
            {
                return mRate;
            }
            set
            {
                mRate = value;
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

        public double NetValueCurrent
        {
            get
            {
                return mNetValueCurrent;
            }
            set
            {
                mNetValueCurrent = value;
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

        public double Convex
        {
            get
            {
                return mConvex;
            }
            set
            {
                mConvex = value;
            }
        }

        private void Set(
                          int coupon,
                          DateTime expiryDate,
                          double interest,
                          double amortization,
                          double flow,
                          double balance,
                          double rate,
                          double parValue,
                          double netValueCurrent,
                          double durationMacaulay,
                          double durationModificed,
                          double convex
                        )
        {
            mCoupon = coupon;
            mExpiryDate = expiryDate;
            mInterest = interest;
            mAmortization = amortization;
            mFlow = flow;
            mBalance = balance;
            mRate = rate;
            mParValue = parValue;
            mNetValueCurrent = netValueCurrent;
            mDurationMacaulay = durationMacaulay;
            mDurationModificed = durationModificed;
            mConvex = convex;
        }

    }

}
