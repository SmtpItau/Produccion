USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MDVMGrabar]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_MDVMGrabar    fecha de la secuencia de comandos: 03/04/2001 15:18:09 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_MDVMGrabar    fecha de la secuencia de comandos: 14/02/2001 09:58:30 ******/
CREATE PROCEDURE [dbo].[Sp_MDVMGrabar]
       (
        @ncodigo    NUMERIC(03,0)    ,
        @nvalor     NUMERIC(18,10)   , 
        @nptacmp    NUMERIC(18,10)   , 
        @nptavta    NUMERIC(18,10)   , 
        @dfecha     DATETIME
       ) 
AS   
BEGIN 
SET NOCOUNT ON
   /*=======================================================================*/
   /*=======================================================================*/
   IF EXISTS(
              SELECT       vmcodigo
                     FROM  VIEW_VALOR_MONEDA
                     WHERE vmcodigo = @ncodigo AND 
                           vmfecha  = @dfecha
            ) BEGIN
      /*====================================================================*/
      /*====================================================================*/
      UPDATE       VALOR_MONEDA 
             SET   vmvalor  = @nvalor  ,
                   vmptacmp = @nptacmp ,
                   vmptavta = @nptavta
             WHERE vmcodigo =  @ncodigo AND
                   vmfecha  =  @dfecha
  
   END ELSE BEGIN
 PRINT "a"
      INSERT INTO VALOR_MONEDA ( vmcodigo, vmvalor, vmptacmp, vmptavta, vmfecha )
                            VALUES    ( @ncodigo, @nvalor, @nptacmp, @nptavta, @dfecha )       
      PRINT "B"
   END 
    
   SET NOCOUNT OFF
   SELECT  0
END






GO
