using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Browser;
using AdminOpciones.Struct;
using AdminOpciones.MenuPrincipal;
using System.Xml.Linq;
using System.Xml;
using AdminOpciones.OpcionesFX;
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
    public partial class InicioDia : UserControl
    {
        AdminOpciones.SrvAcciones.WebAccionesSoapClient sva = AdminOpciones.Recursos.wsGlobales.Acciones;
        AdminOpciones.SrvDetalles.WebDetallesSoapClient svc = AdminOpciones.Recursos.wsGlobales.Detalles;

        XDocument xmlResult = new XDocument();
        XDocument xmlResult2 = new XDocument();
        public string XmlResultIniDia;
        public string XmlResultFechaProxH;
        public string FechaProx_h;
        public int InicioDia_;
        public string Mensaje_ = string.Empty;

        public InicioDia()
        {
            InitializeComponent();
            svc.InicioDiaCompleted += new EventHandler<AdminOpciones.SrvDetalles.InicioDiaCompletedEventArgs>(svc_InicioDiaCompleted);
            svc.FechaProxHCompleted += new EventHandler<AdminOpciones.SrvDetalles.FechaProxHCompletedEventArgs>(svc_FechaProxHCompleted);
            sva.ActualizaInicioDiaCompleted += new EventHandler<AdminOpciones.SrvAcciones.ActualizaInicioDiaCompletedEventArgs>(sva_ActualizaInicioDiaCompleted);
            Listar_Fecha_IniDia();
        }

        public class _Resultados
        {
            public string MsgStatus { get; set; }
            public override string ToString()
            {
                return string.Format("?MsgStatus={0}", MsgStatus);
            }
        }

        void Listar_Fecha_IniDia()
        {
            svc.InicioDiaAsync("01/01/2009", "01/01/2009", "01/01/2009", 0); //Retorna Fechas de Proceso y Status de Inicio Día desde Sp_OpcionesGeneral_fechas
        }

        private void CalculaFechaProx(string F1, string F2)
        {
            svc.FechaProxHAsync(F1, F2);
        }

        private void Procesa_IniDia(string _F1, string _F2, string User) 
        {
            sva.ActualizaInicioDiaAsync(_F1, _F2, User);
        }

        private void Procesar_Click(object sender, RoutedEventArgs e)
        {
            if (InicioDia_ == 0)
            {
                // MAP 20100423 Aplicar para evitar re-ejecucion del proceso
                // Se entregarÃ¡ con 5763 Cambios por errores de SAO
                btnProcesar.IsEnabled = false; 

                Procesa_IniDia(Convert.ToDateTime(txtFechaAp.Text).ToString("yyyyMMdd"), Convert.ToDateTime(txtFechaProxAp.Text).ToString("yyyyMMdd"), "LGUERRA");
                try
                {
                sva.AnticipaOpConSDAAsync(Convert.ToDateTime(txtFechaAp.Text).ToString("yyyyMMdd"), "LGUERRA");            
                  
                }
                catch { }
            }

            else
            {
                AdminOpciones.MenuPrincipal.Menu diag = new AdminOpciones.MenuPrincipal.Menu();
                string Mensaje = "Error: El Inicio día ya se ha realizado";
                System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
                HtmlPage.Window.Invoke("CallThis", null);
                Visibility = Visibility.Collapsed;
                return;
            }  
        }

        void svc_InicioDiaCompleted(object sender, AdminOpciones.SrvDetalles.InicioDiaCompletedEventArgs e)
        {
            XmlResultIniDia = e.Result;
            if (XmlResultIniDia.Length > 0)
            {
                IDia(XmlResultIniDia);
            }
        }

        void sva_ActualizaInicioDiaCompleted(object sender, AdminOpciones.SrvAcciones.ActualizaInicioDiaCompletedEventArgs e)
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
            System.Windows.Browser.HtmlPage.Window.Alert(Mensaje_);
            HtmlPage.Window.Invoke("CallThis", null);
            Visibility = Visibility.Collapsed;

        }

         void svc_FechaProxHCompleted(object sender, AdminOpciones.SrvDetalles.FechaProxHCompletedEventArgs e)
        {
            XmlResultFechaProxH = e.Result;
            if (XmlResultFechaProxH.Length > 0)
            {
                FechaProx(XmlResultFechaProxH);
            }
        }

        void IDia(string strXMLiniDia)
        {
            xmlResult = XDocument.Parse(strXMLiniDia);
            var IniDia_xml = from IDiaXML in xmlResult.Descendants("Data")
                              select new StructIniDia
                              {
                                  FechaProc = IDiaXML.Attribute("FechaProc").Value.ToString(),
                                  FechaAnt = IDiaXML.Attribute("FechaAnt").Value.ToString(),
                                  FechaProx = IDiaXML.Attribute("FechaProx").Value.ToString(),
                                  InicioDia = IDiaXML.Attribute("InicioDia").Value.ToString()
                                  
                              };

            foreach (StructIniDia _Aux in IniDia_xml)
            {
                txtFechaAp.Text = Convert.ToDateTime(_Aux.FechaProx).ToString("dd-MM-yyyy");
                txtFechaAnt.Text = Convert.ToDateTime(_Aux.FechaProc).ToString("dd-MM-yyyy");
                FechaProx_h = Convert.ToDateTime(_Aux.FechaProx).ToString("yyyyMMdd");
                InicioDia_ = int.Parse(_Aux.InicioDia);                                         
            }

            CalculaFechaProx(FechaProx_h, FechaProx_h);

        }       

        void FechaProx(string strXMLFechaProxH)
        {
            xmlResult2 = XDocument.Parse(strXMLFechaProxH);
            var FechaProx_xml = from FechaProxXML in xmlResult2.Descendants("Data")
                             select new StructFechaProxH
                             {
                                 FechaProx = FechaProxXML.Attribute("FechaProx").Value.ToString(),
                                 FechaRet = FechaProxXML.Attribute("FechaRet").Value.ToString()
                             };



            foreach (StructFechaProxH _Aux in FechaProx_xml)
            {
             txtFechaProxAp.Text = Convert.ToDateTime(_Aux.FechaProx).ToString("dd-MM-yyyy");
            }
        }

    }
}
