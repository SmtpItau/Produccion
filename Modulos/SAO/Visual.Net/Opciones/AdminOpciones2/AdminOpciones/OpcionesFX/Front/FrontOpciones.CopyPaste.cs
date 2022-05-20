using System;
using System.Net;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Documents;
using System.Windows.Ink;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Animation;
using System.Windows.Shapes;

using System.Windows.Browser;       //Para ScriptObject

//using AdminOpciones.Recursos;
using System.Collections.Generic;   //Para List
using System.Linq;                  //Para "select"

using AdminOpciones.Struct.OpcionesXF.Asiatica;
//using AdminOpciones.Struct.OpcionesXF.Customers;
using AdminOpciones.Struct.OpcionesXF.Smile;
using AdminOpciones.Struct.OpcionesXF.ValorizacionCartera;
using AdminOpciones.Struct.Componentes;

namespace AdminOpciones.OpcionesFX.Front
{
    public partial class FontOpciones
    {

        #region Implementación Copy/Paste

        #region Eventos KeyDown para Copy/Paste

        /*Revisar, hay eventos repetidos*/

        private void grdTablaFixing_KeyDown(object sender, KeyEventArgs e)
        {
            CopyDataGridContentFixingTable(sender, e);
        }

        private void grdComponentes_KeyDown(object sender, KeyEventArgs e)
        {
            CopyDataGridContentComponentes(sender, e);
        }

        private void grdTopologiaVegaRRFLYPricing_KeyDown(object sender, KeyEventArgs e)
        {
            CopyDataGridContentRRFLY(sender, e);
        }

        private void grdTopologiaVegaVolatilidadesPricing_KeyDown(object sender, KeyEventArgs e)
        {
            CopyDataGridContentRRFLY(sender, e);
        }

        private void grdTopologiaVegaStrikesPricing_KeyDown(object sender, KeyEventArgs e)
        {
            CopyDataGridContentCallPut(sender, e);
        }

        private void grdTopologiaVegaCALLPUTPricing_KeyDown(object sender, KeyEventArgs e)
        {
            CopyDataGridContentCallPut(sender, e);
        }

        private void event_grdAtmRRFly_KeyDown(object sender, KeyEventArgs e)
        {
            CopyDataGridContentRRFLY(sender, e);
        }

        private void event_grdCallPut_KeyDown(object sender, KeyEventArgs e)
        {
            CopyDataGridContentCallPut(sender, e);
        }

        private void event_grdStrikes_KeyDown(object sender, KeyEventArgs e)
        {
            CopyDataGridContentCallPut(sender, e);
        }

        private void event_grdCurvas_KeyDown(object sender, KeyEventArgs e)
        {
            CopyDataGridContentCurvas(sender, e);
        }

        #endregion Eventos KeyDown para Copy/Paste

        #region Copy's Using Ctrl-C
        /*
         * Las funciones de CopyDataGridContent tenían esta validación comentada:
         * 
           #region Valid

            //if (grdValCartera != e.OriginalSource)
            //{
            //    return;
            //}

           #endregion
         * 
         * */

        private void CopyDataGridContentRRFLY(object sender, KeyEventArgs e)
        {
            #region Copy uisng Ctrl-C

            if (e.Key == Key.C &&
                ((Keyboard.Modifiers & ModifierKeys.Control) == ModifierKeys.Control
                || (Keyboard.Modifiers & ModifierKeys.Apple) == ModifierKeys.Apple)
                )
            {
                DataGrid DataGridRRFLY = sender as DataGrid;
                string textData = "";

                textData += ColumnHeadText(DataGridRRFLY);

                #region Value

                //"(t)\tATM\tRR25D\tBF25D\tRR10D\tBF10D\n"

                foreach (object o in DataGridRRFLY.ItemsSource)
                {
                    //mejorable.
                    StructSmileATMRRFLY _Item = new StructSmileATMRRFLY();
                    if (o.GetType().Equals(_Item.GetType()))
                    {
                        //es una StructSmileATMRRFLY
                        _Item = (StructSmileATMRRFLY)o;
                    }
                    else
                    {
                        //es una StructSmileGeneric
                        StructSmileGeneric g = (StructSmileGeneric)o;
                        _Item = g.toATMRRFLY();
                    }

                    textData += string.Format("{0}\t{1}\t{2}\t{3}\t{4}\t{5}\n",
                                                _Item.Tenor.ToString(),
                                                 _Item.ATM.ToString(),
                                                 _Item.RR25D.ToString(),
                                                 _Item.BF25D.ToString(),
                                                 _Item.RR10D.ToString(),
                                                 _Item.BF10D.ToString()
                                              );
                }

                #endregion

                CopyToClipBoard(textData);
            }

            #endregion
        }

