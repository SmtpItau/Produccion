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
using AdminOpciones.Recursos;
using System.Collections.ObjectModel;
using System.Globalization;
using System.Windows.Media.Imaging;
using System.Windows.Controls.Primitives;
using Liquid;
using System.Windows.Media;
using System.Windows.Data;
using System.Data;
using AdminOpciones.OpcionesFX;

namespace AdminOpciones.Controls
{
    public partial class ActualizaParametros : UserControl
    {
        AdminOpciones.SrvAcciones.WebAccionesSoapClient sva = wsGlobales.Acciones;

        XDocument xmlResult = new XDocument();
        public string Mensaje_ = string.Empty;
        AdminOpciones.OpcionesFX.Icon RotateIcon = new AdminOpciones.OpcionesFX.Icon();
        Canvas TransparentMask;

        public ActualizaParametros()
        {
            InitializeComponent();
            sva.ActualizaParamCompleted += new EventHandler<AdminOpciones.SrvAcciones.ActualizaParamCompletedEventArgs>(sva_ActualizaParamCompleted);
            GeneraLogAuditoria();
        }

        private void Procesa_ActParam()
        {
            sva.ActualizaParamAsync();
            StartLoading(this.LayoutRoot);
        }

        public class _ResultadosActualizaParam
        {
            public string MsgStatus { get; set; }
            public override string ToString()
            {
                return string.Format("?MsgStatus={0}", MsgStatus);
            }
        }

        private void Procesar_Click(object sender, RoutedEventArgs e)
        {
            Procesa_ActParam();
        }

        void sva_ActualizaParamCompleted(object sender, AdminOpciones.SrvAcciones.ActualizaParamCompletedEventArgs e)
        {
            string _xmlResult = e.Result.ToString();
            _ResultadosActualizaParam _sData = new _ResultadosActualizaParam();
            xmlResult = XDocument.Parse(_xmlResult);
            List<_ResultadosActualizaParam> _data = new List<_ResultadosActualizaParam>();

            IEnumerable<XElement> elements = xmlResult.Element("Resultado").Elements("Data");
            foreach (XElement element in elements)
            {
                //_Resultados _sData = new _Resultados();
                _sData.MsgStatus = element.FirstAttribute.Value.ToString();
                _data.Add(_sData);
            }

            Mensaje_ = _sData.MsgStatus.ToString();
            
            System.Windows.Browser.HtmlPage.Window.Alert(Mensaje_);
            StopLoading();
        }

        private void GeneraLogAuditoria()
        {
            #region Definicion de Variables

            string _Xml = "<?xml version=\"1.0\" encoding=\"utf-8\"?>";

            #endregion

            #region Generación de Formato XML

            _Xml += string.Format("<Options>");
            _Xml += string.Format(
                                    "<Option Entidad='{0}' FechaProceso='{1}' FechaSistema ='{2}' HoraProceso ='{3}' Terminal ='{4}' " + 
                                    " Usuario ='{5}' Id_Sistema ='{6}' CodigoMenu ='{7}' Codigo_Evento ='{8}' DetalleTransac ='{9}' TablaInvolucrada ='{10}' ValorAntiguo ='{11}' ValorNuevo ='{12}' />",
                                    "1",
                                    globales._FechaProceso, DateTime.Now, DateTime.Parse(Convert.ToString(DateTime.Now)).ToString("hh:mm:ss"), "ADMOPC", globales._Usuario, "OPT", "AdmOpc000001", "01", "Detalle Transac",  
                                    "", "", ""
                                    );
            _Xml += "</Options>";

            #endregion Generación de Formato XML

            #region Ejecución del WebService
            sva.InsertLogAuditoriaAsync(_Xml);
            #endregion
        }

        private void StartLoading(Canvas canvas)
        {
            TransparentMask = new Canvas();
            TransparentMask.Name = canvas.Name + "Mask";
            double _width, _height;
            _width = 316;
            _height = 147;

            TransparentMask.SetValue(Canvas.LeftProperty, 0.0);
            TransparentMask.SetValue(Canvas.TopProperty, 0.0);

            TransparentMask.Width = _width;
            TransparentMask.Height = _height;
            TransparentMask.Background = new SolidColorBrush(Colors.LightGray);
            TransparentMask.Opacity = 0.4;

            AdminOpciones.OpcionesFX.Icon RotateIconDynamic = new AdminOpciones.OpcionesFX.Icon();

            RotateIconDynamic.SetValue(Canvas.LeftProperty, (_width / 2.0) - 30.0);
            RotateIconDynamic.SetValue(Canvas.TopProperty, (_height / 2.0) - 30.0);

            TransparentMask.Children.Add(RotateIconDynamic);
            TransparentMask.Visibility = Visibility.Visible;

            canvas.Children.Add(TransparentMask);
        }

