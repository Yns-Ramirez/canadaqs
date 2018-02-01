// ORM class for table 'null'
// WARNING: This class is AUTO-GENERATED. Modify at your own risk.
//
// Debug information:
// Generated date: Wed Nov 29 13:11:58 CST 2017
// For connector: org.apache.sqoop.manager.GenericJdbcManager
import org.apache.hadoop.io.BytesWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.io.Writable;
import org.apache.hadoop.mapred.lib.db.DBWritable;
import com.cloudera.sqoop.lib.JdbcWritableBridge;
import com.cloudera.sqoop.lib.DelimiterSet;
import com.cloudera.sqoop.lib.FieldFormatter;
import com.cloudera.sqoop.lib.RecordParser;
import com.cloudera.sqoop.lib.BooleanParser;
import com.cloudera.sqoop.lib.BlobRef;
import com.cloudera.sqoop.lib.ClobRef;
import com.cloudera.sqoop.lib.LargeObjectLoader;
import com.cloudera.sqoop.lib.SqoopRecord;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.io.DataInput;
import java.io.DataOutput;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

public class QueryResult extends SqoopRecord  implements DBWritable, Writable {
  private final int PROTOCOL_VERSION = 3;
  public int getClassFormatVersion() { return PROTOCOL_VERSION; }
  public static interface FieldSetterCommand {    void setField(Object value);  }  protected ResultSet __cur_result_set;
  private Map<String, FieldSetterCommand> setters = new HashMap<String, FieldSetterCommand>();
  private void init0() {
    setters.put("ingresoId", new FieldSetterCommand() {
      @Override
      public void setField(Object value) {
        ingresoId = (Integer)value;
      }
    });
    setters.put("categoriaId", new FieldSetterCommand() {
      @Override
      public void setField(Object value) {
        categoriaId = (Integer)value;
      }
    });
    setters.put("porcentaje", new FieldSetterCommand() {
      @Override
      public void setField(Object value) {
        porcentaje = (java.math.BigDecimal)value;
      }
    });
    setters.put("timestamp", new FieldSetterCommand() {
      @Override
      public void setField(Object value) {
        timestamp = (org.apache.hadoop.io.BytesWritable)value;
      }
    });
    setters.put("agency", new FieldSetterCommand() {
      @Override
      public void setField(Object value) {
        agency = (String)value;
      }
    });
  }
  public QueryResult() {
    init0();
  }
  private Integer ingresoId;
  public Integer get_ingresoId() {
    return ingresoId;
  }
  public void set_ingresoId(Integer ingresoId) {
    this.ingresoId = ingresoId;
  }
  public QueryResult with_ingresoId(Integer ingresoId) {
    this.ingresoId = ingresoId;
    return this;
  }
  private Integer categoriaId;
  public Integer get_categoriaId() {
    return categoriaId;
  }
  public void set_categoriaId(Integer categoriaId) {
    this.categoriaId = categoriaId;
  }
  public QueryResult with_categoriaId(Integer categoriaId) {
    this.categoriaId = categoriaId;
    return this;
  }
  private java.math.BigDecimal porcentaje;
  public java.math.BigDecimal get_porcentaje() {
    return porcentaje;
  }
  public void set_porcentaje(java.math.BigDecimal porcentaje) {
    this.porcentaje = porcentaje;
  }
  public QueryResult with_porcentaje(java.math.BigDecimal porcentaje) {
    this.porcentaje = porcentaje;
    return this;
  }
  private org.apache.hadoop.io.BytesWritable timestamp;
  public org.apache.hadoop.io.BytesWritable get_timestamp() {
    return timestamp;
  }
  public void set_timestamp(org.apache.hadoop.io.BytesWritable timestamp) {
    this.timestamp = timestamp;
  }
  public QueryResult with_timestamp(org.apache.hadoop.io.BytesWritable timestamp) {
    this.timestamp = timestamp;
    return this;
  }
  private String agency;
  public String get_agency() {
    return agency;
  }
  public void set_agency(String agency) {
    this.agency = agency;
  }
  public QueryResult with_agency(String agency) {
    this.agency = agency;
    return this;
  }
  public boolean equals(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof QueryResult)) {
      return false;
    }
    QueryResult that = (QueryResult) o;
    boolean equal = true;
    equal = equal && (this.ingresoId == null ? that.ingresoId == null : this.ingresoId.equals(that.ingresoId));
    equal = equal && (this.categoriaId == null ? that.categoriaId == null : this.categoriaId.equals(that.categoriaId));
    equal = equal && (this.porcentaje == null ? that.porcentaje == null : this.porcentaje.equals(that.porcentaje));
    equal = equal && (this.timestamp == null ? that.timestamp == null : this.timestamp.equals(that.timestamp));
    equal = equal && (this.agency == null ? that.agency == null : this.agency.equals(that.agency));
    return equal;
  }
  public boolean equals0(Object o) {
    if (this == o) {
      return true;
    }
    if (!(o instanceof QueryResult)) {
      return false;
    }
    QueryResult that = (QueryResult) o;
    boolean equal = true;
    equal = equal && (this.ingresoId == null ? that.ingresoId == null : this.ingresoId.equals(that.ingresoId));
    equal = equal && (this.categoriaId == null ? that.categoriaId == null : this.categoriaId.equals(that.categoriaId));
    equal = equal && (this.porcentaje == null ? that.porcentaje == null : this.porcentaje.equals(that.porcentaje));
    equal = equal && (this.timestamp == null ? that.timestamp == null : this.timestamp.equals(that.timestamp));
    equal = equal && (this.agency == null ? that.agency == null : this.agency.equals(that.agency));
    return equal;
  }
  public void readFields(ResultSet __dbResults) throws SQLException {
    this.__cur_result_set = __dbResults;
    this.ingresoId = JdbcWritableBridge.readInteger(1, __dbResults);
    this.categoriaId = JdbcWritableBridge.readInteger(2, __dbResults);
    this.porcentaje = JdbcWritableBridge.readBigDecimal(3, __dbResults);
    this.timestamp = JdbcWritableBridge.readBytesWritable(4, __dbResults);
    this.agency = JdbcWritableBridge.readString(5, __dbResults);
  }
  public void readFields0(ResultSet __dbResults) throws SQLException {
    this.ingresoId = JdbcWritableBridge.readInteger(1, __dbResults);
    this.categoriaId = JdbcWritableBridge.readInteger(2, __dbResults);
    this.porcentaje = JdbcWritableBridge.readBigDecimal(3, __dbResults);
    this.timestamp = JdbcWritableBridge.readBytesWritable(4, __dbResults);
    this.agency = JdbcWritableBridge.readString(5, __dbResults);
  }
  public void loadLargeObjects(LargeObjectLoader __loader)
      throws SQLException, IOException, InterruptedException {
  }
  public void loadLargeObjects0(LargeObjectLoader __loader)
      throws SQLException, IOException, InterruptedException {
  }
  public void write(PreparedStatement __dbStmt) throws SQLException {
    write(__dbStmt, 0);
  }

  public int write(PreparedStatement __dbStmt, int __off) throws SQLException {
    JdbcWritableBridge.writeInteger(ingresoId, 1 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(categoriaId, 2 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(porcentaje, 3 + __off, 2, __dbStmt);
    JdbcWritableBridge.writeBytesWritable(timestamp, 4 + __off, -3, __dbStmt);
    JdbcWritableBridge.writeString(agency, 5 + __off, 12, __dbStmt);
    return 5;
  }
  public void write0(PreparedStatement __dbStmt, int __off) throws SQLException {
    JdbcWritableBridge.writeInteger(ingresoId, 1 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeInteger(categoriaId, 2 + __off, 4, __dbStmt);
    JdbcWritableBridge.writeBigDecimal(porcentaje, 3 + __off, 2, __dbStmt);
    JdbcWritableBridge.writeBytesWritable(timestamp, 4 + __off, -3, __dbStmt);
    JdbcWritableBridge.writeString(agency, 5 + __off, 12, __dbStmt);
  }
  public void readFields(DataInput __dataIn) throws IOException {
this.readFields0(__dataIn);  }
  public void readFields0(DataInput __dataIn) throws IOException {
    if (__dataIn.readBoolean()) { 
        this.ingresoId = null;
    } else {
    this.ingresoId = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.categoriaId = null;
    } else {
    this.categoriaId = Integer.valueOf(__dataIn.readInt());
    }
    if (__dataIn.readBoolean()) { 
        this.porcentaje = null;
    } else {
    this.porcentaje = com.cloudera.sqoop.lib.BigDecimalSerializer.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.timestamp = null;
    } else {
    this.timestamp = new BytesWritable();
    this.timestamp.readFields(__dataIn);
    }
    if (__dataIn.readBoolean()) { 
        this.agency = null;
    } else {
    this.agency = Text.readString(__dataIn);
    }
  }
  public void write(DataOutput __dataOut) throws IOException {
    if (null == this.ingresoId) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.ingresoId);
    }
    if (null == this.categoriaId) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.categoriaId);
    }
    if (null == this.porcentaje) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.porcentaje, __dataOut);
    }
    if (null == this.timestamp) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    this.timestamp.write(__dataOut);
    }
    if (null == this.agency) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, agency);
    }
  }
  public void write0(DataOutput __dataOut) throws IOException {
    if (null == this.ingresoId) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.ingresoId);
    }
    if (null == this.categoriaId) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    __dataOut.writeInt(this.categoriaId);
    }
    if (null == this.porcentaje) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    com.cloudera.sqoop.lib.BigDecimalSerializer.write(this.porcentaje, __dataOut);
    }
    if (null == this.timestamp) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    this.timestamp.write(__dataOut);
    }
    if (null == this.agency) { 
        __dataOut.writeBoolean(true);
    } else {
        __dataOut.writeBoolean(false);
    Text.writeString(__dataOut, agency);
    }
  }
  private static final DelimiterSet __outputDelimiters = new DelimiterSet((char) 1, (char) 10, (char) 0, (char) 0, false);
  public String toString() {
    return toString(__outputDelimiters, true);
  }
  public String toString(DelimiterSet delimiters) {
    return toString(delimiters, true);
  }
  public String toString(boolean useRecordDelim) {
    return toString(__outputDelimiters, useRecordDelim);
  }
  public String toString(DelimiterSet delimiters, boolean useRecordDelim) {
    StringBuilder __sb = new StringBuilder();
    char fieldDelim = delimiters.getFieldsTerminatedBy();
    __sb.append(FieldFormatter.escapeAndEnclose(ingresoId==null?"null":"" + ingresoId, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(categoriaId==null?"null":"" + categoriaId, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(porcentaje==null?"null":porcentaje.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(timestamp==null?"null":"" + timestamp, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(agency==null?"null":agency, delimiters));
    if (useRecordDelim) {
      __sb.append(delimiters.getLinesTerminatedBy());
    }
    return __sb.toString();
  }
  public void toString0(DelimiterSet delimiters, StringBuilder __sb, char fieldDelim) {
    __sb.append(FieldFormatter.escapeAndEnclose(ingresoId==null?"null":"" + ingresoId, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(categoriaId==null?"null":"" + categoriaId, delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(porcentaje==null?"null":porcentaje.toPlainString(), delimiters));
    __sb.append(fieldDelim);
    __sb.append(FieldFormatter.escapeAndEnclose(timestamp==null?"null":"" + timestamp, delimiters));
    __sb.append(fieldDelim);
    // special case for strings hive, droppingdelimiters \n,\r,\01 from strings
    __sb.append(FieldFormatter.hiveStringDropDelims(agency==null?"null":agency, delimiters));
  }
  private static final DelimiterSet __inputDelimiters = new DelimiterSet((char) 1, (char) 10, (char) 0, (char) 0, false);
  private RecordParser __parser;
  public void parse(Text __record) throws RecordParser.ParseError {
    if (null == this.__parser) {
      this.__parser = new RecordParser(__inputDelimiters);
    }
    List<String> __fields = this.__parser.parseRecord(__record);
    __loadFromFields(__fields);
  }

  public void parse(CharSequence __record) throws RecordParser.ParseError {
    if (null == this.__parser) {
      this.__parser = new RecordParser(__inputDelimiters);
    }
    List<String> __fields = this.__parser.parseRecord(__record);
    __loadFromFields(__fields);
  }

  public void parse(byte [] __record) throws RecordParser.ParseError {
    if (null == this.__parser) {
      this.__parser = new RecordParser(__inputDelimiters);
    }
    List<String> __fields = this.__parser.parseRecord(__record);
    __loadFromFields(__fields);
  }

  public void parse(char [] __record) throws RecordParser.ParseError {
    if (null == this.__parser) {
      this.__parser = new RecordParser(__inputDelimiters);
    }
    List<String> __fields = this.__parser.parseRecord(__record);
    __loadFromFields(__fields);
  }

  public void parse(ByteBuffer __record) throws RecordParser.ParseError {
    if (null == this.__parser) {
      this.__parser = new RecordParser(__inputDelimiters);
    }
    List<String> __fields = this.__parser.parseRecord(__record);
    __loadFromFields(__fields);
  }

  public void parse(CharBuffer __record) throws RecordParser.ParseError {
    if (null == this.__parser) {
      this.__parser = new RecordParser(__inputDelimiters);
    }
    List<String> __fields = this.__parser.parseRecord(__record);
    __loadFromFields(__fields);
  }

  private void __loadFromFields(List<String> fields) {
    Iterator<String> __it = fields.listIterator();
    String __cur_str = null;
    try {
    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.ingresoId = null; } else {
      this.ingresoId = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.categoriaId = null; } else {
      this.categoriaId = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.porcentaje = null; } else {
      this.porcentaje = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.timestamp = null; } else {
      String[] strByteVal = __cur_str.trim().split(" ");
      byte [] byteVal = new byte[strByteVal.length];
      for (int i = 0; i < byteVal.length; ++i) {
          byteVal[i] = (byte)Integer.parseInt(strByteVal[i], 16);
      }
      this.timestamp = new BytesWritable(byteVal);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.agency = null; } else {
      this.agency = __cur_str;
    }

    } catch (RuntimeException e) {    throw new RuntimeException("Can't parse input data: '" + __cur_str + "'", e);    }  }

  private void __loadFromFields0(Iterator<String> __it) {
    String __cur_str = null;
    try {
    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.ingresoId = null; } else {
      this.ingresoId = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.categoriaId = null; } else {
      this.categoriaId = Integer.valueOf(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.porcentaje = null; } else {
      this.porcentaje = new java.math.BigDecimal(__cur_str);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N") || __cur_str.length() == 0) { this.timestamp = null; } else {
      String[] strByteVal = __cur_str.trim().split(" ");
      byte [] byteVal = new byte[strByteVal.length];
      for (int i = 0; i < byteVal.length; ++i) {
          byteVal[i] = (byte)Integer.parseInt(strByteVal[i], 16);
      }
      this.timestamp = new BytesWritable(byteVal);
    }

    __cur_str = __it.next();
    if (__cur_str.equals("\\N")) { this.agency = null; } else {
      this.agency = __cur_str;
    }

    } catch (RuntimeException e) {    throw new RuntimeException("Can't parse input data: '" + __cur_str + "'", e);    }  }

  public Object clone() throws CloneNotSupportedException {
    QueryResult o = (QueryResult) super.clone();
    o.timestamp = (o.timestamp != null) ? new BytesWritable(Arrays.copyOf(timestamp.getBytes(), timestamp.getLength())) : null;
    return o;
  }

  public void clone0(QueryResult o) throws CloneNotSupportedException {
    o.timestamp = (o.timestamp != null) ? new BytesWritable(Arrays.copyOf(timestamp.getBytes(), timestamp.getLength())) : null;
  }

  public Map<String, Object> getFieldMap() {
    Map<String, Object> __sqoop$field_map = new HashMap<String, Object>();
    __sqoop$field_map.put("ingresoId", this.ingresoId);
    __sqoop$field_map.put("categoriaId", this.categoriaId);
    __sqoop$field_map.put("porcentaje", this.porcentaje);
    __sqoop$field_map.put("timestamp", this.timestamp);
    __sqoop$field_map.put("agency", this.agency);
    return __sqoop$field_map;
  }

  public void getFieldMap0(Map<String, Object> __sqoop$field_map) {
    __sqoop$field_map.put("ingresoId", this.ingresoId);
    __sqoop$field_map.put("categoriaId", this.categoriaId);
    __sqoop$field_map.put("porcentaje", this.porcentaje);
    __sqoop$field_map.put("timestamp", this.timestamp);
    __sqoop$field_map.put("agency", this.agency);
  }

  public void setField(String __fieldName, Object __fieldVal) {
    if (!setters.containsKey(__fieldName)) {
      throw new RuntimeException("No such field:"+__fieldName);
    }
    setters.get(__fieldName).setField(__fieldVal);
  }

}
