using System;
using System.Collections.Generic;
using System.Text;

namespace cFinancialTools.BussineDate
{

    #region "Class"

    public class BussineDate
    {

        #region "Variable privadas"

		protected DateTime mDate;
        const long BasisDays = 693595;

        #endregion

        #region "Constructores"

        public BussineDate(System.DateTime value)
        {
            Value = value;
        }

        public BussineDate(int year, int month, int day)
        {
            Value = new DateTime(year, month, day);
        }

        #endregion

        #region "Property"

        public DateTime Value
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

        public int Day
		{
            get
            {
                return mDate.Day;
            }
		}

        public int Month
		{
            get
            {
			    return mDate.Month;
            }
		}

        public int Year
		{
            get
            {
                return mDate.Year;
            }
		}

        public int DayOfYear
		{
            get
            {
                return mDate.DayOfYear;
            }
		}

        public double DayOfYears
		{

            get
            {
                double year0 = Year - 1;
                double year4 = System.Math.Floor(year0 / 4);
                double year100 = System.Math.Floor(year0 / 100);
                double year400 = System.Math.Floor(year0 / 400);
                double daymonth = 0;
                int imonth;
                double LeapYear; // Año bisiesto

                for (imonth = 1; imonth < Month; imonth++)
                {
                    switch (imonth)
                    {
                        case 1:
                        case 3:
                        case 5:
                        case 7:
                        case 8:
                        case 10:
                        case 12:
                            daymonth += 31;
                            break;
                        case 2:
                            LeapYear = Year / 4.0;
                            if (Math.Floor(LeapYear) == LeapYear)
                            {
                                daymonth += 29;
                            }
                            else
                            {
                                daymonth += 28;
                            }
                            break;
                        default:
                            daymonth += 30;
                            break;
                    };
                }

                double idays = (year0 * 365 + year4 - year100 + year400 + Day + daymonth) - BasisDays;
                return idays;
            }
		}

        public DayOfWeek DayOfWeek
		{
            get
            {
                return mDate.DayOfWeek;
            }
		}

        public DateTime NextDay
		{
            get
            {
			    return Add(enumDateIntevale.Day, 1);
            }
		}

        public DateTime PreviousDay
		{
            get
            {
			    return Add(enumDateIntevale.Day, -1);
            }
		}

        public DateTime EnfOfMonth
		{
            get
            {
			    DateTime date;

			    date = Add(enumDateIntevale.Month, 1);
                date = date.AddDays(date.Day * -1);

			    return date;
            }
		}

        public DateTime PreviousEndOfMonth
		{
            get
            {
                return Add(enumDateIntevale.Day, Day * -1);
            }
        }

        #endregion

        #region "Funciones Publicas"

        public DateTime Add(enumDateIntevale _DateIntervalo, int _Number)
		{
			DateTime date;

            date = mDate;

			switch(_DateIntervalo)
			{
			case enumDateIntevale.Day:
                date = mDate.AddDays(_Number);
				break;

			case enumDateIntevale.Weekend:
                date = mDate.AddDays(_Number * 7);
				break;

			case enumDateIntevale.Month:
                date = mDate.AddMonths(_Number);
				break;

			case enumDateIntevale.Semesters:
                date = mDate.AddMonths(_Number * 6);
				break;

			case enumDateIntevale.TwoMonth:
                date = mDate.AddMonths(_Number * 2);
				break;

			case enumDateIntevale.ThreeMonths:
                date = mDate.AddMonths(_Number * 3);
				break;

			case enumDateIntevale.FourMonths:
                date = mDate.AddMonths(_Number * 4);
				break;

			case enumDateIntevale.Year:
                date = mDate.AddYears(_Number);
				break;

			}

			return date;
		}

        public DateTime MovesDate(
                                   enumIntervalType intervaltypevalue,
                                   int intervalnumbervalue,
                                   enumConvention conventionvalue,
                                   int town,
                                   cFinancialTools.BussineDate.Calendars calendarvalue
                                 )
        {

            cFinancialTools.BussineDate.BussineDate _date = new cFinancialTools.BussineDate.BussineDate(mDate);

            _date.Value = mDate;

            // Desplazamiento
            switch (intervaltypevalue)
            {
                case enumIntervalType.Day:
                    _date.Value = _date.Add(enumDateIntevale.Day, intervalnumbervalue);
                    break;

                case enumIntervalType.DayHoliday:
                    _date.Value = _date.Add(enumDateIntevale.Day, intervalnumbervalue);

                    while (!calendarvalue.IsBussineDay(town, _date.Value))
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
            switch (conventionvalue)
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
                        switch (conventionvalue)
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
                                if (_date.PreviousDay.Month != mDate.Month)
                                {
                                    _date.Value = _date.NextDay;
                                }
                                else
                                {
                                    _date.Value = _date.PreviousDay;
                                }
                                break;

                            case enumConvention.NextModified:
                                if (_date.NextDay.Month != mDate.Month)
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

        #endregion

    };

    #endregion

}
