USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ANULAOPERACION_TICKETINTRAMESA]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE 
[dbo].[SP_ANULAOPERACION_TICKETINTRAMESA] ( @nnumoper NUMERIC(10,0) )
AS
BEGIN
	SET NOCOUNT ON	;

        DECLARE @fecpro         DATETIME       ;
                
        DECLARE @bIsMirror      VARCHAR(01)    ;  

        DECLARE @sTipoper    VARCHAR(03)        ;

    
        SET  @sTipoper   =  (SELECT TOP 1 tipo_operacion FROM dbo.tbl_movticketrtafija WHERE numero_operacion=@nnumoper) ;

        SET @fecpro        = (SELECT acfecproc FROM mdac)        ;



        IF NOT EXISTS(SELECT 1 
                        FROM dbo.tbl_movticketrtafija 
                       WHERE numero_operacion=@nnumoper)    BEGIN
            SELECT -1, 'Operacion NO existe, verifique!!!'
            RETURN 
        END

        IF EXISTS(SELECT 1 
                        FROM dbo.tbl_movticketrtafija 
                       WHERE numero_operacion=@nnumoper
                         AND estado = 'A')    BEGIN
            SELECT -1, 'Operacion ya esta anulada, verifique!!!'
            RETURN 
        END

        IF (SELECT TOP 1 numero_documento_relacion  
                        FROM dbo.tbl_movticketrtafija 
                       WHERE numero_operacion=@nnumoper)<>0    BEGIN
            SELECT -2, 'Operacion espejo no se puede anular, verifique!!!'
            RETURN 
        END


        SET @bIsMirror   = (SELECT TOP 1 CASE  WHEN numero_documento_relacion= 0 THEN  'N' ELSE 'S' END 
                              FROM dbo.tbl_movticketrtafija 
                             WHERE numero_operacion=@nnumoper)            ;

        
    --> Validacion para las compras
        IF @sTipoper = 'CP'
        BEGIN 
            IF @bismirror ='N' 
            BEGIN
                IF EXISTS(SELECT 1 
                                FROM dbo.tbl_movticketrtafija  
                               WHERE tipo_operacion = 'VP'
                                 AND numero_documento_relacion=0  
                                 AND fecha_operacion  = @fecpro 
                                 AND numero_documento = @nnumoper) BEGIN
                        SELECT -3, 'Operacion NO se puede anular ya que tiene ventas asociadas, verifique!!!'                
                        RETURN 
                END
            END            
        
            UPDATE tbl_movticketrtafija 
               SET Estado ='A'
             WHERE Numero_Operacion = @nnumoper
               AND tipo_operacion ='CP'

            DELETE tbl_carticketrtafija
             WHERE Numero_documento  = @nnumoper
               AND tipo_operacion ='CP'

            UPDATE tbl_movticketrtafija 
               SET Estado ='A'
             WHERE Numero_documento_relacion = @nnumoper
               AND tipo_operacion ='VP'
        END


    --> Tratamiento para las ventas definitivas
        IF @stipoper= 'VP'
        BEGIN

              SELECT *
                INTO #testVenta     
                FROM tbl_movticketrtafija  c
               WHERE c.Numero_operacion = @nnumoper

         -->Devuelvo monto a cartera
            UPDATE tbl_carticketrtafija
               SET
                    tbl_carticketrtafija.Valor_Compra       = tbl_carticketrtafija.Valor_Compra       + vta.Valor_Compra
            ,       tbl_carticketrtafija.valor_nominal      = tbl_carticketrtafija.valor_nominal      + vta.valor_nominal
    	    ,       tbl_carticketrtafija.Valor_Presente     = tbl_carticketrtafija.Valor_Presente     + vta.Valor_Presente
            ,       tbl_carticketrtafija.Valor_Compra_UM    = tbl_carticketrtafija.Valor_Compra_UM    + vta.Valor_Compra_UM
            ,       tbl_carticketrtafija.Valor_PrimaDescto  = tbl_carticketrtafija.Valor_PrimaDescto  + vta.Valor_PrimaDescto
            ,       tbl_carticketrtafija.Valor_Tasa_Emision = tbl_carticketrtafija.Valor_Tasa_Emision + vta.Valor_Tasa_Emision
              FROM tbl_carticketrtafija, #testVenta vta
             WHERE tbl_carticketrtafija.numero_documento = vta.numero_documento
               AND tbl_carticketrtafija.correlativo          = vta.correlativo
               AND tbl_carticketrtafija.tipo_operacion   ='CP'


         -->Marco Operacion Real
            UPDATE tbl_movticketrtafija 
               SET Estado ='A'
             WHERE Numero_operacion = @nnumoper

         -->Marco Operacion Espejo 
            UPDATE tbl_movticketrtafija 
               SET Estado ='A'
             WHERE Numero_Documento_Relacion = @nnumoper

        END                

        IF @stipoper= 'VI'
        BEGIN

         --> Anulo operación original
            UPDATE tbl_movticketrtafija 
               SET Estado ='A'
             WHERE Numero_Operacion = @nnumoper
               AND tipo_operacion ='VI'
    
            DELETE tbl_carticketrtafija
             WHERE Numero_documento  = @nnumoper
               AND tipo_operacion ='VI'

         --> Anulo operación espejo
            UPDATE tbl_movticketrtafija 
               SET Estado ='A'
             WHERE Numero_Documento_Relacion = @nnumoper
               AND tipo_operacion ='CI'

            DELETE tbl_carticketrtafija
             WHERE Numero_Documento_Relacion = @nnumoper
               AND tipo_operacion ='CI'
        END


        IF @stipoper= 'CI'
        BEGIN

         --> Anulo operación original
            UPDATE tbl_movticketrtafija 
               SET Estado ='A'
             WHERE Numero_Operacion = @nnumoper
               AND tipo_operacion ='CI'
    
            DELETE tbl_carticketrtafija
             WHERE Numero_documento  = @nnumoper
               AND tipo_operacion ='CI'

         --> Anulo operación espejo
            UPDATE tbl_movticketrtafija 
               SET Estado ='A'
             WHERE Numero_Documento_Relacion = @nnumoper
               AND tipo_operacion ='VI'

            DELETE tbl_carticketrtafija
             WHERE Numero_Documento_Relacion = @nnumoper
               AND tipo_operacion ='VI'
        END



	SET NOCOUNT OFF
	SELECT 0, 'OK'

END

GO
