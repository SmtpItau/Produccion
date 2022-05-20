using System;
using System.Collections.Generic;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Media;
using AdminOpciones.Recursos;
using AdminOpciones.Struct;

namespace AdminOpciones.OpcionesFX.Front
{
    //ASVG esta clase es un intento de aislar las funciones implementadas en la pantalla de front que no tienen lógica de negocio.
    public class Auxiliares
    {
        //private DependencyProperty NameProperty;

        public void StopFixing(AdminOpciones.OpcionesFX.Front.FontOpciones fo)
        {
            fo.MaskFixing.Children.Remove(fo.RotateIcon);
            fo.MaskFixing.Visibility = Visibility.Collapsed;
            fo.MaskFixing.Background = new SolidColorBrush(Colors.Gray);
            fo.MaskFixing.Opacity = 0.7;
        }

        public void StartFixing(AdminOpciones.OpcionesFX.Front.FontOpciones fo)
        {
            fo.RotateIcon.Name = "RotateIcon";
            fo.RotateIcon.SetValue(Canvas.LeftProperty, 270.0);
            fo.RotateIcon.SetValue(Canvas.TopProperty, 200.0);
            fo.MaskFixing.Children.Remove(fo.RotateIcon);
            fo.MaskFixing.Children.Add(fo.RotateIcon);

            fo.MaskFixing.Background = new SolidColorBrush(Colors.LightGray);
            fo.MaskFixing.Opacity = 0.4;
            fo.MaskFixing.Visibility = Visibility.Visible;
        }

        public void StartLoading(AdminOpciones.OpcionesFX.Front.FontOpciones fo)
        {
            fo.RotateIcon.Name = "RotateIcon";
            fo.RotateIcon.SetValue(Canvas.LeftProperty, 270.0);
            fo.RotateIcon.SetValue(Canvas.TopProperty, 200.0);
            fo.Mask.Children.Add(fo.RotateIcon);

            fo.Mask.Background = new SolidColorBrush(Colors.LightGray);
            fo.Mask.Opacity = 0.4;
            fo.Mask.Visibility = Visibility.Visible;
        }

        public void StopLoading(AdminOpciones.OpcionesFX.Front.FontOpciones fo)
        {
            fo.Mask.Children.Remove(fo.RotateIcon);
            fo.Mask.Visibility = Visibility.Collapsed;
            fo.Mask.Background = new SolidColorBrush(Colors.Gray);
            fo.Mask.Opacity = 0.7;
        }

        public void StartSetPricing(AdminOpciones.OpcionesFX.Front.FontOpciones fo)
        {
            fo.RotateIconSetPriging.Name = "RotateIconSetPricing";
            fo.RotateIconSetPriging.SetValue(Canvas.LeftProperty, 270.0);
            fo.RotateIconSetPriging.SetValue(Canvas.TopProperty, 200.0);
            fo.MaskSetPricing.Children.Add(fo.RotateIconSetPriging);

            fo.MaskSetPricing.Background = new SolidColorBrush(Colors.LightGray);
            fo.MaskSetPricing.Opacity = 0.4;
            fo.MaskSetPricing.Visibility = Visibility.Visible;
        }

        public void StopSetPricing(AdminOpciones.OpcionesFX.Front.FontOpciones fo)
        {
            fo.MaskSetPricing.Children.Remove(fo.RotateIconSetPriging);
            fo.MaskSetPricing.Visibility = Visibility.Collapsed;
            fo.MaskSetPricing.Background = new SolidColorBrush(Colors.Gray);
            fo.MaskSetPricing.Opacity = 0.7;
        }

