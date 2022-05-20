using System;
using System.ComponentModel;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Text;

namespace cFinancialTools.Rate
{

    public class RateValue
    {
        private DateTime mDate;
        private double mRate;

        public RateValue()
        {
            DateTime _date = new DateTime(1999, 1, 1);
            Set(_date, 0);
        }

        public RateValue(DateTime date, double value)
        {
            Set(date, value);
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

        protected void Set(DateTime date, double value)
        {
            mDate = date;
            mRate = value;
        }

    }

}
