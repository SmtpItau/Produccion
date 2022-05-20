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

namespace AdminOpciones.OpcionesFX.TopologiaVegaPricing
{    
    public partial class TopoLogiaVegaPricingControl : UserControl
    { 
        public TopoLogiaVegaPricingControl()
        {
            InitializeComponent();
        }

        private void event_btn_X_TopologiaVegaPricing_Click(object sender, RoutedEventArgs e)
        {
            this.Visibility = Visibility.Collapsed;
        }

        private void event_TabControl_TopologiaVegaPricing_SelectedChanged(object sender, SelectionChangedEventArgs e)
        {
        }
        
    }
}
