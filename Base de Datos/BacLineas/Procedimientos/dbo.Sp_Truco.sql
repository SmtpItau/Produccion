USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Truco]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO









/****** Objeto:  procedimiento  almacenado dbo.Sp_Truco    fecha de la secuencia de comandos: 03/04/2001 15:18:13 ******/
CREATE PROC [dbo].[Sp_Truco](@cuenta            char(11)        ,
 		     @descripcion       char(70)        ,
		     @glosa		char(30)	,
                     @tipcuenta		char(3)		,
		     @cta_imp		char(1)		,
		     @con_correc	char(1)		,
		     @con_cto_costo	char(3)		,
		     @tipo_mon          char(1)	,
                     @prod_asoc		numeric( 5)     ,
                     @cta_sbif          char(40)	,
                     @tipo_saldo	numeric( 3)	,
		     @tipo_relacion	numeric (3)	)
AS 
BEGIN
set nocount on
     ----<< Agrega
     IF NOT EXISTS(SELECT * FROM PLAN_DE_CUENTA WHERE Cuenta = @cuenta)

          INSERT INTO Plan_de_Cuenta 
--               VALUES(@cuenta, @DESCRIPCION , @glosa, @tipo_mon,@prod_asoc,@cta_sbif,@tipo_saldo,@tipo_relacion,"")
		values(	@cuenta ,
			@descripcion,
			@glosa,
			@tipcuenta,
			@cta_imp,
			@con_correc,
			@con_cto_costo,	
			@tipo_mon     ,  
                        @prod_asoc,	
                        @cta_sbif , 
                        @tipo_saldo,
			@tipo_relacion	)
          IF @@error <> 0 
          BEGIN
               SELECT -1,"No se pudo Agregar al Plan de Cuentas"
               RETURN
          END

    else

begin 
     ----<< Actualiza
     UPDATE PLAN_DE_CUENTA SET 
			     cuenta 		= @cuenta	,
 			     descripcion 	= @descripcion	,
			     glosa	 	= @glosa	,
			     tipo_cuenta   	= @tipcuenta 	,
			     cuenta_imputable 	= @cta_imp,
			     con_correccion 	= @con_correc,
			     con_centro_costo 	= @con_cto_costo,	
			     tipo_moneda 	= @tipo_mon,
                             prod_asoc   	= @prod_asoc	,
                             cta_sbif   	= @cta_sbif  ,
                             tipo_saldo	 	= @tipo_saldo,
			     tipo_relacion 	= @tipo_relacion
			
                           WHERE cuenta = @cuenta
     IF @@error <> 0 
     BEGIN
          SELECT -1,"No se pudo Actualizar Cuenta"
          RETURN
     END
end
set nocount off  
END 









GO
