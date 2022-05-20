using System;
using System.Net;
using System.Windows;
using System.Windows.Controls;

//Using necesarios para servicios.
using System.Collections.Generic;   //Para List
using System.Linq;                  //Para "select"
using System.Xml.Linq;              //Para XDocument
using AdminOpciones.Recursos;       //Para wsGlobales
using AdminOpciones.Valid;          //Para ValidAmount

namespace AdminOpciones.OpcionesFX.Front
{
    public partial class FontOpciones
    {

        #region Call/Put Spread

        private void Estructura_CallPutSpread(string vanilla_asiatica, string Fijaciones, string estructura, string payoff, double PuntosCosto, DateTime fecha_Val, DateTime fecha_Vencto, string call_put, string paridad, string compra_venta, double nocional, double spot, string Strikes_Delta_Valores_XML, string YieldNameDom, string YieldNameFor, int FlagSmile, string TipoSpread)
        {
            SrvEstructura.SrvEstructuraSoapClient _SrvEstructura = wsGlobales.Estructura;//new AdminOpciones.SrvEstructura.SrvEstructuraSoapClient();
            _SrvEstructura.CallPutSpreadCompleted += new EventHandler<AdminOpciones.SrvEstructura.CallPutSpreadCompletedEventArgs>(_SrvEstructura_CallPutSpreadCompleted);
            _SrvEstructura.CallPutSpreadAsync(this.strikes_delta_flag, vanilla_asiatica, BsSpot_BsFwd_AsianMomentos_flag, Fijaciones, estructura, payoff, PuntosCosto, fecha_Val, fecha_Vencto, FechaSetdePrecios, call_put, paridad, compra_venta, nocional, spot, this.BSSpotValorizacion, Strikes_Delta_Valores_XML, YieldNameDom, YieldNameFor, setPrecios_Pricing, TipoSpread);
            RefreshSetPricing();
        }

