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
using AdminOpciones.Struct.OpcionesXF.Asiatica;
using System.Xml.Linq;
using AdminOpciones.Valid;
using System.Windows.Controls.Primitives;
using AdminOpciones.Struct;

namespace AdminOpciones.OpcionesFX.Asiatica
{
    public delegate void ShowFixing(bool value);
    public delegate void ShowResults(string strResults);
    public delegate void LoadTablaFixingData();
    public delegate void isTablaFixingLoadedFromValcartera(bool isTrue);
    public delegate void delegateCalculaPeso(string tipoPeso_flag);
    public delegate void ChangeDateFixing(DateTime date);

    public partial class TablaFixing : UserControl
    {
        public event ShowFixing event_ShowFixing;
        public event ShowResults event_TablaFixingResult;
        public event ShowResults event_TablaFixingResultEntrada;//PRD_12567
        public event LoadTablaFixingData event_LoadDataTableFixingData;
        public event isTablaFixingLoadedFromValcartera event_TablaFixingLoadedFromValCartera;
        public event delegateCalculaPeso event_TablaFixing_CalculaPeso;
        public event delegateCalculaPeso event_TablaFixing_CalculaPesoEntrada;//PRD_12567
        public event ChangeDateFixing event_ChangeDateFixing;

        private DateTime fechaInicio;// = new DateTime();
        public DateTime fechaFin;// = new DateTime();
        private DateTime fechaInicioEntrada;// = new DateTime();PRD_12567
        public DateTime fechaFinEntrada;// = new DateTime();PRD_12567

        public DateTime fechaHoy { get; set; }
        public DateTime FechaSetPrecios { get; set; }

        public int Town = 2;

        public bool isEditing = false;
        public bool isEditingEntrada = false;//PRD_12567
        private int aux_plazo_dias;
        public string paridad = "CLP/USD";

        public string curvaDom = "CurvaSwapCLP";
        public string curvaFor = "CurvaSwapUSDLocal";
        public double nominal;
        public double strike;
        public double spot;
        public string call_put = "c";
        public string compra_venta = "compra";
        // public int plazo_dias;

        private string XMLFixingData;
        private string XMLFixingDataEntrada;//PRD_12567

        private double pesoBeforeEdit = double.NaN;
        private double pesoBeforeEditEntrada = double.NaN;//PRD_12567
        private double pesoAfterEdit;
        private double pesoAfterEditEntrada;//PRD_12567

        private double fijacionBeforeEdit = double.NaN;
        private double fijacionBeforeEditEntrada = double.NaN;//PRD_12567
        private double fijacionAfterEdit;
        private double fijacionAfterEditEntrada;//PRD_12567

        private double ValorDouble;
        private double ValorDoubleEntrada;//PRD_12567
        private DateTime newDateTime;
        private DateTime newDateTimeEntrada;//PRD_12567
        private int filaEdited;
        private int filaEditedEntrada;//PRD_12567
        private int columnaEdited;
        private int columnaEditedEntrada;//PRD_12567
        private double PesoTotal_100;
        private double PesoTotal_100_Entrada;//PRD_12567

        /// <summary>
        /// Lista con las fijaciones de Salida
        /// </summary>
        public List<StructFixingData> fixingdataList;
        /// <summary>
        /// Lista con las fijaciones de Entrada
        /// </summary>
        public List<StructFixingData> fixingdataListEntrada;//PRD_12567
      
        public int enumSetPrecio;

        public bool isAsiatica = false;
        public bool AcualizarPesos = true;
        public bool AcualizarPesosEntrada = true;

        ValidAmount valtxtDouble = new ValidAmount();
        ValidAmount valtxtPeso = new ValidAmount();
        ValidAmount valtxtFijacion = new ValidAmount();

        public bool bandera = false;
        public string periodoStrip = "";

        //private SrvAsiaticas.SrvAsiaticasSoapClient _SrvAsiatica = AdminOpciones.Recursos.wsGlobales.Asiaticas;
        //private SrvAsiaticas.SrvAsiaticasSoapClient _SrvAsiaticaEntrada = AdminOpciones.Recursos.wsGlobales.Asiaticas;


        private SrvAsiaticas.SrvAsiaticasSoapClient _SrvAsiatica;
        private SrvAsiaticas.SrvAsiaticasSoapClient _SrvAsiaticaEntrada;

        public TablaFixing()
        {
            InitializeComponent();
            valtxtDouble.DecimalPlaces = 2;
            valtxtPeso.DecimalPlaces = 4;
            valtxtFijacion.DecimalPlaces = 4;

            //Se mueve la inicializaciòn acà ya que el diseñador no cargaba
            //ASVG
            //ecastillo
            try
            {
                _SrvAsiatica = AdminOpciones.Recursos.wsGlobales.Asiaticas;
                _SrvAsiaticaEntrada = AdminOpciones.Recursos.wsGlobales.Asiaticas;
            }
            catch
            { }
        }

        public bool IsValidPeso()
        {
            double _Peso = 0;
            double _PesoEntrada = 0;
            int Nentradas = 0 ;
            bool _Status = false;

            foreach (StructFixingData _Element in fixingdataList)
            {
                if (_Element.Peso >= 0)
                {
                    _Peso += _Element.Peso;
                }
            }
            _Status = Math.Round(_Peso, 4).Equals(1.0000) ? true : false;

            if (_Status == false)
            {
                return _Status;
            }

            //PRD_12567
            if (fixingdataListEntrada != null) Nentradas =  fixingdataListEntrada.Count();
            

            if (Nentradas > 0)
            {
                foreach (StructFixingData _Element in fixingdataListEntrada)
                {
                    _PesoEntrada += _Element.Peso;
                }

                _Status = Math.Round(_PesoEntrada, 4).Equals(-1.0000) ? true : false;
            }
            return _Status;
        }

        /// <summary>
        /// Setea fechas de inicio y fin para TablaFixing (Salida) desde DatePicker
        /// </summary>
        /// <returns></returns>
        public bool LoadData()
        {
            try
            {
                fechaInicio = datePikerInicio.SelectedDate.Value;
                fechaFin = datePikerFin.SelectedDate.Value;
                event_LoadDataTableFixingData();//Setea variables independientes de Entrada o Salida

                return true;
            }
            catch
            {
                return false;
            }
        }

        public void event_ClickCrear(object sender, RoutedEventArgs e)
        {

            XMLFixingData = String_XMLFixingData(grdTablaFixing);

            if (!((ComboBoxItem)this.comboFrecuencia.SelectedItem).Content.Equals("Custom") && !((ComboBoxItem)this.comboTipoPeso.SelectedItem).Content.Equals("Custom"))
            {

                if (this.datePikerInicio.SelectedDate != null && this.datePikerFin.SelectedDate != null && (this.checkLondres.IsChecked.Value || this.checkNewYork.IsChecked.Value || this.checkSantiago.IsChecked.Value))
                {

                    PesoTotal_100 = 0;
                    string intervalo = "";
                    if (this.comboFrecuencia.SelectedIndex >= 0)
                    {
                        intervalo = ((ComboBoxItem)this.comboFrecuencia.SelectedItem).Content.ToString();

                    }
                    string TipoPeso = "";
                    if (this.comboTipoPeso.SelectedIndex >= 0)
                    {
                        TipoPeso = ((ComboBoxItem)this.comboTipoPeso.SelectedItem).Content.ToString();
                    }

                    if (this.LoadData()) //Setea fechas de inicio y fin para TablaFixing (Salida) desde DatePicker
                    {
                        //SrvAsiaticas.SrvAsiaticasSoapClient _SrvAsiatica = new AdminOpciones.SrvAsiaticas.SrvAsiaticasSoapClient();
                        //validar que el handler corresponda
                        _SrvAsiatica.generateFixingTableCompleted += new EventHandler<AdminOpciones.SrvAsiaticas.generateFixingTableCompletedEventArgs>(_SrvAsiatica_generateFixingTableCompleted);
                        _SrvAsiatica.generateFixingTableAsync(Town, fechaInicio, fechaFin, this.fechaHoy,FechaSetPrecios, intervalo, TipoPeso, paridad, call_put, compra_venta, nominal, spot, strike, curvaDom, curvaFor, enumSetPrecio, 0);
                    }
                }
            }
            else
            {
                string intervalo = "";
                if (this.comboFrecuencia.SelectedIndex >= 0)
                {
                    intervalo = ((ComboBoxItem)this.comboFrecuencia.SelectedItem).Content.ToString();

                }
                string TipoPeso = "";
                if (this.comboTipoPeso.SelectedIndex >= 0)
                {
                    TipoPeso = ((ComboBoxItem)this.comboTipoPeso.SelectedItem).Content.ToString();
                }

                //SrvAsiaticas.SrvAsiaticasSoapClient _SrvAsiatica = new AdminOpciones.SrvAsiaticas.SrvAsiaticasSoapClient();
                _SrvAsiatica.ReLoadFixingTableCompleted += new EventHandler<AdminOpciones.SrvAsiaticas.ReLoadFixingTableCompletedEventArgs>(_SrvAsiatica_ReLoadFixingTableCompleted);
                _SrvAsiatica.ReLoadFixingTableAsync(fechaInicio, fechaFin, fechaHoy, FechaSetPrecios, intervalo, TipoPeso, paridad, spot, strike, curvaDom, curvaFor, enumSetPrecio, XMLFixingData);

            }
        }

