using System;
using System.Collections.Generic;
using System.Security.Cryptography;
using CoreLib.Common;
using System.IO;
using System.Linq;
using System.Text;

namespace CoreLib.Helpers
{
    /// <summary>
    /// Struct de Constantes de mensajes para usuario
    /// </summary>
    public struct EncryptMSG
    {
        /// <summary>
        /// Mensaje de cadena vacia o nula.
        /// </summary>
        public const string CRYPTO_NULL_OR_EMPTY_STRING = "La cadena no puede ser nula o vacia";
        /// <summary>
        /// Mensaje de vector de inicializacion nulo o vacio.
        /// </summary>
        public const string CRYPTO_NULL_OR_EMPTY_IV = "El vector de inicializacion no puede ser nulo o vacio";
        /// <summary>
        /// Mensaje de llave nula o vacia.
        /// </summary>
        public const string CRYPTO_NULL_OR_EMPTY_KEY = "La llave para Encriptar/Desencriptar no puede ser nula o vacia";
        /// <summary>
        /// Mensaje que indica que el algoritmo solicitado no esta implementado todavia.
        /// </summary>
        public const string CRYPTO_NOTIMPLEMENTED = "No implementado todavia";
    }




    /// <summary>
    /// Helper de Encriptado
    /// </summary>
    public sealed class CryptoHelper
    {
        /// <summary>
        /// Vector de inicializacion
        /// </summary>
        private byte[] _IV;
       
        /// <summary>
        /// Key autogenerada
        /// </summary>
        private byte[] _Key;
        
        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="algorithm">Algoritmo de encryptacion/desencriptacion a usar.</param>
        public CryptoHelper(CryptographyAlgorithm algorithm) {
            this.Algorithm = algorithm;            
            switch (algorithm)
            {
                case CryptographyAlgorithm.DES:
                    DESCryptoServiceProvider desProvider = new DESCryptoServiceProvider();
                    desProvider.GenerateIV();
                    desProvider.GenerateKey();
                    this._IV = desProvider.IV;
                    this._Key = desProvider.Key;
                    break;
                case CryptographyAlgorithm.TripleDES:
                    TripleDESCryptoServiceProvider TriProvider = new TripleDESCryptoServiceProvider();
                    TriProvider.GenerateIV();
                    TriProvider.GenerateKey();
                    this._IV = TriProvider.IV;
                    this._Key = TriProvider.Key;                    
                    break;
                case CryptographyAlgorithm.Rijndael:
                    RijndaelManaged rm = new RijndaelManaged();
                    rm.GenerateKey();
                    rm.GenerateIV();
                    this._IV = rm.IV;
                    this._Key = rm.Key;
                    break;
            }
        }

        /// <summary>
        /// Default Constructor.
        /// </summary>
        public CryptoHelper() {}

        /// <summary>
        /// Algoritmo Crytpografico a utilizar.
        /// </summary>
        public CryptographyAlgorithm Algorithm { get; set; }
        
        /// <summary>
        /// Vector de Inicializacion.
        /// </summary>
        public byte[] IV {
            get { return _IV; }
            set { _IV = value; }
        }

        /// <summary>
        /// Key for process
        /// </summary>
        public byte[] Key { 
           get{return _Key;}
           set {
               _Key = value;

               //bool result = false;
               // switch (this.Algorithm)
               // {
               //     case CryptographyAlgorithm.DES:
               //         DESCryptoServiceProvider desProvider = new DESCryptoServiceProvider();
               //         result = desProvider.ValidKeySize(value.Length);
               //         break;
               //     case CryptographyAlgorithm.TripleDES:
               //         TripleDESCryptoServiceProvider TriProvider = new TripleDESCryptoServiceProvider();
               //         result = TriProvider.ValidKeySize(value.Length);
               //         break;
               //     case CryptographyAlgorithm.Rijndael:
               //         RijndaelManaged rm = new RijndaelManaged();
               //         result = rm.ValidKeySize(value.Length);
               //         break;
               //     default:
               //         break;
               // }
               // if (result == true)
               // {
               //     _Key = value;
               // }
               // else {
               //     _Key = null;
               // }            
            }                
        }
                
