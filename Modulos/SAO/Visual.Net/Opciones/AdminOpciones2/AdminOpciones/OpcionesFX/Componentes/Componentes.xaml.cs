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

namespace AdminOpciones.OpcionesFX.Componentes
{
    public partial class Componentes : UserControl
    {
        public Componentes()
        {
            InitializeComponent();
        }

        private void event_btnXComponentes_Click(object sender, RoutedEventArgs e)
        {
            this.Visibility = Visibility.Collapsed;
        }

        private void UserControl_SizeChanged(object sender, SizeChangedEventArgs e)
        {
            GridPrincipalComponentes.Width = e.NewSize.Width;
            GridPrincipalComponentes.Height = e.NewSize.Height;
        }

    }
}
