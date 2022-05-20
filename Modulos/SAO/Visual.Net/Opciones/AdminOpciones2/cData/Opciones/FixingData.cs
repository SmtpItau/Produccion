using System;
using System.Collections.Generic;
using System.Text;
using System.Data;


namespace cData.Opciones
{
    public static class FixingData
    {
        #region "Atributos Privados"

        private static enumStatus mStatus;
        private static enumSource mSource;
        private static String mError;
        private static String mStack;

        #endregion

        private static List<DateTime> FechasFijacionList;
        private static List<double> PesosFijacion;
        private static List<double> FijacionesList;

        public static List<DateTime> getFechaFijacion()
        {
            FechasFijacionList = new List<DateTime>();

            DateTime date1 = new DateTime(2009,1,29);
            DateTime date2 = new DateTime(2009,3,2);
            DateTime date3 = new DateTime(2009,4,1);
            DateTime date4 = new DateTime(2009,5,1);
            DateTime date5 = new DateTime(2009,6,1);
            DateTime date6 = new DateTime(2009,7,1);
            DateTime date7 = new DateTime(2009,7,31);
            DateTime date8 = new DateTime(2009,8,31);
            DateTime date9 = new DateTime(2009,9,26);

     

            FechasFijacionList.Add(date1);
            FechasFijacionList.Add(date2);
            FechasFijacionList.Add(date3);
            FechasFijacionList.Add(date4);
            FechasFijacionList.Add(date5);
            FechasFijacionList.Add(date6);
            FechasFijacionList.Add(date7);
            FechasFijacionList.Add(date8);
            FechasFijacionList.Add(date9);

            return FechasFijacionList;
 
        }

        public static List<double> getPesosFijacion()
        {
            PesosFijacion = new List<double>();

            double peso1 = 0.11111111111111100000;
            double peso2 = 0.11851851851851900000;
            double peso3 = 0.11111111111111100000;
            double peso4 = 0.11111111111111100000;
            double peso5 = 0.11481481481481500000;
            double peso6 = 0.11111111111111100000;
            double peso7 = 0.11111111111111100000;
            double peso8 = 0.11481481481481500000;
            double peso9 = 0.09629629629629630000;

            PesosFijacion.Add(peso1);
            PesosFijacion.Add(peso2);
            PesosFijacion.Add(peso3);
            PesosFijacion.Add(peso4);
            PesosFijacion.Add(peso5);
            PesosFijacion.Add(peso6);
            PesosFijacion.Add(peso7);
            PesosFijacion.Add(peso8);
            PesosFijacion.Add(peso9);

            return PesosFijacion;
        }

        public static List<double> getFijaciones()
        {
            PesosFijacion = new List<double>();

            double fijacion1 =633.70127473752600;
            double fijacion2 =636.64047139654500;
            double fijacion3 =639.30758717021800;
            double fijacion4 =641.38183122314100;
            double fijacion5 =643.39156618259700;
            double fijacion6 =645.56995885419800;
            double fijacion7 =647.14733198311600;
            double fijacion8 =648.45578033807400;
            double fijacion9 = 649.12418188605500;

            PesosFijacion.Add(fijacion1);
            PesosFijacion.Add(fijacion2);
            PesosFijacion.Add(fijacion3);
            PesosFijacion.Add(fijacion4);
            PesosFijacion.Add(fijacion5);
            PesosFijacion.Add(fijacion6);
            PesosFijacion.Add(fijacion7);
            PesosFijacion.Add(fijacion8);
            PesosFijacion.Add(fijacion9);


            return PesosFijacion;
        }

        public static DataTable getFijaciones(DateTime fechaInicio, DateTime fechaFin, string moneda)
        {
            
            DataTable _DataFijaciones = new DataTable();

            

            String _QueryReturn = "";

            #region "Query Fijaciones"



            _QueryReturn += " SELECT VALOR_MONEDA_CONTABLE.Fecha, VALOR_MONEDA_CONTABLE.Tipo_Cambio, VALOR_MONEDA_CONTABLE.Nemo_Moneda, VALOR_MONEDA_CONTABLE.Codigo_Moneda, VALOR_MONEDA.vmvalor\n"
                         + " FROM bacparamsuda.dbo.VALOR_MONEDA VALOR_MONEDA, bacparamsuda.dbo.VALOR_MONEDA_CONTABLE VALOR_MONEDA_CONTABLE\n"
                         + "WHERE VALOR_MONEDA_CONTABLE.Fecha = VALOR_MONEDA.vmfecha AND VALOR_MONEDA.vmcodigo = VALOR_MONEDA_CONTABLE.Codigo_Moneda AND VALOR_MONEDA_CONTABLE.Fecha > '" + fechaInicio.ToString("yyyyMMdd") + "' AND VALOR_MONEDA_CONTABLE.Fecha <= '" + fechaFin.ToString("yyyyMMdd") + "' AND VALOR_MONEDA_CONTABLE.Nemo_Moneda ='" + moneda + "' "
                         + " Order By VALOR_MONEDA_CONTABLE.Fecha ";
            
            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryReturn);
                _DataFijaciones = _Connect.QueryDataTable();
                _DataFijaciones.TableName = "Fijaciones";

                if (_DataFijaciones.Rows.Count.Equals(0))
                {
                    mStatus = enumStatus.NotFound;
                }
                else
                {
                    mStatus = enumStatus.Already;
                }

            }
            catch (Exception _Error)
            {
                _DataFijaciones = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _DataFijaciones;

        }

        

    }
}