        /// <summary>
        /// Retorna un array de bytes de una cadena dada
        /// </summary>
        /// <param name="str">Cadena</param>
        /// <returns>un array de bytes</returns>
        public static byte[] GetBytes(string str)
        {
            byte[] bytes = new byte[str.Length * sizeof(char)];
            System.Buffer.BlockCopy(str.ToCharArray(), 0, bytes, 0, bytes.Length);
            return bytes;
        }

        /// <summary>
        /// Retorna un literal de un arreglo de bytes.
        /// </summary>
        /// <param name="bytes">Arreglo de bytes.</param>
        /// <returns>string</returns>
        public static string GetString(byte[] bytes)
        {
            char[] chars = new char[bytes.Length / sizeof(char)];
            System.Buffer.BlockCopy(bytes, 0, chars, 0, bytes.Length);
            return new string(chars);
        }

        /// <summary>
        /// Convierte una cadena de texto a conjunto de bytes encriptados segun configuracion de clase.
        /// </summary>
        /// <param name="toEncrypt">Texto a encriptar.</param>
        /// <returns>Byte Array.</returns>
        public byte[] Encrypt(string toEncrypt) {

            if (string.IsNullOrEmpty(toEncrypt))
            {
                throw new ArgumentNullException(EncryptMSG.CRYPTO_NULL_OR_EMPTY_STRING);
            }
            if (this._IV == null)
            {
                throw new ArgumentNullException(EncryptMSG.CRYPTO_NULL_OR_EMPTY_IV);
            }
            if (this._Key == null)
            {
                throw new ArgumentNullException(EncryptMSG.CRYPTO_NULL_OR_EMPTY_KEY);
            }

            switch (this.Algorithm)
            {
                case CryptographyAlgorithm.DES:
                    return DES_Encryption(toEncrypt, this.Key, this.IV);                    
                case CryptographyAlgorithm.TripleDES:
                    break;
                case CryptographyAlgorithm.Rijndael:
                    break;                
            }
            return null;
        }


        /// <summary>
        /// Desencripta un conjunto de bytes.
        /// </summary>
        /// <param name="encrypted">Array de bytes encryptados.</param>
        /// <returns>string desencriptado.</returns>
        public string Decrypt(byte[] encrypted) {

            if (encrypted==null)
            {
                throw new ArgumentNullException(EncryptMSG.CRYPTO_NULL_OR_EMPTY_STRING);
            }
            if (this._IV == null)
            {
                throw new ArgumentNullException(EncryptMSG.CRYPTO_NULL_OR_EMPTY_IV);
            }
            if (this._Key == null)
            {
                throw new ArgumentNullException(EncryptMSG.CRYPTO_NULL_OR_EMPTY_KEY);
            }
            string result = string.Empty;
            switch (this.Algorithm)
            {
                case CryptographyAlgorithm.DES:
                    result =  DES_Decryption(encrypted, this.Key, this.IV);
                    break;
                case CryptographyAlgorithm.TripleDES:
                    break;
                case CryptographyAlgorithm.Rijndael:
                    break;
            }

            return result;
        }
        /// <summary>
        /// Desencritacion de 2 pasos, descifra una cadena en base de 64 bits (previamente encryptada) y luego desencripta según configuracion del Helper.
        /// </summary>
        /// <param name="encryptedBase64">cadena con informacion encriptada en base 64 bits.</param>
        /// <returns></returns>
        public string Decrypt(string encryptedBase64) {
            if (string.IsNullOrEmpty(encryptedBase64))
            {
                throw new ArgumentNullException(EncryptMSG.CRYPTO_NULL_OR_EMPTY_STRING);
            }
            if (this._IV == null)
            {
                throw new ArgumentNullException(EncryptMSG.CRYPTO_NULL_OR_EMPTY_IV);
            }
            if (this._Key == null)
            {
                throw new ArgumentNullException(EncryptMSG.CRYPTO_NULL_OR_EMPTY_KEY);
            }

            string result = string.Empty;
            byte[] data = Convert.FromBase64String(encryptedBase64);

            switch (this.Algorithm)
            {
                case CryptographyAlgorithm.DES:
                    result = DES_Decryption(data, this.Key, this.IV);
                    break;
                case CryptographyAlgorithm.TripleDES:
                    break;
                case CryptographyAlgorithm.Rijndael:
                    break;
            }
            return result;
        }

