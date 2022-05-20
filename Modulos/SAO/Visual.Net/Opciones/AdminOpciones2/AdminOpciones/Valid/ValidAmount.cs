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

    public class ValidAmount
    {

        private System.Text.RegularExpressions.Regex allowableChars = new System.Text.RegularExpressions.Regex("^[-0123456789,]*$");
        private char[] mChars = { '*' };
        private string textBefore = null;
        private int selectionStart = 0;
        private int selectionLength = 0;
        public bool textchange = false;
        public int DecimalPlaces { get; set; }
        public bool Change { get; set; }
        private double ValueOld { get; set; }

        public void GotFocus(TextBox controlTextBox)
        {
            controlTextBox.Text = controlTextBox.Text.Replace(".", "");
            controlTextBox.SelectAll();
            textBefore = controlTextBox.Text;
            if (controlTextBox.Text.Equals(double.NaN.ToString()) || controlTextBox.Text.Equals("NaN") || controlTextBox.Text.Equals("NeuN"))
            {
                ValueOld = double.NaN;
                controlTextBox.Text = "";
            }
            else
            {
                ValueOld = double.Parse(controlTextBox.Text);
            }
        }

        public void KeyDown(TextBox controlTextBox)
        {
            if (controlTextBox.Text != "-")
            {
                textBefore = controlTextBox.Text;
            }            
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

            SetChange(controlTextBox, _Monto);

        }

        public void TextChange(TextBox controlTextBox)
        {
            string _Original = "";
            string _Change = "";
            string _Decimal = 0.ToString("0.0");
            string _NewValue = "";

            if (_Decimal.Substring(1).Equals(","))
            {
                _Original = ",";
                _Change = ".";
            }
            else
            {
                _Original = ".";
                _Change = ",";
            }

            if (DecimalPlaces.Equals(0))
            {
                _NewValue = controlTextBox.Text.Replace(_Original, "");
            }

            if (!textchange && controlTextBox.Text != "-" && _NewValue != textBefore)
            {
                //IAF 13/11/2009 estas lineas hacen que se pierda el formato. conversado cn MP.
                //if (!controlTextBox.Text.Replace(".", ",").Equals(controlTextBox.Text))
                //{
                //    controlTextBox.Text = controlTextBox.Text.Replace(".", ",");
                //    controlTextBox.SelectionStart = controlTextBox.Text.Length;
                //    controlTextBox.SelectionLength = controlTextBox.Text.Length;
                //}


                if (DecimalPlaces.Equals(0))
                {
                    controlTextBox.Text = controlTextBox.Text.Replace(_Original, "");
                }

                if (controlTextBox.Text.Equals(_Original))
                {
                    controlTextBox.Text = "0" + _Change;
                    controlTextBox.SelectionStart = controlTextBox.Text.Length;
                    controlTextBox.SelectionLength = controlTextBox.Text.Length;
                }
                else if (!controlTextBox.Text.Replace(_Original, _Change).Equals(controlTextBox.Text))
                {
                    controlTextBox.Text = controlTextBox.Text.Replace(_Original, _Change);
                    controlTextBox.SelectionStart = controlTextBox.Text.Length;
                    controlTextBox.SelectionLength = controlTextBox.Text.Length;
                }

                if (!controlTextBox.Text.Replace("*", "000").Equals(controlTextBox.Text))
                {
                    int _Pos = controlTextBox.Text.IndexOfAny(mChars);
                    controlTextBox.Text = controlTextBox.Text.Replace("*", "000");
                    controlTextBox.SelectionStart = _Pos + 3;
                }

                if (!allowableChars.IsMatch(controlTextBox.Text))
                {
                    if (controlTextBox.Text.Equals("NaN"))
                    {
                        controlTextBox.Text = "NaN";
                        controlTextBox.SelectionStart = controlTextBox.Text.Length;
                        controlTextBox.SelectionLength = controlTextBox.Text.Length;


                    }
                    else
                    {

                        try
                        {
                            //IAF Solo hace que se escriba el monto anterior con formato correcto.
                            controlTextBox.Text = textBefore;
                            //--
                            controlTextBox.SelectionStart = textBefore.Length;
                            controlTextBox.SelectionLength = textBefore.Length;
                        }
                        catch
                        {
                            controlTextBox.Text = "";
                            controlTextBox.SelectionStart = controlTextBox.Text.Length;
                            controlTextBox.SelectionLength = controlTextBox.Text.Length;
                        }
                    }
                }

                try
                {
                    double _Monto;
                    _Monto = double.Parse(controlTextBox.Text);
                    textBefore = _Monto.ToString();
                }
                catch
                {
                    if (textBefore != null)
                    {
                        controlTextBox.Text = textBefore;
                        controlTextBox.SelectionStart = textBefore.Length;
                        controlTextBox.SelectionLength = textBefore.Length;
                    }
                    else
                    {
                        textBefore = "";
                        controlTextBox.Text = textBefore;
                        controlTextBox.SelectionStart = textBefore.Length;
                        controlTextBox.SelectionLength = textBefore.Length;
                    }
                }

            }

            if (textchange)
            {
                textchange = false;
            }

        }

        public void ShowValue(TextBox controlTextBox)
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

            SetChange(controlTextBox, _Monto);
        }

        /// <summary>
        /// Actualiza valor del control TextBox con monto amount redondeado según ValidAmount.DecimalPlaces
        /// ver: https://msdn.microsoft.com/en-us/library/vstudio/0c899ak8(v=vs.95).aspx#Specifier0
        /// </summary>
        /// <param name="controlTextBox"></param>
        /// <param name="amount"></param>
        public void SetChange(TextBox controlTextBox, double amount)
        {
            string _Format = "#,##0." + "0000000000000000".Substring(0, DecimalPlaces);
            textchange = true;
            controlTextBox.Text = amount.ToString(_Format);
        }

        /// <summary>
        /// Como SetChange pero retorna el valor.
        /// </summary>
        /// <param name="controlTextBox"></param>
        /// <param name="amount"></param>
        /// <returns>Retorna el monto redondeado por SetChange.</returns>
        public Double GetSetChange(TextBox controlTextBox, double amount)
        {
            SetChange(controlTextBox, amount);
            return Double.Parse(controlTextBox.Text);
        }

    }

}