        public void ClearData(AdminOpciones.OpcionesFX.Front.FontOpciones fo)
        {
            if (!fo.IsLoading)
            {
                fo.itemTabEjercicio.Visibility = Visibility.Collapsed;
                fo.IsClearData = true;

                #region Strip asiático

                if (fo.StripList != null)
                {
                    fo.StripList.Clear();
                    string _fix = "<FixingData>";
                    _fix += "<FixingValues/>";
                    _fix += "</FixingData>";
                    fo._TablaFixing.grdTablaFixing.ItemsSource = null;
                    fo._TablaFixing_event_TablaFixingResult(_fix);
                }

                fo.cmbPeriodicidad.SelectedItem = -1;
                fo.GridStrip.ItemsSource = null;


                if (fo.checkboxAsociadoStrip.IsChecked == true)
                {
                    fo.checkboxAsociadoStrip.IsChecked = false;

                    if (fo.radioOpcCall.IsChecked.Value || fo.radioOpcPut.IsChecked.Value)
                    {
                        fo.txtNocional.Text = "";
                        fo.txtStrike1.Text = "";
                        fo.comboPayOff.SelectedIndex = 0;
                        (fo.comboPayOff.Items[0] as ComboBoxItem).IsEnabled = true;
                        (fo.comboPayOff.Items[1] as ComboBoxItem).IsEnabled = true;
                    }
                }
                #endregion

                fo.radioCompra.IsEnabled = true;
                fo.radioVenta.IsEnabled = true;
                fo.txtPlazo.IsEnabled = true;
                fo.DatePickerVencimiento.IsEnabled = true;
                //radioEntregaFisica.IsEnabled = true; //Pato
                fo.radioCompensacion.IsEnabled = true;
                fo.txtNocional.IsEnabled = true;
                fo.tabStrikesDelta.IsEnabled = true;
                fo.txtUnwind.IsEnabled = true;
                fo.txtUnwindCosto.IsEnabled = true;
                fo.txtPrimaContrato.IsEnabled = true;
                fo.ComboUnidadPrima.IsEnabled = true;
                fo.txtParidadPrima.IsEnabled = true;
                fo.txtDistribucion.IsEnabled = true;
                fo.txtMtMContrato.IsEnabled = true;
                fo.txtSpotCosto.IsEnabled = true;

                fo.txtNocional.Text = "";

                fo.txtNocionalContraMoneda.Text = "";
                fo.txtNocionalStrangle.Text = "";

                fo.txtUnwind.Text = "";
                fo.txtUnwindCosto.Text = "";
                fo.txtDistribucion.Text = "";
                fo.txtMtMContrato.Text = "";
                fo.txtPrimaContrato.Text = "";
                fo.txtParidadPrima.Text = "";
                fo.txtResultadoVta.Text = ""; //5843

                fo.ParidadPrima = 0;
                fo.PrimaContrato = 0;
                fo.ResultVenta = 0;   //5843

                fo.txtDeltaSpot.Text = "";//Clear Griegas?
                fo.txtDeltaFwd.Text = "";
                fo.txtGamma.Text = "";
                fo.txtVega.Text = "";
                fo.txtVolga.Text = "";
                fo.txtVanna.Text = "";
                fo.txtCharm.Text = "";
                fo.txtTheta.Text = "";
                fo.txtRhoDom.Text = "";
                fo.txtRhoFor.Text = "";

                fo.txtStrike1.Text = "";
                fo.txtStrike2.Text = "";
                fo.txtStrike3.Text = "";
                fo.txtStrike4.Text = "";

                fo.txtDelta1.Text = "";
                fo.txtDelta2.Text = "";
                fo.txtDelta3.Text = "";

                fo.txtTasaDom.Text = "";
                fo.txtTasaFor.Text = "";
                fo.txtVolatilidad.Text = "";
                fo.txtForward.Text = "";
                fo._Transaccion = "";

                if (fo.TopologiaVegaATMRRFLYPricingList != null && fo.TopologiaVegaATMRRFLYPricingList.Count > 0)
                    fo.TopologiaVegaATMRRFLYPricingList.Clear();

                if (fo.TopologiaVegaCALLPUTListPricing != null && fo.TopologiaVegaCALLPUTListPricing.Count > 0)
                    fo.TopologiaVegaCALLPUTListPricing.Clear();

                fo.TopologiaVegaATMRRFLYPricingList = null;
                fo.TopologiaVegaCALLPUTListPricing = null;
                fo.btnTopoLogiaVegaPricing.IsEnabled = false;

                fo.EnableComponentes = false;

                fo.IdBtnLimpiar.Content = "Limpiar";
                fo.IdBtnGuardar.Content = "Grabar";
                fo.itemTabDeltas.IsEnabled = true;
                fo.CanvasNocional.IsHitTestVisible = true;
                fo.CanvasDefinicionOpcion.IsHitTestVisible = true;
                fo.CanvasOpionesContratoFront.IsHitTestVisible = true;
                fo.CanvasCostoContrato.IsHitTestVisible = true;
                fo.CanvasStrikesDelta.IsHitTestVisible = true;

                fo.ComboUnidadPrima.IsEnabled = true;
                fo.txtPrimaContrato.IsEnabled = true;

                fo.itemValCartera.IsEnabled = true;
                fo.itemSetdePrecios.IsEnabled = true;
                fo.itemTabDeltas.IsEnabled = true;
                fo.DatePickerSetPrecios.IsEnabled = true;
                fo.DatePickerVencimiento.IsEnabled = true;
                fo.datePiker_DateProccess.IsEnabled = true;

                fo.btnTablaFixing.IsEnabled = true;
                fo.btnComponentes.IsEnabled = true;
                fo.btnTopoLogiaVegaPricing.IsEnabled = false;

                fo.expanderOpciones.IsEnabled = true;

                fo.comboPayOff.IsEnabled = true;
                fo.comboBsFwdBsSpotAsianMomenos.IsEnabled = true;

                fo.txtStrike1.IsEnabled = true;
                fo.txtStrike2.IsEnabled = true;
                fo.txtStrike3.IsEnabled = true;
                fo.txtStrike4.IsEnabled = true;

                fo.txtSpotCosto.IsEnabled = true;
                fo.txtPlazo.IsEnabled = true;
                fo.txtPuntosCosto.IsEnabled = true;

                fo.itemTabPrima.IsEnabled = true;
                fo.itemTabDistribucion.IsEnabled = true;
                fo.itemTabResultadoVenta.IsEnabled = false; //5843
                fo.itemTabDistribucion.IsSelected = true;

                fo.CanvasSpotPuntos.IsHitTestVisible = true;
                fo.CanvasGriegas.IsHitTestVisible = true;

                fo.IdBtnLimpiar.IsEnabled = true;
                fo.IdBtnGuardar.IsEnabled = true;
                fo._Guardar.NumeroFolio = 0;
                fo._Guardar.NumeroContrato = 0;
                fo._Guardar.RutCliente = 0;
                fo._Guardar.CodigoCliente = 0;
                fo._Guardar.Libro = 0;
                fo._Guardar.CarteraFinanciera = 0;
                fo._Guardar.CarteraNormativa = "";
                fo._Guardar.SubCarteraNormativa = 0;

                globales._Estado = "C";
                fo._Transaccion = "CREACION";
                globales._NumContrato = 0;
                globales._NumFolio = 0;

                if (fo.comboPayOff.SelectedIndex.Equals(0))
                {
                    fo.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 0;
                }
                else
                {
                    fo.txtPuntosCosto.IsEnabled = false;
                }

                if (fo.grdSensibilidadCLPPricing.ItemsSource != null)
                {
                    fo.grdSensibilidadCLPPricing.ItemsSource = null;
                }
                if (fo.grdSensibilidadLocalPricing.ItemsSource != null)
                {
                    fo.grdSensibilidadLocalPricing.ItemsSource = null;
                }

                fo._TablaFixing.comboFrecuencia.SelectedIndex = 0; //Diario
                fo._TablaFixing.comboFrecuenciaEntrada.SelectedIndex = 0; //Diario PRD_12567
                fo._TablaFixing.Town = 2;

                fo._TablaFixing.AcualizarPesos = false;
                fo._TablaFixing.comboTipoPeso.SelectedIndex = 1; //Equiproporcional;
                fo._TablaFixing.comboTipoPesoEntrada.SelectedIndex = 1; //Equiproporcional;PRD_12567
                fo._TablaFixing.AcualizarPesos = true;

                //se dejó en función original.
                //event_SendChangeTitle(_TitleOriginal, UserControlName);

                //PRD-3162
                fo.LoadPortfolioAndBook();

                if (fo.radioCompensacion.IsChecked == true)
                {
                    if (fo._Guardar != null)//aqui ta el problema
                    {
                        fo._Guardar.CanvasEntregaFisia.Visibility = Visibility.Collapsed;
                        fo._Guardar.CanvasCompensacion.Visibility = Visibility.Visible;
                    }
                }
                else
                {
                    if (fo._Guardar != null)
                    {
                        fo._Guardar.CanvasCompensacion.Visibility = Visibility.Collapsed;
                        fo._Guardar.CanvasEntregaFisia.Visibility = Visibility.Visible;
                    }
                }

                //PRD-3162
                fo.IsClearData = false;
            }
        }

