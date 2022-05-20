#pragma warning disable 1591
using System;
using System.Collections;
using System.Collections.Generic;
using CoreBusinessObjects.DTO;

namespace CoreBusinessObjects.Collections
{

    /// <summary>
    /// Enumerador de TemplateDataAddress
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public class TemplateDataEnumerator<T>
        : IEnumerator<T> where T : TemplateData
    {
        protected TemplateDataCollection<T> _collection; //coleccion enumerada
        protected int index; //current index
        protected T _current; // current enumerated object in the collection
        public TemplateDataEnumerator() { }
        public TemplateDataEnumerator(TemplateDataCollection<T> collection) { _collection = collection; index = -1; _current = default(T); }
        public virtual T Current { get { return _current; } }
        object IEnumerator.Current { get { return _current; } }
        public virtual void Dispose() { _collection = null; _current = default(T); index = -1; }
        public virtual bool MoveNext() { if (++index >= _collection.Count) { return false; } else { _current = _collection[index]; } return true; }
        public virtual void Reset() { _current = default(T); index = -1; }
    }

    /// <summary>
    /// Coleccion de Objetos TemplateData
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public class TemplateDataCollection<T>
        : ICollection<T> where T : TemplateData
    {
        protected ArrayList _innerArray;
        protected bool _IsReadOnly;
        public TemplateDataCollection() { this._innerArray = new ArrayList(); }
        public virtual T this[int index] { get { return (T)_innerArray[index]; } set { _innerArray[index] = value; } }
        public virtual T this[string TemplateName] {
            get {
                foreach (T TData in _innerArray) {
                    if (TData.TemplateName == TemplateName) {
                        return (T)TData;
                    }
                }
                return null;
            }
            set {
                foreach (T TData in _innerArray)
                {
                    if (TData.TemplateName == TemplateName)
                    {
                        this.Remove(TData);
                        this.Add(value);
                    }
                }                        
            }
        }
        public virtual int Count { get { return _innerArray.Count; } }
        public virtual bool IsReadOnly { get { return _IsReadOnly; } }
        public virtual bool Remove(T TemplateData)
        {
            bool result = false;
            for (int i = 0; i < _innerArray.Count; i++)
            {
                T obj = (T)_innerArray[i];
                if (obj.UniqueID == TemplateData.UniqueID)
                {
                    _innerArray.RemoveAt(i);
                    result = true;
                    break;
                }
            }
            return result;
        }
        public virtual bool Contains(T TemplateData)
        {
            foreach (T obj in _innerArray)
            {
                if (obj.UniqueID == TemplateData.UniqueID) { return true; }
            }
            return false;
        }

        public virtual bool Contains(string templateName, StringComparison compareOptions)
        {
            foreach (T obj in _innerArray)
            {
                int result = String.Compare(obj.TemplateName, templateName, compareOptions);
                if (result == 0)
                {
                    return true;
                }

            }
            return false;
        }


        public virtual void Add(T TemplateData) { _innerArray.Add(TemplateData); }
        public virtual void Clear() { _innerArray.Clear(); }
        public virtual void CopyTo(T[] TemplateDataArray, int index)
        {
            throw new Exception("Metodo no valido para esta implementacion");
        }
        public virtual IEnumerator<T> GetEnumerator()
        {
            return new TemplateDataEnumerator<T>(this);
        }
        IEnumerator IEnumerable.GetEnumerator()
        {
            return new TemplateDataEnumerator<T>(this);
        }
    }

}
