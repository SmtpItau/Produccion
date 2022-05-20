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

        //PRD_12567
        private void Estructura_Forward_AsiaticoEntradaSalida(string vanilla_asiatica, string Fijaciones, string estructura, string payoff, double PuntosCosto, DateTime fecha_Val, DateTime fecha_Vencto, string call_put, string paridad, string compra_venta, double nocional, double spot, string Strikes_Delta_Valores_XML, string YieldNameDom, string YieldNameFor, int FlagSmile)
        {
            SrvEstructura.SrvEstructuraSoapClient _SrvEstructura = wsGlobales.Estructura;//new AdminOpciones.SrvEstructura.SrvEstructuraSoapClient();
            _SrvEstructura.ForwardAsiaticoEntradaSalidaCompleted += new EventHandler<AdminOpciones.SrvEstructura.ForwardAsiaticoEntradaSalidaCompletedEventArgs>(_SrvEstructura_Forward_AsiaticoEntradaSalidaCompleted);
            _SrvEstructura.ForwardAsiaticoEntradaSalidaAsync(this.strikes_delta_flag, vanilla_asiatica, BsSpot_BsFwd_AsianMomentos_flag, Fijaciones, estructura, payoff, PuntosCosto, fecha_Val, fecha_Vencto, FechaSetdePrecios, call_put, paridad, compra_venta, nocional, spot, this.BSSpotValorizacion, Strikes_Delta_Valores_XML, YieldNameDom, YieldNameFor, setPrecios_Pricing);

            RefreshSetPricing();
        }

        private void _SrvEstructura_Forward_AsiaticoEntradaSalidaCompleted(object sender, AdminOpciones.SrvEstructura.ForwardAsiaticoEntradaSalidaCompletedEventArgs e)
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

                this._TablaFixing.datePikerFinEntrada.SelectedDate = fechaVencimiento;
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
                            this._TablaFixing.CrearEntrada();

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

                    this._TablaFixing.Cargar(_newFixingdataList.Where(_Element => _Element.Peso > 0).ToList(), isTablaFixingLoadedFromValcartera);

                    this._TablaFixing.CargarEntrada(_newFixingdataList.Where(_Element => _Element.Peso < 0).ToList(), isTablaFixingLoadedFromValcartera);
                }

                SetGriegasAndMtMValues(e.Result);
            }
        }

        //PRD_12567
        private void CrearFixingEntrada()
        {
            try
            {
                _TablaFixing.isEditing = true;
                _TablaFixing.datePikerInicioEntrada.SelectedDate = this.datePiker_DateProccess.SelectedDate.Value;
                _TablaFixing.datePikerFinEntrada.SelectedDate = this.DatePickerVencimiento.SelectedDate.Value;

                _TablaFixing.isEditing = false;

                if (MyPlazo != txtPlazo.Text)
                {
                    this._TablaFixing.comboFrecuenciaEntrada.SelectedIndex = 0; //Diario
                    this._TablaFixing.Town = 2;
                    this._TablaFixing.AcualizarPesosEntrada = false;
                    this._TablaFixing.comboTipoPesoEntrada.SelectedIndex = 1; //Equiproporcional;
                    this._TablaFixing.AcualizarPesosEntrada = true;
                }

                isTextChanged = true;

                this._TablaFixing.CrearEntrada();
            }
            catch { }
        }

    }
}
