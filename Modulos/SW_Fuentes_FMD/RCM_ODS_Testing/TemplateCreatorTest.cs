using Microsoft.VisualStudio.TestTools.UnitTesting;
using System;
using System.Xml;
using System.IO;
using System.Data;
using CoreBusinessObjects.DTO;
using CoreBusinessObjects.Common;
using CoreBusinessObjects.Collections;
using CoreLib.Helpers;
using CoreLib.Common;
using System.Linq;
using System.Collections;
using System.Collections.Specialized;
using System.Collections.Generic;

namespace CoreTest
{
    [TestClass]
    public class TemplateCreatorTest
    {
        #region  Compression Test
        [TestMethod()]
        public void Test_Compresion() {
            string dir_base = @"C:\basedirectory\apps\INTERFACES\SFMC\FMD\ODS\OUT\DAILY\";
            string fileToCompress = dir_base +  "Cartera_Vigente_TURING-BAC_20160229.xml";
            string outputFile = @"C:\comprimido.zip";
            //Assert.AreEqual(true, CoreLib.Helpers.ZipHelper.CompressFile(fileToCompress,true));
            //Assert.AreEqual(true, CoreLib.Helpers.ZipHelper.ZipFile(outputFile,fileToCompress));

            Assert.AreEqual(true,CoreLib.Helpers.ZipHelper.ZipFile(fileToCompress,outputFile,System.IO.Packaging.CompressionOption.SuperFast));
            Assert.AreEqual(true, CoreLib.Helpers.ZipHelper.UnZip(outputFile, @"C:\basedirectory\unziptest\"));
        }

        [TestMethod()]
        public void TestCompression2() {
            List<string> files = Directory.GetFiles(@"C:\DAILY", "*.*").ToList<string>();
            string outputFile = @"C:\Varios_comprimido.zip";

            Assert.AreEqual(true, CoreLib.Helpers.ZipHelper.ZipFile(files, outputFile,System.IO.Packaging.CompressionOption.Normal,true));
        }

        [TestMethod()]
        public void TestDecompress() {
            string outputDirectory = @"C:\BaseDirectory\";
            string zipFile  = @"C:\Varios_comprimido.zip";
            Assert.AreEqual(true,CoreLib.Helpers.ZipHelper.UnZip(zipFile,outputDirectory));
        }

        #endregion

        #region EncriptedMailContext

        [TestMethod]
        public void Test_EncriptacionMail()
        {


            string aux = string.Empty;
            byte[] bytes;
            CryptoHelper crypto = new CryptoHelper(CryptographyAlgorithm.DES);
            crypto.IV = System.Text.ASCIIEncoding.ASCII.GetBytes("34343434");
            crypto.Key = System.Text.ASCIIEncoding.ASCII.GetBytes("12121212");

            string pass = "t3stb4c015";
            string otro_pass = "1djohxdntd";
                                   
            bytes = crypto.Encrypt(pass);
            aux = Convert.ToBase64String(bytes);

            bytes = crypto.Encrypt(otro_pass);
            aux = Convert.ToBase64String(bytes);

            
            //var dummy = "";
        }


        [TestMethod]
        public void Test_FT()
        {
            DirectoryInfo d = new DirectoryInfo(@"\\prodapps187\Traspaso\LD6\25041\Fuentes.Net\SGRU");
            string resultFile = @"c:\lista.txt";
            string info = "{0}\t{1}\t{2}";

            var lista = d.EnumerateFiles("*.*", SearchOption.AllDirectories);

            StreamWriter sw = new StreamWriter(resultFile);

            foreach (FileInfo f in lista)
            {
                string result = string.Format(info, f.DirectoryName, f.Name, f.LastWriteTime.ToString("yyyy-MM-dd\tHH:mm"));
                result = result.Replace(@"Y:\", "");
                sw.WriteLine(result);
            }
            sw.Flush();
            sw.Close();
        }

        #endregion

        #region Encriptacion de claves
        [TestMethod]
        public void Test_Encriptacion()
        {
            string line = ("=").PadLeft(100, '=');
            FileInfo f = new FileInfo(@"C:\BaseDirectory\EncryptedText.txt");
            StreamWriter sw = new StreamWriter(f.FullName, false);
            string aux = string.Empty;
            byte[] bytes;
            CryptoHelper crypto = new CryptoHelper(CryptographyAlgorithm.DES);
            sw.WriteLine(line + "\r\n");
            sw.WriteLine("Configuracion Encriptada wsReportes_CM, las cadenas estan encriptadas en base 64\r\n");
            sw.WriteLine(line);

            //Vector de Inicializacion.
            aux = Convert.ToBase64String(crypto.IV);
            sw.WriteLine("<IV>" + aux + "</IV>");
            //Llave de encriptacion.
            aux = Convert.ToBase64String(crypto.Key);
            sw.WriteLine("<Key>" + aux + "</Key>");
                        
            //Conexiones BD
            string conexiones =
@"[{""DBCatalog"":""Reportes"",""DBMaxConnection"":6,""DBMinConnection"":2,""DBPooling"":true,""DBServerName"":""CLSTGBDD999V99"",""DBUserName"":""app_reportes"",""DBUserPass"":""1djohxdntd"",""DB_IP_Address"":null,""IntegratedSecurity"":false,""TrustedConnection"":false,""Use_IP_Address"":false}
,{""DBCatalog"":""Bacfwdsuda"",""DBMaxConnection"":6,""DBMinConnection"":2,""DBPooling"":true,""DBServerName"":""CLSTGBDD999V99"",""DBUserName"":""bacuser"",""DBUserPass"":""t3stb4c015"",""DB_IP_Address"":null,""IntegratedSecurity"":false,""TrustedConnection"":false,""Use_IP_Address"":false}]";
            bytes = crypto.Encrypt(conexiones);
            aux = Convert.ToBase64String(bytes);
            sw.WriteLine("<DBConnections>");
            sw.WriteLine(aux);
            sw.WriteLine("</DBConnections>");

            //Catalogo bd
            bytes = crypto.Encrypt("Reportes");
            aux = Convert.ToBase64String(bytes);
            sw.WriteLine("<DefaultCatalog>" + aux + "</DefaultCatalog>");

            //MailServer
            bytes = crypto.Encrypt("172.20.17.33");
            aux = Convert.ToBase64String(bytes);
            sw.WriteLine("<MailServer>" + aux + "</MailServer>");

            //MailAccount
            bytes = crypto.Encrypt("confirmations@corpbanca.cl");
            aux = Convert.ToBase64String(bytes);
            sw.WriteLine("<MailAccount>" + aux + "</MailAccount>");

            //MailAccountPass
            /*
            bytes = crypto.Encrypt("");
            aux = Convert.ToBase64String(bytes);
            sw.WriteLine("<MailAccountPass>" + aux + "</MailAccountPass>");
            */
            sw.Close();
        }
        #endregion

        #region RCM LD1-RCM-004 V2
        /*
 |ITAU	                        |CORPBANCA
S|FWD / NDF (Fordward NDF)	    |BFW
S|FRA (Fordward Rate Agreement) |SWAP (FRA) //no hay cartera vigente en producción
N|FUTURES	                    |No tenemos.
N|CDS	                        |No tenemos.
S|CCS (Cross Currency Swap)	    |SWAP (DE MONEDA)
S|IRS (Interest Rate Swap)	    |SWAP (DE TASA)
S|OPTIONS	                    |OPCIONES
N|SWAP	                        |SWAP… es redund1ante con los SWAP anteriores.
         */


        [TestMethod]
        public void Test_Template_NDF_V3()
        {
            //FORDWARD --> Ultima version 
            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                DataBindingName = "BFW",
                DBCatalog = "Reportes",
                TemplateName = "Operaciones FWD",
                TemplateDescription = "Contiene las operaciones Fordward NDF registradas el día de reporte, esto es, contratos nuevos, modificados, actualizados (1) y terminados en el día.",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\NDF_TEMPLATE.xml",
                IOFileBaseDirectory = @"\RCM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Backup, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = string.Empty,
                Suffix = "_IBBA_CL_FWD",
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };

            TData.IOFileNamePattern = pattern;
            #region Output

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"NDF-Operação",
                ExcelColumnStart = 1,
                ExcelRowStart = 13,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = true,
                PageSize = 50
            };

            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 1, ColumnName = "A", ValueMember = "Type", ColumnTitle = "Type" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 2, ColumnName = "B", ValueMember = "Contract Update Reason", ColumnTitle = "Contract Update Reason" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = false, ColumnPosition = 3, ColumnName = "C", ValueMember = "Part Account", ColumnTitle = "Part Account" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 4, ColumnName = "D", ValueMember = "Part Position", ColumnTitle = "Part Position" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 5, ColumnName = "E", ValueMember = "Part Code", ColumnTitle = "Part Code" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 6, ColumnName = "F", ValueMember = "Part CPF/CNPJ", ColumnTitle = "Part CPF/CNPJ" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 7, ColumnName = "G", ValueMember = "Part", ColumnTitle = "Part" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = false, ColumnPosition = 8, ColumnName = "H", ValueMember = "Counterpart Indentified", ColumnTitle = "Counterpart Indentified" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 9, ColumnName = "I", ValueMember = "Counterpart Position", ColumnTitle = "Counterpart Position" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 10, ColumnName = "J", ValueMember = "Counterpart Code", ColumnTitle = "Counterpart Code" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 11, ColumnName = "K", ValueMember = "Counterpart CPF/CNPJ", ColumnTitle = "Counterpart CPF/CNPJ" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 12, ColumnName = "L", ValueMember = "Counterpart", ColumnTitle = "Counterpart" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 13, ColumnName = "M", ValueMember = "Derivative Type", ColumnTitle = "Derivative Type" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 14, ColumnName = "N", ValueMember = "Trading Place", ColumnTitle = "Trading Place" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 15, ColumnName = "O", ValueMember = "Contract Number", ColumnTitle = "Contract Number" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 16, ColumnName = "P", ValueMember = "Notional Amount (Part position)", ColumnTitle = "Notional Amount (Part position)" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 17, ColumnName = "Q", ValueMember = "Reference Currency", ColumnTitle = "Reference Currency" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 18, ColumnName = "R", ValueMember = "Settlement Reference Currency", ColumnTitle = "Settlement Reference Currency" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 19, ColumnName = "S", ValueMember = "Underlying asset", ColumnTitle = "Underlying asset" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 20, ColumnName = "T", ValueMember = "Trade Date", ColumnTitle = "Trade Date" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 21, ColumnName = "U", ValueMember = "Effective Date", ColumnTitle = "Effective Date" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 22, ColumnName = "V", ValueMember = "Settlement Date", ColumnTitle = "Settlement Date" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 23, ColumnName = "W", ValueMember = "Buyer Currency", ColumnTitle = "Buyer Currency" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 24, ColumnName = "X", ValueMember = "Seller Currency", ColumnTitle = "Seller Currency" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 25, ColumnName = "Y", ValueMember = "Forward rate", ColumnTitle = "Forward rate" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 26, ColumnName = "Z", ValueMember = "Barrier", ColumnTitle = "Barrier" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 27, ColumnName = "AA", ValueMember = "Fixing Date", ColumnTitle = "Fixing Date" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 28, ColumnName = "AB", ValueMember = "Settlement Rate Type", ColumnTitle = "Settlement Rate Type" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 29, ColumnName = "AC", ValueMember = "Rate Source", ColumnTitle = "Rate Source" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 30, ColumnName = "AD", ValueMember = "Country Origin", ColumnTitle = "Country Origin" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 31, ColumnName = "AE", ValueMember = "Registration", ColumnTitle = "Registration" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 32, ColumnName = "AF", ValueMember = "Derivative Master Agreement", ColumnTitle = "Derivative Master Agreement" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 33, ColumnName = "AG", ValueMember = "Addicional information", ColumnTitle = "Addicional information" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 34, ColumnName = "AH", ValueMember = "DCE Contract", ColumnTitle = "DCE Contract" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 35, ColumnName = "AI", ValueMember = "US Person", ColumnTitle = "US Person" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 36, ColumnName = "AJ", ValueMember = "OTC", ColumnTitle = "OTC" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 37, ColumnName = "AK", ValueMember = "Dealing Activity", ColumnTitle = "Dealing Activity" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 38, ColumnName = "AL", ValueMember = "IntraGroup", ColumnTitle = "IntraGroup" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 39, ColumnName = "AM", ValueMember = "Unwind", ColumnTitle = "Unwind" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = false, ColumnPosition = 40, ColumnName = "AN", ValueMember = "Trade Done In Brazil", ColumnTitle = "Trade Done In Brazil" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Output, SheetName = "NDF-Operação", RowPosition = 13, CauseValidation = true, ColumnPosition = 41, ColumnName = "AO", ValueMember = "USD Notional", ColumnTitle = "USD Notional" });
            TData.ListExcelInfo.Add(xlsx);
            
            #endregion

            #region Input
            
            xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"FWD",
                ExcelColumnStart = 1,
                ExcelRowStart = 13,
                ExcelSheetDirection = DataDirection.Input,
                ExcelSaveAsPrompt = false,
                AllowPaging = true,
                PageSize = 50
            };

            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 1, ColumnName = "A", ValueMember = "Type", ColumnTitle = "Type" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 2, ColumnName = "B", ValueMember = "Contract Update Reason", ColumnTitle = "Contract Update Reason" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = false, ColumnPosition = 3, ColumnName = "C", ValueMember = "Part Account", ColumnTitle = "Part Account" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 4, ColumnName = "D", ValueMember = "Part Position", ColumnTitle = "Part Position" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 5, ColumnName = "E", ValueMember = "Part Code", ColumnTitle = "Part Code" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 6, ColumnName = "F", ValueMember = "Part CPF/CNPJ", ColumnTitle = "Part CPF/CNPJ" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 7, ColumnName = "G", ValueMember = "Part", ColumnTitle = "Part" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = false, ColumnPosition = 8, ColumnName = "H", ValueMember = "Counterpart Indentified", ColumnTitle = "Counterpart Indentified" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 9, ColumnName = "I", ValueMember = "Counterpart Position", ColumnTitle = "Counterpart Position" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 10, ColumnName = "J", ValueMember = "Counterpart Code", ColumnTitle = "Counterpart Code" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 11, ColumnName = "K", ValueMember = "Counterpart CPF/CNPJ", ColumnTitle = "Counterpart CPF/CNPJ" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 12, ColumnName = "L", ValueMember = "Counterpart", ColumnTitle = "Counterpart" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 13, ColumnName = "M", ValueMember = "Derivative Type", ColumnTitle = "Derivative Type" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 14, ColumnName = "N", ValueMember = "Trading Place", ColumnTitle = "Trading Place" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 15, ColumnName = "O", ValueMember = "Contract Number", ColumnTitle = "Contract Number" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 16, ColumnName = "P", ValueMember = "Notional Amount (Part position)", ColumnTitle = "Notional Amount (Part position)" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 17, ColumnName = "Q", ValueMember = "Reference Currency", ColumnTitle = "Reference Currency" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 18, ColumnName = "R", ValueMember = "Settlement Reference Currency", ColumnTitle = "Settlement Reference Currency" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 19, ColumnName = "S", ValueMember = "Underlying asset", ColumnTitle = "Underlying asset" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 20, ColumnName = "T", ValueMember = "Trade Date", ColumnTitle = "Trade Date" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 21, ColumnName = "U", ValueMember = "Effective Date", ColumnTitle = "Effective Date" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 22, ColumnName = "V", ValueMember = "Settlement Date", ColumnTitle = "Settlement Date" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 23, ColumnName = "W", ValueMember = "Buyer Currency", ColumnTitle = "Buyer Currency" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 24, ColumnName = "X", ValueMember = "Seller Currency", ColumnTitle = "Seller Currency" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 25, ColumnName = "Y", ValueMember = "Forward rate", ColumnTitle = "Forward rate" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 26, ColumnName = "Z", ValueMember = "Barrier", ColumnTitle = "Barrier" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 27, ColumnName = "AA", ValueMember = "Fixing Date", ColumnTitle = "Fixing Date" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 28, ColumnName = "AB", ValueMember = "Settlement Rate Type", ColumnTitle = "Settlement Rate Type" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 29, ColumnName = "AC", ValueMember = "Rate Source", ColumnTitle = "Rate Source" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 30, ColumnName = "AD", ValueMember = "Country Origin", ColumnTitle = "Country Origin" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 31, ColumnName = "AE", ValueMember = "Registration", ColumnTitle = "Registration" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 32, ColumnName = "AF", ValueMember = "Derivative Master Agreement", ColumnTitle = "Derivative Master Agreement" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 33, ColumnName = "AG", ValueMember = "Addicional information", ColumnTitle = "Addicional information" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 34, ColumnName = "AH", ValueMember = "DCE Contract", ColumnTitle = "DCE Contract" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 35, ColumnName = "AI", ValueMember = "US Person", ColumnTitle = "US Person" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 36, ColumnName = "AJ", ValueMember = "OTC", ColumnTitle = "OTC" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 37, ColumnName = "AK", ValueMember = "Dealing Activity", ColumnTitle = "Dealing Activity" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 38, ColumnName = "AL", ValueMember = "IntraGroup", ColumnTitle = "IntraGroup" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 39, ColumnName = "AM", ValueMember = "Unwind", ColumnTitle = "Unwind" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = false, ColumnPosition = 40, ColumnName = "AN", ValueMember = "Trade Done In Brazil", ColumnTitle = "Trade Done In Brazil" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, CauseValidation = true, ColumnPosition = 41, ColumnName = "AO", ValueMember = "USD Notional", ColumnTitle = "USD Notional" });
            TData.ListExcelInfo.Add(xlsx);
            #endregion

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"NDF-Operação";
            store.StoreProcName = @"SP_REPORTES_RCM";
            store.Direction = DataDirection.Output;

            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_REPORTES_RCM", ParameterName = "tipo_reporte", DBType = DbType.AnsiString, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "BFW" });
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_REPORTES_RCM", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            //Fordward BFW-NDF
            xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"DCE", //--> debe indicarse DCE para que sea tomada por proceso de match.
                ExcelSheetName = @"FWD",
                ExcelSheetDirection = DataDirection.Input,
                ExcelRowStart = 13,
                ExcelColumnStart = 1,
                ExcelSaveAsPrompt = false
            };
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, ColumnPosition = 0, ColumnName = "M", ValueMember = "Derivative Type", ColumnTitle = "Derivative Type" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, ColumnPosition = 1, ColumnName = "O", ValueMember = "Contract Number", ColumnTitle = "Contract Number" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FWD", RowPosition = 13, ColumnPosition = 2, ColumnName = "AH", ValueMember = "DCE Contract", ColumnTitle = "DCE Contract" });
            TData.ListExcelInfo.Add(xlsx);


            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }       
        [TestMethod()]
        public void Test_DCE_Template_ALL()
        {
            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                DataBindingName = "DCE",
                DBCatalog = "Reportes",
                TemplateName = "DCE Input",
                TemplateDescription = "Contiene los números DCE, asignados por casa matríz para las operaciones de mesa de dinero",
                UseStoreProc = true,
                TemplateDirection = DataDirection.Input,
                IOFileDirection = DataDirection.Input,
                AdditionalInfo = true,
                //IOFileName = @"C:\Working\FUSION_ITAU_CORPBANCA\ExcelInterface\wsReportes_CM\Templates\RCM\FRA_TEMPLATE.xlsx",
                TemplateFileName = @"C:\BaseDirectory\DCE_ALL_TEMPLATE.xml"
            };

            //R_Banco Itaú Chile_04112015 064737
            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "R_Banco Itaú Chile_",
                Suffix = string.Empty,
                Pattern = "ddMMyyyy",
                useDatePattern = true,
                Extension = ".xlsx"
            };

            TData.IOFileNamePattern = pattern;

            //SWAP
            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"SWAP",
                ExcelColumnStart = 2,
                ExcelRowStart = 14,
                ExcelSheetDirection = DataDirection.Input,
                ExcelSaveAsPrompt = false
            };

            xlsx.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Input, SheetName = "SWAP", RowPosition = 14, ColumnPosition = 14, ColumnName = "N", ValueMember = "Derivative Type", ColumnTitle = "Derivative Type" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Input, SheetName = "SWAP", RowPosition = 14, ColumnPosition = 16, ColumnName = "P", ValueMember = "Contract Number", ColumnTitle = "Contract Number" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Input, SheetName = "SWAP", RowPosition = 14, ColumnPosition = 42, ColumnName = "AP", ValueMember = "DCE Contract", ColumnTitle = "DCE Contract" });
            TData.ListExcelInfo.Add(xlsx);

            //FORDWARD BFW -NDF
            xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"NDF",
                ExcelSheetDirection = DataDirection.Input,
                ExcelRowStart = 14,
                ExcelColumnStart = 2,
                ExcelSaveAsPrompt = false
            };


            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "NDF", RowPosition = 14, ColumnPosition = 14, ColumnName = "N", ValueMember = "Derivative Type", ColumnTitle = "Derivative Type" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "NDF", RowPosition = 14, ColumnPosition = 16, ColumnName = "P", ValueMember = "Contract Number", ColumnTitle = "Contract Number" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "NDF", RowPosition = 14, ColumnPosition = 35, ColumnName = "AI", ValueMember = "DCE Contract", ColumnTitle = "DCE Contract" });
            TData.ListExcelInfo.Add(xlsx);

            //Cross Currency SWAP
            xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"CCS",
                ExcelSheetDirection = DataDirection.Input,
                ExcelRowStart = 14,
                ExcelColumnStart = 2,
                ExcelSaveAsPrompt = false
            };

            xlsx.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Input, SheetName = "CCS", RowPosition = 14, ColumnPosition = 14, ColumnName = "N", ValueMember = "Derivative Type", ColumnTitle = "Derivative Type" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Input, SheetName = "CCS", RowPosition = 14, ColumnPosition = 16, ColumnName = "P", ValueMember = "Contract Number", ColumnTitle = "Contract Number" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Input, SheetName = "CCS", RowPosition = 14, ColumnPosition = 42, ColumnName = "AP", ValueMember = "DCE Contract", ColumnTitle = "DCE Contract" });
            TData.ListExcelInfo.Add(xlsx);

            //Forward Rate Agreement
            xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"FRA",
                ExcelSheetDirection = DataDirection.Input,
                ExcelRowStart = 14,
                ExcelColumnStart = 2,
                ExcelSaveAsPrompt = false
            };
            xlsx.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Input, SheetName = "FRA", RowPosition = 14, ColumnPosition = 14, ColumnName = "N", ValueMember = "Derivative Type", ColumnTitle = "Derivative Type" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Input, SheetName = "FRA", RowPosition = 14, ColumnPosition = 16, ColumnName = "P", ValueMember = "Contract Number", ColumnTitle = "Contract Number" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Input, SheetName = "FRA", RowPosition = 14, ColumnPosition = 42, ColumnName = "AP", ValueMember = "DCE Contract", ColumnTitle = "DCE Contract" });
            TData.ListExcelInfo.Add(xlsx);

            //opciones
            xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"OPTIONS",
                ExcelSheetDirection = DataDirection.Input,
                ExcelRowStart = 14,
                ExcelColumnStart = 2,
                ExcelSaveAsPrompt = false
            };

            xlsx.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Input, SheetName = "OPTIONS", RowPosition = 14, ColumnPosition = 14, ColumnName = "N", ValueMember = "Derivative Type", ColumnTitle = "Derivative Type" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Input, SheetName = "OPTIONS", RowPosition = 14, ColumnPosition = 16, ColumnName = "P", ValueMember = "Contract Number", ColumnTitle = "Contract Number" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Input, SheetName = "OPTIONS", RowPosition = 14, ColumnPosition = 42, ColumnName = "AP", ValueMember = "DCE Contract", ColumnTitle = "DCE Contract" });
            TData.ListExcelInfo.Add(xlsx);

            StoreProcsInfo store;
            store = new StoreProcsInfo()
            {
                DBCatalog = "Reportes",
                SheetName = @"SWAP",
                StoreProcName = @"SP_PROCESA_DCE",
                Direction = DataDirection.Input
            };
            TData.ListStoreProcsInfo.Add(store);
            store = new StoreProcsInfo()
            {
                DBCatalog = "Reportes",
                SheetName = @"NDF",
                StoreProcName = @"SP_PROCESA_DCE",
                Direction = DataDirection.Input
            };
            TData.ListStoreProcsInfo.Add(store);
            store = new StoreProcsInfo()
            {
                DBCatalog = "Reportes",
                SheetName = @"CCS",
                StoreProcName = @"SP_PROCESA_DCE",
                Direction = DataDirection.Input
            };
            TData.ListStoreProcsInfo.Add(store);
            store = new StoreProcsInfo()
            {
                DBCatalog = "Reportes",
                SheetName = @"OPTIONS",
                StoreProcName = @"SP_PROCESA_DCE",
                Direction = DataDirection.Input
            };
            TData.ListStoreProcsInfo.Add(store);
            store = new StoreProcsInfo()
            {
                DBCatalog = "Reportes",
                SheetName = @"FRA",
                StoreProcName = @"SP_PROCESA_DCE",
                Direction = DataDirection.Input
            };
            TData.ListStoreProcsInfo.Add(store);

            foreach (StoreProcsInfo sp_info in TData.ListStoreProcsInfo)
            {
                sp_info.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_PROCESA_DCE", ParameterName = "dce_line", DBType = DbType.Int32, SourceColumn = "RowPosition", Direction = ParameterDirection.Input, IsNullable = false });
                sp_info.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_PROCESA_DCE", ParameterName = "Type", DBType = DbType.AnsiString, SourceColumn = "Derivative Type", Direction = ParameterDirection.Input, IsNullable = false });
                sp_info.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_PROCESA_DCE", ParameterName = "Contract", DBType = DbType.Int32, SourceColumn = "Contract Number", Direction = ParameterDirection.Input, IsNullable = false });
                sp_info.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_PROCESA_DCE", ParameterName = "DCE_contract", DBType = DbType.AnsiString, SourceColumn = "DCE Contract", Direction = ParameterDirection.Input, IsNullable = false });
                sp_info.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_PROCESA_DCE", ParameterName = "archivo", DBType = DbType.AnsiString, SourceColumn = "FileName", Direction = ParameterDirection.Input, IsNullable = false });
                sp_info.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_PROCESA_DCE", ParameterName = "fec_archivo", DBType = DbType.DateTime, SourceColumn = "FileTime", Direction = ParameterDirection.Input, IsNullable = false });
                sp_info.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_PROCESA_DCE", ParameterName = "RETURN_VALUE", DBType = DbType.AnsiString, Direction = ParameterDirection.Output, IsNullable = false, Size = 8000 });
            }
            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }
        [TestMethod()]
        public void Test_Template_FRA()
        {
            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                DataBindingName = "FRA",
                DBCatalog = "Reportes",
                TemplateName = "Operaciones FRA",
                TemplateDescription = "Contiene las operaciones Forward Rate Agreement registradas el día de reporte, esto es, contratos nuevos, modificados, actualizados (1) y terminados en el día.",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                IOFileName = @"Template_FRA.xlsx",
                TemplateFileName = @"C:\BaseDirectory\FRA_TEMPLATE.xml",
                IOFileBaseDirectory = @"\RCM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });

            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = string.Empty,
                Suffix = "_IBBA_CL_FRA",
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };

            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"FRA",
                ExcelColumnStart = 1,
                ExcelRowStart = 13,
                ExcelSheetDirection = DataDirection.InputOutput,
                ExcelSaveAsPrompt = false,
                AllowPaging = true,
                PageSize = 50
            };

            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 1, ColumnName = "A", ValueMember = "Type", ColumnTitle = "Type" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 2, ColumnName = "B", ValueMember = "Contract Update Reason", ColumnTitle = "Contract Update Reason" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = false, ColumnPosition = 3, ColumnName = "C", ValueMember = "Part Account", ColumnTitle = "Part Account" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 4, ColumnName = "D", ValueMember = "Part Position", ColumnTitle = "Part Position" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 5, ColumnName = "E", ValueMember = "Part Code", ColumnTitle = "Part Code" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 6, ColumnName = "F", ValueMember = "Part CPF/CNPJ", ColumnTitle = "Part CPF/CNPJ" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 7, ColumnName = "G", ValueMember = "Part", ColumnTitle = "Part" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = false, ColumnPosition = 8, ColumnName = "H", ValueMember = "Counterpart Indentified", ColumnTitle = "Counterpart Indentified" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 9, ColumnName = "I", ValueMember = "Counterpart Position", ColumnTitle = "Counterpart Position" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 10, ColumnName = "J", ValueMember = "Counterpart Code", ColumnTitle = "Counterpart Code" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 11, ColumnName = "K", ValueMember = "Counterpart CPF/CNPJ", ColumnTitle = "Counterpart CPF/CNPJ" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 12, ColumnName = "L", ValueMember = "Counterpart", ColumnTitle = "Counterpart" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 13, ColumnName = "M", ValueMember = "Derivative Type", ColumnTitle = "Derivative Type" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 14, ColumnName = "N", ValueMember = "Trading Place", ColumnTitle = "Trading Place" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 15, ColumnName = "O", ValueMember = "Contract Number", ColumnTitle = "Contract Number" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 16, ColumnName = "P", ValueMember = "Notional Amount", ColumnTitle = "Notional Amount" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 17, ColumnName = "Q", ValueMember = "Reference Currency", ColumnTitle = "Reference Currency" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 18, ColumnName = "R", ValueMember = "Settlement Reference Currency", ColumnTitle = "Settlement Reference Currency" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 19, ColumnName = "S", ValueMember = "Underlying asset", ColumnTitle = "Underlying asset" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 20, ColumnName = "T", ValueMember = "Trade Date", ColumnTitle = "Trade Date" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 21, ColumnName = "U", ValueMember = "Effective Date", ColumnTitle = "Effective Date" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 22, ColumnName = "V", ValueMember = "Settlement Date", ColumnTitle = "Settlement Date" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 23, ColumnName = "W", ValueMember = "Asset Index", ColumnTitle = "Asset Index" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 24, ColumnName = "X", ValueMember = "Asset Rate", ColumnTitle = "Asset Rate" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 25, ColumnName = "Y", ValueMember = "Barrier", ColumnTitle = "Barrier" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 26, ColumnName = "Z", ValueMember = "Rate Source", ColumnTitle = "Rate Source" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 27, ColumnName = "AA", ValueMember = "Fixing Date", ColumnTitle = "Fixing Date" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 28, ColumnName = "AB", ValueMember = "Settlement Rate Type", ColumnTitle = "Settlement Rate Type" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 29, ColumnName = "AC", ValueMember = "Country Origin", ColumnTitle = "Country Origin" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 30, ColumnName = "AD", ValueMember = "Registration", ColumnTitle = "Registration" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 31, ColumnName = "AE", ValueMember = "Derivative Master Agreement", ColumnTitle = "Derivative Master Agreement" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 32, ColumnName = "AF", ValueMember = "Addicional information", ColumnTitle = "Addicional information" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 33, ColumnName = "AG", ValueMember = "DCE Contract", ColumnTitle = "DCE Contract" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 34, ColumnName = "AH", ValueMember = "US Person", ColumnTitle = "US Person" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 35, ColumnName = "AI", ValueMember = "OTC", ColumnTitle = "OTC" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 36, ColumnName = "AJ", ValueMember = "Dealing Activity", ColumnTitle = "Dealing Activity" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 37, ColumnName = "AK", ValueMember = "IntraGroup", ColumnTitle = "IntraGroup" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 38, ColumnName = "AL", ValueMember = "Unwind", ColumnTitle = "Unwind" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = false, ColumnPosition = 39, ColumnName = "AM", ValueMember = "Trade Done In Brazil", ColumnTitle = "Trade Done In Brazil" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "FRA", RowPosition = 13, CauseValidation = true, ColumnPosition = 40, ColumnName = "AN", ValueMember = "USD Notional", ColumnTitle = "USD Notional" });

            TData.ListExcelInfo.Add(xlsx);

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"FRA";
            store.StoreProcName = @"SP_REPORTES_RCM";
            store.Direction = DataDirection.Output;

            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_REPORTES_RCM", ParameterName = "tipo_reporte", DBType = DbType.AnsiString, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "FRA" });
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_REPORTES_RCM", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            //Fordward Rate Agreement
            xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"DCE", //--> debe indicarse DCE para que sea tomada por proceso de match.
                ExcelSheetName = @"FRA",
                ExcelSheetDirection = DataDirection.Input,
                ExcelRowStart = 13,
                ExcelColumnStart = 1,
                ExcelSaveAsPrompt = false
            };

            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FRA", RowPosition = 13, ColumnPosition = 0, ColumnName = "M", ValueMember = "Derivative Type", ColumnTitle = "Derivative Type" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FRA", RowPosition = 13, ColumnPosition = 1, ColumnName = "O", ValueMember = "Contract Number", ColumnTitle = "Contract Number" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "FRA", RowPosition = 13, ColumnPosition = 2, ColumnName = "AG", ValueMember = "DCE Contract", ColumnTitle = "DCE Contract" });

            TData.ListExcelInfo.Add(xlsx);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }
        [TestMethod()]
        public void Test_Template_CCS()
        {
            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                DataBindingName = "CCS",
                DBCatalog = "Reportes",
                TemplateName = "Operaciones CCS",
                TemplateDescription = "Contiene las operaciones Cross Currency Swap registradas el día de reporte, esto es, contratos nuevos, modificados, actualizados (1) y terminados en el día.",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                IOFileName = @"Template_CCS.xlsx",
                TemplateFileName = @"C:\BaseDirectory\CCS_TEMPLATE.xml",
                IOFileBaseDirectory = @"\RCM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });

            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = string.Empty,
                Suffix = "_IBBA_CL_CCS",
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };

            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"CCS",
                ExcelColumnStart = 1,
                ExcelRowStart = 13,
                ExcelSheetDirection = DataDirection.InputOutput,
                ExcelSaveAsPrompt = false,
                AllowPaging = true,
                PageSize = 50
            };


            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 1, ColumnName = "A", ValueMember = "Type", ColumnTitle = "Type" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 2, ColumnName = "B", ValueMember = "Contract Update Reason", ColumnTitle = "Contract Update Reason" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = false, ColumnPosition = 3, ColumnName = "C", ValueMember = "Part Account", ColumnTitle = "Part Account" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 4, ColumnName = "D", ValueMember = "Part Position", ColumnTitle = "Part Position" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 5, ColumnName = "E", ValueMember = "Part Code", ColumnTitle = "Part Code" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 6, ColumnName = "F", ValueMember = "Part CPF/CNPJ", ColumnTitle = "Part CPF/CNPJ" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 7, ColumnName = "G", ValueMember = "Part", ColumnTitle = "Part" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = false, ColumnPosition = 8, ColumnName = "H", ValueMember = "Counterpart Indentified", ColumnTitle = "Counterpart Indentified" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 9, ColumnName = "I", ValueMember = "Counterpart Position", ColumnTitle = "Counterpart Position" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 10, ColumnName = "J", ValueMember = "Counterpart Code", ColumnTitle = "Counterpart Code" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 11, ColumnName = "K", ValueMember = "Counterpart CPF/CNPJ", ColumnTitle = "Counterpart CPF/CNPJ" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 12, ColumnName = "L", ValueMember = "Counterpart", ColumnTitle = "Counterpart" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 13, ColumnName = "M", ValueMember = "Derivative Type", ColumnTitle = "Derivative Type" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 14, ColumnName = "N", ValueMember = "Trading Place", ColumnTitle = "Trading Place" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 15, ColumnName = "O", ValueMember = "Contract Number", ColumnTitle = "Contract Number" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 16, ColumnName = "P", ValueMember = "Notional Amount", ColumnTitle = "Notional Amount" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 17, ColumnName = "Q", ValueMember = "Reference Currency", ColumnTitle = "Reference Currency" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 18, ColumnName = "R", ValueMember = "Settlement Reference Currency", ColumnTitle = "Settlement Reference Currency" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 19, ColumnName = "S", ValueMember = "Underlying asset", ColumnTitle = "Underlying asset" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 20, ColumnName = "T", ValueMember = "Trade Date", ColumnTitle = "Trade Date" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 21, ColumnName = "U", ValueMember = "Effective Date", ColumnTitle = "Effective Date" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 22, ColumnName = "V", ValueMember = "Settlement Date", ColumnTitle = "Settlement Date" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 23, ColumnName = "W", ValueMember = "Asset Index", ColumnTitle = "Asset Index" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 24, ColumnName = "X", ValueMember = "Liability Index", ColumnTitle = "Liability Index" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 25, ColumnName = "Y", ValueMember = "Asset Rate Percent", ColumnTitle = "Asset Rate Percent" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 26, ColumnName = "Z", ValueMember = "Liability Rate Percent", ColumnTitle = "Liability Rate Percent" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 27, ColumnName = "AA", ValueMember = "Asset Notional Amount", ColumnTitle = "Asset Notional Amount" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 28, ColumnName = "AB", ValueMember = "Asset Referency Currency", ColumnTitle = "Asset Referency Currency" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 29, ColumnName = "AC", ValueMember = "Liability Notional Amount", ColumnTitle = "Liability Notional Amount" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 30, ColumnName = "AD", ValueMember = "Liability Referency Currency", ColumnTitle = "Liability Referency Currency" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 31, ColumnName = "AE", ValueMember = "Asset Spread", ColumnTitle = "Asset Spread" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 32, ColumnName = "AF", ValueMember = "Liability Spread", ColumnTitle = "Liability Spread" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 33, ColumnName = "AG", ValueMember = "Cash-Flow", ColumnTitle = "Cash-Flow" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 34, ColumnName = "AH", ValueMember = "Cash Flow Number", ColumnTitle = "Cash Flow Number" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 35, ColumnName = "AI", ValueMember = "Country Origin", ColumnTitle = "Country Origin" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 36, ColumnName = "AJ", ValueMember = "Registration", ColumnTitle = "Registration" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 37, ColumnName = "AK", ValueMember = "Derivative Master Agreement", ColumnTitle = "Derivative Master Agreement" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 38, ColumnName = "AL", ValueMember = "Barrier", ColumnTitle = "Barrier" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 39, ColumnName = "AM", ValueMember = "Settlement Rate Type", ColumnTitle = "Settlement Rate Type" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 40, ColumnName = "AN", ValueMember = "Addicional information", ColumnTitle = "Addicional information" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 41, ColumnName = "AO", ValueMember = "DCE Contract", ColumnTitle = "DCE Contract" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 42, ColumnName = "AP", ValueMember = "US Person", ColumnTitle = "US Person" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 43, ColumnName = "AQ", ValueMember = "OTC", ColumnTitle = "OTC" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 44, ColumnName = "AR", ValueMember = "Dealing Activity", ColumnTitle = "Dealing Activity" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 45, ColumnName = "AS", ValueMember = "IntraGroup", ColumnTitle = "IntraGroup" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 46, ColumnName = "AT", ValueMember = "Unwind", ColumnTitle = "Unwind" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = false, ColumnPosition = 47, ColumnName = "AU", ValueMember = "Trade Done In Brazil", ColumnTitle = "Trade Done In Brazil" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "CCS", RowPosition = 13, CauseValidation = true, ColumnPosition = 48, ColumnName = "AV", ValueMember = "USD Notional", ColumnTitle = "USD Notional" });





            TData.ListExcelInfo.Add(xlsx);

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"CCS";
            store.StoreProcName = @"SP_REPORTES_RCM";
            store.Direction = DataDirection.Output;

            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_REPORTES_RCM", ParameterName = "tipo_reporte", DBType = DbType.AnsiString, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "CCS" });
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_REPORTES_RCM", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);


            //Cross Currency Swap
            xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"DCE", //--> debe indicarse DCE para que sea tomada por proceso de match.
                ExcelSheetName = @"CCS",
                ExcelSheetDirection = DataDirection.Input,
                ExcelRowStart = 13,
                ExcelColumnStart = 1,
                ExcelSaveAsPrompt = false
            };

            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "CCS", RowPosition = 13, ColumnPosition = 0, ColumnName = "M", ValueMember = "Derivative Type", ColumnTitle = "Derivative Type" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "CCS", RowPosition = 13, ColumnPosition = 1, ColumnName = "O", ValueMember = "Contract Number", ColumnTitle = "Contract Number" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.Input, SheetName = "CCS", RowPosition = 13, ColumnPosition = 2, ColumnName = "AO", ValueMember = "DCE Contract", ColumnTitle = "DCE Contract" });

            TData.ListExcelInfo.Add(xlsx);



            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }
        [TestMethod()]
        public void Test_Template_OPTIONS()
        {
            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                DataBindingName = "OPT",
                DBCatalog = "Reportes",
                TemplateName = "Operaciones OPTIONS",
                TemplateDescription = "Contiene las operaciones OPTIONS registradas el día de reporte, esto es, contratos nuevos, modificados, actualizados (1) y terminados en el día.",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                IOFileName = @"Template_OPTIONS.xlsx",
                TemplateFileName = @"C:\BaseDirectory\OPTIONS_TEMPLATE.xml",
                IOFileBaseDirectory = @"\RCM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });

            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = string.Empty,
                Suffix = "_IBBA_CL_OPTIONS",
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };

            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"OPÇÃO",
                ExcelColumnStart = 1,
                ExcelRowStart = 13,
                ExcelSheetDirection = DataDirection.InputOutput,
                ExcelSaveAsPrompt = false,
                AllowPaging = true,
                PageSize = 50
            };

            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 1, ColumnName = "A", ValueMember = "Type", ColumnTitle = "Type" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 2, ColumnName = "B", ValueMember = "Contract Update Reason", ColumnTitle = "Contract Update Reason" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = false, ColumnPosition = 3, ColumnName = "C", ValueMember = "Part Account", ColumnTitle = "Part Account" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 4, ColumnName = "D", ValueMember = "Part Position", ColumnTitle = "Part Position" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 5, ColumnName = "E", ValueMember = "Part Code", ColumnTitle = "Part Code" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 6, ColumnName = "F", ValueMember = "Part CPF/CNPJ", ColumnTitle = "Part CPF/CNPJ" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 7, ColumnName = "G", ValueMember = "Part", ColumnTitle = "Part" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = false, ColumnPosition = 8, ColumnName = "H", ValueMember = "Counterpart Indentified", ColumnTitle = "Counterpart Indentified" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 9, ColumnName = "I", ValueMember = "Counterpart Position", ColumnTitle = "Counterpart Position" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 10, ColumnName = "J", ValueMember = "Counterpart Code", ColumnTitle = "Counterpart Code" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 11, ColumnName = "K", ValueMember = "Counterpart CPF/CNPJ", ColumnTitle = "Counterpart CPF/CNPJ" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 12, ColumnName = "L", ValueMember = "Counterpart", ColumnTitle = "Counterpart" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 13, ColumnName = "M", ValueMember = "Derivative Type", ColumnTitle = "Derivative Type" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 14, ColumnName = "N", ValueMember = "Trading Place", ColumnTitle = "Trading Place" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 15, ColumnName = "O", ValueMember = "Contract Number", ColumnTitle = "Contract Number" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 16, ColumnName = "P", ValueMember = "Currency Option Type", ColumnTitle = "Currency Option Type" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 17, ColumnName = "Q", ValueMember = "Option", ColumnTitle = "Option" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 18, ColumnName = "R", ValueMember = "Asset Option", ColumnTitle = "Asset Option" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 19, ColumnName = "S", ValueMember = "Notional Amount Reference Currency", ColumnTitle = "Notional Amount Reference Currency" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 20, ColumnName = "T", ValueMember = "Notional Amount (Part position)", ColumnTitle = "Notional Amount (Part position)" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 21, ColumnName = "U", ValueMember = "Settlement Reference Currency", ColumnTitle = "Settlement Reference Currency" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 22, ColumnName = "V", ValueMember = "Underlying asset", ColumnTitle = "Underlying asset" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 23, ColumnName = "W", ValueMember = "Trade Date", ColumnTitle = "Trade Date" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 24, ColumnName = "X", ValueMember = "Effective Date", ColumnTitle = "Effective Date" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 25, ColumnName = "Y", ValueMember = "Settlement Date", ColumnTitle = "Settlement Date" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 26, ColumnName = "Z", ValueMember = "Quantity of contracts", ColumnTitle = "Quantity of contracts" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 27, ColumnName = "AA", ValueMember = "Strike Price", ColumnTitle = "Strike Price" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 28, ColumnName = "AB", ValueMember = "Contract reference Month", ColumnTitle = "Contract reference Month" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 29, ColumnName = "AC", ValueMember = "Contract reference Year", ColumnTitle = "Contract reference Year" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 30, ColumnName = "AD", ValueMember = "Barrier", ColumnTitle = "Barrier" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 31, ColumnName = "AE", ValueMember = "Premium Payment Rate", ColumnTitle = "Premium Payment Rate" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 32, ColumnName = "AF", ValueMember = "Premium Amount", ColumnTitle = "Premium Amount" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 33, ColumnName = "AG", ValueMember = "Currency Option Style", ColumnTitle = "Currency Option Style" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 34, ColumnName = "AH", ValueMember = "Rate Source", ColumnTitle = "Rate Source" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 35, ColumnName = "AI", ValueMember = "Fixing Date", ColumnTitle = "Fixing Date" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 36, ColumnName = "AJ", ValueMember = "Settlement Rate Type", ColumnTitle = "Settlement Rate Type" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 37, ColumnName = "AK", ValueMember = "Country Origin", ColumnTitle = "Country Origin" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 38, ColumnName = "AL", ValueMember = "Registration", ColumnTitle = "Registration" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 39, ColumnName = "AM", ValueMember = "Derivative Master Agreement", ColumnTitle = "Derivative Master Agreement" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 40, ColumnName = "AN", ValueMember = "Addicional information", ColumnTitle = "Addicional information" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 41, ColumnName = "AO", ValueMember = "DCE Contract", ColumnTitle = "DCE Contract" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 42, ColumnName = "AP", ValueMember = "US Person", ColumnTitle = "US Person" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 43, ColumnName = "AQ", ValueMember = "OTC", ColumnTitle = "OTC" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 44, ColumnName = "AR", ValueMember = "Dealing Activity", ColumnTitle = "Dealing Activity" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 45, ColumnName = "AS", ValueMember = "IntraGroup", ColumnTitle = "IntraGroup" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 46, ColumnName = "AT", ValueMember = "Unwind", ColumnTitle = "Unwind" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = false, ColumnPosition = 47, ColumnName = "AU", ValueMember = "Trade Done In Brazil", ColumnTitle = "Trade Done In Brazil" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, CauseValidation = true, ColumnPosition = 48, ColumnName = "AV", ValueMember = "USD Notional", ColumnTitle = "USD Notional" });
            TData.ListExcelInfo.Add(xlsx);

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"OPÇÃO";
            store.StoreProcName = @"SP_REPORTES_RCM";
            store.Direction = DataDirection.Output;

            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_REPORTES_RCM", ParameterName = "tipo_reporte", DBType = DbType.AnsiString, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "OPT" });
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_REPORTES_RCM", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);



            //Opciones
            xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"DCE", //--> debe indicarse DCE para que sea tomada por proceso de match.
                ExcelSheetName = @"OPÇÃO",
                ExcelSheetDirection = DataDirection.Input,
                ExcelRowStart = 13,
                ExcelColumnStart = 1,
                ExcelSaveAsPrompt = false
            };
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, ColumnPosition = 0, ColumnName = "M", ValueMember = "Derivative Type", ColumnTitle = "Derivative Type" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, ColumnPosition = 1, ColumnName = "O", ValueMember = "Contract Number", ColumnTitle = "Contract Number" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "OPÇÃO", RowPosition = 13, ColumnPosition = 2, ColumnName = "AO", ValueMember = "DCE Contract", ColumnTitle = "DCE Contract" });
            TData.ListExcelInfo.Add(xlsx);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }
        [TestMethod()]
        public void Test_Template_IRS()
        {

            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                DataBindingName = "IRS",
                DBCatalog = "Reportes",
                TemplateName = "Operaciones SWAP",
                TemplateDescription = "Contiene las operaciones SWAP DE TASA registradas el día de reporte, esto es, contratos nuevos, modificados, actualizados (1) y terminados en el día.",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                IOFileName = @"Template_SWAP.xlsx",
                TemplateFileName = @"C:\BaseDirectory\SWAP_TEMPLATE.xml",
                IOFileBaseDirectory = @"\RCM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = string.Empty,
                Suffix = "_IBBA_CL_SWAP",
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };


            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"SWAP",
                ExcelColumnStart = 1,
                ExcelRowStart = 13,
                ExcelSheetDirection = DataDirection.InputOutput,
                ExcelSaveAsPrompt = false,
                AllowPaging = true,
                PageSize = 50
            };


            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 1, ColumnName = "A", ValueMember = "Type", ColumnTitle = "Type" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 2, ColumnName = "B", ValueMember = "Contract Update Reason", ColumnTitle = "Contract Update Reason" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = false, ColumnPosition = 3, ColumnName = "C", ValueMember = "Part Account", ColumnTitle = "Part Account" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 4, ColumnName = "D", ValueMember = "Part Position", ColumnTitle = "Part Position" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 5, ColumnName = "E", ValueMember = "Part Code", ColumnTitle = "Part Code" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 6, ColumnName = "F", ValueMember = "Part CPF/CNPJ", ColumnTitle = "Part CPF/CNPJ" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 7, ColumnName = "G", ValueMember = "Part", ColumnTitle = "Part" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = false, ColumnPosition = 8, ColumnName = "H", ValueMember = "Counterpart Indentified", ColumnTitle = "Counterpart Indentified" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 9, ColumnName = "I", ValueMember = "Counterpart Position", ColumnTitle = "Counterpart Position" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 10, ColumnName = "J", ValueMember = "Counterpart Code", ColumnTitle = "Counterpart Code" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 11, ColumnName = "K", ValueMember = "Counterpart CPF/CNPJ", ColumnTitle = "Counterpart CPF/CNPJ" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 12, ColumnName = "L", ValueMember = "Counterpart", ColumnTitle = "Counterpart" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 13, ColumnName = "M", ValueMember = "Derivative Type", ColumnTitle = "Derivative Type" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 14, ColumnName = "N", ValueMember = "Trading Place", ColumnTitle = "Trading Place" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 15, ColumnName = "O", ValueMember = "Contract Number", ColumnTitle = "Contract Number" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 16, ColumnName = "P", ValueMember = "Notional Amount", ColumnTitle = "Notional Amount" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 17, ColumnName = "Q", ValueMember = "Reference Currency", ColumnTitle = "Reference Currency" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 18, ColumnName = "R", ValueMember = "Settlement Reference Currency", ColumnTitle = "Settlement Reference Currency" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 19, ColumnName = "S", ValueMember = "Underlying asset", ColumnTitle = "Underlying asset" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 20, ColumnName = "T", ValueMember = "Trade Date", ColumnTitle = "Trade Date" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 21, ColumnName = "U", ValueMember = "Effective Date", ColumnTitle = "Effective Date" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 22, ColumnName = "V", ValueMember = "Settlement Date", ColumnTitle = "Settlement Date" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 23, ColumnName = "W", ValueMember = "Asset Index", ColumnTitle = "Asset Index" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 24, ColumnName = "X", ValueMember = "Liability Index", ColumnTitle = "Liability Index" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 25, ColumnName = "Y", ValueMember = "Asset Rate Percent", ColumnTitle = "Asset Rate Percent" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 26, ColumnName = "Z", ValueMember = "Liability Rate Percent", ColumnTitle = "Liability Rate Percent" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 27, ColumnName = "AA", ValueMember = "Asset Spread", ColumnTitle = "Asset Spread" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 28, ColumnName = "AB", ValueMember = "Liability Spread", ColumnTitle = "Liability Spread" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 29, ColumnName = "AC", ValueMember = "Cash-Flow", ColumnTitle = "Cash-Flow" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 30, ColumnName = "AD", ValueMember = "Cash Flow Number", ColumnTitle = "Cash Flow Number" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 31, ColumnName = "AE", ValueMember = "Premium Amount", ColumnTitle = "Premium Amount" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 32, ColumnName = "AF", ValueMember = "Amortization", ColumnTitle = "Amortization" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 33, ColumnName = "AG", ValueMember = "Barrier", ColumnTitle = "Barrier" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 34, ColumnName = "AH", ValueMember = "Rate Source", ColumnTitle = "Rate Source" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 35, ColumnName = "AI", ValueMember = "Fixing Date", ColumnTitle = "Fixing Date" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 36, ColumnName = "AJ", ValueMember = "Settlement Rate Type", ColumnTitle = "Settlement Rate Type" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 37, ColumnName = "AK", ValueMember = "Country Origin", ColumnTitle = "Country Origin" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 38, ColumnName = "AL", ValueMember = "Registration", ColumnTitle = "Registration" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 39, ColumnName = "AM", ValueMember = "Derivative Master Agreement", ColumnTitle = "Derivative Master Agreement" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 40, ColumnName = "AN", ValueMember = "Addicional information", ColumnTitle = "Addicional information" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 41, ColumnName = "AO", ValueMember = "DCE Contract", ColumnTitle = "DCE Contract" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 42, ColumnName = "AP", ValueMember = "US Person", ColumnTitle = "US Person" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 43, ColumnName = "AQ", ValueMember = "OTC", ColumnTitle = "OTC" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 44, ColumnName = "AR", ValueMember = "Dealing Activity", ColumnTitle = "Dealing Activity" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 45, ColumnName = "AS", ValueMember = "IntraGroup", ColumnTitle = "IntraGroup" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 46, ColumnName = "AT", ValueMember = "Unwind", ColumnTitle = "Unwind" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = false, ColumnPosition = 47, ColumnName = "AU", ValueMember = "Trade Done In Brazil", ColumnTitle = "Trade Done In Brazil" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, CauseValidation = true, ColumnPosition = 48, ColumnName = "AV", ValueMember = "USD Notional", ColumnTitle = "USD Notional" });

            TData.ListExcelInfo.Add(xlsx);

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"SWAP";
            store.StoreProcName = @"SP_REPORTES_RCM";
            store.Direction = DataDirection.Output;

            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_REPORTES_RCM", ParameterName = "tipo_reporte", DBType = DbType.AnsiString, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "IRS" });
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_REPORTES_RCM", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);


            //Opciones
            xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"DCE", //--> debe indicarse DCE para que sea tomada por proceso de match.
                ExcelSheetName = @"SWAP",
                ExcelSheetDirection = DataDirection.Input,
                ExcelRowStart = 13,
                ExcelColumnStart = 1,
                ExcelSaveAsPrompt = false
            };
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, ColumnPosition = 0, ColumnName = "M", ValueMember = "Derivative Type", ColumnTitle = "Derivative Type" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, ColumnPosition = 1, ColumnName = "O", ValueMember = "Contract Number", ColumnTitle = "Contract Number" });
            xlsx.AddressCollection.Add(new TemplateDataAddress() { Direction = DataDirection.InputOutput, SheetName = "SWAP", RowPosition = 13, ColumnPosition = 2, ColumnName = "AO", ValueMember = "DCE Contract", ColumnTitle = "DCE Contract" });
            TData.ListExcelInfo.Add(xlsx);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }
        #endregion

        #region RCM LD1-ODS-006
        /*
        public void Test_Template_ODS_BCC_V2_DEPRECADO()
        {
            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                DataBindingName = "ODS",
                DBCatalog = "Reportes",
                TemplateName = "ODS",
                TemplateDescription = "Contiene las operaciones diarias para interface ODS",
                UseStoreProc = true,
                TemplateDirection = DataDirection.Output,
                IOFileDirection = DataDirection.Output,
                AdditionalInfo = false,
                TemplateFileName = @"C:\BaseDirectory\ODS_PRODUCTOS.xml",
                IOFileBaseDirectory = @"\ODS",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });

            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "Cartera_Vigente_TURING-BAC_",
                Suffix = string.Empty,
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xml"
            };
            TData.IOFileNamePattern = pattern;

            XmlInfo xml = new XmlInfo()
            {
                DBCatalog = "Reportes",
                SaveAsPrompt = false,
                ValueSource = @"Table1",
                XmlDirection = DataDirection.Output,
                XmlNodeName = @"Operacion",
                XmlRootNode = @"Operaciones"
            };
            
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "transaction_deal_num", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_deal_num" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "transaction_status_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_status_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.DateTime, Format = "yyyy-MM-dd T HH:MM:ss", NullValue = "1875-01-01 T 23:59:59", MaxWritableRows = -1, ValueMember = "transaction_trade_date", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_trade_date" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.DateTime, Format = "yyyy-MM-dd T HH:MM:ss", NullValue = "1875-01-01 T 23:59:59", MaxWritableRows = -1, ValueMember = "transaction_start_date", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_start_date" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.DateTime, Format = "yyyy-MM-dd T HH:MM:ss", NullValue = "1875-01-01 T 23:59:59", MaxWritableRows = -1, ValueMember = "transaction_end_date", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_end_date" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.DateTime, Format = "yyyy-MM-dd T HH:MM:ss", NullValue = "1875-01-01 T 23:59:59", MaxWritableRows = -1, ValueMember = "transaction_ET", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_ET" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "transaction_modalidad_pago", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_modalidad_pago" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "transaction_paymentconv_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_paymentconv_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.String, Format = "@", NullValue = "", MaxWritableRows = -1, ValueMember = "transaction_nemo", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_nemo" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.String, Format = "@", NullValue = "", MaxWritableRows = -1, ValueMember = "transaction_serie", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_serie" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "transaction_TIR_compra", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_TIR_compra" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "transaction_TIR_mercado", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_TIR_mercado" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "transaction_strike", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_strike" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "transaction_id_group", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_id_group" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "side_type", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "side_type" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "side_fix_flt", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "side_fix_flt" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.String, Format = "@", NullValue = "", MaxWritableRows = -1, ValueMember = "side_frec_p", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "side_frec_p" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.String, Format = "@", NullValue = "", MaxWritableRows = -1, ValueMember = "side_reset_p", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "side_reset_p" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "side_notional", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "side_notional" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "side_notional_ccy_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "side_notional_ccy_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "side_payment_ccy_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "side_payment_ccy_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "side_rate", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "side_rate" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "side_rate_spread", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "side_rate_spread" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "side_rate_type_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "side_rate_type_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "side_projection_index", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "side_projection_index" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "side_yield_basis_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "side_yield_basis_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "interest_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "interest_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.DateTime, Format = "yyyy-MM-dd T HH:MM:ss", NullValue = "1875-01-01 T 23:59:59", MaxWritableRows = -1, ValueMember = "interest_start_date", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "interest_start_date" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.DateTime, Format = "yyyy-MM-dd T HH:MM:ss", NullValue = "1875-01-01 T 23:59:59", MaxWritableRows = -1, ValueMember = "interest_end_date", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "interest_end_date" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.DateTime, Format = "yyyy-MM-dd T HH:MM:ss", NullValue = "1875-01-01 T 23:59:59", MaxWritableRows = -1, ValueMember = "interest_payment_date", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "interest_payment_date" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.DateTime, Format = "yyyy-MM-dd T HH:MM:ss", NullValue = "1875-01-01 T 23:59:59", MaxWritableRows = -1, ValueMember = "interest_fixing_date", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "interest_fixing_date" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "interest_fixing_rate", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "interest_fixing_rate" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.DateTime, Format = "yyyy-MM-dd T HH:MM:ss", NullValue = "1875-01-01 T 23:59:59", MaxWritableRows = -1, ValueMember = "interest_accounting_date", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "interest_accounting_date" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "interest_rate", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "interest_rate" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "interest_payment", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "interest_payment" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "interest_df", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "interest_df" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "interest_npv", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "interest_npv" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "cashflow_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "cashflow_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "cashflowtype_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "cashflowtype_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.DateTime, Format = "yyyy-MM-dd T HH:MM:ss", NullValue = "1875-01-01 T 23:59:59", MaxWritableRows = -1, ValueMember = "cashflow_start_date", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "cashflow_start_date" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.DateTime, Format = "yyyy-MM-dd T HH:MM:ss", NullValue = "1875-01-01 T 23:59:59", MaxWritableRows = -1, ValueMember = "cashflow_end_date", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "cashflow_end_date" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.DateTime, Format = "yyyy-MM-dd T HH:MM:ss", NullValue = "1875-01-01 T 23:59:59", MaxWritableRows = -1, ValueMember = "cashflow_accounting_date", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "cashflow_accounting_date" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.DateTime, Format = "yyyy-MM-dd T HH:MM:ss", NullValue = "1875-01-01 T 23:59:59", MaxWritableRows = -1, ValueMember = "cashflow_fixing_date", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "cashflow_fixing_date" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "cashflow_fixing_rate", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "cashflow_fixing_rate" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "cashflow_amount", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "cashflow_amount" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "cashflow_df", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "cashflow_df" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "cashflow_npv", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "cashflow_npv" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "facility_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "facility_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "transaction_info_tc_costo", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_tc_costo" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "transaction_info_tc_cliente", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_tc_cliente" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "transaction_info_paridad_costo", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_paridad_costo" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "transaction_info_paridad_cliente", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_paridad_cliente" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "transaction_info_spread_tc", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_spread_tc" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "transaction_info_spread_paridad", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_spread_paridad" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "transaction_info_fx_spot_cliente", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_fx_spot_cliente" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "transaction_info_fx_fwd_costo", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_fx_fwd_costo" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "transaction_info_fx_fwd_cliente", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_fx_fwd_cliente" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "transaction_info_puntos_fwd", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_puntos_fwd" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "transaction_info_fx_uf_spot", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_fx_uf_spot" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "transaction_info_fx_uf_tasa_costo", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_fx_uf_tasa_costo" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "transaction_info_fx_uf_tasa_margen", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_fx_uf_tasa_margen" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "transaction_info_fx_uf_tasa_cliente", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_fx_uf_tasa_cliente" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "transaction_info_fx_spot_margen", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_fx_spot_margen" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "transaction_info_fx_fwd_margen", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_fx_fwd_margen" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "transaction_info_fx_uf_tasa_sucia_costo", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_fx_uf_tasa_sucia_costo" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "transaction_info_fx_uf_tasa_sucia_cliente", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_fx_uf_tasa_sucia_cliente" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "equivalente_credito_corporativo", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "equivalente_credito_corporativo" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "equivalente_credito_normativo", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "equivalente_credito_normativo" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "equivalente_credito_factor", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "equivalente_credito_factor" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "equivalente_credito_factor_inter", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "equivalente_credito_factor_inter" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "equivalente_credito_factor_normativo", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "equivalente_credito_factor_normativo" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "medio_transaccional_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "medio_transaccional_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "canal_transaccional_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "canal_transaccional_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "profit_value", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "profit_value" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "profit_ccy_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "profit_ccy_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "profit_mesa_clientes_clp", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "profit_mesa_clientes_clp" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "profit_mesa_trading_clp", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "profit_mesa_trading_clp" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "portfolio_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "portfolio_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "instrument_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "instrument_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "product_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "product_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "party_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "party_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.String, Format = "@", NullValue = "", MaxWritableRows = -1, ValueMember = "party_rut", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "party_rut" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "party_secuencia", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "party_secuencia" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "pricing_mtm", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "pricing_mtm" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "pricing_mtm_ccy_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "pricing_mtm_ccy_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "pricing_base_mtm", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "pricing_base_mtm" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "pricing_pnl", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "pricing_pnl" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "pricing_pnl_fx_unrealized", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "pricing_pnl_fx_unrealized" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "pricing_delta", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "pricing_delta" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "pricing_gamma", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "pricing_gamma" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "pricing_vega", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "pricing_vega" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "pricing_beta", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "pricing_beta" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "pricing_rho_local", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "pricing_rho_local" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "pricing_rho_foranea", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "pricing_rho_foranea" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "pricing_theta", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "pricing_theta" });
            xml.AddressCollection.Add(new TemplateDataAddress() { DataType = DataType.Double, Format = "G29", NullValue = "0", MaxWritableRows = -1, ValueMember = "pricing_volga", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "pricing_volga" });




            TData.ListXmlInfo.Add(xml);

            //los store procs sin parametros deben venir con parametro return value
            StoreProcsInfo store = new StoreProcsInfo();
            store.StoreProcName = @"SP_FUSION_REPORTE_ODS";
            store.DBCatalog = @"Reportes";
            store.Direction = DataDirection.Output;
            store.ConnectionTimeout = 120;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_FUSION_REPORTE_ODS", ParameterName = "RETURN_VALUE", DBType = DbType.Object, Direction = ParameterDirection.ReturnValue });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }
        */
        [TestMethod()]
        public void Test_Template_ODS_BCC()
        {
            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                DataBindingName = "ODS",
                DBCatalog = "Reportes",
                TemplateName = "ODS",
                TemplateDescription = "Contiene las operaciones diarias para interface ODS",
                UseStoreProc = true,
                TemplateDirection = DataDirection.Output,
                IOFileDirection = DataDirection.Output,
                AdditionalInfo = false,
                TemplateFileName = @"C:\BaseDirectory\ODS_PRODUCTOS.xml",
                IOFileBaseDirectory = @"\ODS",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST", CompressedFiles = true});
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });

            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "Cartera_Vigente_TURING-BAC_",
                Suffix = string.Empty,
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xml"
            };
            TData.IOFileNamePattern = pattern;

            XmlInfo xml = new XmlInfo()
            {
                DBCatalog = "Reportes",
                SaveAsPrompt = false,
                ValueSource = @"Table1",
                XmlDirection = DataDirection.Output,
                XmlNodeName = @"Operacion",
                XmlRootNode = @"Operaciones"
            };

            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_deal_num", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_deal_num" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_status_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_status_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_trade_date", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_trade_date" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_start_date", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_start_date" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_end_date", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_end_date" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_ET", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_ET" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_modalidad_pago", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_modalidad_pago" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_paymentconv_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_paymentconv_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_nemo", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_nemo" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_serie", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_serie" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_TIR_compra", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_TIR_compra" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_TIR_mercado", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_TIR_mercado" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_strike", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_strike" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_id_group", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_id_group" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "side_type", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "side_type" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "side_fix_flt", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "side_fix_flt" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "side_frec_p", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "side_frec_p" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "side_reset_p", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "side_reset_p" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "side_notional", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "side_notional" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "side_notional_ccy_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "side_notional_ccy_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "side_payment_ccy_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "side_payment_ccy_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "side_rate", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "side_rate" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "side_rate_spread", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "side_rate_spread" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "side_rate_type_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "side_rate_type_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "side_projection_index", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "side_projection_index" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "side_yield_basis_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "side_yield_basis_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "interest_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "interest_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "interest_start_date", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "interest_start_date" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "interest_end_date", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "interest_end_date" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "interest_payment_date", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "interest_payment_date" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "interest_fixing_date", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "interest_fixing_date" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "interest_fixing_rate", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "interest_fixing_rate" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "interest_accounting_date", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "interest_accounting_date" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "interest_rate", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "interest_rate" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "interest_payment", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "interest_payment" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "interest_df", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "interest_df" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "interest_npv", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "interest_npv" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "cashflow_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "cashflow_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "cashflowtype_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "cashflowtype_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "cashflow_start_date", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "cashflow_start_date" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "cashflow_end_date", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "cashflow_end_date" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "cashflow_accounting_date", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "cashflow_accounting_date" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "cashflow_fixing_date", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "cashflow_fixing_date" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "cashflow_fixing_rate", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "cashflow_fixing_rate" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "cashflow_amount", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "cashflow_amount" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "cashflow_df", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "cashflow_df" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "cashflow_npv", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "cashflow_npv" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "facility_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "facility_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_info_tc_costo", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_tc_costo" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_info_tc_cliente", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_tc_cliente" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_info_paridad_costo", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_paridad_costo" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_info_paridad_cliente", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_paridad_cliente" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_info_spread_tc", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_spread_tc" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_info_spread_paridad", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_spread_paridad" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_info_fx_spot_cliente", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_fx_spot_cliente" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_info_fx_fwd_costo", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_fx_fwd_costo" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_info_fx_fwd_cliente", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_fx_fwd_cliente" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_info_puntos_fwd", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_puntos_fwd" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_info_fx_uf_spot", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_fx_uf_spot" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_info_fx_uf_tasa_costo", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_fx_uf_tasa_costo" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_info_fx_uf_tasa_margen", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_fx_uf_tasa_margen" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_info_fx_uf_tasa_cliente", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_fx_uf_tasa_cliente" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_info_fx_spot_margen", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_fx_spot_margen" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_info_fx_fwd_margen", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_fx_fwd_margen" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_info_fx_uf_tasa_sucia_costo", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_fx_uf_tasa_sucia_costo" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "transaction_info_fx_uf_tasa_sucia_cliente", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "transaction_info_fx_uf_tasa_sucia_cliente" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "equivalente_credito_corporativo", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "equivalente_credito_corporativo" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "equivalente_credito_normativo", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "equivalente_credito_normativo" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "equivalente_credito_factor", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "equivalente_credito_factor" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "equivalente_credito_factor_inter", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "equivalente_credito_factor_inter" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "equivalente_credito_factor_normativo", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "equivalente_credito_factor_normativo" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "medio_transaccional_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "medio_transaccional_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "canal_transaccional_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "canal_transaccional_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "profit_value", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "profit_value" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "profit_ccy_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "profit_ccy_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "profit_mesa_clientes_clp", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "profit_mesa_clientes_clp" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "profit_mesa_trading_clp", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "profit_mesa_trading_clp" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "portfolio_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "portfolio_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "instrument_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "instrument_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "product_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "product_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "party_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "party_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "party_rut", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "party_rut" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "party_secuencia", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "party_secuencia" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "pricing_mtm", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "pricing_mtm" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "pricing_mtm_ccy_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "pricing_mtm_ccy_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "pricing_base_mtm", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "pricing_base_mtm" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "pricing_pnl", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "pricing_pnl" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "pricing_pnl_fx_unrealized", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "pricing_pnl_fx_unrealized" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "pricing_delta", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "pricing_delta" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "pricing_gamma", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "pricing_gamma" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "pricing_vega", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "pricing_vega" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "pricing_beta", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "pricing_beta" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "pricing_rho_local", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "pricing_rho_local" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "pricing_rho_foranea", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "pricing_rho_foranea" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "pricing_theta", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "pricing_theta" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "pricing_volga", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "pricing_volga" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "side_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "side_id" });
            xml.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, ValueMember = "call_put_id", RenderAsAttribute = true, Direction = DataDirection.Output, ColumnName = "call_put_id" });
            
            TData.ListXmlInfo.Add(xml);

            //los store procs sin parametros deben venir con parametro return value
            StoreProcsInfo store = new StoreProcsInfo();
            store.StoreProcName = @"SP_FUSION_REPORTE_ODS";
            store.DBCatalog = @"Reportes";
            store.Direction = DataDirection.Output;
            store.ConnectionTimeout = 120;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_FUSION_REPORTE_ODS", ParameterName = "RETURN_VALUE", DBType = DbType.Object, Direction = ParameterDirection.ReturnValue });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }

        #endregion

        #region RCM LD1 ADM Regulatorio 1

        
        [TestMethod()]
        public void SP_FUSION_CONTABILIDAD_SPOT()
        {
        
            //SPOT
            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                //DataBindingName = "SPOT",
                DataBindingName = "ADM1",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. Contabilidad Regulatoria SPOT",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_TEMPLATE_SPOT.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "TR-CA0411",
                Suffix = string.Empty,
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };

            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"SPOT",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"SPOT";
            store.StoreProcName = @"SP_FUSION_CONTABILIDAD_SPOT";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_FUSION_CONTABILIDAD_SPOT", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);

        }
    
        /*
        [TestMethod()]
        public void Test_Regulatorio1_FORWARD()
        {
            //Forward
            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                DataBindingName = "BFW",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. Contabilidad Regulatoria Forward",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_TEMPLATE_FORWARD.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "TR-",
                Suffix = "_CASA_MATRIZ_FWA_ARB_EF",
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };

            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"FORWARD",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"FORWARD";
            store.StoreProcName = @"SP_FUSION_CONTABILIDAD_FORWARD";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_FUSION_CONTABILIDAD_SPOT", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);

        }
    */
    
        #region RPT CHILE
        [TestMethod()]
        public void SP_ADM_REPORTE_CARTERA_VIGENTE()
        {
            //Forward
            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                //DataBindingName = "PCS",
                DataBindingName = "ADM2",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. CARTERA VIGENTE",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_REPORTE_CARTERA_VIGENTE.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "Reporte_Cartera_Vigente_",
                Suffix = " - Turing",
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };

            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"CARTERA_VIGENTE_TURING",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"CARTERA_VIGENTE_TURING";
            store.StoreProcName = @"SP_ADM_REPORTE_CARTERA_VIGENTE";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_ADM_REPORTE_CARTERA_VIGENTE", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);

        }
        [TestMethod()]
        public void SP_ADM_REPORTE_BASILEA_DERIVADOS()
        {
            //Forward
            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                //DataBindingName = "PCS",
                DataBindingName = "ADM3",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. BASILEA DERIVADOS",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_REPORTE_BASILEA_DERIVADOS.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "RPT_BasileaDerivados_",
                Suffix = " - Turing",
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };

            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"BASILEA_DERIVADOS",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"BASILEA_DERIVADOS";
            store.StoreProcName = @"SP_ADM_REPORTE_BASILEA_DERIVADOS";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_ADM_REPORTE_BASILEA_DERIVADOS", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);

        }
        [TestMethod()]
        public void SP_ADM_REPORTE_BASILEA_SWAP()
        {
            //Forward
            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                //DataBindingName = "PCS",
                DataBindingName = "ADM4",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. BASILEA SWAP",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_REPORTE_BASILEA_SWAP.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "RPT_BasileaSwap_",
                Suffix = " - Turing",
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };

            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"BASILEA_SWAP",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"BASILEA_SWAP";
            store.StoreProcName = @"SP_ADM_REPORTE_BASILEA_SWAP";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_ADM_REPORTE_BASILEA_SWAP", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);

        }
        [TestMethod()]
        public void SP_ADM_REPORTE_ITAU_SWAP_DIGITAL()
        {
            //Forward
            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                //DataBindingName = "PCS",
                DataBindingName = "ADM5",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. ITAU SWAP DIGITAL",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_REPORTE_ITAU_SWAP_DIGITAL.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "RPT_Itau_SwapDigital_",
                Suffix = " - Turing",
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };

            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"ITAU_SWAP_DIG",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"ITAU_SWAP_DIG";
            store.StoreProcName = @"SP_ADM_REPORTE_ITAU_SWAP_DIGITAL";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_ADM_REPORTE_ITAU_SWAP_DIGITAL", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }
        #endregion
        #region RPT NY
        [TestMethod()]
        public void SP_ADM_REPORTE_CARTERA_VIGENTE_NY()
        {
            //Forward
            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                //DataBindingName = "PCS",
                DataBindingName = "ADM6",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. CARTERA VIGENTE NY",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_REPORTE_CARTERA_VIGENTE_NY.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "Reporte_Cartera_Vigente_",
                Suffix = " - Turing NY",
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };

            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"CARTERA_VIGENTE_TURING_NY",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"CARTERA_VIGENTE_TURING_NY";
            store.StoreProcName = @"SP_ADM_REPORTE_CARTERA_VIGENTE_NY";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_ADM_REPORTE_CARTERA_VIGENTE_NY", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);

        }
        [TestMethod()]
        public void SP_ADM_REPORTE_BASILEA_DERIVADOS_NY()
        {
            //Forward
            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                //DataBindingName = "PCS",
                DataBindingName = "ADM7",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. BASILEA DERIVADOS NY",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_REPORTE_BASILEA_DERIVADOS_NY.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "RPT_BasileaDerivados_",
                Suffix = " - Turing NY",
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };

            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"BASILEA_DERIVADOS_NY",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"BASILEA_DERIVADOS_NY";
            store.StoreProcName = @"SP_ADM_REPORTE_BASILEA_DERIVADOS_NY";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_ADM_REPORTE_BASILEA_DERIVADOS_NY", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);

        }
        [TestMethod()]
        public void SP_ADM_REPORTE_BASILEA_SWAP_NY()
        {
            //Forward
            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                //DataBindingName = "PCS",
                DataBindingName = "ADM8",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. BASILEA SWAP NY",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_REPORTE_BASILEA_SWAP_NY.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "RPT_BasileaSwap_",
                Suffix = " - Turing NY",
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };

            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"BASILEA_SWAP_NY",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"BASILEA_SWAP_NY";
            store.StoreProcName = @"SP_ADM_REPORTE_BASILEA_SWAP_NY";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_ADM_REPORTE_BASILEA_SWAP_NY", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);

        }
        [TestMethod()]
        public void SP_ADM_REPORTE_ITAU_SWAP_DIGITAL_NY()
        {

            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                //DataBindingName = "PCS",
                DataBindingName = "ADM9",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. ITAU SWAP DIGITAL NY",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_REPORTE_ITAU_SWAP_DIGITAL_NY.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "RPT_Itau_SwapDigital_",
                Suffix = " - Turing NY",
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };

            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"ITAU_SWAP_DIG_NY",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"ITAU_SWAP_DIG_NY";
            store.StoreProcName = @"SP_ADM_REPORTE_ITAU_SWAP_DIGITAL_NY";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_ADM_REPORTE_ITAU_SWAP_DIGITAL_NY", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }
        #endregion

        [TestMethod()]
        public void SP_ADM_REPORTE_CARTERA_VIGENTE_FWD()
        {
            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                //DataBindingName = "BFW",
                DataBindingName = "ADM10",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. CARTERA VIGENTE FWD",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_REPORTE_CARTERA_VIGENTE_FWD.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "RPT_Cartera_Vigente_Forward_",
                Suffix = string.Empty,
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };

            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"CART_VIG_FWD",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"CART_VIG_FWD";
            store.StoreProcName = @"SP_ADM_REPORTE_CARTERA_VIGENTE_FWD";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_ADM_REPORTE_CARTERA_VIGENTE_FWD", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }
        [TestMethod()]
        public void SP_ADM_REPORTE_CVF_FORWARD()
        {
            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                //DataBindingName = "BFW",
                DataBindingName = "ADM11",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. CVF FORWARD",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_REPORTE_CVF_FORWARD.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "RPT_CVF_",
                Suffix = string.Empty,
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };

            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"CVF_FORWARD",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"CVF_FORWARD";
            store.StoreProcName = @"SP_ADM_REPORTE_CVF_FORWARD";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_ADM_REPORTE_CVF_FORWARD", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }
        [TestMethod()]
        public void SP_ADM_REPORTE_CARTERA_VIGENTE_FWD_COMDER()
        {
            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                //DataBindingName = "BFW",
                DataBindingName = "ADM12",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. CARTERA VIGENTE FWD COMDER",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_REPORTE_CARTERA_VIGENTE_FWD_COMDER.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "RPT_Cartera_Vigente_Forward_COMDER_",
                Suffix = string.Empty,
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };

            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"FWD COMDER",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"FWD COMDER";
            store.StoreProcName = @"SP_ADM_REPORTE_CARTERA_VIGENTE_FWD_COMDER";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_ADM_REPORTE_CARTERA_VIGENTE_FWD_COMDER", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }
        [TestMethod()]
        public void SP_ADM_REPORTE_CASA_MATRIZ_OTROS_DER_FWD()
        {
            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                //DataBindingName = "BFW",
                DataBindingName = "ADM13",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. CASA MATRIZ OTROS DERIVADOS FWD",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_REPORTE_CASA_MATRIZ_OTROS_DER_FWD.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "RPT_Casa_Matriz_Otros_Derivados_Forward_",
                Suffix = string.Empty,
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };

            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"OTROS_DEV_FWD",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"OTROS_DEV_FWD";
            store.StoreProcName = @"SP_ADM_REPORTE_CASA_MATRIZ_OTROS_DER_FWD";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_ADM_REPORTE_CASA_MATRIZ_OTROS_DER_FWD", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }
        [TestMethod()]
        public void SP_ADM_REPORTE_ITAU_OTROS_DER_DIGITAL()
        {
            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                //DataBindingName = "BFW",
                DataBindingName = "ADM14",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. Itau Otros Derivados Digitales",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_REPORTE_ITAU_OTROS_DER_DIGITAL.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "RPT_Itau_OtrosDerDigital_",
                Suffix = string.Empty,
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };

            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"ITAU_OTROS_DER_DIG",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"ITAU_OTROS_DER_DIG";
            store.StoreProcName = @"SP_ADM_REPORTE_ITAU_OTROS_DER_DIGITAL";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_ADM_REPORTE_ITAU_OTROS_DER_DIGITAL", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }
        [TestMethod()]
        public void SP_ADM_REPORTE_CARTERA_FWD_ARB()
        {
            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                //DataBindingName = "BFW",
                DataBindingName = "ADM15",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. CARTERA FWD ARB",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_REPORTE_CARTERA_FWD_ARB.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "Casa_Matriz_FWD_ARB_EF",
                Suffix = string.Empty,
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };

            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"CM_FWD_ARB",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"CM_FWD_ARB";
            store.StoreProcName = @"SP_ADM_REPORTE_CARTERA_FWD_ARB";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_ADM_REPORTE_CARTERA_FWD_ARB", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }
       
     

        #region OPCIONES

        /*OPCIONES*/
        [TestMethod()]
        public void SP_ADM_REPORTE_CARTERA_VIGENTE_OPC()
        {

            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                //DataBindingName = "OPT",
                DataBindingName = "ADM17",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. Opciones Cartera Vigente",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_REPORTE_CARTERA_VIGENTE_OPC.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "RPT_Cartera_Vigente_Opciones_",
                Suffix = string.Empty,
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };

            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"OPT",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"OPT";
            store.StoreProcName = @"SP_ADM_REPORTE_CARTERA_VIGENTE_OPC";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_ADM_REPORTE_CARTERA_VIGENTE_OPC", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);

        }
        [TestMethod()]
        public void SP_ADM_REPORTE_CVF_OPC()
        {

            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                //DataBindingName = "OPT",
                DataBindingName = "ADM18",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. Opciones",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_REPORTE_CVF_OPC.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "RPT_Cartera_Vigente_Opciones_",
                Suffix = " CVF",
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };

            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"OPCIONES",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"OPCIONES";
            store.StoreProcName = @"SP_ADM_REPORTE_CVF_OPC";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_ADM_REPORTE_CVF_OPC", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);

        }
        [TestMethod()]
        public void SP_ADM_REPORTE_ITAU_OTROS_DER_DIGITAL_OPC()
        {

            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                //DataBindingName = "OPT",
                DataBindingName = "ADM19",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. Pasivos y Obligaciones",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_REPORTE_ITAU_OTROS_DER_DIGITAL_OPC.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "RPT_Itau_OtrosDerDigital_",
                Suffix = "_Opciones",
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };

            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"OTROS",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"OTROS";
            store.StoreProcName = @"SP_ADM_REPORTE_ITAU_OTROS_DER_DIGITAL_OPC";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_ADM_REPORTE_ITAU_OTROS_DER_DIGITAL_OPC", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);

        }
        [TestMethod()]
        public void SP_ADM_REPORTE_CASA_MATRIZ_OTROS_DER_OPC()
        {

            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                //DataBindingName = "OPT",
                DataBindingName = "ADM20",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. Pasivos y Obligaciones",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_REPORTE_CASA_MATRIZ_OTROS_DER_OPC.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "RPT_Casa_Matriz_Otros_Derivados_Opciones",
                Suffix = string.Empty,
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };



            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"RCM",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"RCM";
            store.StoreProcName = @"SP_ADM_REPORTE_CASA_MATRIZ_OTROS_DER_OPC";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_ADM_REPORTE_CASA_MATRIZ_OTROS_DER_OPC", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);

        }
        
        #endregion

        #region Pasivos y obligaciones
        [TestMethod()]
        public void SP_ADM_REPORTE_PASIVOS_OBLIGACIONES()
        {

            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                //DataBindingName = "BFW",
                DataBindingName = "ADM16",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. Pasivos y Obligaciones",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_REPORTE_PASIVOS_OBLIGACIONES.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "6_Obligaciones_",
                Suffix = string.Empty,
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };

            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"PASIVOS",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"PASIVOS";
            store.StoreProcName = @"SP_ADM_REPORTE_PASIVOS_OBLIGACIONES";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_ADM_REPORTE_PASIVOS_OBLIGACIONES", ParameterName = "dfecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);

        }
        
        [TestMethod()]
        public void SP_ADM_REPORTE_PASIVOS_PAGOS()
        {

            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                //DataBindingName = "OPT",
                DataBindingName = "ADM21",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. Pasivos Pagos",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_REPORTE_PASIVOS_PAGOS.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "BACEN_PAGOS_DIARIOS_",
                Suffix = string.Empty,
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };



            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"PVO_PAGOS",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"PVO_PAGOS";
            store.StoreProcName = @"SP_ADM_REPORTE_PASIVOS_PAGOS";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_ADM_REPORTE_PASIVOS_PAGOS", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }

        [TestMethod()]
        public void SP_ADM_REPORTE_PASIVOS_34A_1()
        {

            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                //DataBindingName = "OPT",
                DataBindingName = "ADM22",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. Pasivos 34A1",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_REPORTE_PASIVOS_34A_1.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "34A1_",
                Suffix = string.Empty,
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };



            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"34A1",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"34A1";
            store.StoreProcName = @"SP_ADM_REPORTE_PASIVOS_34A_1";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_ADM_REPORTE_PASIVOS_34A_1", ParameterName = "dfecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }

        [TestMethod()]
        public void SP_ADM_REPORTE_PASIVOS_34A_2()
        {

            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                //DataBindingName = "OPT",
                DataBindingName = "ADM23",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. Pasivos 34A2",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_REPORTE_PASIVOS_34A_2.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "34A2_",
                Suffix = string.Empty,
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };



            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"34A2",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"34A2";
            store.StoreProcName = @"SP_ADM_REPORTE_PASIVOS_34A_2";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_ADM_REPORTE_PASIVOS_34A_2", ParameterName = "FechaProceso", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }
        
        [TestMethod()]
        public void SP_ADM_REPORTE_PASIVOS_CAPTACION_DIARIA()
        {

            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                //DataBindingName = "OPT",
                DataBindingName = "ADM24",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. Pasivos Captacion Diaria",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_REPORTE_PASIVOS_CAPTACION_DIARIA.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "BACEN_CAPTACION_DIARIA_",
                Suffix = string.Empty,
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };



            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"CAP_DIARIA",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"CAP_DIARIA";
            store.StoreProcName = @"SP_ADM_REPORTE_PASIVOS_CAPTACION_DIARIA";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_ADM_REPORTE_PASIVOS_CAPTACION_DIARIA", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);

        }

        [TestMethod()]
        public void SP_ADM_REPORTE_PASIVOS_CAPTACION_MENSUAL()
        {

            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                //DataBindingName = "OPT",
                DataBindingName = "ADM25",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. Pasivos Captacion Mensual",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_REPORTE_PASIVOS_CAPTACION_MENSUAL.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "BACEN_CAPTACION_STOCK_MENSUAL_",
                Suffix = string.Empty,
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };



            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"CAP_MENSUAL",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"CAP_MENSUAL";
            store.StoreProcName = @"SP_ADM_REPORTE_PASIVOS_CAPTACION_MENSUAL";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_ADM_REPORTE_PASIVOS_CAPTACION_MENSUAL", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);

        }

        #endregion

        #region RENTA FIJA

        [TestMethod()]
        public void SP_ADM_REPORTE_RF_769BSL()
        {
            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                //DataBindingName = "BFW",
                DataBindingName = "ADM26",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. RENTA FIJA 769BSL",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_REPORTE_RF_769BSL.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "769BSL",
                Suffix = string.Empty,
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };

            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"RF_769BSL",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"RF_769BSL";
            store.StoreProcName = @"SP_ADM_REPORTE_RF_769BSL";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_ADM_REPORTE_RF_769BSL", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }

        [TestMethod()]
        public void SP_ADM_REPORTE_RF_769TVM()
        {
            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                //DataBindingName = "BFW",
                DataBindingName = "ADM27",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. RENTA FIJA 769TVM",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_REPORTE_RF_769TVM.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "769TVM",
                Suffix = string.Empty,
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };

            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"RF_769TVM",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"RF_769TVM";
            store.StoreProcName = @"SP_ADM_REPORTE_RF_769TVM";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_ADM_REPORTE_RF_769TVM", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }


        [TestMethod()]
        public void SP_ADM_REPORTE_RF_PACTOS_INGRESOS()
        {
            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                //DataBindingName = "BFW",
                DataBindingName = "ADM28",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. RF PACTOS INGRESOS",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_REPORTE_RF_PACTOS_INGRESOS.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "BACEN_INGRESO_",
                Suffix = string.Empty,
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };

            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"RF_PACTO_ING",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"RF_PACTO_ING";
            store.StoreProcName = @"SP_ADM_REPORTE_RF_PACTOS_INGRESOS";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_ADM_REPORTE_RF_PACTOS_INGRESOS", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }

        [TestMethod()]
        public void SP_ADM_REPORTE_RF_PACTOS_MENSUAL()
        {
            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                //DataBindingName = "BFW",
                DataBindingName = "ADM29",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. RF PACTOS MENSUAL",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_REPORTE_RF_PACTOS_MENSUAL.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "BACEN_MENSUAL_",
                Suffix = string.Empty,
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };

            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"RF_PACTO_M",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"RF_PACTO_M";
            store.StoreProcName = @"SP_ADM_REPORTE_RF_PACTOS_MENSUAL";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_ADM_REPORTE_RF_PACTOS_MENSUAL", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }

        [TestMethod()]
        public void SP_ADM_REPORTE_RF_PACTOS_VENCIMIENTOS()
        {
            TemplateData TData = new TemplateData()
            {
                TemplateID = 1,
                //DataBindingName = "BFW",
                DataBindingName = "ADM30",
                DBCatalog = "Reportes",
                TemplateName = "Rpt. RF PACTOS VENCIMIENTOS",
                TemplateDescription = "",
                UseStoreProc = true,
                TemplateDirection = DataDirection.InputOutput,
                IOFileDirection = DataDirection.InputOutput,
                AdditionalInfo = true,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\ADM_REPORTE_RF_PACTOS_VENCIMIENTOS.xml",
                IOFileBaseDirectory = @"\ADM",
                useAppFolders = false
            };

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Ignore, FolderName = @"\IN\HIST" });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Input, FolderName = @"\IN\DAILY" });


            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "BACEN_VENCIMIENTO_",
                Suffix = string.Empty,
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".xlsx"
            };

            TData.IOFileNamePattern = pattern;

            ExcelInfo xlsx = new ExcelInfo()
            {
                ExcelValueSource = @"Table",
                ExcelSheetName = @"RF_PACTO_VENC",
                ExcelColumnStart = 1,
                ExcelRowStart = 2,
                ExcelSheetDirection = DataDirection.Output,
                ExcelSaveAsPrompt = false,
                AllowPaging = false,
            };

            StoreProcsInfo store;
            store = new StoreProcsInfo();
            store.SheetName = @"RF_PACTO_VENC";
            store.StoreProcName = @"SP_ADM_REPORTE_RF_PACTOS_VENCIMIENTOS";
            store.Direction = DataDirection.Output;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_ADM_REPORTE_RF_PACTOS_VENCIMIENTOS", ParameterName = "fecha", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue = "2015-09-30" });
            TData.ListStoreProcsInfo.Add(store);

            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }
        
        #endregion

        #endregion


        #region Proyecto Rentabilidad

        [TestMethod()]
        public void Interfaz_Productos()
        {

            //Dummy Template Data
            TemplateData TData = new TemplateData()
            {                               
                DataBindingName = "RNT01",
                DBCatalog = "Reportes",
                TemplateName = "RPT. RENTABILIDAD PRODUCTOS",
                TemplateDescription = "INTERFAZ PROYECTO RENTABILIDAD, PRODUCTOS",
                UseStoreProc = true,
                TemplateDirection = DataDirection.Output,
                IOFileDirection = DataDirection.Output,
                AdditionalInfo = false,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\Templates\RENTABILIDAD_PRODUCTOS.xml",
                IOFileBaseDirectory = @"\RENTABILIDAD",
                useAppFolders = false
            };

            PlainTextInfo TextInfo = new PlainTextInfo();
            TextInfo.PlainTextDirection = DataDirection.Output;
            TextInfo.DataOnly = true;            //true: solamente la data se volcara, false: todo (columnas y datos)
            TextInfo.ValueSource = "Table2";
            TextInfo.AddressCollection.Add(new TemplateDataAddress() {MaxWritableRows=-1, Direction=DataDirection.Output,ValueMember="HEADER",ColumnTitle="Header", SheetName="Table2",DataAlign=Align.Right});
            TextInfo.MaxRowSize = 64;      //TOTAL DE CARACTERES X FILA
            TData.ListPlainTextInfo.Add(TextInfo);
                        
            TextInfo = new PlainTextInfo();
            TextInfo.PlainTextDirection = DataDirection.Output;
            TextInfo.DataOnly = true;            //true: solamente la data se volcara, false: todo (columnas y datos)
            TextInfo.ValueSource = "Table1";
            TextInfo.MaxRowSize = 231;      //TOTAL DE CARACTERES X FILA
            TextInfo.AddressCollection.Add(new TemplateDataAddress() {MaxWritableRows=-1, Direction=DataDirection.Output,ValueMember="DATA", ColumnTitle="Data", SheetName="Table1",DataAlign = Align.Right});
            TData.ListPlainTextInfo.Add(TextInfo);
           

            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST", CompressedFiles = true });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });

            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "BAC_RNTB_PRODUCTO_",                
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".dat"
            };
            TData.IOFileNamePattern = pattern;



            //los store procs sin parametros deben venir con parametro return value
            StoreProcsInfo store = new StoreProcsInfo();
            store.StoreProcName = @"SP_INT_RENTABILIDAD_PRODUCTOS";
            store.DBCatalog = @"Reportes";
            store.Direction = DataDirection.Output;
            store.ConnectionTimeout = 120;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_INT_RENTABILIDAD_PRODUCTOS", ParameterName = "OPCION", DBType = DbType.Int16, Direction = ParameterDirection.Input,IsNullable=true});
            //store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_INT_RENTABILIDAD_PRODUCTOS", ParameterName = "FECHA", DBType = DbType.Date, Direction = ParameterDirection.Input,IsNullable = true});
            //store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_INT_RENTABILIDAD_PRODUCTOS", ParameterName = "RETURN_VALUE", DBType = DbType.Date, Direction = ParameterDirection.ReturnValue });
            TData.ListStoreProcsInfo.Add(store);
            


            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }
        
        [TestMethod()]
        public void Interfaz_Traders()
        {

            //Dummy Template Data
            TemplateData TData = new TemplateData()
            {
                DataBindingName = "RNT02",
                DBCatalog = "Reportes",
                TemplateName = "RPT. RENTABILIDAD TRADERS",
                TemplateDescription = "INTERFAZ PROYECTO RENTABILIDAD, TRADERS",
                UseStoreProc = true,
                TemplateDirection = DataDirection.Output,
                IOFileDirection = DataDirection.Output,
                AdditionalInfo = false,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\Templates\RENTABILIDAD_TRADERS.xml",
                IOFileBaseDirectory = @"\RENTABILIDAD",
                useAppFolders = false
            };

            PlainTextInfo TextInfo = new PlainTextInfo();
            TextInfo.PlainTextDirection = DataDirection.Output;
            TextInfo.DataOnly = true;            //true: solamente la data se volcara, false: todo (columnas y datos)
            TextInfo.ValueSource = "Table2";
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "HEADER", ColumnTitle = "Header", SheetName = "Table2", DataAlign = Align.Right });
            TextInfo.MaxRowSize = 64;      //TOTAL DE CARACTERES X FILA
            TData.ListPlainTextInfo.Add(TextInfo);

            TextInfo = new PlainTextInfo();
            TextInfo.PlainTextDirection = DataDirection.Output;
            TextInfo.DataOnly = true;            //true: solamente la data se volcara, false: todo (columnas y datos)
            TextInfo.ValueSource = "Table1";
            TextInfo.MaxRowSize = 885;      //TOTAL DE CARACTERES X FILA
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "DATA", ColumnTitle = "Data", SheetName = "Table1", DataAlign = Align.Right });
            TData.ListPlainTextInfo.Add(TextInfo);


            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST", CompressedFiles = true });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });

            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "BAC_RNTB_TRADERS_",
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".dat"
            };
            TData.IOFileNamePattern = pattern;



            //los store procs sin parametros deben venir con parametro return value
            StoreProcsInfo store = new StoreProcsInfo();
            store.StoreProcName = @"SP_INT_RENTABILIDAD_TRADERS";
            store.DBCatalog = @"Reportes";
            store.Direction = DataDirection.Output;
            store.ConnectionTimeout = 120;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_INT_RENTABILIDAD_TRADERS", ParameterName = "OPCION", DBType = DbType.Int16, Direction = ParameterDirection.Input, IsNullable = true });
            //store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_INT_RENTABILIDAD_TRADERS", ParameterName = "FECHA", DBType = DbType.Date, Direction = ParameterDirection.Input,IsNullable = true});
            //store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_INT_RENTABILIDAD_TRADERS", ParameterName = "RETURN_VALUE", DBType = DbType.Date, Direction = ParameterDirection.ReturnValue });
            TData.ListStoreProcsInfo.Add(store);



            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }
        
        [TestMethod()]
        public void Interfaz_Relacion_Cliente_Contrato()
        {

            //Dummy Template Data
            TemplateData TData = new TemplateData()
            {
                DataBindingName = "RNT03",
                DBCatalog = "Reportes",
                TemplateName = "RPT. RENTABILIDAD REL. CLTE. CONTRATO",
                TemplateDescription = "INTERFAZ PROYECTO RENTABILIDAD, REL. CLTE. CONTRATO",
                UseStoreProc = true,
                TemplateDirection = DataDirection.Output,
                IOFileDirection = DataDirection.Output,
                AdditionalInfo = false,
                TemplateFileName = @"C:\BaseDirectory\Templates\RENTABILIDAD_REL_CLTE_CTO.xml",
                IOFileBaseDirectory = @"\RENTABILIDAD",
                useAppFolders = false
            };

            PlainTextInfo TextInfo = new PlainTextInfo();
            TextInfo.PlainTextDirection = DataDirection.Output;
            TextInfo.DataOnly = true;            //true: solamente la data se volcara, false: todo (columnas y datos)
            TextInfo.ValueSource = "Table2";
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "HEADER", ColumnTitle = "Header", SheetName = "Table2", DataAlign = Align.Right });
            TextInfo.MaxRowSize = 64;      //TOTAL DE CARACTERES X FILA
            TData.ListPlainTextInfo.Add(TextInfo);

            TextInfo = new PlainTextInfo();
            TextInfo.PlainTextDirection = DataDirection.Output;
            TextInfo.DataOnly = true;            //true: solamente la data se volcara, false: todo (columnas y datos)
            TextInfo.ValueSource = "Table1";
            TextInfo.MaxRowSize = 385;      //TOTAL DE CARACTERES X FILA
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "DATA", ColumnTitle = "Data", SheetName = "Table1", DataAlign = Align.Right });
            TData.ListPlainTextInfo.Add(TextInfo);


            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST", CompressedFiles = true });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });

            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "BAC_RNTB_RELACION_CLIENTE_CONTRATO_",
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".dat"
            };
            TData.IOFileNamePattern = pattern;



            //los store procs sin parametros deben venir con parametro return value
            StoreProcsInfo store = new StoreProcsInfo();
            store.StoreProcName = @"SP_INT_RENTABILIDAD_REL_CLTE_CTO";
            store.DBCatalog = @"Reportes";
            store.Direction = DataDirection.Output;
            store.ConnectionTimeout = 120;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_INT_RENTABILIDAD_REL_CLTE_CTO", ParameterName = "OPCION", DBType = DbType.Int16, Direction = ParameterDirection.Input, IsNullable = true });
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_INT_RENTABILIDAD_REL_CLTE_CTO", ParameterName = "FECHA", DBType = DbType.Date, Direction = ParameterDirection.Input,IsNullable = true});
            //store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_INT_RENTABILIDAD_REL_CLTE_CTO", ParameterName = "RETURN_VALUE", DBType = DbType.Date, Direction = ParameterDirection.ReturnValue });
            TData.ListStoreProcsInfo.Add(store);



            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }
        
        [TestMethod()]
        public void Interfaz_Cuadro_Pago()
        {

            //Dummy Template Data
            TemplateData TData = new TemplateData()
            {
                DataBindingName = "RNT04",
                DBCatalog = "Reportes",
                TemplateName = "RPT. RENTABILIDAD CUADRO PAGO",
                TemplateDescription = "INTERFAZ PROYECTO RENTABILIDAD, CUADRO DE PAGO",
                UseStoreProc = true,
                TemplateDirection = DataDirection.Output,
                IOFileDirection = DataDirection.Output,
                AdditionalInfo = false,
                TemplateFileName = @"C:\BaseDirectory\Templates\RENTABILIDAD_CUADRO_PAGO.xml",
                IOFileBaseDirectory = @"\RENTABILIDAD",
                useAppFolders = false
            };

            PlainTextInfo TextInfo = new PlainTextInfo();
            TextInfo.PlainTextDirection = DataDirection.Output;
            TextInfo.DataOnly = true;            //true: solamente la data se volcara, false: todo (columnas y datos)
            TextInfo.ValueSource = "Table2";
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "HEADER", ColumnTitle = "Header", SheetName = "Table2", DataAlign = Align.Right });
            TextInfo.MaxRowSize = 64;      //TOTAL DE CARACTERES X FILA
            TData.ListPlainTextInfo.Add(TextInfo);

            TextInfo = new PlainTextInfo();
            TextInfo.PlainTextDirection = DataDirection.Output;
            TextInfo.DataOnly = true;            //true: solamente la data se volcara, false: todo (columnas y datos)
            TextInfo.ValueSource = "Table1";
            TextInfo.MaxRowSize = 229;      //TOTAL DE CARACTERES X FILA
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "DATA", ColumnTitle = "Data", SheetName = "Table1", DataAlign = Align.Right });
            TData.ListPlainTextInfo.Add(TextInfo);


            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST", CompressedFiles = true });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });

            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "BAC_RNTB_CUADRO_PAGO_",
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".dat"
            };
            TData.IOFileNamePattern = pattern;



            //los store procs sin parametros deben venir con parametro return value
            StoreProcsInfo store = new StoreProcsInfo();
            store.StoreProcName = @"SP_INT_RENTABILIDAD_CUADRO_PAGO";
            store.DBCatalog = @"Reportes";
            store.Direction = DataDirection.Output;
            store.ConnectionTimeout = 120;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_INT_RENTABILIDAD_CUADRO_PAGO", ParameterName = "OPCION", DBType = DbType.Int16, Direction = ParameterDirection.Input, IsNullable = true });
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_INT_RENTABILIDAD_CUADRO_PAGO", ParameterName = "FECHA", DBType = DbType.Date, Direction = ParameterDirection.Input, IsNullable = true });
            //store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_INT_RENTABILIDAD_PRODUCTOS", ParameterName = "RETURN_VALUE", DBType = DbType.Date, Direction = ParameterDirection.ReturnValue });
            TData.ListStoreProcsInfo.Add(store);



            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }
   
        [TestMethod()]
        public void Interfaz_Saldos_Operacionales()
        {

            //Dummy Template Data
            TemplateData TData = new TemplateData()
            {
                DataBindingName = "RNT05",
                DBCatalog = "Reportes",
                TemplateName = "RPT. RENTABILIDAD SALDO OPERACIONAL",
                TemplateDescription = "INTERFAZ PROYECTO RENTABILIDAD, SALDO OPERACIONAL",
                UseStoreProc = true,
                TemplateDirection = DataDirection.Output,
                IOFileDirection = DataDirection.Output,
                AdditionalInfo = false,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\Templates\RENTABILIDAD_SALDO_OPERACIONAL.xml",
                IOFileBaseDirectory = @"\RENTABILIDAD",
                useAppFolders = false
            };

            PlainTextInfo TextInfo = new PlainTextInfo();
            TextInfo.PlainTextDirection = DataDirection.Output;
            TextInfo.DataOnly = true;            //true: solamente la data se volcara, false: todo (columnas y datos)
            TextInfo.ValueSource = "Table2";
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "HEADER", ColumnTitle = "Header", SheetName = "Table2", DataAlign = Align.Right });
            TextInfo.MaxRowSize = 64;      //TOTAL DE CARACTERES X FILA
            TData.ListPlainTextInfo.Add(TextInfo);

            TextInfo = new PlainTextInfo();
            TextInfo.PlainTextDirection = DataDirection.Output;
            TextInfo.DataOnly = true;            //true: solamente la data se volcara, false: todo (columnas y datos)
            TextInfo.ValueSource = "Table1";
            TextInfo.MaxRowSize = 424;      //TOTAL DE CARACTERES X FILA
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "DATA", ColumnTitle = "Data", SheetName = "Table1", DataAlign = Align.Right });
            TData.ListPlainTextInfo.Add(TextInfo);


            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST", CompressedFiles = true });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });

            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "BAC_RNTB_SALDOS_OPERACIONALES_",
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".dat"
            };
            TData.IOFileNamePattern = pattern;



            //los store procs sin parametros deben venir con parametro return value
            StoreProcsInfo store = new StoreProcsInfo();
            store.StoreProcName = @"SP_INT_RENTABILIDAD_SALDO_OPERACIONAL";
            store.DBCatalog = @"Reportes";
            store.Direction = DataDirection.Output;
            store.ConnectionTimeout = 120;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_INT_RENTABILIDAD_SALDO_OPERACIONAL", ParameterName = "OPCION", DBType = DbType.Int16, Direction = ParameterDirection.Input, IsNullable = true });
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_INT_RENTABILIDAD_SALDO_OPERACIONAL", ParameterName = "FECHA", DBType = DbType.Date, Direction = ParameterDirection.Input,IsNullable = true});
            //store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_INT_RENTABILIDAD_PRODUCTOS", ParameterName = "RETURN_VALUE", DBType = DbType.Date, Direction = ParameterDirection.ReturnValue });
            TData.ListStoreProcsInfo.Add(store);



            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }
        
        [TestMethod()]
        public void Interfaz_Resultados_Operacionales()
        {

            //Dummy Template Data
            TemplateData TData = new TemplateData()
            {
                DataBindingName = "RNT06",
                DBCatalog = "Reportes",
                TemplateName = "RPT. RENTABILIDAD RESULTADO OPERACIONAL",
                TemplateDescription = "INTERFAZ PROYECTO RENTABILIDAD, RESULTADO OPERACIONAL",
                UseStoreProc = true,
                TemplateDirection = DataDirection.Output,
                IOFileDirection = DataDirection.Output,
                AdditionalInfo = false,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\Templates\RENTABILIDAD_RESULTADO_OPERACIONAL.xml",
                IOFileBaseDirectory = @"\RENTABILIDAD",
                useAppFolders = false
            };

            PlainTextInfo TextInfo = new PlainTextInfo();
            TextInfo.PlainTextDirection = DataDirection.Output;
            TextInfo.DataOnly = true;            //true: solamente la data se volcara, false: todo (columnas y datos)
            TextInfo.ValueSource = "Table2";
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "HEADER", ColumnTitle = "Header", SheetName = "Table2", DataAlign = Align.Right });
            TextInfo.MaxRowSize = 64;      //TOTAL DE CARACTERES X FILA
            TData.ListPlainTextInfo.Add(TextInfo);

            TextInfo = new PlainTextInfo();
            TextInfo.PlainTextDirection = DataDirection.Output;
            TextInfo.DataOnly = true;            //true: solamente la data se volcara, false: todo (columnas y datos)
            TextInfo.ValueSource = "Table1";
            TextInfo.MaxRowSize = 296;      //TOTAL DE CARACTERES X FILA
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "DATA", ColumnTitle = "Data", SheetName = "Table1", DataAlign = Align.Right });
            TData.ListPlainTextInfo.Add(TextInfo);


            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST", CompressedFiles = true });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });

            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "BAC_RNTB_RESULTADOS_OPERACIONALES_",
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".dat"
            };
            TData.IOFileNamePattern = pattern;



            //los store procs sin parametros deben venir con parametro return value
            StoreProcsInfo store = new StoreProcsInfo();
            store.StoreProcName = @"SP_INT_RENTABILIDAD_RESULTADO_OPERACIONAL";
            store.DBCatalog = @"Reportes";
            store.Direction = DataDirection.Output;
            store.ConnectionTimeout = 120;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_INT_RENTABILIDAD_RESULTADO_OPERACIONAL", ParameterName = "OPCION", DBType = DbType.Int16, Direction = ParameterDirection.Input, IsNullable = true });
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_INT_RENTABILIDAD_RESULTADO_OPERACIONAL", ParameterName = "FECHA", DBType = DbType.Date, Direction = ParameterDirection.Input,IsNullable = true});
            //store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_INT_RENTABILIDAD_PRODUCTOS", ParameterName = "RETURN_VALUE", DBType = DbType.Date, Direction = ParameterDirection.ReturnValue });
            TData.ListStoreProcsInfo.Add(store);



            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }
                 
        [TestMethod()]
        public void Interfaz_Detalle_Operaciones()
        {

            //Dummy Template Data
            TemplateData TData = new TemplateData()
            {
                DataBindingName = "RNT07",
                DBCatalog = "Reportes",
                TemplateName = "RPT. RENTABILIDAD DETALLE OPERACIONES",
                TemplateDescription = "INTERFAZ PROYECTO RENTABILIDAD, DETALLE OPERACIONES",
                UseStoreProc = true,
                TemplateDirection = DataDirection.Output,
                IOFileDirection = DataDirection.Output,
                AdditionalInfo = false,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\Templates\RENTABILIDAD_DET_OPERACIONES.xml",
                IOFileBaseDirectory = @"\RENTABILIDAD",
                useAppFolders = false
            };

            PlainTextInfo TextInfo = new PlainTextInfo();
            TextInfo.PlainTextDirection = DataDirection.Output;
            TextInfo.DataOnly = true;            //true: solamente la data se volcara, false: todo (columnas y datos)
            TextInfo.ValueSource = "Table2";
            TextInfo.MaxRowSize = 64;      //TOTAL DE CARACTERES X FILA
            //TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "DATA", ColumnTitle = "Data", SheetName = "Table1", DataAlign = Align.Right });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FECHA_PROCESO", ColumnTitle = "FECHA_PROCESO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 10 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FECHA_CONTABLE", ColumnTitle = "FECHA_CONTABLE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 10 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FECHA_INICIO", ColumnTitle = "FECHA_INICIO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 10 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "HORA_INICIO", ColumnTitle = "HORA_INICIO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FECHA_TERMINO", ColumnTitle = "FECHA_TERMINO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 10 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "HORA_TERMINO", ColumnTitle = "HORA_TERMINO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TOTAL_REGISTROS", ColumnTitle = "TOTAL_REGISTROS", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TData.ListPlainTextInfo.Add(TextInfo);




            TextInfo = new PlainTextInfo();
            TextInfo.PlainTextDirection = DataDirection.Output;
            TextInfo.DataOnly = true;            //true: solamente la data se volcara, false: todo (columnas y datos)
            TextInfo.ValueSource = "Table1";
            //TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "HEADER", ColumnTitle = "Header", SheetName = "Table2", DataAlign = Align.Right});
            TextInfo.MaxRowSize = 7002;      //TOTAL DE CARACTERES X FILA
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IDF_CTO_ODS", ColumnTitle = "IDF_CTO_ODS", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 32 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_CONTENIDO", ColumnTitle = "COD_CONTENIDO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_DATA", ColumnTitle = "FEC_DATA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_PAIS", ColumnTitle = "COD_PAIS", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 2 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_ENTIDAD", ColumnTitle = "COD_ENTIDAD", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_CENTRO", ColumnTitle = "COD_CENTRO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_PRODUCTO", ColumnTitle = "COD_PRODUCTO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_SUBPRODU", ColumnTitle = "COD_SUBPRODU", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_CUENTA", ColumnTitle = "NUM_CUENTA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 12 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_SECUENCIA_CTO", ColumnTitle = "NUM_SECUENCIA_CTO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_DIVISA", ColumnTitle = "COD_DIVISA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_REAJUSTE", ColumnTitle = "COD_REAJUSTE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 3 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IDF_PERS_ODS", ColumnTitle = "IDF_PERS_ODS", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 25 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_CENTRO_CONT", ColumnTitle = "COD_CENTRO_CONT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_OFI_COMERCIAL", ColumnTitle = "COD_OFI_COMERCIAL", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 5 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_GESTOR_PROD", ColumnTitle = "COD_GESTOR_PROD", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_PROPUESTA", ColumnTitle = "COD_PROPUESTA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_COMBO", ColumnTitle = "COD_COMBO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IDF_ELEM", ColumnTitle = "IDF_ELEM", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 12 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_BASE_TAS_INT", ColumnTitle = "COD_BASE_TAS_INT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 3 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_BCA_INT", ColumnTitle = "COD_BCA_INT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 3 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_COMPOS_INT", ColumnTitle = "COD_COMPOS_INT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_MOD_PAGO", ColumnTitle = "COD_MOD_PAGO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_MET_AMRT", ColumnTitle = "COD_MET_AMRT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_CUR_REF", ColumnTitle = "COD_CUR_REF", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 5 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_TIP_TAS", ColumnTitle = "COD_TIP_TAS", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 2 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TAS_INT", ColumnTitle = "TAS_INT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TAS_INT_MIN", ColumnTitle = "TAS_INT_MIN", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TAS_INT_MAX", ColumnTitle = "TAS_INT_MAX", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_BASE_TAS_INT_EXC", ColumnTitle = "COD_BASE_TAS_INT_EXC", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 3 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TAS_INT_EXC", ColumnTitle = "TAS_INT_EXC", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TAS_DIF_INC_REF", ColumnTitle = "TAS_DIF_INC_REF", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TAS_DIF_CUR_COSTE", ColumnTitle = "TAS_DIF_CUR_COSTE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_SIT_DEVENGO", ColumnTitle = "COD_SIT_DEVENGO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_PEOR_SIT_CTO", ColumnTitle = "COD_PEOR_SIT_CTO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 15 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_PEOR_SIT_CTO_BIS", ColumnTitle = "COD_PEOR_SIT_CTO_BIS", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 2 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_ALTA_CTO", ColumnTitle = "FEC_ALTA_CTO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_INI_GEST", ColumnTitle = "FEC_INI_GEST", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_INI_ELEM", ColumnTitle = "FEC_INI_ELEM", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_INI_ELEM_GEST", ColumnTitle = "FEC_INI_ELEM_GEST", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_CAN_ANT", ColumnTitle = "FEC_CAN_ANT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_DESCUBIERTO", ColumnTitle = "FEC_DESCUBIERTO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_PRIMER_IMPAGO_VIGENTE", ColumnTitle = "FEC_PRIMER_IMPAGO_VIGENTE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_FIN_ENGANCHE", ColumnTitle = "FEC_FIN_ENGANCHE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_ULT_LIQ", ColumnTitle = "FEC_ULT_LIQ", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_PRX_LIQ", ColumnTitle = "FEC_PRX_LIQ", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_ULT_REV", ColumnTitle = "FEC_ULT_REV", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_PRX_REV", ColumnTitle = "FEC_PRX_REV", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_VEN", ColumnTitle = "FEC_VEN", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_VEN_ORIGINAL", ColumnTitle = "FEC_VEN_ORIGINAL", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FRE_PAGO_INT", ColumnTitle = "FRE_PAGO_INT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 5 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_UNI_FRE_PAGO_INT", ColumnTitle = "COD_UNI_FRE_PAGO_INT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FRE_REV_INT", ColumnTitle = "FRE_REV_INT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 5 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_UNI_FRE_REV_INT", ColumnTitle = "COD_UNI_FRE_REV_INT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "PLZ_CONTRACTUAL", ColumnTitle = "PLZ_CONTRACTUAL", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 5 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "PLZ_AMRT", ColumnTitle = "PLZ_AMRT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 5 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_UNI_PLZ_AMRT", ColumnTitle = "COD_UNI_PLZ_AMRT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "PLZ_PER_PEND", ColumnTitle = "PLZ_PER_PEND", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 5 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "PLZ_MED_VEN", ColumnTitle = "PLZ_MED_VEN", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 5 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_UNI_PLZ_MED_VEN", ColumnTitle = "COD_UNI_PLZ_MED_VEN", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "PER_LAG", ColumnTitle = "PER_LAG", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 5 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_UNI_PER_LAG", ColumnTitle = "COD_UNI_PER_LAG", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_REPRECIOS", ColumnTitle = "NUM_REPRECIOS", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 5 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_INI_MO", ColumnTitle = "IMP_INI_MO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_CUO_MO", ColumnTitle = "IMP_CUO_MO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_CUO_INI_MO", ColumnTitle = "IMP_CUO_INI_MO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_CUO_PAC", ColumnTitle = "NUM_CUO_PAC", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 5 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_CUO_PEND", ColumnTitle = "NUM_CUO_PEND", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 5 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_AMRT_PRI_ML", ColumnTitle = "IMP_AMRT_PRI_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_AMRT_PRI_MO", ColumnTitle = "IMP_AMRT_PRI_MO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_LIM_CRE_TOT", ColumnTitle = "IMP_LIM_CRE_TOT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_LIM_CREDITO_ML", ColumnTitle = "IMP_LIM_CREDITO_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_LIM_CREDITO_MO", ColumnTitle = "IMP_LIM_CREDITO_MO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_LIM_MED_MES_ML", ColumnTitle = "IMP_LIM_MED_MES_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_LIM_MED_MES_MO", ColumnTitle = "IMP_LIM_MED_MES_MO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_DIA_DEMORA", ColumnTitle = "NUM_DIA_DEMORA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 5 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_MORA1_ML", ColumnTitle = "IMP_MORA1_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_MORA2_ML", ColumnTitle = "IMP_MORA2_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_MORA3_ML", ColumnTitle = "IMP_MORA3_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_MORA4_ML", ColumnTitle = "IMP_MORA4_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_MORA5_ML", ColumnTitle = "IMP_MORA5_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_PAGO_ML", ColumnTitle = "IMP_PAGO_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_PAGO_MO", ColumnTitle = "IMP_PAGO_MO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_SAL_CAS_ML", ColumnTitle = "IMP_SAL_CAS_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_SAL_CAS_MO", ColumnTitle = "IMP_SAL_CAS_MO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_SDO_FALL_ML", ColumnTitle = "IMP_SDO_FALL_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_SDO_FALL_MO", ColumnTitle = "IMP_SDO_FALL_MO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_SDO_VEN_ML", ColumnTitle = "IMP_SDO_VEN_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_SDO_VEN_MO", ColumnTitle = "IMP_SDO_VEN_MO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_CAN_ANT", ColumnTitle = "IND_CAN_ANT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "SDO_CAN_ANT_ML", ColumnTitle = "SDO_CAN_ANT_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "SDO_CAN_ANT_MO", ColumnTitle = "SDO_CAN_ANT_MO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_FUERA_BLCE", ColumnTitle = "IND_FUERA_BLCE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_REFINANCIACION", ColumnTitle = "IND_REFINANCIACION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_TITULIZADO", ColumnTitle = "IND_TITULIZADO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_CAMB_COND", ColumnTitle = "IND_CAMB_COND", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_LIM_CANCELABLE", ColumnTitle = "IND_LIM_CANCELABLE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_CTO_CASADO", ColumnTitle = "IND_CTO_CASADO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_PRO_CTO_CASADO", ColumnTitle = "COD_PRO_CTO_CASADO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_SUBPRODU_CTO_CASADO", ColumnTitle = "COD_SUBPRODU_CTO_CASADO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IDF_CTO_PAS_CASADO", ColumnTitle = "IDF_CTO_PAS_CASADO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 32 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_CTO_INCENTIVADO", ColumnTitle = "IND_CTO_INCENTIVADO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_CTO_RENOVADO", ColumnTitle = "IND_CTO_RENOVADO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_CTO_SING_TESORERIA", ColumnTitle = "IND_CTO_SING_TESORERIA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_CTO_SUBVEN", ColumnTitle = "IND_CTO_SUBVEN", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 5 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IDF_CTO_DERIVADO", ColumnTitle = "IDF_CTO_DERIVADO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 32 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TIP_ORIGEN_FONDO_ACT", ColumnTitle = "TIP_ORIGEN_FONDO_ACT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_FONDO_AJENO_ACT", ColumnTitle = "COD_FONDO_AJENO_ACT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 3 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_INT_ML", ColumnTitle = "IND_INT_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "INT_DIFER_ML", ColumnTitle = "INT_DIFER_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "INT_DIFER_MO", ColumnTitle = "INT_DIFER_MO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "INT_MED_DIFER_ML", ColumnTitle = "INT_MED_DIFER_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "INT_MED_DIFER_MO", ColumnTitle = "INT_MED_DIFER_MO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "INT_COB_PAG_ML", ColumnTitle = "INT_COB_PAG_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "INT_COB_PAG_MO", ColumnTitle = "INT_COB_PAG_MO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "INT_EXC_ML", ColumnTitle = "INT_EXC_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "INT_EXC_MO", ColumnTitle = "INT_EXC_MO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_EFECTOS", ColumnTitle = "NUM_EFECTOS", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 5 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_DISP", ColumnTitle = "NUM_DISP", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 5 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "SDO_PRECIO_ML", ColumnTitle = "SDO_PRECIO_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "SDO_PRECIO_MO", ColumnTitle = "SDO_PRECIO_MO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "SDO_EXC_LIM_ML", ColumnTitle = "SDO_EXC_LIM_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "SDO_EXC_LIM_MO", ColumnTitle = "SDO_EXC_LIM_MO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "SDO_MED_EXC_LIM_ML", ColumnTitle = "SDO_MED_EXC_LIM_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "SDO_MED_EXC_LIM_MO", ColumnTitle = "SDO_MED_EXC_LIM_MO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "SDO_DISP_ML", ColumnTitle = "SDO_DISP_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "SDO_DISP_MO", ColumnTitle = "SDO_DISP_MO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "SDO_MED_NDISP_LC_ML", ColumnTitle = "SDO_MED_NDISP_LC_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "SDO_MED_NDISP_LC_MO", ColumnTitle = "SDO_MED_NDISP_LC_MO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "SDO_NDISP_LC_ML", ColumnTitle = "SDO_NDISP_LC_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "SDO_NDISP_LC_MO", ColumnTitle = "SDO_NDISP_LC_MO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "POR_COM_NO_DISP", ColumnTitle = "POR_COM_NO_DISP", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "POR_MED_DISP_MES", ColumnTitle = "POR_MED_DISP_MES", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "SDO_MED_ANT_REP_MO", ColumnTitle = "SDO_MED_ANT_REP_MO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "SDO_MED_PEND_AMRT_MO", ColumnTitle = "SDO_MED_PEND_AMRT_MO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "SDO_ULT_REV_MO", ColumnTitle = "SDO_ULT_REV_MO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_TAS_PREDEF", ColumnTitle = "IND_TAS_PREDEF", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TAS_PREDEF", ColumnTitle = "TAS_PREDEF", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TAS_SPR_PREDEF", ColumnTitle = "TAS_SPR_PREDEF", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_RESPONS_TAS_PREDEF", ColumnTitle = "COD_RESPONS_TAS_PREDEF", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 2 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "VAL_IND_REAJUSTE_INI", ColumnTitle = "VAL_IND_REAJUSTE_INI", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "VAL_IND_REAJUSTE", ColumnTitle = "VAL_IND_REAJUSTE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_REESTRUC", ColumnTitle = "FEC_REESTRUC", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_REFINAN", ColumnTitle = "FEC_REFINAN", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_NOVACION", ColumnTitle = "FEC_NOVACION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_AVAL_EJECUTADO", ColumnTitle = "IND_AVAL_EJECUTADO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_DEUDA_PUBLICA", ColumnTitle = "IND_DEUDA_PUBLICA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_DEUDA_SUBORDINADA", ColumnTitle = "IND_DEUDA_SUBORDINADA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TIP_IDF_EMISION", ColumnTitle = "TIP_IDF_EMISION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_IDF_EMISION", ColumnTitle = "COD_IDF_EMISION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 2 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_SIT_CONTABLE", ColumnTitle = "COD_SIT_CONTABLE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TAS_TAE", ColumnTitle = "TAS_TAE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_INVERSION", ColumnTitle = "IND_INVERSION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_SIS_ORIGEN", ColumnTitle = "COD_SIS_ORIGEN", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_PROCESO", ColumnTitle = "COD_PROCESO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "USERID_UMO", ColumnTitle = "USERID_UMO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 10 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TIMEST_UMO", ColumnTitle = "TIMEST_UMO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_SIT_GESTION", ColumnTitle = "COD_SIT_GESTION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_SIT_EXPEDIENTE", ColumnTitle = "COD_SIT_EXPEDIENTE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 3 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_FINALIDAD", ColumnTitle = "COD_FINALIDAD", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 5 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_DESTINO_FONDOS", ColumnTitle = "COD_DESTINO_FONDOS", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 5 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_CAMB_COND", ColumnTitle = "FEC_CAMB_COND", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_CARTERA_GEST", ColumnTitle = "COD_CARTERA_GEST", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_COMPLEMENTO", ColumnTitle = "COD_COMPLEMENTO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 6 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "ROWID_FILA", ColumnTitle = "ROWID_FILA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 64 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "POR_UTIL_IND", ColumnTitle = "POR_UTIL_IND", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "POR_CUPON", ColumnTitle = "POR_CUPON", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TAS_COM", ColumnTitle = "TAS_COM", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_CTO_RENOVADO", ColumnTitle = "COD_CTO_RENOVADO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_CANAL", ColumnTitle = "COD_CANAL", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FRE_CARENCIA", ColumnTitle = "FRE_CARENCIA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 5 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_UNI_FRE_CARENCIA", ColumnTitle = "COD_UNI_FRE_CARENCIA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_ORI_OPE", ColumnTitle = "COD_ORI_OPE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_CAN_CTO", ColumnTitle = "FEC_CAN_CTO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FRE_PAGO_CAP", ColumnTitle = "FRE_PAGO_CAP", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_UNI_FRE_PAGO_CAP", ColumnTitle = "COD_UNI_FRE_PAGO_CAP", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_EXCEPCIONADO", ColumnTitle = "IND_EXCEPCIONADO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "PLZ_CARENCIA", ColumnTitle = "PLZ_CARENCIA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 5 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_SIT_IRR_CTO", ColumnTitle = "COD_SIT_IRR_CTO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 5 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_CARENCIA_CAP", ColumnTitle = "FEC_CARENCIA_CAP", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_BOOKEO", ColumnTitle = "IND_BOOKEO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_INI_ML", ColumnTitle = "IMP_INI_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_AVAL_CTO", ColumnTitle = "IMP_AVAL_CTO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_DANO_CREDITICIO", ColumnTitle = "IND_DANO_CREDITICIO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_EST_RIESGO_CRE", ColumnTitle = "IND_EST_RIESGO_CRE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_CARENCIA_INT", ColumnTitle = "FEC_CARENCIA_INT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_PLAN_GEST_CRE", ColumnTitle = "COD_PLAN_GEST_CRE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_FIDEICOMISO", ColumnTitle = "COD_FIDEICOMISO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_CARTERA_CRE", ColumnTitle = "COD_CARTERA_CRE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_CANAL_CONTR", ColumnTitle = "COD_CANAL_CONTR", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 3 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_ENTIDAD_ORI", ColumnTitle = "COD_ENTIDAD_ORI", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_CENTRO_CART", ColumnTitle = "COD_CENTRO_CART", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_TIENDA", ColumnTitle = "COD_TIENDA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 6 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_BLQ", ColumnTitle = "COD_BLQ", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 2 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_COBZA_JUDICIAL", ColumnTitle = "IND_COBZA_JUDICIAL", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_COM_PERIOD", ColumnTitle = "IMP_COM_PERIOD", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_INT_PERIOD_RESULT", ColumnTitle = "IMP_INT_PERIOD_RESULT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_INT_PERIOD_FUERA_BLCE", ColumnTitle = "IMP_INT_PERIOD_FUERA_BLCE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TIPO_COLOCACION", ColumnTitle = "TIPO_COLOCACION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_TIPO_MOVIMIENTO", ColumnTitle = "COD_TIPO_MOVIMIENTO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IDF_SUBCTO_ODS", ColumnTitle = "IDF_SUBCTO_ODS", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 30 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_CTO_SUBRROGACION", ColumnTitle = "IND_CTO_SUBRROGACION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_TIP_FRE_TAS_REF", ColumnTitle = "COD_TIP_FRE_TAS_REF", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_NAT_ACT_SUBY", ColumnTitle = "COD_NAT_ACT_SUBY", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_CUENTA_ASC", ColumnTitle = "COD_CUENTA_ASC", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 30 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_ENT_CUENTA_ASC", ColumnTitle = "COD_ENT_CUENTA_ASC", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_PLZ_TAS_REF", ColumnTitle = "NUM_PLZ_TAS_REF", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 5 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_PER_REV", ColumnTitle = "NUM_PER_REV", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 5 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_AMT", ColumnTitle = "NUM_AMT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 5 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_LIQ", ColumnTitle = "NUM_LIQ", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 5 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "POR_DIF", ColumnTitle = "POR_DIF", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "POR_TAS_REF", ColumnTitle = "POR_TAS_REF", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "POR_INT_DEMORA", ColumnTitle = "POR_INT_DEMORA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_COM_NO_PERIOD", ColumnTitle = "IMP_COM_NO_PERIOD", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_INT_NO_PERIOD", ColumnTitle = "IMP_INT_NO_PERIOD", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_CLAS_RIESGO", ColumnTitle = "COD_CLAS_RIESGO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_CLAS_RIESGO_MAT", ColumnTitle = "COD_CLAS_RIESGO_MAT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_CICLO_PROV", ColumnTitle = "COD_CICLO_PROV", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_ENT_ORIGEN", ColumnTitle = "COD_ENT_ORIGEN", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_RIESGO_SUB", ColumnTitle = "IND_RIESGO_SUB", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "POR_PON_CTO", ColumnTitle = "POR_PON_CTO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_PER_AMT_REP_INC", ColumnTitle = "NUM_PER_AMT_REP_INC", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 5 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_PRE_VIVIENDA", ColumnTitle = "IMP_PRE_VIVIENDA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_SUCURSAL_CTA_ASOCIADA", ColumnTitle = "COD_SUCURSAL_CTA_ASOCIADA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 10 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_EST_REF", ColumnTitle = "COD_EST_REF", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_PRELACION_DEU_PUB", ColumnTitle = "COD_PRELACION_DEU_PUB", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_UNI_FRE_TAS_REF", ColumnTitle = "COD_UNI_FRE_TAS_REF", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_BAJA", ColumnTitle = "FEC_BAJA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_FRE_TAS_REF", ColumnTitle = "NUM_FRE_TAS_REF", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 5 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_NATURALEZA_CTO", ColumnTitle = "COD_NATURALEZA_CTO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_MOD_PROP_ESTI_RIESGO_CRED", ColumnTitle = "IND_MOD_PROP_ESTI_RIESGO_CRED", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_PRIM_SIT_IRRE_PRIMER_CICLO", ColumnTitle = "FEC_PRIM_SIT_IRRE_PRIMER_CICLO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_PRIM_SIT_IRRE_CICLO_ACTUAL", ColumnTitle = "FEC_PRIM_SIT_IRRE_CICLO_ACTUAL", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_ULT_SIT_IRRE_CICLO_ACTUAL", ColumnTitle = "FEC_ULT_SIT_IRRE_CICLO_ACTUAL", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_RIESGO_SUBESTANDAR", ColumnTitle = "FEC_RIESGO_SUBESTANDAR", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_LIM_NO_COMPROMETIDO_CTO", ColumnTitle = "IMP_LIM_NO_COMPROMETIDO_CTO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_CTES_TRANSACCION", ColumnTitle = "IMP_CTES_TRANSACCION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_PRIMAS_DCTO_ADQUISICION", ColumnTitle = "IMP_PRIMAS_DCTO_ADQUISICION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_VALOR_RESI_LEASING", ColumnTitle = "IMP_VALOR_RESI_LEASING", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_PERI_GARAN_FINANCIERAS", ColumnTitle = "IMP_PERI_GARAN_FINANCIERAS", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_SIT_AMORTIZACION", ColumnTitle = "COD_SIT_AMORTIZACION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_TIP_FRE_LIQ", ColumnTitle = "COD_TIP_FRE_LIQ", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 3 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_PLZ_LIQ", ColumnTitle = "NUM_PLZ_LIQ", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 11 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_RIES_SUBESTANDAR", ColumnTitle = "COD_RIES_SUBESTANDAR", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 40 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_INTRAGRUPO", ColumnTitle = "COD_INTRAGRUPO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "PROV_ESPEC_MATRIZ", ColumnTitle = "PROV_ESPEC_MATRIZ", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 23 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "DIST_VENC_MED_PONDERADO", ColumnTitle = "DIST_VENC_MED_PONDERADO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 17 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "LIM_LINEA_PARALELA", ColumnTitle = "LIM_LINEA_PARALELA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "LIM_LINEA_EXPRESS", ColumnTitle = "LIM_LINEA_EXPRESS", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "LIM_LINEA_CUOTAS", ColumnTitle = "LIM_LINEA_CUOTAS", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_PROGDESCTO", ColumnTitle = "COD_PROGDESCTO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TIP_DIAS", ColumnTitle = "TIP_DIAS", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TIP_COBRO", ColumnTitle = "TIP_COBRO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_PERI_GRACIA_MORATORIOS", ColumnTitle = "FEC_PERI_GRACIA_MORATORIOS", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_PAPERLESS", ColumnTitle = "IND_PAPERLESS", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_PREEMBOZADOS", ColumnTitle = "IND_PREEMBOZADOS", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_BLOQUEO_MAYOR_PRIORIDAD", ColumnTitle = "COD_BLOQUEO_MAYOR_PRIORIDAD", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 2 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_BLOQUEO", ColumnTitle = "FEC_BLOQUEO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_DISP_LINEA_PARALELA", ColumnTitle = "IND_DISP_LINEA_PARALELA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 2 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_ASIG_LINEA", ColumnTitle = "FEC_ASIG_LINEA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_DISP_LINEA_EXPRESS", ColumnTitle = "FEC_DISP_LINEA_EXPRESS", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_TIP_IMP", ColumnTitle = "COD_TIP_IMP", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IDF_PERS_ODS_BENEF", ColumnTitle = "IDF_PERS_ODS_BENEF", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 25 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_LIM_CANC_ENTIDAD", ColumnTitle = "IND_LIM_CANC_ENTIDAD", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_INTERNEG", ColumnTitle = "IND_INTERNEG", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_MOT_CANCE_CTO", ColumnTitle = "COD_MOT_CANCE_CTO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 40 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_PRIM_SIT_IRRE_CICLO_ACT", ColumnTitle = "IMP_PRIM_SIT_IRRE_CICLO_ACT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 23 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_PRIM_SIT_IRRE_CICLO", ColumnTitle = "IMP_PRIM_SIT_IRRE_CICLO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 23 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_EXC_CAL_IRB", ColumnTitle = "IND_EXC_CAL_IRB", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_MOT_ALTA_EXPOS", ColumnTitle = "COD_MOT_ALTA_EXPOS", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 40 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_INI_CARE_CAPITAL", ColumnTitle = "FEC_INI_CARE_CAPITAL", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_INI_CARE_INT", ColumnTitle = "FEC_INI_CARE_INT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_SUBROGACION", ColumnTitle = "IND_SUBROGACION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IDF_CTA_CORRENTE", ColumnTitle = "IDF_CTA_CORRENTE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TIP_ORIGEN_FON_BACEN", ColumnTitle = "TIP_ORIGEN_FON_BACEN", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_BLQ_TAR", ColumnTitle = "IND_BLQ_TAR", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 2 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_SIT_TAR", ColumnTitle = "IND_SIT_TAR", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 2 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "BLOQUE_ACT", ColumnTitle = "BLOQUE_ACT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 2 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "EST_CRED", ColumnTitle = "EST_CRED", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "MORA_ESPANA", ColumnTitle = "MORA_ESPANA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "REESTRUCTURADO", ColumnTitle = "REESTRUCTURADO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TAS_INT_ORIGEN", ColumnTitle = "TAS_INT_ORIGEN", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_PRIM_IMPAGO_NO_REGU", ColumnTitle = "IMP_PRIM_IMPAGO_NO_REGU", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 23 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_AMORT_ANTI", ColumnTitle = "IND_AMORT_ANTI", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_PLAZO_CARE_INTE", ColumnTitle = "NUM_PLAZO_CARE_INTE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_EMISION", ColumnTitle = "COD_EMISION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 70 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_TIP_IDF_EMISION", ColumnTitle = "COD_TIP_IDF_EMISION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "SPRD_TRANSFE", ColumnTitle = "SPRD_TRANSFE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TAS_CAM_REAL", ColumnTitle = "TAS_CAM_REAL", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_SIT_CTO", ColumnTitle = "COD_SIT_CTO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TT_IN_CAM_PROM", ColumnTitle = "TT_IN_CAM_PROM", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_PROD_SBIF", ColumnTitle = "COD_PROD_SBIF", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "USER_TABLA", ColumnTitle = "USER_TABLA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 11 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_OPERACION", ColumnTitle = "IND_OPERACION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "CON_GRADO_REE", ColumnTitle = "CON_GRADO_REE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 7 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_DEUD_VENC_NOREP", ColumnTitle = "IMP_DEUD_VENC_NOREP", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_SUBSD_FNG", ColumnTitle = "IMP_SUBSD_FNG", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "ID_OPER_ENT", ColumnTitle = "ID_OPER_ENT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 12 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TIP_RIES_ENT_MO", ColumnTitle = "TIP_RIES_ENT_MO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TIP_RIES_ENT_ML", ColumnTitle = "TIP_RIES_ENT_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_CUO_ML", ColumnTitle = "IMP_CUO_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "PORC_REAJUST", ColumnTitle = "PORC_REAJUST", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_CREDI_CIFIN", ColumnTitle = "COD_CREDI_CIFIN", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 19 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TIP_EXT_DEUD", ColumnTitle = "TIP_EXT_DEUD", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 120 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_COU_MOR", ColumnTitle = "NUM_COU_MOR", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_CAMB", ColumnTitle = "NUM_CAMB", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 5 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_BASE_IMPUESTO_MO", ColumnTitle = "IMP_BASE_IMPUESTO_MO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TIP_SOBR", ColumnTitle = "TIP_SOBR", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_OTORG_OP", ColumnTitle = "FEC_OTORG_OP", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_COMP_DES", ColumnTitle = "FEC_COMP_DES", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "PORC_FIN_VIV", ColumnTitle = "PORC_FIN_VIV", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "PORC_DEFAULT", ColumnTitle = "PORC_DEFAULT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_SWIFT", ColumnTitle = "COD_SWIFT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 10 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_PAG_FEC", ColumnTitle = "IMP_PAG_FEC", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TAR_ICA", ColumnTitle = "TAR_ICA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 3 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_REST", ColumnTitle = "NUM_REST", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 3 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_RNEGC", ColumnTitle = "NUM_RNEGC", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 3 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TIP_FACT_REEST", ColumnTitle = "TIP_FACT_REEST", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_CUO_ANTICIPADAS", ColumnTitle = "IND_CUO_ANTICIPADAS", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_CUO_FUERA_BLCE", ColumnTitle = "IMP_CUO_FUERA_BLCE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_OFI_DEV", ColumnTitle = "COD_OFI_DEV", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_OFI_RETROCESION", ColumnTitle = "COD_OFI_RETROCESION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "DES_COD_CONVENIO_ASC_CTO", ColumnTitle = "DES_COD_CONVENIO_ASC_CTO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_EST_EMBARGO", ColumnTitle = "COD_EST_EMBARGO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_ULT_PROVISION", ColumnTitle = "FEC_ULT_PROVISION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_FIN_CUSTODIA", ColumnTitle = "FEC_FIN_CUSTODIA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_INI_CUSTODIA", ColumnTitle = "FEC_INI_CUSTODIA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_PRX_PROPAGANDA", ColumnTitle = "FEC_PRX_PROPAGANDA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_PRX_ENVIO_CUPONERA", ColumnTitle = "FEC_PRX_ENVIO_CUPONERA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_ULT_ENVIO_CUPONERA", ColumnTitle = "FEC_ULT_ENVIO_CUPONERA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_RECUP_RECIBO_ML", ColumnTitle = "IMP_RECUP_RECIBO_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_CAMB_PERIODIF", ColumnTitle = "IND_CAMB_PERIODIF", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_REDUCCION_CUO_PREP", ColumnTitle = "IND_REDUCCION_CUO_PREP", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_RETROCESION", ColumnTitle = "IND_RETROCESION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_MIN_FIADORES", ColumnTitle = "NUM_MIN_FIADORES", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 2 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_CAP_ACELERADO", ColumnTitle = "IMP_CAP_ACELERADO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_SOL_ML", ColumnTitle = "IMP_SOL_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FREQ_LIQ_INT_CAR", ColumnTitle = "FREQ_LIQ_INT_CAR", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 3 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_TRAT_SEGURO_CAR", ColumnTitle = "COD_TRAT_SEGURO_CAR", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_INT_CARENCIA", ColumnTitle = "COD_INT_CARENCIA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_DIA_PAGO", ColumnTitle = "NUM_DIA_PAGO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 2 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_CASTIGO", ColumnTitle = "FEC_CASTIGO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_EMI_RECIBO", ColumnTitle = "FEC_EMI_RECIBO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_PAGO_ORIG", ColumnTitle = "FEC_PAGO_ORIG", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_PRIM_FACTURACION", ColumnTitle = "FEC_PRIM_FACTURACION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_PRX_COM_IMPG", ColumnTitle = "FEC_PRX_COM_IMPG", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_PRX_SEG_CAR", ColumnTitle = "FEC_PRX_SEG_CAR", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_PRX_EXTRACTO", ColumnTitle = "FEC_PRX_EXTRACTO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_VENTA", ColumnTitle = "FEC_VENTA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_LIM_PLZ_ADICIONALES", ColumnTitle = "FEC_LIM_PLZ_ADICIONALES", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_ULT_FACTURACION", ColumnTitle = "FEC_ULT_FACTURACION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_ULT_CALC_MORA", ColumnTitle = "FEC_ULT_CALC_MORA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_PAGO_OBLIGACION", ColumnTitle = "COD_PAGO_OBLIGACION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_ACREEDOR", ColumnTitle = "IMP_ACREEDOR", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_OPC_COMPRA", ColumnTitle = "IMP_OPC_COMPRA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_FACTURADO_ML", ColumnTitle = "IMP_FACTURADO_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_MAX_DISPOSIC_ML", ColumnTitle = "IMP_MAX_DISPOSIC_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_MIN_LIQUIDACION", ColumnTitle = "IMP_MIN_LIQUIDACION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_MIN_DISPOSIC_ML", ColumnTitle = "IMP_MIN_DISPOSIC_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_TIP_AJUSTE_CUO", ColumnTitle = "IND_TIP_AJUSTE_CUO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_COMUN_IMPAGADOS", ColumnTitle = "IND_COMUN_IMPAGADOS", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_ACELERADO", ColumnTitle = "IND_ACELERADO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_AJUS_HABIL", ColumnTitle = "IND_AJUS_HABIL", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_AJUS_CUO_CAREN", ColumnTitle = "IND_AJUS_CUO_CAREN", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_MORATORIOS", ColumnTitle = "FEC_MORATORIOS", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_CUO_CASTIGADA", ColumnTitle = "IND_CUO_CASTIGADA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_TIP_CUO_EXTRA", ColumnTitle = "IND_TIP_CUO_EXTRA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_FRE_EXTRACTO", ColumnTitle = "COD_FRE_EXTRACTO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "UNI_FRE_EXTRACTO", ColumnTitle = "UNI_FRE_EXTRACTO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_PRORROGA_CUOTA", ColumnTitle = "IND_PRORROGA_CUOTA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_CAMB_TAS_INT", ColumnTitle = "IND_CAMB_TAS_INT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_RECALCULO_CUO", ColumnTitle = "IND_RECALCULO_CUO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "MESES_CUO_EXTRAORDINARIA", ColumnTitle = "MESES_CUO_EXTRAORDINARIA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 3 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_NUEVO_ESTADO_CTA", ColumnTitle = "IND_NUEVO_ESTADO_CTA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_TRAMO", ColumnTitle = "NUM_TRAMO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 3 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "PLZ_MIN_CANCELACION", ColumnTitle = "PLZ_MIN_CANCELACION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 3 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "POR_REFINAN_CUO", ColumnTitle = "POR_REFINAN_CUO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 7 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "POR_MAX_CAPITALIZACION", ColumnTitle = "POR_MAX_CAPITALIZACION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 7 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "PRM_MES_DOS_CUO", ColumnTitle = "PRM_MES_DOS_CUO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 2 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "SDO_PRORROGA_CUO", ColumnTitle = "SDO_PRORROGA_CUO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_TOT_HIPOT_VIS", ColumnTitle = "IMP_TOT_HIPOT_VIS", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_ENTIDAD_CONVENIO", ColumnTitle = "COD_ENTIDAD_CONVENIO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_UNI_FRE_DEB_AUTOM", ColumnTitle = "COD_UNI_FRE_DEB_AUTOM", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "UNI_FRE_DEB_AUTOM", ColumnTitle = "UNI_FRE_DEB_AUTOM", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_TIP_LIQ", ColumnTitle = "IND_TIP_LIQ", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_CONVENIO_ASC_CTO", ColumnTitle = "COD_CONVENIO_ASC_CTO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_SUBVENCION_ORIG", ColumnTitle = "COD_SUBVENCION_ORIG", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_CONDIC_ADMINISTRAT", ColumnTitle = "IND_CONDIC_ADMINISTRAT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_SUBVENCION", ColumnTitle = "COD_SUBVENCION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_TIP_REVISION", ColumnTitle = "COD_TIP_REVISION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_ENTI_SUBVEN_ORI", ColumnTitle = "COD_ENTI_SUBVEN_ORI", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_ESTADO_REVISION", ColumnTitle = "IND_ESTADO_REVISION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_APROB_PROP", ColumnTitle = "FEC_APROB_PROP", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_VEN_SUBVENCION", ColumnTitle = "FEC_VEN_SUBVENCION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_AVI_PRX_REVI", ColumnTitle = "FEC_AVI_PRX_REVI", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_SIT_CTO", ColumnTitle = "FEC_SIT_CTO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TIP_CALENDARIO", ColumnTitle = "TIP_CALENDARIO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_AJUSTE_VEN_INHABILES", ColumnTitle = "IND_AJUSTE_VEN_INHABILES", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_AJUSTE_REV_INHABILES", ColumnTitle = "IND_AJUSTE_REV_INHABILES", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_ACTU_PROV", ColumnTitle = "IND_ACTU_PROV", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_AVISO_VTO", ColumnTitle = "IND_AVISO_VTO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_CAP_AUTOMATICA", ColumnTitle = "IND_CAP_AUTOMATICA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_CARTERA_VENDIDA", ColumnTitle = "IND_CARTERA_VENDIDA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_PAGARE", ColumnTitle = "IND_PAGARE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_ESTADO_RECIBO", ColumnTitle = "IND_ESTADO_RECIBO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_FINANCIACION_IVA", ColumnTitle = "IND_FINANCIACION_IVA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_CTO_GARANTIA", ColumnTitle = "IND_CTO_GARANTIA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_INT_COB_ACELERACION", ColumnTitle = "IND_INT_COB_ACELERACION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_MORA_CONDONADA", ColumnTitle = "IND_MORA_CONDONADA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_NO_FACTURA_CARENCIA", ColumnTitle = "IND_NO_FACTURA_CARENCIA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_OPE_PAGARE", ColumnTitle = "IND_OPE_PAGARE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_NO_PAGO", ColumnTitle = "IND_NO_PAGO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_SEGURO", ColumnTitle = "IND_SEGURO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_CUADRO_MANUAL", ColumnTitle = "IND_CUADRO_MANUAL", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_CTA_MANCOMUNADA", ColumnTitle = "IND_CTA_MANCOMUNADA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "DES_MOT_CUPO", ColumnTitle = "DES_MOT_CUPO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NOM_PORTAFOLIO", ColumnTitle = "NOM_PORTAFOLIO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_PRIM_AMRT", ColumnTitle = "FEC_PRIM_AMRT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_IMPAGOS", ColumnTitle = "NUM_IMPAGOS", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_AUTORIZACION_RENOV", ColumnTitle = "NUM_AUTORIZACION_RENOV", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_CUO_EXTR", ColumnTitle = "NUM_CUO_EXTR", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 3 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_CUO_VENC", ColumnTitle = "NUM_CUO_VENC", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 3 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_CUO_PRORROGA", ColumnTitle = "NUM_CUO_PRORROGA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 3 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_RECIBOS_EMITIDOS", ColumnTitle = "NUM_RECIBOS_EMITIDOS", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_RENOVACIONES", ColumnTitle = "NUM_RENOVACIONES", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 3 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_DIAS_MAX_RENOVACION", ColumnTitle = "NUM_DIAS_MAX_RENOVACION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 3 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_MAX_RENOVACIONES", ColumnTitle = "NUM_MAX_RENOVACIONES", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 3 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_SECUENCIA_EXC", ColumnTitle = "NUM_SECUENCIA_EXC", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_UNI_FRE_DIF_INT", ColumnTitle = "COD_UNI_FRE_DIF_INT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "UNI_FRE_DIF_INT", ColumnTitle = "UNI_FRE_DIF_INT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FRE_UNI_RENOV", ColumnTitle = "FRE_UNI_RENOV", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_UNI_FRE_RENOV", ColumnTitle = "COD_UNI_FRE_RENOV", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "PORC_INT_SUBVEN", ColumnTitle = "PORC_INT_SUBVEN", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 7 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_RETENIDO_AFC", ColumnTitle = "IMP_RETENIDO_AFC", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_SDO_INSOLUTO", ColumnTitle = "IMP_SDO_INSOLUTO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_SDO_REAJUSTABLE", ColumnTitle = "IMP_SDO_REAJUSTABLE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "SEG_MES_DOS_CUO", ColumnTitle = "SEG_MES_DOS_CUO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 2 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_ESTADO_TARIFA", ColumnTitle = "IND_ESTADO_TARIFA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_OFI_FIN_CUSTODIA", ColumnTitle = "COD_OFI_FIN_CUSTODIA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_TIP_CUO_EXTRAORDINARIA", ColumnTitle = "COD_TIP_CUO_EXTRAORDINARIA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_TIP_REDONDEO", ColumnTitle = "COD_TIP_REDONDEO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_TIP_REDUCCION", ColumnTitle = "COD_TIP_REDUCCION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "ACC_SUSP_CARENCIA", ColumnTitle = "ACC_SUSP_CARENCIA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_SEC_TITULARIZACION", ColumnTitle = "NUM_SEC_TITULARIZACION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_INI_ANTIC_ML", ColumnTitle = "IMP_INI_ANTIC_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_ACELERACION", ColumnTitle = "FEC_ACELERACION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_DESACELERACION", ColumnTitle = "FEC_DESACELERACION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_INI_VALIDEZ", ColumnTitle = "FEC_INI_VALIDEZ", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_CONCEPTO_NEG", ColumnTitle = "IND_CONCEPTO_NEG", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_REDONDEO_TARIFA", ColumnTitle = "COD_REDONDEO_TARIFA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_LIM_NEGOCIABLE", ColumnTitle = "IND_LIM_NEGOCIABLE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_INT_PREPAGO", ColumnTitle = "IND_INT_PREPAGO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_FRE_REV_TAS", ColumnTitle = "COD_FRE_REV_TAS", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "PLZ_MAX_TARIFA", ColumnTitle = "PLZ_MAX_TARIFA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 3 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "SDO_FIN_VAL_INT", ColumnTitle = "SDO_FIN_VAL_INT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "SDO_INI_VAL_INT", ColumnTitle = "SDO_INI_VAL_INT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_PLAN_COMISION", ColumnTitle = "COD_PLAN_COMISION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_FIN_VALIDEZ", ColumnTitle = "FEC_FIN_VALIDEZ", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "POR_DESC_COM", ColumnTitle = "POR_DESC_COM", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_MOV_AMRT", ColumnTitle = "IND_MOV_AMRT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_CONDONA_INT_PRIMER_MES", ColumnTitle = "IND_CONDONA_INT_PRIMER_MES", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "VAL_TAS_REF_MORA", ColumnTitle = "VAL_TAS_REF_MORA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_FORMA_PAGO", ColumnTitle = "COD_FORMA_PAGO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_TARJETA", ColumnTitle = "IND_TARJETA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_PAGO_TOTAL", ColumnTitle = "IND_PAGO_TOTAL", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_BLOQ_TIP_TRANS", ColumnTitle = "COD_BLOQ_TIP_TRANS", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_CUO_REVOLVENTES", ColumnTitle = "NUM_CUO_REVOLVENTES", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 22 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_INTERNO_TARJETA", ColumnTitle = "COD_INTERNO_TARJETA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_MARCA_TARJETA", ColumnTitle = "COD_MARCA_TARJETA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_BLOQUEO", ColumnTitle = "COD_BLOQUEO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 10 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_CORTE_MAX", ColumnTitle = "FEC_CORTE_MAX", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_ESTAMPACION", ColumnTitle = "FEC_ESTAMPACION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_ACT_TARJETA", ColumnTitle = "FEC_ACT_TARJETA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_ENTREGA_TARJETA", ColumnTitle = "FEC_ENTREGA_TARJETA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_DIAS_INT_CORR", ColumnTitle = "NUM_DIAS_INT_CORR", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "PORC_EXON_CUOTA_MENEJO", ColumnTitle = "PORC_EXON_CUOTA_MENEJO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_TIP_CTO_TARJETA", ColumnTitle = "COD_TIP_CTO_TARJETA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_TARJETA_ADICIONALES", ColumnTitle = "NUM_TARJETA_ADICIONALES", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_TARJETA_RENOV", ColumnTitle = "NUM_TARJETA_RENOV", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_CHIP", ColumnTitle = "IND_CHIP", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_TIPO_CTA_TARJETA", ColumnTitle = "IND_TIPO_CTA_TARJETA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_MIN_DIFERIR", ColumnTitle = "IMP_MIN_DIFERIR", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_BLOQUEO_REES", ColumnTitle = "COD_BLOQUEO_REES", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_BLOQUEO_SDO", ColumnTitle = "COD_BLOQUEO_SDO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_BLOQUEO_EXCE", ColumnTitle = "COD_BLOQUEO_EXCE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 28 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_BLOQUEO_SALDO", ColumnTitle = "FEC_BLOQUEO_SALDO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_BLOQUEO_SOBRECUPO", ColumnTitle = "FEC_BLOQUEO_SOBRECUPO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_ULT_USO", ColumnTitle = "FEC_ULT_USO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_INI_COBR_INT_CORR", ColumnTitle = "FEC_INI_COBR_INT_CORR", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_PROCESO_DIAN", ColumnTitle = "FEC_PROCESO_DIAN", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_PAGO_MIN_ESP_ML", ColumnTitle = "IMP_PAGO_MIN_ESP_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_COBRO_IMP", ColumnTitle = "IND_COBRO_IMP", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_FIN_INTERES_CORRIENTE", ColumnTitle = "IND_FIN_INTERES_CORRIENTE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TAS_INT_MORA", ColumnTitle = "TAS_INT_MORA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_CHQ", ColumnTitle = "NUM_CHQ", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 28 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_PREEXPED_CHQ", ColumnTitle = "COD_PREEXPED_CHQ", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_COBRO", ColumnTitle = "FEC_COBRO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_INI_GIROS", ColumnTitle = "FEC_INI_GIROS", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_MOV_EXTRACTO", ColumnTitle = "NUM_MOV_EXTRACTO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 22 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_ORDEN_NOPAGO", ColumnTitle = "NUM_ORDEN_NOPAGO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_VCS_CHQ_MORA", ColumnTitle = "NUM_VCS_CHQ_MORA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TIPO_TALONARIO", ColumnTitle = "TIPO_TALONARIO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_CHQ_FISICOS_TALONARIO", ColumnTitle = "NUM_CHQ_FISICOS_TALONARIO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 3 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_BLQ_TALONARIO", ColumnTitle = "COD_BLQ_TALONARIO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_BLQ_CUPO", ColumnTitle = "COD_BLQ_CUPO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_CAP_INT", ColumnTitle = "FEC_CAP_INT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_RENOV", ColumnTitle = "FEC_RENOV", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_MIN_TRANS_LCA", ColumnTitle = "IMP_MIN_TRANS_LCA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_CUPON_FICTICIO", ColumnTitle = "IND_CUPON_FICTICIO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_CAP_INT_RENOVADO", ColumnTitle = "IND_CAP_INT_RENOVADO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_CTO_DOS_DIVISAS", ColumnTitle = "IND_CTO_DOS_DIVISAS", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_LIQ_COMISIONES", ColumnTitle = "IND_LIQ_COMISIONES", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_COONDICION_ESP_CTO", ColumnTitle = "IND_COONDICION_ESP_CTO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_CTA_ESPERA", ColumnTitle = "IND_CTA_ESPERA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_LIBRETA_PERDIDA", ColumnTitle = "IND_LIBRETA_PERDIDA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_MOT_APERTURA", ColumnTitle = "COD_MOT_APERTURA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_MOT_LIBRETA", ColumnTitle = "COD_MOT_LIBRETA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_LIBRETA", ColumnTitle = "NUM_LIBRETA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_PRX_PAG_LIBRETA", ColumnTitle = "NUM_PRX_PAG_LIBRETA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 28 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_PRIMER_CHQ_TALONARIO", ColumnTitle = "NUM_PRIMER_CHQ_TALONARIO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 28 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "SDO_MIN_CTO", ColumnTitle = "SDO_MIN_CTO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "STOCK_TAL_CTA", ColumnTitle = "STOCK_TAL_CTA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 3 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "ULT_NUM_CHQ_ASIG", ColumnTitle = "ULT_NUM_CHQ_ASIG", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 10 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "VAL_SWAP", ColumnTitle = "VAL_SWAP", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_BENEFICIO", ColumnTitle = "IND_BENEFICIO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "DES_PLAN_PAQUETE", ColumnTitle = "DES_PLAN_PAQUETE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_CIERRE_PLAN", ColumnTitle = "FEC_CIERRE_PLAN", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_FIN_DIF_INT", ColumnTitle = "FEC_FIN_DIF_INT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_VENTA_PLAN", ColumnTitle = "FEC_VENTA_PLAN", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_ID_PLAN", ColumnTitle = "COD_ID_PLAN", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "INC_BON_EXC", ColumnTitle = "INC_BON_EXC", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "INC_INT_NO_AUT", ColumnTitle = "INC_INT_NO_AUT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_CTA_INMOVILIZADA", ColumnTitle = "IND_CTA_INMOVILIZADA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "INT_ABN_RENOV", ColumnTitle = "INT_ABN_RENOV", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_EMBARGO", ColumnTitle = "IND_EMBARGO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_COBRANZA_EXTERNA", ColumnTitle = "IND_COBRANZA_EXTERNA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_REF_CUOTA", ColumnTitle = "COD_REF_CUOTA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_RECHAZO_CONFIRMING", ColumnTitle = "IND_RECHAZO_CONFIRMING", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "POR_COB_CONFIRMING", ColumnTitle = "POR_COB_CONFIRMING", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 7 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_EVENTO_PAQUETE", ColumnTitle = "COD_EVENTO_PAQUETE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_PAQUETE", ColumnTitle = "COD_PAQUETE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_FACT_CAP", ColumnTitle = "IND_FACT_CAP", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NOM_AREA_REC", ColumnTitle = "NOM_AREA_REC", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_GESTOR_RECU", ColumnTitle = "COD_GESTOR_RECU", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "DES_COD_BLOQUEO", ColumnTitle = "DES_COD_BLOQUEO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 50 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "DES_CAMARA", ColumnTitle = "DES_CAMARA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 50 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_DESEMB", ColumnTitle = "FEC_DESEMB", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_PORTAFOLIO", ColumnTitle = "COD_PORTAFOLIO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 10 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NOM_COMITE_APROB", ColumnTitle = "NOM_COMITE_APROB", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_ULT_CUOTA_CAP", ColumnTitle = "IMP_ULT_CUOTA_CAP", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_DESEMBOLSO", ColumnTitle = "IMP_DESEMBOLSO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_OTRO_CUPO", ColumnTitle = "IMP_OTRO_CUPO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_ESTADO_TALONARIO", ColumnTitle = "COD_ESTADO_TALONARIO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_CONC_NOVEDAD", ColumnTitle = "COD_CONC_NOVEDAD", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 10 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_AUT_REGULADOR", ColumnTitle = "COD_AUT_REGULADOR", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 14 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_CAMB_NUM_OPER", ColumnTitle = "IND_CAMB_NUM_OPER", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 2 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_DILIGEN_OBSERV", ColumnTitle = "IND_DILIGEN_OBSERV", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 2 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "VAL_INI_COMPRA_VENTA", ColumnTitle = "VAL_INI_COMPRA_VENTA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_CONDICION_CTO", ColumnTitle = "COD_CONDICION_CTO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 3 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_OPR_REGULADOR", ColumnTitle = "COD_OPR_REGULADOR", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 14 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COND_EJERCICIO", ColumnTitle = "COND_EJERCICIO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_CAMB_ESTADO", ColumnTitle = "FEC_CAMB_ESTADO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_NAC_TARJETA", ColumnTitle = "IND_NAC_TARJETA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 2 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_SUBS_CC", ColumnTitle = "IND_SUBS_CC", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 2 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "MOD_ENTREGA_CARTCRED", ColumnTitle = "MOD_ENTREGA_CARTCRED", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 2 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_TAR_ASOC", ColumnTitle = "NUM_TAR_ASOC", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_INI_CUPON", ColumnTitle = "FEC_INI_CUPON", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_EMISION", ColumnTitle = "FEC_EMISION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_FIN_CUPON", ColumnTitle = "FEC_FIN_CUPON", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "DES_PORTAFOLIO", ColumnTitle = "DES_PORTAFOLIO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_NEMOTECNICO", ColumnTitle = "COD_NEMOTECNICO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_TRADER", ColumnTitle = "COD_TRADER", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "VAL_PREC_LIMP", ColumnTitle = "VAL_PREC_LIMP", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_NOMINAL", ColumnTitle = "IMP_NOMINAL", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_AVR", ColumnTitle = "IMP_AVR", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_AVR_DIVISA", ColumnTitle = "COD_AVR_DIVISA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_CARTERA_FINANCI", ColumnTitle = "COD_CARTERA_FINANCI", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_SUBCARTERA_NORMATIVA", ColumnTitle = "COD_SUBCARTERA_NORMATIVA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_TIP_DEVENGO", ColumnTitle = "IND_TIP_DEVENGO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_TIP_OPERACION", ColumnTitle = "COD_TIP_OPERACION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COTIZ_DIVISA_ML", ColumnTitle = "COTIZ_DIVISA_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_TIP_LIQUIDACION_CL", ColumnTitle = "COD_TIP_LIQUIDACION_CL", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 5 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_FIN_ML", ColumnTitle = "IMP_FIN_ML", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_FIN_MO", ColumnTitle = "IMP_FIN_MO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_TRX_USD", ColumnTitle = "IMP_TRX_USD", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "VALOR_SPOT_GAMA", ColumnTitle = "VALOR_SPOT_GAMA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_DELTA", ColumnTitle = "IMP_DELTA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "VALOR_GAMMA", ColumnTitle = "VALOR_GAMMA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "VALOR_VEGA", ColumnTitle = "VALOR_VEGA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "VALOR_THETA", ColumnTitle = "VALOR_THETA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_TIP_CONFIGURACION", ColumnTitle = "IND_TIP_CONFIGURACION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_FIJACION", ColumnTitle = "FEC_FIJACION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "SEC_FIJACION", ColumnTitle = "SEC_FIJACION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_TIP_CAMBIO_FIJACION", ColumnTitle = "COD_TIP_CAMBIO_FIJACION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "VAL_VOLATIDAD", ColumnTitle = "VAL_VOLATIDAD", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TIP_WEIGHT", ColumnTitle = "TIP_WEIGHT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_MONTO_CONTRAVALOR", ColumnTitle = "IMP_MONTO_CONTRAVALOR", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_LIQ_DIVISA", ColumnTitle = "COD_LIQ_DIVISA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 3 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_TIP_LIBRO", ColumnTitle = "COD_TIP_LIBRO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TIP_OPERA_SENSE", ColumnTitle = "TIP_OPERA_SENSE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_TIP_OPCION", ColumnTitle = "COD_TIP_OPCION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_CURV_DESC", ColumnTitle = "COD_CURV_DESC", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_CURV_PROY", ColumnTitle = "COD_CURV_PROY", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IND_EMPR_PAR_FISC", ColumnTitle = "IND_EMPR_PAR_FISC", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_MODAL", ColumnTitle = "COD_MODAL", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TIP_TAS_FWD", ColumnTitle = "TIP_TAS_FWD", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TIP_TAS_SPOT", ColumnTitle = "TIP_TAS_SPOT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_INVEN", ColumnTitle = "FEC_INVEN", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "VAL_TRM", ColumnTitle = "VAL_TRM", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_TIP_PATA", ColumnTitle = "COD_TIP_PATA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 3 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_CURV_REF_DESC", ColumnTitle = "COD_CURV_REF_DESC", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_TIP_INV_NEGOCIACION", ColumnTitle = "COD_TIP_INV_NEGOCIACION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 4 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_DIVISA_FIJACION", ColumnTitle = "COD_DIVISA_FIJACION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 3 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_COMPONENTE", ColumnTitle = "NUM_COMPONENTE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "VAL_TIR", ColumnTitle = "VAL_TIR", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 8 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FACTOR_RIESGO_SUBYA", ColumnTitle = "FACTOR_RIESGO_SUBYA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "DIVISA_SUBYACENTE", ColumnTitle = "DIVISA_SUBYACENTE", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 3 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "VAR_PYG", ColumnTitle = "VAR_PYG", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "VPN", ColumnTitle = "VPN", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "VAL_RIESGO", ColumnTitle = "VAL_RIESGO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "VAL_VTO", ColumnTitle = "VAL_VTO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "VAL_ACUM", ColumnTitle = "VAL_ACUM", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "VAL_COSTO", ColumnTitle = "VAL_COSTO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "PYG_TIR", ColumnTitle = "PYG_TIR", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "VAL_VALORACION", ColumnTitle = "VAL_VALORACION", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COTI_DIVISA", ColumnTitle = "COTI_DIVISA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "REFERENCIA", ColumnTitle = "REFERENCIA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IMP_TASA_SUCIA", ColumnTitle = "IMP_TASA_SUCIA", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TAS_CAMBIO", ColumnTitle = "TAS_CAMBIO", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 20 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "IDF_EMISOR", ColumnTitle = "IDF_EMISOR", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 25 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_DOC", ColumnTitle = "NUM_DOC", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 12 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NUM_OPE_ANT", ColumnTitle = "NUM_OPE_ANT", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 12 });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_MOD_LIQ", ColumnTitle = "COD_MOD_LIQ", SheetName = "Table1", DataAlign = Align.Right, MaxFieldSize = 1 });
            TData.ListPlainTextInfo.Add(TextInfo);
            

            //TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST", CompressedFiles = true });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });

            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "Rentabilidad_Detalle_Operaciones_",
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".dat"
            };
            TData.IOFileNamePattern = pattern;



            //los store procs sin parametros deben venir con parametro return value
            StoreProcsInfo store = new StoreProcsInfo();
            store.StoreProcName = @"SP_INT_RENTABILIDAD_DETALLE_OPERACIONES";
            store.DBCatalog = @"Reportes";
            store.Direction = DataDirection.Output;
            store.ConnectionTimeout = 120;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_INT_RENTABILIDAD_DETALLE_OPERACIONES", ParameterName = "OPCION", DBType = DbType.Int16, Direction = ParameterDirection.Input, IsNullable = false, ParameterValue= 1 ,UseParameterValue = true });
            //store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_INT_RENTABILIDAD_DETALLE_OPERACIONES", ParameterName = "OPCION", DBType = DbType.Int16, Direction = ParameterDirection.Input, IsNullable = true });
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_INT_RENTABILIDAD_DETALLE_OPERACIONES", ParameterName = "FECHA", DBType = DbType.Date, Direction = ParameterDirection.Input,IsNullable = true});
            //store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_INT_RENTABILIDAD_PRODUCTOS", ParameterName = "RETURN_VALUE", DBType = DbType.Date, Direction = ParameterDirection.ReturnValue });
            TData.ListStoreProcsInfo.Add(store);



            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }
     

        #endregion
        
        [TestMethod()]
        public void Interfaz_PruebaMotorTextoPlano()
        {

            // Plantilla, para probar la capacidad del motor de generacion de texto plano.

            //Dummy Template Data
            TemplateData TData = new TemplateData()
            {
                DataBindingName = "RNT01",
                DBCatalog = "Reportes",
                TemplateName = "RPT. RENTABILIDAD PRODUCTOS",
                TemplateDescription = "INTERFAZ PROYECTO RENTABILIDAD, PRODUCTOS",
                UseStoreProc = true,
                TemplateDirection = DataDirection.Output,
                IOFileDirection = DataDirection.Output,
                AdditionalInfo = false,
                //IOFileName = @"Template_NDF.xlsx",
                TemplateFileName = @"C:\BaseDirectory\RENTABILIDAD_PRODUCTOS2.xml",
                IOFileBaseDirectory = @"\RENTABILIDAD",
                useAppFolders = false
            };

            PlainTextInfo TextInfo = new PlainTextInfo();
            TextInfo.Token = ";";              //la inclusion de token, invalida la validacion de largo maximo.
            TextInfo.PlainTextDirection = DataDirection.Output;
            TextInfo.DataOnly = false;            //true: solamente la data se volcara, false: todo (columnas y datos)
            TextInfo.ValueSource = "Table2";
            TextInfo.MaxRowSize = 64;      //TOTAL DE CARACTERES X FILA
            TextInfo.ValidateMaxSize = false;
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FECHA_PROCESO",   ColumnTitle = "Fecha Proceso"  ,MaxFieldSize=10 ,SheetName = "Table2", DataAlign = Align.Right });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FECHA_CONTABLE",  ColumnTitle = "Fecha Contable" ,MaxFieldSize=10 ,SheetName = "Table2", DataAlign = Align.Right });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FECHA_INICIO",    ColumnTitle = "Fecha Inicio"   ,MaxFieldSize=10 ,SheetName = "Table2", DataAlign = Align.Right });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "HORA_INICIO",     ColumnTitle = "Hora Incio"     ,MaxFieldSize=8  ,SheetName = "Table2", DataAlign = Align.Right });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FECHA_TERMINO",   ColumnTitle = "Fecha Termino"  ,MaxFieldSize=10 ,SheetName = "Table2", DataAlign = Align.Right });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "HORA_TERMINO",    ColumnTitle = "Hora Termino"   ,MaxFieldSize=8  ,SheetName = "Table2", DataAlign = Align.Right });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TOTAL_REGISTROS", ColumnTitle = "Total Registros",MaxFieldSize=8  ,SheetName = "Table2", DataAlign = Align.Right });                       
            
            TData.ListPlainTextInfo.Add(TextInfo);

            TextInfo = new PlainTextInfo();
            TextInfo.Token = ";";
            TextInfo.PlainTextDirection = DataDirection.Output;
            TextInfo.DataOnly = false;            //true: solamente la data se volcara, false: todo (columnas y datos)
            TextInfo.ValueSource = "Table1";
            TextInfo.MaxRowSize = 231;      //TOTAL DE CARACTERES X FILA
            TextInfo.ValidateMaxSize = true;
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_PRODUCTO"         , ColumnTitle = "COD_PRODUCTO"         ,MaxFieldSize=4  , SheetName = "Table1", DataAlign = Align.Right });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_SUBPRODU"         , ColumnTitle = "COD_SUBPRODU"         ,MaxFieldSize=4  , SheetName = "Table1", DataAlign = Align.Right });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_PAIS"             , ColumnTitle = "COD_PAIS"             ,MaxFieldSize=2  , SheetName = "Table1", DataAlign = Align.Right });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "DES_PRODUCTO"         , ColumnTitle = "DES_PRODUCTO"         ,MaxFieldSize=50 , SheetName = "Table1", DataAlign = Align.Right });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_PRODUCTO_GLOBAL"  , ColumnTitle = "COD_PRODUCTO_GLOBAL"  ,MaxFieldSize=3  , SheetName = "Table1", DataAlign = Align.Right });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_ALTA"             , ColumnTitle = "FEC_ALTA"             ,MaxFieldSize=8  , SheetName = "Table1", DataAlign = Align.Right });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_BAJA"             , ColumnTitle = "FEC_BAJA"             ,MaxFieldSize=8  , SheetName = "Table1", DataAlign = Align.Right });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_PROCESO"          , ColumnTitle = "COD_PROCESO"          ,MaxFieldSize=20 , SheetName = "Table1", DataAlign = Align.Right });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "USERID_UMO"           , ColumnTitle = "USERID_UMO"           ,MaxFieldSize=10 , SheetName = "Table1", DataAlign = Align.Right });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "TIMEST_UMO"           , ColumnTitle = "TIMEST_UMO"           ,MaxFieldSize=8  , SheetName = "Table1", DataAlign = Align.Right });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "ROWID_FILA"           , ColumnTitle = "ROWID_FILA"           ,MaxFieldSize=64 , SheetName = "Table1", DataAlign = Align.Right });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_PLAN_GEST_CRE"    , ColumnTitle = "COD_PLAN_GEST_CRE"   ,MaxFieldSize=8  , SheetName = "Table1", DataAlign = Align.Right });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "FEC_DATA"             , ColumnTitle = "FEC_DATA"             ,MaxFieldSize=8  , SheetName = "Table1", DataAlign = Align.Right });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "COD_ENTIDAD"          , ColumnTitle = "COD_ENTIDAD"          ,MaxFieldSize=4  , SheetName = "Table1", DataAlign = Align.Right });
            TextInfo.AddressCollection.Add(new TemplateDataAddress() { MaxWritableRows = -1, Direction = DataDirection.Output, ValueMember = "NOM_SUBPRODUCTO"      , ColumnTitle = "NOM_SUBPRODUCTO"      ,MaxFieldSize=30 , SheetName = "Table1", DataAlign = Align.Right });           
            
            TData.ListPlainTextInfo.Add(TextInfo);


            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = false, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\HIST", CompressedFiles = true });
            TData.IOFileCopyFolders.Add(new IOFileCopyFolders() { MainFolder = true, FolderDirection = FolderDirection.Output, FolderName = @"\OUT\DAILY" });

            IOFileNamePattern pattern = new IOFileNamePattern()
            {
                Prefix = "Rentabilidad_Productos2_",
                Pattern = "yyyyMMdd",
                useDatePattern = true,
                Extension = ".dat"
            };
            TData.IOFileNamePattern = pattern;



            //los store procs sin parametros deben venir con parametro return value
            StoreProcsInfo store = new StoreProcsInfo();
            store.StoreProcName = @"SP_INT_RENTABILIDAD_PRODUCTOS";
            store.DBCatalog = @"Reportes";
            store.Direction = DataDirection.Output;
            store.ConnectionTimeout = 120;
            store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_INT_RENTABILIDAD_PRODUCTOS", ParameterName = "OPCION", DBType = DbType.Int16, Direction = ParameterDirection.Input, IsNullable = false,ParameterValue=1 });
            //store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_INT_RENTABILIDAD_PRODUCTOS", ParameterName = "FECHA", DBType = DbType.Date, Direction = ParameterDirection.Input,IsNullable = true});
            //store.ListStoreProcParams.Add(new TemplateStoreProcParams() { StoreProcName = "SP_INT_RENTABILIDAD_PRODUCTOS", ParameterName = "RETURN_VALUE", DBType = DbType.Date, Direction = ParameterDirection.ReturnValue });
            TData.ListStoreProcsInfo.Add(store);



            XmlDocument xdoc = new XmlDocument();
            xdoc = TData.ToXML();
            xdoc.Save(TData.TemplateFileName);
            FileInfo f = new FileInfo(TData.TemplateFileName);
            Assert.IsTrue(f.Exists, "Done! :" + TData.TemplateFileName);
        }
        
        


    }
}
