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

        #region Forward Ganancia Acotada

        private void Estructura_ForwardGananciaAcotada(string vanilla_asiatica, string Fijaciones, string estructura, string payoff, double PuntosCosto, DateTime fecha_Val, DateTime fecha_Vencto, string call_put, string paridad, string compra_venta, double nocional, double spot, string Strikes_Delta_Valores_XML, string YieldNameDom, string YieldNameFor, int FlagSmile)
        {
            SrvEstructura.SrvEstructuraSoapClient _SrvEstructura = wsGlobales.Estructura;//new AdminOpciones.SrvEstructura.SrvEstructuraSoapClient();
            _SrvEstructura.ForwardGananciaAcotadaCompleted += new EventHandler<AdminOpciones.SrvEstructura.ForwardGananciaAcotadaCompletedEventArgs>(_SrvEstructura_ForwardGananciaAcotadaCompleted);
            _SrvEstructura.ForwardGananciaAcotadaAsync(this.strikes_delta_flag, vanilla_asiatica, BsSpot_BsFwd_AsianMomentos_flag, Fijaciones, estructura, payoff, PuntosCosto, fecha_Val, fecha_Vencto, FechaSetdePrecios, call_put, paridad, compra_venta, nocional, spot, this.BSSpotValorizacion, Strikes_Delta_Valores_XML, YieldNameDom, YieldNameFor, setPrecios_Pricing);

            RefreshSetPricing();
        }

        private void _SrvEstructura_ForwardGananciaAcotadaCompleted(object sender, AdminOpciones.SrvEstructura.ForwardGananciaAcotadaCompletedEventArgs e)
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

        #endregion Forward Ganancia Acotada

        private void Estructura_ForwardPerdidaAcotada(string vanilla_asiatica, string Fijaciones, string estructura, string payoff, double PuntosCosto, DateTime fecha_Val, DateTime fecha_Vencto, string call_put, string paridad, string compra_venta, double nocional, double spot, string Strikes_Delta_Valores_XML, string YieldNameDom, string YieldNameFor, int FlagSmile)
        {
            SrvEstructura.SrvEstructuraSoapClient _SrvEstructura = wsGlobales.Estructura;//new AdminOpciones.SrvEstructura.SrvEstructuraSoapClient();
            _SrvEstructura.ForwardPerdidaAcotadaCompleted += new EventHandler<AdminOpciones.SrvEstructura.ForwardPerdidaAcotadaCompletedEventArgs>(_SrvEstructura_ForwardPerdidaAcotadaCompleted);
            _SrvEstructura.ForwardPerdidaAcotadaAsync(this.strikes_delta_flag, vanilla_asiatica, BsSpot_BsFwd_AsianMomentos_flag, Fijaciones, estructura, payoff, PuntosCosto, fecha_Val, fecha_Vencto, FechaSetdePrecios, call_put, paridad, compra_venta, nocional, spot, this.BSSpotValorizacion, Strikes_Delta_Valores_XML, YieldNameDom, YieldNameFor, setPrecios_Pricing);

            RefreshSetPricing();
        }

        private void _SrvEstructura_ForwardPerdidaAcotadaCompleted(object sender, AdminOpciones.SrvEstructura.ForwardPerdidaAcotadaCompletedEventArgs e)
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

        private void Variando_ForwardAcotado(string Puntos_Cota, string Perdida_Ganancia, string Strikes_Delta_flag, string Vanilla_Asiatica, string BsSpot_BsFwd_AsianMomentos_flag, string _Fijaciones, string _estructura, string _payoff, double _PuntosCosto, DateTime _fecha_Val, DateTime _fecha_Vencto, string _call_put, string _paridad, string _compra_venta, double _nocional, double _spot, string _Strikes_Delta_Valores_XML, string YieldNameDom, string YieldNameFor, double _SpotContrato, double _PuntosContrato, int setPrecios_Pricing)
        {
            SrvEstructura.SrvEstructuraSoapClient _SrvSolverForwardAcotado = wsGlobales.Estructura;//new SrvEstructura.SrvEstructuraSoapClient();
            _SrvSolverForwardAcotado.Solver_FwdAcotadoCompleted += new EventHandler<AdminOpciones.SrvEstructura.Solver_FwdAcotadoCompletedEventArgs>(_SrvSolverForwardAcotado_Solver_FwdAcotadoCompleted);
            _SrvSolverForwardAcotado.Solver_FwdAcotadoAsync(MtMContrato, Puntos_Cota, Perdida_Ganancia, strikes_delta_flag, Vanilla_Asiatica, BsSpot_BsFwd_AsianMomentos_flag, _Fijaciones, _estructura, _payoff, _PuntosCosto, _fecha_Val, _fecha_Vencto, FechaSetdePrecios, _call_put, _paridad, _compra_venta, _nocional, _spot, this.BSSpotValorizacion, _Strikes_Delta_Valores_XML, YieldNameDom, YieldNameFor, _SpotContrato, _PuntosContrato, setPrecios_Pricing);

            RefreshSetPricing();
        }

        //alanrevisar declarada private
        void _SrvSolverForwardAcotado_Solver_FwdAcotadoCompleted(object sender, AdminOpciones.SrvEstructura.Solver_FwdAcotadoCompletedEventArgs e)
        {
            StopLoading(this.PrincipalCanvas);
            double _result, Strike_Temp = 0;
            int Strike_Resuelto = 0;
            bool _resolver = true;
            ValidAmount _Value = new ValidAmount();

            try
            {
                _result = e.Result;
                if (!e.Result.Equals(double.NaN) && !e.Result.Equals(double.PositiveInfinity) && !e.Result.Equals(double.NegativeInfinity))
                {
                    if (this.radioVariando_Strike1.IsChecked.Value)
                    {
                        Strike_Temp = strike;
                        Strike_Resuelto = 1;
                        if (_opcionEstructuraSeleccionada.Codigo.Equals("4") && (radioCompra.IsChecked.Value && _result >= strike2))
                        {
                            _result = strike2 - 0.01;
                            _resolver = System.Windows.Browser.HtmlPage.Window.Confirm("Limite Forward Sobrepasado, desea ajustar y resolver");
                        }

                        if (_opcionEstructuraSeleccionada.Codigo.Equals("4") && (radioVenta.IsChecked.Value && _result <= strike2))
                        {
                            _result = strike2 + 0.01;
                            _resolver = System.Windows.Browser.HtmlPage.Window.Confirm("Limite Forward Sobrepasado, desea ajustar y resolver");
                        }

                        if (_opcionEstructuraSeleccionada.Codigo.Equals("5") && (radioCompra.IsChecked.Value && _result <= strike2))
                        {
                            _result = strike2 + 0.01;
                            _resolver = System.Windows.Browser.HtmlPage.Window.Confirm("Limite Forward Sobrepasado, desea ajustar y resolver");
                        }

                        if (_opcionEstructuraSeleccionada.Codigo.Equals("5") && (radioVenta.IsChecked.Value && _result >= strike2))
                        {
                            _result = strike2 - 0.01;
                            _resolver = System.Windows.Browser.HtmlPage.Window.Confirm("Limite Forward Sobrepasado, desea ajustar y resolver");
                        }

                        _Value.DecimalPlaces = 2;
                        //_Value.SetChange(this.txtStrike1, _result);
                        //this.strike = _result;
                        this.strike = _Value.GetSetChange(this.txtStrike1, _result);
                    }
                    else if (this.radioVariando_Strike2.IsChecked.Value)
                    {
                        Strike_Temp = strike2;
                        Strike_Resuelto = 2;
                        if (_opcionEstructuraSeleccionada.Codigo.Equals("4") && (radioCompra.IsChecked.Value && _result <= strike))
                        {
                            _result = strike + 0.01;
                            _resolver = System.Windows.Browser.HtmlPage.Window.Confirm("Limite de Cota Sobrepasado, desea ajustar y resolver");
                        }

                        if (_opcionEstructuraSeleccionada.Codigo.Equals("4") && (radioVenta.IsChecked.Value && _result >= strike))
                        {
                            _result = strike - 0.01;
                            _resolver = System.Windows.Browser.HtmlPage.Window.Confirm("Limite de Cota Sobrepasado, desea ajustar y resolver");
                        }

                        if (_opcionEstructuraSeleccionada.Codigo.Equals("5") && (radioCompra.IsChecked.Value && _result >= strike))
                        {
                            _result = strike - 0.01;
                            _resolver = System.Windows.Browser.HtmlPage.Window.Confirm("Limite de Cota Sobrepasado, desea ajustar y resolver");
                        }

                        if (_opcionEstructuraSeleccionada.Codigo.Equals("5") && (radioVenta.IsChecked.Value && _result <= strike))
                        {
                            _result = strike + 0.01;
                            _resolver = System.Windows.Browser.HtmlPage.Window.Confirm("Limite de Cota Sobrepasado, desea ajustar y resolver");
                        }

                        _Value.DecimalPlaces = 2;
                        //_Value.SetChange(this.txtStrike2, _result);
                        //this.strike2 = _result;
                        this.strike2 = _Value.GetSetChange(this.txtStrike2, _result);
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

                //if (!(_result.Equals(double.PositiveInfinity) || _result.Equals(double.NegativeInfinity)))
                //{
                //    isTextChanged = true;
                //    Valorizar();
                //}
            }
            catch { }
        }

    }
}
