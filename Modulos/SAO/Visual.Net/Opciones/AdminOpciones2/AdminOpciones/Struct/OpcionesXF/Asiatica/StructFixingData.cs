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
using System.Linq;
using System.Xml.Linq;

namespace AdminOpciones.Struct.OpcionesXF.Asiatica
{
    public class StructFixingData
    {
        public DateTime Fecha { get; set; }
        public double Valor { get; set; }
        
        /// <summary>
        /// Peso de la fijación, con signo.
        /// Obs: con la implementación de 12567, puede haber problema con el caso de peso = -0.
        /// </summary>
        public double Peso { get; set; }

        public double Volatilidad { get; set; }
        public int Plazo { get; set; }

        public StructFixingData() { }

        public StructFixingData(StructFixingData value)
        {
            Fecha = value.Fecha;
            Valor = value.Valor;
            Peso = value.Peso;
            Volatilidad = value.Volatilidad;
            Plazo = value.Plazo;
        }

        public StructFixingData(DateTime fecha,
                            double valor,
                            double peso,
                            double volatilidad, int plazo)
        {
            Fecha = fecha;
            Valor = valor;
            Peso = peso;
            Volatilidad = volatilidad;
            Plazo = plazo;
        }

        public string sFecha 
        {
            get 
            {
                return Fecha.ToString("dd-MM-yyyy");
            }
            set
            {
                this.Fecha = DateTime.Parse(value);
            }

        }
        public string sValor
        {
            get
            {
                return this.Valor.ToString("#,##0.#00");
            }
        }
        public string sPeso
        {
            get
            {
                return this.Peso.ToString("#,##0.#00");
            }
        }
        public string sPesoSinSigno //PRD_12567
        {
            get
            {
                return Math.Abs(this.Peso).ToString("#,##0.#00");
            }
        }
        public string sVolatilidad
        {
            get
            {
                return this.Volatilidad.ToString("#,##0.#00");
            }
        }
        public string sPlazo
        {
            get
            {
              
                return this.Plazo.ToString("###0");
            }
        }
    }

    //Dejé este código aca porque la implementación es dependiente de la estructura de Fixing.

    //Extension methods must be defined in a static class
    public static class StructFixingDataStringExtension
    {
        /// <summary>
        /// Convierte un string con XML de fixing en una lista de fixing.
        /// </summary>
        /// <param name="XMLString">String con representación de XML.</param>
        /// <returns>Retorna una Lista de StructFixingData</returns>
        public static List<StructFixingData> ToListStructFixingData(this string XMLString)
        {
            return XML_StructFixingData_ToList(XMLString, 0);
        }

        /// <summary>
        /// Convierte un string con XML de fixing en una lista de fixing, definiendo el signo del peso de las fijaciones.
        /// </summary>
        /// <param name="XMLString">String con representación de XML.</param>
        /// <param name="signo">Define el signo de los pesos. 0: no lo altera, 1: positivos (Salida), -1: negativos (Entrada).</param>
        /// <returns>Retorna una Lista de StructFixingData de Entrada o Salida</returns>
        public static List<StructFixingData> ToListStructFixingData(this string XMLString, int signo)
        {
            return XML_StructFixingData_ToList(XMLString, signo);
        }

        /// <summary>
        /// Genera lista de fixing en base a XML de fixing.
        /// </summary>
        /// <param name="strFixingValue">XML con tabla de fijación</param>
        /// <param name="EntradaSalida">Signo para el peso de las fijaciones, por convención las de Entrada son negativas, las de Salida positivas.</param>
        /// <returns></returns>
        private static List<StructFixingData> XML_StructFixingData_ToList(string strFixingValue, int signo)
        {
            XDocument xdoc = new XDocument(XDocument.Parse(strFixingValue));

            //Signo de Entrada o Salida, ojo con multiplicar int con double
            var elements = from elementItem in xdoc.Descendants("FixingValues")
                           select new StructFixingData
                           {
                               Fecha = DateTime.Parse(elementItem.Attribute("Fecha").Value.ToString()),
                               Valor = double.Parse(elementItem.Attribute("Valor").Value.ToString()),
                               Peso = signo == 0 ? double.Parse(elementItem.Attribute("Peso").Value) //Si es 0 no alteramos los pesos.
                                        : signo * Math.Abs(double.Parse(elementItem.Attribute("Peso").Value)), //else, aplicamos signo
                               Volatilidad = double.Parse(elementItem.Attribute("Volatilidad").Value.ToString()),
                               Plazo = int.Parse(elementItem.Attribute("Plazo").Value.ToString())
                           };

            List<StructFixingData> _fixingdataList = new List<StructFixingData>(elements.ToList<StructFixingData>());
            return _fixingdataList;
        }
    } //public static class StructFixingDataStringExtension
}
