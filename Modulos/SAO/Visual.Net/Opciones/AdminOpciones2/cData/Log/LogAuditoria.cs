using System;
using System.Data;

namespace cData.Log
{
    public static class LogAuditoria
    {

        #region "Atributos Privados"
        private static enumStatus mStatus;
        private static enumSource mSource;
        private static String mError;
        private static String mStack;
        #endregion

        public static bool Save(DateTime FechaProceso, string terminal, string usuario, string codigomenu, string codigoevento, string detalletransaccion)
        {
            return Save(FechaProceso, terminal, usuario, codigomenu, codigoevento, detalletransaccion, "");
        }

        public static bool Save(DateTime FechaProceso, string terminal, string usuario, string codigomenu, string codigoevento, string detalletransaccion, string query)
        {
            string _Query = "";
            bool _Status = false;

            cConnectionDB.SqlConnectionDB _Connect = new cConnectionDB.SqlConnectionDB("OPCIONES");

            #region "Ejecuta Sp_CaEncContrato"

            _Query += "INSERT INTO dbo.Log_Auditoria ( Entidad, FechaProceso, FechaSistema, HoraProceso, Terminal, Usuario, Id_Sistema, CodigoMenu, Codigo_Evento, DetalleTransac )\n";
            _Query += string.Format(
                                     "       VALUES                 ( '1', '{0}', CONVERT(VARCHAR(10), GETDATE(), 112 ), LEFT( CONVERT(VARCHAR(10), GETDATE(), 114 ), 8), '{1}', '{2}', 'OPT', '{3}', '{4}', '{5}')\n",
                                     FechaProceso.ToString("yyyyMMdd"),     // 00
                                     terminal,                              // 01
                                     usuario,                               // 02
                                     codigomenu,                            // 03
                                     codigoevento,                          // 04
                                     detalletransaccion                     // 05
                                   );

            #endregion

            try
            {
                mStatus = enumStatus.Loading;
                _Connect.Execute(_Query);
                _Status = true;
            }
            catch (Exception _Error)
            {
                mStatus = enumStatus.ErrorLoad;
                mError = _Error.StackTrace;
                mStack = _Error.Message;
            }

            return _Status;
        }

    }
}
