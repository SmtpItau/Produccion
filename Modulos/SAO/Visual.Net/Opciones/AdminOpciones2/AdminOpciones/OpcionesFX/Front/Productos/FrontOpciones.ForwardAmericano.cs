using System;
using System.Net;
using System.Windows;

//Using necesarios para servicios.
using System.Collections.Generic;   //Para List
using System.Linq;                  //Para "select"
using System.Xml.Linq;              //Para XDocument
using AdminOpciones.Recursos;       //Para wsGlobales
using AdminOpciones.Valid;          //Para ValidAmount

//Using para estructuras de negocio
using AdminOpciones.Struct.OpcionesXF.ValorizacionCartera;

namespace AdminOpciones.OpcionesFX.Front
{
    public partial class FontOpciones
    {
        #region Forward Americano

        private void Estructura_ForwardAmericano()
        {
            try
            {
                string _XML = ToXML(false);
                btnSensibilidadPricing.IsEnabled = false;
                SrvEstructura.SrvEstructuraSoapClient _SrvEstructura = wsGlobales.Estructura;//new AdminOpciones.SrvEstructura.SrvEstructuraSoapClient();

                _SrvEstructura.ForwardAmericanoCompleted += new EventHandler<AdminOpciones.SrvEstructura.ForwardAmericanoCompletedEventArgs>(ForwardAmericanoCompleted);
                _SrvEstructura.ForwardAmericanoAsync(_XML);

                RefreshSetPricing();
            }
            catch
            {
                btnSensibilidadPricing.IsEnabled = true;
                StopLoading(this.PrincipalCanvas);
            }
        }

        private void ForwardAmericanoCompleted(object sender, AdminOpciones.SrvEstructura.ForwardAmericanoCompletedEventArgs e)
        {
            StopLoading(this.PrincipalCanvas);
            if (e.Error == null)
            {
                try
                {
                    XDocument _xmlValue = XDocument.Parse(e.Result);
                    DateTime _FechaVencimiento = DateTime.Parse(_xmlValue.Element("Data").Element("Opcion").Element("detContrato").Element("Vencimiento").Attribute("MoFechaVcto").Value);

                    if (!_FechaVencimiento.Equals(this.DatePickerVencimiento.SelectedDate.Value))
                    {
                        this.fechaVencimiento = _FechaVencimiento;
                        this.txtPlazo.Text = this.fechaVencimiento.Subtract(FechaDeProceso).Days.ToString() + "d";
                        this.DatePickerVencimiento.SelectedDate = this.fechaVencimiento;
                        this._TablaFixing.datePikerFin.SelectedDate = fechaVencimiento;
                        isTextChanged = true;

                        Valorizar();
                    }
                    else
                    {
                        ViewForwardAmericano(e.Result, true);
                    }
                }
                catch
                {
                    System.Windows.Browser.HtmlPage.Window.Alert(e.Result);
                }
            }
            else
            {
                System.Windows.Browser.HtmlPage.Window.Alert(e.Error.Message);
            }
        }

