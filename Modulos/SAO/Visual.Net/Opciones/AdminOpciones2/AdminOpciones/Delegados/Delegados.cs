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

namespace AdminOpciones.Delegados
{
    public delegate void SendID(int id);
    public delegate void SendChecked();
    public delegate void CierraSesion();
    public delegate void CloseWindows(string userControlName);
    public delegate void RefreshStatusSystem(string opcion);
    public delegate void RefreshControlMesa(int status);
}
