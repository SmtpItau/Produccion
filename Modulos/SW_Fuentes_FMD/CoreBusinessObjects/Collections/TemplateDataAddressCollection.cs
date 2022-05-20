#pragma warning disable 1591
using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Text;
using CoreBusinessObjects.DTO;

namespace CoreBusinessObjects.Collections
{
   
    /// <summary>
    /// Enumerador de TemplateDataAddress
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public class TemplateDataAddressEnumerator<T>
        : IEnumerator<T> where T : TemplateDataAddress
    {
        protected TemplateDataAddressCollection<T> _collection; //coleccion enumerada
        protected int index; //current index
        protected T _current; // current enumerated object in the collection
        public TemplateDataAddressEnumerator() { }
        public TemplateDataAddressEnumerator(TemplateDataAddressCollection<T> collection) { _collection = collection; index = -1; _current = default(T); }
        public virtual T Current { get { return _current; } }
        object IEnumerator.Current { get { return _current; } }
        public virtual void Dispose() { _collection = null; _current = default(T); index = -1; }
        public virtual bool MoveNext() { if (++index >= _collection.Count) { return false; } else { _current = _collection[index]; } return true; }
        public virtual void Reset() { _current = default(T); index = -1; }
    }

    /// <summary>
    /// Coleccion de Objetos TemplateAddress
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public class TemplateDataAddressCollection<T>
        : ICollection<T> where T : TemplateDataAddress
    {
        protected ArrayList _innerArray;
        protected bool _IsReadOnly;
        public TemplateDataAddressCollection() { this._innerArray = new ArrayList(); }
        public virtual T this[int index] { get { return (T)_innerArray[index]; } set { _innerArray[index] = value; } }

        public virtual T this[string ValueMember] {
            get {
                foreach (T item in _innerArray) {
                    if (item.ValueMember == ValueMember) {
                        return (T)item;
                    }
                }
                return null;
            }        
        }


        
        
        public virtual int Count { get { return _innerArray.Count; } }
        public virtual bool IsReadOnly { get { return _IsReadOnly; } }
        public virtual bool Remove(T TemplateDataAddress)
        {
            bool result = false;
            for (int i = 0; i < _innerArray.Count; i++)
            {
                T obj = (T)_innerArray[i];
                if (obj.UniqueID == TemplateDataAddress.UniqueID)
                {
                    _innerArray.RemoveAt(i);
                    result = true;
                    break;
                }
            }
            return result;
        }
        
        public virtual bool Contains(T TemplateDataAddress)
        {
            foreach (T obj in _innerArray)
            {
                if (obj.UniqueID == TemplateDataAddress.UniqueID) { return true; }
            }
            return false;
        }
        public virtual bool Contains(string columnName,StringComparison compareOptions) {
            foreach (T obj in _innerArray)
            {
                int result = String.Compare(obj.ColumnName, columnName, compareOptions);
                if (result == 0) { 
                    return true;
                }

            }
            return false;
        }
        
        public virtual void Add(T TemplateDataAddress) { _innerArray.Add(TemplateDataAddress); }
        
        public virtual void AddRange(T[] TemplateDataAddressArray) {
            _innerArray.AddRange((ICollection)TemplateDataAddressArray);        
        }

        public virtual void Clear() { _innerArray.Clear(); }
        public virtual void CopyTo(T[] TemplateDataAddressArray, int index)
        {
            throw new Exception("Metodo no valido para esta implementacion");
        }
        public virtual IEnumerator<T> GetEnumerator()
        {            
            return new TemplateDataAddressEnumerator<T>(this);
        }
        IEnumerator IEnumerable.GetEnumerator()
        {         
            return new TemplateDataAddressEnumerator<T>(this);
        }
    }

}