        void _SrvAsiatica_ReLoadFixingTableCompleted(object sender, AdminOpciones.SrvAsiaticas.ReLoadFixingTableCompletedEventArgs e)
        {
            Result_FixingTable_Completed(e.Result);
        }

        public void Crear()
        {
            event_ShowFixing(true);//efecto visual
            if (!((ComboBoxItem)this.comboFrecuencia.SelectedItem).Content.Equals("Custom") && !((ComboBoxItem)this.comboTipoPeso.SelectedItem).Content.Equals("Custom"))
            {
                string intervalo = "";
                if (this.comboFrecuencia.SelectedIndex >= 0)
                {
                    intervalo = ((ComboBoxItem)this.comboFrecuencia.SelectedItem).Content.ToString();
                }
                string TipoPeso = "";
                if (this.comboTipoPeso.SelectedIndex >= 0)
                {
                    TipoPeso = ((ComboBoxItem)this.comboTipoPeso.SelectedItem).Content.ToString();
                }

                if (this.LoadData())//setea fechas desde DatePickers
                {
                    //this.LoadData();
                    //SrvAsiaticas.SrvAsiaticasSoapClient _SrvAsiatica = new AdminOpciones.SrvAsiaticas.SrvAsiaticasSoapClient();
                    //verificar que el handler corresponda
                    _SrvAsiatica.generateFixingTableCompleted += new EventHandler<AdminOpciones.SrvAsiaticas.generateFixingTableCompletedEventArgs>(_SrvAsiatica_generateFixingTableCompleted);
                    _SrvAsiatica.generateFixingTableAsync(Town, fechaInicio, fechaFin, this.fechaHoy, FechaSetPrecios, intervalo, TipoPeso, paridad, call_put, compra_venta, nominal, spot, strike, curvaDom, curvaFor, enumSetPrecio, 0);
                }
            }
            else
            {
                event_ShowFixing(false);
            }
        }

        public void Cargar(List<StructFixingData> FixingDataListToLoad, bool isLoadedFromValCartera)
        {
            if (FixingDataListToLoad != null)
            {
                this.fixingdataList = FixingDataListToLoad;

                string _fixingDataXML = "<FixingData>\n";

                for (int i = 0; i < FixingDataListToLoad.Count; i++)
                {
                    if (FixingDataListToLoad[i].Peso > 0) //PRD_12567
                    {
                        _fixingDataXML += string.Format(
                                                         "<FixingValues Fecha='{0}' Valor='{1}' Peso='{2}' Volatilidad='{3}' Plazo='{4}' />\n",
                                                         FixingDataListToLoad[i].Fecha,
                                                         FixingDataListToLoad[i].Valor,
                                                         FixingDataListToLoad[i].Peso,
                                                         FixingDataListToLoad[i].Volatilidad,
                                                         FixingDataListToLoad[i].Fecha.Subtract(this.fechaHoy).Days.ToString()
                                                       );
                    }
                }
                _fixingDataXML += "</FixingData>\n";
               
                event_TablaFixingLoadedFromValCartera(isLoadedFromValCartera);

                XMLFixingData = _fixingDataXML;
                event_TablaFixingResult(_fixingDataXML);
                this.grdTablaFixing.ItemsSource = null;
                this.grdTablaFixing.ItemsSource = FixingDataListToLoad;
                this.grdTablaFixing.UpdateLayout();
            }
        }

//revisar
        private void Result_FixingTable_Completed(string Result)
        {
            XMLFixingData = Result;
            event_TablaFixingResult(XMLFixingData);//setea variables del this, manda a valorizar...

            try
            {
                XDocument xdoc = new XDocument(XDocument.Parse(XMLFixingData));

                var elements = from elementItem in xdoc.Descendants("FixingValues")
                               select new StructFixingData
                               {
                                   Fecha = DateTime.Parse(elementItem.Attribute("Fecha").Value.ToString()),
                                   Valor = double.Parse(elementItem.Attribute("Valor").Value.ToString()),
                                   Peso = double.Parse(elementItem.Attribute("Peso").Value.ToString()),
                                   Volatilidad = double.Parse(elementItem.Attribute("Volatilidad").Value.ToString()),
                                   Plazo = DateTime.Parse(elementItem.Attribute("Fecha").Value.ToString()).Subtract(this.fechaInicio).Days
                               };

                fixingdataList = new List<StructFixingData>(elements.ToList<StructFixingData>());

                this.grdTablaFixing.ItemsSource = fixingdataList.Where(_Element => _Element.Peso >= 0).ToList();//PRD_12567

                //this.grdTablaFixing.ItemsSource = fixingdataList;

                PesoTotal_100 = 0;
                for (int i = 0; i < fixingdataList.Count; i++)
                {
                    this.PesoTotal_100 += fixingdataList[i].Peso;
                }
            }
            catch { }
        }

        private void _SrvAsiatica_generateFixingTableCompleted(object sender, AdminOpciones.SrvAsiaticas.generateFixingTableCompletedEventArgs e)
        {
            event_TablaFixingLoadedFromValCartera(false);//cambia un flag
            Result_FixingTable_Completed(e.Result);//setea valores de nuevo fixing
            event_ShowFixing(false);//efecto visual
        }

        private void event_XButton_Clicked(object sender, RoutedEventArgs e)
        {
            this.Visibility = Visibility.Collapsed;
        }

        private void event_ClickTown_Checked(object sender, RoutedEventArgs e)
        {
            this.Town = 0;

            if (!checkNewYork.IsChecked.Value && !checkSantiago.IsChecked.Value && checkLondres.IsChecked.Value)
            {
                Town = 1;
            }
            if (!checkNewYork.IsChecked.Value && checkSantiago.IsChecked.Value && !checkLondres.IsChecked.Value)
            {
                Town = 2;
            }
            if (!checkNewYork.IsChecked.Value && checkSantiago.IsChecked.Value && checkLondres.IsChecked.Value)
            {
                Town = 3;
            }
            if (checkNewYork.IsChecked.Value && !checkSantiago.IsChecked.Value && !checkLondres.IsChecked.Value)
            {
                Town = 4;
            }
            if (checkNewYork.IsChecked.Value && !checkSantiago.IsChecked.Value && checkLondres.IsChecked.Value)
            {
                Town = 5;
            }
            if (checkNewYork.IsChecked.Value && checkSantiago.IsChecked.Value && !checkLondres.IsChecked.Value)
            {
                Town = 6;
            }
            if (checkNewYork.IsChecked.Value && checkSantiago.IsChecked.Value && checkLondres.IsChecked.Value)
            {
                Town = 7;
            }

        }

        private void event_comboTipoPeso_SelectedChanged(object sender, SelectionChangedEventArgs e)
        {
            if (comboTipoPeso != null && comboTipoPeso.Items.Count > 0)
            {
                if (((ComboBoxItem)this.comboTipoPeso.SelectedItem).Content.Equals("Custom"))
                {
                    this.grdTablaFixing.Columns[1].IsReadOnly = false;

                }
                else
                {
                    this.grdTablaFixing.Columns[1].IsReadOnly = true;
                }
            }

            if (AcualizarPesos == true && comboTipoPeso != null)
            {
                event_TablaFixing_CalculaPeso(((ComboBoxItem)this.comboTipoPeso.SelectedItem).Content.ToString());
            }
        }

