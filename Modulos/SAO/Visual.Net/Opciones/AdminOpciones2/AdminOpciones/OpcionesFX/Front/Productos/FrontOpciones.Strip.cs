using System;
using System.Net;
using System.Windows;
using System.Windows.Controls;

//Falta definir en qué clase se manejarán los eventos y pantalla.
using System.Windows.Browser;
using System.Windows.Input;
using Liquid;

//Using necesarios para servicios.
using System.Collections.Generic;   //Para List
using System.Linq;                  //Para "select"
using System.Xml.Linq;              //Para XDocument
using AdminOpciones.Recursos;       //Para wsGlobales
using AdminOpciones.Valid;          //Para ValidAmount

//Using para estructuras de negocio
using AdminOpciones.Struct.OpcionesXF.Asiatica;
using AdminOpciones.Struct; //Para Strip

namespace AdminOpciones.OpcionesFX.Front
{
    public partial class FontOpciones
    {

        #region STRIP ASIATICO

        private void event_btnStrip_Click(object sender, RoutedEventArgs e)
        {

            if (_opcionEstructuraSeleccionada.Codigo.Equals("9") || _opcionEstructuraSeleccionada.Codigo.Equals("10"))
            {
                if (txtStrike1.Text == "" || txtNocional.Text == "" || txtPlazo.Text == "")
                {
                    System.Windows.Browser.HtmlPage.Window.Alert("El campo Nocional, Strike y Plazo deben tener valores");
                }
                else
                {
                    if (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.ToString().Equals("Asiaticas"))
                    {

                        if (_TablaFixing.comboTipoPeso.SelectionBoxItem == null)
                        {
                            System.Windows.Browser.HtmlPage.Window.Alert("verifique fixing antes de configurar Strip Asiático");
                            popUpTablaFixing.Show();
                        }
                        else
                        {
                            //Setear valores default pantalla
                            DateFechaInicio.Text = datePiker_DateProccess.Text;
                            DateFechaVencimiento.Text = DatePickerVencimiento.Text;

                            for (int i = 0; i < cmbPeriodicidad.Items.Count; i++)
                            {


                                if (i < this._TablaFixing.comboFrecuencia.SelectedIndex)
                                {
                                    ((ComboBoxItem)cmbPeriodicidad.Items[i]).IsEnabled = false;
                                }
                                else
                                {
                                    ((ComboBoxItem)cmbPeriodicidad.Items[i]).IsEnabled = true;
                                }
                                if (i == this._TablaFixing.comboFrecuencia.SelectedIndex)
                                {
                                    ((ComboBoxItem)cmbPeriodicidad.Items[i]).IsSelected = true;
                                }
                            }

                            popupStrip.Show();
                        }
                    }
                    else
                    {
                        System.Windows.Browser.HtmlPage.Window.Alert("La opción PayOFF deberá ser la Asiática");
                    }
                }
            }
            else
            {
                System.Windows.Browser.HtmlPage.Window.Alert("El Strip solo opera con operaciones CALL o PUT Asiático");
            }
        }

        private void ClearStrip()
        {
            if (StripList != null)
            {
                StripList.Clear();
                GridStrip.ItemsSource = null;
                GridFixingStrip.ItemsSource = null;
            }
        }

