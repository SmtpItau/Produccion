using System;
using System.Collections.Generic;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using System.Xml.Linq;
using AdminOpciones.Struct.OpcionesXF.Customers;

namespace AdminOpciones.Controls
{
    public delegate void isCondicGeneralesDelegate();
    public partial class ControlCliente : UserControl
    {    
        public event isCondicGeneralesDelegate event_delegate_isCondicGeneralesDelegate;
        private List<StructCustomers> CustomersList;
        public bool isCondicionesGenerales = false;
        //public ControlCliente()
        //{
        //    InitializeComponent();
        //    LoadCustomers();
        //}

        public ControlCliente()
        {
            InitializeComponent();
        }

        public void Load()
        {
            if (isCondicionesGenerales == false)
                LoadCustomers();
            else
                LoadCustomersCondicionesGenerales();            
        }
        
            

        public void Clear()
        {
            RutCliente.Text = "";
            comboCodigoRut.SelectedIndex = -1;
            NombreCliente.Text = "";
        }
        private void LoadCustomers()
        {
            SrvCustomers.SrvCustomersSoapClient _SrvCustomers = AdminOpciones.Recursos.wsGlobales.Customers;// new AdminOpciones.SrvCustomers.SrvCustomersSoapClient();
            _SrvCustomers.getCustomersDataCompleted += new EventHandler<AdminOpciones.SrvCustomers.getCustomersDataCompletedEventArgs>(_SrvCustomers_getCustomersDataCompleted);
            _SrvCustomers.getCustomersDataAsync();
        }

        private void _SrvCustomers_getCustomersDataCompleted(object sender, AdminOpciones.SrvCustomers.getCustomersDataCompletedEventArgs e)
        {
            XDocument xdoc = new XDocument(XDocument.Parse(e.Result));
            var customersVarComplete = from Customer in xdoc.Descendants("Data")
                                       select new StructCustomers
                                       {
                                           Clrut = Customer.Attribute("Clrut").Value.ToString(),
                                           Cldv = Customer.Attribute("Cldv").Value.ToString(),
                                           Clcodigo = Customer.Attribute("Clcodigo").Value.ToString(),
                                           Clnombre = Customer.Attribute("Clnombre").Value.ToString()
                                       };
            CustomersList = new List<StructCustomers>(customersVarComplete.ToList<StructCustomers>());

            var customersVarNombre = from Customer in xdoc.Descendants("Data")
                                     select Customer.Attribute("Clnombre").Value.ToString();

            var customersVarRut = from Customer in xdoc.Descendants("Data")
                                  select Customer.Attribute("Clrut").Value.ToString();

            this.autoCompleteBoxNombre.ItemsSource = customersVarNombre.ToList<string>();
            this.autoCompleteBoxRut.ItemsSource = customersVarRut.ToList<string>().Distinct<string>();
        }

        private void LoadCustomersCondicionesGenerales()
        {
            SrvCustomers.SrvCustomersSoapClient _SrvCustomers = AdminOpciones.Recursos.wsGlobales.Customers;// new AdminOpciones.SrvCustomers.SrvCustomersSoapClient();
            _SrvCustomers.getCustomersDataCondicionesGeneralesCompleted += new EventHandler<AdminOpciones.SrvCustomers.getCustomersDataCondicionesGeneralesCompletedEventArgs>(_SrvCustomers_getCustomersDataCondicionesGeneralesCompleted);
            _SrvCustomers.getCustomersDataCondicionesGeneralesAsync();
        }

