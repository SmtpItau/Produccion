using System;
using System.Text;
using System.Data;
using System.Xml.Linq;
using System.Linq;

namespace AdminOpcionesTool.ValorizadorCartera
{
    public class MatrizRecStruct
    {

        #region Atributos Privados

        private int __CurrencyPrimary;
        private int __CurrencySecondary;
        private int __Tenor;
        private double __Factor;

        #endregion

        #region Atributos Publicos

        public int CurrencyPrimary
        {
            get
            {
                return __CurrencyPrimary;
            }
        }

        public int CurrencySecundary
        {
            get
            {
                return __CurrencySecondary;
            }
        }

        public int Tenor
        {
            get
            {
                return __Tenor;
            }
        }

        public double Factor
        {
            get
            {
                return __Factor;
            }
        }

        public decimal dFactor
        {
            get
            {
                return (decimal)__Factor;
            }
        }
        #endregion

        #region Constructor

        public MatrizRecStruct()
        {
            Set();
        }

        public MatrizRecStruct(int currencyprimary, int currencysecundary, int tenor, double factor)
        {
            Set(currencyprimary, currencysecundary, tenor, factor);
        }

        public MatrizRecStruct(MatrizRecStruct value)
        {
            Set(value);
        }

        public MatrizRecStruct(DataRow value)
        {
            Set(value);
        }

        public MatrizRecStruct(XElement value)
        {
            Set(value);
        }

        public MatrizRecStruct(string value)
        {
            Set(value);
        }

        #endregion

        #region Metodos Privados

        private void __Set(int currencyprimary, int currencysecundary, int tenor, double factor)
        {
            __CurrencyPrimary = currencyprimary;
            __CurrencySecondary = currencysecundary;
            __Tenor = tenor;
            __Factor = factor;
        }

        #endregion

        #region Metodos Publicos

        public void Set()
        {
            __Set(0, 0, 0, 0);
        }

        public void Set(int currencyprimary, int currencysecundary, int tenor, double factor)
        {
            __Set(currencyprimary, currencysecundary, tenor, factor);
        }

        public void Set(MatrizRecStruct value)
        {
            __Set(value.CurrencyPrimary, value.CurrencySecundary, value.Tenor, value.Factor);
        }

        public void Set(DataRow value)
        {
            __Set(
                   int.Parse(value["Moneda1"].ToString()),
                   int.Parse(value["Moneda2"].ToString()),
                   int.Parse(value["Plazo"].ToString()),
                   double.Parse(value["Factor"].ToString())
                 );
        }

        public void Set(XElement value)
        {
            __Set(
                   int.Parse(value.Attribute("Moneda1").Value),
                   int.Parse(value.Attribute("Moneda2").Value),
                   int.Parse(value.Attribute("Plazo").Value),
                   double.Parse(value.Attribute("Factor").Value)
                 );
        }

        public void Set(string value)
        {
            string[] _Value = value.Split(',');

            __Set(
                   int.Parse(_Value[0]),
                   int.Parse(_Value[1]),
                   int.Parse(_Value[2]),
                   double.Parse(_Value[3])
                 );
        }

        #endregion

    }
}