        //click al botón "Strip"
        private void btnCreaStrip(object sender, RoutedEventArgs e)
        {
            if (cmbPeriodicidad != null)
            {
                if (cmbPeriodicidad.SelectedItem != null)
                {
                    ClearStrip();

                    double nocional = double.Parse(txtNocional.Text);
                    double strike = double.Parse(txtStrike1.Text);
                    //DateTime FI = new DateTime(DateTime.Parse(datePiker_DateProccess.Text).Ticks);
                    DateTime FI = new DateTime(DateTime.Parse(DateFechaInicio.Text).Ticks);
                    DateTime FF = new DateTime(DateTime.Parse(DatePickerVencimiento.Text).Ticks);
                    DateTime FV = new DateTime(DateTime.Parse(datePiker_DateProccess.Text).Ticks);
                    int Strip = 1;

                    if (FI < FV)
                    {
                        string Mensaje = "Fecha Primer corte no puede ser menor a Fecha Proceso";
                        System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
                        return;
                    }

                    if (FI > FF)
                    {
                        string Mensaje = "Fecha Primer corte no puede ser mayor a Fecha vencimiento";
                        System.Windows.Browser.HtmlPage.Window.Alert(Mensaje);
                        return;
                    }

                    //SrvAsiaticas.SrvAsiaticasSoapClient _SrvAsiatica2 = new AdminOpciones.SrvAsiaticas.SrvAsiaticasSoapClient();
                    SrvAsiaticas.SrvAsiaticasSoapClient _SrvAsiatica2 = wsGlobales.Asiaticas;

                    _SrvAsiatica2.GenerateStripTableCompleted += new EventHandler<AdminOpciones.SrvAsiaticas.GenerateStripTableCompletedEventArgs>(_SrvAsiatica2_generateFixingTableCompleted);
                    _SrvAsiatica2.GenerateStripTableAsync(Town, FI, FF, FV, this.FechaSetdePrecios, cmbPeriodicidad.SelectionBoxItem.ToString(), _TablaFixing.comboTipoPeso.SelectionBoxItem.ToString(), paridad, call_put, compra_venta, nocional, spot, strike, curvaDom, curvaFor, this.setPrecios_Pricing, 0, Strip);
                }
            }
        }

        private void _SrvAsiatica2_generateFixingTableCompleted(object sender, AdminOpciones.SrvAsiaticas.GenerateStripTableCompletedEventArgs e)
        {
            //sacamos las fechas de vencimiento de los contratos stripeados.
            XDocument xmlResult = new XDocument(XDocument.Parse(e.Result));
            var elements = from elementItem in xmlResult.Descendants("FixingValues")
                           select new StructFixingData
                           {
                               Fecha = DateTime.Parse(elementItem.Attribute("Fecha").Value.ToString())
                               /*,
                               Valor = double.Parse(elementItem.Attribute("Valor").Value.ToString()),
                               Peso = double.Parse(elementItem.Attribute("Peso").Value.ToString()),
                               Volatilidad = double.Parse(elementItem.Attribute("Volatilidad").Value.ToString()),
                               Plazo = int.Parse(elementItem.Attribute("Plazo").Value.ToString())
                               */
                           };
            List<StructFixingData> _FechasStripList = new List<StructFixingData>(elements.ToList<StructFixingData>());


            String DateStart = datePiker_DateProccess.Text;
            DateTime DateAnterior = DateTime.Parse(DateStart);

            //creamos una lista con los contratos (el strip)
            StripList = new List<StructStrip>();

            for (int i = 0; i < _FechasStripList.Count; i++)
            {
                CreaStrip = new StructStrip();
                CreaStrip.ID = i + 1;
                CreaStrip.FechaInicio = DateStart;
                CreaStrip.FechaInicioFixing = DateAnterior;
                CreaStrip.FechaVencimiento = _FechasStripList[i].Fecha;
                DateAnterior = CreaStrip.FechaVencimiento;
                CreaStrip.PrecioStrike = strike;
                CreaStrip.NocionalTotal = nocional;

                //extraemos la porción de Fixing que nos interesa.
                List<StructFixingData> ListFixing2 = new List<StructFixingData>();
                StructFixingData grdFixing2;

                //desde CreaStrip.FechaInicio
                //hasta CreaStrip.FechaVencimiento
                for (int k = 0; k < _TablaFixing.fixingdataList.Count; k++)
                {
                    if (
                            CreaStrip.FechaInicioFixing.CompareTo(DateTime.Parse(_TablaFixing.fixingdataList[k].sFecha)) < 0
                            &&
                            CreaStrip.FechaVencimiento.CompareTo(DateTime.Parse(_TablaFixing.fixingdataList[k].sFecha)) >= 0
                        )
                    {
                        grdFixing2 = new StructFixingData();
                        grdFixing2.Fecha = _TablaFixing.fixingdataList[k].Fecha;
                        grdFixing2.Peso = (double)0;
                        grdFixing2.Valor = _TablaFixing.fixingdataList[k].Valor;
                        grdFixing2.Volatilidad = _TablaFixing.fixingdataList[k].Volatilidad;
                        grdFixing2.Plazo = _TablaFixing.fixingdataList[k].Plazo;

                        ListFixing2.Add(grdFixing2);
                    }
                }

                //config pesos
                double sumapeso = 0.0;
                for (int p = 0; p < ListFixing2.Count; p++)
                {
                    double a = (double)1 / (double)ListFixing2.Count;
                    sumapeso = sumapeso + a;

                    if (p + 1 == ListFixing2.Count && sumapeso != 1.0)
                    {
                        double resultado = 1 - sumapeso;
                        ListFixing2[p].Peso = a + resultado;
                    }
                    else
                    {
                        ListFixing2[p].Peso = a;
                    }
                }

                CreaStrip.TablaFixing = ListFixing2;
                StripList.Add(CreaStrip);
            }

            GridStrip.ItemsSource = null;
            GridStrip.ItemsSource = StripList;


        }

