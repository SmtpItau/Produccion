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

namespace AdminOpciones.Valid
{

    public class ValidNumber
    {

        private System.Text.RegularExpressions.Regex allowableChars = new System.Text.RegularExpressions.Regex("^[-0123456789]*$");
        private string textBefore = null;
        private int selectionStart = 0;
        private int selectionLength = 0;
        private bool textchange = false;
        public bool Change { get; set; }
        private double ValueOld { get; set; }

        public void GotFocus(TextBox controlTextBox)
        {

            controlTextBox.Text = controlTextBox.Text.Replace(".", "");
            controlTextBox.SelectAll();
            textBefore = controlTextBox.Text;
            ValueOld = double.Parse(controlTextBox.Text);

        }

        public void KeyDown(TextBox controlTextBox)
        {

            textBefore = controlTextBox.Text;
            selectionStart = controlTextBox.SelectionStart;
            selectionLength = controlTextBox.SelectionLength;

        }

        public void LostFocus(TextBox controlTextBox)
        {

            double _Monto;

            try
            {
                _Monto = double.Parse(controlTextBox.Text);
            }
            catch
            {
                _Monto = 0;
            }

            if (!ValueOld.Equals(_Monto))
            {
                Change = true;
            }
            else
            {
                Change = false;
            }

            textchange = true;
            SetChange(controlTextBox, _Monto);

        }

        public void TextChange(TextBox controlTextBox)
        {

            if (!textchange)
            {

                if (!allowableChars.IsMatch(controlTextBox.Text))
                {
                    controlTextBox.Text = textBefore;
                    controlTextBox.SelectionStart = textBefore.Length;
                    controlTextBox.SelectionLength = textBefore.Length;
                }

                try
                {

                    int _Monto;
                    _Monto = int.Parse(controlTextBox.Text);
                    textBefore = _Monto.ToString();

                }
                catch
                {
                    controlTextBox.Text = textBefore;
                    controlTextBox.SelectionStart = selectionStart;
                    controlTextBox.SelectionLength = selectionLength;
                }

            }
            else
            {
                textchange = false;
            }

        }

        public void SetChange(TextBox controlTextBox, double amount)
        {

            textchange = true;
            controlTextBox.Text = amount.ToString("#,##0");

        }

    }

}
