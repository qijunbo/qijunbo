三种执行SQL语句的的JAVA代码
--

1.简单的Statement执行SQL语句。有SQL注入，一般不使用。


```java
public static void testStatement() throws Exception{
    Statement stm = null;
    ResultSet rs = null;
    DataBaseConn con = new DataBaseConn();
    try{
        stm = con.getMssqlConn().createStatement();
        rs = stm.executeQuery("select top 1 * from tfixitem");
        if(rs.next()){
            System.out.println("testStatement测试，FIXITEM_CODE = " + rs.getString("FIXITEM_CODE"));
        }
        con.closeCon();
    }catch(Exception e){
        System.out.println(e.getMessage());
        e.printStackTrace();
    }
}

```
2.防止SQL注入的PreparedStatement执行SQL语句。

```java

public static void testPreparedStatement(){
        PreparedStatement pstm = null;
        ResultSet rs = null;
        DataBaseConn con = new DataBaseConn();
        try{
            pstm = con.getMssqlConn().prepareStatement("select * from tfixitem where fixitem_id = ?");
            pstm.setInt(1, 2);
            rs = pstm.executeQuery();
            if(rs.next()){
                System.out.println("testPreparedStatement测试，FIXITEM_CODE = " + rs.getString("FIXITEM_CODE"));
            }
        }catch(Exception e){
            e.printStackTrace();
        }
    }

```

3.执行存储过程的CallableStatement执行存储过程SQL


```java
public static void testCallableStatement(){
        CallableStatement cstm = null;
        ResultSet rs = null;
        DataBaseConn con = new DataBaseConn();
        try{
            cstm = con.getMssqlConn().prepareCall("{call SP_QUERY_TFIXITEM(?,?,?,?,?,?,?,?)}");
            cstm.setInt(1, 2);
            cstm.setInt(2, 1);
            cstm.setInt(3, 0);
            cstm.setInt(4, 0);
            cstm.setString(5, "");
            cstm.setString(6, "");
            cstm.setString(7, "");
            cstm.setInt(8, 0);
            rs = cstm.executeQuery();
            if(rs.next()){
                System.out.println("testCallableStatement测试，FIXITEM_CODE = " + rs.getString("FIXITEM_CODE"));
            }
        }catch(Exception e){
            e.printStackTrace();
        }
    }

```


Reference:
--

https://www.cnblogs.com/atp-sir/p/6165088.html