using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Linq;

namespace AdminOpcionesTool.ValorizadorCartera
{
    public class Sensitivity
    {

        #region Atributos Privados

        private int __Tenor;
        private double __MTM;
        private double __MTMSensitivity;
        private double __Delta;

        #endregion

        #region Atributos Publicos

        public int Tenor
        {
            get
            {
                return __Tenor;
            }
        }

        public double MTM
        {
            get
            {
                return __MTM;
            }
        }

        public double MTMSensitivity
        {
            get
            {
                return __MTMSensitivity;
            }
        }

        public double Delta
        {
            get
            {
                return __Delta;
            }
        }

        #endregion

        #region Constructor

        public Sensitivity()
        {
            Set();
        }

        public Sensitivity(int tenor, double mtm, double mtmsensitivity, double delta)
        {
            Set(tenor, mtm, mtmsensitivity, delta);
        }

        public Sensitivity(Sensitivity value)
        {
            Set(value);
        }

        public Sensitivity(string value)
        {
            Set(value);
        }

        public Sensitivity(XElement value)
        {
            Set(value);
        }

        #endregion

        #region Metodos Privados

        private void __Set(int tenor, double mtm, double mtmsensitivity, double delta)
        {
            __Tenor = tenor;
            __MTM = mtm;
            __MTMSensitivity = mtmsensitivity;
            __Delta = delta;
        }

        #endregion

        #region Metodos Publicos

        public void Set()
        {
            __Set(0, 0, 0, 0);
        }

        public void Set(int tenor, double mtm, double mtmsensitivity, double delta)
        {
            __Set(tenor, mtm, mtmsensitivity, delta);
        }

        public void Set(Sensitivity value)
        {
            __Set(value.Tenor, value.MTM, value.MTMSensitivity, value.Delta);
        }

        public void Set(string value)
        {
            string[] _Value = value.Split(',');
            try
            {
                __Set(int.Parse(_Value[0]), double.Parse(_Value[1]), double.Parse(_Value[2]), double.Parse(_Value[3]));
            }
            catch
            {
                Set();
            }
        }

        public void Set(XElement value)
        {
            try
            {
                __Set(
                       int.Parse(value.Attribute("Tenor").Value),
                       double.Parse(value.Attribute("MTM").Value),
                       double.Parse(value.Attribute("MTMSensitivity").Value),
                       double.Parse(value.Attribute("Sensitivity").Value)
                     );
            }
            catch
            {
                Set();
            }
        }

        public void Add(double mtm, double delta)
        {
            __MTM += mtm;
            __MTMSensitivity += mtm + delta;
            __Delta += delta;
        }

        public override string ToString()
        {
            return string.Format("{0}, {1}, {2}, {3}\n", __Tenor, __MTM, __MTMSensitivity, __Delta);
        }

        public string ToXML()
        {
            return string.Format("<Value {0} />", ToElement());
        }

        public string ToElement()
        {
            return string.Format("Tenor='{0}' MTM='{1}' MTMSensitivity='{2}' Sensitivity='{3}'", __Tenor, __MTM, __MTMSensitivity, __Delta);
        }

        #endregion

    }
}
