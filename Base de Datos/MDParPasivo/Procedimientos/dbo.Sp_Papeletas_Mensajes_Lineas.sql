USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Papeletas_Mensajes_Lineas]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Papeletas_Mensajes_Lineas]
   (   @nNum_Opera   NUMERIC(9)
   ,   @cSistema     CHAR(3)
   ,   @cMargen_1    CHAR(100) OUTPUT
   ,   @cMargen_2    CHAR(100) OUTPUT
   ,   @cTraspaso_1  CHAR(100) OUTPUT
   ,   @cTraspaso_2  CHAR(100) OUTPUT
   ,   @cSobreGiro_1 CHAR(100) OUTPUT
   ,   @cSobreGiro_2 CHAR(100) OUTPUT
   )
AS
BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT dmy

   IF EXISTS(SELECT 1 FROM VIEW_LINEA_AUTORIZACION WHERE NumeroOperacion = @nNum_Opera AND codigo_excepcion = 'M' AND Id_Sistema = @cSistema AND Rut_Cliente <> 0 )
   BEGIN
      SELECT @cMargen_1 = 'OPERACION EXCEDE MARGEN DE ATRIBUCIONES DEL OPERADOR'
      SELECT @cSobreGiro_2 = 'AUTORIZADA POR: ' + (SELECT UsuarioAutorizo FROM VIEW_LINEA_AUTORIZACION  WHERE NumeroOperacion = @nNum_Opera AND codigo_excepcion = 'M' AND Id_Sistema = @cSistema AND Rut_Cliente <> 0 GROUP BY UsuarioAutorizo )
   END


   IF EXISTS(SELECT 1 FROM VIEW_LINEA_AUTORIZACION WHERE NumeroOperacion = @nNum_Opera AND codigo_excepcion = 'E' AND Id_Sistema = @cSistema AND Rut_Cliente <> 0)
   BEGIN
         SELECT @cMargen_2 = 'CONVOCA A COMITE DE CREDITO DE TURNO'
         SELECT @cSobreGiro_2 = 'AUTORIZADO POR: ' + (SELECT UsuarioAutorizo FROM VIEW_LINEA_AUTORIZACION  WHERE NumeroOperacion = @nNum_Opera AND codigo_excepcion = 'E' AND Id_Sistema = @cSistema AND Rut_Cliente <> 0 GROUP BY UsuarioAutorizo  )
   END   

   IF EXISTS(SELECT 1 FROM VIEW_LINEA_AUTORIZACION WHERE NumeroOperacion = @nNum_Opera AND codigo_excepcion = 'T' AND Id_Sistema = @cSistema AND Rut_Cliente <> 0)
   BEGIN
      IF @cMargen_1 = ''
      BEGIN
         SELECT @cMargen_1 = 'CLIENTE SOLICITO TRASPASO DE LINEA PARA CURSAR OPERACION'
         SELECT @cSobreGiro_2 = 'TRASPASO AUTORIZADO POR: ' + (SELECT UsuarioAutorizo FROM VIEW_LINEA_AUTORIZACION  WHERE NumeroOperacion = @nNum_Opera AND codigo_excepcion = 'T' AND Id_Sistema = @cSistema AND Rut_Cliente <> 0 GROUP BY UsuarioAutorizo  )
      END ELSE
      BEGIN 
         SELECT @cTraspaso_1 = 'CLIENTE SOLICITO TRASPASO DE LINEA PARA CURSAR OPERACION'
         SELECT @cSobreGiro_2  = 'AUTORIZADO POR: ' + (SELECT UsuarioAutorizo FROM VIEW_LINEA_AUTORIZACION  WHERE NumeroOperacion = @nNum_Opera AND codigo_excepcion = 'T' AND Id_Sistema = @cSistema AND Rut_Cliente <> 0 GROUP BY UsuarioAutorizo  )
      END
   END   

   IF EXISTS(SELECT 1 FROM VIEW_LINEA_AUTORIZACION WHERE NumeroOperacion = @nNum_Opera AND codigo_excepcion = 'S' AND Id_Sistema = @cSistema AND Rut_Cliente <> 0 )
   BEGIN
      IF @cMargen_1 =''
      BEGIN
         SELECT @cMargen_1  = 'SOBREGIRO POR MATRIZ DE FACULTADES CREDITICIAS'--'CLIENTE SOLICITO SOBREGIRO DE LINEA PARA CURSAR OPERACION'
         SELECT @cSobreGiro_2   = 'AUTORIZADO POR: ' + (SELECT UsuarioAutorizo FROM VIEW_LINEA_AUTORIZACION WHERE NumeroOperacion = @nNum_Opera AND codigo_excepcion = 'S' AND Id_Sistema = @cSistema AND Rut_Cliente <> 0 GROUP BY UsuarioAutorizo  )
      END ELSE
      BEGIN
         IF @cTraspaso_1 = ''
         BEGIN
            SELECT @cTraspaso_1  = 'SOBREGIRO POR MATRIZ DE FACULTADES CREDITICIAS'
            SELECT @cSobreGiro_2   = 'AUTORIZADO POR: ' + (SELECT UsuarioAutorizo FROM VIEW_LINEA_AUTORIZACION WHERE NumeroOperacion = @nNum_Opera AND codigo_excepcion = 'S' AND Id_Sistema = @cSistema AND Rut_Cliente <> 0 GROUP BY UsuarioAutorizo 
 )
         END ELSE
         BEGIN
            SELECT @cSobreGiro_1 = 'SOBREGIRO POR MATRIZ DE FACULTADES CREDITICIAS'
            SELECT @cSobreGiro_2 = 'AUTORIZADO POR: ' + (SELECT UsuarioAutorizo FROM VIEW_LINEA_AUTORIZACION WHERE NumeroOperacion = @nNum_Opera AND codigo_excepcion = 'S' AND Id_Sistema = @cSistema AND Rut_Cliente <> 0 GROUP BY UsuarioAutorizo 
  )
         END
      END
   END 

   SET NOCOUNT OFF
END

GO
