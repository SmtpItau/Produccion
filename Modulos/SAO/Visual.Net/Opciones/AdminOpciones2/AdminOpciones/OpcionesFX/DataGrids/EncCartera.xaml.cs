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
using AdminOpciones.Struct.OpcionesXF.ValorizacionCartera;
using System.Windows.Browser;
using AdminOpciones.Delegados;

namespace AdminOpciones.OpcionesFX.DataGrids
{
    public partial class EncCartera : UserControl
    {

        public event SendID event_SendID;
        public event SendChecked event_SendChecked;

        public EncCartera()
        {
            InitializeComponent();
        }

        private void event_btnIdCarteraEstructura_Checked(object sender, RoutedEventArgs e)
        {
            Button _button = sender as Button;
            event_SendID(int.Parse(_button.Content.ToString()) - 1);
        }

        private void grdValCarteraEstructuras_KeyDown(object sender, KeyEventArgs e)
        {

            #region Copy uisng Ctrl-C

            if (e.Key == Key.C &&
                ((Keyboard.Modifiers & ModifierKeys.Control) == ModifierKeys.Control
                || (Keyboard.Modifiers & ModifierKeys.Apple) == ModifierKeys.Apple)
                )
            {
                string textData = "";
                DataGrid DataGridEncContrato = sender as DataGrid;

                #region Head

                string _TextColumn = "";

                foreach (DataGridColumn _Column in DataGridEncContrato.Columns)
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

                foreach (StructEncContrato _Item in (List<StructEncContrato>)DataGridEncContrato.ItemsSource)
                {
                    /*
                     * ID	1
                     * Totalizador	2
                     * Contrato	3
                     * Estructura	4
                     * Transacción	5
                     * Estado	6
                     * Compa/Venta	7
                     * Fecha Contrato	8
                     * Fecha Valorizacion	9
                     * Cartera Financiera	10
                     * Libro	11
                     * Car. Normativa	12
                     * Sub. CarNormativa	13
                     * Rut Cliente	14
                     * Codigo	15
                     * Cliente	16
                     * TipoContrapartida	17
                     * CaPrimaInicial	18
                     * Resultado Vta.	19
                     * CafPagoPrima	20
                     * MtM	21
                     * Delta Spot	22
                     * Delta Forward	23
                     * Gamma	24
                     * Vega	25
                     * RhoDom	26
                     * RhoFor	27
                     * Theta	28
                     * Charm	29
                     * Vanna	30
                     * Volga	31
                     * */
                    textData += string.Format(
                                               "{0}\t{1}\t{2}\t{3}\t{4}\t{5}\t{6}\t{7}\t{8}\t{9}\t{10}\t{11}\t" +
                                               "{12}\t{13}\t{14}\t{15}\t{16}\t{17}\t{18}\t{19}\t{20}\t{21}\t" +
                                               "{22}\t{23}\t{24}\t{25}\t{26}\t{27}\t{28}\t{29}\t{30}\t{31}\n",
                                               _Item.ID,
                                                _Item.Checked ? "SI" : "NO",
                                                _Item.NumContrato.ToString(),
                                                _Item.Estructura,
                                                _Item.TipoTransaccion,
                                                _Item.GlosaEstado,
                                                _Item.CVEstructura,
                                                _Item.FechaContrato.ToString("dd/MM/yyyy"),
                                                _Item.FecValorizacion.ToString("dd/MM/yyyy"),
                                                _Item.CarteraFinanciera,
                                                _Item.Libro,
                                                _Item.CarNormativa,
                                                _Item.SubCarNormativa,
                                                _Item.RutCliente.ToString(),
                                                _Item.Codigo.ToString(),
                                                _Item.NombreCliente,
                                                _Item.TipoContrapartida,
                                                _Item.PrimaInicial.ToString(),
                                                _Item.ResultadoVta.ToString(),  //5843
                                                _Item.fPagoPrima.ToString(),
                                                _Item.MtM.ToString(),
                                                _Item.DeltaSpot.ToString(),
                                                _Item.DeltaForward.ToString(),
                                                _Item.Gamma.ToString(),
                                                _Item.Vega.ToString(),
                                                _Item.RhoDom.ToString(),
                                                _Item.RhoFor.ToString(),
                                                _Item.Theta.ToString(),
                                                _Item.Charm.ToString(),
                                                _Item.Vanna.ToString(),
                                                _Item.Volga.ToString(),
                                                _Item.sRelacionaPAE //PRD_10449
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
                    System.Windows.Browser.HtmlPage.Window.Alert("Sorry, this functionality is only avaliable in Internet Explorer.");
                    return;
                }

                #endregion

            }

            #endregion

        }

        private void event_CheckBoxEncabezado_Click(object sender, RoutedEventArgs e)
        {
            event_SendChecked();
        }
    }
}
