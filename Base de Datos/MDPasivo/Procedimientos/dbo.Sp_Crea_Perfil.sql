USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Crea_Perfil]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[Sp_Crea_Perfil]
            (      @crear_perfil                CHAR(1)
            ,      @id_sistema                  CHAR(3)
            ,      @codigo_producto             CHAR(5)     
            ,      @codigo_evento               CHAR(5)
            ,      @codigo_moneda1              NUMERIC(5)    
            ,      @codigo_moneda2              NUMERIC(5)
            ,      @codigo_instrumento          CHAR(12)
            ,      @tipo_voucher                CHAR(1)
            ,      @glosa_perfil                CHAR(70)

            ,      @folio_perfil                NUMERIC(5) 
            ,      @correlativo_perfil          NUMERIC(3) 
            ,      @codigo_campo                NUMERIC(3)
            ,      @tipo_movimiento_cuenta      CHAR(1)
            ,      @perfil_fijo                 CHAR(1) 
            ,      @cuenta                      CHAR(12)  

            )


AS 
BEGIN
	SET DATEFORMAT DMY
	SET NOCOUNT ON




      IF @crear_perfil = 'S'
      BEGIN

      --   IF @folio_original > 0
      --      SELECT @folio_perfil = @folio_original
      --   ELSE     
      --      SELECT @folio_perfil = ISNULL(MAX(folio_perfil),0) + 1 FROM PERFIL_CNT
      
         INSERT PERFIL(
                         id_sistema
            ,            codigo_producto
            ,            codigo_evento
            ,            codigo_moneda1
            ,            codigo_moneda2
            ,            codigo_instrumento
            ,            tipo_voucher
            ,            glosa_perfil
            )
        VALUES(
                         @id_sistema
            ,            @codigo_producto
            ,            @codigo_evento
            ,            @codigo_moneda1
            ,            @codigo_moneda2
            ,            @codigo_instrumento
            ,            @tipo_voucher
            ,            @glosa_perfil

         )   

         IF @@ERROR <> 0
         BEGIN
            SET NOCOUNT OFF
            PRINT "ERROR_PROC FALLA AGREGANDO PERFIL."
            SELECT "ERR"
            RETURN 1
         END

      END

            INSERT Perfil_Detalle ( 
                                     id_sistema
                  ,                  codigo_producto
                  ,                  codigo_evento
                  ,                  codigo_moneda1
                  ,                  codigo_moneda2
                  ,                  codigo_instrumento
                  ,                  folio_perfil
                  ,                  correlativo_perfil
                  ,                  codigo_campo
                  ,                  tipo_movimiento_cuenta
                  ,                  perfil_fijo
                  ,                  cuenta
                                 )   
                              
            VALUES(                                
                                     @id_sistema
                  ,                  @codigo_producto
                  ,                  @codigo_evento
                  ,                  @codigo_moneda1
                  ,                  @codigo_moneda2
                  ,                  @codigo_instrumento
                  ,                  @folio_perfil
                  ,                  @correlativo_perfil
                  ,                  @codigo_campo
                  ,                  @tipo_movimiento_cuenta
                  ,                  @perfil_fijo
                  ,                  @cuenta
                  )



   SET NOCOUNT OFF


END      



GO
