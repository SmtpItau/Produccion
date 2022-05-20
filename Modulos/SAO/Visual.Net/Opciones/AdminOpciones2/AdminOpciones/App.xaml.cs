using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;
using AdminOpciones.Recursos;

namespace AdminOpciones
{
    public partial class App : Application
    {

        public App()
        {
            this.Startup += this.Application_Startup;
            this.Exit += this.Application_Exit;
            this.UnhandledException += this.Application_UnhandledException;

            InitializeComponent();
        }

        private void Application_Startup(object sender, StartupEventArgs e)
        {
            /*
             * http://msdn.microsoft.com/en-us/library/cc838255(v=vs.95).aspx
             * */
            string aUri = this.Host.Source.AbsoluteUri;
            string aPath = this.Host.Source.AbsolutePath;
            //ASVG_20130425 parche para soportar directorios virtuales. Se requiere mejorar.
            //aPath = "/ClientBin/AdminOpciones.xap";
            string source = e.InitParams["source"];

            globales._Usuario_turing = e.InitParams["user_name"];
            globales._Password_turing = e.InitParams["user_password"];
            globales._Turing = (globales._Usuario_turing.Trim().Length > 0);

            string BaseUri = aUri.Remove(aUri.IndexOf(aPath));
            string BaseDir = aPath.Remove(aPath.IndexOf(source));
            //System.Windows.Browser.HtmlPage.Window.Alert(WebServicePath);

            //Acá se cambió para limpiar el cache de las páginas y no dejar páginas en memoria (n_n)
            this.RootVisual = new PageSwitcher(BaseUri, BaseDir);
        }

        private void Application_Exit(object sender, EventArgs e)
        {
        }
        
        private void Application_UnhandledException(object sender, ApplicationUnhandledExceptionEventArgs e)
        {
            // Si la aplicación se está ejecutando fuera del depurador, informe de la excepción mediante
            // el mecanismo de excepciones del explorador. En IE se mostrará un icono de alerta amarillo 
            // en la barra de estado y en Firefox se mostrará un error de script.
            if (!System.Diagnostics.Debugger.IsAttached)
            {

                // NOTA: esto permitirá a la aplicación continuar ejecutándose después de que una excepción se haya producido
                // pero no controlado. 
                // Para las aplicaciones de producción, este control de errores se debe reemplazar por algo que 
                // informará del error al sitio web y detendrá la aplicación.
                e.Handled = true;
                Deployment.Current.Dispatcher.BeginInvoke(delegate { ReportErrorToDOM(e); });
            }
        }

        private void ReportErrorToDOM(ApplicationUnhandledExceptionEventArgs e)
        {
            try
            {
                string errorMsg = e.ExceptionObject.Message + e.ExceptionObject.StackTrace;
                errorMsg = errorMsg.Replace('"', '\'').Replace("\r\n", @"\n");

                System.Windows.Browser.HtmlPage.Window.Eval("throw new Error(\"Unhandled Error in Silverlight 4 Application " + errorMsg + "\");");
            }
            catch (Exception)
            {
            }
        }
    }
}
