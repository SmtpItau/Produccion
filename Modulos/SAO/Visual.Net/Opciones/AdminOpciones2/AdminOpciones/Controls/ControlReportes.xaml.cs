using System;
using System.Collections.Generic;
using System.Windows.Browser;
using System.Windows.Controls;
using AdminOpciones.Recursos;
using System.Windows;

namespace AdminOpciones.Controls
{
    public partial class ControlReportes : UserControl
    {
        public ControlReportes()
        {
            InitializeComponent();

            List<string> _carga = new List<string>();
            _carga.Add("");
            _carga.Add("Prueba");
            _carga.Add("Otra Prueba"); //alanrevisar ??
            cmb_TipoTransac.ItemsSource = _carga;
        }

        #region "Reportes"
        /*----------------------------------REPORTES v1.0 by Edo-------------------------------------------*/

        private void Btn_Buscar_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            string _Nombre = _Nombre = TextBox1.Text != "" ? TextBox1.Text : "",
                    _Cuenta = "",
                    _FechaDesde = "",
                    _FechaHasta = "",
                    _TipoTransac = "";
            //asvg falta validar este campo
            string _NumeroContrato = txt_NumeroContrato.Text != "" ? txt_NumeroContrato.Text : "0";
            //int _NumeroContrato = txt_NumeroContrato.Text != "" ? int.Parse(txt_NumeroContrato.Text) : 0;

            List<KeyValuePair<string, string>> lst_ = new List<KeyValuePair<string, string>>();

