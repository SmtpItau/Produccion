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
using System.Xml.Linq;
using System.Windows.Browser;
using AdminOpciones.SrvDetalles;
using AdminOpciones.Delegados;
using AdminOpciones.Recursos;

namespace AdminOpciones.Controls
{

    public enum EnumProcess
    {
        Init = 0,
        RecalcularLineas = 1,
        Contabilidad = 2,
        InterfazOperacion = 3,
        InterfazDerivados = 4,
        InterfazBalance = 5
    }

    public partial class Process : UserControl
    {

        #region Definicion de variables y Eventos

        public string UserControlName { get; set; }
        public event CloseWindows event_CloseWindows;
        public EnumProcess ProcessType { get; set; }
        private AdminOpciones.SrvDetalles.WebDetallesSoapClient _SrvProcess = wsGlobales.Detalles;

        private class Resultados
        {
            public string Result1 { get; set; }
            public string Result2 { get; set; }
        }

        #endregion

        public Process()
        {
            InitializeComponent();
            ProcessType = EnumProcess.Init;
            _SrvProcess.RecalculoLineasOpcionesCompleted += new EventHandler<RecalculoLineasOpcionesCompletedEventArgs>(RecalculoLineasOpcionesCompleted);
            _SrvProcess.GenCntVoucherCompleted += new System.EventHandler<GenCntVoucherCompletedEventArgs>(GenCntVoucherCompleted);
        }

        #region Executing

        public void Executing(EnumProcess process)
        {
            ProcessType = process;
            Executing();
        }

        public void Executing()
        {
            switch (ProcessType)
            {
                case EnumProcess.Init:
                    break;
                case EnumProcess.RecalcularLineas:
                    RecalcularLineas();
                    break;
                case EnumProcess.Contabilidad:
                    Contabilidad();
                    break;
                case EnumProcess.InterfazOperacion:
                    InterfazOperacion();
                    break;
                case EnumProcess.InterfazDerivados:
                    InterfazDerivados();
                    break;
                case EnumProcess.InterfazBalance:
                    InterfazBalance();
                    break;
                default:
                    break;
            }
        }

        #endregion

        #region Recalcular Lineas

        private void RecalcularLineas()
        {
            StartingProcess();
            textStatus.Text = "Recalculando las Líneas...";
            _SrvProcess.RecalculoLineasOpcionesAsync();
        }

        private void RecalculoLineasOpcionesCompleted(object sender, RecalculoLineasOpcionesCompletedEventArgs e)
        {
            string _xmlResult = e.Result.ToString();
            XDocument xmlResult = XDocument.Parse(_xmlResult);
            IEnumerable<XElement> elements = xmlResult.Element("Resultado").Elements("Data");
            string Mensaje = string.Empty;

            Resultados _Resultado = new Resultados();
            foreach (XElement element in elements)
            {
                _Resultado.Result1 = element.FirstAttribute.Value.ToString();
                _Resultado.Result2 = element.LastAttribute.Value.ToString();
            }

            StopProcess();

            Mensaje = _Resultado.Result2.ToString();
            textStatus.Text = Mensaje;
        }

        #endregion

        #region Contabilidad

        private void Contabilidad()
        {

            //if (_OpcionesElegidas.Count == 0)
            //{
            //    string _fechaProceso = Convert.ToDateTime(globales._FechaProceso).ToString("yyyyMMdd");
            //    Canvas pantalla = new Canvas();
            //    pantalla.Name = "loading";
            //    cPrincipal.Children.Clear();
            //    cPrincipal.Children.Add(pantalla);
            //    StartLoading(pantalla);
            //    svc.GenCntVoucherAsync(_fechaProceso);
            //}

            StartingProcess();
            string _DateProcess = Convert.ToDateTime(globales._FechaProceso).ToString("yyyyMMdd");
            textStatus.Text = "Contabilizando...";
            _SrvProcess.GenCntVoucherAsync(_DateProcess);

        }

        private void GenCntVoucherCompleted(object sender, GenCntVoucherCompletedEventArgs e)
        {
            string _xmlResult = e.Result.ToString();
            Resultados _Resultados = new Resultados();

            if (_xmlResult == "0")
            {
                List<KeyValuePair<string, string>> _LstProcess = new List<KeyValuePair<string, string>>();
                _LstProcess.Clear();
                _LstProcess.Add(new KeyValuePair<string, string>("Tipo", "CntVoucher"));
                _LstProcess.Add(new KeyValuePair<string, string>("Fecha", globales._FechaProceso.ToString()));
                textStatus.Text = "Generando Interfaz";
                this.ProcessCommand(_LstProcess.ToArray());

            }
            else
            {
                XDocument xmlResult = XDocument.Parse(_xmlResult);
                IEnumerable<XElement> elements = xmlResult.Element("Resultado").Elements("Data");

                foreach (XElement element in elements)
                {
                    _Resultados.Result1 = element.FirstAttribute.Value.ToString();
                }

                textStatus.Text = _Resultados.Result1.ToString();
                StopProcess();
            }
        }