        private void event_grdFixingData_PreparingForEdit(object sender, DataGridPreparingCellForEditEventArgs e)
        {
            try
            {
                this.filaEdited = this.grdTablaFixing.SelectedIndex;
                this.columnaEdited = this.grdTablaFixing.CurrentColumn.DisplayIndex;
                ValorDouble = double.NaN;
                newDateTime = new DateTime(1, 1, 1);

                PesoTotal_100 = 0;

                foreach (StructFixingData _fix in this.fixingdataList)
                {
                    PesoTotal_100 += _fix.Peso;
                }

                if (columnaEdited == 1)
                {
                    this.pesoBeforeEdit = double.Parse(e.EditingElement.GetValue(TextBox.TextProperty).ToString());
                    valtxtPeso.SetChange((e.EditingElement as TextBox), pesoBeforeEdit);

                }
                else if (columnaEdited == 2)
                {
                    this.fijacionBeforeEdit = double.Parse(e.EditingElement.GetValue(TextBox.TextProperty).ToString());
                    this.valtxtFijacion.SetChange((e.EditingElement as TextBox), fijacionBeforeEdit);
                }
                else if (columnaEdited > 2)
                {
                    this.ValorDouble = double.Parse(e.EditingElement.GetValue(TextBox.TextProperty).ToString());
                    valtxtDouble.SetChange((e.EditingElement as TextBox), ValorDouble);
                }
                else if (columnaEdited == 0)
                {
                    this.newDateTime = DateTime.Parse(e.EditingElement.GetValue(DatePicker.SelectedDateProperty).ToString());
                }

            }
            catch
            {
                if (columnaEdited == 1)
                {
                    this.pesoBeforeEdit = double.NaN;
                }
                else if (columnaEdited == 2)
                {
                    this.fijacionBeforeEdit = double.NaN;
                }
                else if (columnaEdited > 2)
                {
                    this.ValorDouble = double.NaN;
                }
                else if (columnaEdited == 0)
                {
                    newDateTime = new DateTime(1, 1, 1);
                }
            }

        }

        private void event_TextBox_TextChanged(object sender, TextChangedEventArgs e)
        {

            TextBox _textBox = sender as TextBox;
            if (columnaEdited == 1)
            {
                this.valtxtPeso.TextChange(_textBox);
            }
            else if (columnaEdited == 2)
            {
                this.valtxtFijacion.TextChange(_textBox);
            }
            else if (columnaEdited > 2)
            {
                this.valtxtDouble.TextChange(_textBox);
            }

            try
            {
                if (columnaEdited == 1)
                {
                    pesoAfterEdit = double.Parse(((TextBox)sender).Text);
                }
                else if (columnaEdited == 2)
                {
                    fijacionAfterEdit = double.Parse(((TextBox)sender).Text);
                }
                else if (columnaEdited > 2)
                {
                    ValorDouble = double.Parse(((TextBox)sender).Text);
                }
            }
            catch
            {
                if (columnaEdited == 1)
                {
                    pesoAfterEdit = pesoBeforeEdit;
                }
                else if (columnaEdited == 2)
                {
                    fijacionAfterEdit = fijacionBeforeEdit;
                }

            }
        }

        private void event_TextBox_KeyDown(object sender, KeyEventArgs e)
        {
            TextBox _textBox = sender as TextBox;

            this.valtxtDouble.KeyDown(_textBox);

            if (columnaEdited == 1)
            {
                this.valtxtPeso.KeyDown(_textBox);
            }
            else if (columnaEdited == 2)
            {
                this.valtxtFijacion.KeyDown(_textBox);
            }
            else if (columnaEdited > 2)
            {
                this.valtxtDouble.KeyDown(_textBox);
            }
        }

        private void event_FechaFijacion_SelectedDateChanged(object sender, SelectionChangedEventArgs e)
        {
        }

        private void event_comboFrecuencia_SelectedChanged(object sender, SelectionChangedEventArgs e)
        {
            if (comboFrecuencia != null)
            {
                if (((ComboBoxItem)this.comboFrecuencia.SelectedItem).Content.Equals("Custom"))
                {
                    this.grdTablaFixing.Columns[0].IsReadOnly = false;
                    this.grdTablaFixing.Columns[2].IsReadOnly = false;
                    this.grdTablaFixing.Columns[3].IsReadOnly = false;
                }
                else
                {
                    this.grdTablaFixing.Columns[0].IsReadOnly = true;
                    this.grdTablaFixing.Columns[2].IsReadOnly = true;
                    this.grdTablaFixing.Columns[3].IsReadOnly = true;
                }
            }
        }

        private void event_comboFrecuenciaEntrada_SelectedChanged(object sender, SelectionChangedEventArgs e)
        {
            if (comboFrecuenciaEntrada != null)
            {
                if (((ComboBoxItem)this.comboFrecuenciaEntrada.SelectedItem).Content.Equals("Custom"))
                {
                    this.grdTablaFixingEntrada.Columns[0].IsReadOnly = false;
                    this.grdTablaFixingEntrada.Columns[2].IsReadOnly = false;
                    this.grdTablaFixingEntrada.Columns[3].IsReadOnly = false;
                }
                else
                {
                    this.grdTablaFixingEntrada.Columns[0].IsReadOnly = true;
                    this.grdTablaFixingEntrada.Columns[2].IsReadOnly = true;
                    this.grdTablaFixingEntrada.Columns[3].IsReadOnly = true;
                }
            }
        }

        private void event_grdFixingData_KeyDown(object sender, KeyEventArgs e)
        {

            if (!isEditing && this.grdTablaFixing.SelectedIndex >= 0 && ((ComboBoxItem)this.comboFrecuencia.SelectedItem).Content.Equals("Custom"))
            {
                if (e.Key == Key.Insert)
                {
                    int _index = grdTablaFixing.SelectedIndex;
                    DateTime _newDateTime = new DateTime();
                    _newDateTime = fixingdataList[_index].Fecha;
                    StructFixingData _newDataFixing = new StructFixingData(new DateTime(_newDateTime.Year, _newDateTime.Month, _newDateTime.Day), 0, 0, 0, fixingdataList[_index].Plazo);
                    this.fixingdataList.Insert(_index, _newDataFixing);

                    event_TablaFixing_CalculaPeso(((ComboBoxItem)this.comboTipoPeso.SelectedItem).Content.ToString());
                    //this.grdTablaFixing.ItemsSource = null;
                    //this.grdTablaFixing.ItemsSource = this.fixingdataList;
                    Cargar(fixingdataList, false);

                    this.grdTablaFixing.SelectedIndex = _index;
                }

                if (e.Key == Key.Delete)
                {
                    int _index = grdTablaFixing.SelectedIndex;
                    double _peso = fixingdataList[_index].Peso;

                    this.fixingdataList.RemoveAt(_index);

                    event_TablaFixing_CalculaPeso(((ComboBoxItem)this.comboTipoPeso.SelectedItem).Content.ToString());


                    //this.grdTablaFixing.ItemsSource = null;
                    //this.grdTablaFixing.ItemsSource = this.fixingdataList;

                    Cargar(fixingdataList, false);

                    if (_index == fixingdataList.Count)
                    {
                        this.grdTablaFixing.SelectedIndex = _index - 1;
                    }
                    else
                    {
                        this.grdTablaFixing.SelectedIndex = _index;
                    }
                    PesoTotal_100 -= _peso;

                }

                isEditing = false;
            }
            else if (!isEditing && this.grdTablaFixing.SelectedIndex < 0 && ((ComboBoxItem)this.comboFrecuencia.SelectedItem).Content.Equals("Custom"))
            {

                if (e.Key == Key.Insert)
                {
                    int _index = 0;
                    DateTime _newDateTime = new DateTime();
                    _newDateTime = fechaHoy;
                    StructFixingData _newDataFixing = new StructFixingData(new DateTime(_newDateTime.Year, _newDateTime.Month, _newDateTime.Day), 0, 1, 0, 0);
                    this.fixingdataList.Insert(_index, _newDataFixing);

                    this.grdTablaFixing.ItemsSource = null;
                    this.grdTablaFixing.ItemsSource = this.fixingdataList;
                    Cargar(fixingdataList, false);

                    this.grdTablaFixing.SelectedIndex = _index;

                    isEditing = false;
                }
            }
        }

        #region Grilla

        private void event_DatePickerNewDate_GotFocus(object sender, RoutedEventArgs e)
        {
            isEditing = true;
        }

