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
using AdminOpciones.Recursos;
using AdminOpciones.Struct;
using System.Xml.Linq;

namespace AdminOpciones.Controls
{
    public delegate void Cancelar();
    public delegate void Aceptar(bool estado, string msg);

    public partial class CambioClave : UserControl
    {
        public event Cancelar event_Cancelar;
        public event Aceptar event_Aceptar;
        public string UserControlName { get; set; }
        private List<StructClave> ClaveLis; //Revisar falta esta implementación.
        private XDocument xmlClave = new XDocument();
        private string message;
        private bool validacion;

        AdminOpciones.SrvLogin.WebLoginSoapClient _srvLogin;// = wsGlobales.WebLogin; //UriFormatException
        Recursos.Encript Encriptacion = new Encript();
        public bool isPantallaLayer = false;

        public CambioClave()
        {
            InitializeComponent();

            //Se mueve la asignación al mismo bloque que llama el Async.
            //De lo contrario genera Net_Uri_BadFormat
            //wsGlobales.WebLogin.WebCambioClaveCompleted += new EventHandler<AdminOpciones.SrvLogin.WebCambioClaveCompletedEventArgs>(_srvLogin_WebCambioClaveCompleted);
            message = "";
            validacion = false;            
            this.txbxUsuario.Text = globales._Usuario;
        }

        void _srvLogin_WebCambioClaveCompleted(object sender, AdminOpciones.SrvLogin.WebCambioClaveCompletedEventArgs e)
        {
            try
            {
                QuitLayer(this.CanvasCambioClavePrincipal);
                XDocument ReultXML = new XDocument(XDocument.Parse(e.Result));
                XElement dataXE = ReultXML.Element("ValidaPass").Element("Data");

                if (dataXE != null)
                {
                    validacion = dataXE.Attribute("Validation").Value == "TRUE" ? true : false;
                    message = dataXE.Attribute("Menssage").Value;
                }

                Limpiar();

                if (isPantallaLayer)
                    event_Aceptar(validacion, message);

                System.Windows.Browser.HtmlPage.Window.Alert(message);
            }
            catch { }
        }

        private void event_btnAceptar_Click(object sender, RoutedEventArgs e)
        {
            PutLayer(this.CanvasCambioClavePrincipal, "ESPERE...");
            message = "";
            ValidaContraseña(); 
        }

        private void event_btnCancelar_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                AdminOpciones.Controls.WindowsControls.CloseUserControl(UserControlName);

