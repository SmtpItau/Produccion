using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace ProxyServiceSAO
{
    // NOTA: puede usar el comando "Rename" del menú "Refactorizar" para cambiar el nombre de clase "Service1" en el código, en svc y en el archivo de configuración.
    public class ProxyLineaCredito : IProxyLineaCredito
    {
        public ProxyClientResult getLineaCode(string clienteAS400,string codigoCliente,string facility, string plazoOP,string montoLinea,string monedaAS400, string actionLine)
        {
            SrvTomaLinea.S_BankPortfolioAndTreasury_Tesoreria_ControlLineaCreditoTesoreriaClient client = new SrvTomaLinea.S_BankPortfolioAndTreasury_Tesoreria_ControlLineaCreditoTesoreriaClient();
            SrvTomaLinea.ControlLineaCreditoTesoreriaRq rq = new SrvTomaLinea.ControlLineaCreditoTesoreriaRq();
            SrvTomaLinea.MsgRqHdr_Type msg = new SrvTomaLinea.MsgRqHdr_Type();
            SrvTomaLinea.ContextRqHdr_Type cnt = new SrvTomaLinea.ContextRqHdr_Type();
            SrvTomaLinea.DevInfo_Type dev = new SrvTomaLinea.DevInfo_Type();
            SrvTomaLinea.PartyRef_Type pf = new SrvTomaLinea.PartyRef_Type();
            SrvTomaLinea.PartyKeys_Type pk = new SrvTomaLinea.PartyKeys_Type();
            SrvTomaLinea.LoginIdent_Type lq = new SrvTomaLinea.LoginIdent_Type();

            SrvTomaLinea.AcctTrnInfo_Type ac = new SrvTomaLinea.AcctTrnInfo_Type();
            SrvTomaLinea.TotalCurAmt_Type to = new SrvTomaLinea.TotalCurAmt_Type();
            SrvTomaLinea.CurAmt_Type cu = new SrvTomaLinea.CurAmt_Type();
            SrvTomaLinea.ExchangeRate_Type ex = new SrvTomaLinea.ExchangeRate_Type();
            SrvTomaLinea.CurCode_Type ba = new SrvTomaLinea.CurCode_Type();
            SrvTomaLinea.ContraCurCode_Type con = new SrvTomaLinea.ContraCurCode_Type();
            SrvTomaLinea.EffTimeFrame_Type ef = new SrvTomaLinea.EffTimeFrame_Type();
            SrvTomaLinea.Duration_Type du = new SrvTomaLinea.Duration_Type();
            SrvTomaLinea.ForExDealRec_Type fex = new SrvTomaLinea.ForExDealRec_Type();
            SrvTomaLinea.PartyRec_Type pr = new SrvTomaLinea.PartyRec_Type();
            SrvTomaLinea.FIData_Type fd = new SrvTomaLinea.FIData_Type();
            SrvTomaLinea.OfferInfo_Type of = new SrvTomaLinea.OfferInfo_Type();

            #region SETEO DATOS CABECERA FIJOS
            //SETEO DATOS CABECERA MSG (FIJO) 
            msg.AsyncRqUID = "1";
            cnt.ChnlId = "11";
            cnt.ChnlDesc = "1";
            cnt.AppId = "1";
            cnt.Browser = "1";
            cnt.ClientIp = "1";
            cnt.LangCode = "1";
            cnt.TimeStamp = "1";
            cnt.Token = "1";
            cnt.MobileKey = "1";
            pk.LoginIdent = lq;
            pf.PartyKeys = pk;
            cnt.PartyRef = pf;
            cnt.DevInfo = dev;
            dev.DevName = "1";
            lq.LoginName = "ITAINTER";

            msg.ContextRqHdr = cnt;
            rq.MsgRqHdr = msg;
            //FIN DATOS CABECERA (FIJO)
            #endregion


            #region SETEO DATOS Obtenidos
            du.Count = plazoOP;
            pr.PartyId = clienteAS400;
            fd.BranchName = "MSD";
            fd.BranchIdent = codigoCliente;
            ba.CurCodeValue = monedaAS400;
            con.CurCodeValue = monedaAS400;
            
            rq.RecSelect = actionLine;

            to.AmtSpecified = true;
            to.Amt = Double.Parse(montoLinea);
            cu.AmtSpecified = true;
            cu.Amt = 0;//Valor ART84 No lo poseo de momento

            //ex.ExchRate = 640;
            fex.ForExDealId = "0";
            of.PricingPlanIdent = facility.Trim();
            #endregion

            //Asociacion de Objetos            
            rq.OfferInfo = of;
            rq.PartyRec = pr;
            rq.FIData = fd;
            ac.TotalCurAmt = to;
            ac.CurA84Amt = cu;
            ex.BaseCurCode = ba;
            ex.ContraCurCode = con;
            ac.ExchangeRate = ex;
            rq.AcctTrnInfo = ac;
            ef.Duration = du;
            rq.EffTimeFrame = ef;
            rq.ForExDealRec = fex;

            InspectorBehavior ins = new InspectorBehavior();
            client.Endpoint.Behaviors.Add(ins);

           SrvTomaLinea.ControlLineaCreditoTesoreriaRs rs = client.ControlLineaCreditoTesoreria(rq);

           ProxyClientResult result = new ProxyClientResult();

           result.MsgStatusCode = rs.MsgRsHdr.Status.StatusCode;
           
           // string responseXML = requestInterceptor.LastResponseXML;
           if (result.MsgStatusCode == "0")
           {
               result.AdStatusCode = rs.MsgRsHdr.Status.AdditionalStatus[0].StatusCode;
               if (result.AdStatusCode != "200")
               {
                   result.StatusDesc = rs.MsgRsHdr.Status.AdditionalStatus[0].StatusDesc;
               }
               else
               {
                   result.ReturnCode = rs.RqUID;
               }
           }
           else
           {
               result.StatusDesc = rs.MsgRsHdr.Status.StatusDesc;
           }

           return result;
        }
    




    }

    public class ProxyClientResult
    {
        public string MsgStatusCode { get; set; }
        public string AdStatusCode { get; set; }
        public string StatusDesc { get; set; }
        public string ReturnCode { get; set; }

        

        public ProxyClientResult()
        {
        }
    }
}
