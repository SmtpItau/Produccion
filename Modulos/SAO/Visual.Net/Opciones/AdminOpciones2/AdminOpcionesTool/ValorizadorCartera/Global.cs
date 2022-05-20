using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
using System.Web;

namespace AdminOpcionesTool.ValorizadorCartera
{
    public static class Global
    {
        //ASVG_20130503 Nota: la Jacques.dll tiene internamente una referencia al tag de "LIBRARY"
        //lo que impide eliminarlo o alterar su estructura.
        //el parche aplicado consiste en sobre-escribir el valor en el arreglo de configuración.
        //por lo tanto el valor real no viene del Web.config sino que se define dinámicamente.
        //revisar SrvConfig.asmx, método GetApplicationSetting
        private static string ___ServiceConnect = ConfigurationManager.AppSettings["LIBRARY"];  // el using ?? 
        private static string __LogPath = ConfigurationManager.AppSettings["LOG"];  // el using ?? 

        private static string __Observable = "OBSERVABLE-0";
        private static string __YieldDomestic = "";
        private static string __YieldForeign = "";

        //public static void Set(string a)
        //{
        //    ___ServiceConnect = a;
        //    //___ServiceConnect = a + "Files\\";
        //    //___ServiceConnect = ___ServiceConnect.Replace("\\","\\\\");
        //    bool igual = false;
        //    //igual = __Alan.Equals(___ServiceConnect);
        //    //igual = __Alan.Equals(___ServiceConnect, StringComparison.CurrentCulture);
        //    //igual = __Alan.Equals(___ServiceConnect, StringComparison.InvariantCulture);
        //    //igual = __Alan.Equals(___ServiceConnect, StringComparison.Ordinal);

        //    return;
        //}

        public static string LogPath
        {
            get
            {
                return __LogPath;
            }
        }

        public static string ServiceConnect
        {
            get
            {
                return ___ServiceConnect;
            }
        }

        public static string Observable
        {
            get
            {
                return __Observable;
            }
        }

        public static string YieldDomestic
        {
            get
            {
                return __YieldDomestic;
            }
            set
            {
                __YieldDomestic = value;
            }
        }

        public static string YieldForeign
        {
            get
            {
                return __YieldForeign;
            }
            set
            {
                __YieldForeign = value;
            }
        }

    }
}