        private void ViewForwardAmericano(string value, bool sensitivity)
        {
            try
            {
                SetGriegasAndMtMValues(value);

                XDocument _xmlValue = XDocument.Parse(value);
                XElement _xmlElement = _xmlValue.Element("Data");
                // Visualizatión Sensibilities

                ValidAmount _Value = new ValidAmount();
                _Value.DecimalPlaces = 0;

                __ObservedDollar = double.Parse(_xmlElement.Element("ObservedDollar").Attribute("Value").Value);

                valtxtStrike1.SetChange(txtStrike1, double.Parse(_xmlElement.Element("Opcion").Element("detContrato").Element("Subyacente").Attribute("MoStrike").Value));
                _Value.SetChange(this.txtNocionalContraMoneda, double.Parse(_xmlElement.Element("Opcion").Element("detContrato").Element("Subyacente").Attribute("MoMontoMon2").Value));

                var _ListCLP = from _Item in _xmlElement.Element("Opcion").Element("Sensivility").Element("Domestic").Elements("Value")
                               select new StructSensibilidad
                               {
                                   Tenor = int.Parse(_Item.Attribute("Day").Value),
                                   MTM = 0,
                                   MTMSens = 0,
                                   Delta = double.Parse(_Item.Attribute("DV01Pos").Value)
                               };

                _ListCurvaCLPPricing = _ListCLP.ToList();
                grdSensibilidadCLPPricing.ItemsSource = null;
                grdSensibilidadCLPPricing.ItemsSource = _ListCurvaCLPPricing;

                var _ListLocal = from _Item in _xmlElement.Element("Opcion").Element("Sensivility").Element("Foreign").Elements("Value")
                                 select new StructSensibilidad
                                 {
                                     Tenor = int.Parse(_Item.Attribute("Day").Value),
                                     MTM = 0,
                                     MTMSens = 0,
                                     Delta = double.Parse(_Item.Attribute("DV01Pos").Value)
                                 };

                _ListCurvaLocalPricing = _ListLocal.ToList();
                grdSensibilidadLocalPricing.ItemsSource = null;
                grdSensibilidadLocalPricing.ItemsSource = _ListCurvaLocalPricing;

                ShowEjercer();

                if (sensitivity && checkboxSensitivity.IsChecked.Value)
                {
                    CalculateSensitivity();
                }
            }
            catch (Exception _Error)
            {
                System.Windows.Browser.HtmlPage.Window.Alert(_Error.Message);
            }
        }

        private void CalculateSensitivity()
        {
            StartLoading(this.CanvasGriegas);
            string _XML = ToXML(true);
            SrvEstructura.SrvEstructuraSoapClient _SrvEstructura = wsGlobales.Estructura;//new AdminOpciones.SrvEstructura.SrvEstructuraSoapClient();

            _SrvEstructura.ForwardAmericanoCompleted += new EventHandler<AdminOpciones.SrvEstructura.ForwardAmericanoCompletedEventArgs>(SensitivityForwardAmericanoCompleted);
            _SrvEstructura.ForwardAmericanoAsync(_XML);
        }

        private void SensitivityForwardAmericanoCompleted(object sender, AdminOpciones.SrvEstructura.ForwardAmericanoCompletedEventArgs e)
        {
            btnSensibilidadPricing.IsEnabled = true;
            StopLoading(this.CanvasGriegas);
            if (e.Error == null)
            {
                try
                {
                    XDocument _xmlValue = XDocument.Parse(e.Result);

                    ViewForwardAmericano(e.Result, false);
                }
                catch
                {
                    System.Windows.Browser.HtmlPage.Window.Alert(e.Result);
                }
            }
            else
            {
                System.Windows.Browser.HtmlPage.Window.Alert(e.Error.Message);
            }
        }

        #endregion Forward Americano

        private void Variando_ForwardAmericano()
        {
            try
            {
                string _XML = ToXML(false);

                StartLoading(this.PrincipalCanvas);
                btnSensibilidadPricing.IsEnabled = false;

                SrvEstructura.SrvEstructuraSoapClient _SrvEstructura = wsGlobales.Estructura;//new AdminOpciones.SrvEstructura.SrvEstructuraSoapClient();

                _SrvEstructura.Solver_ForwardAmericanoCompleted += new EventHandler<AdminOpciones.SrvEstructura.Solver_ForwardAmericanoCompletedEventArgs>(SolverForwardAmericanoCompleted);
                _SrvEstructura.Solver_ForwardAmericanoAsync(_XML);
            }
            catch
            {
                StopLoading(this.PrincipalCanvas);
            }
        }

        private void SolverForwardAmericanoCompleted(object sender, AdminOpciones.SrvEstructura.Solver_ForwardAmericanoCompletedEventArgs e)
        {
            StopLoading(this.PrincipalCanvas);
            if (e.Error == null)
            {
                ViewForwardAmericano(e.Result, true);
            }
            else
            {
                System.Windows.Browser.HtmlPage.Window.Alert(e.Error.Message);
            }
        }

    }
}
