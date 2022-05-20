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
    public partial class DetCartera : UserControl
    {
        public event SendID event_SendID;
        public event SendChecked event_SendChecked;

        public DetCartera()
        {
            InitializeComponent();
        }

        private void grdValCartera_KeyDown(object sender, KeyEventArgs e)
        {
            #region Copy uisng Ctrl-C

            if (e.Key == Key.C &&
                ((Keyboard.Modifiers & ModifierKeys.Control) == ModifierKeys.Control
                || (Keyboard.Modifiers & ModifierKeys.Apple) == ModifierKeys.Apple)
                )
            {
                DataGrid DataGridCarteraDetContrato = sender as DataGrid;
                string textData = "";
                double _Total = 0;

                #region Head

                string _TextColumn = "";

                foreach (DataGridColumn _Column in DataGridCarteraDetContrato.Columns)
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

                foreach (StructDetContrato _Item in (List<StructDetContrato>)DataGridCarteraDetContrato.ItemsSource)
                {
                    textData += string.Format(
                                               "{0}\t{1}\t{2}\t{3}\t{4}\t{5}\t{6}\t{7}\t{8}\t{9}\t{10}\t{11}\t" +
                                               "{12}\t{13}\t{14}\t{15}\t{16}\t{17}\t{18}\t{19}\t{20}\t{21}\t" +
                                               "{22}\t{23}\t{24}\t{25}\t{26}\n",
                                               _Item.ID.ToString(),
                                               _Item.Checked ? "SI" : "NO",
                                               _Item.NumContrato.ToString(),
                                               _Item.NumEstructura.ToString(),
                                               _Item.Estructura,
                                               _Item.TipoTransaccion,
                                               _Item.CallPut,
                                               _Item.Vinculacion,
                                               _Item.TipoPayOff.ToString(),
                                               _Item.sCVOpc,
                                               _Item.FechaInicioOpc.ToString("dd/MM/yyyy"),
                                               _Item.FechaVcto.ToString("dd/MM/yyyy"),
                                               _Item.MontoMon1.ToString(),
                                               _Item.Strike.ToString(),
                                               _Item.SpotDet.ToString(),
                                               _Item.ParStrike,
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
                                               _Item.Volga.ToString()
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

        private void event_btnIdCartera_Checked(object sender, RoutedEventArgs e)
        {
            Button _button = sender as Button;
            event_SendID(int.Parse(_button.Content.ToString()) - 1);
        }

        private void event_CheckBoxDetalle_Click(object sender, RoutedEventArgs e)
        {
            event_SendChecked();
        }
    }
}
