using System;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using System.Windows.Data;
using System.Globalization;

namespace AdminOpciones.OpcionesFX.Converter
{
    public class ConverterDouble: IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            double _double = (double)value;
            return _double.ToString(parameter.ToString());
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            string strValue = value.ToString();
            double resultDouble;
            if (double.TryParse(strValue, out resultDouble))
            {
                return resultDouble;
            }
            return value;
        }       
    }

    public class DateTimeConverter : IValueConverter
    {
        public object Convert(object value,
                           Type targetType,
                           object parameter,
                           CultureInfo culture)
        {
            DateTime date = (DateTime)value;
            return date.ToString((string)parameter);
        }

        public object ConvertBack(object value,
                                  Type targetType,
                                  object parameter,
                                  CultureInfo culture)
        {
            string strValue = value.ToString();
            DateTime resultDateTime;
            if (DateTime.TryParse(strValue, out resultDateTime))
            {
                return resultDateTime;
            }
            return value;
        }
    }

    public class StringDateTimeConverter : IValueConverter
    {
        public object Convert(object value,
                           Type targetType,
                           object parameter,
                           CultureInfo culture)
        {
            DateTime dt;
            String date;
            try
            {
                dt = DateTime.Parse(value.ToString());
            }
            catch 
            {
                dt = new DateTime(1900, 1,1);
            }
            date = dt.ToString((string)parameter);
            return date;
        }

        public object ConvertBack(object value,
                                  Type targetType,
                                  object parameter,
                                  CultureInfo culture)
        {
            
            string strValue = value.ToString();
            return strValue;
        }
    }
}