        public void ClearGriegas(AdminOpciones.OpcionesFX.Front.FontOpciones fo)
        {
            fo.txtDeltaSpot.Text = "";
            fo.txtDeltaFwd.Text = "";
            fo.txtGamma.Text = "";
            fo.txtVega.Text = "";
            fo.txtVolga.Text = "";
            fo.txtVanna.Text = "";
            fo.txtCharm.Text = "";
            fo.txtTheta.Text = "";
            fo.txtRhoDom.Text = "";
            fo.txtRhoFor.Text = "";
        }

        public void OutPutNaNGriegas(AdminOpciones.OpcionesFX.Front.FontOpciones fo)
        {
            fo.txtDeltaSpot.Text = double.NaN.ToString();
            fo.txtDeltaFwd.Text = double.NaN.ToString();
            fo.txtGamma.Text = double.NaN.ToString();
            fo.txtVega.Text = double.NaN.ToString();
            fo.txtVanna.Text = double.NaN.ToString();
            fo.txtVolga.Text = double.NaN.ToString();
            fo.txtRhoDom.Text = double.NaN.ToString();
            fo.txtRhoFor.Text = double.NaN.ToString();
            fo.txtCharm.Text = double.NaN.ToString();
            fo.txtTheta.Text = double.NaN.ToString();
        }

        public void OutPutNaN(AdminOpciones.OpcionesFX.Front.FontOpciones fo)
        {
            fo.strike = double.NaN;
            fo.strike2 = double.NaN;
            fo.strike3 = double.NaN;
            fo.strike4 = double.NaN;

            fo.delta1 = double.NaN;
            fo.delta2 = double.NaN;
            fo.delta3 = double.NaN;

            //MtMContrato = double.NaN;
            fo.MtMContrato = double.NaN;

            //Unwind = double.NaN;
            fo.Unwind = double.NaN;

            fo.txtStrike1.Text = double.NaN.ToString();
            fo.txtStrike2.Text = double.NaN.ToString();
            fo.txtStrike3.Text = double.NaN.ToString();
            fo.txtStrike4.Text = double.NaN.ToString();

            fo.txtDelta1.Text = double.NaN.ToString();
            fo.txtDelta2.Text = double.NaN.ToString();
            fo.txtDelta3.Text = double.NaN.ToString();

            fo.txtPrimaContrato.Text = "";
            fo.txtUnwind.Text = double.NaN.ToString();
            fo.txtUnwindCosto.Text = double.NaN.ToString();
            fo.txtMtMContrato.Text = double.NaN.ToString();
            fo.txtResultadoVta.Text = double.NaN.ToString();  //5843

            OutPutNaNGriegas(fo);
            
            if (fo.BsSpot_BsFwd_AsianMomentos_flag.Equals("BsFwd"))
            {
                fo.txtPuntosCosto.Text = double.NaN.ToString();
                fo.PuntosCosto = double.NaN;
            }
            else
            {
                fo.txtPuntosCosto.Text = "";
                //PuntosCosto = 0;
                fo.PuntosCosto = 0;
            }

            fo.txtForward.Text = double.NaN.ToString();
            fo.txtVolatilidad.Text = double.NaN.ToString();
            fo.txtTasaDom.Text = double.NaN.ToString();
            fo.txtTasaFor.Text = double.NaN.ToString();

            //isGuardarValid = false;
            fo.isGuardarValid = false;

            //EnableComponentes = false;
            fo.EnableComponentes = false;

            //XMLResult = "";
            fo.XMLResult = "";
            //griegas = null;
            fo.griegas = null;
        }

