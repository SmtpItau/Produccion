using System;
using System.ComponentModel;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using cFinancialTools.BussineDate;

namespace cFinancialTools.Flow
{

    #region "Comentarios"
    //'% Argumentos Obligatorios
    //'% 1. fecha_transaccion
    //'% 2. tipo_intervalo
    //'% 3  numero_intervalos
    //'% 4. rezago_partida
    //'% 5. tipo_intervalo_vencimiento
    //'% 6. numero_intervalos_vencimiento
    //'% 7. calendario_generacion
    //'% 8. Convention
    //'
    //'% Argumentos Opcionales
    //'% 9. flag_fijo_flotante
    //'% 10. fecha_inicial
    //'% 11. fecha_vencimiento
    //'% 12. periodo_quebrado
    //'% 13. flag_backstarting
    //'% 14. calendario_pago
    //'% 15. calendario_fijacion
    //'% 16. referencia_pago
    //'% 17. referencia_fijacion
    //'% 18. regla_pago
    //'% 19. regla_fijacion
    #endregion

    #region "Class"

    public class CashFlow
    {

        #region "Variables Privadas"

        private int[] mWeekend = { 1, 0, 0, 0, 0, 0, 1 };
        private DateTime mTransactionsDate;
        private enumIntervalType mIntervalType;
        private int mIntervalNumber;
        private int mBackwardnessStart;
        private enumIntervalType mExpiryIntervalType;
        private int mExpiryIntervalNumber;
        private int mCreatingCalendarType;
        private Calendars mCreatingCalendar;
        private enumConvention mConvention;
        private enumFlagFixedFloating mFlagFixedFloating;
        private DateTime mStartingDate;
        private DateTime mExpiryDate;
        private enumBrokenPeriod mBrokenPeriod;
        private enumFlagBackStarting mFlagBackStarting;

        private int mPaymentCalendarType;
        private Calendars mPaymentCalendar;
        private enumPayment mPaymentReference;
        private int mPaymentRule;

        private int mFixingCalendarType;
        private cFinancialTools.BussineDate.Calendars mFixingCalendar;
        private enumPayment mFixingReference;
        private int mFixingRule;

        #endregion

        #region "Constructores"

        public CashFlow()
        {
            mTransactionsDate = new DateTime(1900, 1, 1);
            mStartingDate = new DateTime(1900, 1, 1);
            mExpiryDate = new DateTime(1900, 1, 1);
			mCreatingCalendar = new cFinancialTools.BussineDate.Calendars();
			mPaymentCalendar = new cFinancialTools.BussineDate.Calendars();
            mFixingCalendar = new cFinancialTools.BussineDate.Calendars();
        }

        #endregion

        #region "Property"

        public DateTime TransactionsDate
        {
            get
            {
                return mTransactionsDate;
            }
            set
            {
                mTransactionsDate = value;
            }
		}

        public enumIntervalType IntervalType
		{
            get
            {
                return mIntervalType;
            }
            set
            {
                mIntervalType = value;
            }
		}

		public int IntervalNumber
		{
            get
            {
                return mIntervalNumber;
            }
            set
            {
                mIntervalNumber = value;
            }
		}

		public int BackwardnessStart
		{
            get
            {
                return mBackwardnessStart;
            }
            set
            {
                mBackwardnessStart = value;
            }
		}

        public enumIntervalType ExpiryIntervalType
		{
            get
            {
                return mExpiryIntervalType;
            }
            set
            {
                mExpiryIntervalType = value;
            }
		}

        public int ExpiryIntervalNumber
		{
            get
            {
                return mExpiryIntervalNumber;
            }
            set
            {
                mExpiryIntervalNumber = value;
            }
		}

        public int CreatingCalendarType
        {
            get
            {
                return mCreatingCalendarType;
            }
            set
            {
                mCreatingCalendarType = value;
            }
        }

        public Calendars CreatingCalendar
        {
            get
            {
                return mCreatingCalendar;
            }
            set
            {
                mCreatingCalendar = value;
            }
        }

