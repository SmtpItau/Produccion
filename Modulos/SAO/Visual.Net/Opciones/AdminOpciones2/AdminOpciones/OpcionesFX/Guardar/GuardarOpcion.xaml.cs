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
using AdminOpciones.Struct.OpcionesXF.Customers;
using AdminOpciones.Struct.Generic;
using System.Xml.Linq;
using AdminOpciones.Struct.OpcionesXF.Asiatica;
using AdminOpciones.Recursos;
using AdminOpciones.Struct;
using AdminOpciones.OpcionesFX.Front;
using AdminOpciones.SrvArt84;
using AdminOpciones.SrvTicket84;

namespace AdminOpciones.OpcionesFX.Guardar
{    
    public delegate void SetData();
    public delegate void Delegate();

    public partial class GuardarOpcion : UserControl
    {
        #region "Variables"

        #region Var. Artículo 84
        private int numeroTicket = 0;
        private decimal correlativoIbs = 0;
        #endregion Var. Artículo 84

        public event Delegate MaskCollapsed;
        public event SetData SetData;
        public event Delegate Event_SendSave;

        public List<StructCustomers> CustomersList;
        public List<StructCodigoDescripcion> BookList;
        public List<StructCodigoDescripcion> FinancialPortFolioList;
        public List<StructCodigoDescripcion> PortFolioRulesList;
        public List<StructCodigoDescripcion> SubPortFolioRulesList;
        //PRD-3162
        public List<StructConfiguracionPortFolio> ConfiguracionPortFolioList;
        public List<StructFinancialPortFolio> FinancialPortFolioPrioridadList;
        public List<StructMonedaFormaPago> FormaDePagoList;
        //PRD_16803
        public List<StructRelacion> EstructuraRelacion;
        //PRD_12567 se agrega lista de fixing para Entrada y Salida
        public List<StructFixingData> FixingDataList = new List<StructFixingData>();
        public List<StructFixingData> FixingDataListEntrada = new List<StructFixingData>();//PRD_12567

        public XDocument xmlData;

        #region Datos GrabaciÃ³n

        #region Datos BÃ¡sicos

        public int RutCliente { get; set; }
        public int CodigoCliente { get; set; }
        public int NumeroContrato { get; set; }
        public int NumeroFolio { get; set; }
        public int MonedaNocional { get; set; }
        public int MonedaNocionalContraMoneda { get; set; }
        public int Libro { get; set; }
        public int CarteraFinanciera { get; set; }
        public string CarteraNormativa { get; set; }
        public int SubCarteraNormativa { get; set; }
        public int CodigoMonedaPrima { get; set; }
        public int FormaPagoPrima { get; set; }
        public bool ModalidadPago { get; set; }
        public string Glosa { get; set; }
        string _CodigoRelacion { get; set; }
        
        #endregion

        #region Compensacion

        public int MonedaCompensacion { get; set; }
        public int FormaPagoCompensacion { get; set; }

        #endregion

        #region EntregaFisica

        public int FormaPagoEntregaFisica { get; set; }
        public int FormaPagoContraMonedaEntregaFisica { get; set; }

        #endregion

        #region Constantes

        private const int CONST_FormaPagoCLP = 5;
        private const int CONST_FormaPagoUSD = 13;
        private const int CONST_Libro = 1;
        private const int CONST_CarteraFinanciera = 1;
        private const string CONST_CarteraNormativa = "T";
        private const int CONST_SubCarteraNormativa = 4;

        #endregion

        #endregion

        public int codigoMon1;
        public int codigoMon2;
        public int codigoMonPrima = 999; // codigo moneda prima, Inicia con CLP:999, pero cambia a USD 13 si la unidad de la prima se cambia en el front.
        private double __primaInicialML = 0;

        //MAntener el mensaje para desplegar
        public string mensajeRetorno;




        public double primaInicialML
        {
            get
            {
                return __primaInicialML;
            }
            set
            {
                __primaInicialML = value;
            }
        }
        public double primaInicial = 0;
        public double paridadPrima = 0;
        public double ResultVenta = 0;  //5843
        public bool isAsiatica = false;
        public DateTime FechaVal;
        /// <summary>
        /// PRD_16803 Para mandar dato de Nocional a Leasing??? //REVISAR CONFIRMAR
        /// </summary>
        public double NocionalFwd = 0;

        List<StructMonedaFormaPago> FormaPagoUSD;
        List<StructMonedaFormaPago> FormaPagoCLP;

        //public int monedaCompensacion = 999; // CLP

        public string Compensacion_EntregaFisica;

        //Cambio Linea Credito - DInostroza Vmetrix
        public bool isLineaPuntual = false;
         
        string Cotizacion_Afirme = "C";
        public string _Transaccion;

        #endregion

        public GuardarOpcion()
        {
            InitializeComponent();
            this.btnAceptarGuardar.IsEnabled = true;
        }

        public void Load()
        {
            try
            {
                SetData();

                #region Formas de Pago
                
                FormaPagoUSD = this.FormaDePagoList.Where(_Element => _Element.CodigoMoneda.Equals(13)).ToList();
                FormaPagoCLP = this.FormaDePagoList.Where(_Element => _Element.CodigoMoneda.Equals(999)).ToList();

                #endregion
                
                #region Datos Cliente

                var customersVarNombre = from Customer in CustomersList
                                         select Customer.Clnombre.ToString();

                var customersVarRut = from Customer in CustomersList
                                      select Customer.Clrut.ToString();

                this.autoCompleteBoxNombre.ItemsSource = customersVarNombre.ToList<string>();
                this.autoCompleteBoxRut.ItemsSource = customersVarRut.ToList<string>().Distinct<string>();
                this.comboFomaPagoAnticipo.ItemsSource = SettingFormaPago(999);
                BuscarFormaPagoDefecto(comboFomaPagoAnticipo, CONST_FormaPagoCLP);

                //alanrevisar estados E y C nuevos
                if ( globales._Estado.Equals("U") || globales._Estado.Equals("M") || globales._Estado.Equals("N") || globales._Estado.Equals("E") || globales._Estado.Equals("C"))
                {
                    _BoxRut();
                }
                else
                {
                    autoCompleteBoxRut.Text = "";
                    autoCompleteBoxNombre.Text = "";
                    comboCodigoRut.ItemsSource = null;
                }

                #endregion

                #region Setting Forma Pago

                if (ModalidadPago == true)
                {
                    #region Compensacion

                    comboFomaPagoPrimaCompensacion.ItemsSource = SettingFormaPago(CodigoMonedaPrima);

                    //PAE 20120112
                    //for(int k = 0 ; k < comboFomaPagoPrimaCompensacion.Items.Count; k++)
                    //{
                    //    if (((StructMonedaFormaPago)comboFomaPagoPrimaCompensacion.Items[k]).Codigo == "144")
                    //    {
                    //        ((StructMonedaFormaPago)comboFomaPagoPrimaCompensacion.Items[k]). = true;
                    //        break;
                    //    }
                    //}

                    if (FormaPagoPrima.Equals(0))
                    {
                        FormaPagoPrima = CodigoMonedaPrima.Equals(999) ? CONST_FormaPagoCLP : CONST_FormaPagoUSD;
                    }

                    if (globales._Estado.Equals("M"))
                    {
                        #region Setting ModificaciÃ³n

                        comboMonedaCompensacion.SelectedIndex = MonedaCompensacion == 999 ? 0 : 1;
                        comboFomaPagoCompensacionCompensacion.ItemsSource = SettingFormaPago(MonedaCompensacion);

                        BuscarFormaPagoDefecto(comboFomaPagoPrimaCompensacion, FormaPagoPrima);
                        BuscarFormaPagoDefecto(comboFomaPagoCompensacionCompensacion, FormaPagoCompensacion);

                        #endregion
                    }
                    else
                    {
                        #region Setting Ingreso

                        MonedaCompensacion = 999;
                        
                        comboMonedaCompensacion.SelectedIndex = MonedaCompensacion == 999 ? 0 : 1;
                        comboFomaPagoCompensacionCompensacion.ItemsSource = SettingFormaPago(MonedaCompensacion);

                        if (FormaPagoCompensacion.Equals(0))
                        {
                            FormaPagoCompensacion = FormaPagoCompensacion.Equals(0) ? CONST_FormaPagoCLP : FormaPagoCompensacion;
                        }

                        BuscarFormaPagoDefecto(comboFomaPagoPrimaCompensacion, FormaPagoPrima);
                        BuscarFormaPagoDefecto(comboFomaPagoCompensacionCompensacion, FormaPagoCompensacion);

                        #endregion
                    }

                    #endregion
                }
                else
                {
                    #region Entrega Fisica

                    comboFomaPagPrimaEntregaFisica.ItemsSource = SettingFormaPago(CodigoMonedaPrima);
                    comboFomaPagNocionalEntregaFisica.ItemsSource = SettingFormaPago(MonedaNocional);
                    comboFomaPagNocionalContraMonedaEntregaFisica.ItemsSource = SettingFormaPago(MonedaNocionalContraMoneda);

                    if (FormaPagoPrima.Equals(0))
                    {
                        FormaPagoPrima = CodigoMonedaPrima.Equals(999) ? CONST_FormaPagoCLP : CONST_FormaPagoUSD;
                    }

                    if (globales._Estado.Equals("M") || globales._Estado.Equals("E"))
                    {
                        #region Setting ModificaciÃ³n

                        FormaPagoEntregaFisica = FormaPagoEntregaFisica.Equals(0) ? CONST_FormaPagoUSD : FormaPagoEntregaFisica;
                        FormaPagoContraMonedaEntregaFisica = FormaPagoEntregaFisica.Equals(0) ? CONST_FormaPagoCLP : FormaPagoContraMonedaEntregaFisica;

                        BuscarFormaPagoDefecto(comboFomaPagPrimaEntregaFisica, FormaPagoPrima);
                        BuscarFormaPagoDefecto(comboFomaPagNocionalEntregaFisica, FormaPagoEntregaFisica);
                        BuscarFormaPagoDefecto(comboFomaPagNocionalContraMonedaEntregaFisica, FormaPagoContraMonedaEntregaFisica);

                        #endregion
                    }
                    else
                    {
                        #region Setting ModificaciÃ³n

                        BuscarFormaPagoDefecto(comboFomaPagPrimaEntregaFisica, FormaPagoPrima);
                        BuscarFormaPagoDefecto(comboFomaPagNocionalEntregaFisica, CONST_FormaPagoUSD);
                        BuscarFormaPagoDefecto(comboFomaPagNocionalContraMonedaEntregaFisica, CONST_FormaPagoCLP);

                        #endregion
                    }

                    #endregion
                }

                #endregion

                #region Setting ClasificaciÃ³n de Cartera

                this.comboLibro.ItemsSource = BookList;
                this.comboCarteraFinanciera.ItemsSource = FinancialPortFolioPrioridadList;
                this.comboCarteraNormativa.ItemsSource = PortFolioRulesList;
                this.comboSubCarteraNormativa.ItemsSource = SubPortFolioRulesList;

                this.comboLibro.Measure(new Size(comboLibro.ActualWidth, comboLibro.ActualHeight));
                this.comboCarteraFinanciera.Measure(new Size(comboCarteraFinanciera.ActualWidth, comboCarteraFinanciera.ActualHeight));
                this.comboCarteraNormativa.Measure(new Size(comboCarteraNormativa.ActualWidth, comboCarteraNormativa.ActualHeight));
                this.comboSubCarteraNormativa.Measure(new Size(comboSubCarteraNormativa.ActualWidth, comboSubCarteraNormativa.ActualHeight));

                this.comboFomaPagNocionalContraMonedaEntregaFisica.Measure(new Size(comboFomaPagNocionalContraMonedaEntregaFisica.ActualWidth, comboFomaPagNocionalContraMonedaEntregaFisica.ActualHeight));
                this.comboFomaPagNocionalEntregaFisica.Measure(new Size(comboFomaPagNocionalEntregaFisica.ActualWidth, comboFomaPagNocionalEntregaFisica.ActualHeight));
                this.comboFomaPagoCompensacionCompensacion.Measure(new Size(comboFomaPagoCompensacionCompensacion.ActualWidth, comboFomaPagoCompensacionCompensacion.ActualHeight));
                this.comboFomaPagoPrimaCompensacion.Measure(new Size(comboFomaPagoPrimaCompensacion.ActualWidth, comboFomaPagoPrimaCompensacion.ActualHeight));
                this.comboFomaPagPrimaEntregaFisica.Measure(new Size(comboFomaPagPrimaEntregaFisica.ActualWidth, comboFomaPagPrimaEntregaFisica.ActualHeight));

                if (globales._Estado.Equals("M") || globales._Estado.Equals("N") || globales._Estado.Equals("E"))
                {
                    #region Modificacion

                    BuscarClasificacionCarteraModifica(Libro, CarteraFinanciera, CarteraNormativa, SubCarteraNormativa);

                    #endregion
                }
                else
                {
                    #region Ingreso Contrato

                    BuscarClasificacionCartera(CONST_Libro, CONST_CarteraFinanciera, CONST_CarteraNormativa, CONST_SubCarteraNormativa);

                    #endregion
                }

                #endregion

                //PRD_16803
                CargaEstructuraRelacion();
                //Se elimina el CheckBox
                //CbxOpePAE.Visibility = Visibility.Collapsed;
            }
            catch (Exception e)
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Load: " + e.ToString());
            }
        }