        public void Enable_RadioButtons_Solver(AdminOpciones.OpcionesFX.Front.FontOpciones fo)
        {
            if (fo.txtMtMContrato != null && fo.txtMtMContrato.Text != "")
            {
                if ((!fo._opcionEstructuraSeleccionada.Codigo.Equals("-1") && !fo._opcionEstructuraSeleccionada.Codigo.Equals("0")))
                {
                    switch (fo._opcionEstructuraSeleccionada.Codigo)
                    {
                        case "6":
                        case "13": //Forward Asiatico Entrada Salida PRD_12567
                            fo.radioVariando_Strike1.IsEnabled = true;
                            fo.radioVariando_Strike2.IsEnabled = false;
                            break;

                        case "1":
                            fo.radioVariando_Strike1.IsEnabled = false;
                            fo.radioVariando_Strike2.IsEnabled = false;
                            break;

                        case "7":
                            fo.radioVariando_Strike1.IsEnabled = false;
                            fo.radioVariando_Strike2.IsEnabled = false;
                            break;

                        case "3":
                            fo.radioVariando_Strike1.IsEnabled = false;
                            fo.radioVariando_Strike2.IsEnabled = false;
                            break;

                        case "2":
                            fo.radioVariando_Strike1.IsEnabled = true;
                            fo.radioVariando_Strike2.IsEnabled = true;
                            break;

                        case "4":
                            fo.radioVariando_Strike1.IsEnabled = true;
                            //fo.radioVariando_Strike1.IsChecked = true;
                            fo.radioVariando_Strike2.IsEnabled = true;
                            break;

                        case "5":
                            fo.radioVariando_Strike1.IsEnabled = true;
                            fo.radioVariando_Strike2.IsEnabled = true;
                            //fo.radioVariando_Puntos.IsEnabled = true;
                            break;
                        case "11": //Call Spread
                        case "12": //Put Spread
                            fo.radioVariando_Strike1.IsEnabled = true;
                            fo.radioVariando_Strike2.IsEnabled = true;
                            break;
                        case "14": //Call Spread Doble
                            fo.radioVariando_Strike1.IsEnabled = true;
                            fo.radioVariando_Strike2.IsEnabled = true;
                            fo.radioVariando_Strike3.IsEnabled = true;
                            fo.radioVariando_Strike4.IsEnabled = true;
                            break;
                           /*
                        case "9":
                        case "10":
                            fo.radioVariando_Strike1.IsEnabled = true;
                            break;
                             * */
                    }
                }
                else
                {
                    if (((ComboBoxItem)fo.comboPayOff.SelectedItem) != null && (((ComboBoxItem)fo.comboPayOff.SelectedItem).Content.Equals("Vanilla") || ((ComboBoxItem)fo.comboPayOff.SelectedItem).Content.Equals("Asiaticas")))
                    {
                        fo.radioVariando_Strike1.IsEnabled = true;
                        fo.radioVariando_Strike1.IsChecked = true;
                    }
                }
            }
            else if (fo.txtMtMContrato != null)
            {
                fo.radioVariando_Strike1.IsEnabled = false;
            }
        }

        public void PutBlockTextBox(TextBox textBox)
        {
            Canvas _Parent = textBox.Parent as Canvas;

            Type _type = _Parent.GetType();
            bool _exist = false;

            foreach (FrameworkElement _element in _Parent.Children)
            {
                if (_element.GetType().Equals(_type) && _element.GetValue(System.Windows.FrameworkElement.NameProperty).Equals(textBox.Name + "MaskTextBox"))
                {
                    _exist = true;
                }
            }

            if (!_exist)
            {

                double _width, _height;

                Canvas TransparentMaskTextBox = new Canvas();
                TransparentMaskTextBox.Name = textBox.Name + "MaskTextBox";

                _width = textBox.Width;
                _height = textBox.Height;

                TransparentMaskTextBox.SetValue(Canvas.LeftProperty, textBox.GetValue(Canvas.LeftProperty));
                TransparentMaskTextBox.SetValue(Canvas.TopProperty, textBox.GetValue(Canvas.TopProperty));

                TransparentMaskTextBox.Width = _width;
                TransparentMaskTextBox.Height = _height;
                TransparentMaskTextBox.Background = new SolidColorBrush(Colors.Transparent);
                TransparentMaskTextBox.Opacity = 0.1;

                _Parent.Children.Add(TransparentMaskTextBox);
            }
        }

        public void RemoveBlockTextBox(TextBox textBox)
        {
            Canvas _Parent = textBox.Parent as Canvas;

            Type _type = _Parent.GetType();
            bool _exist = false;
            Canvas _TransparentMasnk = null;

            foreach (FrameworkElement _element in _Parent.Children)
            {
                if (_element.GetType().Equals(_type) && _element.GetValue(System.Windows.FrameworkElement.NameProperty).Equals(textBox.Name + "MaskTextBox"))
                {
                    _exist = true;
                    _TransparentMasnk = _element as Canvas;

                }
            }
            if (_exist && _TransparentMasnk != null)
            {

                _Parent.Children.Remove(_TransparentMasnk);
                _Parent.Children.Remove(_TransparentMasnk);
            }
        }

        /// <summary>
        /// Convierte en 0.0 cualquier valor que paresca NaN
        /// </summary>
        /// <param name="posibleNaN"></param>
        /// <returns></returns>
        public double cleanNaN(double posibleNaN)
        {
            if (double.IsNaN(posibleNaN)) { return 0.0; }
            if (posibleNaN.ToString().Equals("NaN")) { return 0.0; }
            if (posibleNaN.ToString().Equals("NeuN")) { return 0.0; }

            return posibleNaN;
        }

