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
using AdminOpciones.Recursos;

namespace AdminOpciones.Controls
{
    public static class LogAuditoria
    {
        public static void SaveLogAuditoria(string codigomenu, string codigoevento, string detalletransaccion)
        {
            SaveLogAuditoria(codigomenu, globales._Usuario, codigoevento, detalletransaccion);
        }

        public static void SaveLogAuditoria(string codigomenu, string user, string codigoevento, string detalletransaccion)
        {
            AdminOpciones.SrvAcciones.WebAccionesSoapClient _SvcAcciones = wsGlobales.Acciones;
            _SvcAcciones.SaveLogAuditoriaCompleted += new EventHandler<AdminOpciones.SrvAcciones.SaveLogAuditoriaCompletedEventArgs>(_SvcAcciones_SaveLogAuditoriaCompleted);
            _SvcAcciones.SaveLogAuditoriaAsync(globales.FechaProceso, globales._Terminal, user, codigomenu, codigoevento, detalletransaccion);
        }

        private static void _SvcAcciones_SaveLogAuditoriaCompleted(object sender, AdminOpciones.SrvAcciones.SaveLogAuditoriaCompletedEventArgs e)
        {
            if (e.Error == null)
            {
            }
        }
    }
}