        #region Implementacion de Algoritmo DES

        /// <summary>
        /// Encriptacion DES
        /// </summary>
        /// <param name="toEncrypt">Texto a encriptar</param>
        /// <param name="Key">LLave</param>
        /// <param name="IV">Vector de inicializacion</param>
        /// <returns>arreglo de bytes encriptado.</returns>
        private byte[] DES_Encryption(string toEncrypt, byte[] Key, byte[] IV)
        {
            UTF8Encoding encoding = new UTF8Encoding();
            byte[] message = encoding.GetBytes(toEncrypt);

            DESCryptoServiceProvider cryptoProvider = new DESCryptoServiceProvider();
            cryptoProvider.Key = Key;
            cryptoProvider.IV = IV;
            ICryptoTransform transform = cryptoProvider.CreateEncryptor();
            MemoryStream memStream = new MemoryStream();
            CryptoStream cryptoStream = new CryptoStream(memStream, transform, CryptoStreamMode.Write);
            cryptoStream.Write(message, 0, message.Length);
            cryptoStream.FlushFinalBlock();
            byte[] encriptado = memStream.ToArray();
            return encriptado;
        }

        /// <summary>
        /// Desencriptacion DES.
        /// </summary>
        /// <param name="encrypted">arreglo de bytes con informacion encriptada</param>
        /// <param name="Key">Llave</param>
        /// <param name="IV">Vector de Inicializacion</param>
        /// <returns>Cadena desencriptada.</returns>
        private string DES_Decryption(byte[] encrypted, byte[] Key, byte[] IV)
        {
            MemoryStream memStream = new MemoryStream(encrypted.Length);
            DESCryptoServiceProvider provider = new DESCryptoServiceProvider();
            CryptoStream cryptoStream = new CryptoStream(memStream, provider.CreateDecryptor(Key, IV), CryptoStreamMode.Read);
            memStream.Write(encrypted, 0,encrypted.Length);
            memStream.Position = 0;
            string decryted = new StreamReader(cryptoStream).ReadToEnd();
            cryptoStream.Close();
            return decryted;
        }
        
        #endregion





/*
        
        #region Boxing CryptoHelper

        /// <summary>
        /// Desencripta un string, segun Algoritmo Criptografico señalado
        /// </summary>
        /// <param name="encrypted">String a descencriptar</param>
        /// <param name="Key">LLave para descencroptacion</param>
        /// <param name="IV">Vector de inicializacion</param>
        /// <param name="crypto">Algoritmo a utilizar en proceso de descencriptacion</param>
        /// <returns>string desencriptado</returns>
        public static string Decrypt(string encrypted, string Key, string IV, CryptographyAlgorithm crypto)
        {

            if (string.IsNullOrEmpty(encrypted))
            {
                throw new ArgumentNullException(EncryptMSG.CRYPTO_NULL_OR_EMPTY_STRING);
            }
            if (string.IsNullOrEmpty(IV))
            {
                throw new ArgumentNullException(EncryptMSG.CRYPTO_NULL_OR_EMPTY_IV);
            }
            if (string.IsNullOrEmpty(Key))
            {
                throw new ArgumentNullException(EncryptMSG.CRYPTO_NULL_OR_EMPTY_KEY);
            }
            string result = string.Empty;
            switch (crypto)
            {
                case CryptographyAlgorithm.DES:
                    result = DES_Decryption(encrypted, Key, IV);
                    break;
                case CryptographyAlgorithm.TripleDES:
                    result = TripleDES_Decryption(encrypted, Key, IV);
                    break;
                case CryptographyAlgorithm.Rijndael:
                    result = Rijndael_Decryption(encrypted, Key);
                    break;
            }

            return result;
        }


        /// <summary>
        /// Encripta un string, segun Algoritmo Criptografico señalado
        /// </summary>
        /// <param name="encryted">String a encriptar</param>
        /// <param name="Key">LLave para encriptacion</param>
        /// <param name="IV">Vector de inicializacion</param>
        /// <param name="crypto">Algoritmo a utilizar en proceso de encriptacion</param>
        /// <returns>string encriptado</returns>
        public static string Encrypt(string toEncrypt, string Key, string IV, CryptographyAlgorithm crypto)
        {

            if (string.IsNullOrEmpty(toEncrypt))
            {
                throw new ArgumentNullException(EncryptMSG.CRYPTO_NULL_OR_EMPTY_STRING);
            }
            if (string.IsNullOrEmpty(IV))
            {
                throw new ArgumentNullException(EncryptMSG.CRYPTO_NULL_OR_EMPTY_IV);
            }
            if (string.IsNullOrEmpty(Key))
            {
                throw new ArgumentNullException(EncryptMSG.CRYPTO_NULL_OR_EMPTY_KEY);
            }

            string result = string.Empty;
            switch (crypto)
            {
                case CryptographyAlgorithm.DES:
                    result = DES_Encryption(toEncrypt, Key, IV);
                    break;
                case CryptographyAlgorithm.TripleDES:
                    result = TripleDES_Encryption(toEncrypt, Key, IV);
                    break;
                case CryptographyAlgorithm.Rijndael:
                    result = Rijndael_Encryption(toEncrypt, Key);
                    break;
            }
            return result;
        }

        
        #endregion
      
*/