        public void ShowControl(string transacction)
        {
            bool _Control = true;

            CanvasAnticipo.Visibility = Visibility.Collapsed;

            if (transacction.Equals("ANTICIPA"))
            {
                autoCompleteBoxRut.IsEnabled = false;
                comboCodigoRut.IsEnabled = false;
                autoCompleteBoxNombre.IsEnabled = false;
                CanvasCompensacion.Visibility = Visibility.Collapsed;
                CanvasEntregaFisia.Visibility = Visibility.Collapsed;
                CanvasAnticipo.Visibility = Visibility.Visible;
                _Control = false;
            }            

            if (transacction.Equals("CREACION")) //PRD-3162
            {
                _Control = true;
            }
            else if (transacction.Equals("EJERCE"))
            {
                _Control = false;
            }

            radio.IsEnabled = _Control;
            radioCotizacion.IsEnabled = _Control;
            autoCompleteBoxRut.IsEnabled = _Control;
            comboCodigoRut.IsEnabled = _Control;
            autoCompleteBoxNombre.IsEnabled = _Control;
            comboLibro.IsEnabled = _Control;
            comboCarteraFinanciera.IsEnabled = _Control;
            comboCarteraNormativa.IsEnabled = _Control;
            comboSubCarteraNormativa.IsEnabled = _Control;
            comboFomaPagoPrimaCompensacion.IsEnabled = _Control;
            comboFomaPagPrimaEntregaFisica.IsEnabled = _Control;

            comboMonedaCompensacion.IsEnabled = _Control;
            comboFomaPagoCompensacionCompensacion.IsEnabled = _Control;
            txtGlosa.IsEnabled = true;

            if (transacction.Equals("MODIFICA"))
            {
                autoCompleteBoxRut.IsEnabled = false;
                comboCodigoRut.IsEnabled = false;
                autoCompleteBoxNombre.IsEnabled = false;
                //PRD-3162
                comboLibro.IsEnabled = false;
                comboCarteraFinanciera.IsEnabled = false;
                comboCarteraNormativa.IsEnabled = false;
                comboSubCarteraNormativa.IsEnabled = false;
            }
            else if (transacction.Equals("EJERCE"))
            {
                textblockTituloPrimaCompensacion.Visibility = Visibility.Collapsed;
                borderMonedaPrimaCompensacion.Visibility = Visibility.Collapsed;
                comboFomaPagoPrimaCompensacion.Visibility = Visibility.Collapsed;

                textblockTituloPrimaEntregaFisica.Visibility = Visibility.Collapsed;
                borderMonedaPrimaEntregaFisica.Visibility = Visibility.Collapsed;
                comboFomaPagPrimaEntregaFisica.Visibility = Visibility.Collapsed;
                comboFomaPagoCompensacionCompensacion.IsEnabled = true;
            }
        }

        private List<StructMonedaFormaPago> SettingFormaPago(int moneda)
        {
            if (moneda.Equals(999))
            {
                return FormaPagoCLP;
            }
            else
            {
                return FormaPagoUSD;
            }
        }

        private void comboLibroSeleccionChange(object sender, SelectionChangedEventArgs e)
        {
            if ((!(globales._Estado.Equals("M")) && !(globales._Estado.Equals("N"))))
            {
                /** MAP: Cargar nuevamente la CarteraNormativa, deberia 
                    ejecutarse solo el changeNormativa si es que se programa **/
                // Cartera Normativa
                this.comboCarteraNormativa.ItemsSource = null;
                // Cartera Normativa

                PortFolioRulesList.Clear();
                foreach (StructConfiguracionPortFolio _Element2 in ConfiguracionPortFolioList)
                {
                    if (comboLibro.ItemsSource != null && comboLibro.SelectedItem != null)
                    {
                        if (_Element2.LibroCod == (comboLibro.SelectedItem as StructCodigoDescripcion).Codigo)
                        {
                            Boolean _EstaCN;
                            _EstaCN = false;
                            foreach (StructCodigoDescripcion _Element3 in PortFolioRulesList)
                            {
                                if (_Element3.Codigo == _Element2.CartNormCod)
                                    _EstaCN = true;
                            }
                            if (!_EstaCN)
                                PortFolioRulesList.Add(new StructCodigoDescripcion(_Element2.CartNormCod, _Element2.CartNormDesc));
                        }
                    }
                }


                // Asigna a comboCarteraNormativa
                comboCarteraNormativa.ItemsSource = PortFolioRulesList;

                // Asigna el item por defecto en el comboCarteraNormativa
                foreach (StructConfiguracionPortFolio _Element2 in ConfiguracionPortFolioList)
                {
                    if (_Element2.Prioridad == "S")
                    {
                        if (comboCarteraNormativa.ItemsSource != null)
                        {
                            for (int i = 0; i <= comboCarteraNormativa.Items.Count() - 1; i++)
                            {
                                if ((comboCarteraNormativa.Items[i] as StructCodigoDescripcion).Codigo == _Element2.CartNormCod)
                                {
                                    comboCarteraNormativa.SelectedItem = comboCarteraNormativa.Items[i];
                                }
                            }
                        }
                        // _Index = 0; MAP: no sÃƒÂ©
                        //_Index = comboCarteraNormativa.SelectedIndex;
                        //    break;  // MAP: no me gustan son como los Goto
                    }
                }

                if (comboCarteraNormativa.SelectedItem == null)
                {
                    if (comboCarteraNormativa.Items.Count != 0)
                    {
                        comboCarteraNormativa.SelectedItem = comboCarteraNormativa.Items[0];
                    }
                }
                // Cartera Normativa
            }
        }

        // Change Cartera Normativa
        private void comboCarteraNormativaSeleccionChange(object sender, SelectionChangedEventArgs e)
        {
            //   /** MAP: Cargar nuevamente la SubCarteraNormativa  **/

            if ((!(globales._Estado.Equals("M")) && !(globales._Estado.Equals("N"))))
            {
                // Sub Cartera  Normativa
                this.comboSubCarteraNormativa.ItemsSource = null;
                // Sub Cartera Normativa

                SubPortFolioRulesList.Clear();
                foreach (StructConfiguracionPortFolio _Element2 in ConfiguracionPortFolioList)
                {
                    if (comboLibro.SelectedItem != null && comboCarteraNormativa.SelectedItem != null)
                    {
                        if ((_Element2.LibroCod == (comboLibro.SelectedItem as StructCodigoDescripcion).Codigo)
                            &&
                            (_Element2.CartNormCod == (comboCarteraNormativa.SelectedItem as StructCodigoDescripcion).Codigo))
                        {
                            Boolean _EstaSCN;
                            _EstaSCN = false;
                            foreach (StructCodigoDescripcion _Element3 in SubPortFolioRulesList)
                                if (_Element3.Codigo == _Element2.SubCartNormCod) _EstaSCN = true;
                            if (!_EstaSCN)
                                SubPortFolioRulesList.Add(new StructCodigoDescripcion(_Element2.SubCartNormCod, _Element2.SubCartNormDesc));
                        }
                    }
                }

                // Asigna a comboCarteraNormativa
                comboSubCarteraNormativa.ItemsSource = null;
                comboSubCarteraNormativa.ItemsSource = SubPortFolioRulesList;

                // Asigna el item por defecto en el comboCarteraNormativa
                foreach (StructConfiguracionPortFolio _Element2 in ConfiguracionPortFolioList)
                {
                    if (_Element2.Prioridad == "S")
                    {
                        if (comboSubCarteraNormativa.ItemsSource != null)
                        {
                            for (int i = 0; i <= comboSubCarteraNormativa.Items.Count() - 1; i++)
                            {
                                if ((comboSubCarteraNormativa.Items[i] as StructCodigoDescripcion).Codigo == _Element2.SubCartNormCod)
                                {
                                    comboSubCarteraNormativa.SelectedItem = comboSubCarteraNormativa.Items[i];
                                }
                            }
                        }
                        // _Index = 0; MAP: no sÃƒÂ©
                        //_Index = comboCarteraNormativa.SelectedIndex;
                        //    break;  // MAP: no me gustan son como los Goto
                    }
                }
                if (comboSubCarteraNormativa.SelectedItem == null)
                {
                    if (comboSubCarteraNormativa.Items.Count != 0)
                    {
                        comboSubCarteraNormativa.SelectedItem = comboSubCarteraNormativa.Items[0];
                    }
                }
            }
        }
        //* Change Cartera Normativa

