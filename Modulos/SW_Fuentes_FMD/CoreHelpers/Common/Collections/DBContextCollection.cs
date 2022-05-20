#pragma warning disable 1591
using System;
using System.Collections;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace CoreLib.Common.Collections
{

    /// <summary>
    /// Enumerador de DBContextCollection
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public class DBContextCollectionEnumerator<T>
        : IEnumerator<T> where T : DBContext
    {
        protected DBContextCollection<T> _collection; //coleccion enumerada
        protected int index; //current index
        protected T _current; // current enumerated object in the collection
        public DBContextCollectionEnumerator() { }
        public DBContextCollectionEnumerator(DBContextCollection<T> collection) { _collection = collection; index = -1; _current = default(T); }
        public virtual T Current { get { return _current; } }
        object IEnumerator.Current { get { return _current; } }
        public virtual void Dispose() { _collection = null; _current = default(T); index = -1; }
        public virtual bool MoveNext() { if (++index >= _collection.Count) { return false; } else { _current = _collection[index]; } return true; }
        public virtual void Reset() { _current = default(T); index = -1; }
    }

    [Serializable()]
    [XmlRoot("DBConnections")]
    public class DBContextCollection<T>
       : ICollection<T> where T : DBContext
    {
        protected ArrayList _innerArray;
        protected bool _IsReadOnly;
        public DBContextCollection() { this._innerArray = new ArrayList(); }
        public virtual T this[int index] { get { return (T)_innerArray[index]; } set { _innerArray[index] = value; } }
        public virtual T this[string DBCatalog] {
            get {
                foreach (T item in _innerArray) {
                    if (item.DBCatalog == DBCatalog) {
                        return (T)item;
                    }
                }
                return null;
            }            
        }
        public virtual int Count { get { return _innerArray.Count; } }
        public virtual bool IsReadOnly { get { return _IsReadOnly; } }
        public virtual bool Remove(T DBContext)
        {
            bool result = false;
            for (int i = 0; i < _innerArray.Count; i++)
            {
                T obj = (T)_innerArray[i];
                if (obj.UniqueID == DBContext.UniqueID)
                {
                    _innerArray.RemoveAt(i);
                    result = true;
                    break;
                }
            }
            return result;
        }
        public virtual bool Contains(T DBContextCollection)
        {
            foreach (T obj in _innerArray)
            {
                if (obj.UniqueID == DBContextCollection.UniqueID) { return true; }
            }
            return false;
        }

        public virtual bool Contains(string dbCatalog, StringComparison compareOptions)
        {
            foreach (T obj in _innerArray)
            {
                int result = String.Compare(obj.DBCatalog, dbCatalog, compareOptions);
                if (result == 0)
                {
                    return true;
                }

            }
            return false;
        }       

        public virtual void Add(T DBContextCollection) { _innerArray.Add(DBContextCollection); }
        public virtual void Clear() { _innerArray.Clear(); }
        public virtual void CopyTo(T[] DBContextCollectionArray, int index)
        {
            throw new Exception("Metodo no valido para esta implementacion");
        }
        public virtual IEnumerator<T> GetEnumerator()
        {
            return new DBContextCollectionEnumerator<T>(this);
        }
        IEnumerator IEnumerable.GetEnumerator()
        {
            return new DBContextCollectionEnumerator<T>(this);
        }
    }

}
/*
   
    public class DBContextCollection : ICollection { 
    
    protected ArrayList _innerArray;
    protected bool _IsReadOnly;
    protected bool _IsSynchronized;
    public DBContextCollection() { this._innerArray = new ArrayList(); }
    public virtual DBContext this[int index] { get { return (DBContext)_innerArray[index]; } set { _innerArray[index] = value; } }
    public virtual int Count { get { return _innerArray.Count; } }
    public virtual bool IsReadOnly { get { return _IsReadOnly; } }
    public virtual bool IsSynchronized { get { return _IsSynchronized; } set { _IsSynchronized = value; } }
    private object _SyncRoot;
    public virtual object SyncRoot { get { return _SyncRoot; } set { _SyncRoot = value; } }
        
        
    public virtual bool Remove(DBContext item)
    {
        bool result = false;
        for (int i = 0; i < _innerArray.Count; i++)
        {
            DBContext obj = (DBContext)_innerArray[i];
            if (obj.UniqueID == item.UniqueID)
            {
                _innerArray.RemoveAt(i);
                result = true;
                break;
            }
        }
        return result;
    }
    public virtual void Add(DBContext item) { _innerArray.Add(item); }
    public virtual void Clear() { _innerArray.Clear(); }

    public virtual bool Contains(string DBCatalog) {

        foreach (DBContext ctx in _innerArray) {
            if (ctx.DBCatalog.ToLowerInvariant() == DBCatalog.ToLowerInvariant()){
                return true;
            }
        }
        return false;
    }
        
    public virtual void CopyTo(Array DBContextCollectionArray, int index)
    {
        //throw new Exception("Metodo no valido para esta implementacion");
        foreach (DBContext db in _innerArray) {
            DBContextCollectionArray.SetValue(db, index);
                index++;            
        }
    }


    public virtual IEnumerator GetEnumerator()
    {
        return _innerArray.GetEnumerator();
        //   return new DBContextCollectionEnumerator<DBContext>(this);
    }
    IEnumerator IEnumerable.GetEnumerator()
    {
        return _innerArray.GetEnumerator();
        //return null; //new DBContextCollectionEnumerator<T>(this);
    }
    
}
    
*/