        private void StopLoading()
        {
            this.TransparentMask.Children.Remove(RotateIcon);
            this.TransparentMask.Visibility = Visibility.Collapsed;
            this.TransparentMask.Background = new SolidColorBrush(Colors.Gray);
            this.TransparentMask.Opacity = 0.7;
        }

        ///// <summary>
        ///// Prd_16803 Comunicación entre SAO y Leasecom
        ///// </summary>
        ///// <param name="sender"></param>
        ///// <param name="e"></param>
        //private void CargaRelacionLeasingClick(object sender, RoutedEventArgs e)
        //{
        //    try
        //    {
        //        string FechaProceso = Convert.ToDateTime(globales._FechaProceso).ToString("yyyyMMdd");
        //        sva.ValidaFechaListaLeasingAsync(FechaProceso);
        //        sva.ValidaFechaListaLeasingCompleted += new EventHandler<AdminOpciones.SrvAcciones.ValidaFechaListaLeasingCompletedEventArgs>(sva_ValidaFechaListaLeasingCompleted);

        //        //REVISAR
        //        //PRD_16803 Entrega_20131120
        //        // this.Dispatcher.BeginInvoke(() =>
        //        // {
        //        //     string FechaProceso = Convert.ToDateTime(globales._FechaProceso).ToString("yyyyMMdd");
        //        //     sva.ValidaFechaListaLeasingCompleted += new EventHandler<AdminOpciones.SrvAcciones.ValidaFechaListaLeasingCompletedEventArgs>(sva_ValidaFechaListaLeasingCompleted); 
        //        //     sva.ValidaFechaListaLeasingAsync(FechaProceso);
        //        // });
        //    }
        //    catch
        //    {
        //        System.Windows.Browser.HtmlPage.Window.Alert("Error al Invocar Servicio");
        //    }
        //}

        //private void Leasing_ListaLeasing(object sender, AdminOpciones.SrvLeasing.ConsultaLeasingACLSC1002CompletedEventArgs e)
        //{
        //    string _xmlResult = e.Result.ToString();
        //    XDocument xmlResult = new XDocument();
        //    xmlResult = XDocument.Parse(_xmlResult);

        //    string FechaProceso = Convert.ToDateTime(globales._FechaProceso).ToString("yyyyMMdd");
        //    try
        //    {
        //        sva.GrabaListaLeasingAsync(_xmlResult, FechaProceso);
        //        sva.GrabaListaLeasingCompleted += new EventHandler<AdminOpciones.SrvAcciones.GrabaListaLeasingCompletedEventArgs>(sva_GrabaListaLeasingCompleted);
        //    }
        //    catch
        //    {
        //        this.Dispatcher.BeginInvoke(() =>
        //        {
        //            System.Windows.Browser.HtmlPage.Window.Alert("Error al cargar Listado Relaciona Leasing SAO");
        //        });
        //    }
        //}

        #region ListaLeasing (Comentado)

