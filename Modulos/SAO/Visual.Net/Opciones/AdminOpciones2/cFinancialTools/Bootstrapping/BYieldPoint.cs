using System;
using System.Collections.Generic;
using System.Text;

namespace cFinancialTools.Bootstrapping
{
    public class BYieldPoint
    {
        protected DateTime mDate;
        protected double mRate;
        protected enumBootstrappingType mBootstrappingType;

        public BYieldPoint()
        {
            Set(new DateTime(1900, 1, 1), 0, enumBootstrappingType.MoneyMarket);
        }

        public BYieldPoint(DateTime date, Double rate, enumBootstrappingType bootstrappingType)
        {
            Set(date, rate, bootstrappingType);
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

        public enumBootstrappingType BootstrappingType
        {
            get
            {
                return mBootstrappingType;
            }
            set
            {
                mBootstrappingType = value;
            }
        }

        protected void Set(DateTime date, Double rate, enumBootstrappingType bootstrappingType)
        {
            mDate = date;
            mRate = rate;
            mBootstrappingType = bootstrappingType;
        }

    }
}
