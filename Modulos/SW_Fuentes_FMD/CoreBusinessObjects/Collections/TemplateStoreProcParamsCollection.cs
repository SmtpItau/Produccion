#pragma warning disable 1591
using System;
using System.Collections;
using System.Collections.Generic;
using CoreBusinessObjects.DTO;

namespace CoreBusinessObjects.Collections
{
   
    /// <summary>
    /// Enumerador de TemplateStoreProcParams
    /// </summary>
    /// <typeparam name="T"></typeparam>    
    public class TemplateStoreProcParamsEnumerator<T>
        : IEnumerator<T> where T : TemplateStoreProcParams
    {
        protected TemplateStoreProcParamsCollection<T> _collection; //coleccion enumerada
        protected int index; //current index
        protected T _current; // current enumerated object in the collection
        public TemplateStoreProcParamsEnumerator() { }
        public TemplateStoreProcParamsEnumerator(TemplateStoreProcParamsCollection<T> collection) { _collection = collection; index = -1; _current = default(T); }
        public virtual T Current { get { return _current; } }
        object IEnumerator.Current { get { return _current; } }
        public virtual void Dispose() { _collection = null; _current = default(T); index = -1; }
        public virtual bool MoveNext() { if (++index >= _collection.Count) { return false; } else { _current = _collection[index]; } return true; }
        public virtual void Reset() { _current = default(T); index = -1; }
    }

    /// <summary>
    /// Coleccion de Objetos TemplateStoreProcParams
    /// </summary>
    /// <typeparam name="T"></typeparam>        
    public class TemplateStoreProcParamsCollection<T>
        : ICollection<T> where T : TemplateStoreProcParams
    {        
        protected ArrayList _innerArray;
        protected bool _IsReadOnly;
        public TemplateStoreProcParamsCollection() { this._innerArray = new ArrayList(); }
        public virtual T this[int index] { get { return (T)_innerArray[index]; } set { _innerArray[index] = value; } }
        
        /// <summary>
        /// Retorna un objeto TemplateStoreProcParams por el nombre del parametro
        /// </summary>
        /// <param name="ParameterName">Nombre del parametro</param>
        /// <returns>TemplateStoreProcParams</returns>
        public virtual T this[string ParameterName]
        {
            get
            {
                foreach (T item in _innerArray)
                {
                    if (item.ParameterName == ParameterName)
                    {
                        return (T)item;
                    }
                }
                return null;
            }
        }
        
        
        public virtual int Count { get { return _innerArray.Count; } }
        public virtual bool IsReadOnly { get { return _IsReadOnly; } }
        public virtual bool Remove(T TemplateStoreProcParams)
        {
            bool result = false;
            for (int i = 0; i < _innerArray.Count; i++)
            {
                T obj = (T)_innerArray[i];
                if (obj.UniqueID == TemplateStoreProcParams.UniqueID)
                {
                    _innerArray.RemoveAt(i);
                    result = true;
                    break;
                }
            }
            return result;
        }
        public virtual bool Contains(T TemplateStoreProcParams)
        {
            foreach (T obj in _innerArray)
            {
                if (obj.UniqueID == TemplateStoreProcParams.UniqueID) { return true; }
            }
            return false;
        }

        public virtual bool Contains(string ParameterName, StringComparison compareOptions)
        {
            foreach (T obj in _innerArray)
            {
                int result = String.Compare(obj.ParameterName, ParameterName, compareOptions);
                if (result == 0) { 
                    return true;
                }

            }
            return false;
        }
        public virtual void Add(T TemplateStoreProcParams) { _innerArray.Add(TemplateStoreProcParams); }
        public virtual void Clear() { _innerArray.Clear(); }
        public virtual void CopyTo(T[] TemplateDataAddressArray, int index)
        {
            throw new Exception("Metodo no valido para esta implementacion");
        }
        public virtual IEnumerator<T> GetEnumerator()
        {
            return new TemplateStoreProcParamsEnumerator<T>(this);
        }
        IEnumerator IEnumerable.GetEnumerator()
        {
            return new TemplateStoreProcParamsEnumerator<T>(this);
        }
    }

}
