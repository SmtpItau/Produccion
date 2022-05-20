#pragma warning disable 1591
using System;
using System.Text;
using System.Runtime.Serialization.Json;
using System.Web.Script.Serialization;
using System.IO;
using System.Linq;
using System.Xml.Linq;

namespace CoreLib.Helpers
{
    
     public static class JSONHelper
    {
        /// <summary>
        /// Serializa un objeto de tipo T en JSON string
        /// </summary>
        /// <typeparam name="T">Tipo de objeto a convertir</typeparam>
        /// <param name="source">objeto a convertir</param>
        /// <returns>string</returns>
         public static string Serialize<T>(T source) {
             try
             {
                 MemoryStream ms = new MemoryStream();
                 DataContractJsonSerializer ser = new DataContractJsonSerializer(typeof(T));
                 ser.WriteObject(ms, source);
                 byte[] json = ms.ToArray();
                 ms.Close();
                 return Encoding.UTF8.GetString(json, 0, json.Length);
             }
             catch (Exception)
             {                 
                 throw;
             }
         }


         /// <summary>
         /// Deserializa un JSON string en tipo T
         /// </summary>
         /// <typeparam name="T">Tipo de objeto a convertir</typeparam>
         /// <param name="obj">representacion tipo string de objeto a deserializar</param>
         /// <returns>Objeto de tipo &gt;T&lt;</returns>   
         public static T Deserialize<T>(string obj){

             try
             {
                 if (string.IsNullOrEmpty(obj))
                 {
                     return default(T);
                 }

                 MemoryStream ms = new MemoryStream(Encoding.UTF8.GetBytes(obj));
                 DataContractJsonSerializer serial = new DataContractJsonSerializer(typeof(T));
                 T deserialized = (T)serial.ReadObject(ms);
                 ms.Close();
                 return deserialized;
             }
             catch (Exception)
             {                 
                 throw;
             }
         }
         
         /// <summary>
         /// Serializa un objeto de tipo T en JSON string
         /// </summary>
         /// <typeparam name="T">Tipo de objeto a convertir</typeparam>
         /// <param name="source">objeto a convertir</param>
         /// <returns>string</returns>
         public static string JavaScript_Serialize<T>(T source) {
             try
             {
                 JavaScriptSerializer serializer = new JavaScriptSerializer();
                 StringBuilder sb = new StringBuilder();
                 serializer.Serialize(source,sb);
                 return sb.ToString();
             }
             catch (Exception)
             {
                 throw;
             }
         }







         /*
         /// <summary>
         /// Deserializa un JSON string en tipo T
         /// </summary>
         /// <typeparam name="T">Tipo de objeto a convertir</typeparam>
         /// <param name="obj">representacion tipo string de objeto a deserializar</param>
         /// <returns>Objeto de tipo &gt;T&lt;</returns>
         public static T Deserialize<T>(string obj) {
             try
             {
                 if (string.IsNullOrEmpty(obj)) {
                     return default(T);
                 }
                 JavaScriptSerializer serializer = new JavaScriptSerializer();
                 return (T)serializer.Deserialize<T>(obj);
             }
             catch (Exception)
             {                 
                 throw;
             }
         }
         */
    }
}
