USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MDVMLeerValMon]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_MDVMLeerValMon    fecha de la secuencia de comandos: 03/04/2001 15:18:09 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_MDVMLeerValMon    fecha de la secuencia de comandos: 14/02/2001 09:58:30 ******/
CREATE PROCEDURE [dbo].[Sp_MDVMLeerValMon]
       (
        @ncodigo     NUMERIC(03,0)   , 
        @nmes        INTEGER         ,
        @nano        INTEGER      
       )
AS   
BEGIN
SET NOCOUNT ON    
   /*=======================================================================*/
   IF @nmes = 0 BEGIN
      SELECT           vmcodigo         ,
                       vmvalor       ,
         vmptacmp  ,
   vmptavta  ,
   /*vmliborsemanal ,
   vmlibormes1    ,
   vmlibormes2    ,
   vmlibormes3    ,
   vmlibormes4    ,
   vmlibormes5    ,
   vmlibormes6    ,
   vmlibormes7     ,
   vmlibormes8    ,
   vmlibormes9    ,
   vmlibormes10   ,
   vmlibormes11   , 
   vmlibormes12 ,*/
   vmtipo,
   vmparidad,
   vmparmer,
   vmposini,
   vmprecoi,
   vmparini,
   vmprecoc,
   vmparidc,
   vmposic,
   vmpreco,
   vmpreve,
   vmpmeco,
   vmpmeve,
   vmtotco,
   vmtotve,
   vmutili,
   vmparco,
   vmparve,
   vmorden,
   vmctacmb,
   vmcmbini,
   vmreval,
   vmarbit,
   vmparmer1,
   vmnumstgo,
                      CONVERT( CHAR(10), vmfecha, 103 ) 
             FROM     VALOR_MONEDA
             WHERE    vmcodigo                   = @ncodigo   AND
                      DATEPART( YEAR, vmfecha )  = @nano 
             ORDER BY vmcodigo, vmfecha
   /*=======================================================================*/
    END IF @nmes > 0 BEGIN
      SELECT            vmcodigo,
                        vmvalor,
                        vmptacmp,
                        vmptavta,
                        CONVERT( CHAR(10), vmfecha, 103 )
   /*vmLiborSemanal ,
   vmLiborMes1    ,
   vmLiborMes2    ,
   vmLiborMes3    ,
   vmLiborMes4    ,
   vmLiborMes5    ,
   vmLiborMes6    ,
   vmLiborMes7     ,
   vmLiborMes8    ,
   vmLiborMes9    ,
   vmLiborMes10   ,
   vmLiborMes11   , 
   vmLiborMes12,*/
   vmtipo,
   vmparidad,
   vmparmer,
   vmposini,
   vmprecoi,
   vmparini,
   vmprecoc,
   vmparidc,
   vmposic,
   vmpreco,
   vmpreve,
   vmpmeco,
   vmpmeve,
   vmtotco,
   vmtotve,
   vmutili,
   vmparco,
   vmparve,
   vmorden,
   vmctacmb,
   vmcmbini,
   vmreval,
   vmarbit,
   vmparmer1,
   vmnumstgo
             FROM     VALOR_MONEDA
             WHERE    vmcodigo                   = @ncodigo AND
                      DATEPART( MONTH, vmfecha ) = @nmes    AND
                      DATEPART( YEAR,  vmfecha ) = @nano
             ORDER BY vmcodigo, vmfecha
   END
  /*=======================================================================*/
   SET NOCOUNT OFF
END






GO
