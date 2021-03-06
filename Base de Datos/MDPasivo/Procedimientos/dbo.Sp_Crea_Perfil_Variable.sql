USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Crea_Perfil_Variable]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[Sp_Crea_Perfil_Variable]
            (      @id_sistema                  CHAR(3)
            ,      @codigo_producto             CHAR(5)     
            ,      @codigo_evento               CHAR(5)
            ,      @codigo_moneda1              NUMERIC(5)    
            ,      @codigo_moneda2              NUMERIC(5)
            ,      @codigo_instrumento          CHAR(12)
            ,      @folio_perfil                NUMERIC(3) 
            ,      @correlativo_perfil          NUMERIC(5)
            ,      @codigo_campo                NUMERIC(3)
            ,      @codigo_condicion            VARCHAR(30)
            ,      @cuenta                      CHAR(12)

            )


AS 
BEGIN
	SET DATEFORMAT DMY
	SET NOCOUNT ON





      INSERT INTO PERFIL_VARIABLE
             SELECT             
                   @id_sistema
            ,      @codigo_producto
            ,      @codigo_evento
            ,      @codigo_moneda1
            ,      @codigo_moneda2
            ,      @codigo_instrumento
            ,      @folio_perfil
            ,      @correlativo_perfil
            ,      @codigo_campo
            ,      @codigo_condicion
            ,      @cuenta

--      FROM PERFIL_PASO

            IF @@ERROR <> 0 BEGIN

               RETURN 1         

            END
      


   SET NOCOUNT OFF

END      






GO
