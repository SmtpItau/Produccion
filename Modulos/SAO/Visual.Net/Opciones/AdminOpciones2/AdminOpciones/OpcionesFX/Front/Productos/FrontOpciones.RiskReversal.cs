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

        private void Estructura_RiskReversal(string vanilla_asiatica, string Fijaciones, string estructura, string payoff, double PuntosCosto, DateTime fecha_Val, DateTime fecha_Vencto, string call_put, string paridad, string compra_venta, double nocional, double spot, string Strikes_Delta_Valores_XML, string YieldNameDom, string YieldNameFor, int FlagSmile)
        {
            SrvEstructura.SrvEstructuraSoapClient _SrvEstructura = wsGlobales.Estructura;//new AdminOpciones.SrvEstructura.SrvEstructuraSoapClient();
            _SrvEstructura.RiskReversalCompleted += new EventHandler<AdminOpciones.SrvEstructura.RiskReversalCompletedEventArgs>(_SrvEstructura_RiskReversalCompleted);
            _SrvEstructura.RiskReversalAsync(this.strikes_delta_flag, vanilla_asiatica, BsSpot_BsFwd_AsianMomentos_flag, Fijaciones, estructura, payoff, PuntosCosto, fecha_Val, fecha_Vencto, FechaSetdePrecios, call_put, paridad, compra_venta, nocional, spot, this.BSSpotValorizacion, Strikes_Delta_Valores_XML, YieldNameDom, YieldNameFor, setPrecios_Pricing);

            RefreshSetPricing();
        }

        private void _SrvEstructura_RiskReversalCompleted(object sender, AdminOpciones.SrvEstructura.RiskReversalCompletedEventArgs e)
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

        private void Variando_RiskReversal(string Ceiling_Floor, string Strikes_Delta_flag, string Vanilla_Asiatica, string BsSpot_BsFwd_AsianMomentos_flag, string _Fijaciones, string _estructura, string _payoff, double _PuntosCosto, DateTime _fecha_Val, DateTime _fecha_Vencto, string _paridad, string _compra_venta, double _nocional, double _spot, string _Strikes_Delta_Valores_XML, string YieldNameDom, string YieldNameFor, int setPrecios_Pricing)
        {
            SrvEstructura.SrvEstructuraSoapClient _SrvSolverRiskReversal = wsGlobales.Estructura;//new SrvEstructura.SrvEstructuraSoapClient();
            _SrvSolverRiskReversal.Solver_RiskReversalCompleted += new EventHandler<AdminOpciones.SrvEstructura.Solver_RiskReversalCompletedEventArgs>(_SrvSolverRiskReversal_Solver_RiskReversalCompleted);
            _SrvSolverRiskReversal.Solver_RiskReversalAsync(MtMContrato, Ceiling_Floor, strikes_delta_flag, Vanilla_Asiatica, BsSpot_BsFwd_AsianMomentos_flag, _Fijaciones, _estructura, _payoff, _PuntosCosto, _fecha_Val, _fecha_Vencto, FechaSetdePrecios, _paridad, _compra_venta, _nocional, _spot, this.BSSpotValorizacion, _Strikes_Delta_Valores_XML, YieldNameDom, YieldNameFor, setPrecios_Pricing);

            RefreshSetPricing();
        }

        private void _SrvSolverRiskReversal_Solver_RiskReversalCompleted(object sender, AdminOpciones.SrvEstructura.Solver_RiskReversalCompletedEventArgs e)
        {
            StopLoading(this.PrincipalCanvas);
            double _result;
            ValidAmount _Value = new ValidAmount();
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
                        if (_result <= strike2)
                        {
                            _result = strike2 + 0.01;
                            _resolver = System.Windows.Browser.HtmlPage.Window.Confirm("Limite Strike Call Sobrepasado, desea ajustar y resolver");
                        }

                        Strike_Temp = strike;

                        _Value.DecimalPlaces = 2;
                        _Value.SetChange(this.txtStrike1, _result);
                        //this.strike = _result;
                        this.strike = double.Parse(this.txtStrike1.Text);
                    }
                    else if (this.radioVariando_Strike2.IsChecked.Value)
                    {
                        Strike_Resuelto = 2;
                        if (_result >= strike)
                        {
                            _result = strike - 0.01;
                            _resolver = System.Windows.Browser.HtmlPage.Window.Confirm("Limite Strike Put Sobrepasado, desea ajustar y resolver");
                        }

                        Strike_Temp = strike2;
                        _Value.DecimalPlaces = 2;
                        _Value.SetChange(this.txtStrike2, _result);
                        //this.strike2 = _result;
                        this.strike2 = double.Parse(this.txtStrike2.Text);
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

    }
}
