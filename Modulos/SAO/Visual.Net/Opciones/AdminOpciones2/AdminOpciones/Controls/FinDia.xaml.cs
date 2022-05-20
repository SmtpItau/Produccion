using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Browser;
using AdminOpciones.Struct;
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
    public partial class FinDia : UserControl
    {
  
        AdminOpciones.SrvAcciones.WebAccionesSoapClient sva = AdminOpciones.Recursos.wsGlobales.Acciones;

        XDocument xmlResult = new XDocument();
        public string Mensaje_ = string.Empty;

        public FinDia()
        {
            InitializeComponent();
            sva.ActualizaFinDiaCompleted += new EventHandler<AdminOpciones.SrvAcciones.ActualizaFinDiaCompletedEventArgs>(sva_ActualizaFinDiaCompleted);
        }

        private void Procesa_FinDia()
        {
            sva.ActualizaFinDiaAsync();
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
            this.btnFinDia.IsEnabled = false;
            Procesa_FinDia();
        }

        void sva_ActualizaFinDiaCompleted(object sender, AdminOpciones.SrvAcciones.ActualizaFinDiaCompletedEventArgs e)
        {
            this.btnFinDia.IsEnabled = true;
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
            System.Windows.Browser.HtmlPage.Window.Alert(Mensaje_);
            Visibility = Visibility.Collapsed;      

        }
    }  
}