		public enumConvention Convention
		{
            get
            {
                return mConvention;
            }
            set
            {
                mConvention = value;
            }
		}

		public enumFlagFixedFloating FlagFixedFloating
		{
            get
            {
                return mFlagFixedFloating;
            }
            set
            {
                mFlagFixedFloating = value;
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

		public enumBrokenPeriod BrokenPeriod
		{
            get
            {
                return mBrokenPeriod;
            }
            set
            {
                mBrokenPeriod = value;
	        }
		}

		public enumFlagBackStarting FlagBackstarting
		{
            get
            {
                return mFlagBackStarting;
            }
            set
            {
                mFlagBackStarting = value;
            }
		}

        public int PaymentCalendarType
		{
            get
            {
                return mPaymentCalendarType;
            }
            set
            {
                mPaymentCalendarType = value;
            }
		}

        public Calendars PaymentCalendar
        {
            get
            {
                return mPaymentCalendar;
            }
            set
            {
                mPaymentCalendar = value;
            }
        }

		public enumPayment PaymentReference
		{
            get
            {
                return mPaymentReference;
            }
            set
            {
                mPaymentReference = value;
            }
		}

		public int PaymentRule
		{
            get
            {
                return mPaymentRule;
            }
            set
            {
                mPaymentRule = value;
            }
		}

        public int FixingCalendarType
		{
            get
            {
                return mFixingCalendarType;
            }
            set
            {
                mFixingCalendarType = value;
            }
		}

        public Calendars FixingCalendar
        {
            get
            {
                return mFixingCalendar;
            }
            set
            {
                mFixingCalendar = value;
            }
        }

		public enumPayment FixingReference
		{
            get
            {
                return mFixingReference;
            }
            set
            {
                mFixingReference = value;
            }
		}

		public int FixingRule
		{
            get
            {
                return mFixingRule;
            }
            set
            {
                mFixingRule = value;
            }
		}

        #endregion

        #region "Funciones Protegidas"

        protected double DateNum(DateTime datevalue)
        {

            BussineDate.BussineDate _date = new BussineDate.BussineDate(datevalue);

            return (double)_date.DayOfYears;

        }

        protected DateTime MovesDate(
                                      DateTime datevalue, 
                                      enumIntervalType intervaltypevalue,
                                      int intervalnumbervalue,
                                      enumConvention conventionvalue, 
                                      int town,
                                      cFinancialTools.BussineDate.Calendars calendarvalue
                                    )
        {

            cFinancialTools.BussineDate.BussineDate _date = new cFinancialTools.BussineDate.BussineDate(datevalue);

            _date.Value = datevalue;

            // Desplazamiento
            switch (intervaltypevalue)
            {
                case enumIntervalType.Day:
                    _date.Value = _date.Add(enumDateIntevale.Day, intervalnumbervalue);
                    break;

                case enumIntervalType.DayHoliday:
                    _date.Value = _date.Add(enumDateIntevale.Day, intervalnumbervalue);

                    while (calendarvalue.IsBussineDay(town, _date.Value))
                    {
                        _date.Value = _date.Add(enumDateIntevale.Day, intervalnumbervalue);
                    }
                    break;

                case enumIntervalType.Month:
                    _date.Value = _date.Add(enumDateIntevale.Month, intervalnumbervalue);
                    break;

                case enumIntervalType.Year:
                    _date.Value = _date.Add(enumDateIntevale.Year, intervalnumbervalue);
                    break;

                default:
                    _date.Value = _date.Value;
                    break;

            }

            // Aplicacion de la Convention
            switch(Convention)
            {
                case enumConvention.NotAdjustedMonthEnd:
                    _date.Value = _date.EnfOfMonth;
                    break;

                case enumConvention.PreviousMonthEnd:
                    _date.Value = _date.Add(enumDateIntevale.Day, -_date.Day);
                    break;

                case enumConvention.NextMonthEnd:
                    _date.Value = _date.EnfOfMonth;
                    _date.Value = _date.Add(enumDateIntevale.Month, 1);
                    break;

                default:
                    if (!calendarvalue.IsBussineDay(town, _date.Value))
                    {
                        switch (Convention)
                        {
                            case enumConvention.NotAdjusted:
                                _date.Value = _date.Value;
                                break;

                            case enumConvention.Previous:
                                _date.Value = _date.PreviousDay;
                                break;

                            case enumConvention.Next:
                                _date.Value = _date.NextDay;
                                break;

                            case enumConvention.PreviousModified:
                                if (_date.PreviousDay.Month != datevalue.Month)
                                {
                                    _date.Value = _date.NextDay;
                                }
                                else
                                {
                                    _date.Value = _date.PreviousDay;
                                }
                                break;

                            case enumConvention.NextModified:
                                if (_date.NextDay.Month != datevalue.Month)
                                {
                                    _date.Value = _date.PreviousDay;
                                }
                                else
                                {
                                    _date.Value = _date.NextDay;
                                }
                                break;

                            default:
                                break;
                        }

                    }
                    break;
            }

            return _date.Value;

        }
        
        protected void CheckStartingDate()
        {
            DateTime _date = new DateTime(1900, 1, 1);

            if (ExpiryDate.Equals(_date))
            {
                StartingDate = mCreatingCalendar.BussineDate(6, TransactionsDate, BackwardnessStart);
            }
        }

        protected void CheckExpiryDate()
        {
            DateTime _date = new DateTime(1900, 1, 1);

            // Determinacion de la fecha de vencimiento, la fecha de referencia es la fecha de inicial--------------------------
            if (ExpiryDate.Equals(_date))
            {
                ExpiryDate = MovesDate(TransactionsDate, mExpiryIntervalType, ExpiryIntervalNumber, Convention, mCreatingCalendarType, mCreatingCalendar);
            }
        }

        protected DateTime CalculatePaymentDate(DateTime startingdatevalue,DateTime expirydatevalue)
        {
            int _flagpaymentrule;
            int _paymentrule;
            DateTime _paymentdate;

            _paymentrule = PaymentRule;
            _paymentdate = startingdatevalue;

            if (_paymentrule < 0)
            {
                _flagpaymentrule = -1;
            }
            else
            {
                _flagpaymentrule = 1;
            }

            if (PaymentReference == enumPayment.StartDate)
            {
                _paymentdate = startingdatevalue;
                while (_paymentrule != 0)
                {
                    _paymentdate = mPaymentCalendar.BussineDate(6, _paymentdate, _flagpaymentrule);
                    _paymentrule -= _flagpaymentrule;
                }

            }
            else if (PaymentReference == enumPayment.FinishDate)
            {
                _paymentdate = expirydatevalue;
                while (_paymentrule != 0)
                {
                    _paymentdate = mPaymentCalendar.BussineDate(6, _paymentdate, _flagpaymentrule);
                    _paymentrule -= _flagpaymentrule;
                }

            }

            return _paymentdate;

        }

        protected DateTime CalculateDateFixingRate(DateTime startingdatevalue, DateTime expirydatevalue)
        {
            int _flagfixingrule;
            int _fixingrule;
            DateTime _fixingdate;

            _fixingrule = FixingRule;
            _fixingdate = startingdatevalue;

            if (_fixingrule < 0)
            {
                _flagfixingrule = -1;
            }
            else
            {
                _flagfixingrule = 1;
            }

            if (FixingReference == enumPayment.StartDate)
            {
                _fixingdate = startingdatevalue;
                while (_fixingrule != 0)
                {
                    _fixingdate = mFixingCalendar.BussineDate(6, _fixingdate, _flagfixingrule);
                    _fixingrule -= _flagfixingrule;
                }

            }
            else if (FixingReference == enumPayment.FinishDate)
            {
                _fixingdate = expirydatevalue;
                while (_fixingrule != 0)
                {
                    _fixingdate = mFixingCalendar.BussineDate(6, _fixingdate, _flagfixingrule);
                    _fixingrule -= _flagfixingrule;
                }

            }

            return _fixingdate;

        }

        #endregion

    }
    #endregion

}