        private void event_TextBoxEdit_LostFocus(object sender, RoutedEventArgs e)
        {

            string xmlFixing = this.XMLFixingData;
            XDocument _NewXML_Fixing = new XDocument(XDocument.Parse(xmlFixing));
            XElement _FixingValues = _NewXML_Fixing.Element("FixingData").Elements("FixingValues").ElementAt(this.filaEdited);

            TextBox _textBox = sender as TextBox;

            if (columnaEdited == 1)
            {
                valtxtPeso.LostFocus(_textBox);
                try
                {
                    if (double.Parse(_textBox.Text) < 0)
                    {
                        _textBox.Text = pesoBeforeEdit.ToString("#,##0.#0000");
                        PesoTotal_100 = 1;
                        pesoAfterEdit = pesoBeforeEdit;

                    }
                    else
                    {
                        PesoTotal_100 -= this.pesoBeforeEdit;

                        if ((PesoTotal_100 + double.Parse(_textBox.Text)) > 1.00)
                        {
                            if (1 - PesoTotal_100 >= 0)
                            {
                                pesoAfterEdit = 1 - PesoTotal_100;

                                _textBox.Text = (1 - PesoTotal_100).ToString("#,##0.#0000");
                                PesoTotal_100 += 1 - PesoTotal_100;
                            }
                            else
                            {
                                _textBox.Text = pesoBeforeEdit.ToString("#,##0.#0000");
                                PesoTotal_100 = 1;
                                pesoAfterEdit = pesoBeforeEdit;
                            }
                        }
                        else
                        {
                            PesoTotal_100 += double.Parse(_textBox.Text);
                            pesoAfterEdit = double.Parse(_textBox.Text);
                        }
                    }
                }
                catch
                {
                    _textBox.Text = pesoBeforeEdit.ToString("#,##0.#0000");
                    PesoTotal_100 = 1;
                    pesoAfterEdit = pesoBeforeEdit;
                }

                //--------------

                _FixingValues.Attribute("Peso").Value = pesoAfterEdit.ToString("#,##0.#0000");

                XMLFixingData = (_NewXML_Fixing.ToString());
                event_TablaFixingResult(XMLFixingData);
            }
            if (columnaEdited == 2 && !fijacionBeforeEdit.Equals(double.NaN))
            {
                try
                {
                    valtxtFijacion.LostFocus(_textBox);

                    if (double.Parse(_textBox.Text) < 0)
                    {
                        _textBox.Text = fijacionBeforeEdit.ToString("#,##0.#0000");
                        fijacionAfterEdit = fijacionBeforeEdit;
                    }
                    else
                    {
                        fijacionAfterEdit = double.Parse(_textBox.Text);
                    }

                    _FixingValues.Attribute("Valor").Value = this.fijacionAfterEdit.ToString("#,##0.#00");

                    XMLFixingData = (_NewXML_Fixing.ToString());
                    event_TablaFixingResult(XMLFixingData);
                }
                catch
                {
                    _textBox.Text = fijacionBeforeEdit.ToString("#,##0.#0000");
                    fijacionAfterEdit = fijacionBeforeEdit;
                }
            }

            if (columnaEdited == 3 && !ValorDouble.Equals(double.NaN))
            {
                _FixingValues.Attribute("Volatilidad").Value = ValorDouble.ToString("#,##0.#00");

                XMLFixingData = (_NewXML_Fixing.ToString());
                event_TablaFixingResult(XMLFixingData);
            }

            if (columnaEdited == 0 && !this.newDateTime.Equals(new DateTime(1, 1, 1)))
            {
                _FixingValues.Attribute("Fecha").Value = newDateTime.ToString("dd-MM-yyyy");

                double _plazo = newDateTime.Subtract(fechaInicio).Days;


                _FixingValues.Attribute("Plazo").Value = _plazo.ToString("#,##0");


                XMLFixingData = (_NewXML_Fixing.ToString());
                event_TablaFixingResult(XMLFixingData);

                DateTime _Date = new DateTime(1900, 1, 1);
                DateTime _DateEnd = this.datePikerFin.SelectedDate.Value;

                foreach (StructFixingData _Item in (List<StructFixingData>)grdTablaFixing.ItemsSource)
                {
                    if (_Item.Fecha > _Date)
                    {
                        _Date = _Item.Fecha;
                    }
                }

                if (!_DateEnd.Equals(_Date))
                {
                    this.datePikerFin.SelectedDate = _Date;
                }

                event_ChangeDateFixing(_Date);

            }

            try
            {


                var elements = from elementItem in _NewXML_Fixing.Descendants("FixingValues")
                               select new StructFixingData
                               {
                                   Fecha = DateTime.Parse(elementItem.Attribute("Fecha").Value.ToString()),
                                   Valor = double.Parse(elementItem.Attribute("Valor").Value.ToString()),
                                   Peso = double.Parse(elementItem.Attribute("Peso").Value.ToString()),
                                   Volatilidad = double.Parse(elementItem.Attribute("Volatilidad").Value.ToString()),
                                   Plazo = int.Parse(elementItem.Attribute("Plazo").Value.ToString())

                               };

                fixingdataList = new List<StructFixingData>(elements.ToList<StructFixingData>());

                this.grdTablaFixing.CommitEdit(DataGridEditingUnit.Cell, true);




            }
            catch { }

            isEditing = false;

        }

        #endregion

        private void event_TextBox_GotFocus(object sender, RoutedEventArgs e)
        {
            isEditing = true;

        }

        private void event_datePikerInicio_SelectedDateChanged(object sender, SelectionChangedEventArgs e)
        {
            try
            {
                this.fechaInicio = (sender as DatePicker).SelectedDate.Value;

                if (strike != 0 && isEditing == false)
                {
                    if (!((ComboBoxItem)this.comboFrecuencia.SelectedItem).Content.Equals("Custom") && !((ComboBoxItem)this.comboTipoPeso.SelectedItem).Content.Equals("Custom"))
                    {
                        this.Crear();
                    }
                    else
                    {
                        if (fixingdataList.Count > 0)
                        {
                            fixingdataList[0].Fecha = this.datePikerInicio.SelectedDate.Value;
                            this.grdTablaFixing.ItemsSource = null;
                            this.grdTablaFixing.ItemsSource = fixingdataList;
                            Cargar(fixingdataList, true);
                        }
                    }
                }

            }
            catch
            {

            }
        }

        private void event_datePikerFin_SelectedDateChanged(object sender, SelectionChangedEventArgs e)
        {
        }

        private void DatePicker_LostFocus(object sender, RoutedEventArgs e)
        {
            try
            {
                this.fechaFin = (sender as DatePicker).SelectedDate.Value;
                if (isAsiatica && strike != 0)
                {
                    if (!((ComboBoxItem)this.comboFrecuencia.SelectedItem).Content.Equals("Custom") && !((ComboBoxItem)this.comboTipoPeso.SelectedItem).Content.Equals("Custom"))
                    {
                        this.Crear();
                    }
                    else
                    {
                        if (fixingdataList.Count > 0)
                        {
                            DateTime _Date = new DateTime(1900, 1, 1);
                            DateTime _DateEnd = this.datePikerFin.SelectedDate.Value;
                            StructFixingData _Fixing = new StructFixingData();
                            fixingdataList = (List<StructFixingData>)grdTablaFixing.ItemsSource;

                            foreach (StructFixingData _Item in fixingdataList)
                            {
                                if (_Item.Fecha >= _Date)
                                {
                                    _Date = _Item.Fecha;
                                    _Fixing = _Item;
                                }
                            }

                            if (!_DateEnd.Equals(_Date))
                            {
                                _Fixing.Fecha = this.datePikerFin.SelectedDate.Value;
                            }

                            event_ChangeDateFixing(_DateEnd);

                            this.grdTablaFixing.ItemsSource = null;
                            this.grdTablaFixing.ItemsSource = fixingdataList;
                            Cargar(fixingdataList, true);
                        }
                    }
                }
            }
            catch { }

        }

