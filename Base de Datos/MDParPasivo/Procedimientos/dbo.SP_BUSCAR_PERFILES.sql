USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCAR_PERFILES]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- DBO.SP_BUSCAR_PERFILES 'PSV' , 'JLCI' , 141

CREATE PROCEDURE [dbo].[SP_BUSCAR_PERFILES](
	@Idsistema   CHAR(3),
	@Usuario     CHAR(20),	 
	@Numero      NUMERIC(5)
	)

AS 
BEGIN
 	SET DATEFORMAT DMY
	SET NOCOUNT ON
	


	SELECT	 @Idsistema = id_sistema
        FROM PERFIL_CNT 
        WHERE folio_perfil = @Numero 


	SELECT	 id_sistema,
		 tipo_movimiento,
		 tipo_operacion,
		 folio_perfil,
		 codigo_instrumento,
		 moneda_instrumento,
		 tipo_voucher,
		 glosa_perfil
        FROM PERFIL_CNT 
        WHERE folio_perfil = @Numero 
            
	DELETE  paso_cnt 
	Where ID_Sistema  = @Idsistema AND
		 Usuario  = @Usuario
            
	INSERT INTO paso_cnt
		 SELECT 
		       @Idsistema,
		       @Usuario,
		       ISNULL(correlativo_perfil,0) ,
                       ISNULL(valor_dato_campo,'')   ,
                       ISNULL(codigo_cuenta,'')      ,
                       ISNULL((SELECT Descripcion 
                                 FROM PLAN_DE_CUENTA
	                        --WHERE LTRIM(RTRIM(Cuenta)) = LTRIM(RTRIM(codigo_cuenta))),''), /*SE CORRIGE PARA RESOLVER COMPATIBILIDAD SQL_Latin1_General_CP1_CI_AS*/
				WHERE convert(numeric(10),Cuenta) = convert(numeric(10),codigo_cuenta)),''),
 		       ISNULL(folio_perfil,0)
                  FROM PERFIL_VARIABLE_CNT
                 WHERE folio_perfil = @Numero  

   SET NOCOUNT OFF	                                   
END 



GO
