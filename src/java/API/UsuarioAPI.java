package API;

import Models.UsuarioDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UsuarioAPI {
    Conection cn = new Conection();    
    Connection conn;
    PreparedStatement pst;
    ResultSet rs;    

    UsuarioDTO us = new UsuarioDTO();
    public UsuarioDTO validarUsurio(String usuario, String password){
        
        String sql = "SELECT * FROM usuarios WHERE Usuario=? and PasswordUser=?";
        
        try{
            conn = cn.getConnection();
            pst = conn.prepareStatement(sql);
            
            pst.setString(1, usuario);
            pst.setString(2, password);
            rs=pst.executeQuery();
            
            while(rs.next()){
                us.setEntityID(rs.getInt("EntityID"));
                us.setPrimerNombre(rs.getString("PrimerNombre"));
                us.setPrimerApellido(rs.getString("PrimerApellido"));
                us.setUsuario(rs.getString("Usuario"));
            }
            
        }catch(Exception e){            
        }        
        return us;
    }
}