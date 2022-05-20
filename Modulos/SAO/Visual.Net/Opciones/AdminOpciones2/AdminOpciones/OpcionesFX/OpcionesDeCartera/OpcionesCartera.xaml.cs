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

namespace AdminOpciones.OpcionesFX.OpcionesDeCartera
{

    public delegate void SendComboBoxString(string comboboxTag, string itemOption);

    public partial class OpcionesCartera : UserControl
    {
        public event SendComboBoxString ChangedComboBoxOption;        
        
        public OpcionesCartera()
        {
            InitializeComponent();       
        }

        private void event_btnXButton_Click(object sender, RoutedEventArgs e)
        {
            this.Visibility = Visibility.Collapsed;

        }

        private void event_comboLibro_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ChangedComboBoxOption("Libro", comboLibro.SelectedItem.ToString());

        }

        private void event_comboCarteraFinanciera_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ChangedComboBoxOption("CarteraFinanciera", comboLibro.SelectedItem.ToString());
        }

        private void event_comboCarteraNormativa_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ChangedComboBoxOption("CarteraNormativa", comboLibro.SelectedItem.ToString());
        }

        private void event_comboSubCarteraNormativa_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            ChangedComboBoxOption("SubCarteraNormativa", comboLibro.SelectedItem.ToString());
        }
    }
}