            switch (_Nombre)
            {
                case "Voucher Contables":
                    
                    _FechaDesde = Dt_FechaDesde.Text != "" ? Dt_FechaDesde.Text : "";
                    lst_.Clear();                 
                    lst_.Add(new KeyValuePair<string, string>("Usuario", globales._Usuario ));
                    lst_.Add(new KeyValuePair<string, string>("RepName", "~/CrystalReportes/Contabilidad_Listado_Voucher.rpt"));
                    lst_.Add(new KeyValuePair<string, string>("Tipo", "Voucher"));
                    lst_.Add(new KeyValuePair<string, string>("FechaDesde", _FechaDesde));

                    this.ProcessCommand(lst_.ToArray());
                    break;

                case "Listado Movimientos entre fechas":

                    _FechaDesde = Dt_FechaDesde.Text != "" ? Dt_FechaDesde.Text : "";
                    _FechaHasta = Dt_FechaHasta.Text != "" ? Dt_FechaHasta.Text : "";
                    lst_.Clear();
                    lst_.Add(new KeyValuePair<string, string>("Usuario", globales._Usuario ));
                    lst_.Add(new KeyValuePair<string, string>("RepName", "~/CrystalReportes/MoNivOpciones.rpt"));
                    lst_.Add(new KeyValuePair<string, string>("Tipo", "ListMovFechas"));
                    lst_.Add(new KeyValuePair<string, string>("FechaDesde", _FechaDesde));
                    lst_.Add(new KeyValuePair<string, string>("FechaHasta", _FechaHasta));
                    lst_.Add(new KeyValuePair<string, string>("NumeroContrato", _NumeroContrato));

                    this.ProcessCommand(lst_.ToArray());
                    break;

                case "Listado Anulaciones":

                    _FechaDesde = Dt_FechaDesde.Text != "" ? Dt_FechaDesde.Text : "";
                    _FechaHasta = Dt_FechaHasta.Text != "" ? Dt_FechaHasta.Text : "";
                    _TipoTransac = "ANULA"; // MAP 20090630 cmb_TipoTransac.SelectedItem.ToString() != "" ? cmb_TipoTransac.SelectedItem.ToString() : "";
                    lst_.Clear();
                    lst_.Add(new KeyValuePair<string, string>("Usuario", globales._Usuario ));
                    lst_.Add(new KeyValuePair<string, string>("RepName", "~/CrystalReportes/MoNivOpciones.rpt"));
                    lst_.Add(new KeyValuePair<string, string>("Tipo", "ListAnulaciones"));
                    lst_.Add(new KeyValuePair<string, string>("FechaDesde", _FechaDesde));
                    lst_.Add(new KeyValuePair<string, string>("FechaHasta", _FechaHasta));
                    lst_.Add(new KeyValuePair<string, string>("TipoTransac", _TipoTransac));

                    this.ProcessCommand(lst_.ToArray());
                    break;

                case "Listado Control de Precios":

                    _FechaDesde = Dt_FechaDesde.Text != "" ? Dt_FechaDesde.Text : "";
                    _FechaHasta = Dt_FechaHasta.Text != "" ? Dt_FechaHasta.Text : "";                    
                    lst_.Clear();
                    lst_.Add(new KeyValuePair<string, string>("Usuario", globales._Usuario ));
                    lst_.Add(new KeyValuePair<string, string>("RepName", "~/CrystalReportes/MoControlPrecios.rpt"));
                    lst_.Add(new KeyValuePair<string, string>("Tipo", "ListContrPreci"));
                    lst_.Add(new KeyValuePair<string, string>("FechaDesde", _FechaDesde));
                    lst_.Add(new KeyValuePair<string, string>("FechaHasta", _FechaHasta));                   

                    this.ProcessCommand(lst_.ToArray());
                    break;

                case "Cartera":

                    _FechaDesde = Dt_FechaDesde.Text != "" ? Dt_FechaDesde.Text : "";

                    lst_.Clear();
                    lst_.Add(new KeyValuePair<string, string>("Usuario", globales._Usuario));
                    lst_.Add(new KeyValuePair<string, string>("RepName", "~/CrystalReportes/CaNivContrato.rpt"));
                    lst_.Add(new KeyValuePair<string, string>("Tipo", "ICartera"));
                    lst_.Add(new KeyValuePair<string, string>("FechaDesde", _FechaDesde));
                    lst_.Add(new KeyValuePair<string, string>("TipoTransaccion", "1"));
                    lst_.Add(new KeyValuePair<string, string>("NumeroContrato", _NumeroContrato));

                    this.ProcessCommand(lst_.ToArray());

                    lst_.Clear();
                    lst_.Add(new KeyValuePair<string, string>("Usuario", globales._Usuario));
                    lst_.Add(new KeyValuePair<string, string>("RepName", "~/CrystalReportes/CaNivContrato.rpt"));
                    lst_.Add(new KeyValuePair<string, string>("Tipo", "ICartera"));
                    lst_.Add(new KeyValuePair<string, string>("FechaDesde", _FechaDesde));
                    lst_.Add(new KeyValuePair<string, string>("TipoTransaccion", "2"));
                    lst_.Add(new KeyValuePair<string, string>("NumeroContrato", _NumeroContrato));

                    this.ProcessCommand(lst_.ToArray());

                    lst_.Clear();
                    lst_.Add(new KeyValuePair<string, string>("Usuario", globales._Usuario));
                    lst_.Add(new KeyValuePair<string, string>("RepName", "~/CrystalReportes/CaNivContrato.rpt"));
                    lst_.Add(new KeyValuePair<string, string>("Tipo", "ICartera"));
                    lst_.Add(new KeyValuePair<string, string>("FechaDesde", _FechaDesde));
                    lst_.Add(new KeyValuePair<string, string>("TipoTransaccion", "3"));
                    lst_.Add(new KeyValuePair<string, string>("NumeroContrato", _NumeroContrato));

                    this.ProcessCommand(lst_.ToArray());

                    MessageBoxResult Imprimir = MessageBox.Show("Desea imprimir a nivel de opciones ", "Administrador Opciones", MessageBoxButton.OKCancel);

                    if (Imprimir == MessageBoxResult.OK)
                    {
                        _FechaDesde = Dt_FechaDesde.Text != "" ? Dt_FechaDesde.Text : "";
                        lst_.Clear();
                        lst_.Add(new KeyValuePair<string, string>("Usuario", globales._Usuario));
                        lst_.Add(new KeyValuePair<string, string>("RepName", "~/CrystalReportes/CaNivOpciones.rpt"));
                        lst_.Add(new KeyValuePair<string, string>("Tipo", "ICarteraOpciones"));
                        lst_.Add(new KeyValuePair<string, string>("FechaDesde", _FechaDesde));
                        lst_.Add(new KeyValuePair<string, string>("NumeroContrato", _NumeroContrato));

                        this.ProcessCommand(lst_.ToArray());

                    }
                    break;

                case "Movimientos por Cta.":

                    _FechaDesde = Dt_FechaDesde.Text != "" ? Dt_FechaDesde.Text : "";
                    _FechaHasta = Dt_FechaHasta.Text != "" ? Dt_FechaHasta.Text : "";
                    _Cuenta = txt_Cuenta.Text != "" ? txt_Cuenta.Text : "";
                   
                    lst_.Clear();
                    lst_.Add(new KeyValuePair<string, string>("Usuario", globales._Usuario ));
                    lst_.Add(new KeyValuePair<string, string>("RepName", "~/CrystalReportes/Contabilidad_Listado_Cuenta.rpt"));
                    lst_.Add(new KeyValuePair<string, string>("Tipo", "MovPorCta"));
                    lst_.Add(new KeyValuePair<string, string>("FechaDesde", _FechaDesde));
                    lst_.Add(new KeyValuePair<string, string>("FechaHasta", _FechaHasta));
                    lst_.Add(new KeyValuePair<string, string>("Cuenta", _Cuenta));

                    this.ProcessCommand(lst_.ToArray());
                    break;

                case "Balance por Operación":

                    _FechaDesde = Dt_FechaDesde.Text != "" ? Dt_FechaDesde.Text : "";
                    lst_.Clear();
                    lst_.Add(new KeyValuePair<string, string>("Usuario", globales._Usuario ));
                    lst_.Add(new KeyValuePair<string, string>("RepName", "~/CrystalReportes/Total_Por_Cuenta.rpt"));
                    lst_.Add(new KeyValuePair<string, string>("Tipo", "Balance"));
                    lst_.Add(new KeyValuePair<string, string>("FechaDesde", _FechaDesde));

                    this.ProcessCommand(lst_.ToArray());
                    break;
            }
        }

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
            HtmlPage.Window.Invoke("AbreReporte", response);
        }
        #endregion

        private void LayoutRoot_Loaded(object sender, System.Windows.RoutedEventArgs e)
        {
            string _Nombre = _Nombre = TextBox1.Text != "" ? TextBox1.Text : "";
            switch (_Nombre)
            {
                case "Voucher Contables":
                case "Cartera":
                case "Balance por Operación":
                    txt_Cuenta.IsEnabled = false;
                    Dt_FechaHasta.IsEnabled = false;
                    cmb_TipoTransac.IsEnabled = false;
                    Dt_FechaDesde.Text = globales._FechaProceso;
                    break;
                case "Listado Movimientos entre fechas":
                    txt_NumeroContrato.IsEnabled = true;
                    txt_Cuenta.IsEnabled = false;
                    cmb_TipoTransac.IsEnabled = false;
                    Dt_FechaDesde.Text = globales._FechaProceso;
                    Dt_FechaHasta.Text = globales._FechaProceso;
                    break;
                case "Listado Control de Precios":
                    txt_Cuenta.IsEnabled = false;                    
                    cmb_TipoTransac.IsEnabled = false;
                    Dt_FechaDesde.Text = globales._FechaProceso;
                    Dt_FechaHasta.Text = globales._FechaProceso;
                    break;
                case "Listado Anulaciones":
                    txt_Cuenta.IsEnabled = false;
                    List<string> _d = new List<string>();
                    _d.Add("");
                    _d.Add("ANULA");
                    cmb_TipoTransac.ItemsSource = _d;
                    Dt_FechaDesde.Text = globales._FechaProceso;
                    Dt_FechaHasta.Text = globales._FechaProceso;
                    break;                                                                       
                case "Movimientos por Cta.":                    
                    cmb_TipoTransac.IsEnabled = false;
                    Dt_FechaDesde.Text = globales._FechaProceso;
                    Dt_FechaHasta.Text = globales._FechaProceso;
                    break;
            }
        }
    }
}