        //no se usa
        private void Logica_Strikes_Delta(AdminOpciones.OpcionesFX.Front.FontOpciones fo)
        {
            this.Enable_RadioButtons_Solver(fo);

            if ((!fo._opcionEstructuraSeleccionada.Codigo.Equals("-1") && !fo._opcionEstructuraSeleccionada.Codigo.Equals("0"))
                && fo.txtDelta1 != null && fo.txtDelta2 != null && fo.txtDelta3 != null
                && fo.txtStrike1 != null && fo.txtStrike2 != null && fo.txtStrike3 != null)
            {
                if (fo._opcionEstructuraSeleccionada.Codigo.Equals("6") || fo._opcionEstructuraSeleccionada.Codigo.Equals("13"))//PRD_12567
                {
                    #region Seteo Pantalla Estructura 6 o 13 Forward Sintético
                    fo.txtStrike1.IsEnabled = true;
                    fo.txtStrike2.IsEnabled = false;
                    fo.txtStrike3.IsEnabled = false;
                    fo.txtStrike4.IsEnabled = false;

                    fo.unidadStrike1.Text = "CLP/USD";
                    fo.unidadStrike2.Text = "";
                    fo.unidadStrike3.Text = "";
                    fo.unidadStrike4.Text = "";

                    fo.txtStrikeCallPut1.Text = "Fwd";
                    fo.txtStrikeCallPut2.Text = "";
                    fo.txtStrikeCallPut3.Text = "";
                    fo.txtStrikeCallPut4.Text = "";

                    fo.txtDelta1.IsEnabled = false;
                    fo.txtDelta2.IsEnabled = false;
                    fo.txtDelta3.IsEnabled = false;

                    fo.unidadDelta1.Text = "";
                    fo.unidadDelta2.Text = "";
                    fo.unidadDelta3.Text = "";

                    fo.txtDeltaCallPut1.Text = "";
                    fo.txtDeltaCallPut2.Text = "";
                    fo.txtDeltaCallPut3.Text = "";

                    fo.txtNocionalContraMoneda.IsEnabled = true;

                    if (((ComboBoxItem)fo.comboPayOff.SelectedItem).Content.Equals("Vanilla"))
                    {
                        (fo.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                        (fo.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                        (fo.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                    }
                    else
                    {
                        (fo.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                        (fo.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = false;
                        (fo.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = true;
                    }

                    fo.txtSpotCosto.IsEnabled = true;
                    #endregion
                }
                else if (fo._opcionEstructuraSeleccionada.Codigo.Equals("7"))
                {
                    #region Seteo Pantalla Estructura 7 Strangle
                    if (fo.itemTabSrikes.IsSelected)
                    {
                        fo.txtStrike1.IsEnabled = true;
                        fo.txtStrike2.IsEnabled = true;
                        fo.txtStrike3.IsEnabled = false;
                        fo.txtStrike4.IsEnabled = false;

                        fo.unidadStrike1.Text = "CLP/USD";
                        fo.unidadStrike2.Text = "CLP/USD";
                        fo.unidadStrike3.Text = "";
                        fo.unidadStrike4.Text = "";

                        fo.txtStrikeCallPut1.Text = "Call";
                        fo.txtStrikeCallPut2.Text = "Put";
                        fo.txtStrikeCallPut3.Text = "";
                        fo.txtStrikeCallPut4.Text = "";

                        fo.txtDelta1.IsEnabled = false;
                        fo.txtDelta2.IsEnabled = false;
                        fo.txtDelta3.IsEnabled = false;

                        fo.txtDeltaCallPut1.Text = "Strangle";
                        fo.txtDeltaCallPut2.Text = "";
                        fo.txtDeltaCallPut3.Text = "";
                    }
                    else
                    {
                        fo.txtStrike1.IsEnabled = false;
                        fo.txtStrike2.IsEnabled = false;
                        fo.txtStrike3.IsEnabled = false;
                        fo.txtStrike4.IsEnabled = false;

                        fo.txtStrikeCallPut1.Text = "Call";
                        fo.txtStrikeCallPut2.Text = "Put";
                        fo.txtStrikeCallPut3.Text = "";
                        fo.txtStrikeCallPut4.Text = "";

                        fo.txtDelta1.IsEnabled = true;
                        fo.txtDelta2.IsEnabled = false;
                        fo.txtDelta3.IsEnabled = false;

                        fo.unidadDelta1.Text = "%";
                        fo.unidadDelta2.Text = "%";
                        fo.unidadDelta3.Text = "";

                        fo.txtDeltaCallPut1.Text = "Strangle";
                        fo.txtDeltaCallPut2.Text = "";
                        fo.txtDeltaCallPut3.Text = "";
                    }

                    fo.txtNocionalContraMoneda.IsEnabled = false;
                    (fo.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                    (fo.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                    (fo.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                    fo.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;

                    fo.txtSpotCosto.IsEnabled = true;
                    #endregion
                }
                else if (fo._opcionEstructuraSeleccionada.Codigo.Equals("1"))
                {
                    #region Seteo Pantalla Estructura 1 Straddle
                    if (fo.itemTabSrikes.IsSelected)
                    {
                        fo.txtStrike1.IsEnabled = true;
                        fo.txtStrike2.IsEnabled = false;
                        fo.txtStrike3.IsEnabled = false;
                        fo.txtStrike4.IsEnabled = false;

                        fo.unidadStrike1.Text = "CLP/USD";
                        fo.unidadStrike2.Text = "";
                        fo.unidadStrike3.Text = "";
                        fo.unidadStrike4.Text = "";

                        fo.txtStrikeCallPut1.Text = "Straddle";
                        fo.txtStrikeCallPut2.Text = "";
                        fo.txtStrikeCallPut3.Text = "";
                        fo.txtStrikeCallPut4.Text = "";

                        fo.txtDelta1.IsEnabled = false;
                        fo.txtDelta2.IsEnabled = false;
                        fo.txtDelta3.IsEnabled = false;

                        fo.txtDeltaCallPut1.Text = "Straddle";
                        fo.txtDeltaCallPut2.Text = "";
                        fo.txtDeltaCallPut3.Text = "";
                    }
                    else
                    {
                        fo.txtStrike1.IsEnabled = false;
                        fo.txtStrike2.IsEnabled = false;
                        fo.txtStrike3.IsEnabled = false;
                        fo.txtStrike4.IsEnabled = false;

                        fo.txtStrikeCallPut1.Text = "Straddle";
                        fo.txtStrikeCallPut2.Text = "";
                        fo.txtStrikeCallPut3.Text = "";
                        fo.txtStrikeCallPut4.Text = "";

                        fo.txtDelta1.IsEnabled = true;
                        fo.txtDelta2.IsEnabled = false;
                        fo.txtDelta3.IsEnabled = false;

                        fo.unidadDelta1.Text = "%";
                        fo.unidadDelta2.Text = "";
                        fo.unidadDelta3.Text = "";

                        fo.txtDeltaCallPut1.Text = "Straddle";
                        fo.txtDeltaCallPut2.Text = "";
                        fo.txtDeltaCallPut3.Text = "";
                    }

                    fo.txtNocionalContraMoneda.IsEnabled = true;
                    (fo.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                    (fo.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                    (fo.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;

                    fo.txtSpotCosto.IsEnabled = true;
                    #endregion
                }
                else if (fo._opcionEstructuraSeleccionada.Codigo.Equals("2"))
                {
                    #region Seteo Pantalla Estructura 2 Collar (Risk Reversal)
                    if (fo.itemTabSrikes.IsSelected)
                    {
                        fo.txtStrike1.IsEnabled = true;
                        fo.txtStrike2.IsEnabled = true;
                        fo.txtStrike3.IsEnabled = false;
                        fo.txtStrike4.IsEnabled = false;

                        fo.unidadStrike1.Text = "CLP/USD";
                        fo.unidadStrike2.Text = "CLP/USD";
                        fo.unidadStrike3.Text = "";
                        fo.unidadStrike4.Text = "";

                        fo.txtStrikeCallPut1.Text = "Call";
                        fo.txtStrikeCallPut2.Text = "Put";
                        fo.txtStrikeCallPut3.Text = "";
                        fo.txtStrikeCallPut4.Text = "";

                        fo.txtDelta1.IsEnabled = false;
                        fo.txtDelta2.IsEnabled = false;
                        fo.txtDelta3.IsEnabled = false;

                        fo.txtDeltaCallPut1.Text = "RR";
                        fo.txtDeltaCallPut2.Text = "";
                        fo.txtDeltaCallPut3.Text = "";
                    }
                    else
                    {
                        fo.txtStrike1.IsEnabled = false;
                        fo.txtStrike2.IsEnabled = false;
                        fo.txtStrike3.IsEnabled = false;
                        fo.txtStrike4.IsEnabled = false;

                        fo.txtStrikeCallPut1.Text = "Call";
                        fo.txtStrikeCallPut2.Text = "Put";
                        fo.txtStrikeCallPut3.Text = "";
                        fo.txtStrikeCallPut4.Text = "";

                        fo.txtDelta1.IsEnabled = true;
                        fo.txtDelta2.IsEnabled = false;
                        fo.txtDelta3.IsEnabled = false;

                        fo.unidadDelta1.Text = "%";
                        fo.unidadDelta2.Text = "";
                        fo.unidadDelta3.Text = "";

                        fo.txtDeltaCallPut1.Text = "RR";
                        fo.txtDeltaCallPut2.Text = "";
                        fo.txtDeltaCallPut3.Text = "";
                    }

                    fo.txtNocionalContraMoneda.IsEnabled = false;
                    (fo.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                    (fo.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                    (fo.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                    fo.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;

                    fo.txtSpotCosto.IsEnabled = true;
                    #endregion
                }
                else if (fo._opcionEstructuraSeleccionada.Codigo.Equals("3"))
                {
                    #region Seteo Pantalla Estructura 3 Butterfly
                    if (fo.itemTabSrikes.IsSelected)
                    {
                        fo.txtStrike1.IsEnabled = true;
                        fo.txtStrike2.IsEnabled = true;
                        fo.txtStrike3.IsEnabled = true;
                        fo.txtStrike4.IsEnabled = false;

                        fo.unidadStrike1.Text = "CLP/USD";
                        fo.unidadStrike2.Text = "CLP/USD";
                        fo.unidadStrike3.Text = "CLP/USD";
                        fo.unidadStrike4.Text = "CLP/USD";

                        fo.txtStrikeCallPut1.Text = "Call Strangle";
                        fo.txtStrikeCallPut2.Text = "Put Strangle";
                        fo.txtStrikeCallPut3.Text = "Straddle";
                        fo.txtStrikeCallPut4.Text = "";

                        fo.txtDelta1.IsEnabled = false;
                        fo.txtDelta2.IsEnabled = false;
                        fo.txtDelta3.IsEnabled = false;

                        fo.txtDeltaCallPut1.Text = "BF";
                        fo.txtDeltaCallPut2.Text = "";
                        fo.txtDeltaCallPut3.Text = "";
                    }
                    else
                    {
                        fo.txtStrike1.IsEnabled = false;
                        fo.txtStrike2.IsEnabled = false;
                        fo.txtStrike3.IsEnabled = false;
                        fo.txtStrike4.IsEnabled = false;

                        fo.txtStrikeCallPut1.Text = "Call Strangle";
                        fo.txtStrikeCallPut2.Text = "Put Strangle";
                        fo.txtStrikeCallPut3.Text = "Straddle";
                        fo.txtStrikeCallPut4.Text = "";

                        fo.txtDelta1.IsEnabled = true;
                        fo.txtDelta2.IsEnabled = false;
                        fo.txtDelta3.IsEnabled = false;

                        fo.unidadDelta1.Text = "%";
                        fo.unidadDelta2.Text = "%";
                        fo.unidadDelta3.Text = "%";

                        fo.txtDeltaCallPut1.Text = "BF";
                        fo.txtDeltaCallPut2.Text = "";
                        fo.txtDeltaCallPut3.Text = "";
                    }

                    fo.txtNocionalContraMoneda.IsEnabled = false;
                    RemoveBlockTextBox(fo.txtNocionalContraMoneda);
                    (fo.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                    (fo.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                    (fo.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                    fo.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;

                    fo.txtSpotCosto.IsEnabled = true;
                    #endregion
                }
                else if (fo._opcionEstructuraSeleccionada.Codigo.Equals("4") || fo._opcionEstructuraSeleccionada.Codigo.Equals("5"))
                {
                    #region Seteo Pantalla Estructura 4 & 5 Forward Utilidad/Pérdida Acotada
                    if (fo.itemTabSrikes.IsSelected)
                    {
                        fo.txtStrike1.IsEnabled = true;
                        fo.txtStrike2.IsEnabled = true;
                        fo.txtStrike3.IsEnabled = false;
                        fo.txtStrike4.IsEnabled = false;

                        fo.unidadStrike1.Text = "CLP/USD";
                        fo.unidadStrike2.Text = "CLP/USD";
                        fo.unidadStrike3.Text = "";
                        fo.unidadStrike4.Text = "";

                        fo.txtStrikeCallPut1.Text = "Fwd";
                        fo.txtStrikeCallPut2.Text = "Cota";
                        fo.txtStrikeCallPut3.Text = "";
                        fo.txtStrikeCallPut4.Text = "";

                        fo.txtDelta1.IsEnabled = false;
                        fo.txtDelta2.IsEnabled = false;
                        fo.txtDelta3.IsEnabled = false;

                        fo.txtDeltaCallPut1.Text = "";
                        fo.txtDeltaCallPut2.Text = "";
                        fo.txtDeltaCallPut3.Text = "";
                    }
                    else
                    {
                        fo.txtStrike1.IsEnabled = false;
                        fo.txtStrike2.IsEnabled = false;
                        fo.txtStrike3.IsEnabled = false;
                        fo.txtStrike4.IsEnabled = false;

                        fo.txtStrikeCallPut1.Text = "Fwd";
                        fo.txtStrikeCallPut2.Text = "Cota";
                        fo.txtStrikeCallPut3.Text = "";
                        fo.txtStrikeCallPut4.Text = "";

                        fo.txtDelta1.IsEnabled = false;
                        fo.txtDelta2.IsEnabled = false;
                        fo.txtDelta3.IsEnabled = false;

                        fo.unidadDelta1.Text = "%";
                        fo.unidadDelta2.Text = "%";
                        fo.unidadDelta3.Text = "";

                        fo.txtDeltaCallPut1.Text = "";
                        fo.txtDeltaCallPut2.Text = "";
                        fo.txtDeltaCallPut3.Text = "";
                    }

                    fo.txtNocionalContraMoneda.IsEnabled = true; ;
                    (fo.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                    (fo.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                    (fo.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;
                    fo.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 1;

                    fo.txtSpotCosto.IsEnabled = true;
                    #endregion
                }
            }
            else if (fo._opcionEstructuraSeleccionada.Codigo.Equals("-1") || fo._opcionEstructuraSeleccionada.Codigo.Equals("0")
                //PRD7274 Strip Asiático se parece a opción asiática
                || fo._opcionEstructuraSeleccionada.Codigo.Equals("9") || fo._opcionEstructuraSeleccionada.Codigo.Equals("10"))
            {
                if (fo.itemTabSrikes.IsSelected)
                {
                    if (globales._Estado == "" || globales._Estado == "C")
                    {
                        fo.txtStrike1.IsEnabled = true;
                    }
                    fo.txtStrike2.IsEnabled = false;
                    fo.txtStrike3.IsEnabled = false;
                    fo.txtStrike4.IsEnabled = false;

                    fo.unidadStrike1.Text = "CLP/USD";
                    fo.unidadStrike2.Text = "";
                    fo.unidadStrike3.Text = "";
                    fo.unidadStrike4.Text = "";

                    if (fo._opcionEstructuraSeleccionada.Codigo.Equals("-1"))
                    {
                        fo.txtStrikeCallPut1.Text = "Call";
                    }
                    else
                    {
                        fo.txtStrikeCallPut1.Text = "Put";
                    }
                    fo.txtStrikeCallPut2.Text = "";
                    fo.txtStrikeCallPut3.Text = "";
                    fo.txtStrikeCallPut4.Text = "";

                    fo.txtDelta1.IsEnabled = false;
                    fo.txtDelta2.IsEnabled = false;
                    fo.txtDelta3.IsEnabled = false;

                    fo.txtDeltaCallPut1.Text = "%";
                }
                else
                {
                    fo.txtStrike1.IsEnabled = false;
                    fo.txtStrike2.IsEnabled = false;
                    fo.txtStrike3.IsEnabled = false;
                    fo.txtStrike4.IsEnabled = false;

                    if (fo._opcionEstructuraSeleccionada.Codigo.Equals("-1"))
                    {
                        fo.txtStrikeCallPut1.Text = "Call";
                    }
                    else
                    {
                        fo.txtStrikeCallPut1.Text = "Put";
                    }

                    if (((ComboBoxItem)fo.comboPayOff.SelectedItem).Content.Equals("Vanilla"))
                    {
                        fo.txtDelta1.IsEnabled = true;
                        fo.txtDelta2.IsEnabled = false;
                        fo.txtDelta3.IsEnabled = false;

                        fo.unidadDelta1.Text = "%";
                        fo.unidadDelta2.Text = "";
                        fo.unidadDelta3.Text = "";

                        fo.txtDeltaCallPut1.Text = fo._opcionEstructuraSeleccionada.Descripcion;
                        fo.txtDeltaCallPut2.Text = "";
                        fo.txtDeltaCallPut3.Text = "";
                    }
                    else
                    {
                        fo.txtDelta1.IsEnabled = false;
                        fo.txtDelta2.IsEnabled = false;
                        fo.txtDelta3.IsEnabled = false;

                        fo.unidadDelta1.Text = "";
                        fo.unidadDelta2.Text = "";
                        fo.unidadDelta3.Text = "";

                        fo.txtDeltaCallPut1.Text = "";
                        fo.txtDeltaCallPut2.Text = "";
                        fo.txtDeltaCallPut3.Text = "";
                    }
                }

                if (fo.comboPayOff != null && fo.comboPayOff.Items.Count > 0 && ((ComboBoxItem)fo.comboPayOff.SelectedItem).Content.Equals("Vanilla"))
                {
                    fo.txtNocionalContraMoneda.IsEnabled = true;

                    PutBlockTextBox(fo.txtNocionalContraMoneda);

                    (fo.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = true;
                    (fo.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = true;
                    (fo.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = false;

                    if (globales._Estado == "")
                    {
                        fo.txtSpotCosto.IsEnabled = true;
                    }
                }
                else
                {
                    fo.txtNocionalContraMoneda.IsEnabled = true;
                    (fo.comboBsFwdBsSpotAsianMomenos.Items[0] as ComboBoxItem).IsEnabled = false;
                    (fo.comboBsFwdBsSpotAsianMomenos.Items[1] as ComboBoxItem).IsEnabled = false;
                    (fo.comboBsFwdBsSpotAsianMomenos.Items[2] as ComboBoxItem).IsEnabled = true;
                    fo.comboBsFwdBsSpotAsianMomenos.SelectedIndex = 2;

                    if (globales._Estado == "")
                    {
                        fo.txtSpotCosto.IsEnabled = true;
                    }
                }
            }
        }

        /// <summary>
        /// Genera XML con estructura de Strikes y Deltas según atributo "strikes_delta_flag" del FontOpciones.
        /// Revisar nombre de la función y ubicación en estructura de clases.
        /// </summary>
        /// <param name="fo">Referencia al objeto de pantalla con la operación, normalmente "this".</param>
        /// <returns></returns>
        public string genera_XML_strikes_deltas(AdminOpciones.OpcionesFX.Front.FontOpciones fo)
        {
            string strikes_delta_values_xml = "<DataStrikesDelta>\n";

            if (fo.strikes_delta_flag == "strikes")
            {
                if (!fo.strike.Equals(double.NaN) && !fo.strike.Equals(double.PositiveInfinity) && !fo.strike.Equals(double.NegativeInfinity))
                {
                    strikes_delta_values_xml += "<Strike Valor='" + fo.strike + "'/>\n";
                }
                if (!fo.strike2.Equals(double.NaN) && !fo.strike2.Equals(double.PositiveInfinity) && !fo.strike2.Equals(double.NegativeInfinity))
                {
                    strikes_delta_values_xml += "<Strike Valor='" + fo.strike2 + "'/>\n";
                }
                if (!fo.strike3.Equals(double.NaN) && !fo.strike3.Equals(double.PositiveInfinity) && !fo.strike3.Equals(double.NegativeInfinity))
                {
                    strikes_delta_values_xml += "<Strike Valor='" + fo.strike3 + "'/>\n";
                }
                if (!fo.strike4.Equals(double.NaN) && !fo.strike4.Equals(double.PositiveInfinity) && !fo.strike4.Equals(double.NegativeInfinity))
                {
                    strikes_delta_values_xml += "<Strike Valor='" + fo.strike4 + "'/>\n";
                }
            }
            else if (fo.strikes_delta_flag == "delta")
            {
                if (!fo.delta1.Equals(double.NaN) && !fo.delta1.Equals(double.PositiveInfinity) && !fo.delta1.Equals(double.NegativeInfinity))
                {
                    strikes_delta_values_xml += "<Delta Valor='" + fo.delta1 + "'/>\n";
                }
                if (!fo.delta2.Equals(double.NaN) && !fo.delta2.Equals(double.PositiveInfinity) && !fo.delta2.Equals(double.NegativeInfinity))
                {
                    strikes_delta_values_xml += "<Delta Valor='" + fo.delta2 + "'/>\n";
                }
                if (!fo.delta3.Equals(double.NaN) && !fo.delta3.Equals(double.PositiveInfinity) && !fo.delta3.Equals(double.NegativeInfinity))
                {
                    strikes_delta_values_xml += "<Delta Valor='" + fo.delta3 + "'/>\n";
                }
            }
            strikes_delta_values_xml += "</DataStrikesDelta>";
            return strikes_delta_values_xml;
        }
    }
}