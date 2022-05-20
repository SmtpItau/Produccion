using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
 
namespace cData.Opciones
{
    public static class Smiles
    {
        #region "Atributos Privados"

        private static enumStatus mStatus;
        private static enumSource mSource;
        private static String mError;
        private static String mStack;

        #endregion

        public static DataTable LoadSmiles(DateTime dateSmile, string parFor)
        {
            String _QueryRateFixing = "";

            #region "Query Fixing Rate" 

            _QueryRateFixing += "SELECT 'SmlFecha' = SMILE.SmlFecha \n";
            _QueryRateFixing += ", 'SmlParFor'  = SMILE.SmlParFor\n";
            _QueryRateFixing += ", 'SmlEstructura'  = SMILE.SmlEstructura \n";
            _QueryRateFixing += ", 'SmlDelta' = SMILE.SmlDelta\n";
            _QueryRateFixing += ", 'SmlDias' = SMILE.SmlDias\n";
            _QueryRateFixing += ", 'SmlBid'  = SMILE.SmlBid\n";
            _QueryRateFixing += ", 'SmlAsk'  = SMILE.SmlAsk\n";
            _QueryRateFixing += ", 'SmlMid'  = SMILE.SmlMid\n";
            _QueryRateFixing += "FROM SMILE\n";
            _QueryRateFixing += "WHERE SMILE.SmlFecha = '" + dateSmile.ToString("yyyyMMdd") + "' AND  SMILE.SmlParFor = '" + parFor + "' \n";
            _QueryRateFixing += "ORDER BY SmlDias, SmlDelta, SmlEstructura \n"; 
            // Order by completado por instruccion de Finanzas 23-03-2010
            // Pasado por contingencia 

            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");

            DataTable _Smiles;

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryRateFixing);
                _Smiles = _Connect.QueryDataTable();
                _Smiles.TableName = "Smiles";

                if (_Smiles.Rows.Count.Equals(0))
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
                _Smiles = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _Smiles;
        }

        public static DataTable LoadSmilesPricing(DateTime dateSmile, string parFor, int enumSetPricing)
        {
            String _QuerySmie = "";

            #region "Query Smile "

            _QuerySmie+="SELECT 'SmlFecha' = smiledate ";
            _QuerySmie+=", 'SmlParFor'  = currencypair ";
            _QuerySmie+=", 'SmlEstructura'  = structure ";
            _QuerySmie+=", 'SmlDelta' = delta ";
            _QuerySmie+=", 'SmlDias' = tenor ";
            _QuerySmie+=", 'SmlBid'  = valuebid ";
            _QuerySmie+=", 'SmlAsk'  = valueask ";
            _QuerySmie+=", 'SmlMid'  = valuemid ";
            _QuerySmie+="FROM tblSmileSetPricing ";
            _QuerySmie += "WHERE smiledate = '"+dateSmile.ToString("yyyyMMdd")+"' AND  currencypair = '" + parFor + "' AND setpricing = '" + enumSetPricing.ToString() + "' ";
            _QuerySmie += "ORDER BY tenor, delta , structure ";

            #endregion

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("Turing");

            DataTable _Smiles;

            try
            {
                // Definición de la Curva
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QuerySmie);
                _Smiles = _Connect.QueryDataTable();
                _Smiles.TableName = "Smiles";

                if (_Smiles.Rows.Count.Equals(0))
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
                _Smiles = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _Smiles;
        }
    }
}