        private void popupStrip_Closed(object sender, DialogEventArgs e)
        {
            popupStrip.Close();
            //DateFechaInicio.Text = "";
            //DateFechaVencimiento.Text = "";
            //cmbPeriodicidad.SelectedItem = -1;
        }

        private void event_lostFocus_FechaVencimiento(object sender, RoutedEventArgs e)
        {
            DatePickerVencimiento.Text = DateFechaVencimiento.Text;
            DatePickerVencimiento_LostFocus(sender, e);
        }

        private void event_btnGuardarStrip(object sender, RoutedEventArgs e)
        {
            popupStrip.Close();
            //FechaFinStrip = _TablaFixing.fixingdataList[_TablaFixing.fixingdataList.Count - 1].Fecha.ToString();
            isTextChanged = true;
            Valorizar();
            checkboxAsociadoStrip.IsChecked = true;
        }

        private void event_btnCerrarStrip(object sender, RoutedEventArgs e)
        {

            if (cmbPeriodicidad.SelectedItem == null)
            {
                popupStrip.Close();
            }
            else
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Se eliminarán los cambios realizados");
                StripList.Clear();
                cmbPeriodicidad.SelectedItem = -1;
                GridStrip.ItemsSource = null;
                popupStrip.Close();
            }

            checkboxAsociadoStrip.IsChecked = false;
        }

        private void event_btnEditarFixingStrip_Checked(object sender, RoutedEventArgs e)
        {

            Button bt = (Button)sender;
            int j = int.Parse(bt.Tag.ToString());
            idOperacionStripFixing = j - 1;

            List<StructFixingData> ListFixing = new List<StructFixingData>();

            StructFixingData grdFixing;

            for (int i = 0; i < StripList[j - 1].TablaFixing.Count; i++)
            {

                grdFixing = new StructFixingData();
                grdFixing.Fecha = StripList[j - 1].TablaFixing[i].Fecha;
                grdFixing.sFecha = StripList[j - 1].TablaFixing[i].sFecha;
                grdFixing.Peso = StripList[j - 1].TablaFixing[i].Peso;
                grdFixing.Plazo = StripList[j - 1].TablaFixing[i].Plazo;
                grdFixing.Valor = StripList[j - 1].TablaFixing[i].Valor;
                grdFixing.Volatilidad = StripList[j - 1].TablaFixing[i].Volatilidad;

                ListFixing.Add(grdFixing);
            }

            this.GridFixingStrip.ItemsSource = null;
            this.GridFixingStrip.ItemsSource = ListFixing;
            popupModificarFixing.Show();

        }

        //Limpiar esta función.
        private void btn_GuardaFixing(object sender, RoutedEventArgs e)
        {
            int i = 0;
            double peso = 0.0;

            foreach (StructFixingData item in (List<StructFixingData>)GridFixingStrip.ItemsSource)
            {
                peso = item.Peso + peso;
            }

            if (peso != 1)
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Error, la suma total de los pesos es de: " + peso + " y debe ser igual a 1");
            }

