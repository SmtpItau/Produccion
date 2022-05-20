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

        private void Opcion_CallPutVanilla(string strikes_delta_flag, string paridad, string call_put_flag, string compraVenta, double nominal, double spot, double spot_smile, double strike_delta, DateTime fecha_val, DateTime fecha_Vencimiento, string YieldNameCurvaDom, string YieldNameCurvaFor, int numComponente_Estruc, string PayOff, string Estruct_Indiv)
        {
            SrvSmile.SrvSmileSoapClient _SrvVanilla = wsGlobales.Smile;// new AdminOpciones.SrvSmile.SrvSmileSoapClient();
            _SrvVanilla.OpcionVanillaCompleted += new EventHandler<AdminOpciones.SrvSmile.OpcionVanillaCompletedEventArgs>(_SrvSmile_OpcionVanillaCompleted);
            _SrvVanilla.OpcionVanillaAsync(BsSpot_BsFwd_AsianMomentos_flag, strikes_delta_flag, paridad, call_put_flag, compraVenta, nominal, spot, spot_smile, PuntosCosto, strike_delta, fecha_val, fecha_Vencimiento, FechaSetdePrecios, YieldNameCurvaDom, YieldNameCurvaFor, numComponente_Estruc, PayOff, Estruct_Indiv, setPrecios_Pricing);

            RefreshSetPricing();
        }

        private void _SrvSmile_OpcionVanillaCompleted(object sender, AdminOpciones.SrvSmile.OpcionVanillaCompletedEventArgs e)
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

        private void Opcion_CallPutAsiatica(string paridad, string call_put_flag, string compraVenta, double nominal, double spot, double spot_smile, double strike, DateTime fecha_val, DateTime fecha_Vencimiento, string YieldNameCurvaDom, string YieldNameCurvaFor, int numComponente_Estruc, string PayOff, string Estruct_Indiv, string fijacionesDataXML)
        {
            SrvAsiaticas.SrvAsiaticasSoapClient _SrvAsiatica = wsGlobales.Asiaticas;
            _SrvAsiatica.OpcionCompleted += new EventHandler<AdminOpciones.SrvAsiaticas.OpcionCompletedEventArgs>(_SrvAsiatica_OpcionCompleted);
            _SrvAsiatica.OpcionAsync(paridad, call_put_flag, compraVenta, nominal, spot, spot_smile, strike, fecha_val, fecha_Vencimiento, FechaSetdePrecios, YieldNameCurvaDom, YieldNameCurvaFor, setPrecios_Pricing, numComponente_Estruc, PayOff, Estruct_Indiv, fijacionesDataXML);

            RefreshSetPricing();
        }

        private void _SrvAsiatica_OpcionCompleted(object sender, AdminOpciones.SrvAsiaticas.OpcionCompletedEventArgs e)
        {
            StopLoading(this.PrincipalCanvas);

            try
            {
                string _Result = e.Result;

                XDocument _ResultXDoc = new XDocument(XDocument.Parse(_Result));

                var VencimientoVar = from itemVencimiento in _ResultXDoc.Descendants("Vencimiento")
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
                    string _Newfijaciones = _ResultXDoc.Element("Opcion").Element("detContrato").Element("FixingData").ToString();

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

                    SetGriegasAndMtMValues(_Result);
                }
            }
            catch { }
        }

        private void Variando_Asiatica(string _BsSpot_BsFwd_AsianMomentos_flag, string _paridad, string _call_put, string _compra_venta, double _nocional, double _spot, double _strike, double MtM_objetivo, DateTime date_Proccess, DateTime fecha_Vencimiento, string _curvaDom, string _curvaFor, string FijacionesXML, int _enumSetPricing)
        {
            SrvAsiaticas.SrvAsiaticasSoapClient _SrvAsiatica = wsGlobales.Asiaticas;
            _SrvAsiatica.Solver_CallPut_AsiaticoCompleted += new EventHandler<AdminOpciones.SrvAsiaticas.Solver_CallPut_AsiaticoCompletedEventArgs>(_SrvAsiatica_Solver_CallPut_AsiaticoCompleted);
            _SrvAsiatica.Solver_CallPut_AsiaticoAsync(_BsSpot_BsFwd_AsianMomentos_flag, _paridad, _call_put, _compra_venta, _nocional, _spot, _strike, MtM_objetivo, date_Proccess, fecha_Vencimiento, FechaSetdePrecios, _curvaDom, _curvaFor, this.FixingDataString, _enumSetPricing);

            RefreshSetPricing();
        }

        private void _SrvAsiatica_Solver_CallPut_AsiaticoCompleted(object sender, AdminOpciones.SrvAsiaticas.Solver_CallPut_AsiaticoCompletedEventArgs e)
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

        private void Variando_Vanilla(string _BsSpot_BsFwd_AsianMomentos_flag, string _paridad, string _call_put, string _compra_venta, double _nocional, double _spot, double _puntos_costo, double _strike, double MtM_objetivo, DateTime date_Proccess, DateTime fecha_Vencimiento, string _curvaDom, string _curvaFor, int _enumSetPricing)
        {
            SrvSmile.SrvSmileSoapClient _SrvSolverVanilla = wsGlobales.Smile;// new AdminOpciones.SrvSmile.SrvSmileSoapClient();
            _SrvSolverVanilla.Solver_CallPut_VanillaCompleted += new EventHandler<AdminOpciones.SrvSmile.Solver_CallPut_VanillaCompletedEventArgs>(_SrvSolverVanilla_Solver_CallPut_VanillaCompleted);
            _SrvSolverVanilla.Solver_CallPut_VanillaAsync(_BsSpot_BsFwd_AsianMomentos_flag, _paridad, _call_put, _compra_venta, _nocional, _spot, _puntos_costo, _strike, MtM_objetivo, date_Proccess, fecha_Vencimiento, FechaSetdePrecios, _curvaDom, _curvaFor, _enumSetPricing);

            RefreshSetPricing();
        }

        private void _SrvSolverVanilla_Solver_CallPut_VanillaCompleted(object sender, AdminOpciones.SrvSmile.Solver_CallPut_VanillaCompletedEventArgs e)
        {
            StopLoading(this.PrincipalCanvas);
            try
            {
                this.strike = e.Result;
                ValidAmount _Value = new ValidAmount();
                _Value.DecimalPlaces = 2;
                //_Value.SetChange(this.txtStrike1, e.Result);
                this.strike = _Value.GetSetChange(this.txtStrike1, e.Result);

                if (!e.Result.Equals(double.NaN) && !e.Result.Equals(double.PositiveInfinity) && !e.Result.Equals(double.NegativeInfinity))
                {
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
