using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace AdminOpcionesTool.ValorizadorCartera
{
    public class FASensitivity
    {

        private int __Day;
        private double __DV01Pos;
        private double __DV01Neg;
        private double __Delta;
        private double __Gamma;

        public int Day
        {
            get
            {
                return __Day;
            }
        }

        public double DV01Pos
        {
            get
            {
                return __DV01Pos;
            }
        }

        public double DV01Neg
        {
            get
            {
                return __DV01Neg;
            }
        }

        public double Delta
        {
            get
            {
                return __Delta;
            }
        }

        public double Gamma
        {
            get
            {
                return __Gamma;
            }
        }

        public FASensitivity()
        {
            Set();
        }

        public FASensitivity(int day)
        {
            Set(day);
        }

        public FASensitivity(int day, double delta, double gamma)
        {
            Set(day, delta, gamma);
        }

        public FASensitivity(FASensitivity value)
        {
            Set(value);
        }

        private void __Set(int day, double delta, double gamma)
        {
            __Day = day;
            __DV01Pos = 0.5 * (2 * Math.Pow(10, -4) * delta + Math.Pow(10, -8) * gamma);
            __DV01Neg = 0.5 * (-2 * Math.Pow(10, -4) * delta + Math.Pow(10, -8) * gamma);
            __Delta = delta;
            __Gamma = gamma;
        }

        public void Set()
        {
            __Set(0, 0, 0);
        }

        public void Set(int day)
        {
            __Set(day, 0, 0);
        }

        public void Set(int day, double delta, double gamma)
        {
            __Set(day, delta, gamma);
        }

        public void Set(FASensitivity value)
        {
            __Set(value.Day, value.Delta, value.Gamma);
        }

        public void Clear()
        {
            __DV01Pos = 0;
            __DV01Neg = 0;
        }

        public void Add(double dv01pos, double dv01neg)
        {
            __DV01Pos += dv01pos;
            __DV01Neg += dv01neg;
        }

        public override string ToString()
        {
            return string.Format(
                                  "{0}, {1}, {2}, {3}, {4}\n",
                                  __Day,
                                  __DV01Pos,
                                  __DV01Neg,
                                  __Delta,
                                  __Gamma
                                );
        }

        public string ToXML()
        {
            return string.Format("<Value {0} />\n", ToElement());
        }

        public string ToXML(double notional)
        {
            return string.Format("<Value {0} />\n", ToElement(notional));
        }

        public string ToElement()
        {
            return string.Format(
                                  "Day='{0}' DV01Pos='{1}' DV01Neg='{2}' Delta='{3}' Gamma='{4}'\n",
                                  __Day,
                                  __DV01Pos,
                                  __DV01Neg,
                                  __Delta,
                                  __Gamma
                                );
        }

        public string ToElement(double notional)
        {
            return string.Format(
                                  "Day='{0}' DV01Pos='{1}' DV01Neg='{2}' Delta='{3}' Gamma='{4}'",
                                  __Day,
                                  __DV01Pos * notional,
                                  __DV01Neg * notional,
                                  __Delta,
                                  __Gamma
                                );

        }

    }
}
