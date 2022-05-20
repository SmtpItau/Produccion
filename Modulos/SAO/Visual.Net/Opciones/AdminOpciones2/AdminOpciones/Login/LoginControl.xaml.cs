using System;
using System.Windows.Controls;
using System.Windows.Input;
using Microsoft.VisualBasic;
using System.Windows;
using System.Threading;
using System.Globalization;

namespace AdminOpciones.Login
{
    public partial class LoginControl : UserControl
    {
        public delegate void HazmeClickHandler(object sender, RoutedEventArgs e);
        public event HazmeClickHandler HazmeClickEvent;

        public LoginControl()
        {
            CultureInfo cul = new CultureInfo("es-CL");

            //Formato a la moneda #,##.0
            cul.NumberFormat.CurrencyDecimalSeparator = ",";
            cul.NumberFormat.CurrencyGroupSeparator = ".";

            //Formato a los numeros #,##.0
            cul.NumberFormat.NumberDecimalSeparator = ",";
            cul.NumberFormat.NumberGroupSeparator = ".";

            Thread.CurrentThread.CurrentCulture = cul;
            Thread.CurrentThread.CurrentUICulture = cul;

            InitializeComponent();
        }


        public void Login()
        {
            HazmeClickEvent(this.btnLogin, null);
        }

        private void txtCliID_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Delete || e.Key == Key.Back)
            {
                e.Handled = false;
                return;
            }
            
            string _key = e.Key.ToString();
            int _cont = _key.Length;
            if (_cont == 1)
            {
                if (Char.IsLetter(e.Key.ToString(), 0))
                {
                    e.Handled = true;
                    int _start = txtUserName.SelectionStart;
                    //hay texto seleccionado, reemplazamos contenido
                    if (!txtUserName.SelectedText.Equals(System.String.Empty))
                    {
                        txtUserName.Text = txtUserName.Text.Remove(_start, txtUserName.SelectionLength);
                    }
                    txtUserName.Text = txtUserName.Text.Insert(_start, e.Key.ToString());
                    txtUserName.SelectionStart = _start + _cont;
                }
            }
        }

        private void txtPassword_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Delete || e.Key == Key.Back)
            {
                e.Handled = false;
                return;
            }
            else if (e.Key == Key.Enter)
            {
                if (HazmeClickEvent != null)
                {
                    HazmeClickEvent(this.btnLogin, null);
                    return;
                }
            }
        }        
    }
}
