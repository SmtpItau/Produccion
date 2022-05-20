using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Browser;
using AdminOpciones.Struct;
using AdminOpciones.Recursos;
using System.Xml.Linq;
using System.Xml;
using System.Collections.ObjectModel;
using System.Globalization;
using System.Windows.Media.Imaging;
using System.Windows.Controls.Primitives;
using Liquid;
using System.Windows.Media;
using System.Windows.Data;
using System.Data;

namespace AdminOpciones.Controls
{
    public partial class CierreAbreMesa : UserControl
    {
        public delegate void event_controlmesa(int status);
        public event event_controlmesa send_controlmesa;

        AdminOpciones.SrvAcciones.WebAccionesSoapClient sva = wsGlobales.Acciones;
        AdminOpciones.SrvDetalles.WebDetallesSoapClient svc = wsGlobales.Detalles;

        XDocument xmlResult = new XDocument();
        public string Mensaje_;
        public int EstadoMesa_ = 0;


        public CierreAbreMesa()
        {
            InitializeComponent();

            sva.ActualizaCierreMesaCompleted += new EventHandler<AdminOpciones.SrvAcciones.ActualizaCierreMesaCompletedEventArgs>(sva_ActualizaCierreMesaCompleted);
            svc.RetornaCierreMesaCompleted += new EventHandler<AdminOpciones.SrvDetalles.RetornaCierreMesaCompletedEventArgs>(svc_RetornaCierreMesaCompleted);
            btnCierreA.IsEnabled = false;
            LoadStatusMesa();
        }

        private void LoadStatusMesa()
        {
            svc.RetornaCierreMesaAsync(Convert.ToDateTime(Convert.ToString(globales._FechaProceso)).ToString());
        }

        void svc_RetornaCierreMesaCompleted(object sender, AdminOpciones.SrvDetalles.RetornaCierreMesaCompletedEventArgs e)
        {
            string _fproc = Convert.ToDateTime(Convert.ToString(globales._FechaProceso)).ToString("yyyyMMdd");
            string _xmlResult = e.Result.ToString();
            xmlResult = XDocument.Parse(_xmlResult);
            List<AdminOpciones.Page._Resultado_Mesa> _data = new List<AdminOpciones.Page._Resultado_Mesa>();

            IEnumerable<XElement> elements = xmlResult.Element("CierreMesa").Elements("Data");
            foreach (XElement element in elements)
            {

                AdminOpciones.Page._Resultado_Mesa _sData = new AdminOpciones.Page._Resultado_Mesa();
                _sData.ResultMesa = element.FirstAttribute.Value.ToString();
                EstadoMesa_ = Convert.ToInt32(_sData.ResultMesa);
            }

            if (EstadoMesa_ == 1)
            {
                btnCierreA.Content = "Abrir Mesa";
            }
            else
            {
                btnCierreA.Content = "Cerrar Mesa";
            }
            btnCierreA.IsEnabled = true;
        }


        private void Procesa_CierreMesa()
        {
            sva.ActualizaCierreMesaAsync(globales._Usuario);
            if ( EstadoMesa_ == 1 )  
               {
                   btnCierreA.Content = "Cerrar Mesa";
                   EstadoMesa_ = 0;
               }
            else
            {
                btnCierreA.Content = "Abrir Mesa";
                EstadoMesa_ = 1;
            }
        }

        public class _Resultados
        {
            public string MsgStatus { get; set; }
            public override string ToString()
            {
                return string.Format("?MsgStatus={0}", MsgStatus);
            }
        }

        private void Procesar_Click(object sender, RoutedEventArgs e)
        {
            btnCierreA.IsEnabled = false;
            Procesa_CierreMesa();
        }

        void sva_ActualizaCierreMesaCompleted(object sender, AdminOpciones.SrvAcciones.ActualizaCierreMesaCompletedEventArgs e)
        {
            string _xmlResult = e.Result.ToString();
            _Resultados _sData = new _Resultados();
            xmlResult = XDocument.Parse(_xmlResult);
            List<_Resultados> _data = new List<_Resultados>();

            IEnumerable<XElement> elements = xmlResult.Element("Resultado").Elements("Data");
            foreach (XElement element in elements)
            {
                //_Resultados _sData = new _Resultados();
                _sData.MsgStatus = element.FirstAttribute.Value.ToString();
                _data.Add(_sData);
            }

            Mensaje_ = _sData.MsgStatus.ToString();

            if (Mensaje_.Equals("Apertura Mesa OK"))
            {
                send_controlmesa(0);
            }
            else if (Mensaje_.Equals("Cierre Mesa OK"))
            {
                send_controlmesa(1);
            }
            System.Windows.Browser.HtmlPage.Window.Alert(Mensaje_);
            //Visibility = Visibility.Collapsed;
            btnCierreA.IsEnabled = true;

        }
    }
}