        /*
        #region Encriptacion Simetrica.

        #region DES Encryption/Desencryption

        private static string DES_Encryption(string toEncrypt, string Key, string IV) {
            UTF8Encoding encoding = new UTF8Encoding();
            byte[] message = encoding.GetBytes(toEncrypt);
            
            DESCryptoServiceProvider cryptoProvider = new DESCryptoServiceProvider();
            cryptoProvider.GenerateIV();
            cryptoProvider.GenerateKey();
            
            ICryptoTransform transform = cryptoProvider.CreateEncryptor();
            MemoryStream memStream = new MemoryStream();
            CryptoStream cryptoStream = new CryptoStream(memStream, transform, CryptoStreamMode.Write);
            cryptoStream.Write(message, 0, message.Length);
            cryptoStream.FlushFinalBlock();
            byte[] encriptado = memStream.ToArray();
            //string cadena = encoding.GetString(encriptado);
            return Convert.ToBase64String(encriptado);
            //return cadena;
        }

        private static string DES_Decryption(string encrypted, string Key, string IV) {
            byte[] data = System.Convert.FromBase64String(encrypted);
            byte[] bKey = System.Text.ASCIIEncoding.ASCII.GetBytes(Key);
            byte[] bIV = System.Text.ASCIIEncoding.ASCII.GetBytes(IV);

            MemoryStream memStream = new MemoryStream(data.Length);
            DESCryptoServiceProvider provider = new DESCryptoServiceProvider();
            CryptoStream cryptoStream = new CryptoStream(memStream, provider.CreateDecryptor(bKey, bIV), CryptoStreamMode.Read);
            memStream.Write(data, 0, data.Length);
            memStream.Position = 0;

            string decryted = new StreamReader(cryptoStream).ReadToEnd();
            cryptoStream.Close();
            return decryted;
        }


        #endregion

        #region TRIPLEDES

        private static string TripleDES_Encryption(string encrypted, string Key, string IV) { return EncryptMSG.CRYPTO_NOTIMPLEMENTED; }

        private static string TripleDES_Decryption(string encrypted, string Key, string IV) { return EncryptMSG.CRYPTO_NOTIMPLEMENTED; }

        #endregion
        #region Rijndael

        private static string Rijndael_Encryption(string encrypted, string Key) { return EncryptMSG.CRYPTO_NOTIMPLEMENTED; }

        private static string Rijndael_Decryption(string encrypted, string Key) { return EncryptMSG.CRYPTO_NOTIMPLEMENTED; }

        #endregion 
        #endregion
      */    
    }
}
