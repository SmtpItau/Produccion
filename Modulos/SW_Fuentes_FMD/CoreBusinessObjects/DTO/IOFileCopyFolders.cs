#pragma warning disable 1591
using System;
using System.IO;
using System.Xml;
using System.Xml.Serialization;
using CoreBusinessObjects.Common;

namespace CoreBusinessObjects.DTO
{
    /// <summary>
    /// Clase Implementacion multiples directorios.
    /// </summary>
    [Serializable]
    [XmlType("IOFileCopyFolders")]
    public class IOFileCopyFolders : IDisposable
    {
        #region Private Members

        /// <summary>
        /// Marca el Folder como primario
        /// </summary>
        private bool _MainFolder = false;

        /// <summary>
        /// Direccion del directorio
        /// </summary>
        private FolderDirection _FolderDirection;

        /// <summary>
        /// Nombre del directorio
        /// </summary>
        private string _FolderName;

        /// <summary>
        /// aux
        /// </summary>
        private DirectoryInfo _DirInfo;

        private bool _CompressedFiles = false;
        
        #endregion

        #region Properties
        /// <summary>
        /// Direccion de entrega del Directorio.
        /// </summary>
        [XmlElement("FolderDirection")]
        public FolderDirection FolderDirection { get { return _FolderDirection; } set { _FolderDirection = value; } }

        /// <summary>
        /// Nombre del directorio
        /// </summary>
        [XmlElement("FolderName")]
        public string FolderName { get { return _FolderName; } set { _FolderName = value; } }

        /// <summary>
        /// Marca el directorio como principal (si existe en la coleccion mas de un principal, tomara el ultimo marcado.
        /// </summary>
        [XmlElement("MainFolder")]
        public bool MainFolder { get { return _MainFolder; } set { _MainFolder = value; } }
        
        /// <summary>
        /// Indica si los archivo en este directorio se debe comprimir para ahorrar espacio
        /// </summary>
        [XmlElement("CompressedFiles")]
        public bool CompressedFiles { get { return _CompressedFiles; } set { _CompressedFiles = value; } }

        /// <summary>
        /// DirectoryInfo Object
        /// </summary>
        [XmlIgnore]
        public DirectoryInfo DirectoryInfo
        {
            get
            {
                if (string.IsNullOrEmpty(_FolderName))
                {
                    throw new DirectoryNotFoundException();
                }

                _DirInfo = new DirectoryInfo(_FolderName);
                return _DirInfo;
            }
        }
        
        #endregion

        #region Methods

        /// <summary>
        /// Copia el objeto IOFileCopyFolders
        /// </summary>
        /// <returns></returns>
        public IOFileCopyFolders Copy()
        {
            IOFileCopyFolders x = new IOFileCopyFolders();
            x._DirInfo = this._DirInfo;
            x._FolderDirection = this._FolderDirection;
            x._FolderName = this._FolderName;
            x._MainFolder = this._MainFolder;
			x._CompressedFiles = this._CompressedFiles;
            return x;
        }
        
        #endregion
        #region Implementacion IDisposable

        /// <summary>
        /// guid del objeto
        /// </summary>
        protected Guid? _UniqueID;
        /// <summary>
        /// Id Interno del objeto
        /// </summary>
        [XmlIgnore]
        public Guid? UniqueID { get { return _UniqueID; } set { _UniqueID = value; } }

        public IOFileCopyFolders()
        {
            this._UniqueID = Guid.NewGuid();
        }

        /// <summary>
        /// Default Destructor
        /// </summary>
        ~IOFileCopyFolders()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        /// <summary>
        /// Disposing Flag
        /// </summary>
        private bool disposed = false;

        /// <summary>
        /// Virtual Dispose Method
        /// </summary>
        /// <param name="disposing">true/false</param>
        protected virtual void Dispose(bool disposing)
        {
            if (!disposed)
            {
                if (disposing)
                {
                    //Liberacion de recursos tomados.
                    //this._ExcelFile = null;
                }
                disposed = true;
            }
        }

        /// <summary>
        /// Dispose Method
        /// </summary>
        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
        #endregion
        
    }
}