        //PRD_12567
        private void event_ClickCrearEntrada(object sender, RoutedEventArgs e)
        {
            XMLFixingDataEntrada = String_XMLFixingData(grdTablaFixingEntrada);

            if (!((ComboBoxItem)this.comboFrecuenciaEntrada.SelectedItem).Content.Equals("Custom") && !((ComboBoxItem)this.comboTipoPesoEntrada.SelectedItem).Content.Equals("Custom"))
            {

                if (this.datePikerInicioEntrada.SelectedDate != null && this.datePikerFinEntrada.SelectedDate != null && (this.checkLondresEntrada.IsChecked.Value || this.checkNewYorkEntrada.IsChecked.Value || this.checkSantiagoEntrada.IsChecked.Value))
                {

                    PesoTotal_100 = 0;
                    string intervaloEntrada = "";
                    if (this.comboFrecuenciaEntrada.SelectedIndex >= 0)
                    {
                        intervaloEntrada = ((ComboBoxItem)this.comboFrecuenciaEntrada.SelectedItem).Content.ToString();

                    }
                    string TipoPesoEntrada = "";
                    if (this.comboTipoPesoEntrada.SelectedIndex >= 0)
                    {
                        TipoPesoEntrada = ((ComboBoxItem)this.comboTipoPesoEntrada.SelectedItem).Content.ToString();
                    }

                    if (this.LoadDataEntrada())
                    {
                        //SrvAsiaticas.SrvAsiaticasSoapClient _SrvAsiaticaEntrada = new AdminOpciones.SrvAsiaticas.SrvAsiaticasSoapClient();
                        _SrvAsiaticaEntrada.generateFixingTableCompleted += new EventHandler<AdminOpciones.SrvAsiaticas.generateFixingTableCompletedEventArgs>(_SrvAsiaticaEntrada_generateFixingTableCompleted);
                        _SrvAsiaticaEntrada.generateFixingTableAsync(Town, fechaInicioEntrada, fechaFinEntrada, this.fechaHoy, FechaSetPrecios, intervaloEntrada, TipoPesoEntrada, paridad, call_put, compra_venta, nominal, spot, strike, curvaDom, curvaFor, enumSetPrecio, 0);
                    }
                }
            }
            else
            {
                string intervaloEntrada = "";
                if (this.comboFrecuenciaEntrada.SelectedIndex >= 0)
                {
                    intervaloEntrada = ((ComboBoxItem)this.comboFrecuenciaEntrada.SelectedItem).Content.ToString();
                }
                string TipoPesoEntrada = "";
                if (this.comboTipoPesoEntrada.SelectedIndex >= 0)
                {
                    TipoPesoEntrada = ((ComboBoxItem)this.comboTipoPesoEntrada.SelectedItem).Content.ToString();
                }

                //SrvAsiaticas.SrvAsiaticasSoapClient _SrvAsiatica = new AdminOpciones.SrvAsiaticas.SrvAsiaticasSoapClient();
                //Salida? _SrvAsiatica.ReLoadFixingTableCompleted += new EventHandler<AdminOpciones.SrvAsiaticas.ReLoadFixingTableCompletedEventArgs>(_SrvAsiatica_ReLoadFixingTableCompletedEntrada);
                //Salida? _SrvAsiatica.ReLoadFixingTableAsync(fechaInicio, fechaFin, fechaHoy, FechaSetPrecios, intervaloEntrada, TipoPesoEntrada, paridad, spot, strike, curvaDom, curvaFor, enumSetPrecio, XMLFixingData);
                _SrvAsiaticaEntrada.ReLoadFixingTableCompleted += new EventHandler<AdminOpciones.SrvAsiaticas.ReLoadFixingTableCompletedEventArgs>(_SrvAsiatica_ReLoadFixingTableCompletedEntrada);
                _SrvAsiaticaEntrada.ReLoadFixingTableAsync(fechaInicio, fechaFin, fechaHoy, FechaSetPrecios, intervaloEntrada, TipoPesoEntrada, paridad, spot, strike, curvaDom, curvaFor, enumSetPrecio, XMLFixingDataEntrada);
            }

        }

        private string String_XMLFixingData(DataGrid grd)
        {
            string _XMLFixingDataES = "<FixingData>";
            foreach (StructFixingData FixingData in (List<StructFixingData>)grd.ItemsSource)
            {
                _XMLFixingDataES += string.Format(
                                                    "<FixingValues Fecha='{0}' Valor='{1}' Peso='{2}' Volatilidad='{3}' Plazo='{4}' />",
                                                    FixingData.Fecha.ToString("dd-MM-yyyy"),
                                                    FixingData.Valor.ToString(),
                                                    FixingData.Peso.ToString(),
                                                    FixingData.Volatilidad.ToString(),
                                                    FixingData.Plazo.ToString()
                                                 );
            }
            _XMLFixingDataES += "</FixingData>";

            return _XMLFixingDataES;
        }

        public void CrearEntrada()
        {
            event_ShowFixing(true);
            if (!((ComboBoxItem)this.comboFrecuenciaEntrada.SelectedItem).Content.Equals("Custom") && !((ComboBoxItem)this.comboTipoPesoEntrada.SelectedItem).Content.Equals("Custom"))
            {
                string intervaloEntrada = "";
                if (this.comboFrecuenciaEntrada.SelectedIndex >= 0)
                {
                    intervaloEntrada = ((ComboBoxItem)this.comboFrecuenciaEntrada.SelectedItem).Content.ToString();
                }
                string TipoPesoEntrada = "";
                if (this.comboTipoPesoEntrada.SelectedIndex >= 0)
                {
                    TipoPesoEntrada = ((ComboBoxItem)this.comboTipoPesoEntrada.SelectedItem).Content.ToString();
                }

                if (this.LoadDataEntrada())
                {
                    _SrvAsiaticaEntrada.generateFixingTableCompleted += new EventHandler<AdminOpciones.SrvAsiaticas.generateFixingTableCompletedEventArgs>(_SrvAsiaticaEntrada_generateFixingTableCompleted);
                    _SrvAsiaticaEntrada.generateFixingTableAsync(Town, fechaInicioEntrada, fechaFinEntrada, this.fechaHoy, FechaSetPrecios, intervaloEntrada, TipoPesoEntrada, paridad, call_put, compra_venta, nominal, spot, strike, curvaDom, curvaFor, enumSetPrecio, 0);
                }
            }
            else
            {
                event_ShowFixing(false);
            }
        }

        /// <summary>
        /// Setea fechas de inicio y fin para TablaFixing (Entrada) desde DatePicker
        /// </summary>
        /// <returns></returns>
        public bool LoadDataEntrada()
        {
            try
            {
                fechaInicioEntrada = datePikerInicioEntrada.SelectedDate.Value;
                fechaFinEntrada = datePikerFinEntrada.SelectedDate.Value;
                event_LoadDataTableFixingData();

                return true;
            }
            catch
            {
                return false;
            }
        }

        private void _SrvAsiaticaEntrada_generateFixingTableCompleted(object sender, AdminOpciones.SrvAsiaticas.generateFixingTableCompletedEventArgs e)
        {
            event_TablaFixingLoadedFromValCartera(false);//cambia un flag
            Result_FixingTable_CompletedEntrada(e.Result);//setea valores de nuevo fixing Entrada
            event_ShowFixing(false);//efecto visual
        }

        private void Result_FixingTable_CompletedEntrada(string Result)
        {
            XMLFixingDataEntrada = Result;
            event_TablaFixingResultEntrada(XMLFixingDataEntrada);

            try
            {
                XDocument xdoc = new XDocument(XDocument.Parse(XMLFixingDataEntrada));

                var elements = from elementItem in xdoc.Descendants("FixingValues")
                               select new StructFixingData
                               {
                                   Fecha = DateTime.Parse(elementItem.Attribute("Fecha").Value.ToString()),
                                   Valor = double.Parse(elementItem.Attribute("Valor").Value.ToString()),
                                   Peso = -1.0 * Math.Abs(double.Parse(elementItem.Attribute("Peso").Value)), //ASVG_20130212 PRD_12567
                                   Volatilidad = double.Parse(elementItem.Attribute("Volatilidad").Value.ToString()),
                                   Plazo = DateTime.Parse(elementItem.Attribute("Fecha").Value.ToString()).Subtract(this.fechaInicio).Days

                               };

                fixingdataListEntrada = new List<StructFixingData>(elements.ToList<StructFixingData>());

                XDocument xdocGrid = new XDocument(XDocument.Parse(XMLFixingDataEntrada));

                var elementsGrid = from elementItem in xdocGrid.Descendants("FixingValues")
                               select new StructFixingData
                               {
                                   Fecha = DateTime.Parse(elementItem.Attribute("Fecha").Value.ToString()),
                                   Valor = double.Parse(elementItem.Attribute("Valor").Value.ToString()),
                                   Peso = double.Parse(elementItem.Attribute("Peso").Value.ToString()),
                                   Volatilidad = double.Parse(elementItem.Attribute("Volatilidad").Value.ToString()),
                                   Plazo = DateTime.Parse(elementItem.Attribute("Fecha").Value.ToString()).Subtract(this.fechaInicio).Days

                               };

                List<StructFixingData> fixingdataListCargaGrilla = new List<StructFixingData>(elementsGrid.ToList<StructFixingData>());

                this.grdTablaFixingEntrada.ItemsSource = fixingdataListCargaGrilla;
                
                PesoTotal_100 = 0;
                for (int i = 0; i < fixingdataListEntrada.Count; i++)
                {
                    this.PesoTotal_100_Entrada += fixingdataListEntrada[i].Peso;

                }
            }
            catch { }

        }