        private void BuscarClasificacionCartera(int libro, int carteraFinanciera, string carteraNormativa, int subCarteraNormativa)
        {
            int _Index = -1;

            this.comboCarteraFinanciera.ItemsSource = null;
            this.comboCarteraFinanciera.ItemsSource = FinancialPortFolioPrioridadList;

            #region Cartera Financiera

            _Index = -1;

            if (comboCarteraFinanciera != null)
            {

                foreach (StructFinancialPortFolio _Element in FinancialPortFolioPrioridadList)
                {

                    if (_Element.Prioridad == "S")
                    {
                        comboCarteraFinanciera.SelectedItem = _Element;
                        _Index = 0;
                    }

                    break;
                }

                if (FinancialPortFolioPrioridadList.Count != 0)
                {
                    if (_Index != 0)
                    {
                        comboCarteraFinanciera.SelectedIndex = 0;
                    }
                }


            }

            #endregion

            #region Limpia y Carga Combos Libro Cartera SubCartera
            this.comboLibro.ItemsSource = null;
            this.comboLibro.ItemsSource = BookList;
            this.comboCarteraNormativa.ItemsSource = null;
            this.comboCarteraNormativa.ItemsSource = PortFolioRulesList;
            this.comboSubCarteraNormativa.ItemsSource = null;
            this.comboSubCarteraNormativa.ItemsSource = SubPortFolioRulesList;
            #endregion

            foreach (StructConfiguracionPortFolio _Element2 in ConfiguracionPortFolioList)
            {
                // Libro
                foreach (StructCodigoDescripcion _Element in BookList)
                    if (_Element2.Prioridad == "S" && _Element2.LibroCod == _Element.Codigo)
                    {
                        comboLibro.SelectedItem = _Element;
                        _Index = 0;
                        break;
                    }
            }
            ////PRD-3162
        }

        private void BuscarClasificacionCarteraModifica(int libro, int carteraFinanciera, string carteraNormativa, int subCarteraNormativa)
        {
            int _Index = -1;

            if (comboLibro != null)
            {
                foreach (StructCodigoDescripcion _Element in BookList)
                {
                    if (int.Parse(_Element.Codigo) == libro)
                    {
                        comboLibro.SelectedItem = _Element;
                        _Index = 0;
                        break;
                    }
                }

                if (_Index != 0)
                {
                    comboLibro.SelectedIndex = 0;
                }
            }

            if (comboCarteraFinanciera != null)
            {
                foreach (StructFinancialPortFolio _Element in FinancialPortFolioPrioridadList)
                {
                    if (int.Parse(_Element.Codigo) == carteraFinanciera)
                    {
                        comboCarteraFinanciera.SelectedItem = _Element;
                        _Index = 0;
                        break;
                    }
                }

                if (_Index != 0)
                {
                    comboCarteraFinanciera.SelectedIndex = 0;
                }
            }

            if (comboCarteraNormativa != null)
            {
                foreach (StructCodigoDescripcion _Element in PortFolioRulesList)
                {
                    if ((_Element.Codigo) == carteraNormativa)
                    {
                        comboCarteraNormativa.SelectedItem = _Element;
                        _Index = 0;
                        break;
                    }
                }

                if (_Index != 0)
                {
                    comboCarteraNormativa.SelectedIndex = 0;
                }
            }

            if (comboSubCarteraNormativa != null)
            {
                foreach (StructCodigoDescripcion _Element in SubPortFolioRulesList)
                {
                    if (int.Parse(_Element.Codigo) == subCarteraNormativa)
                    {
                        comboSubCarteraNormativa.SelectedItem = _Element;
                        _Index = 0;
                        break;
                    }
                }

                if (_Index != 0)
                {
                    comboSubCarteraNormativa.SelectedIndex = 0;
                }
            }
        }

        private void BuscarFormaPagoDefecto(ComboBox comboFormaPago, int formapago)
        {
            int _Index = -1;
            if (comboFormaPago != null)
            {
                List<StructMonedaFormaPago> _List = (List<StructMonedaFormaPago>)comboFormaPago.ItemsSource;

                foreach (StructMonedaFormaPago _Element in _List)
                {
                    if (int.Parse(_Element.Codigo) == formapago)
                    {
                        comboFormaPago.SelectedItem = _Element;
                        _Index = 0;
                        break;
                    }
                }

                if (_Index != 0)
                {
                    comboFormaPago.SelectedIndex = 0;
                }
            }
        }

        private void _BoxRut()
        {
            var codigosRutVar = from CodigoItem in CustomersList.Where(x => int.Parse(x.Clrut) == RutCliente).ToList<StructCustomers>()
                                select CodigoItem.Clcodigo.ToString();

            List<StructCustomers> _ClientList = CustomersList.Where(x => int.Parse(x.Clrut) == RutCliente && int.Parse(x.Clcodigo) == CodigoCliente).ToList<StructCustomers>();

            //alanrevisar varias cosas:
            //la primera pasada viene la lista vacia al parecer
            //en certificacion habia un usuario con rut 0
            if (_ClientList.Count > 0)
            {
                StructCustomers _Cliente = _ClientList[0];

                autoCompleteBoxRut.Text = _Cliente.Clrut;

                this.comboCodigoRut.ItemsSource = null;
                this.comboCodigoRut.UpdateLayout();
                this.comboCodigoRut.ItemsSource = codigosRutVar.ToList<string>();
                this.comboCodigoRut.SelectedItem = _Cliente.Clcodigo.ToString();

                this.autoCompleteBoxNombre.Text = _Cliente.Clnombre;
            }
        }

