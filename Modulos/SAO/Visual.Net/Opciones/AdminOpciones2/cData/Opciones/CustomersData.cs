using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace cData.Opciones
{
    public static class CustomersData
    {
        #region "Atributos Privados"

        private static enumStatus mStatus;
        private static enumSource mSource;
        private static String mError;
        private static String mStack;

        #endregion

        public static DataTable GetCustomersData()
        {
            DataTable _DataCustomers = new DataTable();
            String _QueryReturn = "";

            #region "Query Customers"

            _QueryReturn += "select Clrut, Cldv, Clcodigo, Clnombre from cliente where ClVigente = 'S' order by clrut";

            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryReturn);
                _DataCustomers = _Connect.QueryDataTable();
                _DataCustomers.TableName = "Customers";

                if (_DataCustomers.Rows.Count.Equals(0))
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
                _DataCustomers = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _DataCustomers;            
        }

        public static DataTable GetCustomersDataCondicionesGenerales()
        {
            DataTable _DataCustomers = new DataTable();
            String _QueryReturn = "";

            #region "Query Customers"

            _QueryReturn += @"SET NOCOUNT ON

                            SELECT DISTINCT Clrut,
                                   Cldv, 
                                   Clcodigo, 
                                   Clnombre
                            FROM Cliente 
                            WHERE 
                             clFechaFirma_cond <> '19000101'  and clCondicionesGenerales = 'S' 
                             and ClVigente = 'S'      -- 5896 Contrapartes vigentes
                            ORDER BY clrut

                            
                            SET NOCOUNT OFF";
            // Comentario para probar etiqueta

            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryReturn);
                _DataCustomers = _Connect.QueryDataTable();
                _DataCustomers.TableName = "Customers";

                if (_DataCustomers.Rows.Count.Equals(0))
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
                _DataCustomers = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _DataCustomers;


        }
    }
}