        void _SrvAsiatica_ReLoadFixingTableCompletedEntrada(object sender, AdminOpciones.SrvAsiaticas.ReLoadFixingTableCompletedEventArgs e)
        {
            Result_FixingTable_CompletedEntrada(e.Result);
        }

        public void CargarEntrada(List<StructFixingData> FixingDataListToLoad, bool isLoadedFromValCartera)
        {
            if (FixingDataListToLoad != null)
            {
               
               this.fixingdataListEntrada = FixingDataListToLoad;
              
               string _fixingDataXML = "<FixingData>\n";
            
                for (int i = 0; i < FixingDataListToLoad.Count; i++)
                {
                    _fixingDataXML += string.Format(
                                                     "<FixingValues Fecha='{0}' Valor='{1}' Peso='{2}' Volatilidad='{3}' Plazo='{4}' />\n",
                                                     FixingDataListToLoad[i].Fecha,
                                                     FixingDataListToLoad[i].Valor,
                                                     FixingDataListToLoad[i].Peso * -1,
                                                     FixingDataListToLoad[i].Volatilidad,
                                                     FixingDataListToLoad[i].Fecha.Subtract(this.fechaHoy).Days.ToString()
                                                   );
                }
                _fixingDataXML += "</FixingData>\n";


                event_TablaFixingLoadedFromValCartera(isLoadedFromValCartera);

                XMLFixingDataEntrada = _fixingDataXML;

                XDocument xdoc = new XDocument(XDocument.Parse(_fixingDataXML));

                var elements = from elementItem in xdoc.Descendants("FixingValues")
                               select new StructFixingData
                               {
                                   Fecha = DateTime.Parse(elementItem.Attribute("Fecha").Value.ToString()),
                                   Valor = double.Parse(elementItem.Attribute("Valor").Value.ToString()),
                                   Peso =  double.Parse(elementItem.Attribute("Peso").Value)< 0 ? //cambiar esto por un Math.Abs
                                           double.Parse(elementItem.Attribute("Peso").Value)* -1 : double.Parse(elementItem.Attribute("Peso").Value),
                                   Volatilidad = double.Parse(elementItem.Attribute("Volatilidad").Value.ToString()),
                                   Plazo = DateTime.Parse(elementItem.Attribute("Fecha").Value.ToString()).Subtract(this.fechaInicio).Days

                               };
                List<StructFixingData> fixingdataListEntrada = new List<StructFixingData>(elements.ToList<StructFixingData>());
                
                //fixingdataListEntrada = new List<StructFixingData>(elements.ToList<StructFixingData>());

                //this.grdTablaFixing.ItemsSource = FixingDataListToLoad.Where(_Element => _Element.Peso > 0).ToList();//PRD_12567

                event_TablaFixingResultEntrada(_fixingDataXML);
                this.grdTablaFixingEntrada.ItemsSource = null;
                this.grdTablaFixingEntrada.ItemsSource = fixingdataListEntrada;            
                this.grdTablaFixingEntrada.UpdateLayout();
            }
        }

        //validar cuando se interrumpa en este pundo que el sender sea de Entrada
        private void event_datePikerInicio_SelectedDateChangedEntrada(object sender, SelectionChangedEventArgs e)
        {
            try
            {
                //acá estábamos pisando...
                //this.fechaInicio = (sender as DatePicker).SelectedDate.Value;
                //PATO
                this.fechaInicioEntrada = (sender as DatePicker).SelectedDate.Value;

                //alan, validar: if (strike != 0 && isEditing == false)
                //PATO
                if (strike != 0 && isEditingEntrada == false)
                {
                    //esto era para Salida... if (!((ComboBoxItem)this.comboFrecuenciaEntrada.SelectedItem).Content.Equals("Custom") && !((ComboBoxItem)this.comboTipoPeso.SelectedItem).Content.Equals("Custom"))
                    //PATO
                    if (!((ComboBoxItem)this.comboFrecuenciaEntrada.SelectedItem).Content.Equals("Custom") && !((ComboBoxItem)this.comboTipoPesoEntrada.SelectedItem).Content.Equals("Custom"))
                    {
                        this.CrearEntrada();
                    }
                    else
                    {
                        if (fixingdataListEntrada.Count > 0)
                        {
                            //Salida? fixingdataList[0].Fecha = this.datePikerInicioEntrada.SelectedDate.Value;
                            //PATO
                            fixingdataListEntrada[0].Fecha = this.datePikerInicioEntrada.SelectedDate.Value;
                            this.grdTablaFixingEntrada.ItemsSource = null;
                            //Salida? this.grdTablaFixingEntrada.ItemsSource = fixingdataList;
                            //PATO
                            this.grdTablaFixingEntrada.ItemsSource = fixingdataListEntrada;
                            CargarEntrada(fixingdataListEntrada, true);
                        }
                    }
                }

            }
            catch
            {

            }

        }

        private void event_DatePickerNewDateEntrada_GotFocus(object sender, RoutedEventArgs e)
        {
            isEditingEntrada = true;
        }

        private void event_TextBoxEditEntrada_LostFocus(object sender, RoutedEventArgs e)
        {
            string xmlFixing = this.XMLFixingDataEntrada;
            XDocument _NewXML_Fixing = new XDocument(XDocument.Parse(xmlFixing));
            XElement _FixingValues = _NewXML_Fixing.Element("FixingData").Elements("FixingValues").ElementAt(this.filaEdited);

            TextBox _textBox = sender as TextBox;

            if (columnaEditedEntrada == 1)
            {
                valtxtPeso.LostFocus(_textBox);
                try
                {
                    if (double.Parse(_textBox.Text) < 0)
                    {
                        _textBox.Text = pesoBeforeEditEntrada.ToString("#,##0.#0000");
                        PesoTotal_100_Entrada = 1;
                        pesoAfterEditEntrada = pesoBeforeEditEntrada;

                    }
                    else
                    {
                        PesoTotal_100_Entrada -= this.pesoBeforeEditEntrada;

                        if ((PesoTotal_100_Entrada + double.Parse(_textBox.Text)) > 1.00)
                        {
                            if (1 - PesoTotal_100_Entrada >= 0)
                            {
                                pesoAfterEditEntrada = 1 - PesoTotal_100_Entrada;

                                _textBox.Text = (1 - PesoTotal_100_Entrada).ToString("#,##0.#0000");
                                PesoTotal_100_Entrada += 1 - PesoTotal_100_Entrada;
                            }
                            else
                            {
                                _textBox.Text = pesoBeforeEditEntrada.ToString("#,##0.#0000");
                                PesoTotal_100_Entrada = 1;
                                pesoAfterEditEntrada = pesoBeforeEditEntrada;


                            }
                        }
                        else
                        {
                            PesoTotal_100_Entrada += double.Parse(_textBox.Text);
                            pesoAfterEditEntrada = double.Parse(_textBox.Text);

                        }
                    }
                }
                catch
                {
                    _textBox.Text = pesoBeforeEditEntrada.ToString("#,##0.#0000");
                    PesoTotal_100_Entrada = 1;
                    pesoAfterEditEntrada = pesoBeforeEditEntrada;

                }

                //--------------

                _FixingValues.Attribute("Peso").Value = pesoAfterEdit.ToString("#,##0.#0000");

                //Salida? XMLFixingData = (_NewXML_Fixing.ToString());
                //Salida? event_TablaFixingResult(XMLFixingData);
                //PATO
                XMLFixingDataEntrada = (_NewXML_Fixing.ToString());
                //PATO
                event_TablaFixingResult(XMLFixingDataEntrada);
            }
            if (columnaEditedEntrada == 2 && !fijacionBeforeEditEntrada.Equals(double.NaN))
            {
                try
                {
                    valtxtFijacion.LostFocus(_textBox);

                    if (double.Parse(_textBox.Text) < 0)
                    {
                        _textBox.Text = fijacionBeforeEditEntrada.ToString("#,##0.#0000");
                        fijacionAfterEditEntrada = fijacionBeforeEditEntrada;
                    }
                    else
                    {
                        fijacionAfterEditEntrada = double.Parse(_textBox.Text);
                    }

                    _FixingValues.Attribute("Valor").Value = this.fijacionAfterEditEntrada.ToString("#,##0.#00");

                    //Salida? XMLFixingData = (_NewXML_Fixing.ToString());
                    //Salida? event_TablaFixingResult(XMLFixingData);
                    //PATO
                    XMLFixingDataEntrada = (_NewXML_Fixing.ToString());
                    //PATO
                    event_TablaFixingResult(XMLFixingDataEntrada);
                }
                catch
                {
                    _textBox.Text = fijacionBeforeEditEntrada.ToString("#,##0.#0000");
                    fijacionAfterEditEntrada = fijacionBeforeEditEntrada;
                }
            }

            if (columnaEditedEntrada == 3 && !ValorDoubleEntrada.Equals(double.NaN))
            {
                _FixingValues.Attribute("Volatilidad").Value = ValorDoubleEntrada.ToString("#,##0.#00");

                //Salida? XMLFixingData = (_NewXML_Fixing.ToString());
                //Salida? event_TablaFixingResult(XMLFixingData);
                //PATO
                XMLFixingDataEntrada = (_NewXML_Fixing.ToString());
                //PATO
                event_TablaFixingResult(XMLFixingDataEntrada);
            }

            if (columnaEditedEntrada == 0 && !this.newDateTimeEntrada.Equals(new DateTime(1, 1, 1)))
            {
                _FixingValues.Attribute("Fecha").Value = newDateTimeEntrada.ToString("dd-MM-yyyy");

                double _plazo = newDateTimeEntrada.Subtract(fechaInicio).Days;


                _FixingValues.Attribute("Plazo").Value = _plazo.ToString("#,##0");


                XMLFixingDataEntrada = (_NewXML_Fixing.ToString());
                //Salida? event_TablaFixingResult(XMLFixingData);
                //PATO
                event_TablaFixingResult(XMLFixingDataEntrada);

                DateTime _Date = new DateTime(1900, 1, 1);
                DateTime _DateEnd = this.datePikerFinEntrada.SelectedDate.Value;

                foreach (StructFixingData _Item in (List<StructFixingData>)grdTablaFixingEntrada.ItemsSource)
                {
                    if (_Item.Fecha > _Date)
                    {
                        _Date = _Item.Fecha;
                    }
                }

                if (!_DateEnd.Equals(_Date))
                {
                    this.datePikerFinEntrada.SelectedDate = _Date;
                }

                event_ChangeDateFixing(_Date);

            }

            try
            {


                var elements = from elementItem in _NewXML_Fixing.Descendants("FixingValues")
                               select new StructFixingData
                               {
                                   Fecha = DateTime.Parse(elementItem.Attribute("Fecha").Value.ToString()),
                                   Valor = double.Parse(elementItem.Attribute("Valor").Value.ToString()),
                                   Peso = double.Parse(elementItem.Attribute("Peso").Value) * -1,
                                   Volatilidad = double.Parse(elementItem.Attribute("Volatilidad").Value.ToString()),
                                   Plazo = int.Parse(elementItem.Attribute("Plazo").Value.ToString())

                               };

                fixingdataListEntrada = new List<StructFixingData>(elements.ToList<StructFixingData>());

                this.grdTablaFixingEntrada.CommitEdit(DataGridEditingUnit.Cell, true);




            }
            catch { }

            isEditingEntrada = false;

        }

