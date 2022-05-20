using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Configuration;

namespace AdminOpciones.Web.WebService
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]

    public class SrvConfig : System.Web.Services.WebService
    {
        [WebMethod]
        public string GetApplicationSetting(string ApplicationSetting)
        {
            //No se puede llamar a Debug antes de setear el path de LOG...

            //string path = HttpContext.Current.Server.MapPath("/");
            string path = HttpContext.Current.Server.MapPath("").Replace("\\", "\\\\");

            path = path.Remove(path.IndexOf("WebService",StringComparison.OrdinalIgnoreCase));
            //ASVG_20130506 Mejorable, por ejemplo, consultar si está definido antes de pisarlo.
            try
            {
                if (String.IsNullOrWhiteSpace(ConfigurationManager.AppSettings.Get("LIBRARY")))
                {
                    //ConfigurationManager.AppSettings.Remove("LIBRARY");
                    ConfigurationManager.AppSettings.Set("LIBRARY", path + "Files\\\\");
                }

                if (!String.IsNullOrWhiteSpace(ConfigurationManager.AppSettings.Get("LOG")))
                {
                    //ConfigurationManager.AppSettings.Remove("LOG");
                    ConfigurationManager.AppSettings.Set("LOG", path + "Files\\\\" + "Log\\\\");
                }

                if (!String.IsNullOrWhiteSpace(ConfigurationManager.AppSettings.Get("BTRADER")))
                {
                    //ConfigurationManager.AppSettings.Remove("BTRADER");
                    ConfigurationManager.AppSettings.Set("BTRADER", path + "Btrader\\\\");
                }
            }
            catch (Exception e) { }
            return ConfigurationManager.AppSettings.Get(ApplicationSetting);
        }

        [WebMethod]
        public string GetAllApplicationSetting()
        {
            //HORROR, es para forzar el seteo de ConfigurationManager
            GetApplicationSetting("OPCIONES");

            string ret = "";
            foreach (string key in ConfigurationManager.AppSettings.AllKeys)
            {
                if (key.StartsWith("BAC")) continue;
                ret += string.Format("<Key>{0}</Key><Value>{1}</Value>\n", key, ConfigurationManager.AppSettings.Get(key));
            }
            ret += string.Format("<Key2>{0}</Key2><Value>{1}</Value>\n", "LIBRARY", ConfigurationManager.AppSettings["LIBRARY"]);
            ret += string.Format("<Key2>{0}</Key2><Value>{1}</Value>\n", "LOG", ConfigurationManager.AppSettings["LOG"]);
            ret += string.Format("<Key2>{0}</Key2><Value>{1}</Value>\n", "BTRADER", ConfigurationManager.AppSettings["BTRADER"]);

            return ret;
        }

        [WebMethod]
        public string[] GetArrayApplicationSetting()
        {
            string[] ret = new string[ConfigurationManager.AppSettings.Count + ConfigurationManager.ConnectionStrings.Count];
            int i = 0;

            foreach (string key in ConfigurationManager.AppSettings.AllKeys)
            {
                //if (key.StartsWith("BAC")) continue;
                ret[i++] = string.Format("{0}:{1}", key, ConfigurationManager.AppSettings.Get(key));
            }

            //foreach (ConnectionStringSettings config in ConfigurationManager.ConnectionStrings)
            //{
            //    //if (key.StartsWith("BAC")) continue;
            //    ret[i++] = string.Format("{0}:{1}", config.ConnectionString, "");
            //}

            //return ConfigurationManager.AppSettings.AllKeys;
            return ret;
        }

        [WebMethod]
        public string GetLocalPath()
        {
            return HttpContext.Current.Server.MapPath("/");
        }

        [WebMethod]
        public string GetLocalPathNull(string path)
        {
            string ret = "";
            if (path.Equals("null"))
            {
                ret = HttpContext.Current.Server.MapPath(null);
            }
            else
            {
                ret = HttpContext.Current.Server.MapPath(path);
            }
            return ret;
        }

        [WebMethod]
        public string SetApplicationSetting(string key, string parametro)
        {
            //solamente permite pisar un parámetro, los otros se definieron arriba.
            ConfigurationManager.AppSettings[key] = parametro;

            return ConfigurationManager.AppSettings[key];
        }

        //ASVG_20140923 REVISAR
        //Viene del desarrollo de Leasing, confirmar si todavía sirve...
        private void SetAppSettings(string path)
        {
            //IDEA: esta función se podría invocar en los catch de IO.

            //OJO: No se puede llamar a Debug antes de setear el path de LOG...
            //string path = HttpContext.Current.Server.MapPath("/");
            if (path == null) { path = HttpContext.Current.Server.MapPath("").Replace("\\", "\\\\"); }

            //path = path.Remove(path.IndexOf("WebService", StringComparison.OrdinalIgnoreCase));
            int i = path.IndexOf("WebService", StringComparison.OrdinalIgnoreCase);
            if (i >= 0) { path = path.Remove(i); }

            //ASVG_20130506 Mejorable, por ejemplo, consultar si está definido antes de pisarlo.
            ConfigurationManager.AppSettings["LIBRARY"] = path + "Files\\\\";
            ConfigurationManager.AppSettings["LOG"] = path + "Files\\\\" + "Log\\\\";
            ConfigurationManager.AppSettings["BTRADER"] = path + "Btrader\\\\";
        }

        /// <summary>
        /// Validaciones básicas de la configuración.
        /// Confirma que servidor de BBDD sea el mismo para OPCIONES en <appSettings> y <connectionStrings>.
        /// </summary>
        /// <returns></returns>
        [WebMethod]
        public string CheckApplicationSettings()
        {
            try
            {
                string appSettings_OPCIONES = ConfigurationManager.AppSettings.Get("OPCIONES");
                string connectionStrings_OPCIONES = ConfigurationManager.ConnectionStrings["OPCIONES"].ConnectionString;
                if (!String.IsNullOrWhiteSpace(appSettings_OPCIONES))
                {
                    if (!String.IsNullOrWhiteSpace(connectionStrings_OPCIONES))
                    {
                        if (!appSettings_OPCIONES.Split(',')[4].Equals(connectionStrings_OPCIONES.Split(';')[0].Split('=')[1]))
                        {
                            return "Servidores no coinciden.";
                        }
                    }
                }
            }
            catch (Exception) { return "Excepción Validando Servidores, revise archivo de configuración."; }
            return "OK";
        }
    }
}