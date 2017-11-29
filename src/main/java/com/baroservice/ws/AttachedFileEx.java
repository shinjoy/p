/**
 * AttachedFileEx.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package com.baroservice.ws;

public class AttachedFileEx  implements java.io.Serializable {
    private int fileIndex;

    private java.lang.String fileName;

    private java.lang.String displayFileName;

    private java.lang.String fileURL;

    public AttachedFileEx() {
    }

    public AttachedFileEx(
           int fileIndex,
           java.lang.String fileName,
           java.lang.String displayFileName,
           java.lang.String fileURL) {
           this.fileIndex = fileIndex;
           this.fileName = fileName;
           this.displayFileName = displayFileName;
           this.fileURL = fileURL;
    }


    /**
     * Gets the fileIndex value for this AttachedFileEx.
     * 
     * @return fileIndex
     */
    public int getFileIndex() {
        return fileIndex;
    }


    /**
     * Sets the fileIndex value for this AttachedFileEx.
     * 
     * @param fileIndex
     */
    public void setFileIndex(int fileIndex) {
        this.fileIndex = fileIndex;
    }


    /**
     * Gets the fileName value for this AttachedFileEx.
     * 
     * @return fileName
     */
    public java.lang.String getFileName() {
        return fileName;
    }


    /**
     * Sets the fileName value for this AttachedFileEx.
     * 
     * @param fileName
     */
    public void setFileName(java.lang.String fileName) {
        this.fileName = fileName;
    }


    /**
     * Gets the displayFileName value for this AttachedFileEx.
     * 
     * @return displayFileName
     */
    public java.lang.String getDisplayFileName() {
        return displayFileName;
    }


    /**
     * Sets the displayFileName value for this AttachedFileEx.
     * 
     * @param displayFileName
     */
    public void setDisplayFileName(java.lang.String displayFileName) {
        this.displayFileName = displayFileName;
    }


    /**
     * Gets the fileURL value for this AttachedFileEx.
     * 
     * @return fileURL
     */
    public java.lang.String getFileURL() {
        return fileURL;
    }


    /**
     * Sets the fileURL value for this AttachedFileEx.
     * 
     * @param fileURL
     */
    public void setFileURL(java.lang.String fileURL) {
        this.fileURL = fileURL;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof AttachedFileEx)) return false;
        AttachedFileEx other = (AttachedFileEx) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            this.fileIndex == other.getFileIndex() &&
            ((this.fileName==null && other.getFileName()==null) || 
             (this.fileName!=null &&
              this.fileName.equals(other.getFileName()))) &&
            ((this.displayFileName==null && other.getDisplayFileName()==null) || 
             (this.displayFileName!=null &&
              this.displayFileName.equals(other.getDisplayFileName()))) &&
            ((this.fileURL==null && other.getFileURL()==null) || 
             (this.fileURL!=null &&
              this.fileURL.equals(other.getFileURL())));
        __equalsCalc = null;
        return _equals;
    }

    private boolean __hashCodeCalc = false;
    public synchronized int hashCode() {
        if (__hashCodeCalc) {
            return 0;
        }
        __hashCodeCalc = true;
        int _hashCode = 1;
        _hashCode += getFileIndex();
        if (getFileName() != null) {
            _hashCode += getFileName().hashCode();
        }
        if (getDisplayFileName() != null) {
            _hashCode += getDisplayFileName().hashCode();
        }
        if (getFileURL() != null) {
            _hashCode += getFileURL().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(AttachedFileEx.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("http://ws.baroservice.com/", "AttachedFileEx"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("fileIndex");
        elemField.setXmlName(new javax.xml.namespace.QName("http://ws.baroservice.com/", "FileIndex"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("fileName");
        elemField.setXmlName(new javax.xml.namespace.QName("http://ws.baroservice.com/", "FileName"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("displayFileName");
        elemField.setXmlName(new javax.xml.namespace.QName("http://ws.baroservice.com/", "DisplayFileName"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("fileURL");
        elemField.setXmlName(new javax.xml.namespace.QName("http://ws.baroservice.com/", "FileURL"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setMinOccurs(0);
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
    }

    /**
     * Return type metadata object
     */
    public static org.apache.axis.description.TypeDesc getTypeDesc() {
        return typeDesc;
    }

    /**
     * Get Custom Serializer
     */
    public static org.apache.axis.encoding.Serializer getSerializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanSerializer(
            _javaType, _xmlType, typeDesc);
    }

    /**
     * Get Custom Deserializer
     */
    public static org.apache.axis.encoding.Deserializer getDeserializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanDeserializer(
            _javaType, _xmlType, typeDesc);
    }

}