        private void CopyDataGridContentCallPut(object sender, KeyEventArgs e)
        {
            #region Copy uisng Ctrl-C

            if (e.Key == Key.C &&
                ((Keyboard.Modifiers & ModifierKeys.Control) == ModifierKeys.Control
                || (Keyboard.Modifiers & ModifierKeys.Apple) == ModifierKeys.Apple)
                )
            {
                DataGrid _DataGrid = sender as DataGrid;
                string textData = "";

                textData += ColumnHeadText(_DataGrid);

                #region Value

                //foreach (StructSmileGeneric g in (List<StructSmileGeneric>)_DataGrid.ItemsSource)
                foreach (object o in _DataGrid.ItemsSource)
                {
                    StructSmileCallPut _Item = new StructSmileCallPut();
                    if (o.GetType().Equals(_Item.GetType()))
                    {
                        //es una StructSmileCallPut
                        _Item = (StructSmileCallPut)o;
                    }
                    else
                    {
                        //es una StructSmileGeneric
                        StructSmileGeneric g = (StructSmileGeneric)o;
                        _Item = g.toCALLPUT();
                    }

                    textData += string.Format("{0}\t{1}\t{2}\t{3}\t{4}\t{5}\n",
                                               _Item.Tenor.ToString(),
                                                _Item.Put10.ToString(),
                                                _Item.Put25.ToString(),
                                                _Item.Atm.ToString(),
                                                _Item.Call25.ToString(),
                                                _Item.Call10.ToString()
                                             );
                }

                #endregion

                CopyToClipBoard(textData);
            }

            #endregion
        }

        private void CopyDataGridContentCurvas(object sender, KeyEventArgs e)
        {
            #region Copy uisng Ctrl-C

            if (e.Key == Key.C &&
                ((Keyboard.Modifiers & ModifierKeys.Control) == ModifierKeys.Control
                || (Keyboard.Modifiers & ModifierKeys.Apple) == ModifierKeys.Apple)
                )
            {
                DataGrid DataGridCurvas = sender as DataGrid;
                string textData = "";

                textData += ColumnHeadText(DataGridCurvas);

                #region Value

                //"(t)\tATM\tRR25D\tBF25D\tRR10D\tBF10D\n"

                foreach (StructItemCurvaMoneda _Item in DataGridCurvas.ItemsSource)
                {
                    textData += string.Format("{0}\t{1}\t{2}\n",
                                                _Item.dias.ToString(),
                                                 _Item.Bid.ToString(),
                                                 _Item.Ask.ToString()
                                                 );
                }

                #endregion

                CopyToClipBoard(textData);
            }

            #endregion
        }

        private void CopyDataGridContentCurvaFwd(object sender, KeyEventArgs e)
        {
            #region Copy uisng Ctrl-C

            if (e.Key == Key.C &&
                ((Keyboard.Modifiers & ModifierKeys.Control) == ModifierKeys.Control
                || (Keyboard.Modifiers & ModifierKeys.Apple) == ModifierKeys.Apple)
                )
            {
                DataGrid DataGridCurvas = sender as DataGrid;
                string textData = "";

                textData += ColumnHeadText(DataGridCurvas);

                #region Value

                foreach (StructItemPuntosForward _Item in DataGridCurvas.ItemsSource)
                {
                    textData += string.Format("{0}\t{1}\n",
                                                _Item.dias.ToString(),
                                                _Item.Puntos
                                                 );
                }

                #endregion

                CopyToClipBoard(textData);
            }

            #endregion
        }

        private void CopyDataGridContentComponentes(object sender, KeyEventArgs e)
        {
            #region Copy uisng Ctrl-C

            if (e.Key == Key.C &&
                ((Keyboard.Modifiers & ModifierKeys.Control) == ModifierKeys.Control
                || (Keyboard.Modifiers & ModifierKeys.Apple) == ModifierKeys.Apple)
                )
            {
                DataGrid DataGridCurvas = sender as DataGrid;
                string textData = "";

                textData += ColumnHeadText(DataGridCurvas);

                #region Value

                int _Componentes = 0;
                try
                {
                    if (DataGridCurvas.ItemsSource.Cast<ItemComponentes>().ToList()[0].Componente0 != "")
                        _Componentes++;
                    if (DataGridCurvas.ItemsSource.Cast<ItemComponentes>().ToList()[0].Componente1 != "")
                        _Componentes++;
                    if (DataGridCurvas.ItemsSource.Cast<ItemComponentes>().ToList()[0].Componente2 != "")
                        _Componentes++;
                    if (DataGridCurvas.ItemsSource.Cast<ItemComponentes>().ToList()[0].Componente3 != "")
                        _Componentes++;
                    if (DataGridCurvas.ItemsSource.Cast<ItemComponentes>().ToList()[0].Componente4 != "")
                        _Componentes++;
                    if (DataGridCurvas.ItemsSource.Cast<ItemComponentes>().ToList()[0].Componente5 != "")
                        _Componentes++;
                }
                catch { }


                for (int i = 0; i < DataGridCurvas.ItemsSource.Cast<ItemComponentes>().ToList().Count; i++)
                {
                    for (int j = 0; j < _Componentes; j++)
                    {
                        switch (j)
                        {
                            case 0:
                                textData += DataGridCurvas.ItemsSource.Cast<ItemComponentes>().ToList()[i].Componente0.ToString() + "\t";
                                break;
                            case 1:
                                textData += DataGridCurvas.ItemsSource.Cast<ItemComponentes>().ToList()[i].Componente1.ToString() + "\t";
                                break;
                            case 2:
                                textData += DataGridCurvas.ItemsSource.Cast<ItemComponentes>().ToList()[i].Componente2.ToString() + "\t";
                                break;
                            case 3:
                                textData += DataGridCurvas.ItemsSource.Cast<ItemComponentes>().ToList()[i].Componente3.ToString() + "\t";
                                break;
                            case 4:
                                textData += DataGridCurvas.ItemsSource.Cast<ItemComponentes>().ToList()[i].Componente4.ToString() + "\t";
                                break;
                            case 5:
                                textData += DataGridCurvas.ItemsSource.Cast<ItemComponentes>().ToList()[i].Componente5.ToString() + "\t";
                                break;
                        }
                    }
                    textData += "\n";
                }

                #endregion

                CopyToClipBoard(textData);
            }

            #endregion
        }

