USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Buscar_Perfiles_Copiar]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[Sp_Buscar_Perfiles_Copiar]
      (      @numero                NUMERIC(5)
      ,      @id_sistema            CHAR(3)
      ,      @codigo_producto       CHAR(5)
      ,      @codigo_evento         CHAR(5)   
      ,      @codigo_moneda1        NUMERIC(5)
      ,      @codigo_moneda2        NUMERIC(5)
      ,      @codigo_instrumento    CHAR(12) = '' 
      )

AS 
BEGIN
	SET DATEFORMAT DMY
	SET NOCOUNT ON


        IF EXISTS ( SELECT 1 FROM PERFIL WHERE --folio_perfil = @numero 
                        id_sistema            = @id_sistema            
            AND         codigo_producto       = @codigo_producto       
            AND         codigo_evento         = @codigo_evento         
            AND         codigo_moneda1        = @codigo_moneda1        
            AND         codigo_moneda2        = @codigo_moneda2        
            AND         (codigo_instrumento   = @codigo_instrumento OR @codigo_instrumento = ' ')
         )
        BEGIN
  
	      SELECT 	
                         id_sistema
                  ,      codigo_producto
                  ,      codigo_evento
                  ,      codigo_moneda1
                  ,      codigo_moneda2
                  ,      codigo_instrumento
                  ,      tipo_voucher
                  ,      glosa_perfil
                  ,      'folio' = ( SELECT DISTINCT folio_perfil FROM PERFIL_DETALLE WHERE --folio_perfil = @numero 
                                                                                    id_sistema            = @id_sistema            
                                                                        AND         codigo_producto       = @codigo_producto       
                                                                        AND         codigo_evento         = @codigo_evento         
                                                                        AND         codigo_moneda1        = @codigo_moneda1        
                                                                        AND         codigo_moneda2        = @codigo_moneda2        
                                                                        AND         (codigo_instrumento   = @codigo_instrumento OR @codigo_instrumento = ' ')
                                                                                          )
 	      FROM PERFIL WHERE 
                              id_sistema            = @id_sistema            
                  AND         codigo_producto       = @codigo_producto       
                  AND         codigo_evento         = @codigo_evento         
                  AND         codigo_moneda1        = @codigo_moneda1        
                  AND         codigo_moneda2        = @codigo_moneda2        
                  AND         (codigo_instrumento   = @codigo_instrumento OR @codigo_instrumento = ' ')


/*
             INSERT INTO PASO_CNT

             SELECT     
                  P.correlativo_perfil,
                  P.folio_perfil,
                  P.codigo_condicion,
                  P.cuenta,
                  'descripcion'      = ( SELECT descripcion FROM PLAN_DE_CUENTA WHERE cuenta = P.cuenta ) ,
                  P.codigo_campo


             FROM PERFIL_VARIABLE_CNT P

             WHERE
                              id_sistema            = @id_sistema            
                  AND         codigo_producto       = @codigo_producto       
                  AND         codigo_evento         = @codigo_evento         
                  AND         codigo_moneda1        = @codigo_moneda1        
                  AND         codigo_moneda2        = @codigo_moneda2        
                  AND         (codigo_instrumento   = @codigo_instrumento OR @codigo_instrumento = ' ')

*/
         END
         ELSE BEGIN
      
            IF ( SELECT COUNT(*)  FROM PERFIL ) = 0 BEGIN

                 SELECT       

                        'Retorna'      = 'NO HAY' 
                       ,'folio'        = (SELECT COUNT(*)+1  FROM PERFIL ) 

            END
            ELSE BEGIN

                 SELECT       

                        'Retorna'      = 'NO HAY' 
                       ,'folio'        = (SELECT MAX(folio_perfil)+1 FROM PERFIL_DETALLE )

            END

        END


SET NOCOUNT OFF
END






GO
