using System;
using System.Collections.Generic;
using System.Text;

namespace cFinancialTools.DayCounters
{

    public class Basis
    {

        private enumBasis mConventionBasis;
        private DateTime mInitalDate;
        private DateTime mExpiryDate;
        private Double mTerm;
        private Double mTermBasis;

        public Basis()
        {
            SetValue(enumBasis.Basis_Act_Act, new DateTime(1900, 1, 1), new DateTime(1900, 1, 1));
        }

        public Basis(
                      enumBasis conventionbasis,
                      DateTime initialdate,
                      DateTime expirydate
                    )
        {
            SetValue(conventionbasis, initialdate, expirydate);
            ConventionDaysBasis();
        }

        private void SetValue(
                               enumBasis conventionbasis,
                               DateTime initialdate,
                               DateTime expirydate
                             )
        {
            mConventionBasis = conventionbasis;
            mInitalDate = initialdate;
            mExpiryDate = expirydate;
            mTerm = 0;
            mTermBasis = 0;
        }

        public enumBasis ConventionBasis
        {
            get
            {
                return mConventionBasis;
            }
            set
            {
                mConventionBasis = value;
            }
        }

        public DateTime InitialDate
        {
            get
            {
                return mInitalDate;
            }
            set
            {
                mInitalDate = value;
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

        public double Term
        {
            get
            {
                return mTerm;
            }
        }

        public double TermBasis
        {
            get
            {
                return mTermBasis;
            }
        }

        public void ConventionDaysBasis()
        {
            BussineDate.BussineDate _date = new BussineDate.BussineDate(mInitalDate);

            if (mTerm.Equals(0))
            {
                ConventionDays();
            }

            mTermBasis = 0;

            switch (mConventionBasis)
            {
                case enumBasis.Basis_Act_360:
                    mTermBasis = mTerm / 360;
                    break;

                case enumBasis.Basis_30E_360:
                    mTermBasis = mTerm / 360;
                    break;

                case enumBasis.Basis_Act_365:
                    mTermBasis = mTerm / 365;
                    break;

                case enumBasis.Basis_30E_365:
                    mTermBasis = mTerm / 365;
                    break;

                case enumBasis.Basis_Act_Act:
                    _date.Value = _date.Add(enumDateIntevale.Month, 12);
                    mTermBasis = mTerm / Basis_Act_Act(_date.Value);
                    break;

                case enumBasis.Basis_Act_30:
                    mTermBasis = mTerm / 30;
                    break;

                case enumBasis.Basis_30_30:
                    mTermBasis = mTerm / 30;
                    break;

                default:
                    mTermBasis = 0;
                    break;
            }

        }

        private void ConventionDays()
        {
            BussineDate.BussineDate _date = new BussineDate.BussineDate(mInitalDate);

            mTerm = 0;

            switch (mConventionBasis)
            {
                case enumBasis.Basis_Act_360:
                case enumBasis.Basis_Act_365:
                case enumBasis.Basis_Act_30:
                    mTerm = Basis_Act_Act(mExpiryDate);
                    break;

                case enumBasis.Basis_30E_360:
                case enumBasis.Basis_30E_365:
                case enumBasis.Basis_30_30:
                    mTerm = Basis_30E_360();
                    break;

                case enumBasis.Basis_Act_Act:
                    mTerm = Basis_Act_Act(mExpiryDate);
                    break;

                default:
                    mTerm = 0;
                    break;
            }

        }

        private double DateNum(DateTime date)
        {

            BussineDate.BussineDate _date = new BussineDate.BussineDate(date);
            return (double)_date.DayOfYears;
        }

        private double Basis_Act_Act(DateTime expirydate)
        {
            double Days;

            //Days = DateNum(expirydate) - DateNum(mInitalDate);
            Days = ((TimeSpan)(expirydate - mInitalDate)).TotalDays;
            return Days;
        }

        private double Basis_30E_360()
        {

            return (
                     (360 * (mExpiryDate.Year - mInitalDate.Year)) +
                     (30 * (mExpiryDate.Month - mInitalDate.Month)) +
                     (mExpiryDate.Day - mInitalDate.Day)
                   );
        }

    }

}