        private void event_grdFixingDataEntrada_PreparingForEdit(object sender, DataGridPreparingCellForEditEventArgs e)
        {
            try
            {
                this.filaEditedEntrada = this.grdTablaFixingEntrada.SelectedIndex;
                this.columnaEditedEntrada = this.grdTablaFixingEntrada.CurrentColumn.DisplayIndex;
                ValorDoubleEntrada = double.NaN;
                newDateTimeEntrada = new DateTime(1, 1, 1);

                PesoTotal_100_Entrada = 0;

                foreach (StructFixingData _fix in this.fixingdataListEntrada)
                {
                    PesoTotal_100_Entrada += _fix.Peso;
                }

                if (columnaEditedEntrada == 1)
                {
                    this.pesoBeforeEditEntrada = double.Parse(e.EditingElement.GetValue(TextBox.TextProperty).ToString());
                    valtxtPeso.SetChange((e.EditingElement as TextBox), pesoBeforeEditEntrada);

                }
                else if (columnaEditedEntrada == 2)
                {
                    this.fijacionBeforeEditEntrada = double.Parse(e.EditingElement.GetValue(TextBox.TextProperty).ToString());
                    this.valtxtFijacion.SetChange((e.EditingElement as TextBox), fijacionBeforeEditEntrada);
                }
                else if (columnaEditedEntrada > 2)
                {
                    this.ValorDoubleEntrada = double.Parse(e.EditingElement.GetValue(TextBox.TextProperty).ToString());
                    valtxtDouble.SetChange((e.EditingElement as TextBox), ValorDoubleEntrada);
                }
                else if (columnaEditedEntrada == 0)
                {
                    this.newDateTimeEntrada = DateTime.Parse(e.EditingElement.GetValue(DatePicker.SelectedDateProperty).ToString());
                }

            }
            catch
            {
                if (columnaEditedEntrada == 1)
                {
                    this.pesoBeforeEditEntrada = double.NaN;
                }
                else if (columnaEditedEntrada == 2)
                {
                    this.fijacionBeforeEditEntrada = double.NaN;
                }
                else if (columnaEditedEntrada > 2)
                {
                    this.ValorDoubleEntrada = double.NaN;
                }
                else if (columnaEditedEntrada == 0)
                {
                    newDateTimeEntrada = new DateTime(1, 1, 1);
                }
            }
        }

        private void event_grdFixingDataEntrada_KeyDown(object sender, KeyEventArgs e)
        {
            if (!isEditingEntrada && this.grdTablaFixingEntrada.SelectedIndex >= 0 && ((ComboBoxItem)this.comboFrecuenciaEntrada.SelectedItem).Content.Equals("Custom"))
            {
                if (e.Key == Key.Insert)
                {
                    int _index = grdTablaFixingEntrada.SelectedIndex;
                    DateTime _newDateTime = new DateTime();
                    _newDateTime = fixingdataListEntrada[_index].Fecha;
                    StructFixingData _newDataFixing = new StructFixingData(new DateTime(_newDateTime.Year, _newDateTime.Month, _newDateTime.Day), 0, 0, 0, fixingdataListEntrada[_index].Plazo);
                    this.fixingdataListEntrada.Insert(_index, _newDataFixing);

                    event_TablaFixing_CalculaPesoEntrada(((ComboBoxItem)this.comboTipoPesoEntrada.SelectedItem).Content.ToString());
                    //this.grdTablaFixing.ItemsSource = null;
                    //this.grdTablaFixing.ItemsSource = this.fixingdataList;
                    CargarEntrada(fixingdataListEntrada, false);

                    this.grdTablaFixingEntrada.SelectedIndex = _index;
                }

                if (e.Key == Key.Delete)
                {
                    int _index = grdTablaFixingEntrada.SelectedIndex;
                    double _peso = fixingdataListEntrada[_index].Peso;

                    this.fixingdataListEntrada.RemoveAt(_index);

                    event_TablaFixing_CalculaPesoEntrada(((ComboBoxItem)this.comboTipoPesoEntrada.SelectedItem).Content.ToString());


                    //this.grdTablaFixing.ItemsSource = null;
                    //this.grdTablaFixing.ItemsSource = this.fixingdataList;

                    CargarEntrada(fixingdataListEntrada, false);

                    if (_index == fixingdataListEntrada.Count)
                    {
                        this.grdTablaFixingEntrada.SelectedIndex = _index - 1;
                    }
                    else
                    {
                        this.grdTablaFixingEntrada.SelectedIndex = _index;
                    }
                    PesoTotal_100_Entrada -= _peso;

                }

                isEditingEntrada = false;
            }
            else if (!isEditingEntrada && this.grdTablaFixingEntrada.SelectedIndex < 0 && ((ComboBoxItem)this.comboFrecuenciaEntrada.SelectedItem).Content.Equals("Custom"))
            {

                if (e.Key == Key.Insert)
                {
                    int _index = 0;
                    DateTime _newDateTime = new DateTime();
                    _newDateTime = fechaHoy;
                    StructFixingData _newDataFixing = new StructFixingData(new DateTime(_newDateTime.Year, _newDateTime.Month, _newDateTime.Day), 0, 1, 0, 0);
                    this.fixingdataListEntrada.Insert(_index, _newDataFixing);

                    this.grdTablaFixingEntrada.ItemsSource = null;
                    this.grdTablaFixingEntrada.ItemsSource = this.fixingdataListEntrada;
                    CargarEntrada(fixingdataListEntrada, false);

                    this.grdTablaFixingEntrada.SelectedIndex = _index;

                    isEditingEntrada = false;
                }
            }

        }

