using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using cFinancialTools.DayCounters;
using cFinancialTools.Yield;

namespace AdminOpcionesTool.Opciones.Functions
{
    public static class Function
    {
        public static double CND(double x)
        {
            double returnValue;

            double xabs, Exponential, Build;

            xabs = Math.Abs(x);

            if (xabs > 37)
            {
                returnValue = 0;
            }
            else
            {
                Exponential = Math.Exp(-Math.Pow(xabs, 2) / 2);
                if (xabs < 7.07106781186547)
                {
                    Build = 3.52624965998911E-02 * xabs + 0.700383064443688;
                    Build = Build * xabs + 6.37396220353165;
                    Build = Build * xabs + 33.912866078383;
                    Build = Build * xabs + 112.079291497871;
                    Build = Build * xabs + 221.213596169931;
                    Build = Build * xabs + 220.206867912376;
                    returnValue = Exponential * Build;
                    Build = 8.83883476483184E-02 * xabs + 1.75566716318264;
                    Build = Build * xabs + 16.064177579207;
                    Build = Build * xabs + 86.7807322029461;
                    Build = Build * xabs + 296.564248779674;
                    Build = Build * xabs + 637.333633378831;
                    Build = Build * xabs + 793.826512519948;
                    Build = Build * xabs + 440.413735824752;
                    returnValue = returnValue / Build;
                }
                else
                {
                    Build = xabs + 0.65;
                    Build = xabs + 4 / Build;
                    Build = xabs + 3 / Build;
                    Build = xabs + 2 / Build;
                    Build = xabs + 1 / Build;
                    returnValue = (Exponential / Build) / 2.506628274631;
                }
            }
            if (x > 0)
            {
                return (1 - returnValue);
            }
            else
            {
                return returnValue;
            }
        }

        /// <summary>
        /// Calcula precio forward
        /// </summary>
        /// <param name="FechaInicioPlazo"></param>
        /// <param name="FechaFinPlazo"></param>
        /// <param name="FechaSetdePrecios"></param>
        /// <param name="Spot"></param>
        /// <param name="CurvaDom"></param>
        /// <param name="CurvaFor"></param>
        /// <param name="CurvaList"></param>
        /// <returns></returns>
        public static double Forward(DateTime FechaInicioPlazo, DateTime FechaFinPlazo, DateTime FechaSetdePrecios,  double Spot, string CurvaDom, string CurvaFor, YieldList CurvaList)
        {

            YieldList mYieldList = CurvaList;          
            Basis _Basis360;
            Basis _Basis365;

            _Basis360 = new Basis(enumBasis.Basis_Act_360, FechaInicioPlazo, FechaFinPlazo);
            _Basis365 = new Basis(enumBasis.Basis_Act_365, FechaInicioPlazo, FechaFinPlazo);

            double wf_dom = Math.Pow((1 + 0.01 * mYieldList.Read(CurvaDom, enumSource.System, FechaSetdePrecios, (int)_Basis365.Term).Rate), _Basis360.TermBasis);

            double wf_for = Math.Pow((1 + 0.01 * mYieldList.Read(CurvaFor, enumSource.System, FechaSetdePrecios, (int)_Basis365.Term).Rate), _Basis360.TermBasis);

            double returnValue = Spot * (wf_dom / wf_for);
            return returnValue;
        }
 

    }
}
