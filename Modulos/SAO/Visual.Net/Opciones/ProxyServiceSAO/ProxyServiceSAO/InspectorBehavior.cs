using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ServiceModel.Description;
using System.ServiceModel.Dispatcher;
using System.Xml;
using System.Xml.Linq;
using System.Xml.XPath;

namespace ProxyServiceSAO
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


        var document = new XmlDocument();
        var root = document.CreateElement("soapenv", "Envelope", "http://schemas.xmlsoap.org/soap/envelope/");
        root.SetAttribute("xmlns:ns", "http://itau.cl/xmlns/BankPortfolioAndTreasury/CorporateTreasury/Tesoreria/1");
        root.SetAttribute("xmlns:ns1", "http://itau.cl/xmlns/xsd/1");
        document.AppendChild(root);

        var bodyHeader = document.CreateElement("soapenv", "Body", "http://schemas.xmlsoap.org/soap/envelope/");
        root.AppendChild(bodyHeader);

        var body = document.CreateElement("ns", "ControlLineaCreditoTesoreriaRq", "http://itau.cl/xmlns/BankPortfolioAndTreasury/CorporateTreasury/Tesoreria/1");
        bodyHeader.AppendChild(body);

        var replacedString = GetPayloadString(document);
        var removedString = replacedString.Replace(@"<ns:ControlLineaCreditoTesoreriaRq />", bodyRequestXml);


        return removedString;
    }


    /// Helper method to get the XMLDocument format right 
    private string GetPayloadString(XmlDocument document)
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