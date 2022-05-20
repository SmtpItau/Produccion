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
using System.Text.RegularExpressions;

namespace AdminOpciones.Valid
{
    public class TermValidate
    {        
        string AntNumero = "";
        string AntText = "";
        public bool IsValid= false;
        private bool textchange = false;

        private Regex permiteNumeroLetra = new Regex("^[0123456789]+[d|D|w|W|m|M|y|Y]$");
        private Regex permiteNumero = new Regex("^[0123456789]+$");

        int selectionStart = 0;
        int selectionLength = 0;
 

        public void TextChange(TextBox controlTextBox)
        {
            if (!textchange)
            {
                string _texto = controlTextBox.Text;
                string _Numero;
                bool _textoCompletoValido = false;


                if (permiteNumero.IsMatch(_texto) && !permiteNumeroLetra.IsMatch(_texto))
                {
                    _Numero = _texto;
                    AntNumero = _Numero;
                    AntText = _Numero;
                    _textoCompletoValido = false;
                }
                else if (permiteNumeroLetra.IsMatch(_texto))
                {
                    string _TextoValido = _texto;
                    _Numero = _TextoValido.Substring(0, _texto.Length - 1);
                    AntNumero = _texto;
                    AntText = _texto;
                    _textoCompletoValido = true;


                }
                else
                {
                    if (permiteNumeroLetra.IsMatch(_texto))
                    {
                        controlTextBox.Text = AntText;
                    }
                    else
                    {
                        controlTextBox.Text = AntNumero;
                    }


                    controlTextBox.SelectionStart = selectionStart;
                    controlTextBox.SelectionLength = selectionLength;
                }

                if (_textoCompletoValido)
                {
                    IsValid = true;
                }
                else
                {
                    IsValid = false;
                }
            }
            else
            {
                textchange = false;
            }
        }

        /// <summary>
        /// Deja seleccionado (Marcado) el texto del TextBox.
        /// </summary>
        /// <param name="controlTextBox"></param>
        public void KeyDown(TextBox controlTextBox)
        {
            selectionStart = controlTextBox.SelectionStart;
            selectionLength = controlTextBox.SelectionLength;
        }
        
        public void LostFocus(TextBox controlTextBox)
        {
            string _texto = controlTextBox.Text;

            if (permiteNumeroLetra.IsMatch(_texto))
            {
                string _TextoValido = _texto;                
                AntNumero = _texto;
                AntText = _texto;
                IsValid = true;
                //return true;
            }
            else if (permiteNumero.IsMatch(_texto))
            {
                controlTextBox.Text = _texto + "d";
                controlTextBox.SelectionStart = selectionStart;
                controlTextBox.SelectionLength = selectionLength;
                this.IsValid = true;


            }
            else { this.IsValid = false; }
            //return false;

        }

        public void GotFocus(TextBox controlTextBox)
        {            

            if (permiteNumero.IsMatch(controlTextBox.Text) && !permiteNumeroLetra.IsMatch(controlTextBox.Text))
            {
                AntNumero = controlTextBox.Text;
                IsValid = false;
            }
            else if (permiteNumeroLetra.IsMatch(controlTextBox.Text))
            {
                AntNumero = controlTextBox.Text;
                AntText = controlTextBox.Text;
                IsValid = true;
            }

            controlTextBox.SelectionStart = selectionStart;
            controlTextBox.SelectionLength = selectionLength;
            controlTextBox.Text = controlTextBox.Text.Replace(".", "");
            controlTextBox.SelectAll();
             
           
        }

        public void SetValue(TextBox controlTextBox, string value)
        {
            textchange = true;
            controlTextBox.Text = value;
        }

    }
}
