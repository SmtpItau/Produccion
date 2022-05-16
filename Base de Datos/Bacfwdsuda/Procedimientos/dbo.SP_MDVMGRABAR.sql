USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MDVMGRABAR]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MDVMGRABAR]
       (
        @ncodigo    NUMERIC(03,0)    ,
        @nvalor     NUMERIC(18,10)   , 
        @nptacmp    NUMERIC(18,10)   , 
        @nptavta    NUMERIC(18,10)   , 
        @dfecha     DATETIME
       ) 
AS   
BEGIN 

	SET NOCOUNT OFF
	SELECT  0
RETURN 

/*
   SET NOCOUNT ON
   /*=======================================================================*/
   IF EXISTS(
              SELECT       vmcodigo
                     FROM  VIEW_VALOR_MONEDA
                     WHERE vmcodigo = @ncodigo AND 
                           vmfecha  = @dfecha
            ) BEGIN
      /*====================================================================*/
      UPDATE       VIEW_VALOR_MONEDA
             SET   vmvalor  = @nvalor  ,
                   vmptacmp = @nptacmp ,
                   vmptavta = @nptavta
             WHERE vmcodigo =  @ncodigo AND
                   vmfecha  =  @dfecha
  
   END ELSE BEGIN
      INSERT INTO VIEW_VALOR_MONEDA
  (  vmcodigo, 
   vmvalor, 
   vmptacmp, 
   vmptavta, 
   vmfecha,
   Vmtipo ,
   Vmparidad ,
   Vmparmer ,
   Vmposini ,
   Vmprecoi ,
   Vmparini ,
   Vmprecoc ,
   Vmparidc ,
   Vmposic ,
   Vmpreco ,
   Vmpreve ,
   Vmpmeco ,
   Vmpmeve ,
   Vmtotco ,
   Vmtotve ,
   Vmutili ,
   Vmparco ,
   Vmparve ,
   Vmorden ,
   Vmctacmb ,
   Vmcmbini ,
   Vmreval ,
   Vmarbit ,
   Vmparmer1 ,
   Vmnumstgo
  )
 VALUES ( 
   @ncodigo, 
   @nvalor, 
   @nptacmp, 
   @nptavta, 
   @dfecha,
   '' ,
   0 ,
   0 ,
   0 ,
   0 ,
   0 ,
   0 ,
   0 ,
   0 ,
   0 ,
   0 ,
   0 ,
   0 ,
   0 ,
   0 ,
   0 ,
   0 ,
   0 ,
   0 ,
   0 ,
   0 ,
   '' ,
   '' ,
   0 ,
   0
  )       
   END 
    
   SET NOCOUNT OFF
   SELECT  0
	*/
	
END


GO
