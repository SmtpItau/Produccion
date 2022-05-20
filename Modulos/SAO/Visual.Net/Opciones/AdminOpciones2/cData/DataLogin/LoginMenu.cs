using System;
using System.Data;

namespace cData.DataLogin
{
    public static class LoginMenu 
    {
        #region  "Atributos Privados"
        private static enumStatus mStatus;
        private static enumSource mSource;
        private static String mError;
        private static String mStack;
        #endregion

        public static DataTable LoginUser(String User) 
        {
            String _QueryLogin = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("BACPARAMSUDA");
            DataTable _LoginData;

            #region "Query OpcionesMenu"

            _QueryLogin = string.Format(cData.Properties.Resources.LoginSQL, User);

            #endregion

            try
            {                
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryLogin);
                _LoginData = _Connect.QueryDataTable();
                _LoginData.TableName = "OpcionesMenu";

                if (_LoginData.Rows.Count.Equals(0))
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
                _LoginData = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _LoginData;
        }

        public static DataTable ValidaPass(String User)
        {
            String _QueryLogin = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _ValidaPass;

            #region "Query ValidaPass"
            _QueryLogin += "Sp_Rescata_Datos_Usuario " + "'" + User + "'";            
            #endregion

            try
            {                
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryLogin);
                _ValidaPass = _Connect.QueryDataTable();
                _ValidaPass.TableName = "ValidaPass";

                if (_ValidaPass.Rows.Count.Equals(0))
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
                _ValidaPass = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _ValidaPass;
        }

        public static DataTable BloqueoUSuario(string user)
        {
            string _QueryBloqueoUsuario = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _ValidaPass;

            #region Query Bloqueo Usuario

            _QueryBloqueoUsuario += string.Format("UPDATE lnkbac.bacparamsuda.dbo.Usuario SET bloqueado = '1' WHERE usuario = '{0}'\n", user);
            _QueryBloqueoUsuario += "SELECT 'Status' = 'OK'\n";

            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryBloqueoUsuario);
                _ValidaPass = _Connect.QueryDataTable();
                _ValidaPass.TableName = "BloqueoUsuario";

                if (_ValidaPass.Rows.Count.Equals(0))
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
                _ValidaPass = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _ValidaPass;
        }



        public static DataTable CambioClave(string Usuario, string ClaveAnterior, string NuevaClave, string ConfirmaClave, DateTime FechaExpira, DateTime FechaProceso)
        {
            string _QueryCambioCLave = "";

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");
            DataTable _CambioClave;

            #region Query Bloqueo Usuario

            _QueryCambioCLave += string.Format("Sp_Graba_Cambio_Clave '{0}','{1}','{2}','{3}','{4}','{5}'\n", Usuario, ClaveAnterior, NuevaClave, ConfirmaClave, FechaExpira.ToString("yyyyMMdd"), FechaProceso.ToString("yyyyMMdd"));
            //_QueryCambioCLave += "SELECT 'Status' = 'OK'\n";

            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_QueryCambioCLave);
                _CambioClave = _Connect.QueryDataTable();
                _CambioClave.TableName = "CambioClave";

                if (_CambioClave.Rows.Count.Equals(0))
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
                _CambioClave = null;
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _CambioClave;
        }

    }
}