        private void event_FechaFijacionEntrada_SelectedDateChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        private void event_TextBoxEntrada_GotFocus(object sender, RoutedEventArgs e)
        {
            isEditingEntrada = true;
        }

        private void event_TextBoxEntrada_TextChanged(object sender, TextChangedEventArgs e)
        {
            TextBox _textBox = sender as TextBox;
            if (columnaEditedEntrada == 1)
            {
                this.valtxtPeso.TextChange(_textBox);
            }
            else if (columnaEditedEntrada == 2)
            {
                this.valtxtFijacion.TextChange(_textBox);
            }
            else if (columnaEditedEntrada > 2)
            {
                this.valtxtDouble.TextChange(_textBox);
            }

            try
            {
                if (columnaEditedEntrada == 1)
                {
                    pesoAfterEditEntrada = double.Parse(((TextBox)sender).Text);
                }
                else if (columnaEditedEntrada == 2)
                {
                    fijacionAfterEditEntrada = double.Parse(((TextBox)sender).Text);
                }
                else if (columnaEditedEntrada > 2)
                {
                    ValorDoubleEntrada = double.Parse(((TextBox)sender).Text);
                }
            }
            catch
            {
                if (columnaEditedEntrada == 1)
                {
                    pesoAfterEditEntrada = pesoBeforeEditEntrada;
                }
                else if (columnaEditedEntrada == 2)
                {
                    fijacionAfterEditEntrada = fijacionBeforeEditEntrada;
                }

            }
        }

        private void event_TextBoxEntrada_KeyDown(object sender, KeyEventArgs e)
        {
            TextBox _textBox = sender as TextBox;

            this.valtxtDouble.KeyDown(_textBox);

            if (columnaEditedEntrada == 1)
            {
                this.valtxtPeso.KeyDown(_textBox);
            }
            else if (columnaEditedEntrada == 2)
            {
                this.valtxtFijacion.KeyDown(_textBox);
            }
            else if (columnaEditedEntrada > 2)
            {
                this.valtxtDouble.KeyDown(_textBox);
            }
        }

        private void DatePickerEntrada_LostFocus(object sender, RoutedEventArgs e)
        {

            try
            {
                this.fechaFinEntrada = (sender as DatePicker).SelectedDate.Value;
                if (isAsiatica && strike != 0)
                {
                    if (!((ComboBoxItem)this.comboFrecuenciaEntrada.SelectedItem).Content.Equals("Custom") && !((ComboBoxItem)this.comboTipoPesoEntrada.SelectedItem).Content.Equals("Custom"))
                    {
                        this.CrearEntrada();
                    }
                    else
                    {
                        if (fixingdataListEntrada.Count > 0)
                        {
                            DateTime _Date = new DateTime(1900, 1, 1);
                            DateTime _DateEnd = this.datePikerFinEntrada.SelectedDate.Value;
                            StructFixingData _Fixing = new StructFixingData();
                            fixingdataListEntrada = (List<StructFixingData>)grdTablaFixingEntrada.ItemsSource;

                            foreach (StructFixingData _Item in fixingdataListEntrada)
                            {
                                if (_Item.Fecha >= _Date)
                                {
                                    _Date = _Item.Fecha;
                                    _Fixing = _Item;
                                }
                            }

                            if (!_DateEnd.Equals(_Date))
                            {
                                _Fixing.Fecha = this.datePikerFinEntrada.SelectedDate.Value;
                            }

                            event_ChangeDateFixing(_DateEnd);

                            this.grdTablaFixingEntrada.ItemsSource = null;
                            this.grdTablaFixingEntrada.ItemsSource = fixingdataListEntrada;
                            CargarEntrada(fixingdataListEntrada, true);
                        }
                    }
                }
            }
            catch { }

        }

        private void event_datePikerFinEntrada_SelectedDateChanged(object sender, SelectionChangedEventArgs e)
        {

        }

        //REVISAR
        private void event_ClickTown_CheckedEntrada(object sender, RoutedEventArgs e)
        {
            this.Town = 0;

            if (!checkNewYorkEntrada.IsChecked.Value && !checkSantiagoEntrada.IsChecked.Value && checkLondresEntrada.IsChecked.Value)
            {
                Town = 1;
            }
            if (!checkNewYorkEntrada.IsChecked.Value && checkSantiagoEntrada.IsChecked.Value && !checkLondresEntrada.IsChecked.Value)
            {
                Town = 2;
            }
            if (!checkNewYorkEntrada.IsChecked.Value && checkSantiagoEntrada.IsChecked.Value && checkLondresEntrada.IsChecked.Value)
            {
                Town = 3;
            }
            if (checkNewYorkEntrada.IsChecked.Value && !checkSantiagoEntrada.IsChecked.Value && !checkLondresEntrada.IsChecked.Value)
            {
                Town = 4;
            }
            if (checkNewYorkEntrada.IsChecked.Value && !checkSantiagoEntrada.IsChecked.Value && checkLondresEntrada.IsChecked.Value)
            {
                Town = 5;
            }
            if (checkNewYorkEntrada.IsChecked.Value && checkSantiagoEntrada.IsChecked.Value && !checkLondresEntrada.IsChecked.Value)
            {
                Town = 6;
            }
            if (checkNewYorkEntrada.IsChecked.Value && checkSantiagoEntrada.IsChecked.Value && checkLondresEntrada.IsChecked.Value)
            {
                Town = 7;
            }

        }

        private void event_comboTipoPeso_SelectedChangedEntrada(object sender, SelectionChangedEventArgs e)
        {
            if (comboTipoPesoEntrada != null && comboTipoPesoEntrada.Items.Count > 0)
            {
                if (((ComboBoxItem)this.comboTipoPesoEntrada.SelectedItem).Content.Equals("Custom"))
                {
                    this.grdTablaFixingEntrada.Columns[1].IsReadOnly = false;
                }
                else
                {
                    this.grdTablaFixingEntrada.Columns[1].IsReadOnly = true;
                }
            }

            if (AcualizarPesosEntrada == true && comboTipoPesoEntrada != null)
            {
                event_TablaFixing_CalculaPesoEntrada(((ComboBoxItem)this.comboTipoPesoEntrada.SelectedItem).Content.ToString());
            }
        }

        /// <summary>
        /// Setea los CheckBox de calendarios (NY, SCL, LON) según el "Town".
        /// </summary>
        /// <param name="town">Código de Town, ni idea...</param>
        /// <returns></returns>
        public bool SetTown(int town)
        {
            return __SetTown(town, 1);
        }

        /// <summary>
        /// Setea los CheckBox de calendarios (NY, SCL, LON) según el "Town".
        /// </summary>
        /// <param name="town">Código de Town, ni idea...</param>
        /// <returns></returns>
        public bool SetTownEntrada(int town)
        {
            return __SetTown(town, -1);
        }

        /// <summary>
        /// Setea los CheckBox de calendarios (NY, SCL, LON) según el "Town".
        /// </summary>
        /// <param name="town">Código de Town, parece ser un entero de un byte con los bits de check</param>
        /// <param name="signo">Código de tipo de tabla de fixing, Entrada: -1 o Salida: 1.</param>
        /// <returns>Retorna false si no reconoce el código de "Town" o el "signo".</returns>
        private bool __SetTown(int town, int signo)
        {
            bool retval = true;
            bool t1, t2, t3;
            string chk_t1 = "", chk_t2 = "", chk_t3 = "";
            if (signo == 1) { chk_t1 = "checkNewYork"; chk_t2 = "checkSantiago"; chk_t3 = "checkLondres"; }
            else if (signo == -1) { chk_t1 = "checkNewYorkEntrada"; chk_t2 = "checkSantiagoEntrada"; chk_t3 = "checkLondresEntrada"; }
            else return false;

            switch (town)
            {
                case 0: t1 = false; t2 = false; t3 = false; break;
                case 1: t1 = false; t2 = false; t3 = true;  break;
                case 2: t1 = false; t2 = true;  t3 = false; break;
                case 3: t1 = false; t2 = true;  t3 = true;  break;
                case 4: t1 = true;  t2 = false; t3 = false; break;
                case 5: t1 = true;  t2 = false; t3 = true;  break;
                case 6: t1 = true;  t2 = true;  t3 = false; break;
                case 7: t1 = true;  t2 = true;  t3 = true;  break;

                default: return false;
            }

            ((CheckBox)this.FindName(chk_t1)).IsChecked = t1;
            ((CheckBox)this.FindName(chk_t2)).IsChecked = t2;
            ((CheckBox)this.FindName(chk_t3)).IsChecked = t3;

            return retval;
        }

    }
}
