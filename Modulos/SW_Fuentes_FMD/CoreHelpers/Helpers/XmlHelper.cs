#pragma warning disable 1591
using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using System.Xml;
using System.Xml.Serialization;
using System.Text;
using System.IO;

namespace CoreLib.Helpers
{
    public static class XmlHelper
    {
        
        public static XDocument Serialize<T>(T source)
        {
            XDocument target = new XDocument();
            XmlSerializer s = new XmlSerializer(typeof(T));
            System.Xml.XmlWriter writer = target.CreateWriter();
            s.Serialize(writer, source);
            writer.Close();
            return target;
        }

        public static XmlDocument SerializeToXML<T>(T source)
        {
      
                XmlDocument doc = new XmlDocument();
                XmlSerializer serial = new XmlSerializer(typeof(T));

                using (MemoryStream stream = new MemoryStream())
                {
                    serial.Serialize(stream, source);
                    stream.Flush();
                    stream.Seek(0, SeekOrigin.Begin);
                    doc.Load(stream);
                }
                return doc;
        
        }


        public static XmlDocument SerializeToXML<T>(T source,Encoding encoding)
        {
            XmlDocument doc = new XmlDocument();
            XmlSerializer serial = new XmlSerializer(typeof(T));
            XmlSerializerNamespaces ns = new XmlSerializerNamespaces();

            string file = System.Environment.CurrentDirectory + "\\temp.xml";
                       
            using (StreamWriter stream = new StreamWriter(file,false,
               encoding
                ))
            {
                //Encoding.GetEncoding("ISO-8859-1"));
                serial.Serialize(stream, source, ns);
                stream.Flush();
                stream.Close();
                doc.Load(file);                
            }
            FileInfo f = new FileInfo(file);
            if (f.Exists) { f.Delete(); }
            return doc;
        }


     


        public static T Deserialize<T>(XmlDocument doc){
            if (string.IsNullOrEmpty(doc.InnerXml)) { 
                return default(T);
            }

            XmlSerializer serial = new XmlSerializer(typeof(T));
            XmlReaderSettings settings = new XmlReaderSettings();
            using (StringReader reader = new StringReader(doc.InnerXml.ToString())) {

                using (XmlReader xmlReader = XmlReader.Create(reader, settings))
                {
                    return (T)serial.Deserialize(xmlReader);
                }
            }

        }

    }
}