        void _SrvCustomers_getCustomersDataCondicionesGeneralesCompleted(object sender, AdminOpciones.SrvCustomers.getCustomersDataCondicionesGeneralesCompletedEventArgs e)
        {
            XDocument xdoc = new XDocument(XDocument.Parse(e.Result));
            var customersVarComplete = from Customer in xdoc.Descendants("Data")
                                       select new StructCustomers
                                       {
                                           Clrut = Customer.Attribute("Clrut").Value.ToString(),
                                           Cldv = Customer.Attribute("Cldv").Value.ToString(),
                                           Clcodigo = Customer.Attribute("Clcodigo").Value.ToString(),
                                           Clnombre = Customer.Attribute("Clnombre").Value.ToString()
                                       };
            CustomersList = new List<StructCustomers>(customersVarComplete.ToList<StructCustomers>());

            var customersVarNombre = from Customer in xdoc.Descendants("Data")
                                     select Customer.Attribute("Clnombre").Value.ToString();

            var customersVarRut = from Customer in xdoc.Descendants("Data")
                                  select Customer.Attribute("Clrut").Value.ToString();

            this.autoCompleteBoxNombre.ItemsSource = customersVarNombre.ToList<string>();
            this.autoCompleteBoxRut.ItemsSource = customersVarRut.ToList<string>().Distinct<string>();
        }

        private void autocompleteNombreClosed(object sender, RoutedPropertyChangedEventArgs<bool> e)
        {
            if (this.autoCompleteBoxNombre.SelectedItem != null)
            {
                this.autoCompleteBoxRut.Text = CustomersList.Where(x => x.Clnombre == this.autoCompleteBoxNombre.Text).ToList<StructCustomers>()[0].Clrut;

                if (this.autoCompleteBoxRut.Text != "")
                {
                    var codigosRutVar = from CodigoItem in CustomersList.Where(x => x.Clrut == this.autoCompleteBoxRut.Text).ToList<StructCustomers>()
                                        select CodigoItem.Clcodigo.ToString();

                    this.comboCodigoRut.ItemsSource = codigosRutVar.ToList<string>();
                    if (codigosRutVar.ToList().Count == 0)
                    {
                        this.autoCompleteBoxNombre.Text = CustomersList.Where(x => x.Clrut == this.autoCompleteBoxRut.SelectedItem.ToString()).ToList<StructCustomers>()[0].Clnombre;
                    }
                    else
                    {
                        //comboCodigoRut.SelectedIndex = 1;
                    }
                }
            }
        }

        private void autocompleteRutClosed(object sender, RoutedPropertyChangedEventArgs<bool> e)
        {

            if (this.autoCompleteBoxRut.SelectedItem != null)
            {
                var codigosRutVar = from CodigoItem in CustomersList.Where(x => x.Clrut == this.autoCompleteBoxRut.Text).ToList<StructCustomers>()
                                    select CodigoItem.Clcodigo.ToString();

                this.comboCodigoRut.ItemsSource = null;
                this.comboCodigoRut.UpdateLayout();
                this.comboCodigoRut.ItemsSource = codigosRutVar.ToList<string>();

                if (comboCodigoRut.Items.Count == 0 && this.autoCompleteBoxRut.SelectedItem != null)
                {
                    this.autoCompleteBoxNombre.Text = CustomersList.Where(x => x.Clrut == this.autoCompleteBoxRut.SelectedItem.ToString()).ToList<StructCustomers>()[0].Clnombre;
                }
            }
        }

        private void autocompleteNombreLoaded(object sender, RoutedEventArgs e)
        {
            this.autoCompleteBoxNombre.IsEnabled = true;
        }

        private void autocompleteRutLoaded(object sender, RoutedEventArgs e)
        {
            this.autoCompleteBoxRut.IsEnabled = true;
        }

        private void comboCodigoRutSelectionChange(object sender, SelectionChangedEventArgs e)
        {
            if (this.comboCodigoRut.Items.Count > 0 && comboCodigoRut.SelectedItem != null)
            {
                this.autoCompleteBoxNombre.Text = CustomersList.Where(x => x.Clrut == this.autoCompleteBoxRut.SelectedItem.ToString() && x.Clcodigo == comboCodigoRut.SelectedItem.ToString()).ToList<StructCustomers>()[0].Clnombre;
            }
        }
    }
}
