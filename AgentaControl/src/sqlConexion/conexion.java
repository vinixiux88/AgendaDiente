
package sqlConexion;

import java.sql.*;
import javax.swing.JOptionPane;

public class conexion {
    Connection conect = null;
    
    public Connection conexion(){
        try{
            Class.forName("org.gjt.mm.mysql.Driver");
            conect = DriverManager.getConnection("jdbc:mysql://localhost/bdVinicioGay","root","");
        }catch(Exception e){
            JOptionPane.showMessageDialog(null, "error en la conexion a la Base de Datos");
        }
    return conect;
}
    
}
