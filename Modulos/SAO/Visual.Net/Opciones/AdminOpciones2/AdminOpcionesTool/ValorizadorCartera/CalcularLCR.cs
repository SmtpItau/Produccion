using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using cData.AccionesBD;         //20190612.RCH.Importar clase para ejecutar servicio CbMdbOpc..SP_Calculo_LCR_Interno_Opciones

namespace AdminOpcionesTool.ValorizadorCartera
{
    public static class CalcularLCR
    {
        public static string Calculate(string underlying, string operationtype, double mtm, double deltaspot, int tenor, double dobs, double Nocional, string vinculacion)
        {
            DataTable DtMoneda = cData.Detalles.svcDetalles.TraeDolarContable();

            string TipoBidAsk = operationtype == "C" ? "ASK" : "BID";

            cData.Rate.MatrizRec _Matriz = new cData.Rate.MatrizRec();

            DataRow _p = DtMoneda.Rows[0];
            double MonedaContable = Convert.ToDouble(_p["Tipo_Cambio"].ToString());
                     
            double _Factor = 0;
            int _RelativeCount = 0;
            double _Sign = operationtype.Equals("C") ? 1 : -1;

            DataTable _DT = _Matriz.Load(TipoBidAsk);
            List<MatrizRecStruct> _ListMatriz = new List<MatrizRecStruct>();

            foreach (DataRow _DR in _DT.Rows)
            {
                _ListMatriz.Add(new MatrizRecStruct(_DR));
            }

            _RelativeCount = _ListMatriz.Count - 1;

            if (_ListMatriz[0].Tenor >= tenor)
            {
                _Factor = _ListMatriz[0].Factor;
            }
            else if (_ListMatriz[_RelativeCount].Tenor <= tenor)
            {
                _Factor = _ListMatriz[_RelativeCount].Factor;
            }
            else
            {
                for (int _Data = 0; _Data < _ListMatriz.Count; _Data++)
                {
                    if (_ListMatriz[_Data].Tenor == tenor)
                    {
                        _Factor = _ListMatriz[_Data].Factor;
                        break;
                    }
                    else if (_ListMatriz[_Data].Tenor > tenor)
                    {
                        MatrizRecStruct _Point1 = _ListMatriz[_Data-1];
                        MatrizRecStruct _Point2 = _ListMatriz[_Data];
                        double _Slope = (_Point2.Factor - _Point1.Factor) / (Math.Round(_Point2.Tenor/360.0,11,MidpointRounding.AwayFromZero) - _Point1.Tenor);

                        _Factor = _Point1.Factor + _Slope * (Math.Round(tenor/365.0,4) - _Point1.Tenor);
                        break;
                    }
                }
            }

            dobs = Math.Round(MonedaContable,5,MidpointRounding.AwayFromZero);

            //Puede ser redundante, en teoría las ventas siempre tienen delta negativa.
            double _AddOn = Math.Abs(deltaspot * _Factor * dobs * _Sign);
            double _LCR = Math.Max(mtm + _AddOn, 0);
            //CbMdbOpc.SP_CALCULO_LCR_INTERNO_OPCIONES
            //[BacLineas].[dbo].[SP_RIEFIN_CALCULO_LCR_INTERNO_OPCIONES]
            //IF @CaVinculacion = 'Individual' AND @CompraVenta = 'V' -- Venta no imputa
            if (vinculacion.Equals("Individual") && operationtype.Equals("V"))
            {
                _LCR = 0.0;
            }

            double _LCRusd = _LCR / dobs;

            string srt = string.Format(
                                  "<LCR MTM='{0}' AddOn='{1}' LCR='{2}' LCRusd='{3}' Parity='{4}' Factor='{5}' />",
                                  mtm,
                                  _AddOn,
                                  _LCR,
                                  _LCRusd,
                                  dobs,
                                  _Factor
                                );
            return srt;
        }

        #region Simular_LCR
        public static string Calculate2(int _NumContrato, string _Operacion)
        {
            DataTable DtMoneda = cData.Detalles.svcDetalles.TraeDolarContable();

            DataTable _Resultado = new DataTable();

            DataRow _p = DtMoneda.Rows[0];
            double MonedaContable = Convert.ToDouble(_p["Tipo_Cambio"].ToString());

            _Resultado = Acciones.CalculaLCROpciones(_NumContrato, _Operacion);

            double MtoAvr=0;
            double MtoAddOn = 0;
            double _LCR = 0;
            double _LCRUSD = 0;
            double dobs = Math.Round(MonedaContable, 5, MidpointRounding.AwayFromZero);
            
            foreach (DataRow row in _Resultado.Rows)
            {
                MtoAvr = (double)row["Avr"];//.ToString();
                MtoAddOn = (double)row["Monto_AddOn"];//.ToString();
                _LCRUSD = (double)row["Monto_Imputacion"];//.ToString();
                _LCR = Math.Max(MtoAvr + MtoAddOn, 0);


            }
            _LCRUSD = _LCR / dobs;
            string srt = string.Format(
                                  "<LCR MTM='{0}' AddOn='{1}' LCR='{2}' LCRusd='{3}' Parity='{4}'/>",
                                  MtoAvr,
                                  MtoAddOn,
                                  _LCR,
                                  _LCRUSD,
                                  dobs
                         );
            return srt;
        }
        #endregion  Simular_LCR
    }
}