        #endregion

        #region Interfaz de Operaciones

        private void InterfazOperacion()
        {

            //if (_OpcionesElegidas.Count == 0)
            //{
            //    Canvas pantalla = new Canvas();
            //    pantalla.Name = "loading";
            //    List<KeyValuePair<string, string>> lst_ = new List<KeyValuePair<string, string>>();
            //    lst_.Clear();
            //    lst_.Add(new KeyValuePair<string, string>("Tipo", "IntOperaciones"));
            //    lst_.Add(new KeyValuePair<string, string>("Fecha", globales._FechaProceso.ToString()));
            //    cPrincipal.Children.Clear();
            //    cPrincipal.Children.Add(pantalla);
            //    StartLoading(pantalla);
            //    this.ProcessCommand(lst_.ToArray());
            //}

            StartingProcess();
            textStatus.Text = "Loading...";
            List<KeyValuePair<string, string>> _LstProcess = new List<KeyValuePair<string, string>>();
            _LstProcess.Clear();
            _LstProcess.Add(new KeyValuePair<string, string>("Tipo", "IntOperaciones"));
            _LstProcess.Add(new KeyValuePair<string, string>("Fecha", globales._FechaProceso.ToString()));
            this.ProcessCommand(_LstProcess.ToArray());

        }

        #endregion

        #region Interfaz de Derivados

        private void InterfazDerivados()
        {

            //if (_OpcionesElegidas.Count == 0)
            //{
            //    List<KeyValuePair<string, string>> lst_ = new List<KeyValuePair<string, string>>();
            //    lst_.Clear();
            //    lst_.Add(new KeyValuePair<string, string>("Tipo", "IntDerivados"));
            //    lst_.Add(new KeyValuePair<string, string>("Fecha", globales._FechaProceso.ToString()));
            //    cPrincipal.Children.Clear();
            //    StartLoading(cPrincipal);
            //    this.ProcessCommand(lst_.ToArray());
            //}

            StartingProcess();
            textStatus.Text = "Loading...";
            List<KeyValuePair<string, string>> _LstProcess = new List<KeyValuePair<string, string>>();
            _LstProcess.Clear();
            _LstProcess.Add(new KeyValuePair<string, string>("Tipo", "IntDerivados"));
            _LstProcess.Add(new KeyValuePair<string, string>("Fecha", globales._FechaProceso.ToString()));
            this.ProcessCommand(_LstProcess.ToArray());

        }

        #endregion

        #region Interfaz de Balance

        private void InterfazBalance()
        {

            //if (_OpcionesElegidas.Count == 0)
            //{
            //    List<KeyValuePair<string, string>> lst_ = new List<KeyValuePair<string, string>>();
            //    lst_.Clear();
            //    lst_.Add(new KeyValuePair<string, string>("Tipo", "IntBalance"));
            //    lst_.Add(new KeyValuePair<string, string>("Fecha", globales._FechaProceso.ToString()));
            //    cPrincipal.Children.Clear();
            //    StartLoading(cPrincipal);
            //    this.ProcessCommand(lst_.ToArray());
            //}

            StartingProcess();
            textStatus.Text = "Loading...";
            List<KeyValuePair<string, string>> _LstProcess = new List<KeyValuePair<string, string>>();
            _LstProcess.Clear();
            _LstProcess.Add(new KeyValuePair<string, string>("Tipo", "IntBalance"));
            _LstProcess.Add(new KeyValuePair<string, string>("Fecha", globales._FechaProceso.ToString()));
            this.ProcessCommand(_LstProcess.ToArray());

        }

        #endregion

        #region Manejo de Status Proceso

        private void StartingProcess()
        {
            Mask.Visibility = Visibility.Visible;
        }

        private void StopProcess()
        {
            Mask.Visibility = Visibility.Collapsed;
        }

        #endregion

        #region "Codificador url"

        private void ProcessCommand(params KeyValuePair<string, string>[] values)
        {
            Uri serverUri_ = new Uri(wsGlobales.FullUri + "Default.aspx");
            HttpHelper helper = new HttpHelper(serverUri_, "POST", values);
            helper.ResponseComplete += new HttpResponseCompleteEventHandler(this.CommandComplete);
            helper.Execute();
        }

        private void CommandComplete(HttpResponseCompleteEventArgs e)
        {
            this.Dispatcher.BeginInvoke(() => this.WriteText(e.Response));
        }

        private void WriteText(string response)
        {
            HtmlPage.Window.Invoke("ExportaTxt", response);
            textStatus.Text = "Procesos Terminado";
            StopProcess();
        }

        #endregion

        #region Buton Salir

        private void buttonSalir_Click(object sender, RoutedEventArgs e)
        {
            event_CloseWindows(UserControlName);
        }

        #endregion

    }
}