            else
            {
                foreach (StructFixingData item in (List<StructFixingData>)GridFixingStrip.ItemsSource)
                {
                    StripList[idOperacionStripFixing].TablaFixing[i].Peso = item.Peso;
                    StripList[idOperacionStripFixing].TablaFixing[i].sFecha = item.sFecha;
                    StripList[idOperacionStripFixing].TablaFixing[i].Fecha = item.Fecha;
                    StripList[idOperacionStripFixing].TablaFixing[i].Valor = item.Valor;
                    StripList[idOperacionStripFixing].TablaFixing[i].Volatilidad = item.Volatilidad;
                    StripList[idOperacionStripFixing].TablaFixing[i].Plazo = item.Plazo;

                    i++;

                }


                System.Windows.Browser.HtmlPage.Window.Alert("Datos guardados para la operación: " + (idOperacionStripFixing + 1) + "");
            }
            popupModificarFixing.Close();
            btnTablaFixing.IsEnabled = false;
        }

        private void btn_cancelaEditarFixingStrip(object sender, RoutedEventArgs e)
        {
            popupModificarFixing.Close();
        }

        private void popupStripModificaFixing_Closed(object sender, DialogEventArgs e)
        {
            popupModificarFixing.Close();
        }

        private void grdCopiaStrip(object sender, KeyEventArgs e)
        {
            #region Copy uisng Ctrl-C

            if (e.Key == Key.C &&
                ((Keyboard.Modifiers & ModifierKeys.Control) == ModifierKeys.Control
                || (Keyboard.Modifiers & ModifierKeys.Apple) == ModifierKeys.Apple)
                )
            {
                DataGrid DataGridStrip = sender as DataGrid;
                string textData = "";

                #region Head

                string _TextColumn = "";

                foreach (DataGridColumn _Column in DataGridStrip.Columns)
                {
                    if (_TextColumn != "")
                    {
                        if (_TextColumn == "Fixing")
                        {
                            _TextColumn = "Strip";
                        }
                        _TextColumn += "\t";
                    }
                    _TextColumn += _Column.Header;
                }

                _TextColumn += "\t";
                _TextColumn += "Fixing";

                textData += _TextColumn + "\n";

                #endregion

                #region Value

                int _ID = 1;

                foreach (StructStrip _Item in (List<StructStrip>)DataGridStrip.ItemsSource)
                {
                    textData += string.Format(
                                               "{0}\t{1}\t{2}\t{3}\t{4}\t{5}\n",
                                               _Item.ID.ToString(),
                                               _Item.FechaInicio.ToString(),
                                               _Item.dFechaVencimiento.ToString(),
                                               _Item.PrecioStrike.ToString(),
                                               _Item.NocionalTotal.ToString(),
                                               (_Item.TablaFixing.Count != 0) ? "SI" : "NO"
                                             );
                    _ID++;
                }

                #endregion

                #region ClipBoardData

                ScriptObject clipboardData = (ScriptObject)HtmlPage.Window.GetProperty("clipboardData");
                if (clipboardData != null)
                {
                    bool success = (bool)clipboardData.Invoke("setData", "text", textData);
                }
                else
                {
                    System.Windows.Browser.HtmlPage.Window.Alert("Error al copiar.");
                    return;
                }

                #endregion

            }

            #endregion
        }

        private void grdCopiaFixingStrip(object sender, KeyEventArgs e)
        {
            #region Copy uisng Ctrl-C

            if (e.Key == Key.C &&
                ((Keyboard.Modifiers & ModifierKeys.Control) == ModifierKeys.Control
                || (Keyboard.Modifiers & ModifierKeys.Apple) == ModifierKeys.Apple)
                )
            {
                DataGrid DataFixingGridStrip = sender as DataGrid;
                string textData = "";

                #region Head

                string _TextColumn = "";


                foreach (DataGridColumn _Column in DataFixingGridStrip.Columns)
                {
                    if (_TextColumn != "")
                    {
                        _TextColumn += "\t";
                    }
                    _TextColumn += _Column.Header;
                }

                textData += _TextColumn + "\n";

                #endregion

                #region Value

                int _ID = 1;

                foreach (StructFixingData _Item in (List<StructFixingData>)DataFixingGridStrip.ItemsSource)
                {
                    textData += string.Format(
                                               "{0}\t{1}\t{2}\t{3}\n",
                        //_ID.ToString(),
                                               _Item.sFecha.ToString(),
                                               _Item.sPeso.ToString(),
                                               _Item.sValor.ToString(),
                                               _Item.sVolatilidad.ToString()

                                             );
                    _ID++;
                }

                #endregion

                #region ClipBoardData

                ScriptObject clipboardData = (ScriptObject)HtmlPage.Window.GetProperty("clipboardData");
                if (clipboardData != null)
                {
                    bool success = (bool)clipboardData.Invoke("setData", "text", textData);
                }
                else
                {
                    System.Windows.Browser.HtmlPage.Window.Alert("Error al copiar.");
                    return;
                }

                #endregion

            }

            #endregion
        }

        #endregion STRIP ASIATICO

        public string XMLStripAsiatico(List<StructStrip> StripList)
        {
            string _xmlStrip = string.Format("<stripList total='{0}'>\n", StripList.Count.ToString());
            //by jolguinr
            foreach (StructStrip s in StripList)
            {
                _xmlStrip += string.Format("<Operacion id='{0}'>\n", s.ID);

                _xmlStrip += string.Format("<detOperacion fi='{0}' fv='{1}' strike='{2}' nocional='{3}' >",
                                            s.FechaInicio.ToString(),
                                            s.dFechaVencimiento,
                                            s.PrecioStrike.ToString(),
                                            s.NocionalTotal.ToString()
                                            );
                _xmlStrip += string.Format("</detOperacion>\n");

                _xmlStrip += string.Format("<fixingOperacion>");
                for (int i = 0; i < StripList[s.ID - 1].TablaFixing.Count; i++)
                {
                    _xmlStrip += string.Format(
                        "<fixing FixFecha='{0}' FixValor='{1}' FixPeso='{2}' FixVolatilidad='{3}' FixPlazo='{4}' />\n",
                        StripList[s.ID - 1].TablaFixing[i].sFecha,
                        StripList[s.ID - 1].TablaFixing[i].Valor.ToString(),
                        StripList[s.ID - 1].TablaFixing[i].Peso.ToString(),
                        StripList[s.ID - 1].TablaFixing[i].Volatilidad.ToString(),
                        StripList[s.ID - 1].TablaFixing[i].sPlazo
                        );
                }
                _xmlStrip += string.Format("</fixingOperacion>\n");

                _xmlStrip += "</Operacion>\n";
            }
            _xmlStrip += "</stripList>";

            return _xmlStrip;
        }

        #region Strip Asiático
        //PRD7274 ASVG_20111114
        private void Estructura_StripAsiatico(string vanilla_asiatica, string Fijaciones, string estructura, string payoff, double PuntosCosto, DateTime fecha_Val, DateTime fecha_Vencto, string call_put, string paridad, string compra_venta, double nocional, double spot, string Strikes_Delta_Valores_XML, string YieldNameDom, string YieldNameFor, int FlagSmile, string xmlStrip)
        {
            SrvEstructura.SrvEstructuraSoapClient _SrvEstructura = wsGlobales.Estructura;//new AdminOpciones.SrvEstructura.SrvEstructuraSoapClient();
            _SrvEstructura.StripAsiaticoCompleted += new EventHandler<AdminOpciones.SrvEstructura.StripAsiaticoCompletedEventArgs>(_SrvEstructura_StripAsiaticoCompleted);
            _SrvEstructura.StripAsiaticoAsync(this.strikes_delta_flag, vanilla_asiatica, BsSpot_BsFwd_AsianMomentos_flag, Fijaciones, estructura, payoff, PuntosCosto, fecha_Val, fecha_Vencto, FechaSetdePrecios, call_put, paridad, compra_venta, nocional, spot, this.BSSpotValorizacion, Strikes_Delta_Valores_XML, YieldNameDom, YieldNameFor, setPrecios_Pricing, xmlStrip);

            RefreshSetPricing();
        }

        //PRD7274 ASVG_20111114
        void _SrvEstructura_StripAsiaticoCompleted(object sender, SrvEstructura.StripAsiaticoCompletedEventArgs e)
        {
            StopLoading(this.PrincipalCanvas);

            XDocument xmlResult = new XDocument(XDocument.Parse(e.Result));
            var VencimientoVar = from itemVencimiento in xmlResult.Descendants("Vencimiento")
                                 select new List<DateTime>
                         {
                              DateTime.Parse(itemVencimiento.Attribute("MoFechaVcto").Value.ToString())
                         };

            //if (VencimientoVar.ToList<List<DateTime>>().Count > 0 && !fechaVencimiento.Equals(VencimientoVar.ToList<List<DateTime>>()[0][0]))
            if (this.DatePickerVencimiento.SelectedDate != this.FixingDataList[FixingDataList.Count - 1].Fecha
                && IsLoadStripContrat == false)
            {
                this.txtPlazo.Text = this.FixingDataList[FixingDataList.Count - 1].Fecha.Subtract(FechaDeProceso).Days.ToString() + "d";
                this.DatePickerVencimiento.SelectedDate = this.FixingDataList[FixingDataList.Count - 1].Fecha;
                this.fechaVencimiento = this.FixingDataList[FixingDataList.Count - 1].Fecha;
                isTextChanged = true;
                Valorizar();
            }
            else
            {
                SetGriegasAndMtMValues(e.Result);
                IsLoadStripContrat = false;
            }
        }

        #endregion Strip Asiático
        //PRD_7274
        private void Variando_StripAsiatico(double MtM_Objetivo, string vanilla_asiatica, string Fijaciones, string estructura, string payoff, double PuntosCosto, DateTime fecha_Val, DateTime fecha_Vencto, string call_put, string paridad, string compra_venta, double nocional, double spot, string Strikes_Delta_Valores_XML, string YieldNameDom, string YieldNameFor, int FlagSmile, string xmlStrip)
        {
            SrvEstructura.SrvEstructuraSoapClient _SrvSolverStripAsiatico = wsGlobales.Estructura;//new SrvEstructura.SrvEstructuraSoapClient();
            _SrvSolverStripAsiatico.Solver_StripAsiaticoCompleted += new EventHandler<AdminOpciones.SrvEstructura.Solver_StripAsiaticoCompletedEventArgs>(_SrvAsiatica_Solver_StripAsiaticoCompleted);
            _SrvSolverStripAsiatico.Solver_StripAsiaticoAsync(MtM_Objetivo, this.strikes_delta_flag, vanilla_asiatica, BsSpot_BsFwd_AsianMomentos_flag, Fijaciones, estructura, payoff, PuntosCosto, fecha_Val, fecha_Vencto, FechaSetdePrecios, call_put, paridad, compra_venta, nocional, spot, this.BSSpotValorizacion, Strikes_Delta_Valores_XML, YieldNameDom, YieldNameFor, setPrecios_Pricing, xmlStrip);

            RefreshSetPricing();
        }

        void _SrvAsiatica_Solver_StripAsiaticoCompleted(object sender, AdminOpciones.SrvEstructura.Solver_StripAsiaticoCompletedEventArgs e)
        {
            StopLoading(this.PrincipalCanvas);
            try
            {
                if (!e.Result.Equals(double.NaN) && !e.Result.Equals(double.PositiveInfinity) && !e.Result.Equals(double.NegativeInfinity))
                {
                    this.txtStrike1.Text = e.Result.ToString();
                    this.strike = e.Result;

                    isTextChanged = true;
                    Valorizar();
                }
                else
                {
                    OutPutNaN();
                    TopologiaVegaCALLPUTListPricing = null;
                    TopologiaVegaATMRRFLYPricingList = null;
                    btnTopoLogiaVegaPricing.IsEnabled = false;
                }
            }
            catch { }
        }

    }
}
