using System;
using System.ComponentModel;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Data;
using cFinancialTools.BussineDate;

namespace cFinancialTools.BussineDate
{

    public class Calendars
	{

        private ArrayList mDataCalendar;
        private Hashtable mCalendar;

        public Calendars()
        {
            mDataCalendar = new ArrayList();
            mCalendar = new Hashtable();
        }

        public DateTime PreviousHolidayDate(int town, DateTime Value)
		{
            BussineDate date = new BussineDate(Value);

			date.Value = date.PreviousDay;

			while (!IsBussineDay(town, date.Value))
            {			
				date.Value = date.Add(enumDateIntevale.Day, -1);
			}

			return date.Value;

		}

        public DateTime NextHolidayDate(int town, DateTime Value)
		{
            BussineDate date = new BussineDate(Value);

			date.Value = date.NextDay;

			while (!IsBussineDay(town, date.Value))
			{
				date.Value = date.Add(enumDateIntevale.Day, 1);
			}

			return date.Value;

		}

        public DateTime NextDate(int town, DateTime Value)
        {
            BussineDate date = new BussineDate(Value);

            date.Value = date.NextDay;

            return date.Value;

        }

        public bool IsBussineDay(int town, DateTime value)
		{

			BussineDate _Financialdate = new BussineDate(value);
            Hashtable _Calendar = new Hashtable();
			int _Dow;
            int[] _WeekendArray = { 1, 0, 0, 0, 0, 0, 1 };
			bool _Status;
            int _Holidays;


			_Status = true;

            _Dow = (int)_Financialdate.DayOfWeek;
            _Holidays = _WeekendArray[_Dow];

            if (_Holidays.Equals(1))
			{
				_Status = false;
			}
			else
			{

                _Status = Valid(town, value);
			}

            return _Status;

		}

        public DateTime BussineDate(int town, DateTime value, int Interval)
		{
            if (Interval.Equals(0))
            {
                return value;
            }
			else if (Interval > 0)
			{
				return NextHolidayDate(town, value);
			}
			else
			{
                return PreviousHolidayDate(town, value);
			}

		}

        public void Load()
		{

            mCalendar = new Hashtable();
            cData.Parameters.Calendars _CalendarLoad = new cData.Parameters.Calendars(enumSource.System);
            DataTable _DataCalendar = new DataTable();
            int _Row;
            DataRow _DataRow;
            int _Town;
            int _Year;
            Hashtable _CalendarTown = new Hashtable();
            Hashtable _CalendarMonth = new Hashtable();

            _DataCalendar = _CalendarLoad.Load(0);

            for (_Row = 0; _Row < _DataCalendar.Rows.Count; _Row++)
            {
                
                _DataRow = _DataCalendar.Rows[_Row];

                _Town = int.Parse(_DataRow["Town"].ToString());
                _Year = int.Parse(_DataRow["Year"].ToString());

                _CalendarTown = (Hashtable)mCalendar[_Town.ToString()];

                if (_CalendarTown == null)
                {
                    mCalendar.Add(_Town.ToString(), new Hashtable());
                    _CalendarTown = (Hashtable)mCalendar[_Town.ToString()];
                }

                _CalendarMonth = new Hashtable();
                _CalendarMonth.Add("January", _DataRow["January"].ToString());
                _CalendarMonth.Add("February", _DataRow["February"].ToString());
                _CalendarMonth.Add("March", _DataRow["March"].ToString());
                _CalendarMonth.Add("April", _DataRow["April"].ToString());
                _CalendarMonth.Add("May", _DataRow["May"].ToString());
                _CalendarMonth.Add("June", _DataRow["June"].ToString());
                _CalendarMonth.Add("July", _DataRow["July"].ToString());
                _CalendarMonth.Add("August", _DataRow["August"].ToString());
                _CalendarMonth.Add("September", _DataRow["September"].ToString());
                _CalendarMonth.Add("October", _DataRow["October"].ToString());
                _CalendarMonth.Add("November", _DataRow["November"].ToString());
                _CalendarMonth.Add("December", _DataRow["December"].ToString());

                _CalendarTown.Add(_Year.ToString(), _CalendarMonth);

            }

		}

        private long toDate(int year, int month, int day)
		{
			return (year * 10000 + month * 100 + day);
		}

        private bool Valid(int town, DateTime value)
        {

            bool _Status = true;

            int _Year = value.Year;
            int _Month = value.Month;
            int _Day = value.Day;
            string _SMonth;
            string[] _Dates;
            int _Item;
            string _Days;
            char[] _Separator = { ',' };

            Hashtable _CalendarTown = new Hashtable();
            Hashtable _CalendarYear = new Hashtable();
            string _CalendarMonth;

            _CalendarTown = (Hashtable)mCalendar[town.ToString()];

            if (_CalendarTown == null)
            {
                _Status = true;
            }
            else
            {
                _CalendarYear = (Hashtable)_CalendarTown[_Year.ToString()];

                if (_CalendarYear == null)
                {
                    _Status = true;
                }
                else
                {
                    _SMonth = SMonth(_Month);

                    _CalendarMonth = (string)_CalendarYear[_SMonth];
                    _CalendarMonth = _CalendarMonth.Trim();

                    if (_CalendarMonth.Equals(""))
                    {
                        _Status = true;
                    }
                    else
                    {

                        _Dates = _CalendarMonth.Split(_Separator);

                        for (_Item = 0; _Item < _Dates.Length; _Item++)
                        {
                            _Days = _Dates[_Item].ToString();

                            if (_Days.Trim().Length > 0)
                            {
                                if (_Day.Equals(int.Parse(_Days)))
                                {
                                    _Status = false;
                                    break;
                                }

                            }

                        }

                    }

                }

            }

            return (_Status);

        }

        private string SMonth(int month)
        {
            string _Value;

            switch (month)
            {
                case 1:
                    _Value = "January";
                    break;
                case 2:
                    _Value = "February";
                    break;
                case 3:
                    _Value = "March";
                    break;
                case 4:
                    _Value = "April";
                    break;
                case 5:
                    _Value = "May";
                    break;
                case 6:
                    _Value = "June";
                    break;
                case 7:
                    _Value = "July";
                    break;
                case 8:
                    _Value = "August";
                    break;
                case 9:
                    _Value = "September";
                    break;
                case 10:
                    _Value = "October";
                    break;
                case 11:
                    _Value = "November";
                    break;
                case 12:
                    _Value = "December";
                    break;
                default:
                    _Value = "";
                    break;
            }
            return (_Value);

        }

    }

}
