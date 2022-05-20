using System;

namespace cFinancialTools.Struct
{

    public class StructFlow
    {

#region "Variables"

        private long mNumberFlow;
        private DateTime mStartingDate;
        private DateTime mExpiryDate;
        private DateTime mPaymentDate;
        private DateTime mFixingDate;

#endregion

#region "Constructores"

        public StructFlow(long numberflow, DateTime startingdate, DateTime expirydate, DateTime paymentdate, DateTime fixingdate)
        {
            SetValue(numberflow, startingdate, expirydate, paymentdate, fixingdate);
        }

        public StructFlow(DateTime startingdate, DateTime expirydate, DateTime paymentdate, DateTime fixingdate)
        {
            SetValue(0, startingdate, expirydate, paymentdate, fixingdate);
        }

        public StructFlow()
        {
            DateTime _date = new DateTime(1900, 1, 1);

            SetValue(0, _date, _date, _date, _date);
        }
#endregion

#region "Propiedades"

        public long NumberFlow
        {
            get { return mNumberFlow; }
            set { mNumberFlow = value; }
        }

        public DateTime StartingDate
        {
            get { return mStartingDate; }
            set { mStartingDate = value; }
        }

        public DateTime ExpiryDate
        {
            get { return mExpiryDate; }
            set { mExpiryDate = value; }
        }

        public DateTime PaymentDate
        {
            get { return mPaymentDate; }
            set { mPaymentDate = value; }
        }

        public DateTime FixingDate
        {
            get { return mFixingDate; }
            set { mFixingDate = value; }
        }

#endregion

#region "Private"

        private void SetValue(long numberflow, DateTime startingdate, DateTime expirydate, DateTime paymentdate, DateTime fixingdate)
        {
            mNumberFlow = numberflow;
            mStartingDate = startingdate;
            mExpiryDate = expirydate;
            mPaymentDate = paymentdate;
            mFixingDate = fixingdate;

        }

#endregion

    }

}