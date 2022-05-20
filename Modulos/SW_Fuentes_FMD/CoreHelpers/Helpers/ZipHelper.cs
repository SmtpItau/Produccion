using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO.Compression;
using System.IO.Packaging;
using System.IO;


namespace CoreLib.Helpers
{
    
    /// <summary>
    /// Provee de funciones de compresion y descompresion para archivos Zip (segun estandar OpenPackage) y GZip
    /// </summary>
    public static class ZipHelper
    {
        /// <summary>
        /// Comprime un archivo en formato GZip
        /// </summary>
        /// <param name="fileToCompress">Archivo a comprimir</param>
        /// <param name="DeleteFile">Indica si se borra el archivo una vez comprimido</param>
        /// <returns>true/false</returns>
        public static bool CompressFile(string fileToCompress, bool DeleteFile)
        {
            bool compressed = ZipHelper.CompressFile(fileToCompress);
            if (compressed)
            {
                if (DeleteFile == true)
                {
                    try
                    {
                        FileInfo f = new FileInfo(fileToCompress);
                        f.Delete();
                        return true;
                    }
                    catch (Exception)
                    {
                        throw;
                    }
                }
                else
                {
                    return true;
                }
            }
            return false;
        }

        /// <summary>
        /// Comprime un archivo en formato GZip
        /// </summary>
        /// <param name="fileToCompress">Archivo a comprimir</param>
        /// <returns>true, si el archivo fue comprimido / false si hubo una excepcion interna.</returns>
        public static bool CompressFile(string fileToCompress)
        {
            if (string.IsNullOrEmpty(fileToCompress.Trim()))
            {
                throw new ArgumentNullException("fileToZip", "El parametro no puede ser nulo");
            }
            else
            {
                FileInfo aux = new FileInfo(fileToCompress);
                if (!aux.Exists)
                {
                    aux = null;
                    throw new FileNotFoundException("No se puede encontrar el archivo:" + fileToCompress);
                }
                aux = null;
            }

            try
            {
                FileInfo file = new FileInfo(fileToCompress);
                using (FileStream fileStream = file.OpenRead())
                {

                    if ((File.GetAttributes(file.FullName) &
                          FileAttributes.Hidden) != FileAttributes.Hidden & file.Extension != ".gz")
                    {
                        using (FileStream compressedFileStream = File.Create(file.FullName + ".gz"))
                        {
                            using (GZipStream compressionStream = new GZipStream(compressedFileStream, CompressionMode.Compress))
                            {
                                fileStream.CopyTo(compressionStream);
                            }//using compressionStream
                        } //using compressedFileStream
                    }//if (fileattr)
                }//using fileStream
                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }

        /// <summary>
        /// Descomprime un unico archivo
        /// </summary>
        /// <param name="zipFile">nombre del archivo gzip para descomprimir</param>
        /// <returns>true</returns>
        public static bool Decompress(string zipFile)
        {
            FileInfo f = new FileInfo(zipFile);
            if (f.Exists)
            {
                using (FileStream org_fs = f.OpenRead())
                {
                    string currentFile = f.FullName;
                    string newFileName = currentFile.Remove(currentFile.Length - f.Extension.Length);

                    using (FileStream decompressedFileStream = File.Create(newFileName))
                    {
                        using (GZipStream decompressionStream = new GZipStream(org_fs, CompressionMode.Decompress))
                        {
                            decompressionStream.CopyTo(decompressedFileStream);
                        }
                    }
                }
            }
            else
            {
                throw new FileNotFoundException();
            }
            return true;
        }

        /// <summary>
        /// Comprime un archivo en un nuevo archivo zip
        /// </summary>
        /// <param name="fileToZip">Archivo a comprimir</param>
        /// <param name="outputZip">Nombre del archivo zip resultante</param>
        /// <param name="compressionLevel">Nivel de compresion</param>
        /// <returns>true</returns>
        public static bool ZipFile(string fileToZip, string outputZip, CompressionOption compressionLevel = CompressionOption.Normal)
        {
            if (ZipHelper.GetFileExtentionName(outputZip).ToLower() != "zip")
            {
                throw new ArgumentException("La extensión del archivo no corresponde.");
            }


            try
            {
                //tipo de contenido de archivo.
                string contentType = @"data/" + ZipHelper.GetFileExtentionName(fileToZip);
                //genera un uri como dato para ingresar en archivo zip
                Uri fileUri = PackUriHelper.CreatePartUri(new Uri(@"/" + Path.GetFileName(fileToZip), UriKind.Relative));

                using (FileStream fs_output = new FileStream(outputZip, FileMode.Create))
                {
                    //genera un stream donde se almacenaran los archivos comprimidos
                    using (Package pkg = Package.Open(fs_output, FileMode.Create))
                    {
                        // crea una entrada para agregar al zip
                        using (Stream zip_stream = pkg.CreatePart(fileUri, contentType, compressionLevel).GetStream())
                        {
                            //stream de destino (archivo zip)
                            using (FileStream fs = new FileStream(fileToZip, FileMode.Open))
                            {
                                //copia el stream del archivo (comprime internamente)
                                fs.CopyTo(zip_stream);
                            }
                        }
                    }
                }
                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }

        /// <summary>
        /// Comprime un archivo en un nuevo archivo zip
        /// </summary>
        /// <param name="fileToZip">Archivo a comprimir</param>
        /// <param name="outputZip">Nombre del archivo zip resultante</param>
        /// <param name="compressionLevel">Nivel de compresion</param>
        /// <param name="deleteFileAfterZip">Indica al motor si borra el archivo despues de comprimirlo</param>
        /// <returns>true</returns>
        public static bool ZipFile(string fileToZip, string outputZip, CompressionOption compressionLevel = CompressionOption.Normal, bool deleteFileAfterZip = false) {
            bool compressed = ZipFile(fileToZip, outputZip, compressionLevel);

            if (compressed) {
                if (deleteFileAfterZip == true)
                {
                    try
                    {
                        FileInfo f = new FileInfo(fileToZip);
                        f.Delete();
                        return true;
                    }
                    catch (Exception)
                    {
                        throw;
                    }
                }
                else {
                    return true;
                }
            }            
            return false;
        }



        /// <summary>
        /// Comprime un archivo en un nuevo archivo zip (Compresion = Normal por default)
        /// </summary>
        /// <param name="fileToZip">Archivo a comprimir</param>
        /// <param name="outputZip">Nombre del archivo zip resultante</param>
        /// <param name="deleteFileAfterZip">Indica al motor si borra el archivo despues de comprimirlo</param>        
        /// <returns>true</returns>
        public static bool ZipFile(string fileToZip, string outputZip, bool deleteFileAfterZip = false) {
            return ZipHelper.ZipFile(fileToZip, outputZip, CompressionOption.Normal, deleteFileAfterZip);
        }
            
        /// <summary>
        /// Comprime multiples archivos en uno solo zip
        /// </summary>
        /// <param name="files">Lista o array de con nombres de archivos</param>
        /// <param name="outputZip">Nombre de archivo zip resultante</param>
        /// <param name="compressionLevel" value="CompressionOption.Normal">Nivel de compresion </param>
        /// <returns>true</returns>
        public static bool ZipFile(IEnumerable<string> files, string outputZip, CompressionOption compressionLevel = CompressionOption.Normal) {

            if (ZipHelper.GetFileExtentionName(outputZip).ToLower() != "zip")
            {
                throw new ArgumentException("La extensión del archivo no corresponde.");
            }

            try
            {
                
                using (FileStream fs_output = new FileStream(outputZip,FileMode.Create))
                {
                    using (Package pkg = Package.Open(fs_output, FileMode.Create)) 
                    {
                        foreach (string file in files) { 
                            string contentType = @"data/" + ZipHelper.GetFileExtentionName(file);
                            Uri fileUri = PackUriHelper.CreatePartUri(new Uri(@"/" + Path.GetFileName(file),UriKind.Relative));                            

                            using (Stream zip_stream = pkg.CreatePart(fileUri, contentType, compressionLevel).GetStream()) 
                            {
                                using (FileStream fs = new FileStream(file, FileMode.Open)) {
                                    fs.CopyTo(zip_stream);                                    
                                }
                            }                        
                        }
                    }
                }
                return true;
            }
            catch (Exception)
            {                
                throw;
            }
        }

        /// <summary>
        /// Agrega un archivo a un archivo zip ya existente.
        /// </summary>
        /// <param name="files"></param>
        /// <param name="zipFile"></param>
        /// <param name="compressionLevel"></param>
        /// <returns></returns>
        public static bool AddToZipFile(IEnumerable<string> files, string zipFile, CompressionOption compressionLevel = CompressionOption.Normal) {
            if (ZipHelper.GetFileExtentionName(zipFile).ToLower() != "zip")
            {
                throw new ArgumentException("La extensión del archivo no corresponde.");
            }
            try
            {

                using (FileStream fs_output = new FileStream(zipFile, FileMode.Open))
                {
                    using (Package pkg = ZipPackage.Open(fs_output, FileMode.Open))
                    {
                       
                        foreach (string file in files)
                        {
                            string contentType = @"data/" + ZipHelper.GetFileExtentionName(file);
                            Uri fileUri = PackUriHelper.CreatePartUri(new Uri(@"/" + Path.GetFileName(file), UriKind.Relative));

                            if (pkg.PartExists(fileUri)) {
                                pkg.DeletePart(fileUri);
                            }
                            
                            using (Stream zip_stream = pkg.CreatePart(fileUri, contentType, compressionLevel).GetStream())
                            {                                                                    
                                using (FileStream fs = new FileStream(file, FileMode.Open)) {
                                    fs.CopyTo(zip_stream);
                                }
                            }
                        }
                    }
                }
                return true;

            }
            catch (Exception)
            {
                
                throw;
            }
            
        }

        /// <summary>
        /// Añade un archivo a un archivo zip existente
        /// </summary>
        /// <param name="files">Lista de archivos a agregar</param>
        /// <param name="zipFile">Nombre de archivo zip al cual se va a añadir el(los) archivos</param>
        /// <param name="compressionLevel">Nivel de compresion</param>
        /// <param name="deleteFilesAfterZip">Elimina o no los archivos</param>
        /// <returns></returns>
        public static bool AddToZipFile(IEnumerable<string> files, string zipFile, CompressionOption compressionLevel = CompressionOption.Normal, bool deleteFilesAfterZip = false) {
            bool result = ZipHelper.AddToZipFile(files, zipFile, compressionLevel);
            try
            {
                if (result == true)
                {
                    foreach (string file in files)
                    {
                        FileInfo f = new FileInfo(file);
                        f.Delete();
                    }
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception)
            {
                throw;
            }
        
        }
        

        /// <summary>
        /// Comprime multiples archivos en uno solo zip
        /// </summary>
        /// <param name="files">Lista o array de con nombres de archivos</param>
        /// <param name="outputZip">Nombre de archivo zip resultante</param>
        /// <param name="compressionLevel" value="CompressionOption.Normal">Nivel de compresion </param>
        /// <param name="deleteFilesAfterZip">indica al motor si borra los archivos despues de comprimirlos</param>
        /// <returns>true</returns>
        public static bool ZipFile(IEnumerable<string> files, string outputZip, CompressionOption compressionLevel = CompressionOption.Normal, bool deleteFilesAfterZip = false) {
            bool result = ZipHelper.ZipFile(files, outputZip, compressionLevel);
            try
            {
                if (result == true)
                {
                    foreach (string file in files)
                    {
                        FileInfo f = new FileInfo(file);
                        f.Delete();
                    }
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception)
            {                
                throw;
            }
        }

        /// <summary>
        /// Comprime multiples archivos en uno solo zip, con modo de compresion Normal
        /// </summary>
        /// <param name="files">Lista o array de con nombres de archivos</param>
        /// <param name="outputZip">Nombre de archivo zip resultante</param>
        /// <param name="deleteFilesAfterZip">indica al motor si borra los archivos despues de comprimirlos</param>
        /// <returns>true</returns>
        public static bool ZipFile(IEnumerable<string> files, string outputZip, bool deleteFilesAfterZip = false) {
            return ZipHelper.ZipFile(files, outputZip, CompressionOption.Normal, deleteFilesAfterZip);
        }
                
        /// <summary>
        /// Descomprime un archivo zip
        /// </summary>
        /// <param name="fileToUnzip">Nombre del archivo zip a descomprimr</param>
        /// <param name="baseFolder">directorio donde quedara el archivo</param>
        /// <returns>true</returns>
        public static bool UnZip(string fileToUnzip, string baseFolder)
        {
            if (ZipHelper.GetFileExtentionName(fileToUnzip).ToLower() != "zip")
            {
                throw new ArgumentException("La extensión del archivo no corresponde.");
            }
            try
            {
                if (!Directory.Exists(baseFolder))
                {
                    Directory.CreateDirectory(baseFolder);
                }

                FileStream fs_zip = new FileStream(fileToUnzip, FileMode.Open);

                using (Package pkg = Package.Open(fs_zip,FileMode.Open))
                {

                    foreach (PackagePart zipPart in pkg.GetParts())
                    {
                        string path = Path.Combine(baseFolder, Uri.UnescapeDataString(zipPart.Uri.ToString()).Substring(1));

                        using (Stream zipStream = zipPart.GetStream())
                        {
                            using (FileStream fs = new FileStream(path, FileMode.Create))
                            {
                                zipStream.CopyTo(fs);
                            }
                        }//end: using zipStream
                    } //end:foreach                        
                }//end:Using pkg                        
                fs_zip.Close();
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        
        /// <summary>
        /// Retorna la extension del archivo 
        /// </summary>
        /// <param name="path">ruta del archivo</param>
        /// <returns>string con la extension.</returns>
        private static string GetFileExtentionName(string path)
        {
            string extention = Path.GetExtension(path);
            if (!string.IsNullOrWhiteSpace(extention) && extention.StartsWith("."))
            {
                extention = extention.Substring(1);
            }
            return extention;
        }
    }
}