                if (isPantallaLayer)
                    event_Cancelar();
            }
            catch{};
        }

        private void ValidaContraseña()
        {
            validacion = true;            
            string CurrentPass, Newpass, RepNewPass;
            string msg = "";

            CurrentPass = this.txbxContraseña.Password;
            Newpass = this.txbxNuevaContraseña.Password;
            RepNewPass = this.txbxRepContraseña.Password;

            if (validacion && (msg+=ValidacionAlfanumerica(CurrentPass)) == "")
                CurrentPass = Encriptacion.sEncript(CurrentPass, true);
            else
                validacion = false;

            if (validacion && (msg+=ValidacionAlfanumerica(Newpass)) == "")
                Newpass = Encriptacion.sEncript(Newpass, true);
            else
                validacion = false;

            if (validacion && (msg+=ValidacionAlfanumerica(RepNewPass)) == "")
                RepNewPass = Encriptacion.sEncript(RepNewPass, true);
            else
                validacion = false;

            if (validacion)
            {
                _srvLogin = wsGlobales.WebLogin;
                _srvLogin.WebCambioClaveCompleted += new EventHandler<AdminOpciones.SrvLogin.WebCambioClaveCompletedEventArgs>(_srvLogin_WebCambioClaveCompleted);
                _srvLogin.WebCambioClaveAsync(this.txbxUsuario.Text, CurrentPass, Newpass, RepNewPass, globales.FechaProceso);
            }
            else
            {
                System.Windows.Browser.HtmlPage.Window.Alert(msg);
                QuitLayer(this.CanvasCambioClavePrincipal);
            }
        }

        private void Limpiar()
        {
            this.txbxContraseña.Password = "";
            this.txbxNuevaContraseña.Password = "";
            this.txbxRepContraseña.Password = "";
        }

        private string ValidacionAlfanumerica(string NuevaPass)
        {
            string ReturnMessage = "";            
            int minLength, maxLength;
            char ch1, ch2;
            //System.Text.RegularExpressions.Regex ExRegAlfa = new System.Text.RegularExpressions.Regex(@"^[A-Z]{1}[a-z]+[0-9]+$"); //Corpbanca01            
            System.Text.RegularExpressions.Regex ExNotRegAlfa = new System.Text.RegularExpressions.Regex(@"[^A-Za-z0-9]"); //Encuentra algun caracter que no sea alfanumerico
            System.Text.RegularExpressions.Regex ExRegMayus = new System.Text.RegularExpressions.Regex(@"[A-Z]+"); //Encuentra algun mayuscula
            System.Text.RegularExpressions.Regex ExRegNum = new System.Text.RegularExpressions.Regex(@"[0-9]+"); //Encuentra algun mayuscula

            minLength = 8;
            maxLength = 15;            

            if (NuevaPass.Length < minLength)
                ReturnMessage = ReturnMessage + "- La contraseña debe tener minimo " + minLength + " caracteres \n";

            if (NuevaPass.Length > maxLength)
                ReturnMessage = ReturnMessage + "- La contraseña debe tener maximo " + maxLength + " caracteres \n";

            if (ExNotRegAlfa.IsMatch(NuevaPass))
                ReturnMessage = ReturnMessage + "- La contraseña debe ser alfanumerica \n";


            if (!ExRegMayus.IsMatch(NuevaPass))
                ReturnMessage = ReturnMessage + "- La contraseña debe tener al menos una mayúscula \n";

            if (!ExRegNum.IsMatch(NuevaPass))
                ReturnMessage = ReturnMessage + "- La contraseña debe tener al menos un número \n";

            for (int i = 0; i < NuevaPass.Length - 1; i++) //No debe tener dos numeros iguales seguidos. DEF.Informal CBB Doc.Impreso
            {
                ch1 = Convert.ToChar(NuevaPass[i]);
                ch2 = Convert.ToChar(NuevaPass[i + 1]);
                if (ch1 == ch2)  //((int)ch1 >= 48 && (int)ch1 <= 57 && (int)ch2 >= 48 && (int)ch2 <= 57)
                    ReturnMessage = ReturnMessage + "- La contraseña no debe tener dos caracteres consecutivos iguales\n";
            }

            return ReturnMessage;
        }


        private void QuitLayer(Canvas CanvasParent)
        {
            Type _type = CanvasParent.GetType();
            bool _exist = false;
            Canvas _TransparentMasnk = null;

            foreach (FrameworkElement _element in CanvasParent.Children)
            {
                if (_element.GetType().Equals(_type) && _element.GetValue(NameProperty).Equals(CanvasParent.Name + "Layer"))
                {
                    _exist = true;
                    _TransparentMasnk = _element as Canvas;
                }
            }
            if (_exist && _TransparentMasnk != null)
            {
                CanvasParent.Children.Remove(_TransparentMasnk);
            }
        }

        private void PutLayer(Canvas CanvasParent, string message)
        {
            bool _exist = false;
            Type _type = CanvasParent.GetType();

            foreach (FrameworkElement _element in CanvasParent.Children)
            {
                if (_element.GetType().Equals(_type) && _element.GetValue(NameProperty).Equals(CanvasParent.Name + "Layer"))
                {
                    _exist = true;
                }
            }

            if (!_exist)
            {
                double _width, _height;

                Canvas TransparentLayer = new Canvas();
                TransparentLayer.Name = CanvasParent.Name + "Layer";

                _width = CanvasParent.Width;
                _height = CanvasParent.Height;

                TransparentLayer.SetValue(Canvas.LeftProperty, CanvasParent.GetValue(Canvas.LeftProperty));
                TransparentLayer.SetValue(Canvas.TopProperty, CanvasParent.GetValue(Canvas.TopProperty));

                TransparentLayer.Width = _width;
                TransparentLayer.Height = _height;
                TransparentLayer.Background = new SolidColorBrush(Colors.LightGray);
                TransparentLayer.Opacity = 0.9;

                Border _border = new Border();
                _border.BorderBrush = new SolidColorBrush(Colors.Gray);
                _border.BorderThickness = new Thickness(2, 2, 2, 2);

                TextBlock _message = new TextBlock();
                _message.TextWrapping = TextWrapping.Wrap;
                _message.Text = message;
                _message.Width = 200.0;
                _message.Margin = new Thickness(5, 10, 5, 10);

                _message.TextAlignment = TextAlignment.Center;

                _message.Opacity = 1.0;

                _message.FontSize = 14.0;
                _message.Foreground = new SolidColorBrush(Colors.Black);

                StackPanel _StackPanelMessage = new StackPanel();
                _StackPanelMessage.VerticalAlignment = VerticalAlignment.Center;
                _StackPanelMessage.Background = new SolidColorBrush(Colors.White);
                _StackPanelMessage.Children.Add(_message);
                _message.VerticalAlignment = VerticalAlignment.Center;

                _border.Child = _StackPanelMessage;

                _border.SetValue(Canvas.LeftProperty, (_width / 2.0) - 100);
                _border.SetValue(Canvas.TopProperty, (_height / 2.0) - 100);

                TransparentLayer.Children.Add(_border);

                CanvasParent.Children.Add(TransparentLayer);
            }
        }
    }
}