        // CER 
        public void event_btnAceptar_Click(object sender, RoutedEventArgs e)
        {
            //PRD_16803
            //ASVG_20141020 Se comenta funcionalidad ya que proyecto queda Stand-By por fusión.
            //InvocaValidaLeasing();  

          //  if(isLineaPuntual){
          //      llamadoWSIDD("8100264","1","640","100","2000","US.D");
          //  }


            //revisar, está repetido.
            //Prd_16803
            try
            {
                _CodigoRelacion = ((AdminOpciones.Struct.StructRelacion)(this.ComboEstructRelacion.SelectedItem)).CodigoRelacion.ToString();
            }
            catch (NullReferenceException)
            {
                _CodigoRelacion = "-1";
            }

            //if (ValidaIngresoRelacionado())
            //{
            //    System.Windows.Browser.HtmlPage.Window.Alert("Debe Ingresar N° Leasing y N° de Bien.");
            //    return;
            //}

            //Valida Ingreso solo Numeros Req_7274
            if (autoCompleteBoxRut.Text != "")
            {
                ValidaNumeros();
            }
            this.btnCancelarGuardar.IsEnabled = false;
            this.btnAceptarGuardar.IsEnabled = false;
            //Valida que no se ingrese el digito verificador en el RUT
            if (this.comboCodigoRut.SelectedIndex != -1)
            {
                if ((this.autoCompleteBoxRut.Text != ""
                    && this.comboCodigoRut.SelectedIndex >= 0
                    && this.comboCarteraFinanciera.SelectedIndex >= 0
                    && this.comboCarteraNormativa.SelectedIndex >= 0
                    && this.comboLibro.SelectedIndex >= 0
                    && this.comboSubCarteraNormativa.SelectedIndex >= 0
					&& ((Compensacion_EntregaFisica.Equals("E")
						&& this.comboFomaPagNocionalEntregaFisica.SelectedIndex >= 0
						&& this.comboFomaPagPrimaEntregaFisica.SelectedIndex >= 0
						&& this.comboFomaPagNocionalContraMonedaEntregaFisica.SelectedIndex >= 0
						)
						|| this.Compensacion_EntregaFisica.Equals("C")
						&& this.comboFomaPagoCompensacionCompensacion.SelectedIndex >= 0
						&& this.comboFomaPagoPrimaCompensacion.SelectedIndex >= 0
						)
					)
                    || globales._Estado == "U"
                    || globales._Estado == "N"  // Esperar la Preparacion  MAP
                   )
                {
                    #region Validación PAE BONIFICADO
                    if (this.Compensacion_EntregaFisica.Equals("C")
						&& ((StructMonedaFormaPago)comboFomaPagoPrimaCompensacion.SelectedItem).Codigo == "144"
                        && CanvasPae.Visibility == Visibility.Visible) 
                    {
                        System.Windows.Browser.HtmlPage.Window.Alert("Advertencia: El tipo de Pago: PAE Bonificado corresponde solo a una estructura PAE.");
                        comboFomaPagoPrimaCompensacion.SelectedIndex = 4;
                        comboFomaPagoPrimaCompensacion.Focus();
                        this.btnAceptarGuardar.IsEnabled = true;
                        this.btnCancelarGuardar.IsEnabled = true;
                    }
                    else
                    {
                        if (this.Compensacion_EntregaFisica.Equals("C")
							&& ((StructMonedaFormaPago)comboFomaPagoPrimaCompensacion.SelectedItem).Codigo == "144"
                           && CanvasPae.Visibility == Visibility.Collapsed
                           && _CodigoRelacion != "2" )//CbxOpePAE.IsChecked == false)
                        {
                            System.Windows.Browser.HtmlPage.Window.Alert("Advertencia: Solo se puedede ocupar tipo de pago PAE Bonificado al asociar la operación a PAE.");
                            comboFomaPagoPrimaCompensacion.SelectedIndex = 4;
                            comboFomaPagoPrimaCompensacion.Focus();
                            this.btnAceptarGuardar.IsEnabled = true;
                            this.btnCancelarGuardar.IsEnabled = true;
                        }
                        else
                        {
                            if (this.comboCodigoRut.SelectedItem != null || globales._Estado == "U" || globales._Estado == "N")
                            {
                                GenerateXml();
                                Articulo84Habilitado();
                                //Insertar(xmlData);
                                //this.Visibility = Visibility.Collapsed;
                            }
                            else
                            {
                                System.Windows.Browser.HtmlPage.Window.Alert("Advertencia: No ha seleccionado el cliente.");
                                this.btnAceptarGuardar.IsEnabled = true;
                                this.btnCancelarGuardar.IsEnabled = true;
                            }
                        }
                    }
                    #endregion                  
                }
                else
                {
                    //PRD-3162
                    if (this.comboCarteraFinanciera.SelectedItem == null || this.comboLibro.SelectedItem == null || this.comboCarteraNormativa.SelectedItem == null || comboSubCarteraNormativa.SelectedItem == null)
                    {
                        System.Windows.Browser.HtmlPage.Window.Alert("Advertencia: Verificar asignación de carteras o libro para Usuario.");
                        this.btnAceptarGuardar.IsEnabled = true;
                        this.btnCancelarGuardar.IsEnabled = true;
                    }
                    else
                    {
                        this.btnAceptarGuardar.IsEnabled = true;
                        this.btnCancelarGuardar.IsEnabled = true;
                    }
                }
            }
            else
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Advertencia: El Rut ingresado no debe contener el dígito verificador.");
                this.btnCancelarGuardar.IsEnabled = true;
                this.btnAceptarGuardar.IsEnabled = true;
            }
        }

        #region Artículo 84

        /// <summary>
        /// Llama a al servicio para saber si se debe ejecutar el control de artículo 84
        /// </summary>
        private void Articulo84Habilitado() {
            SrvDetalles.WebDetallesSoapClient client = wsGlobales.Detalles;
            client.Activar84Completed += new EventHandler<SrvDetalles.Activar84CompletedEventArgs>(client_Activar84Completed);
            client.Activar84Async();
        }

        /// <summary>
        /// Verifica que esté habilitado el control de artículo 84 en la base de datos y lo omite si está deshabilitado
        /// Se obvia el Art. 84 si se está ejerciendo algún derivado.
        /// Si operación corresponde a cotización, no debe imputar Art84.
        /// </summary>
        void client_Activar84Completed(object sender, SrvDetalles.Activar84CompletedEventArgs e) {
            if (e.Result && ObtenerCodigoTransaccion() != "3" && radioCotizacion.IsChecked == false) {
                ObtenerTicketIBS();
            }
            else {
                Insertar(xmlData);
            }
        }

        /// <summary> 
        /// Se conecta con el servicio para obtener un nuevo ticket
        /// </summary>
        private void ObtenerTicketIBS() {
            txtError.Text = "Obteniendo ticket...";
            //para evitar que agregue un ticket anterior
            numeroTicket = 0;

            WSTicketSoapClient client = wsGlobales.Ticket84;
            client.ConsultaNumeroTicketCompleted += new EventHandler<ConsultaNumeroTicketCompletedEventArgs>(client_ConsultaNumeroTicketCompleted);
            client.ConsultaNumeroTicketAsync();
        }

        /// <summary>
        /// Obtiene un ticket para enviar a webservice de artículo 84 y revisa si existe el número de contrato,
        /// De existir, solicita obtener el número correlativo del ibs perteneciente al contrato, de lo contrario consulta al ibs por la operación
        /// </summary>
        private void client_ConsultaNumeroTicketCompleted(object sender, ConsultaNumeroTicketCompletedEventArgs e) {
            try {
                if (e.Error != null) {
                    ControlarAlerta(e, "ConsultaNumeroTicket");
                }
                else {
                    if (e.Result.Header.FLAG != 0) {
                        numeroTicket = (int)e.Result.Data.TICKET;
                        if (globales._NumContrato != 0) {
                            ObtenerNumerosIBS();
                        }
                        else {
                            correlativoIbs = 0;
                            ConsultarIBS();
                        }
                    }
                    else {
                        ControlarAlerta("Error al obtener el ticket");
                    }
                }
            }
            catch (Exception ex) {
                ControlarAlerta("Error: " + ex.Message);
            }
        }

        /// <summary>
        /// Se conecta con el servicio para recuperar el número correlativo de IBS de la operación
        /// </summary>
        private void ObtenerNumerosIBS() {
            txtError.Text = "Obteniendo correlativo IBS...";

            SrvNumeroIBSPorOperacion84.WSNumeroIBSporOperacionSoapClient client = wsGlobales.NumeroIBSPorOperacion84;
            client.ObtenerNumeroIBSCompleted += new EventHandler<SrvNumeroIBSPorOperacion84.ObtenerNumeroIBSCompletedEventArgs>(client_ObtenerNumeroIBSCompleted);
            client.ObtenerNumeroIBSAsync(globales._NumContrato, "OPT");
        }

        /// <summary>
        /// Recupera el correlativo del IBS para modificar o eliminar una operación, junto con el ticket anterior.
        /// De no existir problemas, solicita la consulta de la operación para el IBS
        /// </summary>
        /// <remarks>Puede que la operación a modificar no exista en el IBS, por lo que ingresa la operación ignorando el Art. 84</remarks>
        private void client_ObtenerNumeroIBSCompleted(object sender, SrvNumeroIBSPorOperacion84.ObtenerNumeroIBSCompletedEventArgs e) {
            try {
                if (e.Error != null) {
                    ControlarAlerta(e, "ObtenerNumeroIBS");
                }
                else {
                    if (e.Result.Header.FLAG != 0 && e.Result.Data.Length > 0) {
                        if (e.Result.Data[0].TICKET > 1 && e.Result.Data[0].NRO_IBS > 1) {
                            correlativoIbs = e.Result.Data[0].NRO_IBS;
                        }
                        ConsultarIBS();
                    }
                    else {
                        ControlarAlerta(e.Result.LOG.EVENTO_APLICACION[0].ERROR);
                    }
                }
            }
            catch (Exception ex) {
                ControlarAlerta(ex.Message);
            }
        }

        /// <summary>
        /// Recupera los datos y envía la consulta al IBS para control de Artículo 84
        /// </summary>
        private void ConsultarIBS() {
            txtError.Text = "Consultando IBS...";

            //asignación de variables para IBS
            string usuario = globales._Usuario;
            string rutClie = autoCompleteBoxRut.Text;
            string codClie = comboCodigoRut.SelectedItem.ToString();
            string mtm = TruncarMTM();
            string duracion = ObtenerDuracion();
            string codigoTransaccion = ObtenerCodigoTransaccion();
            string codigoDeuda = ObtenerCodigoDeuda();
            string nocional = ObtenerNocional();

            //se llama al servicio del art. 84
            WSArticulo84SoapClient client = wsGlobales.Articulo84;
            client.ConsultaIBSParCompleted += new EventHandler<ConsultaIBSParCompletedEventArgs>(client_ConsultaIBSParCompleted);
            client.ConsultaIBSParAsync("3", usuario, rutClie, codClie, "USD", nocional, mtm, "0", "1", correlativoIbs.ToString(), codigoDeuda, codigoTransaccion, "MD01", "160", "A", "OPT", numeroTicket.ToString(), duracion, "OPT");
        }
        
        /// <summary>
        /// Verifica el cumplimiento del art. 84 y la correcta ejecución del servicio, luego solicita la grabación de la operación si corresponde
        /// </summary>
        private void client_ConsultaIBSParCompleted(object sender, ConsultaIBSParCompletedEventArgs e) {
            try {
                if (e.Error != null) {
                    ControlarAlerta(e, "ConsultaIBSPar");
                }
                else {
                    if (e.Result.Data.Length < 1) {
                        ControlarAlerta(e.Result);
                    }
                    else {
                        if (e.Result.Data[0].flagCumplimiento == "S") {
                            correlativoIbs = Convert.ToDecimal(e.Result.Data[0].correlativoIngresoIBS);
                            txtError.Text = string.Format("Operación aceptada por IBS, grabando...");
                            #if debugcarlos
                            ControlarAlerta(e.Result);
                            #endif  
                            Insertar(xmlData);
                        }
                        else {
                            ControlarAlerta(e.Result);
                            AgregarOperacionTicket(0, 0);
                        }
                    }
                }
            }
            catch (Exception ex) {
                ControlarAlerta(ex.Message);
            }
        }
        
        #region Seteadores Variables Artículo 84

        /// <summary>
        /// Revisa de qué forma imputan las operaciones y envía el código acorde según el anexo de IBS
        /// 1.- Deuda directa
        /// 6.- Forward
        /// </summary>
        /// <returns>Código de deuda solicitado por IBS</returns>
        private string ObtenerCodigoDeuda() {
            //ASVG_20150226 Ivan Ramos solicita informar todas las Opciones como Forward, ya que en IBS no existe el producto Opciones.
            return "6";
            /*
            if (xmlData.Element("Datos").Element("encContrato").Element("Estructura").Attribute("MoCodEstructura").Value == "8" || xmlData.Element("Datos").Element("encContrato").Element("Estructura").Attribute("MoCodEstructura").Value == "13") {
                return "6";
            }
            else {
                
                return "1";
            }
             * */
        }

        /// <summary>
        /// se revisa el tipo de acción a realizar y se devuelve según anexo de IBS
        /// 1.- Agrega nueva operación
        /// 3.- Modifica una operación
        /// 4.- Elimina o termina una operación
        /// </summary>
        /// <remarks>El ejercicio puede ser 3 si ejerce parcialmente, o 4 si se ejerce completo</remarks>
        /// <returns>String con el código de transacción</returns>
        private string ObtenerCodigoTransaccion() {
            if (_Transaccion == "ANULA" || _Transaccion == "ANTICIPA") {
                return "4";
            }
            else if (_Transaccion == "EJERCE") {
                double montoTotal = Convert.ToDouble(xmlData.Element("Datos").Element("encContrato").Element("Ejercer").Attribute("Nocional").Value);
                double montoEjercido = Convert.ToDouble(xmlData.Element("Datos").Element("detContrato").Element("Subyacente").Attribute("MoMontoMon1").Value);
                if (montoTotal == montoEjercido) {
                    return "4";
                }
                else {
                    return "3";
                }
            }
            else if (_Transaccion == "MODIFICA") {
                return "3";
            }
            else {
                return "1";
            }
        }

        /// <summary>
        /// Busca el monto nocional mayor dentro del XML de guardado
        /// </summary>
        /// <returns>Monto nocional mayor</returns>
        private string ObtenerNocional() {
            return xmlData.Element("Datos").Elements("detContrato").Elements("Subyacente").Max(l => (l.Attribute("MoMontoMon1").Value));
        }

        /// <summary>
        /// Quita los decimales del MTM para prevenir caída de ibs
        /// </summary>
        /// <returns>String con el valor MTM sin decimales</returns>
        private string TruncarMTM() {
            string mtmParcial = xmlData.Element("Datos").Element("encContrato").Element("MtM").Attribute("MoVr").Value;
            if (mtmParcial.Contains(',')) {
                int posComa = xmlData.Element("Datos").Element("encContrato").Element("MtM").Attribute("MoVr").Value.IndexOf(',');
                return mtmParcial.Substring(0, posComa);
            }
            else {
                return mtmParcial;
            }

        }

        /// <summary>
        /// Obtiene la diferencia entre las fechas final e inicial del contrato
        /// </summary>
        /// <returns>Duración del contrato en días</returns>
        private string ObtenerDuracion() {
            DateTime fechaFinal = xmlData.Element("Datos").Elements("detContrato").Elements("Vencimiento").Max(l => DateTime.Parse(l.Attribute("MoFechaVcto").Value));
            DateTime fechaInicinal = DateTime.Parse(xmlData.Element("Datos").Element("encContrato").Element("Contrato").Attribute("MoFechaContrato").Value.ToString());

            return (fechaFinal - fechaInicinal).TotalDays.ToString();
        }

        #endregion Seteadores Variables Artículo 84

        /// <summary>
        /// Se obtiene el número de operación desde el mensaje enviado por el webservice
        /// </summary>
        /// <param name="mensaje">Mensaje entregado al terminar de grabar la operación</param>
        /// <returns>Número de la operación extraída del mensaje</returns>
        private int GetNumeroOperacion(string mensaje) {
            int inicioNumOp = (mensaje.ElementAt(mensaje.IndexOf('°')+1).Equals(' ')) ? mensaje.IndexOf('°') + 2 : mensaje.IndexOf('°') + 1;
            string partialMsj = mensaje.Substring(inicioNumOp);
            int finNumOp = partialMsj.IndexOf(' ');
            string msjFinal = mensaje.Substring(inicioNumOp, finNumOp);
            return Convert.ToInt32(msjFinal);
        }

        /// <summary>
        /// Conecta con el servicio para ingresar el ticket, el número de la operación y el correlativo del IBS y el sistema en los registros
        /// </summary>
        /// <param name="operacion">N° de operación realizada en la pantalla</param>
        /// <param name="correlativoIngresoIBS"> Correlativo entregado por el IBS al terminar la simulación</param>
        private void AgregarOperacionTicket(int operacion, decimal correlativoIngresoIBS) {
            txtError.Text = "Registrando transacción";

            var client = wsGlobales.Operaciones84;
            client.Actualizar_Operaciones_A_TicketCompleted += new EventHandler<SrvOperaciones84.Actualizar_Operaciones_A_TicketCompletedEventArgs>(client_Actualizar_Operaciones_A_TicketCompleted);
            client.Actualizar_Operaciones_A_TicketAsync(numeroTicket, operacion, "OPT", correlativoIngresoIBS);
        }

        /// <summary>
        /// termina la ejecución del artículo 84
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        void client_Actualizar_Operaciones_A_TicketCompleted(object sender, SrvOperaciones84.Actualizar_Operaciones_A_TicketCompletedEventArgs e) {
            if (e.Error != null) {
                ControlarAlerta(e, "Actualizar_Operaciones_A_Ticket");
            }
            else {
                txtError.Text = "Finalizado";
            }
        }

        #region control de alertas Artíuclo 84

        /// <summary>
        /// Muestra los errores que se puedan producir durante la cadena de llamadas al IBS
        /// Data.Length < 0 Indica que existió un error al contactar al IBS
        /// Si el flag de cumplimiento es "N" la operación fue rechazada
        /// Si existen otros problemas muestra los detalles por alerta.
        /// </summary>
        /// <param name="xmlIbs">Objeto del IBS que contiene los errores</param>
        private void ControlarAlerta(Return_XML_IBS xmlIbs) {

            string final = string.Empty;
            if (xmlIbs.Data.Length < 1) {
                final = "Error en IBS: " + xmlIbs.LOG.EVENTO_APLICACION[0].ERROR + " "/* + xmlIbs.LOG.EVENTO_APLICACION[0].METODO*/;
            }
            else if (xmlIbs.Data[0].flagCumplimiento == "N") {
                final = "No se permite esta operación para este cliente.\nRazón: ";
                final += xmlIbs.Data[0].footer[0].errors[0].code + " " + xmlIbs.Data[0].footer[0].errors[0].description;
                try {
                    foreach (var alerta in xmlIbs.Data[0].alerta) {
                        final = "\nAlerta: " + alerta.descripcionAlerta;
                    }
                }
                catch (Exception e) {

                }
            }
            else {
                try {
                    final = "Error: Problema al conectar ";// +xmlIbs.LOG.EVENTO_APLICACION[0].ERROR;
                    //foreach (var alerta in xmlIbs.Data[0].alerta) {
                    //    final += "\n" + alerta.descripcionAlerta;
                    //}
                }
                catch (Exception e) {

                }
            }
            #if debugcarlos
            try {
                final += string.Format("\nAddon: {0}\nMTM: {1}\nNocional: {2}\nMonto IBS: {3}", xmlIbs.Data[0].CalculosIBS.ADDON, xmlIbs.Data[0].CalculosIBS.MONTO_MTM, xmlIbs.Data[0].CalculosIBS.MONTO_OPERACION, xmlIbs.Data[0].CalculosIBS.MONTO_AFECTO);
            }
            catch (System.Exception ex) {
                //Oppa gangnam style
            }
            #endif
            System.Windows.Browser.HtmlPage.Window.Alert(final);
            txtError.Text = final.Replace("\n", ";");
            btnCancelarGuardar.IsEnabled = true;
        }

        /// <summary>
        /// Muestra los errores que puedan ocurrir si los servicios entregan error, bajo los códigos
        /// 1000: Por defecto para un servicio no controlado
        /// 1001: Error de solicitud de ticket (ConsultaNumeroTicket)
        /// 1002: Error en solicitud de N° IBS (ObtenerNumeroIBS)
        /// 1003: Error al consultar IBS (ConsultaIBSPar)
        /// 1004: Error al grabar operación (InsertOption)
        /// 1005: Error al grabar el ticket utilizado junto con los datos de la operación (Actualizar_Operaciones_A_Ticket)
        /// </summary>
        /// <param name="e">objeto retornado por el servicio con problemas</param>
        /// <param name="nombreServicio">Servicio en el que ocurre el problema</param>
        private void ControlarAlerta(System.ComponentModel.AsyncCompletedEventArgs e, string nombreServicio) {
            string mensaje = string.Empty;
            if (numeroTicket > 0 && nombreServicio != "Actualizar_Operaciones_A_Ticket") {
                AgregarOperacionTicket(0, 0);
            }
            mensaje = "Ocurrió un error durante la ejecución del proceso, operación abortada. \nError: ";
            switch (nombreServicio) {
                case "ConsultaNumeroTicket":
                    mensaje += "1001";
                    break;
                case "ObtenerNumeroIBS":
                    mensaje += "1002";
                    break;
                case "ConsultaIBSPar":
                    mensaje += "1003";
                    break;
                case "InsertOption":
                    mensaje += "1004";
                    break;
                case "Actualizar_Operaciones_A_Ticket":
                    mensaje += "1005";
                    break;
                default:
                    mensaje += "1000";
                    break;
            }
            System.Windows.Browser.HtmlPage.Window.Alert(mensaje);
            txtError.Text = mensaje;
            btnCancelarGuardar.IsEnabled = true;
        }

        /// <summary>
        /// Muestra los errores que se puedan producir durante la cadena de llamadas al IBS
        /// </summary>
        /// <param name="mensaje">Mensaje a mostrar</param>
        private void ControlarAlerta(string mensaje) {
            if (numeroTicket != 0) {
                AgregarOperacionTicket(0, 0);
            }
            System.Windows.Browser.HtmlPage.Window.Alert(mensaje);
            txtError.Text = mensaje;
            btnCancelarGuardar.IsEnabled = true;
        }
        #endregion control de alertas Artíuclo 84

        #endregion Artículo 84

        private void Insertar(XDocument xdcInsertar)
        {
            txtError.Text = "Ingresando operación...";

            SrvBDOpciones.BDOpcionesSoapClient _SrvBDOpciones = wsGlobales.BDOpciones;// new AdminOpciones.SrvBDOpciones.BDOpcionesSoapClient();
            _SrvBDOpciones.InsertOptionCompleted += new EventHandler<AdminOpciones.SrvBDOpciones.InsertOptionCompletedEventArgs>(_SrvBDOpciones_InsertOptionCompleted);
            _SrvBDOpciones.InsertOptionAsync(xdcInsertar.ToString(), globales._Usuario, globales._Estado, NumeroFolio, NumeroContrato,globales.FechaProceso,globales._Turing);
        }

        void _SrvBDOpciones_InsertOptionCompleted(object sender, AdminOpciones.SrvBDOpciones.InsertOptionCompletedEventArgs e)
        {
            mensajeRetorno = "";
            MaskCollapsed();
            Event_SendSave();
            if (e.Error != null) {
                ControlarAlerta(e, "InsertOption");
            }
            else {
                ///Si no se permite art. 84 se debe omitir la insersión del ticket 0
                if (numeroTicket > 0) {
                    int numOp = GetNumeroOperacion(e.Result);
                    AgregarOperacionTicket(numOp, correlativoIbs);
                }



                if (_Transaccion.Equals("ANULA") || _Transaccion.Equals("CREACION") ){
                    if (e.Result.ToString().Contains("Contrato") )
                    {
                        //MANEJO DE OPERACION IDD (GUARDADO) 
                        int numOp = GetNumeroOperacion(e.Result);
                        mensajeRetorno = e.Result;
                        ObtenerOperacionIDD("OPT", numOp, 0);

                    }
                    else
                    {
                        txtError.Text = "finalizado";
                        System.Windows.Browser.HtmlPage.Window.Alert(e.Result);
                    }

                }else{
                        txtError.Text = "finalizado";
                        System.Windows.Browser.HtmlPage.Window.Alert(e.Result);
                }
            }
        }


        private void ObtenerOperacionIDD(string Aplicativo, int numOp, int correlativo){
            txtError.Text = "Obteniendo Valores IDD...";

            SrvBDOpciones.BDOpcionesSoapClient _SrvBDOpciones = wsGlobales.BDOpciones;// new AdminOpciones.SrvBDOpciones.BDOpcionesSoapClient();
            _SrvBDOpciones.getTransactionIDDCompleted += new EventHandler<AdminOpciones.SrvBDOpciones.getTransactionIDDCompletedEventArgs>(_SrvBDOpciones_getTransactionIDDCompleted);
            _SrvBDOpciones.getTransactionIDDAsync(Aplicativo, Aplicativo, numOp, numOp, correlativo);

        }

        void _SrvBDOpciones_getTransactionIDDCompleted(object sender, AdminOpciones.SrvBDOpciones.getTransactionIDDCompletedEventArgs e)
        {
            if (e.Error != null)
            {
                ControlarAlerta(e, "GetIDD");
            }
            else
            {
                int numOp = GetNumeroOperacion(mensajeRetorno);
                char[] ch = Environment.NewLine.ToCharArray();
                string[] result = e.Result.ToString().Split(ch[0]);
                if (result.Length == 1)
                    result = e.Result.ToString().Split(ch[1]);




                if (isLineaPuntual)
                {
                    //LLamado para actualizar Tabla cuando es Linea Puntual
                    ActualizaOperacionIDD(205, "OPT", numOp, 0, 0, "Linea Pendiente Toma Puntual, debe ser autorizada por administrador de Creditos.", 0);
                }
                else
                {
                    string clientAS400 = result[0];
                    string codigoCliente = result[1];
                    string facility = result[2];
                    string plazoOP = result[3];
                    string montoLinea = result[4];
                    string monedaAS400 = result[6];
                    string numIDD = result[7];

                    if (_Transaccion.Equals("ANULA") && numIDD == "0")
                    {
                        //NO SE TOMO LINEA POR ENDE NO SE VA AL WS 
                        System.Windows.Browser.HtmlPage.Window.Alert(mensajeRetorno);
                    }
                    else
                    {
                        //Realizar llamado IDD - Corregir Cuando se logre conexion con el servicio
                        llamadoWSIDD(clientAS400, codigoCliente, facility, plazoOP, montoLinea, monedaAS400);
                        //se debe comentar el llamado a la actualizacion ya que eso se debe hacer en la vuelta de IDD.
                      //  ActualizaOperacionIDD(200, "OPT", numOp, 0, 987654, "IDD Correcto (DUMMY) ", 1);
                    }


                }
                

               


                
            }
        }


        private void ActualizaOperacionIDD(int statusIDD, string Aplicativo, int numOp, int correlativo, int numeroIDD, string mensaje, int controlLinea)
        {
            txtError.Text = "Actualizando Valores IDD...";

            SrvBDOpciones.BDOpcionesSoapClient _SrvBDOpciones = wsGlobales.BDOpciones;// new AdminOpciones.SrvBDOpciones.BDOpcionesSoapClient();
            //_SrvBDOpciones.getTransactionIDDCompleted += new EventHandler<AdminOpciones.SrvBDOpciones.getTransactionIDDCompletedEventArgs>(_SrvBDOpciones_ActualizaOperacionIDDCompleted);
            _SrvBDOpciones.updateTransaccionIDDCompleted += new EventHandler<AdminOpciones.SrvBDOpciones.updateTransaccionIDDCompletedEventArgs>(_SrvBDOpciones_ActualizaOperacionIDDCompleted); 
            _SrvBDOpciones.updateTransaccionIDDAsync(statusIDD, Aplicativo, Aplicativo, numOp, numOp, correlativo,mensaje, numeroIDD,controlLinea);

        }

        void _SrvBDOpciones_ActualizaOperacionIDDCompleted(Object sender, AdminOpciones.SrvBDOpciones.updateTransaccionIDDCompletedEventArgs e)
        {
            txtError.Text = "finalizado.";
            if(this._Transaccion.Equals("ANULA"))
                System.Windows.Browser.HtmlPage.Window.Alert(mensajeRetorno +  Environment.NewLine + " Actualizacion IDR:" + e.Result);
            else
                System.Windows.Browser.HtmlPage.Window.Alert(mensajeRetorno +  Environment.NewLine + " Actualizacion IDD :" + e.Result);
        }



        private void event_btnCancelar_Click(object sender, RoutedEventArgs e)
        {
            MaskCollapsed();
            BuscarClasificacionCartera(CONST_Libro, CONST_CarteraFinanciera, CONST_CarteraNormativa, CONST_SubCarteraNormativa);
            //PAE
            //CbxOpePAE.IsChecked = false;
            this.ComboEstructRelacion.SelectedIndex = -1;
            this.autoCompleteBoxOpLeasing.Text = "";
            this.autoCompleteBoxNumBienLeasing.Text = "";
        }

        private void GenerateXml()
        {
            int FormaPagoMon1 = 0;
            int FormaPagoMon2 = 0;
            int FormaPagoPrimaInicial = 0;
            int FormaPagoCompensacion = 0;
            int FormaPagoUnWind = 0;
            string _diasValuta;

            if (this._Transaccion == "ANTICIPA")
            {
                FormaPagoUnWind = int.Parse(((StructMonedaFormaPago)comboFomaPagoAnticipo.SelectedItem).Codigo);
                xmlData.Element("Datos").Element("encContrato").Element("MtM").Attribute("MoFormPagoUnwind").Value = FormaPagoUnWind.ToString();
            }

            if (ModalidadPago)
            {
                FormaPagoCompensacion = int.Parse(((StructMonedaFormaPago)comboFomaPagoCompensacionCompensacion.SelectedItem).Codigo);
                FormaPagoPrimaInicial = int.Parse(((StructMonedaFormaPago)comboFomaPagoPrimaCompensacion.SelectedItem).Codigo);
            }
            else
            {
                FormaPagoMon1 = int.Parse(((StructMonedaFormaPago)comboFomaPagNocionalEntregaFisica.SelectedItem).Codigo);
                FormaPagoMon2 = int.Parse(((StructMonedaFormaPago)comboFomaPagNocionalContraMonedaEntregaFisica.SelectedItem).Codigo);
                FormaPagoPrimaInicial = int.Parse(((StructMonedaFormaPago)comboFomaPagPrimaEntregaFisica.SelectedItem).Codigo);
            }

            if (this._Transaccion == "ANULA")
            {
                string RutCliente = this.autoCompleteBoxRut.Text;               
                string CodigoRutCliente = this.comboCodigoRut.SelectedItem.ToString();

                xmlData.Element("Datos").Element("encContrato").Element("Contraparte").Attribute("MoRutCliente").Value = RutCliente;
                xmlData.Element("Datos").Element("encContrato").Element("Contraparte").Attribute("MoCodigo").Value = CodigoRutCliente;
            }

            if ((this._Transaccion != "ANULA") && (this._Transaccion != "ANTICIPA"))
            {
                string _CodigoRelacion = "";// ((AdminOpciones.Struct.StructRelacion)(this.ComboEstructRelacion.SelectedItem)).CodigoRelacion.ToString(); //Prd_16803

                //Prd_16803
                //revisar, está repetido.
                //Prd_16803
                try
                {
                    _CodigoRelacion = ((AdminOpciones.Struct.StructRelacion)(this.ComboEstructRelacion.SelectedItem)).CodigoRelacion.ToString();
                }
                catch (NullReferenceException)
                {
                    _CodigoRelacion = "-1";
                }

                string RutCliente = this.autoCompleteBoxRut.Text;

                string CodigoRutCliente = this.comboCodigoRut.SelectedItem.ToString();

                Libro = int.Parse(((StructCodigoDescripcion)comboLibro.SelectedItem).Codigo);
                CarteraFinanciera = int.Parse(((StructFinancialPortFolio)comboCarteraFinanciera.SelectedItem).Codigo);
                CarteraNormativa = ((StructCodigoDescripcion)comboCarteraNormativa.SelectedItem).Codigo;
                SubCarteraNormativa = int.Parse(((StructCodigoDescripcion)comboSubCarteraNormativa.SelectedItem).Codigo);

                Glosa = this.txtGlosa.Text;

                xmlData.Element("Datos").Element("encContrato").Element("Contrato").Attribute("MoEstado").Value = this.Cotizacion_Afirme;
                xmlData.Element("Datos").Element("encContrato").Element("Contrato").Attribute("MoGlosa").Value = Glosa;

                //HORROR
                //ASVG_20111102 PRD_10449
                xmlData.Element("Datos").Element("encContrato").Element("Contrato").Attribute("MoRelacionaPAE").Value = _CodigoRelacion == "2" ? "1" : "0";//Prd_16803 this.CbxOpePAE.IsChecked.Value.Equals(true) ? "1" : "0";
                //Prd_16803
                xmlData.Element("Datos").Element("encContrato").Element("Contrato").Attribute("MoRelacionaLeasing").Value = _CodigoRelacion; //== "1" ? "0" : _CodigoRelacion; //Prd_16803 
                xmlData.Element("Datos").Element("encContrato").Element("Contrato").Attribute("MoNumeroLeasing").Value = this.autoCompleteBoxOpLeasing.Text;
                xmlData.Element("Datos").Element("encContrato").Element("Contrato").Attribute("MoNumeroBien").Value = this.autoCompleteBoxNumBienLeasing.Text;

                xmlData.Element("Datos").Element("encContrato").Element("Resultados").Attribute("MoPrimaInicial").Value = this.primaInicial.ToString();
                //5843
                xmlData.Element("Datos").Element("encContrato").Element("Resultados").Attribute("MoResultadoVentasML").Value = this.ResultVenta.ToString();

                xmlData.Element("Datos").Element("encContrato").Element("Resultados").Attribute("MoPrimaInicialML").Value = this.primaInicialML.ToString();
                xmlData.Element("Datos").Element("encContrato").Element("Resultados").Attribute("MoParMdaPrima").Value = paridadPrima.ToString();
                
                xmlData.Element("Datos").Element("encContrato").Element("Resultados").Attribute("MofPagoPrima").Value = FormaPagoPrimaInicial.ToString();

                xmlData.Element("Datos").Element("encContrato").Element("Contraparte").Attribute("MoRutCliente").Value = RutCliente;
                xmlData.Element("Datos").Element("encContrato").Element("Contraparte").Attribute("MoCodigo").Value = CodigoRutCliente;

                xmlData.Element("Datos").Element("encContrato").Element("Carteras").Attribute("MoCarteraFinanciera").Value = CarteraFinanciera.ToString();
                xmlData.Element("Datos").Element("encContrato").Element("Carteras").Attribute("MoLibro").Value = Libro.ToString();
                xmlData.Element("Datos").Element("encContrato").Element("Carteras").Attribute("MoCarNormativa").Value = CarteraNormativa;
                xmlData.Element("Datos").Element("encContrato").Element("Carteras").Attribute("MoSubCarNormativa").Value = SubCarteraNormativa.ToString();

                _diasValuta = this.FormaDePagoList.Where(x => int.Parse(x.Codigo).Equals(FormaPagoPrimaInicial)).ToList<StructMonedaFormaPago>()[0].Valor.ToString();
                xmlData.Element("Datos").Element("encContrato").Element("Resultados").Attribute("MoFechaPagoPrima").Value = this.FechaVal.ToString("dd-MM-yyyy");

                xmlData.Element("Datos").Element("encContrato").Element("Resultados").Attribute("MoCodMonPagPrima").Value = this.codigoMonPrima.ToString(); ;

                xmlData.Element("Datos").Element("encContrato").Element("Griegas").Attribute("MoMondelta").Value = this.codigoMon2.ToString();
                xmlData.Element("Datos").Element("encContrato").Element("Griegas").Attribute("MoMon_gamma").Value = this.codigoMon2.ToString();
                xmlData.Element("Datos").Element("encContrato").Element("Griegas").Attribute("MoMon_vega").Value = this.codigoMon2.ToString();
                xmlData.Element("Datos").Element("encContrato").Element("Griegas").Attribute("MoMon_vanna").Value = this.codigoMon2.ToString();
                xmlData.Element("Datos").Element("encContrato").Element("Griegas").Attribute("MoMon_volga").Value = this.codigoMon2.ToString();
                xmlData.Element("Datos").Element("encContrato").Element("Griegas").Attribute("MoMon_theta").Value = this.codigoMon2.ToString();
                xmlData.Element("Datos").Element("encContrato").Element("Griegas").Attribute("MoMon_rho").Value = this.codigoMon2.ToString();
                xmlData.Element("Datos").Element("encContrato").Element("Griegas").Attribute("MoMon_rhof").Value = this.codigoMon2.ToString();
                xmlData.Element("Datos").Element("encContrato").Element("Griegas").Attribute("MoMon_charm").Value = this.codigoMon2.ToString();
                //PRD_13575
                string TipoEstructura = xmlData.Element("Datos").Element("encContrato").Element("Estructura").Attribute("MoCodEstructura").Value;


                if (ModalidadPago)
                {
                    foreach (XElement _Item in xmlData.Descendants("detContrato"))
                    {
                        _Item.Element("Subyacente").Attribute("MoMdaCompensacion").Value = MonedaCompensacion.ToString();
                        _Item.Element("Subyacente").Attribute("MoFormaPagoComp").Value = FormaPagoCompensacion.ToString();
                        _Item.Element("Subyacente").Attribute("MoFormaPagoMon1").Value = "";
                        _Item.Element("Subyacente").Attribute("MoFormaPagoMon2").Value = "";
                    }
                }
                else
                {
                    foreach (XElement _Item in xmlData.Descendants("detContrato"))
                    {
                        // PRD_13575
                        if ((TipoEstructura.Equals("4") || TipoEstructura.Equals("5")) && Compensacion_EntregaFisica.Equals("E")
                            && _Item.Element("Estructura").Attribute("MoNumEstructura").Value.Equals("3"))
                        {
                            _Item.Element("Subyacente").Attribute("MoMdaCompensacion").Value = this.codigoMon2.ToString(); //MonedaCompensacion.ToString();
                            _Item.Element("Subyacente").Attribute("MoFormaPagoComp").Value = FormaPagoMon2.ToString();
                            _Item.Element("Subyacente").Attribute("MoFormaPagoMon1").Value = "";
                            _Item.Element("Subyacente").Attribute("MoFormaPagoMon2").Value = "";
                        }
                        else
                        {
                            _Item.Element("Subyacente").Attribute("MoMdaCompensacion").Value = "";
                            _Item.Element("Subyacente").Attribute("MoFormaPagoComp").Value = "";
                            _Item.Element("Subyacente").Attribute("MoFormaPagoMon1").Value = FormaPagoMon1.ToString();
                            _Item.Element("Subyacente").Attribute("MoFormaPagoMon2").Value = FormaPagoMon2.ToString();
                        }
                    }
                }

                // E-mail de Ivan Acevedo 20 Agosto 16:00
                double _peso = 0;
                foreach (XElement _fix in xmlData.Descendants("FixingValues"))
                {
                    _peso = double.Parse(_fix.Attribute("Peso").Value);
                    _peso = _peso * 100;
                    _fix.Attribute("Peso").Value = _peso.ToString();
                }
                // E-mail de Ivan Acevedo 20 Agosto 16:00
            }
        }

        private void autocompleteNombreLoaded(object sender, RoutedEventArgs e)
        {
            //this.autoCompleteBoxNombre.IsEnabled = true;
        }

        private void autocompleteRutLoaded(object sender, RoutedEventArgs e)
        {
            //this.autoCompleteBoxRut.IsEnabled = true;
        }

        private void autocompleteRutClosed(object sender, RoutedPropertyChangedEventArgs<bool> e)
        {
            if (this.autoCompleteBoxRut.SelectedItem != null)
            {
                var codigosRutVar = from CodigoItem in CustomersList.Where(x => x.Clrut == this.autoCompleteBoxRut.Text).ToList<StructCustomers>()
                                    select CodigoItem.Clcodigo.ToString();

                this.comboCodigoRut.ItemsSource = codigosRutVar.ToList<string>();
                this.comboCodigoRut.UpdateLayout();
                this.comboCodigoRut.Measure(new Size(comboCodigoRut.ActualWidth, comboCodigoRut.ActualHeight));

                if (comboCodigoRut.Items.Count == 0 && this.autoCompleteBoxRut.SelectedItem != null)
                {
                    this.autoCompleteBoxNombre.Text = CustomersList.Where(x => x.Clrut == this.autoCompleteBoxRut.SelectedItem.ToString()).ToList<StructCustomers>()[0].Clnombre;
                }

                if (comboCodigoRut.Items.Count > 0)
                {
                    this.comboCodigoRut.SelectedIndex = 0;
                }
            }
        }

        private void comboCodigoRutSelectionChange(object sender, SelectionChangedEventArgs e)
        {
            try
            {
                if (autoCompleteBoxNombre.Text != "" || autoCompleteBoxRut.Text != "")
                    if (this.comboCodigoRut.Items.Count > 0 && comboCodigoRut.SelectedItem != null)
                    {
                        this.autoCompleteBoxNombre.Text = CustomersList.Where(x => x.Clrut == this.autoCompleteBoxRut.SelectedItem.ToString() && x.Clcodigo == comboCodigoRut.SelectedItem.ToString()).ToList<StructCustomers>()[0].Clnombre;
                    }
            }
            catch
            {
                this.autoCompleteBoxRut.Text = "";
                this.autoCompleteBoxNombre.Text = "";
                this.comboCodigoRut.ItemsSource = null;
            }  
        }

        private void autocompleteNombreClosed(object sender, RoutedPropertyChangedEventArgs<bool> e)
        {
            if (this.autoCompleteBoxNombre.SelectedItem != null)
            {
                this.autoCompleteBoxRut.Text = CustomersList.Where(x => x.Clnombre == this.autoCompleteBoxNombre.Text).ToList<StructCustomers>()[0].Clrut;

                if (this.autoCompleteBoxRut.Text != "")
                {
                    var codigosRutVar = from CodigoItem in CustomersList.Where(x => x.Clrut == this.autoCompleteBoxRut.Text).ToList<StructCustomers>()
                                        select CodigoItem.Clcodigo.ToString();

                    this.comboCodigoRut.ItemsSource = codigosRutVar.ToList<string>();
                    this.comboCodigoRut.UpdateLayout();
                    this.comboCodigoRut.Measure(new Size(comboCodigoRut.ActualWidth, comboCodigoRut.ActualHeight));

                    if (codigosRutVar.ToList().Count > 0)
                        this.comboCodigoRut.SelectedIndex = 0;

                    if (codigosRutVar.ToList().Count == 0)
                    {
                        this.autoCompleteBoxNombre.Text = CustomersList.Where(x => x.Clrut == this.autoCompleteBoxRut.SelectedItem.ToString()).ToList<StructCustomers>()[0].Clnombre;
                    }
                }
            }
        }

        private void evemt_radioCorizacion_Clicked(object sender, RoutedEventArgs e)
        {
            this.Cotizacion_Afirme = "C";
        }

        private void evemt_radioAfirmen_Clicked(object sender, RoutedEventArgs e)
        {
            this.Cotizacion_Afirme = " ";
        }

        private void event_comboMonedaCompensacion_SelectedChanged(object sender, SelectionChangedEventArgs e)
        {
            if (FormaDePagoList != null)
            {
                ComboBox _comboMonedaCompensacion = sender as ComboBox;

                this.MonedaCompensacion = (_comboMonedaCompensacion.SelectedIndex == 0) ? 999 : 13;
                this.FormaPagoCompensacion = (_comboMonedaCompensacion.SelectedIndex == 0) ? CONST_FormaPagoCLP : CONST_FormaPagoUSD;

                comboFomaPagoCompensacionCompensacion.ItemsSource = SettingFormaPago(MonedaCompensacion);
                BuscarFormaPagoDefecto(comboFomaPagoCompensacionCompensacion, FormaPagoCompensacion);
            }
        }
				
        //Valida Ingreso solo Numeros Req_7274
        private void Event_ValidaNumeros(object sender, RoutedEventArgs e)
        {
            if (autoCompleteBoxRut.Text != "")
            {
                ValidaNumeros();
            }  
        }

        private void ValidaNumeros()
        {
            string campoRut = autoCompleteBoxRut.Text;
            try
            {
                int x;
                string y;
                y = campoRut;
                x = Convert.ToInt32(campoRut);
            }
            catch
            {
                System.Windows.Browser.HtmlPage.Window.Alert("En campo Rut debe Ingresar solo Números");
                autoCompleteBoxRut.Text = "";
            }   
        }

        //PAE 
        //Habilitar forma de pago: PAE BONIFICADO
        //public void event_CbxPAE_FormaPago(object sender, RoutedEventArgs e)
        //{
        //    #region Compensacion
        //    if (Compensacion_EntregaFisica.Equals("C") && (CbxOpePAE.IsChecked != false))
        //    {
        //        for (int i = 0; i < comboFomaPagoPrimaCompensacion.Items.Count; i++)
        //        {
        //            if (((AdminOpciones.Struct.StructMonedaFormaPago)(comboFomaPagoPrimaCompensacion.Items[i])).Descripcion.Trim().Equals("PAE BONIFICADO") == true)
        //            {
        //                comboFomaPagoPrimaCompensacion.SelectedIndex = i;
        //                comboFomaPagoPrimaCompensacion.IsEnabled = false;
        //                break;
        //            }
        //            else
        //            {
        //                if (i++ == comboFomaPagoPrimaCompensacion.Items.Count)
        //                {
        //                    System.Windows.Browser.HtmlPage.Window.Alert("Advertencia: no se encuentra el tipo de pago PAE ESTRUCTURADO.");
        //                    MaskCollapsed();
        //                    BuscarClasificacionCartera(CONST_Libro, CONST_CarteraFinanciera, CONST_CarteraNormativa, CONST_SubCarteraNormativa);
        //                }
        //            }
        //        }
        //    }
        //    else
        //    {
        //        if (Compensacion_EntregaFisica.Equals("C"))
        //        {
        //            //comboFomaPagoPrimaCompensacion.SelectedIndex = 4;
        //            comboFomaPagoPrimaCompensacion.IsEnabled = true;
        //        }
        //    }
        //    #endregion
        //}

        //Prd_16803
        void Leasing_ValidaLeasing(object sender, AdminOpciones.SrvLeasing.ValidaLeasingACLSC1001CompletedEventArgs e)
        {
            string _xmlResult = e.Result.ToString();

            try
            {
                if (_xmlResult.Equals("FALSE"))
                {
                    System.Windows.Browser.HtmlPage.Window.Alert("Número Operacion Leasing No Existe.");
                    this.autoCompleteBoxNumBienLeasing.Text = "";
                    this.autoCompleteBoxOpLeasing.Text = "";                      
                }
                else if (_xmlResult.Equals("TRUE"))
                {
                    this.Dispatcher.BeginInvoke(() =>
                    {
                        this.btnAceptarGuardar.IsEnabled = true;
                    });
                }
                else
                {
                    System.Windows.Browser.HtmlPage.Window.Alert("Problemas al Validar Leasing.");
                    this.autoCompleteBoxNumBienLeasing.Text = "";
                    this.autoCompleteBoxOpLeasing.Text = "";
                }
            }
            catch (Exception ex)
            {
                this.Dispatcher.BeginInvoke(() =>
                {
                    System.Windows.Browser.HtmlPage.Window.Alert("Error al Invocar Servicio SrvSAO  Error: " + ex);
                });
            }
        }

        /// <summary>
        /// Valida vía WS-Broker los datos para estructurar el Forward Americano con Leasing.
        /// Internamente valida que el combo de relación sea tipo Leasing //this.ComboEstructRelacion.SelectedItem.Equals("3")
        /// PRD_16803 No está habilitado.
        /// </summary>
        //void InvocaValidaLeasing()
        //{
        //    try
        //    {
        //        int OpLeasing = 0;
        //        int NumBienLeasing = 0;
        //        int RutCliente = 0;

        //        string Relacionleasing = ((AdminOpciones.Struct.StructRelacion)(this.ComboEstructRelacion.SelectedItem)).CodigoRelacion.ToString();
        //        string TipoEstructura = xmlData.Element("Datos").Element("encContrato").Element("Estructura").Attribute("MoCodEstructura").Value;
        //        switch (TipoEstructura)
        //        {
        //            case "8":
        //                if (Relacionleasing.Equals("3") && Compensacion_EntregaFisica.Equals("C"))
        //                {
        //                    if (this.autoCompleteBoxOpLeasing.Text != "" && this.autoCompleteBoxNumBienLeasing.Text != "" && this.autoCompleteBoxRut.Text != "")
        //                    {
        //                        try
        //                        {
        //                            OpLeasing = Convert.ToInt32(this.autoCompleteBoxOpLeasing.Text);
        //                            NumBienLeasing = Convert.ToInt32(this.autoCompleteBoxNumBienLeasing.Text);
        //                            RutCliente = Convert.ToInt32(this.autoCompleteBoxRut.Text);


        //                            AdminOpciones.SrvLeasing.LeasingSoapClient Leasing = wsGlobales.Leasing;
        //                            Leasing.ValidaLeasingACLSC1001Async(RutCliente.ToString(), OpLeasing.ToString(), NumBienLeasing.ToString(), NocionalFwd.ToString());
        //                            Leasing.ValidaLeasingACLSC1001Completed += new EventHandler<AdminOpciones.SrvLeasing.ValidaLeasingACLSC1001CompletedEventArgs>(Leasing_ValidaLeasing);
        //                        }
        //                        catch
        //                        {
        //                            System.Windows.Browser.HtmlPage.Window.Alert("Debe Ingresar solo Numeros en N° Leasing y N° Bien");
        //                            this.autoCompleteBoxOpLeasing.Text = "";
        //                            this.autoCompleteBoxNumBienLeasing.Text = "";
        //                            return;
        //                        }
        //                    }
        //                }
        //            break;
        //        }
        //    }
        //    catch
        //    { }
        //}

        /// <summary>
        /// Llamada a WS para traer lista de posibles relaciones desde BBDD.
        /// En el Completed inicializa el combo de relaciones.
        /// </summary>
        public void CargaEstructuraRelacion()
        {
            AdminOpciones.SrvDetalles.WebDetallesSoapClient svc = wsGlobales.Detalles;
            svc.Trae_EstructurasRelacionadasAsync();
            svc.Trae_EstructurasRelacionadasCompleted+= new EventHandler<AdminOpciones.SrvDetalles.Trae_EstructurasRelacionadasCompletedEventArgs>(svc_TraeEstructuraRelacionCompleted);
            this.autoCompleteBoxOpLeasing.Text = "";
            this.autoCompleteBoxNumBienLeasing.Text = "";
        }

        void svc_TraeEstructuraRelacionCompleted(object sender, AdminOpciones.SrvDetalles.Trae_EstructurasRelacionadasCompletedEventArgs e)
        {
            if (globales._Estado != "M")
            {
                string _xmlResult = e.Result.ToString();
                XDocument xmlResult = new XDocument();
                xmlResult = XDocument.Parse(_xmlResult);

                var DataEstructura = from itemDataLoad in xmlResult.Element("Result").Elements("Status").Elements("Item") 
                                     select new StructRelacion
                                     {
                                         CodigoRelacion = itemDataLoad.Attribute("ReId").Value.ToString(),
                                         DescripcionRelacion = itemDataLoad.Attribute("ReDescripcion").Value.ToString()
                                     };

                EstructuraRelacion = DataEstructura.ToList();
                ComboEstructRelacion.ItemsSource = EstructuraRelacion;
                ComboEstructRelacion.DisplayMemberPath = "DescripcionRelacion";

                for (int i = 0; i < EstructuraRelacion.Count; i++)
                {
                    if (EstructuraRelacion[i].CodigoRelacion == "1")
                    {
                        ComboEstructRelacion.SelectedIndex = i;
                    }
                }
            }
        }
        //viene de acá
        private void ComboEstructRelacionGotFocus(object sender, RoutedEventArgs e)
        {
            Validarelacionados();
        }
        //se cae acá
        private void Validarelacionados()
        {
            string TipoEstructura = xmlData.Element("Datos").Element("encContrato").Element("Estructura").Attribute("MoCodEstructura").Value;
            try
            {
                _CodigoRelacion = ((AdminOpciones.Struct.StructRelacion)(this.ComboEstructRelacion.SelectedItem)).CodigoRelacion.ToString();
            }
            catch (NullReferenceException)
            {
                _CodigoRelacion = "-1";
            }

            //Switch para Estructuras que soportan relación.
            switch (TipoEstructura)
            {
                case "8":
                    try
                    {
                        if (_CodigoRelacion != "3")
                        {
                            this.btnAceptarGuardar.IsEnabled = true;
                            for (int i = 0; i < EstructuraRelacion.Count; i++)
                            {
                                if (EstructuraRelacion[i].CodigoRelacion == "1")
                                {
                                    ComboEstructRelacion.SelectedIndex = i;
                                    this.autoCompleteBoxOpLeasing.IsEnabled = false;
                                    this.autoCompleteBoxNumBienLeasing.IsEnabled = false;
                                    this.autoCompleteBoxOpLeasing.Text = "";
                                    this.autoCompleteBoxNumBienLeasing.Text = "";                                    
                                }
                            }
                        }
                        else if (_CodigoRelacion == "3")
                        {
                            this.autoCompleteBoxOpLeasing.IsEnabled = true;
                            this.autoCompleteBoxNumBienLeasing.IsEnabled = true;
                            this.btnAceptarGuardar.IsEnabled = false; 
                        }
                    }
                    catch { }
                break;
                
                case"0":
                    if (_CodigoRelacion != "2")
                    {
                        for (int i = 0; i < EstructuraRelacion.Count; i++)
                        {
                            if (EstructuraRelacion[i].CodigoRelacion == "1")
                            {
                                ComboEstructRelacion.SelectedIndex = i;
                                this.autoCompleteBoxOpLeasing.IsEnabled = false;
                                this.autoCompleteBoxNumBienLeasing.IsEnabled = false;
                            }
                        }
                    }                       
                    #region Compensacion
                    if (Compensacion_EntregaFisica.Equals("C")&&_CodigoRelacion == "2")
                    {
                        for (int i = 0; i < comboFomaPagoPrimaCompensacion.Items.Count; i++)
                        {
                            //if (((AdminOpciones.Struct.StructMonedaFormaPago)(comboFomaPagoPrimaCompensacion.Items[i])).Descripcion.Equals("PAE ESTRUCTURADO              ") == true)
                            if (((AdminOpciones.Struct.StructMonedaFormaPago)(comboFomaPagoPrimaCompensacion.Items[i])).Descripcion.Trim().Equals("PAE BONIFICADO") == true)
                            {
                                comboFomaPagoPrimaCompensacion.SelectedIndex = i;
                                comboFomaPagoPrimaCompensacion.IsEnabled = false;
                                break;
                            }
                            else
                            {
                                if (i++ == comboFomaPagoPrimaCompensacion.Items.Count)
                                {
                                    System.Windows.Browser.HtmlPage.Window.Alert("Advertencia: no se encuentra el tipo de pago PAE ESTRUCTURADO");
                                    MaskCollapsed();
                                    BuscarClasificacionCartera(CONST_Libro, CONST_CarteraFinanciera, CONST_CarteraNormativa, CONST_SubCarteraNormativa);
                                }
                            }
                        }
                    }
                    else
                    {
                        if (Compensacion_EntregaFisica.Equals("C"))
                        {
                            //comboFomaPagoPrimaCompensacion.SelectedIndex = 4;
                            comboFomaPagoPrimaCompensacion.IsEnabled = true;
                        }
                    }
                    #endregion
                break;
            }
        }

        /// <summary>
        /// REVISAR - Valida condiciones de relación para Forward Americano con Leasing.
        /// PRD_16803 No está habilitado.
        /// </summary>
        /// <returns></returns>
        private bool ValidaIngresoRelacionado()
        {
            bool Resultado = false;
            string TipoEstructura = xmlData.Element("Datos").Element("encContrato").Element("Estructura").Attribute("MoCodEstructura").Value;
            switch (TipoEstructura)
            {
                case "8":
                    try
                    {
                        if (_CodigoRelacion == "3" && this.autoCompleteBoxNumBienLeasing.Text == "" && this.autoCompleteBoxOpLeasing.Text == "")
                        {
                            Resultado = true;
                        }
                    }
                    catch { }
                    break;
            }

            return Resultado;
        }

        private void autoCompleteBoxOpLeasingLostFocus(object sender, RoutedEventArgs e)
        {
            //PRD_16803
            //ASVG_20141020 Se comenta funcionalidad ya que proyecto queda Stand-By por fusión.
            //InvocaValidaLeasing();
        }

        private void autoCompleteBoxNumBienLeasingLostFocus(object sender, RoutedEventArgs e)
        {
            //PRD_16803
            //ASVG_20141020 Se comenta funcionalidad ya que proyecto queda Stand-By por fusión.
            //InvocaValidaLeasing();   
        }

        private void autoCompleteBoxNombreLostFocus(object sender, RoutedEventArgs e)
        {
            //PRD_16803
            //ASVG_20141020 Se comenta funcionalidad ya que proyecto queda Stand-By por fusión.
            //InvocaValidaLeasing();
        }

        void client_obtieneIDD(object sender, AdminOpciones.SrvTomaLinea.getLineaCodeCompletedEventArgs e ) {

            try
            {
                int numOp = 0;
                if(mensajeRetorno != null)
                    numOp= GetNumeroOperacion(mensajeRetorno);

                string firstStatus =  e.Result.MsgStatusCode;
                string statusIDD = e.Result.AdStatusCode;
                string codigoIDD = "0";
                string statusDesc = "";

                if (statusIDD.Equals("200") && firstStatus.Equals("0"))
                {
                    codigoIDD = e.Result.ReturnCode.ToString();
                    if (this._Transaccion.Equals("ANULA"))
                {
                        statusDesc = "Devolucion de Linea IDR Correcta";
                    }
                    else
                    {
                        statusDesc = "Toma Linea IDD Correcta";
                    }
                }
                else
                {
                    statusDesc = "ERROR IDD:" + e.Result.StatusDesc;
                }



                ActualizaOperacionIDD(Int16.Parse(statusIDD), "OPT", numOp, 0, Int32.Parse(codigoIDD), statusDesc, 1);



                //SrvTomaLinea.ControlLineaCreditoTesoreriaRs rs = e.Result.;
                //System.Windows.Browser.HtmlPage.Window.Alert("OBTIENE Retorno IDD : " + e.Result.MsgRsHdr.Status.StatusCode.ToString());
            }
            catch (Exception ex)
            {
                System.Windows.Browser.HtmlPage.Window.Alert("ERROR EN WS: " + ex.Message + Environment.NewLine + ex.StackTrace);
            }
            

        }


        void llamadoWSIDD(string clienteAS400,string codigoCliente,string facility, string plazoOP,string montoLinea,string monedaAS400)
        {

            try
            {
                SrvTomaLinea.ProxyLineaCreditoClient client = wsGlobales.TomaLinea;

                string actionLinea = "";

                if (this._Transaccion.Equals("ANULA"))//DETERMINA SI ES IDR O IDD
                    actionLinea = "R";
                else
                    actionLinea = "Y";

                client.getLineaCodeCompleted += new EventHandler<SrvTomaLinea.getLineaCodeCompletedEventArgs>(client_obtieneIDD);

                client.getLineaCodeAsync(clienteAS400, codigoCliente, facility, plazoOP, montoLinea, monedaAS400, actionLinea);


            }catch(Exception e ){
                string t = "";
                t = e.Message;
               
                }
                
                
        }

    }
}