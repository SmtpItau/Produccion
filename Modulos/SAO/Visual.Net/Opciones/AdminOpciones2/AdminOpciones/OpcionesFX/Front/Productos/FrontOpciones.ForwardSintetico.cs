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

//Using para estructuras de negocio
using AdminOpciones.Struct.OpcionesXF.Asiatica;

namespace AdminOpciones.OpcionesFX.Front
{
    public partial class FontOpciones
    {

        private void Estructura_Forward_Sintetico(string vanilla_asiatica, string Fijaciones, string estructura, string payoff, double PuntosCosto, DateTime fecha_Val, DateTime fecha_Vencto, string call_put, string paridad, string compra_venta, double nocional, double spot, string Strikes_Delta_Valores_XML, string YieldNameDom, string YieldNameFor, int FlagSmile)
        {
            SrvEstructura.SrvEstructuraSoapClient _SrvEstructura = wsGlobales.Estructura;// new AdminOpciones.SrvEstructura.SrvEstructuraSoapClient();
            _SrvEstructura.ForwardSinteticoCompleted += new EventHandler<AdminOpciones.SrvEstructura.ForwardSinteticoCompletedEventArgs>(_SrvEstructura_ForwardSinteticoCompleted);
            _SrvEstructura.ForwardSinteticoAsync(this.strikes_delta_flag, vanilla_asiatica, BsSpot_BsFwd_AsianMomentos_flag, Fijaciones, estructura, payoff, PuntosCosto, fecha_Val, fecha_Vencto, FechaSetdePrecios, call_put, paridad, compra_venta, nocional, spot, this.BSSpotValorizacion, Strikes_Delta_Valores_XML, YieldNameDom, YieldNameFor, setPrecios_Pricing);

            RefreshSetPricing();
        }

        private void _SrvEstructura_ForwardSinteticoCompleted(object sender, AdminOpciones.SrvEstructura.ForwardSinteticoCompletedEventArgs e)
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

                if (((ComboBoxItem)this.comboPayOff.SelectedItem).Content.Equals("Asiaticas"))
                {
                    if (!this.datePiker_DateProccess.Text.Equals("") && !this.DatePickerVencimiento.Text.Equals("") && !this.txtSpotCosto.Text.Equals("") && !this.txtStrike1.Text.Equals(""))
                    {
                        try
                        {
                            this._TablaFixing.Crear();
                        }
                        catch { }
                    }
                }
            }
            else
            {
                if (((ComboBoxItem)comboPayOff.SelectedItem).Content.Equals("Asiaticas"))
                {
                    string _Newfijaciones = xmlResult.Descendants("Opcion").ElementAt(0).Element("detContrato").Element("FixingData").ToString();

                    XElement _FixingXElement = XElement.Parse(_Newfijaciones);

                    var elements = from elementItem in _FixingXElement.Descendants("FixingValues")
                                   select new StructFixingData
                                   {
                                       Fecha = DateTime.Parse(elementItem.Attribute("Fecha").Value.ToString()),
                                       Valor = double.Parse(elementItem.Attribute("Valor").Value.ToString()),
                                       Peso = double.Parse(elementItem.Attribute("Peso").Value.ToString()),
                                       Volatilidad = double.Parse(elementItem.Attribute("Volatilidad").Value.ToString()),
                                       Plazo = int.Parse(elementItem.Attribute("Plazo").Value.ToString())

                                   };

                    List<StructFixingData> _newFixingdataList = new List<StructFixingData>(elements.ToList<StructFixingData>());

                    this._TablaFixing.Cargar(_newFixingdataList, isTablaFixingLoadedFromValcartera);
                }
                SetGriegasAndMtMValues(e.Result);
            }
        }


        private void Variando_ForwardSintetico(string Strikes_Delta_flag, string Vanilla_Asiatica, string BsSpot_BsFwd_AsianMomentos_flag, string _Fijaciones, string _estructura, string _payoff, double _PuntosCosto, DateTime _fecha_Val, DateTime _fecha_Vencto, string _paridad, string _compra_venta, double _nocional, double _spot, string _Strikes_Delta_Valores_XML, string YieldNameDom, string YieldNameFor, int setPrecios_Pricing)
        {
            SrvEstructura.SrvEstructuraSoapClient _SrvSolverForwardSintetico = wsGlobales.Estructura;//new SrvEstructura.SrvEstructuraSoapClient();
            _SrvSolverForwardSintetico.Solver_FwdSinteticoCompleted += new EventHandler<AdminOpciones.SrvEstructura.Solver_FwdSinteticoCompletedEventArgs>(_SrvSolverForwardSintetico_Solver_FwdSinteticoCompleted);
            _SrvSolverForwardSintetico.Solver_FwdSinteticoAsync(MtMContrato, strikes_delta_flag, Vanilla_Asiatica, BsSpot_BsFwd_AsianMomentos_flag, _Fijaciones, _estructura, _payoff, _PuntosCosto, _fecha_Val, _fecha_Vencto, FechaSetdePrecios, _paridad, _compra_venta, _nocional, _spot, _Strikes_Delta_Valores_XML, YieldNameDom, YieldNameFor, setPrecios_Pricing);

            RefreshSetPricing();
        }

        //alanrevisar declarada private
        void _SrvSolverForwardSintetico_Solver_FwdSinteticoCompleted(object sender, AdminOpciones.SrvEstructura.Solver_FwdSinteticoCompletedEventArgs e)
        {
            StopLoading(this.PrincipalCanvas);
            ValidAmount _Value = new ValidAmount();
            double _result;
            try
            {
                _result = e.Result;
                if (!e.Result.Equals(double.NaN) && !e.Result.Equals(double.PositiveInfinity) && !e.Result.Equals(double.NegativeInfinity))
                {
                    if (this.radioVariando_Strike1.IsChecked.Value)
                    {
                        _Value.DecimalPlaces = 2;
                        _Value.SetChange(this.txtStrike1, e.Result);
                        this.strike = e.Result;
                        //this.txtPuntosContrato.Text = (e.Result - SpotContrato).ToString();
                        //PuntosContrato = e.Result - SpotContrato;

                    }
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
