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
using System.Collections.Generic;

namespace AdminOpciones.Controls
{
    public static class WindowsControls
    {

        #region User Controls

        private static Grid __UserControls;
        public static Grid UserControls
        {
            get
            {
                return __UserControls;
            }
            set
            {
                __UserControls = value;
            }
        }

        #endregion

        #region Manejo de Ventanas

        #region Find User Control

        public static bool FindUserControl(string name)
        {
            Liquid.Dialog _Dialog = new Liquid.Dialog();
            int _Item;
            bool _Exists = false;

            for (_Item = 0; _Item < __UserControls.Children.Count; _Item++)
            {

                if (__UserControls.Children[_Item].GetType().FullName.Equals("Liquid.Dialog"))
                {
                    _Dialog = (Liquid.Dialog)__UserControls.Children[_Item];

                    if (_Dialog.Tag.Equals(name))
                    {
                        _Exists = true;
                    }

                }

            }

            return _Exists;
        }

        public static List<Object> FindListUserControl(string name)
        {
            List<Object> _ListDialog = new List<Object>();
            ScrollViewer _Scroll = new ScrollViewer();
            Object _Object = new object();
            Liquid.Dialog _Dialog = new Liquid.Dialog();

            foreach (Object _Item in __UserControls.Children)
            {

                if (_Item.GetType().FullName.Equals("Liquid.Dialog"))
                {
                    _Dialog = (Liquid.Dialog)_Item;

                    if (_Dialog.Tag.Equals(name))
                    {
                        _Scroll = (ScrollViewer)_Dialog.Content;
                        _Object = _Scroll.Content;
                        _ListDialog.Add(_Object);
                    }

                }

            }

            return _ListDialog;
        }

        public static int CountControl(string name)
        {
            Liquid.Dialog _Dialog = new Liquid.Dialog();
            int _Item;
            int _Count = 0;

            for (_Item = 0; _Item < __UserControls.Children.Count; _Item++)
            {

                if (__UserControls.Children[_Item].GetType().FullName.Equals("Liquid.Dialog"))
                {
                    _Dialog = (Liquid.Dialog)__UserControls.Children[_Item];

                    if (_Dialog.Tag.Equals(name))
                    {
                        _Count++;
                    }

                }

            }

            return _Count;
        }

        public static string UserControlName(string name)
        {
            return string.Format("{0}{1}", name, (Count(name)+1).ToString("000000"));
        }

        public static int Count(string name)
        {
            Liquid.Dialog _Dialog = new Liquid.Dialog();
            int _Item;
            int _Count = 0;

            for (_Item = 0; _Item < __UserControls.Children.Count; _Item++)
            {

                if (__UserControls.Children[_Item].GetType().FullName.Equals("Liquid.Dialog"))
                {
                    _Dialog = (Liquid.Dialog)__UserControls.Children[_Item];

                    if (_Dialog.Tag.Equals(name))
                    {
                        _Count++;
                    }

                }

            }

            return _Count;
        }

        #endregion

        #region Create User Control

        public static int CreateUserControl(UserControl userControl, string title, string userName, string optionmenu)
        {
            return CreateUserControl(userControl, title, userName, userName, optionmenu, 0, 0, 0);
        }

        public static int CreateUserControl(UserControl userControl, string title, string userName, string tag, string optionmenu)
        {
            return CreateUserControl(userControl, title, userName, tag, optionmenu, 0, 0, 0);
        }

        public static int CreateUserControl(UserControl userControl, string title, string userName, string tag, string optionmenu, int modal)
        {
            return CreateUserControl(userControl, title, userName, tag, optionmenu, modal, 0, 0);
        }

        public static int CreateUserControl(UserControl userControl, string title, string userName, string optionmenu, int modal, double x, double y)
        {
            return CreateUserControl(userControl, title, userName, userName, optionmenu, modal, x, y);
        }