        //private void ListaLeasing(IAsyncResult ar)
        //{
        //    string XmlListadoLeasing = "";
        //    string FechaProceso = Convert.ToDateTime(globales._FechaProceso).ToString("yyyyMMdd");
        //    try
        //    {
        //        SrvLeasing.SrvSAOSoap client = ar.AsyncState as SrvLeasing.SrvSAOSoap;
        //        var stringArray = client.EndListarLeasingRelacionados(ar);
        //        int TotalDatos = stringArray.ListaLeasing.Count();
        //        //agregar control error
        //
        //        if (stringArray.Error == 0)
        //        {
        //            //Array <int, int, int> listaInt = stringArray.ListaLeasing;
        //            //int[, ,] ArrayInt = {stringArray.ListaLeasing[].NumeroForward
        //            //                        ,stringArray.ListaLeasing[].NumeroForward
        //            //                        ,stringArray.ListaLeasing[].NumeroForward};
        //
        //            if (TotalDatos > 0)
        //            {
        //                XmlListadoLeasing = "<ListaLeasing>\n";
        //
        //                for (int i = 0; i < stringArray.ListaLeasing.Count(); i++)
        //                {
        //                    XmlListadoLeasing += string.Format(
        //                                                         "<RelatedLeasingClass> \n <NumeroLeasing>{0}</NumeroLeasing> \n <NumeroGrupoBienes>{1}</NumeroGrupoBienes> \n <NumeroForward>{2}</NumeroForward> \n </RelatedLeasingClass> \n",
        //                                                         stringArray.ListaLeasing[i].NumeroLeasing,
        //                                                         stringArray.ListaLeasing[i].NumeroGrupoBienes,
        //                                                         stringArray.ListaLeasing[i].NumeroForward,
        //                                                         FechaProceso
        //                                                      );
        //                }
        //                XmlListadoLeasing += "</ListaLeasing>\n";
        //
        //                sva.GrabaListaLeasingAsync(XmlListadoLeasing, FechaProceso);
        //                sva.GrabaListaLeasingCompleted += new EventHandler<AdminOpciones.SrvAcciones.GrabaListaLeasingCompletedEventArgs>(sva_GrabaListaLeasingCompleted);
        //            }
        //        }
        //        else
        //        {
        //            this.Dispatcher.BeginInvoke(() =>
        //            {
        //                System.Windows.Browser.HtmlPage.Window.Alert("Error al cargar Listado Relaciona Leasing SAO");
        //            });              
        //        }
        //
        //    }
        //    catch
        //    {
        //        this.Dispatcher.BeginInvoke(() =>
        //        {
        //            System.Windows.Browser.HtmlPage.Window.Alert("Error al cargar Listado Relaciona Leasing SAO");
        //        });
        //
        //    }
        //}

        #endregion ListaLeasing (Comentado)

        //void sva_GrabaListaLeasingCompleted(object sender, AdminOpciones.SrvAcciones.GrabaListaLeasingCompletedEventArgs e)
        //{
        //    try
        //    {
        //        string _xmlResult = e.Result.ToString();

        //        if (_xmlResult == "0")
        //        {
        //            this.Dispatcher.BeginInvoke(() =>
        //             {
        //                 System.Windows.Browser.HtmlPage.Window.Alert("Se cargo tabla Leasing_Relacionados_OPT de forma correcta ");
        //                 return;
        //             });                   
        //        }
        //        else
        //        {
        //            this.Dispatcher.BeginInvoke(() =>
        //             {
        //                 System.Windows.Browser.HtmlPage.Window.Alert("Error al cargar Listado Relaciona Leasing, Revisar  en en Accione metodo GrabaListaLeasing");
        //                 return;
        //             });
        //        }
        //    }
        //    catch(Exception Ex)
        //    {
        //        this.Dispatcher.BeginInvoke(() =>
        //        {
        //            System.Windows.Browser.HtmlPage.Window.Alert("Error al Invocar Servicio SrvSAO  Error: " + Ex); 
        //            return;
        //        });
        //    }
        //}

        //void sva_ValidaFechaListaLeasingCompleted(object sender, AdminOpciones.SrvAcciones.ValidaFechaListaLeasingCompletedEventArgs e)
        //{
        //    try
        //    {
        //        string _xmlResult = e.Result.ToString();
        //        bool _resolver = true;

        //        if (_xmlResult == "1")
        //        {
        //            _resolver = System.Windows.Browser.HtmlPage.Window.Confirm("Existe Listado Leasing para Hoy, " + "Desea Reemplazar");
        //        }

        //        if (_resolver.Equals(true))
        //        {
        //            try
        //            {
        //                AdminOpciones.SrvLeasing.LeasingSoapClient Leasing = wsGlobales.Leasing;
        //                Leasing.ConsultaLeasingACLSC1002Async();
        //                Leasing.ConsultaLeasingACLSC1002Completed += new EventHandler<AdminOpciones.SrvLeasing.ConsultaLeasingACLSC1002CompletedEventArgs>(Leasing_ListaLeasing);
        //            }
        //            catch
        //            {
        //                System.Windows.Browser.HtmlPage.Window.Alert("Error al Invocar Servicio SrvSAO Metodo ListarLeasingRelacionados [ConsultaLeasingACLSC1002]");
        //            }
        //        }
        //    }
        //    catch { }
        //}
    }
}