        private void CopyDataGridContentTotalizador(object sender, KeyEventArgs e)
        {
            #region Copy uisng Ctrl-C

            if (e.Key == Key.C &&
                ((Keyboard.Modifiers & ModifierKeys.Control) == ModifierKeys.Control
                || (Keyboard.Modifiers & ModifierKeys.Apple) == ModifierKeys.Apple)
                )
            {
                DataGrid DataGridCurvas = sender as DataGrid;
                string textData = "";

                textData += ColumnHeadText(DataGridCurvas);

                #region Value

                foreach (StructDetContrato _Item in DataGridCurvas.ItemsSource)
                {
                    textData += string.Format("{0}\t{1}\t{2}\t{3}\t{4}\t{5}\t{6}\t{7}\t{8}\t{9}\t{10}\n",
                                                _Item.MtM.ToString(),
                                                _Item.DeltaSpot,
                                                _Item.DeltaForward,
                                                _Item.Gamma,
                                                _Item.Vega,
                                                _Item.RhoDom,
                                                _Item.RhoFor,
                                                _Item.Theta,
                                                _Item.Charm,
                                                _Item.Vanna,
                                                _Item.Volga
                                                 );
                }

                #endregion

                CopyToClipBoard(textData);
            }

            #endregion
        }

        private void CopyDataGridContentFixingTable(object sender, KeyEventArgs e)
        {
            #region Copy uisng Ctrl-C

            if (e.Key == Key.C &&
                ((Keyboard.Modifiers & ModifierKeys.Control) == ModifierKeys.Control
                || (Keyboard.Modifiers & ModifierKeys.Apple) == ModifierKeys.Apple)
                )
            {
                DataGrid DataGridFixingTable = sender as DataGrid;
                string textData = "";

                textData += ColumnHeadText(DataGridFixingTable);

                #region Value

                foreach (StructFixingData _Item in (List<StructFixingData>)DataGridFixingTable.ItemsSource)
                {
                    textData += string.Format(
                                               "{0}\t{1}\t{2}\t{3}\n",
                                               _Item.Fecha.ToString("dd/MM/yyyy"),
                                               _Item.Peso,
                                               _Item.Valor,
                                               _Item.Volatilidad
                                             );
                }

                #endregion

                CopyToClipBoard(textData);
            }

            #endregion
        }

        /// <summary>
        /// Genera String con encabezado de columna para copy/paste desde grilla
        /// </summary>
        /// <param name="dg">Grilla con los datos a copiar</param>
        /// <returns>String con los nombres de las columnas separados por tabulaciones</returns>
        private static string ColumnHeadText(DataGrid dg)
        {
            string _TextColumn = "";

            foreach (DataGridColumn _Column in dg.Columns)
            {
                if (_TextColumn != "")
                {
                    _TextColumn += "\t";
                }
                _TextColumn += _Column.Header;
            }
            _TextColumn += "\n";

            return _TextColumn;
        }

        /// <summary>
        /// Llena el ClipBoard de Windows con el string
        /// </summary>
        /// <param name="textData">Texto a cargar en ClipBoard</param>
        private static void CopyToClipBoard(string textData)
        {
            #region ClipBoardData

            ScriptObject clipboardData = (ScriptObject)HtmlPage.Window.GetProperty("clipboardData");
            if (clipboardData != null)
            {
                bool success = (bool)clipboardData.Invoke("setData", "text", textData);
            }
            else
            {
                System.Windows.Browser.HtmlPage.Window.Alert("Sorry, this functionality is only avaliable in Internet Explorer.");
            }

            #endregion
        }

        #endregion Copy's Using Ctrl-C

        #endregion Implementación Copy/Paste

    }
}