        public static int CreateUserControl(UserControl userControl, string title, string userName, string userTag, string optionmenu, int modal, double x, double y)
        {
            int _Position;
            bool _IsControlBox = true;

            if (userTag.Equals("UserControlProcess"))
            {
                _IsControlBox = false;
            }

            Liquid.Dialog _DialogControl = new Liquid.Dialog();
            ScrollViewer _Scroll = new ScrollViewer();

            _Scroll.Content = userControl;
            _Scroll.HorizontalScrollBarVisibility = ScrollBarVisibility.Auto;
            _Scroll.VerticalScrollBarVisibility = ScrollBarVisibility.Auto;
            _Scroll.Tag = optionmenu;

            SolidColorBrush _Solid = new SolidColorBrush();
            _Solid.Color = Color.FromArgb(255, 10, 130, 196);

            _DialogControl.Title = title;
            _DialogControl.TitleBarBackground = _Solid;
            _DialogControl.Name = userName;
            _DialogControl.Content = _Scroll;

            double _WidthArea = __UserControls.Width - x - 10;
            double _HeightArea = __UserControls.Height - y;
            double _WindowsControlWidht = _WidthArea;
            double _WindowsControlHeight = _HeightArea;
            double _ScrollHorizontal = 0;
            double _ScrollVertical = 0;
            double _UserControlWidth = userControl.Width + 18;
            double _UserControlHeight = userControl.Height + 40;

            if (AdminOpciones.Recursos.globales._Turing)
            {
                _WidthArea = 1259; //__UserControls.Width - x - 10;
                _HeightArea = 831;// __UserControls.Height - y;
                _WindowsControlWidht = _WidthArea;
                _WindowsControlHeight = _HeightArea;
                _ScrollHorizontal = 0;
                _ScrollVertical = 0;
                _UserControlWidth = 750;// userControl.Width + 18;
                _UserControlHeight = 1020; //userControl.Height + 40;
            }

            if (_UserControlHeight > _HeightArea)
            {
                _ScrollHorizontal = 10;
                _Scroll.VerticalScrollBarVisibility = ScrollBarVisibility.Auto;
            }
            else
            {
                _Scroll.VerticalScrollBarVisibility = ScrollBarVisibility.Hidden;
            }

            if (_UserControlWidth > _WidthArea)
            {
                _ScrollHorizontal = 10;
                _Scroll.HorizontalScrollBarVisibility = ScrollBarVisibility.Auto;
            }
            else
            {
                _Scroll.HorizontalScrollBarVisibility = ScrollBarVisibility.Hidden;
            }

            _DialogControl.Width = Math.Min(_UserControlWidth, _WindowsControlWidht - _ScrollVertical);
            _DialogControl.Height = Math.Min(_UserControlHeight, _WindowsControlHeight - _ScrollHorizontal);
            _DialogControl.StartPosition = Liquid.DialogStartPosition.Manual;

            if (modal.Equals(1))
            {
                x = (__UserControls.Width - userControl.Width) / 2;
                y = (__UserControls.Height - userControl.Height) / 2;
            }

            _DialogControl.HorizontalOffset = x;
            _DialogControl.VerticalOffset = y;

            _DialogControl.IsResizable = _IsControlBox;
            _DialogControl.IsMaximizeEnabled = _IsControlBox;
            _DialogControl.IsMinimizeEnabled = _IsControlBox;
            _DialogControl.IsCloseEnabled = userTag.Equals("PRICINGSWAP") ? true : _IsControlBox;
            _DialogControl.Buttons = Liquid.DialogButtons.None;
            _DialogControl.Tag = userTag;


            if (AdminOpciones.Recursos.globales._Turing)
            {
                _DialogControl.IsResizable = false;
                _DialogControl.IsMaximizeEnabled = false;
                _DialogControl.IsMinimizeEnabled = false;
                _DialogControl.IsCloseEnabled = false;
            
            }


            _DialogControl.SizeChanged += new SizeChangedEventHandler(SizeChangeUserControl);
            _DialogControl.CloseCompleted += new Liquid.DialogEventHandler(CloseUserControlCompleted);

            __UserControls.Children.Add(_DialogControl);

            _Position = __UserControls.Children.Count - 1;

            _DialogControl.Show();

            AdminOpciones.Controls.LogAuditoria.SaveLogAuditoria(optionmenu, "07", "");

            return _Position;

        }

        #endregion

        #region Sise Change User Control

        private static void SizeChangeUserControl(object sender, SizeChangedEventArgs e)
        {
            Liquid.Dialog _Windows = (Liquid.Dialog)sender;

            //if (_Windows.SizeState != Liquid.DialogSizeState.Minimized)
            //{
            //}
        }

        public static void Resize()
        {

            int _Item = 0;

            for (_Item = 0; _Item < __UserControls.Children.Count; _Item++)
            {

                if (__UserControls.Children[_Item].GetType().FullName.Equals("Liquid.Dialog"))
                {

                    Resize((Liquid.Dialog)__UserControls.Children[_Item]);
                }

            }

        }

        private static void Resize(Liquid.Dialog windowsControl)
        {

            double _Position_X;
            double _Position_Y;

            if (windowsControl.Tag.Equals("LOGIN"))
            {
                _Position_Y = (__UserControls.Height - windowsControl.Height) / 2.0;
                _Position_X = (__UserControls.Width - windowsControl.Width) / 2.0;

                windowsControl.HorizontalOffset = _Position_X;
                windowsControl.VerticalOffset = _Position_Y;
            }

        }

        #endregion

        #region Close User Control

        public static void CloseAllUserControl()
        {
            Liquid.Dialog _Dialog = new Liquid.Dialog();
            int _Item;
            for (_Item = 0; _Item < __UserControls.Children.Count; _Item++)
            {
                if (__UserControls.Children[_Item].GetType().FullName.Equals("Liquid.Dialog"))
                {
                    _Dialog = (Liquid.Dialog)__UserControls.Children[_Item];
                    ScrollViewer _Scroll = (ScrollViewer)_Dialog.Content;
                    AdminOpciones.Controls.LogAuditoria.SaveLogAuditoria(_Scroll.Tag.ToString(), "08", "");
                    _Dialog.Close();
                    __UserControls.Children.Remove(_Dialog);
                    break;
                }
            }

        }

        public static void CloseUserControlCompleted(object sender, EventArgs e)
        {

            Liquid.Dialog _Dialog = (Liquid.Dialog)sender;
            ScrollViewer _Scroll = (ScrollViewer)_Dialog.Content;

            CloseUserControl(_Dialog.Name);
        }

        public static void CloseUserControl(string index)
        {

            Liquid.Dialog _Dialog = new Liquid.Dialog();
            int _Item;

            for (_Item = 0; _Item < __UserControls.Children.Count; _Item++)
            {

                if (__UserControls.Children[_Item].GetType().FullName.Equals("Liquid.Dialog"))
                {
                    _Dialog = (Liquid.Dialog)__UserControls.Children[_Item];

                    if (_Dialog.Name.Equals(index))
                    {
                        ScrollViewer _Scroll = (ScrollViewer)_Dialog.Content;
                        AdminOpciones.Controls.LogAuditoria.SaveLogAuditoria(_Scroll.Tag.ToString(), "08", "");
                        _Dialog.Close();
                        __UserControls.Children.Remove(_Dialog);
                        break;
                    }

                }

            }

        }

        #endregion

        #endregion

    }

}