        private void _SrvEstructura_CallPutSpreadCompleted(object sender, AdminOpciones.SrvEstructura.CallPutSpreadCompletedEventArgs e)
        {
            StopLoading(this.PrincipalCanvas);
            XDocument xmlResult = new XDocument(XDocument.Parse(e.Result));
            var VencimientoVar = from itemVencimiento in xmlResult.Descendants("Vencimiento")
                                 select new List<DateTime>
                         {
                              DateTime.Parse(itemVencimiento.Attribute("MoFechaVcto").Value.ToString())
                         };

            if (VencimientoVar.ToList<List<DateTime>>().Count > 0 && !fechaVencimiento.Equals(VencimientoVar.ToList<List<DateTime>>()[0][0]))
            {
                this.fechaVencimiento = VencimientoVar.ToList<List<DateTime>>()[0][0];
                if (!this.fechaVencimiento.Equals(this.DatePickerVencimiento.SelectedDate.Value))
                {
                    this.txtPlazo.Text = this.fechaVencimiento.Subtract(FechaDeProceso).Days.ToString() + "d";
                }
                this.DatePickerVencimiento.SelectedDate = this.fechaVencimiento;

                this._TablaFixing.datePikerFin.SelectedDate = fechaVencimiento;

                isTextChanged = true;

                if (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla"))
                {
                    Valorizar();
                }
            }
            else
            {
                SetGriegasAndMtMValues(e.Result);
            }
        }

        #endregion Call/Put Spread

        #region Variando Call/Put Spread

        private void Variando_CallPutSpread(string Ceiling_Floor, string Strikes_Delta_flag, string Vanilla_Asiatica, string BsSpot_BsFwd_AsianMomentos_flag, string _Fijaciones, string _estructura, string _payoff, double _PuntosCosto, DateTime _fecha_Val, DateTime _fecha_Vencto, string _paridad, string _compra_venta, double _nocional, double _spot, string _Strikes_Delta_Valores_XML, string YieldNameDom, string YieldNameFor, int setPrecios_Pricing, string TipoEstructura)
        {
            SrvEstructura.SrvEstructuraSoapClient _SrvSolverCallPutSpread = wsGlobales.Estructura;//new SrvEstructura.SrvEstructuraSoapClient();
            _SrvSolverCallPutSpread.Solver_CallPutSpreadCompleted += new EventHandler<AdminOpciones.SrvEstructura.Solver_CallPutSpreadCompletedEventArgs>(_SrvSolverCallPutSpread_Solver_CallPutSpreadCompleted);
            _SrvSolverCallPutSpread.Solver_CallPutSpreadAsync(MtMContrato, Ceiling_Floor, strikes_delta_flag, Vanilla_Asiatica, BsSpot_BsFwd_AsianMomentos_flag, _Fijaciones, _estructura, _payoff, _PuntosCosto, _fecha_Val, _fecha_Vencto, FechaSetdePrecios, _paridad, _compra_venta, _nocional, _spot, this.BSSpotValorizacion, _Strikes_Delta_Valores_XML, YieldNameDom, YieldNameFor, setPrecios_Pricing, TipoEstructura);

            RefreshSetPricing();
        }

        private void _SrvSolverCallPutSpread_Solver_CallPutSpreadCompleted(object sender, AdminOpciones.SrvEstructura.Solver_CallPutSpreadCompletedEventArgs e)
        {
            StopLoading(this.PrincipalCanvas);
            double _result;
            ValidAmount _Value = new ValidAmount();
            bool _ValidaSolver = false;
            try
            {
                _result = e.Result;
                if (!e.Result.Equals(double.NaN) && !e.Result.Equals(double.PositiveInfinity) && !e.Result.Equals(double.NegativeInfinity))
                {
                    bool _resolver = true;
                    int Strike_Resuelto = 1;
                    double Strike_Temp = 0;
                    if (this.radioVariando_Strike1.IsChecked.Value)
                    {
                        Strike_Resuelto = 1;

                        // Compra Spread
                        if (this.radioCompra.IsChecked == true)
                        {
                            //Compra Call Spread
                            if (_opcionEstructuraSeleccionada.Codigo == "11")
                            {
                                if (_result < strike2)
                                {
                                    _ValidaSolver = true;
                                }
                            }
                            // Compra Put Spread
                            else
                            {
                                if (_result > strike2)
                                {
                                    _ValidaSolver = true;
                                }
                            }
                        }
                        // Venta Spread
                        else
                        {
                            //Venta Call Spread
                            if (_opcionEstructuraSeleccionada.Codigo == "11")
                            {
                                if (_result > strike2)
                                {
                                    _ValidaSolver = true;
                                }
                            }
                            // Venta Put Spread
                            else
                            {
                                if (_result < strike2)
                                {
                                    _ValidaSolver = true;
                                }
                            }
                        }

                        //if (_result <= strike2)
                        if (_ValidaSolver == false)
                        {
                            _result = strike2 + 0.01;
                            _resolver = System.Windows.Browser.HtmlPage.Window.Confirm("Limite Strike seleccionado está Sobrepasado, debe ajustar y resolver");
                        }

                        Strike_Temp = strike;

                        _Value.DecimalPlaces = 2;
                        _Value.SetChange(this.txtStrike1, _result);
                        this.strike = _result;

                    }
                    else if (this.radioVariando_Strike2.IsChecked.Value)
                    {
                        Strike_Resuelto = 2;

                        // Compra Spread
                        if (this.radioCompra.IsChecked == true)
                        {
                            //Compra Call Spread
                            if (_opcionEstructuraSeleccionada.Codigo == "11")
                            {
                                if (_result > strike)
                                {
                                    _ValidaSolver = true;
                                }
                            }
                            // Compra Put Spread
                            else
                            {
                                if (_result < strike)
                                {
                                    _ValidaSolver = true;
                                }
                            }
                        }
                        // Venta Spread
                        else
                        {
                            //Venta Call Spread
                            if (_opcionEstructuraSeleccionada.Codigo == "11")
                            {
                                if (_result < strike)
                                {
                                    _ValidaSolver = true;
                                }
                            }
                            // Venta Put Spread
                            else
                            {
                                if (_result > strike)
                                {
                                    _ValidaSolver = true;
                                }
                            }
                        }

                        if (_ValidaSolver == false)
                        {
                            _result = strike - 0.01;
                            _resolver = System.Windows.Browser.HtmlPage.Window.Confirm("Limite Strike seleccionado está Sobrepasado, debe ajustar y resolver");
                        }

                        Strike_Temp = strike2;
                        _Value.DecimalPlaces = 2;
                        _Value.SetChange(this.txtStrike2, _result);
                        this.strike2 = _result;
                    }

                    if (_resolver)
                    {

                        isTextChanged = true;
                        Valorizar();
                    }
                    else
                    {
                        if (Strike_Resuelto == 1)
                        {
                            strike = Strike_Temp;
                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike1, Strike_Temp);
                        }

                        if (Strike_Resuelto == 2)
                        {
                            strike2 = Strike_Temp;
                            _Value.DecimalPlaces = 2;
                            _Value.SetChange(this.txtStrike2, Strike_Temp);
                        }

                        txtMtMContrato.Text = "";
                        MtMContrato = double.NaN;

                        TopologiaVegaCALLPUTListPricing = null;
                        TopologiaVegaATMRRFLYPricingList = null;
                        btnTopoLogiaVegaPricing.IsEnabled = false;
                    }
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

        #endregion Variando Call/Put Spread

        #region Servicios Call Spread Doble

        private void Estructura_CallSpreadDoble(string vanilla_asiatica, string Fijaciones, string estructura, string payoff, double PuntosCosto, DateTime fecha_Val, DateTime fecha_Vencto, string call_put, string paridad, string compra_venta, double nocional, double spot, string Strikes_Delta_Valores_XML, string YieldNameDom, string YieldNameFor, int FlagSmile)
        {
            SrvEstructura.SrvEstructuraSoapClient _SrvEstructura = wsGlobales.Estructura;//new AdminOpciones.SrvEstructura.SrvEstructuraSoapClient();
            _SrvEstructura.CallSpreadDobleCompleted += new EventHandler<AdminOpciones.SrvEstructura.CallSpreadDobleCompletedEventArgs>(_SrvEstructura_CallSpreadDobleCompleted);
            _SrvEstructura.CallSpreadDobleAsync(this.strikes_delta_flag, vanilla_asiatica, BsSpot_BsFwd_AsianMomentos_flag, Fijaciones, estructura, payoff, PuntosCosto, fecha_Val, fecha_Vencto, FechaSetdePrecios, call_put, paridad, compra_venta, nocional, spot, this.BSSpotValorizacion, Strikes_Delta_Valores_XML, YieldNameDom, YieldNameFor, setPrecios_Pricing);
            RefreshSetPricing();
        }

        private void _SrvEstructura_CallSpreadDobleCompleted(object sender, AdminOpciones.SrvEstructura.CallSpreadDobleCompletedEventArgs e)
        {
            StopLoading(this.PrincipalCanvas);
            XDocument xmlResult = new XDocument(XDocument.Parse(e.Result));
            var VencimientoVar = from itemVencimiento in xmlResult.Descendants("Vencimiento")
                                 select new List<DateTime>
                         {
                              DateTime.Parse(itemVencimiento.Attribute("MoFechaVcto").Value.ToString())
                         };

            if (VencimientoVar.ToList<List<DateTime>>().Count > 0 && !fechaVencimiento.Equals(VencimientoVar.ToList<List<DateTime>>()[0][0]))
            {
                this.fechaVencimiento = VencimientoVar.ToList<List<DateTime>>()[0][0];
                if (!this.fechaVencimiento.Equals(this.DatePickerVencimiento.SelectedDate.Value))
                {
                    this.txtPlazo.Text = this.fechaVencimiento.Subtract(FechaDeProceso).Days.ToString() + "d";
                }
                this.DatePickerVencimiento.SelectedDate = this.fechaVencimiento;

                this._TablaFixing.datePikerFin.SelectedDate = fechaVencimiento;

                isTextChanged = true;

                if (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Vanilla"))
                {
                    Valorizar();
                }
            }
            else
            {
                SetGriegasAndMtMValues(e.Result);
            }
        }

        #region Variando Call Spread Doble

        private void Variando_CallSpreadDoble(string Ceiling_Floor, string Strikes_Delta_flag, string Vanilla_Asiatica, string BsSpot_BsFwd_AsianMomentos_flag, string _Fijaciones, string _estructura, string _payoff, double _PuntosCosto, DateTime _fecha_Val, DateTime _fecha_Vencto, string _paridad, string _compra_venta, double _nocional, double _spot, string _Strikes_Delta_Valores_XML, string YieldNameDom, string YieldNameFor, int setPrecios_Pricing, string TipoEstructura)
        {
            SrvEstructura.SrvEstructuraSoapClient _SrvSolverCallSpreadDoble = wsGlobales.Estructura;//new SrvEstructura.SrvEstructuraSoapClient();
            _SrvSolverCallSpreadDoble.Solver_CallSpreadDobleCompleted += new EventHandler<AdminOpciones.SrvEstructura.Solver_CallSpreadDobleCompletedEventArgs>(_SrvSolverCallSpreadDoble_Solver_CallSpreadDobleCompleted);
            _SrvSolverCallSpreadDoble.Solver_CallSpreadDobleAsync(MtMContrato, Ceiling_Floor, strikes_delta_flag, Vanilla_Asiatica, BsSpot_BsFwd_AsianMomentos_flag, _Fijaciones, _estructura, _payoff, _PuntosCosto, _fecha_Val, _fecha_Vencto, FechaSetdePrecios, _paridad, _compra_venta, _nocional, _spot, this.BSSpotValorizacion, _Strikes_Delta_Valores_XML, YieldNameDom, YieldNameFor, setPrecios_Pricing, TipoEstructura);

            RefreshSetPricing();
        }

        private void _SrvSolverCallSpreadDoble_Solver_CallSpreadDobleCompleted(object sender, AdminOpciones.SrvEstructura.Solver_CallSpreadDobleCompletedEventArgs e)
        {
            StopLoading(this.PrincipalCanvas);
            double _result;
            ValidAmount _Value = new ValidAmount();

            try
            {
                _result = e.Result;

                if (!_result.Equals(double.NaN) && !_result.Equals(double.PositiveInfinity) && !_result.Equals(double.NegativeInfinity))
                {
                    //ASVG solución temporal muy básica
                    #region Determina el Strike Resuelto y lo Setea
                    if (this.radioVariando_Strike1.IsChecked.Value)
                    {
                        _Value.DecimalPlaces = 2;
                        _Value.SetChange(this.txtStrike1, _result);
                        this.strike = double.Parse(this.txtStrike1.Text);
                    }
                    else if (this.radioVariando_Strike2.IsChecked.Value)
                    {
                        _Value.DecimalPlaces = 2;
                        _Value.SetChange(this.txtStrike2, _result);
                        this.strike2 = double.Parse(this.txtStrike2.Text);
                    }
                    else if (this.radioVariando_Strike3.IsChecked.Value)
                    {
                        _Value.DecimalPlaces = 2;
                        _Value.SetChange(this.txtStrike3, _result);
                        this.strike3 = double.Parse(this.txtStrike3.Text);
                    }
                    else if (this.radioVariando_Strike4.IsChecked.Value)
                    {
                        _Value.DecimalPlaces = 2;
                        _Value.SetChange(this.txtStrike4, _result);
                        this.strike4 = double.Parse(this.txtStrike4.Text);
                    }
                    #endregion Determina el Strike Resuelto y lo Setea

                    txtMtMContrato.Text = "";
                    MtMContrato = double.NaN;
                    isTextChanged = true;
                    this.isMTMTextChanged = true;

                    Valorizar();
                }
                else
                {
                    System.Windows.Browser.HtmlPage.Window.Alert("Solver no logró encontrat Strike deseado, favor ajustar valores.");
                }
            }
            catch
            {
                OutPutNaN();
                TopologiaVegaCALLPUTListPricing = null;
                TopologiaVegaATMRRFLYPricingList = null;
                btnTopoLogiaVegaPricing.IsEnabled = false;
            }
        }

        #endregion Variando Call Spread Doble

        #endregion Servicios Call Spread Doble

        #region Validaciones Call Spread Doble

        /// <summary>
        /// Recibe los 4 strikes y determina si cumplen las reglas de negocio
        /// </summary>
        /// <param name="textBox_1"></param>
        /// <param name="textBox_2"></param>
        /// <param name="textBox_3"></param>
        /// <param name="textBox_4"></param>
        /// <returns></returns>
        private bool ValidaTxtStrike_CallSpreadDoble(TextBox textBox_1, TextBox textBox_2, TextBox textBox_3, TextBox textBox_4)
        {
            try
            {
                if (!textBox_1.Text.Equals("") && !textBox_2.Text.Equals("") && !textBox_3.Text.Equals("") && !textBox_4.Text.Equals(""))
                {
                    return ValidaStrikes_CallSpreadDoble(double.Parse(textBox_1.Text), double.Parse(textBox_2.Text), double.Parse(textBox_3.Text), double.Parse(textBox_4.Text));
                }
            }
            catch (Exception e)
            {
                return false;
            }
            return true;
        }

        /// <summary>
        /// Valida lo siguiente:
        /// Strikes positivos.
        /// Strike1 < Strike2 < Strike3 < Strike4
        /// Strike4 - Strike3 <= Strike2 - Strike1
        /// </summary>
        /// <param name="strike_componente_1">Valor de Strike para componente 1 de la estructura.</param>
        /// <param name="strike_componente_2">Valor de Strike para componente 2 de la estructura.</param>
        /// <param name="strike_componente_3">Valor de Strike para componente 3 de la estructura.</param>
        /// <param name="strike_componente_4">Valor de Strike para componente 4 de la estructura.</param>
        /// <returns></returns>
        private bool ValidaStrikes_CallSpreadDoble(double strike_componente_1, double strike_componente_2, double strike_componente_3, double strike_componente_4)
        {
            try
            {
                if (strike_componente_1 != null && !double.IsNaN(strike_componente_1))
                {
                    if (strike_componente_1 <= 0)
                    {
                        return false;
                    }
                    if (strike_componente_2 != null && !double.IsNaN(strike_componente_2))
                    {
                        if (strike_componente_1 >= strike_componente_2)
                        {
                            return false;
                        }
                        if (strike_componente_3 != null && !double.IsNaN(strike_componente_3))
                        {
                            if (strike_componente_2 >= strike_componente_3)
                            {
                                return false;
                            }
                            if (strike_componente_4 != null && !double.IsNaN(strike_componente_4))
                            {
                                if (strike_componente_3 >= strike_componente_4)
                                {
                                    return false;
                                }
                                else
                                {
                                    if ((strike_componente_4 - strike_componente_3) > (strike_componente_2 - strike_componente_1))
                                    {
                                        return false;
                                    }
                                    else
                                    {
                                        //pasamos todas las validaciones.
                                        return true;
                                    }
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception e)
            {
                return false;
            }
            return false;
        }

        #endregion Validaciones Call Spread Doble

    }
}
