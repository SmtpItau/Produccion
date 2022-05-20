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
using System.Text;
using System.ServiceModel.Description;
using System.ServiceModel.Dispatcher;
using System.Xml;
using System.Xml.Linq;


namespace AdminOpciones.Recursos
{
    public class InspectorBehavior : IEndpointBehavior
    {
        public string LastRequestXML
        {
            get
            {
                return myMessageInspector.LastRequestXML;
            }
        }

        public string LastResponseXML
        {
            get
            {
                return myMessageInspector.LastResponseXML;
            }
        }


        private MyMessageInspector myMessageInspector = new MyMessageInspector();
        public void AddBindingParameters(ServiceEndpoint endpoint, System.ServiceModel.Channels.BindingParameterCollection bindingParameters)
        {

        }

        public void ApplyDispatchBehavior(ServiceEndpoint endpoint, EndpointDispatcher endpointDispatcher)
        {

        }

        public void Validate(ServiceEndpoint endpoint)
        {

        }


        public void ApplyClientBehavior(ServiceEndpoint endpoint, ClientRuntime clientRuntime)
        {
            clientRuntime.MessageInspectors.Add(myMessageInspector);
        }
    }
}

public class MyMessageInspector : IClientMessageInspector
{
    public string LastRequestXML { get; private set; }
    public string LastResponseXML { get; private set; }
    public void AfterReceiveReply(ref System.ServiceModel.Channels.Message reply, object correlationState)
    {
        LastResponseXML = reply.ToString();
    }

    public object BeforeSendRequest(ref System.ServiceModel.Channels.Message request, System.ServiceModel.IClientChannel channel)
    {


        LastRequestXML = request.ToString();
        
        var xmlPayload = ChangeMessage();
        var ms = new System.IO.MemoryStream();
        var writer = new System.IO.StreamWriter(ms);
        writer.Write(xmlPayload);
        writer.Flush();
        ms.Position = 0;


        var reader = XmlReader.Create(ms);
        request = System.ServiceModel.Channels.Message.CreateMessage(reader, int.MaxValue, request.Version);
        
        return request;


    }


    /// Manipulate the SOAP message 
    private string ChangeMessage()
    {
        // LastRequestXML is a string here. You can change it to your heart's content 
        // Sample example here 

        // NOTE - I couldn't load the string into an XDocument or XMLDocument as it was throwing all sort of errors 
        // about undefined namespaces. String manipulation to the rescue! 

        // strip out the envelope and header 
        var startIndexOfStringToKeep = LastRequestXML.IndexOf("<MsgRqHdr", StringComparison.CurrentCulture);

        // strip out the footer 
        var sanitizedRequestXml = LastRequestXML.Substring(startIndexOfStringToKeep - 1);
        var firstPhase = sanitizedRequestXml.Replace(@"</s:Envelope>", string.Empty);
        var secondPhase = firstPhase.Replace(@"</s:Body>", string.Empty);
        var thirdPhase = secondPhase.Replace(@"</ControlLineaCreditoTesoreriaRq>", string.Empty);

        // wrap the body with the right element declarations sans any namespaces 
        var bodyRequestXml = "<ns:ControlLineaCreditoTesoreriaRq>" + thirdPhase + "</ns:ControlLineaCreditoTesoreriaRq>";


        var document = new XDocument();
        XNamespace envelope = "http://schemas.xmlsoap.org/soap/envelope/";
        XNamespace ns = "http://itau.cl/xmlns/BankPortfolioAndTreasury/CorporateTreasury/Tesoreria/1";
        XNamespace ns1 = "http://itau.cl/xmlns/xsd/1";


        var root = new XElement(envelope+"Envelope", new XAttribute(XNamespace.Xmlns + "soapenv", envelope.NamespaceName),
            new XAttribute(XNamespace.Xmlns + "ns", ns.NamespaceName), new XAttribute(XNamespace.Xmlns + "ns1", ns1.NamespaceName));
    

       // document.Add(root);

        var bodyHeader = new XElement(envelope+"Body");
        //root.Add(bodyHeader);

        var body = new XElement("ControlLineaCreditoTesoreriaRq");
        bodyHeader.Add(body);
        root.Add(bodyHeader);
        document.Add(root);

        var replacedString = GetPayloadString(document);
        var removedString = replacedString.Replace(@"<ControlLineaCreditoTesoreriaRq />", bodyRequestXml);


        return removedString;
    }


    /// Helper method to get the XMLDocument format right 
    private string GetPayloadString(XDocument document)
    {
        var settings = new XmlWriterSettings();
        settings.OmitXmlDeclaration = true;
        using (var stringWriter = new System.IO.StringWriter())
        using (var xmlTextWriter = XmlWriter.Create(stringWriter, settings))
        {
            document.WriteTo(xmlTextWriter);
            xmlTextWriter.Flush();
            return stringWriter.GetStringBuilder().ToString();
        }
    } 



}
