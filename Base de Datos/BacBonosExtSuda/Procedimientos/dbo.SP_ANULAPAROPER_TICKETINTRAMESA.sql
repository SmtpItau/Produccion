USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ANULAPAROPER_TICKETINTRAMESA]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ANULAPAROPER_TICKETINTRAMESA] 
(
	@nnumoper NUMERIC(10,0) 
)
AS
BEGIN
	SET NOCOUNT ON	
        DECLARE @fecpro         DATETIME       
        DECLARE @bIsMirror      VARCHAR(01)      
        DECLARE @sTipoper    VARCHAR(03)        
        SET  @sTipoper   =  (SELECT TOP 1 motipoper FROM dbo.MOV_ticketbonext WHERE monumoper = @nnumoper) 
        SET @fecpro        = (SELECT acfecproc FROM text_arc_ctl_dri)        

        IF NOT EXISTS(SELECT 1 
                        FROM dbo.MOV_ticketbonext 
                       WHERE monumoper=@nnumoper)    
	BEGIN
            SELECT -1, 'Operacion NO existe, verifique!!!'
            RETURN 
        END

        IF EXISTS(SELECT 1 
                        FROM dbo.MOV_ticketbonext 
                       WHERE monumoper=@nnumoper
                         AND mostatreg = 'A')    
	BEGIN
            SELECT -1, 'Operacion ya esta anulada, verifique!!!'
            RETURN 
        END

--JBH, validacion op. especjo bloqueada por mi, 17-12-2009
/*
        IF (SELECT TOP 1 operacion_relacionada  
                        FROM dbo.MOV_ticketbonext 
                       WHERE monumoper=@nnumoper)<>0    
	BEGIN
            SELECT -2, 'Operacion espejo no se puede anular, verifique!!!'
            RETURN 
        END
*/

        SET @bIsMirror   = (SELECT TOP 1 CASE  WHEN operacion_relacionada = 0 THEN  'N' ELSE 'S' END 
                              FROM dbo.MOV_ticketbonext 
                             WHERE monumoper=@nnumoper)           

        
    --> Validacion para las compras
        IF @sTipoper = 'CP'
        BEGIN 
            IF @bismirror ='N' 
            BEGIN
                IF EXISTS(SELECT 1 
                               FROM dbo.MOV_ticketbonext  
                               WHERE motipoper = 'VP'
                                 AND operacion_relacionada = 0  
                                 AND mofecpro = @fecpro 
                                 AND monumdocu = @nnumoper) 
		BEGIN
                        SELECT -3, 'Operacion NO se puede anular ya que tiene ventas asociadas, verifique!!!'                
                        RETURN 
                END
            END            
        
            UPDATE MOV_ticketbonext 
               SET mostatreg ='A'
             WHERE monumoper = @nnumoper
               AND motipoper ='CP'

            DELETE CAR_ticketbonext
             WHERE cpnumdocu  = @nnumoper

            UPDATE MOV_ticketbonext 
               SET mostatreg ='A'
             WHERE operacion_relacionada = @nnumoper
               AND motipoper ='VP'
        END

    --> Tratamiento para las ventas definitivas
        IF @stipoper= 'VP'
        BEGIN
              SELECT *
                INTO #testVenta     
                FROM MOV_ticketbonext  c
               WHERE c.monumoper = @nnumoper

         -->Devuelvo monto a cartera
            
     		UPDATE CAR_ticketbonext
	   		SET cpnominal  = cpnominal   + vta.monominal,
	   	    	cpvalcomp  = cpvalcomp   + vta.movalcomp  ,
	       		cpvalcomu  = cpvalcomu   + vta.movalcomu  ,
	       		cpvptirc   = cpvptirc    + vta.movpresen ,
	       		cpcapital = cpcapital  + isnull(vta.movalcomp, 0) ,
	       		cpinteres = cpinteres  + isnull(vta.mointeres, 0) ,
	       		cpreajust = cpreajust  + isnull(vta.moreajuste, 0)  ,
			cpvalvenc  = cpvalvenc   + isnull(vta.movalvenc, 0) ,
	       		cpprincipal = (cpnominal   + vta.monominal) * (cppvpcomp/100)
            		FROM CAR_ticketbonext, #testVenta vta   	 
	   		WHERE CAR_ticketbonext.cpnumdocu = vta.monumoper
	   		AND CAR_ticketbonext.cpcorrelativo = vta.mocorrelativo


         -->Marco Operacion Real
            UPDATE MOV_ticketbonext
               SET mostatreg ='A'
             WHERE monumoper = @nnumoper

         -->Marco Operacion Espejo 
            UPDATE MOV_ticketbonext 
               SET mostatreg ='A'
             WHERE operacion_relacionada = @nnumoper
        END 
	SET NOCOUNT OFF
	SELECT 0, 'OK'
END

GO
